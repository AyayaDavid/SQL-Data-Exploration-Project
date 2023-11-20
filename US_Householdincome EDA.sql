#US Household Income Exploratory Data Analysis


SELECT * 
FROM us_householdincome.us_household_income;


SELECT * 
FROM us_householdincome.us_household_income_statistics;




----------------------------------------------------------------------------------------------

SELECT State_Name,County, City, ALand, AWater
FROM us_householdincome.us_household_income;


---------------------------------------------------------------------------------------------------------------------------------

-- Calculate the  Total of sum land area and water for each state


-- Select State_Name, sum of ALand, and sum of AWater for each state
SELECT 
  -- State_Name column represents the names of states
  State_Name,
  
  -- SUM(ALand) calculates the total land area for each state
  SUM(ALand) AS Total_Land_Area,
  
  -- SUM(AWater) calculates the total water area for each state
  SUM(AWater) AS Total_Water_Area
  
-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Group the results by the "State_Name" column
GROUP BY State_Name

-- Order the results by the total land and water  area (SUM(ALand = 1)), (SUM(AWater = 2)) in descending order
ORDER BY 3 DESC

-- Limit the results to the top 10 rows
LIMIT 10;

---------------------------------------------------------------------------------------------------------------------------------------------------

-- combination of columns from both tables


-- Select all columns from the joined tables
SELECT * 

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id;
----------------------------------------------------------------------------------------------------------------------------------------------

-- combination of columns from both tables where the 'id' values match and the "Mean" column is not equal to 0


-- Select all columns from the joined tables
SELECT * 

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
INNER JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id

-- Filter the results to exclude rows where Mean is 0
WHERE Mean <> 0;

     ----------------------------------------------------------------------------------------------------------------------- 
      
      
-- Select specific columns from the joined tables
SELECT 
  -- State_Name column from the "us_household_income" table, aliased as 'u'
  u.State_Name,
  
  -- County column from the "us_household_income" table, aliased as 'u'
  County,
  
  -- Type column from the "us_household_income" table, aliased as 'u'
  Type,
  
  -- `Primary` column from the "us_household_income" table, aliased as 'u'
  `Primary`,
  
  -- Mean column from the "us_household_income_statistics" table, aliased as 'us'
  Mean,
  
  -- Median column from the "us_household_income_statistics" table, aliased as 'us'
  Median

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
INNER JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id

-- Filter the results to exclude rows where Mean is 0
WHERE Mean <> 0;


-------------------------------------------------------------------------------------------------------------------------------------



-- Select State_Name, rounded average of Mean, and rounded average of Median for each state
SELECT 
  -- State_Name column from the "us_household_income" table, aliased as 'u'
  u.State_Name,
  
  -- ROUND(AVG(Mean), 1) calculates the rounded average of the Mean column, aliased as 'Average_Mean'
  ROUND(AVG(Mean), 1) AS Average_Mean,
  
  -- ROUND(AVG(Median), 1) calculates the rounded average of the Median column, aliased as 'Average_Median'
  ROUND(AVG(Median), 1) AS Average_Median

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
INNER JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id

-- Filter the results to exclude rows where Mean is 0
WHERE Mean <> 0

-- Group the results by the State_Name column
GROUP BY u.State_Name

-- Order the results by the third column (1-indexed), which is the rounded average of Median, in descending order
ORDER BY 3 DESC

-- Limit the results to the top 10 rows
LIMIT 10;




------



-- Select Type, rounded average of Mean, and rounded average of Median for each Type
SELECT 
  -- Type column from the "us_household_income" table, aliased as 'u'
  Type,
  
  -- ROUND(AVG(Mean), 1) calculates the rounded average of the Mean column, aliased as 'Average_Mean'
  ROUND(AVG(Mean), 1) AS Average_Mean,
  
  -- ROUND(AVG(Median), 1) calculates the rounded average of the Median column, aliased as 'Average_Median'
  ROUND(AVG(Median), 1) AS Average_Median

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
INNER JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id

-- Filter the results to exclude rows where Mean is 0
WHERE Mean <> 0

-- Group the results by the Type column (alternatively, can use GROUP BY 1 for Type)
GROUP BY Type

-- Order the results by the second column (1-indexed), which is the rounded average of Mean, in descending order
ORDER BY 2 DESC

-- Limit the results to the top 20 rows
LIMIT 20;


      
-----------      
-- Select Type, count of Type, rounded average of Mean, and rounded average of Median for each Type
SELECT 
  -- Type column from the "us_household_income" table, aliased as 'u'
  Type,
  
  -- COUNT(Type) calculates the number of occurrences for each type
  COUNT(Type) AS Type_Count,
  
  -- ROUND(AVG(Mean), 1) calculates the rounded average of the Mean column, aliased as 'Average_Mean'
  ROUND(AVG(Mean), 1) AS Average_Mean,
  
  -- ROUND(AVG(Median), 1) calculates the rounded average of the Median column, aliased as 'Average_Median'
  ROUND(AVG(Median), 1) AS Average_Median

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
INNER JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id

-- Filter the results to exclude rows where Mean is 0
WHERE Mean <> 0

-- Group the results by the Type column (alternatively, can use GROUP BY 1 for Type)
GROUP BY Type

-- Order the results by the fourth column (1-indexed), which is the rounded average of Median, in descending order
ORDER BY 4 DESC

-- Limit the results to the top 20 rows
LIMIT 20;


 -------------------------------------------------------------------------------------
      
      
SELECT * 
FROM us_householdincome.us_household_income 
WHERE Type = 'Community';

--- filter out some of the outliers

SELECT Type,COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_householdincome.us_household_income u
INNER JOIN us_householdincome.us_household_income_statistics us
      ON u.id = us.id
      WHERE Mean <> 0
      GROUP BY 1
      HAVING COUNT(Type) > 100
      ORDER BY 4 DESC  
      LIMIT 20
      ;
      
 -----------------------------------------------------------------------
 
 ----- Looking for average household income by State 
 
 SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)

-- From the "us_household_income" table in the "us_householdincome" schema or database, aliased as 'u'
FROM us_householdincome.us_household_income u

-- Inner join with the "us_household_income_statistics" table, aliased as 'us', using the 'id' column
JOIN us_householdincome.us_household_income_statistics us
  ON u.id = us.id
  
  GROUP BY u.State_Name, City
  ORDER BY ROUND(AVG(Mean),1) DESC
  ;
 
 
  
SELECT * 
FROM us_householdincome.us_household_income_statistics;








