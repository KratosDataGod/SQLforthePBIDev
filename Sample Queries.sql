


/*BASIC SELECT*/

SELECT [EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[MiddleName]
      ,[Title]
      ,[TitleOfCourtesy]
      ,[BirthDate]
      ,[HireDate]
      ,[TerminationDate]
      ,[RehireDate]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[HomePhone]
      ,[Extension]
      ,[Notes]
      ,[ReportsTo]
      ,[PhotoPath]
      ,[EmployeeStatusID]
  FROM dbo.[Employees]

/*SELECT with Alias & Calculated value*/
SELECT EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName] as EmpName
      ,EMP.[Title]
      ,EMP.[TitleOfCourtesy]
      ,EMP.[BirthDate]
      ,EMP.[HireDate]
      ,EMP.[TerminationDate]
      ,EMP.[RehireDate]
      ,EMP.[Address]
      ,EMP.[City]
      ,EMP.[Region]
      ,EMP.[PostalCode]
      ,EMP.[Country]
      ,EMP.[HomePhone]
      ,EMP.[Extension]
      ,EMP.[Notes]
      ,EMP.[ReportsTo]
      ,EMP.[PhotoPath]
      ,EMP.[EmployeeStatusID]
	  --SELECT COUNT(*)
  FROM dbo.[Employees] EMP
  


  /*SELECT with JOIN*/
  SELECT EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName] as EmpName
      ,EMP.[MiddleName]
      ,EMP.[Title]
      ,EMP.[TitleOfCourtesy]
      ,EMP.[BirthDate]
      ,EMP.[HireDate]
      ,EMP.[TerminationDate]
      ,EMP.[RehireDate]
      ,EMP.[Address]
      ,EMP.[City]
      ,EMP.[Region]
      ,EMP.[PostalCode]
      ,EMP.[Country]
      ,EMP.[HomePhone]
      ,EMP.[Extension]
      ,EMP.[Notes]
      ,EMP.[ReportsTo]
      ,EMP.[PhotoPath]
      --,EMP.[EmployeeStatusID]
	  ,EMPSTAT.StatusName
	  --SELECT COUNT(*)
  FROM dbo.[Employees] EMP
  INNER JOIN dbo.[EmployeeStatus] EMPSTAT
	ON EMP.EmployeeStatusID = EMPSTAT.StatusID

/*Aggregation*/

  SELECT SUM(ORDDET.[Quantity]) AS [Quantity]

      ,SUM(ORDDET.[LineTotal]) AS [LineTotal]


FROM dbo.[Orders] ORD
INNER JOIN dbo.[OrderDetails] ORDDET
	ON ORD.OrderID = ORDDET.OrderID


 /*Validation Sales*/
  SELECT EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName] as EmpName

	  ,SUM(ORDDET.[Quantity]) AS [Quantity]

      ,SUM(ORDDET.[LineTotal]) AS [LineTotal]


FROM dbo.[Orders] ORD
INNER JOIN dbo.[OrderDetails] ORDDET
	ON ORD.OrderID = ORDDET.OrderID

INNER JOIN dbo.Employees EMP
	ON ORD.EmployeeID = EMP.EmployeeID

LEFT JOIN dbo.Regions EmpReg
	ON EMP.Region = EmpReg.RegionName


GROUP BY EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName]
ORDER BY EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName]


 /*Validation Supliers*/
  SELECT 
	  SUP.SupplierID
	 ,SUP.CompanyName
	  ,SUM(ORDDET.[Quantity]) AS [Quantity]

      ,SUM(ORDDET.[LineTotal]) AS [LineTotal]
FROM dbo.[Orders] ORD
INNER JOIN dbo.[OrderDetails] ORDDET
	ON ORD.OrderID = ORDDET.OrderID
INNER JOIN dbo.Products PROD
	ON ORDDET.ProductID = PROD.ProductID

INNER JOIN dbo.Suppliers SUP
	ON PROD.SupplierID = SUP.SupplierID

GROUP BY SUP.SupplierID
	 ,SUP.CompanyName
ORDER BY SUP.SupplierID
	 ,SUP.CompanyName



 /*Validation Sales & Supliers*/
  SELECT 
	  EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName] as EmpName
	  ,SUP.SupplierID
	 ,SUP.CompanyName
	  ,SUM(ORDDET.[Quantity]) AS [Quantity]

      ,SUM(ORDDET.[LineTotal]) AS [LineTotal]
FROM dbo.[Orders] ORD
INNER JOIN dbo.[OrderDetails] ORDDET
	ON ORD.OrderID = ORDDET.OrderID
