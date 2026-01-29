# Retail ETL SQL Analytics

End-to-End Data Analytics Project: CSV → Python → SQL Server → SQL Analysis → Insights

---

## 📊 Project Flow Diagram

```mermaid
flowchart LR
    A[(Orders.csv)] -->|Extract| B[Python ETL<br/>Pandas Cleaning]
    B -->|Load| C[(SQL Server Database)]
    C -->|Analyze| D[SQL Queries<br/>CTEs & Window Functions]
    D --> E[Business Insights]


## Project Overview
End-to-end data analytics pipeline that:
- Extracts retail order data from CSV
- Cleans and preprocesses using Python (Pandas)
- Loads processed data into SQL Server
- Performs advanced SQL analysis for business insights

## Tech Stack
- Python 3.12
- Pandas
- SQLAlchemy + PyODBC
- Microsoft SQL Server (SSMS)

## Key Analysis
- Top revenue-generating products
- Top-selling products per region
- Month-over-month sales growth (2022 vs 2023)
- Best sales month per category
- Sub-category with highest yearly growth

## How to Run
1. Install Python libraries:

2. Run ETL:

3. Open `analysis_queries.sql` in SSMS and execute queries.

## Author
Suraj Keshri
GitHub: https://github.com/surajkeshri-1912
