create database retail_sale;
use retail_sales;
alter table `retail sales`
change column transaction_id  transaction_id int NOT NULL,
change column sale_date sale_date date null default null ,
change column sale_time sale_time time null default null;
rename table `retail sales` to sales_info;

alter table sales_info
change column quantiy quantity int not null;

select * from sales_info;


select count(*) from sales_info;

select * from sales_info
where transaction_id is null
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

delete from sales_info   
where transaction_id is null
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


-- Data exploration

-- How many sales we have

select * from sales_info;

select count(*) as total_sales from sales_info;

-- How many unique customers we have 

select count(distinct customer_id) as total_customer from sales_info;

-- How many category we have

select count(distinct category) as category from sales_info;

-- Data analysis

-- Q1 Write a sql query to retrive all columns for sales made on 2022-11-05

select * from sales_info
where sale_date = '2022-11-05';

-- Q2 write a sql query to retrive all transaction where the category is 'clothing' and the quantity sold is more than 3 in a month
-- of nov-2022.

select  * from sales_info 
where category = 'clothing'
and
quantiy > 3
and 
date_format(sale_date, '%Y-%m') = '2022-11';

-- Q3 Write a sql query to calculate the total sales for each category 

select category, sum(total_sale) as net_sale,
count(*) as total_order
from sales_info
group by category
order by net_sale desc;

-- Q4 Write a sql query to calculate the average age of customers who purchased from the beauty category.

select round(avg(age),2) avg_age from sales_info
where category = 'beauty';

-- Q5 Write a sql query to find all transactions where the total sales is greater than 1000.

select * from sales_info
where total_sale > 1000
order by total_sale desc;

-- Q6 write a sql query to find the total number of transactions made by each gender in each category 

select gender, category,count(*) as transaction_count from sales_info
group by gender, category
order by gender;

-- Q7 Write a sql query to calculate the average sale for each month. find out best selling month in each year. 

 select * from (
select year(sale_date)as year_, 
date_format(sale_date,'%M') as month_, 
avg(total_sale) as avg_sales,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as sale_rank
 from sales_info
group by year_, month_) as t1
where sale_rank = 1;

-- Q8 write a sql sqery to find a top 5 customer based on the highest total sales

select customer_id, sum(total_sale) as total_spent from sales_info
group by customer_id
order by total_spent desc
limit 5;

-- Q9 write a sql query to find the number of unique customer who purchased items from each category. 

select category,
count(distinct(customer_id)) as unique_customer 
from sales_info
group by category;

-- Q10 Write a sql query to create each shift and number of orders(example morning <= 12, Afternoon Between 12 & 17, Evening > 17)

select 
case
    when hour(sale_time) < 12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    when hour(sale_time) > 17 then 'evening'
    else 'Evening'
end as shift,
count(*) as no_of_order
from sales_info
group by shift;

--  --- --- --- --- - --- -- --- - -- - - -END OF PROJECT - - -- - -- - - -- - - - -- - - - -- -