INNER JOIN dbo.Products PROD
	ON ORDDET.ProductID = PROD.ProductID

INNER JOIN dbo.Suppliers SUP
	ON PROD.SupplierID = SUP.SupplierID
INNER JOIN dbo.Employees EMP
	ON ORD.EmployeeID = EMP.EmployeeID

GROUP BY EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName]
	  ,SUP.SupplierID
	 ,SUP.CompanyName
ORDER BY EMP.[EmployeeID]
      ,EMP.[LastName] + ', ' + EMP.[FirstName]
	  ,SUP.SupplierID
	 ,SUP.CompanyName




/*Central Fact Orders*/

SELECT ORD.[OrderID]
      ,ORD.[CustomerID]
      ,ORD.[EmployeeID]
	  ,EMP.EmployeeStatusID
	  ,EmpReg.RegionID
	  ,PROD.CategoryID
	  ,PROD.[ProductID]
	  ,SUP.SupplierID

      ,ORD.[OrderDate]
      ,ORD.[RequiredDate]
      ,ORD.[ShippedDate]
      ,ORD.[ShipVia]
      ,ORD.[Freight]
      ,ORD.[ShipName]
      ,ORD.[ShipAddress]
      ,ORD.[ShipCity]
      ,ORD.[ShipRegion]
      ,ORD.[ShipPostalCode]
      ,ORD.[ShipCountry]

      ,ORDDET.[UnitPrice]
      ,ORDDET.[Quantity]
      ,ORDDET.[Discount]
      ,ORDDET.[LineTotal]
	  --SELECT COUNT(*)
FROM dbo.[Orders] ORD
INNER JOIN dbo.[OrderDetails] ORDDET
	ON ORD.OrderID = ORDDET.OrderID
INNER JOIN dbo.Products PROD
	ON ORDDET.ProductID = PROD.ProductID

INNER JOIN dbo.Suppliers SUP
	ON PROD.SupplierID = SUP.SupplierID

INNER JOIN dbo.Employees EMP
	ON ORD.EmployeeID = EMP.EmployeeID

LEFT JOIN dbo.Regions EmpReg
	ON EMP.Region = EmpReg.RegionName


/*Detail Table*/

SELECT ORD.OrderID
	  ,CUST.CustomerID
	  ,CUST.CompanyName
	  ,CUST.ContactName
	  ,CUST.Address
	  ,CUST.City
	  ,CUST.Country
	  ,CUST.PostalCode
	  ,EMP.EmployeeID
	  ,EMP.EmployeeStatusID
	  ,EMP.FirstName + EMP.LastName as EmployeeName
	  ,EMP.Title
	  ,EMP_MGR.FirstName + EMP_MGR.LastName as ManagerName
	  ,EMP_MGR.Title
	  ,PROD.ProductID
	  ,PROD.CategoryID
	  ,PROD.[ProductID]
	  ,PROD.ProductName
	  ,PROD.ProductDescription
	  ,PROD.QuantityPerUnit
	  ,SUP.SupplierID
	  ,SUP.CompanyName as SupplierCompanyName
	  ,SUP.City as SupplierCity

      ,ORD.[OrderDate]
      ,ORD.[RequiredDate]
      ,ORD.[ShippedDate]
      ,ORD.[ShipVia]
      ,ORD.[Freight]
      ,ORD.[ShipName]
      ,ORD.[ShipAddress]
      ,ORD.[ShipCity]
      ,ORD.[ShipRegion]
      ,ORD.[ShipPostalCode]
      ,ORD.[ShipCountry]
      ,ORDDET.[Discount]

	  --Aggs
      ,ORDDET.[UnitPrice]
      ,ORDDET.[Quantity]
      ,ORDDET.[LineTotal]

	  --SELECT COUNT(*)
FROM dbo.[Orders] ORD
INNER JOIN dbo.[OrderDetails] ORDDET
	ON ORD.OrderID = ORDDET.OrderID

INNER JOIN dbo.Products PROD
	ON ORDDET.ProductID = PROD.ProductID

INNER JOIN dbo.Suppliers SUP
	ON PROD.SupplierID = SUP.SupplierID

INNER JOIN dbo.Employees EMP
	ON ORD.EmployeeID = EMP.EmployeeID

INNER JOIN model.Customers CUST
	ON ord.CustomerID = CUST.CustomerID

LEFT JOIN dbo.Regions EmpReg
	ON EMP.Region = EmpReg.RegionName

LEFT JOIN model.Employees EMP_MGR
	ON EMP.ReportsTo = EMP_MGR.EmployeeID


WHERE DATEADD( D, 14, ORD.[OrderDate]) <=  ORD.[ShippedDate]