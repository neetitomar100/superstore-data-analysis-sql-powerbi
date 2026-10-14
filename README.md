# Superstore Sales Analysis (SQL + Power BI)

Analyzed sales, profit, returns, and discount impact for a retail store (2012 to 2015). SQL (PostgreSQL) was used for the analysis, and Power BI for the dashboard.

## Dashboard (4 pages)

![Sales](1_sales.png)
![Returns](2_returns.png)
![Profit](3_profit.png)
![Discount Impact](4_discount.png)

## What I did
- SQL (PostgreSQL): analyzed sales, profit, return rate, and discount impact across 3 tables (orders, returns, people) using JOINs, GROUP BY, HAVING, and date functions
- Power BI: built a 4-page dashboard (Sales, Returns, Profit, Discount Impact) with DAX measures for profit margin %, return rate %, and discount value

## Key findings
- Total sales of $12.64M and profit of $1.47M (12% margin) from about 26K orders
- Orders with 20%+ discount lost $0.8M, while full-price orders earned $1.8M profit
- Profit margin falls from 25% (no discount) to -42% (20%+ discount)
- Returns are about 4% of orders; Binders are the most returned sub-category

## Files
- `superstore_analysis.sql`: SQL queries
- `Superstore_Analysis.pbix`: Power BI file
- `1_sales.png` to `4_discount.png`: dashboard pages

## Tools
PostgreSQL, SQL, Power BI, DAX
