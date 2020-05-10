# onechampion
One Champion Questions
1. SQL: 

One Championship conducts events in a stadium, each event many people visit it and the stats are saved as these columns: id, event_name, people_count

Take leverage in adding sample data yourself.
Please write a query to display the records which have 3 or more consecutive events and the amount of people more than 100(inclusive).

Answer- Please execute popular_events.sql in mysql or any other sql editor.





2. Data Parsing: 

Write code to extract data from **data.csv**.

The data contains four columns. The first column is the person identifier. The second column is the datetime the person entered the floor. The third column is the floor the person accessed. The fourth column specifies the building the floor is in.
Each row is considered a floor access event. Your task it to output each floor access event in json format. Each event should comply with the schema located in **schema.json**.

Answer- Please execute file csv_to_json with below format-

python csv_to_json.py <source_file_name_with_path> <target_file_name_with_path>
eg- python csv_to_json.py /home/ubuntu/data.csv /home/ubuntu/data.json

