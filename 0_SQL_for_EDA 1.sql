USE rainfall_cleaned;

-- Calculate total annual rainfall for each city
WITH city_annual_rainfall AS (
    SELECT 
        City,
        Climate_Type,
        Year,
        SUM(rainfall_mm) as total_rainfall_mm
    FROM rainfall_data
    GROUP BY City, Climate_Type, Year
),

-- Calculate average annual rainfall per climate type
-- (Sum of all cities' rainfall in that climate type / number of cities)
climate_type_averages AS (
    SELECT 
        Climate_Type,
        Year,
        AVG(total_rainfall_mm) as avg_rainfall_per_city,
        COUNT(DISTINCT City) as city_count,
        SUM(total_rainfall_mm) as total_rainfall_all_cities
    FROM city_annual_rainfall
    GROUP BY Climate_Type, Year
)

-- Final query to get the results
SELECT 
    Climate_Type,
    Year,
    avg_rainfall_per_city as "Average Rainfall (mm)",
    city_count as "Number of Cities",
    total_rainfall_all_cities as "Total Rainfall All Cities"
FROM climate_type_averages
ORDER BY Climate_Type, Year;
