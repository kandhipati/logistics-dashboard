-- Calculate total volume and average on-time delivery rate by region
SELECT 
    Region,
    SUM(Volume) AS Total_Volume,
    AVG(OnTimeDeliveryRate) AS Avg_OnTime_Rate
FROM logistics_data
GROUP BY Region;