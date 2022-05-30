SET SQL_SAFE_UPDATES = 0;

create database `assignment`;
-- ------------------------------------------------------------------
-- Import the Date and Close price column from the tables and modify the date format
-- ------------------------------------------------------------------
select * from `bajaj auto`;
-- UPDATE THE TABLE TO CHANGE THE FORMAT OF THE DATE FIELD
UPDATE `bajaj auto`  
SET Date = str_to_date(Date,'%d-%M-%Y');
-- ALTER THE TABLE TO MODIFY THE DATE DATATYPE
alter table `bajaj auto`  
modify date DATE;

select * from `eicher motors`;
UPDATE `eicher motors`  
SET Date = str_to_date(Date,'%d-%M-%Y');
alter table `eicher motors`  
modify date DATE;

select * from `hero motocorp`;

UPDATE `hero motocorp`  
SET Date = str_to_date(Date,'%d-%M-%Y');    
alter table `hero motocorp`  
modify date DATE;                   

select * from `infosys`;
UPDATE `infosys`  
SET Date = str_to_date(Date,'%d-%M-%Y');
alter table `infosys`  
modify date DATE;

select * from `tcs`;
UPDATE `tcs`  
SET Date = str_to_date(Date,'%d-%M-%Y');
alter table `tcs`  
modify date DATE;

select * from `tvs motors`;
UPDATE `tvs motors`  
SET Date = str_to_date(Date,'%d-%M-%Y');
alter table `tvs motors`  
modify date DATE;

-- --------------------------------------------------------------------------------
# 1. create 6 tables each with 4  column  Date   Close Price 20 Day MA   50 Day MA and 
-- popluate the column with required data from base tables , calculate teh 20 day and 50 day moving average  
-- --------------------------------------------------------------------------------
create table bajaj1 (
 Date DATE not null,
 `Close Price`  DOUBLE not null,
 `20 Day MA` DOUBLE default null,
 `50 Day MA` DOUBLE default null,
 primary key (Date),
 unique (Date)
 );

