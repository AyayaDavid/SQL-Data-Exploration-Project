#World Life Expectancy Project (Exploratory Data Analysis)

SELECT *
 FROM world_life_expectancy.world_life_expectancy;






-- Select the country, minimum life expectancy, maximum life expectancy,
-- and the rounded difference between maximum and minimum life expectancy as "Life_Increase_15_Years"
SELECT Country, 
       MIN(`Life expectancy`) AS Min_Life_Expectancy, 
       MAX(`Life expectancy`) AS Max_Life_Expectancy, 
       ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy.world_life_expectancy
-- Group the results by country
GROUP BY Country
-- Filter out groups where either minimum or maximum life expectancy is 0
HAVING MIN(`Life expectancy`) <> 0
   AND MAX(`Life expectancy`) <> 0
-- Order the results by the calculated "Life_Increase_15_Years" in descending order
ORDER BY Life_Increase_15_Years DESC;









-- Select the country, minimum life expectancy, maximum life expectancy,
-- and the rounded difference between maximum and minimum life expectancy as "Life_Increase_15_Years"
SELECT Country, 
       MIN(`Life expectancy`) AS Min_Life_Expectancy, 
       MAX(`Life expectancy`) AS Max_Life_Expectancy, 
       ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
       
-- From the "world_life_expectancy" table in the "world_life_expectancy" schema or database
FROM world_life_expectancy.world_life_expectancy

-- Group the results by country
GROUP BY Country

-- Filter out groups where either minimum or maximum life expectancy is 0
HAVING MIN(`Life expectancy`) <> 0
   AND MAX(`Life expectancy`) <> 0

-- Order the results by the calculated "Life_Increase_15_Years" in ascending order
ORDER BY Life_Increase_15_Years ASC;









-- Select the year and the rounded average life expectancy for each year
SELECT Year, ROUND(AVG(`Life expectancy`), 2) AS Average_Life_Expectancy

-- From the "world_life_expectancy" table in the "world_life_expectancy" schema or database
FROM world_life_expectancy.world_life_expectancy

-- Filter out rows where life expectancy is 0
WHERE `Life expectancy` <> 0

-- Group the results by year
GROUP BY Year

-- Order the results by year in ascending order
ORDER BY Year;







#check if there's correlation between Country GPD and life expectancy 

SELECT Country, ROUND(AVG(`Life expectancy`),1)  AS Life_exp, ROUND(AVG(GDP),1) AS GDP
 FROM world_life_expectancy.world_life_expectancy
 GROUP BY Country
 HAVING Life_exp > 0
 AND GDP > 0
 ORDER BY GDP ASC
 ;
 
 
 
 
 
 
 
 #check if there's correlation between Country BMI and life expectancy 

SELECT Country, ROUND(AVG(`Life expectancy`),1)  AS Life_exp, ROUND(AVG(BMI),1) AS BMI
 FROM world_life_expectancy.world_life_expectancy
 GROUP BY Country
 HAVING Life_exp > 0
 AND BMI > 0
 ORDER BY BMI ASC
 ;
 
 







-- Select aggregated information based on GDP categories
SELECT 
  -- Count of rows where GDP is greater than or equal to 1500
  SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
  
  -- Average Life Expectancy for rows where GDP is greater than or equal to 1500
  AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) AS High_GDP_Life_Expectancy,
  
  -- Count of rows where GDP is less than or equal to 1500
  SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
  
  -- Average Life Expectancy for rows where GDP is less than or equal to 1500
  AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) AS Low_GDP_Life_Expectancy
FROM world_life_expectancy.world_life_expectancy
LIMIT 0, 1000;









-- Select aggregated information based on the "Status" column
SELECT 
  -- Status column represents the different statuses
  Status,
  
  -- Round the average Life Expectancy to one decimal place
  ROUND(AVG(`Life expectancy`), 1) AS Average_Life_Expectancy
  
-- From the "world_life_expectancy" table in the "world_life_expectancy" schema or database
FROM world_life_expectancy.world_life_expectancy

-- Group the results by the "Status" column
GROUP BY Status;










-- Select aggregated information based on the "Status" column
SELECT 
  -- Status column represents the different statuses
  Status,
  
  -- Count the distinct number of countries for each status
  COUNT(DISTINCT Country) AS Distinct_Country_Count,
  
  -- Round the average Life Expectancy to one decimal place
  ROUND(AVG(`Life expectancy`), 1) AS Average_Life_Expectancy
  
-- From the "world_life_expectancy" table in the "world_life_expectancy" schema or database
FROM world_life_expectancy.world_life_expectancy

-- Group the results by the "Status" column
GROUP BY Status;

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
-- Select specific columns and a rolling total based on the "Country" and "Year" columns
SELECT 
  -- Country column represents the country names
  Country,
  
  -- Year column represents the years
  Year,
  
  -- Life expectancy column represents life expectancy values
  `Life expectancy`,
  
  -- Adult Mortality column represents adult mortality values
  `Adult Mortality`,
  
  -- Calculate the rolling total of "Adult Mortality" partitioned by "Country" and ordered by "Year"
  SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
  
-- From the "world_life_expectancy" table in the "world_life_expectancy" schema or database
FROM world_life_expectancy.world_life_expectancy

-- Filter the results to include only rows where the "Country" column contains 'United'
WHERE Country LIKE '%United%';












 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 





