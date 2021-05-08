import numpy as np
import mysql.connector

class AHP_lib:
    def __init__(self, student_id):
        #データベースへの接続
        dbh = mysql.connector.connect(
        host='localhost',
        port='3306',
        db='naisyo',
        user='naisyo',
        password='Oshienaiyo',
        charset='utf8'
        )
        self.cur = dbh.cursor()
        
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
        self.cur.execute("SELECT * FROM `ahp_students` WHERE `id` = " + str(self.student_id) +";")
        evaluation = self.cur.fetchall()
        evaluation_weight = evaluation[0][2:14] #今回の評価項目数は12
        return evaluation_weight
        
        
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
    
    