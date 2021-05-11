import numpy as np
import mysql.connector

class AHP_lib:
    def __init__(self, student_id):
        #データベースへの接続
        self.dbh = mysql.connector.connect(
        host='localhost',
        port='3306',
        db='naisyo',
        user='naisyo',
        password='Oshienaiyo',
        charset='utf8'
        )
        self.cur = self.dbh.cursor()
        
        self.cluster_number = 6 #今回は固定
        self.evaluation_number = 12
        
        #今回の対象学生の取得
        self.student_id = student_id
        
        #評価項目ウエイトの取得
        self.evaluation_weight = self.getEvaluationWeight()
        
        #クラスタの項目平均
        self.altermean = self.getClusterMean()
        
        #代替案のウエイト取得
        self.alternative_weight = self.getAlternativeWeight()
        
        #最終結果を求める
        self.result = np.dot(self.alternative_weight, self.evaluation_weight)
        
    def getResult(self):
        return self.result
        
    def getEvaluationWeight(self):#評価項目のウエイトをDBから返す
        self.cur.execute("SELECT * FROM `students` WHERE `id` = " + str(self.student_id) +";")
        evaluation = self.cur.fetchall()
        evaluation_weight = evaluation[0][2:14] #この値は正規化されていない

        #一対比較行列の作成
        matrix = np.zeros((len(evaluation_weight), len(evaluation_weight))) #0で初期化をしておく
        for j, val_j in enumerate(evaluation_weight): #1行ずつ取り出す
            for k, val_k in enumerate(evaluation_weight):
                matrix[j][k] = val_j / val_k
        weight = self.getWeight(matrix)
        return weight
        
    def getClusterMean(self):#クラスタの項目平均を求める
        altermean = [[]for i in range(self.cluster_number)] #それぞれの項目の平均を入れる(`employee`, `distance`, `branche`, `salary`, `holiday`, `student`, `listingscore`, `iscore`, `mscore`, `escore`, `cscore`, `bscore`)
        for idx in range(self.cluster_number):
            self.cur.execute("SELECT * FROM `ahp_companies` where `cluster_id` = "+ str(idx+1) +";")
            alterval = self.cur.fetchall()
            for i in range(self.evaluation_number):
                sum = 0
                for j in range(len(alterval)):
                    sum += float(alterval[j][i+2]) #id,nameを飛ばす
                altermean[idx].append(sum / len(alterval))
        return altermean
    
    def getWeight(self, array): #固有値からウエイトを計算
        w, v = np.linalg.eig(array) #w : 固有値, v : 固有ベクトル
        weight = np.abs(v[:, np.argmax(w)])/ np.sum(np.abs(v[:, np.argmax(w)])) #最大固有値の固有ベクトルを正規化
        return weight

    def getAlternativeWeight(self):
        altermean_np = np.array(self.altermean) #代替案一対比較をするために、numpyに変換して転置して行ごと取り出すようにする
        weight_matrix = np.zeros((len(altermean_np.T),len(altermean_np)))
        for i in range(len(altermean_np.T)): #評価項目数だけ繰り返す
            altermatrix = np.zeros((len(altermean_np), len(altermean_np))) #0で初期化をしておく
            for j, val_j in enumerate(altermean_np.T[i]): #1行ずつ取り出す
                for k, val_k in enumerate(altermean_np.T[i]):
                    altermatrix[j][k] = val_j / val_k
            weight = self.getWeight(altermatrix)
            for j, val_j in enumerate(weight):
                weight_matrix[i][j] = val_j
        return weight_matrix.T
    
    def updateResult(self, result):
        self.cur.execute('UPDATE `students` SET `cluster0`=%s,`cluster1`=%s,`cluster2`=%s,`cluster3`=%s,`cluster4`=%s,`cluster5`=%s WHERE `id` = %s', (result[0],result[1],result[2],result[3],result[4],result[5],self.student_id))
        self.dbh.commit()
        
    def disConnect(self):
        #削除 
        self.cur.close()
        self.dbh.close()