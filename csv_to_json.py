import csv
import json
import sys
csv_file=sys.argv[1]
json_file=sys.argv[2]
from datetime import datetime
fmt1='%m-%d-%Y %H:%M'
fmt2='%m/%d/%y %H:%M'
tgt_fmt='%Y-%m-%dT%H:%M:%SZ'
fmt=''
data={}
with open(csv_file) as csvFile:
    with open(json_file,'w') as jsonFile:
        csvReader=csv.DictReader(csvFile)
        for rows in csvReader:
            #identifying date format based on delimiter
            if (rows['Floor Access DateTime'].find('-')==-1):
                fmt=fmt2
            else:
                fmt=fmt1    
            py_datetime=datetime.strptime(rows['Floor Access DateTime'],fmt)
            data['person_id']=rows['Person Id']
            data['datetime']=datetime.strftime(py_datetime,tgt_fmt)
            data['floor_level']=int(rows['Floor Level'])
            data['building']=rows['Building']
            jsonFile.write(json.dumps(data)+"\n")
