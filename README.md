# 🛒 Retail Sales Analysis — SQL Project

![SQL](https://img.shields.io/badge/Language-SQL-blue?style=flat-square&logo=postgresql)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square)
![Domain](https://img.shields.io/badge/Domain-Retail%20Analytics-orange?style=flat-square)

## 📌 Project Overview

This project is a end-to-end **SQL-based Retail Sales Analysis** built on a real-world style dataset. It covers the full workflow — from database setup and data cleaning to exploration and answering key business questions using structured queries.

The goal is to demonstrate practical SQL skills including **aggregations, window functions, CTEs, filtering, and date/time manipulation** in the context of a retail sales environment.

---

## 🗂️ Dataset

The dataset (`SQL_RETAIL_SALES_DATA.csv`) contains transactional retail sales records with the following columns:

| Column | Description |
|---|---|
| `transactions_id` | Unique ID for each transaction |
| `sale_date` | Date of the sale |
| `sale_time` | Time of the sale |
| `customer_id` | Unique customer identifier |
| `gender` | Customer gender |
| `age` | Customer age |
| `category` | Product category (e.g., Clothing, Beauty) |
| `quantity` | Units sold |
| `price_per_unit` | Price per item |
| `cogs` | Cost of goods sold |
| `total_sale` | Total sale value |

---

## 🛠️ Database Setup

```sql
create database sql_project_1;

drop table if exists retail_sales;
create table retail_sales (
    transactions_id  int primary key,
    sale_date        date,
    sale_time        time,
    customer_id      int,
    gender           varchar(15),
    age              int,
    category         varchar(25),
    quantity         int,
    price_per_unit   float,
    cogs             float,
    total_sale       float
);
```

---

## 🧹 Data Cleaning

Checked for and removed any NULL records across all columns to ensure data integrity before analysis.

```sql
-- identify null records
select * from retail_sales
where
    transactions_id is null or sale_date is null or sale_time is null or
    customer_id is null or gender is null or age is null or
    category is null or quantity is null or price_per_unit is null or
    cogs is null or total_sale is null;

-- delete null records
delete from retail_sales
where
    transactions_id is null or sale_date is null or sale_time is null or
    customer_id is null or gender is null or age is null or
    category is null or quantity is null or price_per_unit is null or
    cogs is null or total_sale is null;
```

---

## 🔍 Data Exploration

```sql
-- total number of sales
select count(*) as total_sales from retail_sales;

-- unique customers
select count(distinct customer_id) as total_customers from retail_sales;

-- product categories available
select distinct category from retail_sales;
```

---

## 📊 Business Questions & SQL Solutions

### Q1 — Sales on a Specific Date

```sql
select * from retail_sales
where sale_date = '2025-11-05';
```

---

### Q2 — Clothing Transactions with Quantity ≥ 4 in November 2024

```sql
select * from retail_sales
where category = 'Clothing'
  and to_char(sale_date, 'YYYY-MM') = '2024-11'
  and quantity >= 4;
```

---

### Q3 — Total Sales by Category

```sql
select
    category,
    sum(total_sale) as net_sale,
    count(*)        as total_orders
from retail_sales
group by category;
```

---

### Q4 — Average Customer Age for Beauty Category

```sql
select round(avg(age), 2) as avg_age
from retail_sales
where category = 'Beauty';
```

---

### Q5 — High-Value Transactions (> 1000)

```sql
select * from retail_sales
where total_sale > 1000;
```

---

### Q6 — Transactions by Gender per Category

```sql
select
    category,
    gender,
    count(*) as total_transactions
from retail_sales
group by category, gender
order by category;
```

---

### Q7 — Best Selling Month per Year (by Average Sale)

```sql
select year, month, avg_sale
from (
    select
        extract(year from sale_date)  as year,
        extract(month from sale_date) as month,
        avg(total_sale)               as avg_sale,
        rank() over (
            partition by extract(year from sale_date)
            order by avg(total_sale) desc
        ) as rank
    from retail_sales
    group by 1, 2
) as ranked_months
where rank = 1;
```

---

### Q8 — Top 5 Customers by Total Sales

```sql
select
    customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;
```

---

### Q9 — Unique Customers per Category

```sql
select
    category,
    count(distinct customer_id) as unique_customers
from retail_sales
group by category;
```

---

### Q10 — Orders by Time of Day Shift

```sql
with hourly_sales as (
    select *,
        case
            when extract(hour from sale_time) < 12              then 'Morning'
            when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
            else 'Evening'
        end as shift
    from retail_sales
)
select
    shift,
    count(*) as total_orders
from hourly_sales
group by shift;
```

---

## 💡 Key Findings

- **Category Performance** — Total sales and order counts vary significantly across product categories, revealing top-performing segments.
- **Customer Demographics** — The average age of Beauty category shoppers provides targeting insights for marketing campaigns.
- **Seasonal Trends** — Identifying the best-selling month per year highlights seasonal demand peaks useful for inventory planning.
- **Peak Hours** — Shift-based analysis shows when orders are highest (Morning / Afternoon / Evening), helping optimize staffing and promotions.
- **Top Customers** — The top 5 customers by revenue can be targeted for loyalty programs or exclusive offers.
- **Gender Insights** — Transaction distribution across gender and category helps tailor product recommendations.

---

## 🧰 Tools Used

- **PostgreSQL** — Primary SQL dialect used for all queries
- **pgAdmin / DBeaver** — Query execution and database management
- **CSV Dataset** — Raw retail sales data imported into the database

---

## 📁 Project Structure

```
retail-sales-sql/
│
├── SQL_RETAIL_SALES_DATA.csv       # Raw dataset
├── RETAIL_SALES_PROJECT.sql        # All SQL queries (setup + analysis)
└── README.md                       # Project documentation
```

---

## 🚀 How to Run

1. Clone this repository
2. Open your SQL client (pgAdmin, DBeaver, etc.)
3. Run `RETAIL_SALES_PROJECT.sql` top-to-bottom
4. Import `SQL_RETAIL_SALES_DATA.csv` into the `retail_sales` table
5. Execute individual queries to explore the analysis

---

## ✅ Conclusion

This project demonstrates a complete SQL analytics workflow on a retail dataset — from raw data ingestion and cleaning to structured business question answering. The queries cover a range of SQL concepts including **aggregations, GROUP BY, window functions (RANK), CTEs, date/time extraction, and conditional logic (CASE WHEN)**.

It serves as a solid foundation for anyone looking to practice real-world SQL for data analysis roles.

---

## 🔗 Connect with Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/cyriljaiswal)
[![GitHub](https://img.shields.io/badge/GitHub-cyriljaiswal-black?style=flat-square&logo=github)](https://github.com/cyriljaiswal)

---


