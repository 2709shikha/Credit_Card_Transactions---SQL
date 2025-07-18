select * from credit_card_transactions

--1 write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends
with cte as (select sum(amount) as total_spends from credit_card_transactions)

select top 5 city, sum(amount) as spends, (sum(amount)/total_spends)*100 as percentage_contribution
from credit_card_transactions
join cte on 1=1
group by city, total_spends
order by spends desc


--2 write a query to print highest spend month and amount spent in that month for each card type
with cte as(select card_type, DATEPART(year,transaction_date) as Year, DATEPART(month,transaction_date) as month, sum(amount) as expense
from credit_card_transactions 
group by card_type, DATEPART(year,transaction_date), DATEPART(month,transaction_date))
select * from (
select *, rank() over(partition by card_type order by expense desc) as rn
from cte)A
where rn=1


--3 write a query to print the transaction details(all columns from the table) for each card type when
----it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)
select * from(
select * ,rank() over(partition by card_type order by cum_sum asc) as rn
from(
select *, sum(amount) over(partition by card_type order by transaction_date, transaction_id) as cum_sum
from credit_card_transactions) A
where cum_sum>=1000000) B
where rn=1

--4 write a query to find city which had lowest percentage spend for gold card type
select city,sum(amount) as total_spend, sum(case when card_type='Gold' then amount else 0 end) as gold_spend,
sum(case when card_type='Gold' then amount else 0 end)/sum(amount) as gold_contribution
from credit_card_transactions
group by city
having sum(case when card_type='Gold' then amount else 0 end)>0
order by gold_contribution

--5 write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
with cte as (
select city,exp_type,sum(amount) as total_spend
from credit_card_transactions
group by city,exp_type)
--order by city,total_spend
, cte2 as (
select *
,rank() over(partition by city order by total_spend desc) rn_high
,rank() over(partition by city order by total_spend) rn_low
from cte)
select city
, max(case when rn_high=1 then exp_type end) as highest_expense_type
, max(case when rn_low=1 then exp_type end) as lowest_expense_type
from cte2
where rn_high=1 or rn_low=1
group by city;

--6 write a query to find percentage contribution of spends by females for each expense type
select exp_type,sum(amount) as total_spend
, sum(case when gender='F' then amount else 0 end) as female_spend
,sum(case when gender='F' then amount else 0 end)*1.0/sum(amount)*100 as female_contribution
from credit_card_transactions
group by exp_type
order by female_contribution

--7 which card and expense type combination saw highest month over month growth in Jan-2014
with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transactions
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend) as mom_growth
from (
select *
,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mom_growth desc;

--8 during weekends which city has highest total spend to total no of transactions ratio
select city, sum(amount)*1.0/count(*) as ratio 
from credit_card_transactions
where datepart(weekday,transaction_date) in (1,7)
group by city
order by ratio desc

--9 which city took least number of days to reach its 500th transaction after the first transaction in that city
with cte as (
select *
, row_number() over(partition by city order by transaction_date,transaction_id) as rn
from credit_card_transactions)
select city, min(transaction_date) as first_transaction,max(transaction_date) as last_transaction
, datediff(day,min(transaction_date),max(transaction_date)) as days_to_500
from cte
where rn in (1,500)
group by city
having count(*)=2
order by days_to_500 asc