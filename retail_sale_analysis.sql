ALTER TABLE retail_sale
CHANGE `ï»¿transactions_id` transactions_id INT;


select * from retail_sale;

desc retail_sale;

alter table retail_sale
MODIFY sale_date date,
MODIFY sale_time time,
MODIFY gender varchar(15),
MODIFY category varchar(15),
MODIFY price_per_unit float,
MODIFY cogs float,
MODIFY total_sale float;

select count(*) from retail_sale;

select * 
from retail_sale
where sale_date is null; 

select * 
from retail_sale
where sale_time is null; 

select * 
from retail_sale
where customer_id is null; 

select * 
from retail_sale
where customer_id is null; 

select * 
from retail_sale
where 
	transactions_id is null
    or
	sale_date is null
    or 
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    


delete from retail_sale
where 
	transactions_id is null
    or
	sale_date is null
    or 
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;


-- Data Exploration--

-- how many sales we have
select count(*) from retail_sale;

-- how many customers we have
select count(distinct customer_id) from retail_sale;

-- how many category we have
select distinct category from retail_sale;

-- Data Analysis & business key Problems --

-- q-1 write a query to retrieve all columns for sales made on 2022-11-5
select * 
from retail_sale
where sale_date = '2022-11-5';

-- q-2 write a query to retrieve all the transaction where the category is clothing and quantity sold is more than 4 in the month of nov-2022
select *
from retail_sale
where category = 'Clothing' and quantiy >= 4 and date_format(sale_date, 'YYYY-MM') = '2022-11';


-- q.3 write a query to calculate total sale for each category
select category, sum(total_sale), count(*) total_order
from retail_sale 
group by category;

-- q-4 write a query to find average age for customer who purchased item  for the beauty category
select round(avg(age),2) as avg_age
from retail_sale
where category = 'Beauty';

-- q-5 write a query to find all the transaction where total sale is greater then 1000	

select * from retail_sale where total_sale >1000;

-- q-6 write a query to find out total number of transaction  (transaction_id ) made by each gender in 	each category

select count(*), category,gender
from retail_sale
group by  category,gender;


-- q-7 write a qury to calculate the average sale for each month , find out the best selling month in each year
select * from retail_sale;

select * from
(
select  year(sale_date) year,  
		month(sale_date) month ,
        round(avg(total_sale),0) avg,
		rank() over(partition by year(sale_date) order by avg(total_sale) desc)  as rank_sale_month
from retail_sale
group by 1,2
) as t1
where rank_sale_month =1;

-- q-8 write query to find the top 5 customer based on the highest total sale

select customer_id, sum(total_sale) from retail_sale
group by 1
order by 2 desc
limit 5;

-- q-9 write a query to find number of unique customer who purchased item from each category

select * from retail_sale;

select category, count(distinct customer_id)
from retail_sale
group by category;

-- q-10 write a query to create a each shift and number of orders (example : morning<=12, afternoon between 12 & 17 , evening >17)

with hourly_sale as
(
select *,
	case
		when hour(sale_time) < 12 then 'Morning' 
		when  hour(sale_time) between 12 and 17  then 'Afternoon'
        else 'Evening'
	end as shift
from retail_sale
)
select shift, count(*) total_orders
from hourly_sale
group by shift ;


