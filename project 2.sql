USE AdventureWorks2022

--1
SELECT PP.ProductID,PP.Name,PP.Color,PP.ListPrice,PP.Size
FROM Production.Product PP  
WHERE PP.ProductID NOT IN (SELECT PRODUCTID FROM SALES.SalesOrderDetail)
ORDER BY PP.ProductID

GO

--2
SELECT SC.CustomerID,
	(SELECT P.LastName FROM Person.Person P WHERE P.BusinessEntityID = SC.CustomerID) AS LastName,
    (SELECT P.FirstName FROM Person.Person P WHERE P.BusinessEntityID = SC.CustomerID) AS FirstName
FROM Sales.Customer SC
WHERE SC.CustomerID NOT IN (SELECT DISTINCT SOH.CustomerID FROM Sales.SalesOrderHeader SOH)
ORDER BY SC.CustomerID

GO

--3
SELECT TOP 10 C.CustomerID,P.FirstName,P.LastName,
	COUNT(*)
FROM SALES.CUSTOMER C JOIN Person.Person P
	ON C.PersonID=P.BusinessEntityID  JOIN
	SALES.SalesOrderHeader SOH ON C.CustomerID=SOH.CustomerID
GROUP BY C.CustomerID,P.FirstName,P.LastName
ORDER BY COUNT(*) DESC

GO

--4
SELECT  P.FirstName,P.LastName,E.JobTitle,E.HireDate,
		COUNT(*)OVER(PARTITION BY JOBTITLE ORDER BY JOBTITLE) AS COUNTOFTITLE
FROM Person.Person P JOIN HumanResources.Employee E
	ON P.BusinessEntityID=E.BusinessEntityID

GO

--5 
SELECT A.SalesOrderID,A.CustomerID,A.LastName,A.FirstName,A.LASTORDER,A.PREVORDER
FROM (	
		SELECT SOH.SalesOrderID,C.CustomerID,P.LastName,P.FirstName,
			ORDERDATE AS LASTORDER,
			LAG(ORDERDATE) OVER (PARTITION BY C.CUSTOMERID ORDER BY ORDERDATE )AS PREVORDER,
			DENSE_RANK()OVER (PARTITION BY C.CUSTOMERID ORDER BY ORDERDATE DESC) AS RN
		FROM	SALES.SalesOrderHeader SOH JOIN SALES.Customer C
			ON SOH.CustomerID=C.CustomerID  JOIN
			Person.Person P ON
			C.PersonID=P.BusinessEntityID
	) A
		WHERE RN=1
		ORDER BY LastName,CustomerID

GO

--6 
SELECT "YEAR", SALESORDERID, LASTNAME, FIRSTNAME,TOTAL
FROM (
		SELECT "YEAR", SALESORDERID, LASTNAME, FIRSTNAME, TOTAL,
		    DENSE_RANK() OVER(PARTITION BY "YEAR" ORDER BY TOTAL DESC) AS RN
	    FROM (
				 SELECT YEAR(ORDERDATE) AS "YEAR", SOH.SALESORDERID,
			       P.LASTNAME, P.FIRSTNAME, SUM(UNITPRICE*(1-UNITPRICEDISCOUNT)*ORDERQTY) AS TOTAL
             	   FROM Sales.SalesOrderHeader SOH
					JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID=SOD.SalesOrderID
					JOIN SALES.Customer C ON C.CustomerID=SOH.CustomerID
					JOIN PERSON.Person P ON P.BusinessEntityID=C.PersonID
					GROUP BY  YEAR(ORDERDATE), SOH.SALESORDERID,P.LASTNAME, P.FIRSTNAME
			  ) A
	) S
WHERE RN=1
GROUP BY "YEAR", SALESORDERID, LASTNAME, FIRSTNAME,TOTAL

GO

--7

SELECT 
    Month,COALESCE([2011], 0) AS [2011],
    COALESCE([2012], 0) AS [2012],
    COALESCE([2013], 0) AS [2013],
    COALESCE([2014], 0) AS [2014]
