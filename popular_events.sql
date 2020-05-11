--One Championship conducts events in a stadium, each event many people visit it and the stats are saved as these columns: id, event_name, people_count

--Take leverage in adding sample data yourself.
--Please write a query to display the records which have 3 or more consecutive events and the amount of people more than 100(inclusive).

----------------------
--Base table schema-
---------------------
create table events
(id int,
 event_name varchar(100),
 people_count int
);
----------------------
--sample data-
----------------------
insert into events(id,event_name,people_count) values(1 , 'event_1'  , 10);
insert into events(id,event_name,people_count) values(2 , 'event_2'  , 109);
insert into events(id,event_name,people_count) values(3 , 'event_3'  , 150);
insert into events(id,event_name,people_count) values(4 , 'event_4'  , 99);
insert into events(id,event_name,people_count) values(5 , 'event_5' , 145);
insert into events(id,event_name,people_count) values(6 , 'event_6'  , 1455);
insert into events(id,event_name,people_count) values(7 , 'event_7'  , 199);
----------------------
--Solution-
----------------------

WITH a as 
(select id,event_name,people_count,case when people_count>=100 then 1 else 0 end as valid_flag from events where case when people_count>=100 then 1 else 0 end=1), 
b AS(select a.id,a.event_name,a.people_count,b.id as b_id from a left outer  join a as b on b.id = a.id+1 and a.valid_flag=1 and b.valid_flag=1 ),
c as (select * from b where b_id is null), 
d as (select id,event_name,people_count,coalesce(lag(id,1) over(order by id asc),0) as previous_step,id-coalesce(lag(id,1) over(order by id asc),0) as diff from c),
e as (select * from d where diff>=3),
f as (select e.id,a.id as a_id,a.event_name,a.people_count from e inner JOIN a on a.id>e.previous_step and a.id<=e.id),
g as (select id,count(*) from f group by id having count(*)>=3)
select a_id,event_name,people_count from f where f.id in (select id from g);
-----------------------
