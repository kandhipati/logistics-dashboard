-- etl_pipeline.sql
-- This script demonstrates a simple ETL process for logistics data

-- Step 1: Create a staging table
CREATE TABLE IF NOT EXISTS logistics_staging (
  Date DATE,
  Region VARCHAR(50),
  Carrier VARCHAR(50),
  Volume INT,
  Spend DECIMAL(10,2),
  OnTimeDeliveryRate DECIMAL(5,2)
);

-- Step 2: Load data from CSV into the staging table
-- (In practice, you would use a tool or command to load CSV data)
-- Example: COPY logistics_staging FROM 'sample_logistics_data.csv' CSV HEADER;

-- Step 3: Clean and transform data (example: filtering out records with nulls)
CREATE TABLE IF NOT EXISTS logistics_clean AS
SELECT *
FROM logistics_staging
WHERE Volume IS NOT NULL
  AND Spend IS NOT NULL
  AND OnTimeDeliveryRate IS NOT NULL;

-- Step 4: Create aggregated summary table for dashboard KPIs
CREATE TABLE IF NOT EXISTS logistics_summary AS
SELECT 
  Region,
  SUM(Volume) AS Total_Volume,
  AVG(OnTimeDeliveryRate) AS Avg_OnTime_Rate,
  SUM(Spend) AS Total_Spend
FROM logistics_clean
GROUP BY Region;
