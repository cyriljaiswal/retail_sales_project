-- Retail Sale analysis 
Create Database sql_project_1;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
			transactions_id INT PRIMARY KEY,
			sale_date date,
			sale_time TIME,	
			customer_id INT,
			gender VARCHAR(15),
			age INT,
			category VARCHAR(25),	
			quantity INT,	
			price_per_unit FLOAT,	
			cogs FLOAT,
			total_sale FLOAT
		);

select * from retail_sales
LIMIT 10

select COUNT (*)
from retail_sales



-- Checking null for every column

select * from retail_sales 
	WHERE 
		transactions_id is null
		Or
		sale_date is null
		Or
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
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null

-- To delete Null records 

Delete from retail_sales
	WHERE 
		transactions_id is null
		Or
		sale_date is null
		Or
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
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null

-- Data Exploration

-- How many sales we have?
select Count (*) as total_sales from retail_sales

-- How many unique customers we have?
select Count (Distinct customer_id) as total_sales from retail_sales

-- How many categories we have?
select Count (Distinct category) as total_sales from retail_sales

-- Type of Category:
select Distinct category from retail_sales


-- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2025-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2024
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2025-11-05'

select * from retail_sales
where sale_date = '2025-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2024

select
	*
From retail_sales
where category = 'Clothing'
	And 
	To_char(sale_date, 'YYYY-MM') = '2024-11'
	And
	quantity >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select
	Round(Avg(age), 2) as avg_age
from retail_sales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.

select 
    category,
    gender,
    COUNT(*) as total_trans
from retail_sales
group
    by
    category,
    gender
order by 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select
       year,
       month,
    avg_sale
from 
(    
select
    extract(year from sale_date) as year,
    extract(month from sale_date) as month,
    avg(total_sale) as avg_sale,
    rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1, 2
) as t1
where rank = 1

-- order by 1, 3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

select
    customer_id,
    SUM(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
    category,
    count(distinct customer_id) as unique_cust_cnt
from retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales
as
(
select *,
    case
        when extract(hour from sale_time) < 12 then 'morning'
        when extract(hour from sale_time) between 12 and 17 then 'afternoon'
        else 'evening'
    end as shift
from retail_sales
)
select 
    shift,
    count(*) as total_orders    
from hourly_sale
group by shift

--END OF THE PROJECT