import pandas as pd
import sqlalchemy as sal

# ---------- STEP 1: Read CSV ----------
df = pd.read_csv("orders.csv", na_values=["Not Available", "unknown"])

# ---------- STEP 2: Clean column names ----------
df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")

# Now columns become:
# order_id, order_date, ship_mode, segment, country, city, state,
# postal_code, region, category, sub_category, product_id,
# cost_price, list_price, quantity, discount_percent

# ---------- STEP 3: Feature Engineering ----------
df["discount"] = df["list_price"] * df["discount_percent"] * 0.01
df["sale_price"] = df["list_price"] - df["discount"]
df["profit"] = df["sale_price"] - df["cost_price"]

# ---------- STEP 4: Convert date ----------
df["order_date"] = pd.to_datetime(df["order_date"], format="%Y-%m-%d")

# ---------- STEP 5: Drop unused columns ----------
df.drop(columns=["list_price", "cost_price", "discount_percent", "discount"], inplace=True)

print("Data Preprocessing Done. Sample:")
print(df.head())

# ---------- STEP 6: Connect to SQL Server ----------
# IMPORTANT: Your SQL Server instance name is SQLEXPRESS
# Your database name we created: RetailOrdersDB

engine = sal.create_engine(
    "mssql+pyodbc://localhost\\SQLEXPRESS/RetailOrdersDB"
    "?driver=ODBC+Driver+18+for+SQL+Server"
    "&Trusted_Connection=yes"
    "&TrustServerCertificate=yes"
)

# ---------- STEP 7: Load to SQL ----------
df.to_sql("df_orders", con=engine, index=False, if_exists="replace")

print("Data Loaded Successfully into SQL Server ✅")
