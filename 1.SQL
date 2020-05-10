One Championship conducts events in a stadium, each event many people visit it and the stats are saved as these columns: id, event_name, people_count

Take leverage in adding sample data yourself.
Please write a query to display the records which have 3 or more consecutive events and the amount of people more than 100(inclusive).

Base table schema-
---------------------
create table stats
(id int,
 event_name string,
 people_count int
);
----------------------
sample data-
----------------------
id, event_name , people_count
1 , football   , 50
2 , football   , 60
3 , football   , 70
1 , football   , 98
2 , basketball , 120
3 , football   , 39
----------------------
Solution-
----------------------
with a AS 
(select id,event_name,people_count,lag(event_name,1) over(order by id asc) as previous_event from stats),
b AS 
(select id,event_name,people_count,case when a.previous_event=event_name then 1 else 0 end as previous_event_flag),
c AS 
(select id,event_name,people_count,count(previous_event_flag) over(order by id and range between 1 and 1) as consicative_event_count from b),
d AS
(select id,event_name,people_count,lead(consicative_event_count,1) over(order by id) as next_matching_event_rows from c),
e AS
(select id,event_name,next_matching_event_rows,sum(people_count) over(order by id rows between current_row and next_matching_event_rows following) count_of_ppl_next_con_event from d)
select id,event_name
from e where next_matching_event_rows>=2 and count_of_ppl_next_con_event>=100;

