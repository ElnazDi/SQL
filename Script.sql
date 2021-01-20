
-- 1. Determine all available cities of a country of your choice

SELECT Name AS Cities_in_Iran
FROM City c 
WHERE Country = 'IR';




-- 2. Count the cities of a country / the cities that have more than 1 000 000 population. (Correct)

SELECT COUNT(*) 
FROM City c 
WHERE Population >= 1000000 AND Country = 'IR';

SELECT Name, Population 
FROM City c 
WHERE Population >= 1000000 AND Country = 'IR'
ORDER BY Population DESC;




-- 3. Calculate the sum population of all listed cities of a country

SELECT SUM(Population)
FROM City c 
WHERE Country = 'IR';




-- 4. Determine the river in Germany that flows through the largest number of provinces (Correct)
--    (should be river "Elbe" crossing 7 provinces)


SELECT River, COUNT(Province) as NumProvinces
FROM geo_River
WHERE Country = 'D'
GROUP BY River
ORDER BY NumProvinces DESC;


SELECT DISTINCT MAX(River) AS 'River that exsists in most of the provience'
FROM River r 
INNER JOIN Lake l
USING('River')
INNER JOIN geo_River gr 
USING ('River')
WHERE Country = 'D';





-- 5. For each country, compare the total population size with the population of its capital (CORRECT)
--    and calculate the percentage of people living in the capital

SELECT c.Name AS Country_Name , c.Population AS Country_Population, 
       c.Capital ,c2.Population AS Capital_Population, 
       (c2.Population * 100 ) / c.Population AS CapitalPopulationPercentage
FROM Country c 
INNER JOIN City c2 
ON c.Code = c2.Country
AND 
   c.Capital = c2.Name
ORDER BY
CapitalPopulationPercentage DESC;





-- 6. For each country, determine the number of lakes (geo_Lake) (Correct)

SELECT Name AS Country_Name, COUNT(Lake) 
FROM Country c 
LEFT JOIN geo_Lake gl
ON c.Code = gl.Country
GROUP BY c.Name; -- This part is really important





-- 7. Add the "Neckar" river to the geo_River table (Correct)

INSERT INTO geo_River(River, Country, Province)
VALUES('Neckar', 'D', 'Baden-Württemberg');

SELECT * 
FROM geo_River gr 
WHERE River = 'Neckar';



-- 8. Try to add another record with the same unique key
-- (should fail because of violation of the "UNIQUE constraint") (Correct)

INSERT INTO
Country (Name, Code, Capital, Province, Area, Population)
VALUES
('India', 'A', 'B', 'C', 0, 0)














