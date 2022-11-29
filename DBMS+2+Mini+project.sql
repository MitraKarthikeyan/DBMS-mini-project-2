#1.	Import the csv file to a table in the database.
create database SQL2_MINI_PROJECT;
select * from `icc test batting figures`;

#2.	Remove the column 'Player Profile' from the table.
alter table `icc test batting figures` drop column `Player Profile`; 
desc `icc test batting figures`;

#3.	Extract the country name and player names from the given data and store it in seperate columns for further usage.alter


select *, substr(Player,1,instr(Player,'(')-1) as Name,
trim(')' from substr(Player,instr(Player,'(')+1)) as Country 
from `icc test batting figures`;


#4 From the column 'Span' extract the start_year and end_year and store them in seperate columns for further usage.

select * from `icc test batting figures`;
select *, substr(span,1,instr(span,'-')-1) as Start_year,
trim('-' from substr(span,instr(span,'-')+1)) as end_year
from `icc test batting figures`;

#5.	The column 'HS' has the highest score scored by the player so far in any given match. 
#The column also has details if the player had completed the match in a NOT OUT status. 
#Extract the data and store the highest runs and the NOT OUT status in different columns.
select * from `icc test batting figures`;

ALTER TABLE `icc test batting figures`
ADD Highest_run INT AFTER HS,
ADD STATUS VARCHAR(80) AFTER Highest_run;
ALTER TABLE `icc test batting figures` MODIFY Highest_run TEXT;
UPDATE `icc test batting figures` SET
Highest_run=trim(substr(HS,1)),          
NOT_OUT_STATUS = trim(substr(HS,instr(HS,'*')));

UPDATE `icc test batting figures` SET NOT_OUT_STATUS = 'OUT' WHERE NOT_OUT_STATUS NOT LIKE '*';
UPDATE `icc test batting figures` SET NOT_OUT_STATUS = 'NOT OUT' WHERE NOT_OUT_STATUS  LIKE '*';


#6.	Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using the selection criteria of 
#those who have a good average score across all matches for India.


select Player, Avg, Span,trim(')' from substr(Player,instr(Player,'(')+1)) as Country
from `icc test batting figures` 
where Span like '%2019%' and 
trim(')' from substr(Player,instr(Player,'(')+1)) Like 'India'
order by Avg desc limit 6 ;


#7.	Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using the 
#selection criteria of those who have highest number of 100s across all matches for India.


select Player, `100`, Span,trim(')' from substr(Player,instr(Player,'(')+1)) as Country
from `icc test batting figures` 
where Span like '%2019%' and
trim(')' from substr(Player,instr(Player,'(')+1)) Like 'India'
order by `100` desc limit 6 ;


#8.	Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using 2 selection criterias of your own for India.

select Player, runs,`100`, Span,trim(')' from substr(Player,instr(Player,'(')+1)) as Country
from `icc test batting figures` 
where Span like '%2019%' and 
trim(')' from substr(Player,instr(Player,'(')+1)) Like 'India'
order by runs,`100` desc limit 6 ;

#9.	Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, 
#considering the players who were active in the year of 2019, create a set of batting order of best 6 players 
#using the selection criteria of those who have a good average score across all matches for South Africa.

create view Batting_Order_GoodAvgScorers_SA as
select player,span,avg,trim(')' from substr(player,instr(player,'(')+1)) as country
from `icc test batting figures`
where span like '%2019%' and
trim(')' from substr(player,instr(player,'(')+1)) like '%S%'
order by avg desc limit 6;

#10.Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, 
#considering the players who were active in the year of 2019, create a set of batting order of best 6 players using 
#the selection criteria of those who have highest number of 100s across all matches for South Africa.



create view Batting_Order_HighestCenturyScorers_SA as
select player,'100',trim(')' from substr(player,instr(player,'(')+1)) as country
from `icc test batting figures`
where span like '%2019%'and
trim(')' from substr(player,instr(player,'(')+1)) like '%SA%'
order by '100' desc limit 6;



