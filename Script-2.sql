SELECT * FROM passengers;

-- 1. Count the number of passengers and the average age in each class. (Correct)

SELECT Pclass, COUNT(*), AVG(Age)
FROM passengers
GROUP BY Pclass

SELECT 
COUNT(*) AS "Number of Passengers", 
AVG(Age) AS "Average Age" 
FROM passengers; 

SELECT 
COUNT(*) AS "No.Passengers in 1st Class", 
AVG(Age) AS "Average Age" 
FROM passengers
WHERE Pclass = 1; 

SELECT 
COUNT(*) AS "No.Passengers in 2nd Class", 
AVG(Age) AS "Average Age" 
FROM passengers
WHERE Pclass = 2; 

SELECT 
COUNT(*) AS "No.Passengers in 3rd Class", 
AVG(Age) AS "Average Age" 
FROM passengers
WHERE Pclass = 3; 




-- 2. Count the number of passengers in each class that have survived / not survived (Correct)

SELECT Pclass, Survived, COUNT(*)
FROM passengers
GROUP BY Pclass, Survived

SELECT COUNT(Survived) AS "Survived People in First Class"
FROM passengers p 
WHERE Survived = 1 AND Pclass = 1 ;


SELECT COUNT(Survived) AS "Survived People in Second Class"
FROM passengers p 
WHERE Survived = 1 AND Pclass = 2 ;

SELECT COUNT(Survived) AS "Survived People in Third Class"
FROM passengers p 
WHERE Survived = 1 AND Pclass = 3 ;



-- 3. Determine the embarkment port (S, C, Q) where most first-class passengers boarded (Correct)

SELECT Embarked, COUNT(*) as count
FROM passengers
WHERE Pclass = 1
GROUP BY Embarked
ORDER BY count DESC

SELECT MAX(Embarked) 
FROM passengers p 
WHERE Pclass = 1;

SELECT COUNT(Embarked) 
FROM passengers p 
WHERE Pclass = 1 AND Embarked LIKE 'S';

SELECT COUNT(Embarked) 
FROM passengers p 
WHERE Pclass = 1 AND Embarked LIKE 'C';

SELECT COUNT(Embarked) 
FROM passengers p 
WHERE Pclass = 1 AND Embarked LIKE 'Q';



-- 4. For passenger Mr. James Moran, set the missing age value to 28 (Correct)
--    Hint: UPDATE ... SET ... WHERE

UPDATE passengers
SET Age = 28
WHERE PassengerId = 6

UPDATE passengers 
SET Age = 28
WHERE Name LIKE "%Moran%" AND Name LIKE "%James%";

SELECT *
FROM passengers p 
WHERE Name LIKE "%Moran%" AND Name LIKE "%James%";



-- 5. Determine whether more male or female passengers travelled with at least one sibling or spouse (Correct)

SELECT sex, COUNT(*)
FROM passengers
WHERE SibSp > 0
GROUP BY sex

SELECT MAX(Sex)
FROM passengers p
WHERE SibSp >= 1;

SELECT COUNT(Sex)
FROM passengers p
WHERE SibSp >= 1 AND Sex = 'male';

SELECT COUNT(Sex)
FROM passengers p
WHERE SibSp >= 1 AND Sex = 'female';



-- 6. Select all last names (defined as prefix of Name before the comma) (Correct)
-- Hint: https://sqlite.org/lang_corefunc.html


SELECT SUBSTR(Name, 1, INSTR(Name, ',')-1) AS lastname
FROM passengers

SELECT
  Name AS "Full Name",
  SUBSTRING(Name , 1, CHARINDEX(' ', Name) - 2) AS "Last Name",
  SUBSTRING(Name , CHARINDEX(' ', Name) + 1, LENGTH(Name)) AS "First Name"
FROM
  passengers p;

 

-- 7. For each last name, count the number of passengers (Correct)

 
 SELECT 
  SUBSTR(Name, 1, INSTR(Name, ',')-1) AS lastname,
  COUNT(*) AS count FROM passengers p
GROUP BY
lastname
ORDER BY
count DESC


SELECT
  SUBSTRING(Name , 1, CHARINDEX(' ', Name) - 2) AS "Last Name",
  COUNT(*) occurrences
FROM
  passengers p
GROUP BY
  "Last Name"
HAVING 
  COUNT(*) >= 1
ORDER BY occurrences DESC;


-- 8. The average age is 24.064 years. What is the median age? (Correct)
--    Hint: SELECT ... LIMIT ... OFFSET


SELECT Age AS "Median of Age"
FROM passengers
ORDER BY Age 
LIMIT 1
OFFSET (SELECT COUNT(*)
        FROM passengers) / 2;

       
       
SELECT Age
FROM passengers
ORDER BY Age
LIMIT 1
OFFSET (SELECT COUNT(*)/2
FROM passengers)       