FROM (
    SELECT 
        YEAR(ORDERDATE) AS "Year",
        MONTH(ORDERDATE) AS "Month",
        ISNULL(COUNT(*),0) AS "OrdersCount"
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(ORDERDATE), MONTH(ORDERDATE)
	) AS Orders
PIVOT (
		  SUM(OrdersCount)
		   FOR YEAR IN ([2011], [2012], [2013], [2014])
		) AS PivotTable
ORDER BY Month

GO

--8
WITH DATA 
AS (
    SELECT 
        YEAR(SOH.ORDERDATE) AS "YEAR",
        MONTH(SOH.ORDERDATE) AS "MONTH",
        SUM(LineTotal) AS "SUM_PRICE",
        SUM(SUM(LineTotal)) OVER (PARTITION BY YEAR(SOH.OrderDate) ORDER BY MONTH(SOH.OrderDate)) AS "CUM_SUM"
    FROM SALES.SalesOrderHeader SOH 
    JOIN SALES.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
    GROUP BY YEAR(SOH.ORDERDATE),MONTH(SOH.ORDERDATE))
	SELECT 
		"YEAR",CAST("MONTH"AS VARCHAR)AS "MONTH","SUM_PRICE","CUM_SUM"
	FROM DATA
	UNION ALL
	SELECT 
		"YEAR" ,'GRANDTOTAL'AS "MONTH",NULL,MAX("CUM_SUM")
	FROM DATA
	GROUP BY "YEAR"
	ORDER BY "YEAR",4

GO

--9
SELECT D.Name,E.BusinessEntityID AS EMPLOYEEID,
	CONCAT_WS(' ', P.FirstName,P.LastName)AS "EMPLOYEE'SFULLNAME",E.HireDate,
	DATEDIFF(MM,HireDate,GETDATE()) AS SENIORITY,
	LEAD(CONCAT_WS(' ', P.FirstName,P.LastName),1)OVER(PARTITION BY D.NAME ORDER BY (DATEDIFF(MM,HireDate,GETDATE()))) AS PREVEMPNAME,
	LEAD(HireDate,1) OVER(PARTITION BY D.NAME ORDER BY HIREDATE DESC) AS PREVEMPHDATE,
	DATEDIFF(DD,LEAD(HireDate,1) OVER(PARTITION BY D.NAME ORDER BY HIREDATE DESC),HIREDATE)AS DIFFDAYS
FROM HumanResources.Employee E JOIN Person.Person P
ON E.BusinessEntityID=P.BusinessEntityID JOIN HumanResources.EmployeeDepartmentHistory EH
ON P.BusinessEntityID=EH.BusinessEntityID JOIN HumanResources.Department D
ON EH.DepartmentID=D.DepartmentID
ORDER BY D.NAME

GO

--10
SELECT 
     E.HireDate AS HireDate,
	 D.DepartmentID AS DepartmentID,
    STUFF((
        SELECT  ', ' + CONCAT_WS(' ', P1.BusinessEntityID, P1.LastName, P1.FirstName)
        FROM 
            Person.Person P1 
            JOIN HumanResources.Employee E1 ON P1.BusinessEntityID = E1.BusinessEntityID 
            JOIN HumanResources.EmployeeDepartmentHistory D1 ON E1.BusinessEntityID = D1.BusinessEntityID
        WHERE 
            E.HireDate = E1.HireDate
            AND  D.DepartmentID =  D1.DepartmentID 
        FOR XML PATH ('')), 1, 2, '') AS TEAMEMPLOYEES
FROM 
    HumanResources.Employee E 
    JOIN Person.Person P ON E.BusinessEntityID = P.BusinessEntityID 
    JOIN HumanResources.EmployeeDepartmentHistory D ON E.BusinessEntityID = D.BusinessEntityID
	WHERE EndDate IS NULL
GROUP BY
	E.HireDate,
    D.DepartmentID
ORDER BY 
    E.HireDate DESC;

GO