-- popiulate the table and cacluate 20 day moving average and 50 day moving average and fill the first 19 and 49 entries as null for 20 and 50 day moving average 
insert into 
bajaj1 (Date, `Close Price`,`20 Day MA`,`50 Day MA`)
select 
 date, 
 `Close Price`, 
 if(row_number() over w >= 20,
   AVG(`Close Price`) OVER (w ROWS BETWEEN 19 PRECEDING AND CURRENT ROW), null) AS '20_Day_MA',
 if(row_number() over w >= 50,  
   AVG(`Close Price`) OVER (w ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50_Day_MA'
from `bajaj auto`
window w as (order by date ASC);

select * from bajaj1 ORDER BY date ASC;


create table eicher1 (
 Date DATE not null,
 `Close Price`  DOUBLE not null,
 `20 Day MA` DOUBLE default null,
 `50 Day MA` DOUBLE default null,
 primary key(Date),
 unique (Date)
 );
 
insert into 
eicher1 (Date, `Close Price`,`20 Day MA`,`50 Day MA`)
select 
 date, 
 `Close Price`, 
 if(row_number() over w >= 20,
   AVG(`Close Price`) OVER (w ROWS BETWEEN 19 PRECEDING AND CURRENT ROW), null) AS '20_Day_MA',
 if(row_number() over w >= 50,  
   AVG(`Close Price`) OVER (w ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50_Day_MA'
from `eicher motors`
window w as (order by date ASC);

select * from eicher1 ORDER BY date ASC;

create table hero1 (
 Date DATE not null,
 `Close Price`  DOUBLE not null,
 `20 Day MA` DOUBLE default null,
 `50 Day MA` DOUBLE default null,
 primary key(Date),
 unique (Date)
 );
 
insert into 
hero1 (Date, `Close Price`,`20 Day MA`,`50 Day MA`)
select 
 date, 
 `Close Price`, 
 if(row_number() over w >= 20,
   AVG(`Close Price`) OVER (w ROWS BETWEEN 19 PRECEDING AND CURRENT ROW), null) AS '20_Day_MA',
 if(row_number() over w >= 50,  
   AVG(`Close Price`) OVER (w ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50_Day_MA'
from `hero motocorp`
window w as (order by date ASC);
select * from hero1 ORDER BY date ASC;

create table infosys1 (
 Date DATE not null,
 `Close Price`  DOUBLE not null,
 `20 Day MA` DOUBLE default null,
 `50 Day MA` DOUBLE default null,
 primary key (Date),
 unique (Date)
 );
 
insert into 
infosys1 (Date, `Close Price`,`20 Day MA`,`50 Day MA`)
select 
 date, 
 `Close Price`, 
 if(row_number() over w >= 20,
   AVG(`Close Price`) OVER (w ROWS BETWEEN 19 PRECEDING AND CURRENT ROW), null) AS '20_Day_MA',
 if(row_number() over w >= 50,  
   AVG(`Close Price`) OVER (w ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50_Day_MA'
from infosys
window w as (order by date ASC); 

select * from infosys1 ORDER BY date ASC;

create table tcs1 (
 Date DATE not null,
 `Close Price`  DOUBLE not null,
 `20 Day MA`  DOUBLE default null,
 `50 Day MA` DOUBLE default null,
 primary key (Date),
 unique (Date)
 );
 
insert into 
tcs1 (Date, `Close Price`,`20 Day MA`,`50 Day MA`)
select 
 date, 
 `Close Price`, 
 if(row_number() over w >= 20,
   AVG(`Close Price`) OVER (w ROWS BETWEEN 19 PRECEDING AND CURRENT ROW), null) AS '20_Day_MA',
 if(row_number() over w >= 50,  
   AVG(`Close Price`) OVER (w ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50_Day_MA'
from tcs
window w as (order by date ASC);

select * from tcs1 ORDER BY date ASC;

create table tvs1(
 Date DATE not null,
 `Close Price`  DOUBLE not null,
 `20 Day MA` DOUBLE default null,
 `50 Day MA` DOUBLE default null,
 primary key (Date),
 unique (Date)
 );
 
insert into 
tvs1 (Date, `Close Price`,`20 Day MA`,`50 Day MA`)
select 
 date, 
 `Close Price`, 
 if(row_number() over w >= 20,
   AVG(`Close Price`) OVER (w ROWS BETWEEN 19 PRECEDING AND CURRENT ROW), null) AS '20_Day_MA',
 if(row_number() over w >= 50,  
   AVG(`Close Price`) OVER (w ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50_Day_MA'
from `tvs motors`
window w as (order by date ASC);  

select * from tvs1 ORDER BY date ASC;


-- --------------------------------------------------------------------------------
# 2. Create a master table containing the date and close price of all the six stocks. 
--   (Column header for the price is the name of the stock)  
-- --------------------------------------------------------------------------------
create table MasterTable(
 Date DATE not null, 
 Bajaj  DOUBLE not null,
 TCS  DOUBLE not null,
 TVS  DOUBLE not null,
 Infosys  DOUBLE not null,
 Eicher  DOUBLE not null,
 Hero  DOUBLE not null,
 primary key (Date),
 unique (Date)
 );
insert into 
MasterTable (Date, Bajaj,TCS,TVS,Infosys,Eicher,Hero)
select a.Date, a.`Close Price`, b.`Close Price`, c.`Close Price`, d.`Close Price`, e.`Close Price`,f.`Close Price`
from `bajaj auto` a 
inner join `eicher motors` b on a.date = b.date
inner join `hero motocorp` c on b.date = c.date   
inner join `infosys` d on c.date = d.date
inner join `tcs`  e on d.date = e.date
inner join `tvs motors` f on e.date = f.date
ORDER BY date ASC;

select * from MasterTable;

-- ------------------------------------------------------------------
-- 3. Use the table created in Part(1) to generate buy and sell signal. 
--    Store this in another table named 'bajaj2'. 
--    Perform this operation for all stocks.
-- ------------------------------------------------------------------
create table bajaj2 as 
select tab.Date, tab.`Close Price`,
     case
        when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	    else 'Hold'
      end as 'Signal'
from bajaj1 tab      
window  w as (order by tab.Date  ASC);
select * from bajaj2;

-- let us check if there any buy and sell signal generated properly
select b1.Date, `Signal`,`20 Day MA` , `50 Day MA`, (`20 Day MA` - `50 Day MA`) as 'MA_diff'
from bajaj1 b1
inner join bajaj2 b2 on b1.date = b2.date
where `Signal` in ('Buy' , 'Sell');

-- Create rest of the tables on the same pattern
create table infosys2 as 
select tab.Date, tab.`Close Price`,
     case
        when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	    else 'Hold'
      end as 'Signal'
from infosys1 tab      
window  w as (order by tab.Date  ASC);
select * from infosys2;

create table hero2 as 
select tab.Date, tab.`Close Price`,
     case
        when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	    else 'Hold'
      end as 'Signal'
from hero1 tab      
window  w as (order by tab.Date  ASC);
select * from hero2;

create table eicher2 as 
select tab.Date, tab.`Close Price`,
     case
        when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	    else 'Hold'
      end as 'Signal'
from eicher1 tab      
window  w as (order by tab.Date  ASC);
select * from eicher2;

create table tcs2 as 
select tab.Date, tab.`Close Price`,
     case
        when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	    else 'Hold'
      end as 'Signal'
from tcs1 tab      
window  w as (order by tab.Date  ASC);
select * from tcs2;


create table tvs2 as 
select tab.Date, tab.`Close Price`,
     case
        when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	    else 'Hold'
      end as 'Signal'
from tvs1 tab      
window  w as (order by tab.Date  ASC);
select * from tvs2;

-- ------------------------------------------------------------------
-- 4. Create a User defined function, that takes the date as input and 
--    returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.
-- ------------------------------------------------------------------
drop function if exists stock_signal;
create function stock_signal(in_date DATE)
returns varchar (4) deterministic
return 
 (select `Signal` from 
   (select tab.Date, tab.`Close Price`,
      case
         when tab.`20 Day MA` > tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) < LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Buy'
		 when tab.`20 Day MA` < tab.`50 Day MA` and 
              LAG(tab.`20 Day MA`,1) OVER(w) > LAG(tab.`50 Day MA`,1) OVER(w)
				then 'Sell'
	     else 'Hold'
       end as 'Signal'
     from bajaj1 tab      
     window  w as (order by tab.Date  ASC)) as t1
 where t1.date = in_date);

-- Check if the function is working fine for buy, sell and hold
select stock_signal('2015-05-18') as 'signal';  
select stock_signal('2015-08-24') as 'signal';
select stock_signal('2015-05-13') as 'signal';

-- ------------------------------------------------------------------
-- 5. Write a brief summary of the results obtained and what inferences you can draw from the analysis performed. 
--    (Less than 250 words to be submitted in a pdf file)
-- ------------------------------------------------------------------
-- Point 1
select count(*) from bajaj2 where `Signal` in ('Buy', 'Sell' ); -- 23 , 12 Golden cross, 11 death cross 
select count(*) from eicher2 where `Signal` in ('Buy' , 'Sell'); -- 13, 7  Golden cross, 6 death cross
select count(*) from hero2 where `Signal` in ('Buy' , 'Sell');  -- 18, 9 Golden cross, 9 death cross
select count(*) from infosys2 where `Signal` in ('Buy' , 'Sell');  -- 18, 9 Golden cross, 9 death cross
select count(*) from tcs2 where `Signal` in ('Buy' , 'Sell');  -- 25, 13 Golden cross, 12 death cross
select count(*) from tvs2 where `Signal` in ('Buy' , 'Sell');  -- 16, 8 Golden cross, 8 death cross

-- From the above results we can observe that tcs and bajaj stocks has highest fluctuation then infosys, hero, tvs and eicher stock has the least fluctuation.  

-- Point 2
select * from Mastertable where year(date) = '2018' order by date asc limit 1;
select * from Mastertable where year(date) = '2018'order by date desc limit 1;
-- Date        Bajaj    tcs         tvs    Infosys.  Eicher   Hero
-- 2015-01-01   2454.1	15239.15	3107.3	1975.8	2548.2	276.85
-- 2015-12-31	2533.5	16855.2	    2695.25	1104.55	2439.2	289.65
-- 2016-01-01	2520.05	17365.25	2687.85	1103.15	2416.25	287.1
-- 2016-12-30	2633.85	21812.1	    3044.75	1010.7	2361.95	360.65
-- 2017-01-02	2596.8	22510.6	    3028.7	1001.6	2359.05	366.15
-- 2017-12-29	3323.2	30290.55	3786.3	1039.3	2700.4	771.3
-- 2018-01-01	3293.4	29901.3	    3768.8	1034.55	2654.65	766.35
-- 2018-07-31   2700.7	27820.95	3293.8	1365	1941.25	517.45

-- From the result we can observe that 
-- Price of these stocks Bajaj, TCS, TVS,Hero have increased over a period of 4 years where as  price of Eicher and Infosys has dropped
-- TCS is the most expensive stock where as Hero is the least expensive stock