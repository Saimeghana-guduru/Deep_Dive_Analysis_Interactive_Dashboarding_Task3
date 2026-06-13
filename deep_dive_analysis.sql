select * from cleaned_hotel_bookings;

-- Identifying market segments with the highest cancellation risk and impact on revenue
SELECT 
    market_segment,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS total_cancellations,
    ROUND(SUM(CAST(is_canceled AS FLOAT)) / COUNT(*), 2) AS cancellation_rate,
    ROUND(SUM(adr), 2) AS total_revenue_generated
FROM cleaned_hotel_bookings
GROUP BY market_segment
ORDER BY cancellation_rate DESC;

-- Analyzing booking demand trends by month and year
SELECT 
    year(arrival_date) as year,
    month(arrival_date) as month,
    COUNT(*) AS bookings_per_month
FROM cleaned_hotel_bookings
GROUP BY year(arrival_date), month(arrival_date)
ORDER BY year(arrival_date), month(arrival_date);

-- Does booking lead time affect cancellation risk?
SELECT 
    CASE 
        WHEN lead_time < 30 THEN 'Short Lead'
        WHEN lead_time BETWEEN 30 AND 90 THEN 'Medium Lead'
        ELSE 'Long Lead'
    END AS lead_time_category,
    COUNT(*) AS total_bookings,
    AVG(is_canceled) AS avg_cancellation_rate
FROM cleaned_hotel_bookings
GROUP BY 1
ORDER BY avg_cancellation_rate DESC;