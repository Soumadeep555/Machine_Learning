-- Creating the database Assignment
create database Assignment;

use Assignment;

-- Create table bajaj1 with columns Date as Primary Key, Close Price, 20 Day MA and 50 Day MA 
create table bajaj1(CONSTRAINT PK_date PRIMARY KEY (Date)) as
SELECT str_to_date(Date,"%d-%M-%Y") as `Date`, `Close Price` as `Close Price` ,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`bajaj auto`;

-- Create table eicher1 with columns Date as Primary Key, Close Price, 20 Day MA and 50 Day MA
create table eicher1(CONSTRAINT PK_date PRIMARY KEY (Date)) as
SELECT str_to_date(Date,"%d-%M-%Y") as `Date`, `Close Price` as `Close Price`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`eicher motors`;

-- Create table hero1 with columns Date as Primary Key, Close Price, 20 Day MA and 50 Day MA
create table hero1(CONSTRAINT PK_date PRIMARY KEY (Date)) as
SELECT str_to_date(Date,"%d-%M-%Y") as `Date`, `Close Price` as `Close Price`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`hero motocorp`;

-- Create table infosys1 with columns Date as Primary Key, Close Price, 20 Day MA and 50 Day MA
create table infosys1(CONSTRAINT PK_date PRIMARY KEY (Date)) as
SELECT str_to_date(Date,"%d-%M-%Y") as `Date`, `Close Price` as `Close Price`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`infosys`;

-- Create table tcs1 with columns Date as Primary Key, Close Price, 20 Day MA and 50 Day MA
create table tcs1(CONSTRAINT PK_date PRIMARY KEY (Date)) as
SELECT str_to_date(Date,"%d-%M-%Y") as `Date`, `Close Price` as `Close Price`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`tcs`;

-- Create table tvs1 with columns Date as Primary Key, Close Price, 20 Day MA and 50 Day MA
create table tvs1(CONSTRAINT PK_date PRIMARY KEY (Date)) as
SELECT str_to_date(Date,"%d-%M-%Y") as `Date`, `Close Price` as `Close Price`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`Close Price`) over (order by str_to_date(Date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`tvs motors`;

-- Create Master Table containing the Date and Close Price of all the six stocks
create table Mas_Tbl
as 
select Baj.Date as `Date`, 
Baj.`Close Price` as `Bajaj`, 
t.`Close Price` as `TCS`,
tv.`Close Price` as `TVS`,
infy.`Close Price` as `Infosys`,
eic.`Close Price` as `Eicher`,
he.`Close Price` as `Hero`
from Assignment.bajaj1 Baj 
inner join Assignment.tcs1 t 
on t.Date = Baj.Date
inner join Assignment.tvs1 tv 
on tv.Date = t.Date
inner join Assignment.infosys1 infy 
on infy.Date = tv.Date
inner join Assignment.eicher1 eic 
on eic.Date = infy.Date
inner join Assignment.hero1 he 
on he.Date = eic.Date;

-- Using the tables created in Part(1) to generate buy and sell signal and Storing them in another table for all stocks.
-- Create bajaj2 to generate the column Signal
create table bajaj2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN 
		(`20 Day MA` > `50 Day MA`) AND (LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over()) THEN 'Buy'
		WHEN 
		(`20 Day MA` < `50 Day MA`) AND (LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over()) THEN 'Sell'
		ELSE 'Hold' 
end as `Signal`
FROM Assignment.bajaj1;

-- Create eicher2 to generate the column Signal
create table eicher2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN 
		(`20 Day MA` > `50 Day MA`) AND (LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over()) THEN 'BUY'
		WHEN 
		(`20 Day MA` < `50 Day MA`) AND (LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over()) THEN 'Sell'
		ELSE 'Hold' 
end as `Signal`
FROM Assignment.eicher1;

-- Create hero2 to generate the column Signal
create table hero2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN 
		(`20 Day MA` > `50 Day MA`) AND (LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over()) THEN 'Buy'
		WHEN 
		(`20 Day MA` < `50 Day MA`) AND (LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over()) THEN 'Sell'
		ELSE 'Hold' 
end as `Signal`
FROM Assignment.hero1;

-- Create infosys2 to generate the column Signal
create table infosys2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN 
		(`20 Day MA` > `50 Day MA`) AND (LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over()) THEN 'Buy'
		WHEN 
		(`20 Day MA` < `50 Day MA`) AND (LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over()) THEN 'Sell'
		ELSE 'Hold' 
end as `Signal`
FROM Assignment.infosys1;

-- Create tcs2 to generate the column Signal
create table tcs2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN 
		(`20 Day MA` > `50 Day MA`) AND (LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over()) THEN 'Buy'
		WHEN 
		(`20 Day MA` < `50 Day MA`) AND (LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over()) THEN 'Sell'
		ELSE 'Hold' 
end as `Signal`
FROM Assignment.tcs1;

-- Create tvs2 to generate the column Signal
create table tvs2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN 
		(`20 Day MA` > `50 Day MA`) AND (LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over()) THEN 'Buy'
		WHEN 
		(`20 Day MA` < `50 Day MA`) AND (LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over()) THEN 'Sell'
		ELSE 'Hold' 
end as `Signal`
FROM Assignment.tvs1;

-- Creating a User defined function that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock
DROP function IF EXISTS Assignment.udf_signal_day;

delimiter $$
create function udf_signal_day (in_Date varchar(10))
returns varchar(4)
deterministic
begin
declare Signal_Val varchar(4);
select `Signal` into Signal_Val from bajaj2 where date=str_to_date(in_Date, "%Y-%m-%d");
return Signal_Val;
end$$ 
delimiter ;

-- Retrieving the Signal for particular dates
select udf_signal_day('2018-06-21') as `Signal`; 
select udf_signal_day('2017-12-21') as `Signal`; 
select udf_signal_day('2017-08-09') as `Signal`; 












