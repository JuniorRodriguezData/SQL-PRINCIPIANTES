/*========================================
	APLICACIÓN EN LA BASE NORTHWIND
==========================================*/
use Northwind

--1.- Listado de clientes que tengan como primer caracter la letra A en el nombre
	SELECT*FROM Customers

	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE 'A%'

--2.-Listado de clientes que tengan como último caracter la letra A en el nombre
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE '%A'

--3.-Listado de clientes que tengan al menos la letra A en el nombre
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE '%A%'

--4.- Listado de clientes que tengan como primer y último caracter la letra A en el nombre
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE 'A%A'

--5.- Listado de clientes que tengan como tercer caracter la letra A
	SELECT C.CompanyName 'Nombre del cliente'
	FROM Customers as C
	WHERE C.CompanyName LIKE '__A%'

--6.- Listado de clientes que comiencen con las letras A,B,C,D,E,F
	--i) Primera forma
		SELECT C.CompanyName 'Nombre del cliente'
		FROM Customers as C
		WHERE C.CompanyName LIKE '[ABCDEF]%'

	--ii) Segunda forma
		SELECT C.CompanyName 'Nombre del cliente'
		FROM Customers as C
		WHERE C.CompanyName LIKE '[A-F]%'

--7.- Listado de clientes que comiencen con la letra H y terminen en una vocal
		SELECT CompanyName
		FROM Customers
		WHERE CompanyName LIKE 'H%[AEIOU]'

--8.- Listado de empleados : código, nombre y apellido (en una sola columna), fecha de nac. y fecha de contrato
	SELECT*FROM Employees

	SELECT E.EmployeeID 'Código de empleado',
			E.FirstName + ' ' + E.LastName 'Nombre completo',
			E.BirthDate 'Fecha de nacimiento',
			E.HireDate 'Fecha de contrato'
	FROM Employees AS E

/*------------------------------------
		Funciones de fecha
---------------------------------------*/
--1.- Fecha actual
SELECT GETDATE() 'Fecha y hora'

--2.- Formato de fecha
	--i) 103---> DD/MM/YYYY
		SELECT CONVERT(VARCHAR(10), GETDATE(),103)

	--ii) 104---> DD.MM.YYYY
		SELECT CONVERT(VARCHAR(10), GETDATE(),104)

	--iii) 105---> DD-MM-YYYY
		SELECT CONVERT(VARCHAR(10), GETDATE(),105)

--3.- Diferencias de fechas
	--SELECT DATEDIFF (Periodo, Fecha inicial, Fecha final)
		/* Diario (entre días)---> DAY
		   Mensual (entre meses) ---> MONTH
		   Anual (entre años) ---> YEAR
		   Semanal (entre semanas) ---> WEEK
		   Trimestral (entre trimestres)---> QUARTER*/

	SELECT DATEDIFF (DAY, '07/18/2022','10/17/2022')
/*============================
	APLICACIÓN EN NORTHWIND
==============================*/
USE Northwind

--1.- Listar órdenes realizas en el año 1997
	SELECT*FROM Orders

	SELECT*FROM Orders
	WHERE DATEPART(YEAR,OrderDate)=1997

--2.- Listado de órdenes realizadas en el mes de agosto del año 1997
	SELECT*FROM Orders
	WHERE DATEPART(YEAR,OrderDate) = 1997
		  AND DATEPART(MONTH,OrderDate) = 8

--3.- Listado de órdenes realizados la primera quincena del mes de enero del año 1998
	SELECT*FROM Orders
	WHERE DATEPART(YEAR,OrderDate)=1998
		  AND DATEPART(MONTH,OrderDate) = 1
		  AND DATEPART(DAY,OrderDate)<=15

--4.- Listado de órdenes emitidas un martes 13 o domingo 7
	SET LANGUAGE SPANISH --- Cambiar el idioma
	PRINT DATENAME(MONTH,GETDATE()) --- Imprimir el mes
	PRINT DATENAME(WEEKDAY,GETDATE()) ---Imprimir el día

	SELECT*FROM Orders
	WHERE (DATEPART(DAY,OrderDate)='13' AND DATENAME(WEEKDAY,OrderDate)='Martes')
		OR (DATEPART(DAY,OrderDate)='7' AND DATENAME(WEEKDAY,OrderDate)='Domingo')

--5.- Listado de órdenes realizadas en el mes de Octubre de los años 1996 y 1998
	SELECT*FROM Orders
	WHERE DATEPART(MONTH,OrderDate) = 10
		  AND DATEPART(YEAR,OrderDate) IN (1996,1998)

/*----------------------
	Otras consultas
-------------------------*/
--1.- DISTINCT (Valores únicos)
	SELECT*FROM Customers

	--Lista de valores únicos en países
	 SELECT DISTINCT(Country) 'Países'
	 FROM Customers 

--2.- Hallar el precio con IGV(18%) en productos
	SELECT*FROM Products

	SELECT ProductName 'Nombre del producto',
		   UnitPrice 'Precio',
		   (UnitPrice*1.18) 'Precio con IGV'
	FROM Products

--3.- Hallar el subtotal (por fila) en la tabla Order Details
	SELECT*FROM [Order Details]

	SELECT ProductID 'Código de producto',
		   UnitPrice 'Precio unitario',
		   Quantity 'Cantidad',
		   (UnitPrice*Quantity) 'Subtotal'
	FROM [Order Details]

--4.- Hallar el monto del descuento
	SELECT ProductID 'Código de producto',
		   UnitPrice 'Precio unitario',
		   Quantity 'Cantidad',
		   (UnitPrice*Quantity) 'Subtotal',
		   (UnitPrice*Quantity*Discount) 'Descuento'
	FROM [Order Details]

--5.- Hallar el monto real pagado por el cliente
	SELECT ProductID 'Código de producto',
		   UnitPrice 'Precio unitario',
		   Quantity 'Cantidad',
		   (UnitPrice*Quantity) 'Subtotal',
		   (UnitPrice*Quantity*Discount) 'Descuento',
		   (UnitPrice*Quantity*(1-Discount)) 'Monto neto total'
	FROM [Order Details]

--6.- Obtener nombre de compáñía, dirección y ciudad de clientes en México
	SELECT*FROM Customers

	SELECT C.CompanyName 'Compañía', C.Address 'Dirección', C.City 'Ciudad'
	FROM Customers as C
	WHERE C.Country = 'Mexico'

--7.- Obtener nombre de compáñía, dirección, ciudad y teléfono de clientes de México o Argentina
	SELECT C.CompanyName 'Compañía', C.Address 'Dirección', C.City 'Ciudad', C.Phone 'Teléfono'
	FROM Customers AS C
	WHERE C.Country='Mexico' OR C.Country='Argentina'

--8.- Listar clientes que sean dueños del negocio para los países de Venezuela y Francia
	SELECT*FROM Customers AS C
	WHERE C.ContactTitle='Owner'
			AND C.Country IN ('Venezuela','Francia')

--9.- Seleccionar productos de la categoría 1,2,3 y 4
	SELECT*FROM Products

	---Primera forma
		SELECT*FROM Products
			WHERE CategoryID='1'
					OR CategoryID='2'
						OR CategoryID='3'
							OR CategoryID='4'
		ORDER BY CategoryID

	--Segunda forma
		SELECT*FROM Products
		WHERE CategoryID IN (1,2,3,4)
		ORDER BY CategoryID

	--Tercera forma
		SELECT*FROM Products
		WHERE CategoryID BETWEEN 1 AND 4
		ORDER BY CategoryID