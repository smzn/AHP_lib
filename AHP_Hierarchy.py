import numpy as np
import mysql.connector
import sys

class AHP_Hierarchy:
    
    def __init__(self, project_id, user_id):
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
       
        #今回の対象プロジェクト取得
        self.project_id = project_id
        #今回の対象ユーザの取得
        self.user_id = user_id
       
        # 評価項目階層構造の取得
        self.evaluation_list, self.child_setlist = self.getHierarchy()#0は親無し、1以上は親あり
        
        # 代替案の取得
        self.alternative_list = self.getAlternativeList()
        
        #最終結果
        weight = self.getAlternativeWeight(self.evaluation_list[0])
        print(weight)
        
    def getHierarchy(self): #最初に階層ごとの評価項目リストを作成, child項目だけ取り出し、階層を確認
        self.cur.execute("SELECT child FROM `engine_evaluations` WHERE `engine_project_id` = "+str(self.project_id)+" ;")
        hierarchies = self.cur.fetchall()
        child_list = []
        for i in hierarchies:
            child_list.append(i[0])
        child_setlist = list(set(child_list)) #setはlistにしないと要素が取り出せない
        
        evaluation_list = [[] for i in range(len(set(child_list)))] #空リスト作成
        for i, val_i in enumerate(child_setlist):
            self.cur.execute("SELECT `id` FROM `engine_evaluations` WHERE `engine_project_id` = "+str(self.project_id)+" and `child` = "+str(val_i)+";")
            for j in self.cur.fetchall():
                evaluation_list[i].append(j[0])
        return evaluation_list, child_setlist
    
    def getAlternativeList(self):
        alternative_list = []
        self.cur.execute("SELECT * FROM `engine_alternatives` WHERE `engine_project_id` = "+str(self.project_id)+";")
        for i in self.cur.fetchall():
            alternative_list.append(i[0])
        return alternative_list
        
    def getWeight(self, array): #固有値からウエイトを計算
        w, v = np.linalg.eig(array) #w : 固有値, v : 固有ベクトル
        weight = np.abs(v[:, np.argmax(w)])/ np.sum(np.abs(v[:, np.argmax(w)])) #最大固有値の固有ベクトルを正規化
        return weight

    #評価項目の一対比較行列を作成してウエイトを計算する
    def getEvaluationPair(self, number):#numberは利用する評価項目
        evaluation_pair = np.zeros((len(number), len(number)))
        for i, val_i in enumerate(number):
            for j, val_j in enumerate(number):
                self.cur.execute("SELECT value FROM `engine_evaluation_pairs` WHERE `engine_project_id` = "+str(self.project_id)+" and `engine_user_id` = "+str(self.user_id)+" and `from_id` = "+str(val_i)+" and `to_id` = "+str(val_j)+";")
                evaluation_pair[i, j] = self.cur.fetchone()[0]
        weight = self.getWeight(evaluation_pair)
        return weight
   
    #代替案の評価項目ごと一対比較行列を作成してウエイトを計算する
    def getAlternativePair(self, evaluation_id):#self.alternative_listを利用
        alternative_pair = np.zeros((len(self.alternative_list), len(self.alternative_list)))
        for i, val_i in enumerate(self.alternative_list):
            for j, val_j in enumerate(self.alternative_list):
                self.cur.execute("SELECT `value` FROM `engine_alternative_pairs` WHERE `engine_evaluation_id` = "+str(evaluation_id)+" and `from_id` = "+str(val_i)+" and `to_id` = "+str(val_j)+" and `engine_project_id` = "+str(self.project_id)+" and `engine_user_id` = "+str(self.user_id)+";")
                alternative_pair[i, j] = self.cur.fetchone()[0]
        weight = self.getWeight(alternative_pair)
        return weight
   
    def getResult(self, alternative_weight, evaluation_weight):
        return np.dot(alternative_weight, evaluation_weight)
    
    #この関数に最上位の評価項目evaluation(つまりevaluation_list[0])とalternative_list, child_setlistを渡すと結果が得られる
    def getAlternativeWeight(self, evaluation):
        evaluation_weight = self.getEvaluationPair(evaluation) #評価項目ウエイト
        alternative_matrix = np.zeros((len(evaluation), len(self.alternative_list)))
        for i, val_i in enumerate(evaluation):
            if val_i in self.child_setlist: #下位層がある場合
                idx = self.child_setlist.index(val_i)
                alternative_matrix[i] = self.getAlternativeWeight(self.evaluation_list[idx])
            else: #下位層がない場合
                alternative_matrix[i] = self.getAlternativePair(val_i)
        result = self.getResult(alternative_matrix.T, evaluation_weight)
        return result
    
if __name__ == '__main__':
    project_id = sys.argv[1]
    user_id = sys.argv[2]
    
    ahp = AHP_Hierarchy(project_id, user_id)
    
   # python3 AHP_Hierarchy.py 1 1 