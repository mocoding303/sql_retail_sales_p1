---create table 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 

	       (    transactions_id INT,
				sale_date date,
				sale_time time,
				customer_id INT,
				gender VARCHAR (15),
				age INT,
				category VARCHAR (15),
				quantiy INT,
				price_per_unit float,
				cogs FLOAT,
				total_sale FLOAT
			
			);


SELECT * from retail_sales 
LIMIT 10

SELECT 
COUNT(*)
FROM retail_sales

--- DATA CLEANING 

SELECT * from retail_sales

WHERE
      transactions_id isnull 
or 
      sale_date ISNULL
or
      sale_time ISNULL
or
	  customer_id ISNULL
or
	  gender ISNULL
or
	  age ISNULL
or
	  Quantiy ISNULL
or
	  price_per_unit ISNULL
or
	  cogs ISNULL
OR
	  total_sale ISNULL;



delete FROM retail_sales

WHERE
      transactions_id isnull 
or 
      sale_date ISNULL
or
      sale_time ISNULL
or
	  customer_id ISNULL
or
	  gender ISNULL
or
	  age ISNULL
or
	  Quantiy ISNULL
or
	  price_per_unit ISNULL
or
	  cogs ISNULL
OR
	  total_sale ISNULL;


--- DATA EXPLORATION

-- how many sales do we have 

SELECT count(*) as total_sales from retail_sales

--- how many unique customer do we have 

SELECT count(distinct customer_id) from retail_sales

--- unique categories

SELECT DISTINCT category  from retail_sales;


--- Data anlysis 

--Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * from retail_sales
where 
     sale_date = '2022-11-05'

---Write a SQL query to retrieve all transactions where the category is 'Clothing'and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
 * 
FROM retail_sales
WHERE
      category = 'Clothing'
	  AND
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  AND 
	  quantiy >=4


SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

----Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category,
sum (total_sale) as total_sales,
count(*) as total_orders
from 
retail_sales
group by 1

---Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT category,
round(avg(age),2) as avg_age
from retail_sales
WHERE category= 'Beauty'
group by 1


--- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * from 
retail_sales
where total_sale >= 1000


--- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select
category,
gender,

count(transactions_id) as number_transaction
from retail_sales
group by 1,2
order by 1

--- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT year,
       month,
	   avg_sale
FROM
( SELECT
	extract (year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank () OVER(partition by extract (year from sale_date)  ORDER by avg(total_sale) DESC) as Rank  
	from retail_sales
	group  by 1,2
) as t1

WHERE rank = 1


-----Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id,
       sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 DESC
LIMIT 5

---- Write a SQL query to find the number of unique customers who purchased items from each category.:
select category,
       count(distinct customer_id) as unique_customer
from retail_sales
group by 1

---Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sale
AS
(
SELECT *,

case
    WHEN extract(hour from sale_time) < 12 then 'Morning'
	WHEN extract (hour from sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
	ELSE 'Evening'
end AS shift
from retail_sales
) 

SELECT shift, 
       count(*) num_orders
from hourly_sale
group by 1
