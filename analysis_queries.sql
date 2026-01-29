-- Top 10 highest revenue products
SELECT TOP 10 product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC;

-- Top 5 products in each region
WITH cte AS (
  SELECT region, product_id, SUM(sale_price) AS sales
  FROM df_orders
  GROUP BY region, product_id
)
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY region ORDER BY sales DESC) rn
  FROM cte
) t
WHERE rn <= 5;

-- Month over month sales growth 2022 vs 2023
WITH cte AS (
 SELECT YEAR(order_date) yr, MONTH(order_date) mn, SUM(sale_price) sales
 FROM df_orders
 GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT mn,
 SUM(CASE WHEN yr=2022 THEN sales ELSE 0 END) sales_2022,
 SUM(CASE WHEN yr=2023 THEN sales ELSE 0 END) sales_2023
FROM cte
GROUP BY mn
ORDER BY mn;

-- Best month per category
WITH cte AS (
 SELECT category,
        FORMAT(order_date,'yyyyMM') AS order_year_month,
        SUM(sale_price) AS sales
 FROM df_orders
 GROUP BY category, FORMAT(order_date,'yyyyMM')
)
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) rn
  FROM cte
) t
WHERE rn = 1;

-- Sub-category with highest growth 2023 vs 2022
WITH cte AS (
 SELECT sub_category, YEAR(order_date) AS yr, SUM(sale_price) sales
 FROM df_orders
 GROUP BY sub_category, YEAR(order_date)
),
cte2 AS (
 SELECT sub_category,
  SUM(CASE WHEN yr=2022 THEN sales ELSE 0 END) sales_2022,
  SUM(CASE WHEN yr=2023 THEN sales ELSE 0 END) sales_2023
 FROM cte
 GROUP BY sub_category
)
SELECT TOP 1 *, (sales_2023 - sales_2022) AS profit_growth
FROM cte2
ORDER BY profit_growth DESC;
