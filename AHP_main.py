import AHP_lib as mdl
import sys

student_id = sys.argv[1]

alib = mdl.AHP_lib(student_id)
result = alib.getResult()
print(result)