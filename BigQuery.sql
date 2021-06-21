-- 1. How many boroughs are there in London ? 
SELECT DISTINCT borough
FROM `dataengineering-315913.londoncrime.fromGCE_13M`;

-- 2. What is the rate of crimes in each borough?
SELECT borough, SUM(value) AS number_of_crimes
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
GROUP BY borough
ORDER BY number_of_crimes DESC;

-- 3. How many LSOA codes are there per borough?
SELECT borough, count(DISTINCT lsoa_code) as n_codes
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
GROUP BY borough
ORDER BY count(DISTINCT lsoa_code) DESC;

-- 4. How many crimes have happend per year in London from 2008 to 2016?
SELECT year, sum(value) AS `total_crime`
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
WHERE year BETWEEN 2008 AND 2016
GROUP BY year
ORDER BY total_crime DESC; 

-- 5. What is the overall volume of the different crimes in London?
SELECT year, major_category, sum(value) AS `total_crime`
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
GROUP BY year, major_category
ORDER BY year, total_crime DESC;


-- 6. How are the crimes in Croydon over the whole time period?
SELECT year, sum(value) AS `total_crime`
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
WHERE borough = 'Croydon'
GROUP BY year
ORDER BY total_crime DESC;


-- 7. What is the order of major crime categories for Croydon in 2012 that most of the crimes has happened in that year?
SELECT major_category, sum(value) AS `total_crime`
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
WHERE borough = 'Croydon' AND year = 2012
GROUP BY major_category
ORDER BY total_crime DESC;


-- 8. What type of crimes are growing fastest? (by finding the total crime counts for the major categories across all the years in the data set)
SELECT year, major_category, SUM(value) AS `total_crime` 
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
GROUP BY major_category, year
ORDER BY major_category, year;


-- 9. What are the different types of crimes and their quantity per year?
SELECT year, major_category, SUM(value) AS `total_crime` 
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
WHERE year BETWEEN 2008 AND 2016
GROUP BY major_category, year
ORDER BY major_category, year;

-- 10. What are the minor categories in Theft and Handling?
SELECT major_category, minor_category, year,SUM(value) AS total_possesions
FROM `dataengineering-315913.londoncrime.fromGCE_13M`
WHERE major_category='Theft and Handling'
GROUP BY 1,2,3
ORDER BY 3 DESC;

-- 11. What is the change in the number of crime incidents from 2011 to 2016?
SELECT
  borough,
  no_crimes_2011,
  no_crimes_2016,
  no_crimes_2016 - no_crimes_2011 AS change,
  ROUND(((no_crimes_2016 - no_crimes_2011) / no_crimes_2016) * 100, 2) AS perc_change
FROM (
  SELECT
    borough,
    SUM(IF(year=2011, value, NULL)) no_crimes_2011,
    SUM(IF(year=2016, value, NULL)) no_crimes_2016
  FROM
    `dataengineering-315913.londoncrime.fromGCE_13M`
  GROUP BY
    borough )
ORDER BY
  perc_change ASC;


-- 12. What are the top 3 crimes per borough?
SELECT
  borough,
  major_category,
  rank_per_borough,
  no_of_incidents
FROM (
  SELECT
    borough,
    major_category,
    RANK() OVER(PARTITION BY borough ORDER BY SUM(value) DESC) AS rank_per_borough,
    SUM(value) AS no_of_incidents
  FROM
    `dataengineering-315913.londoncrime.fromGCE_13M`
  GROUP BY
    borough,
    major_category )
WHERE
  rank_per_borough <= 3
ORDER BY
  borough,
  rank_per_borough;
