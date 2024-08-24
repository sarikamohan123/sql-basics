

---Exercises:
--1. Write a SELECT statement that returns all columns from the Vendors table inner-joined with the Invoices table.

SELECT * FROM Vendors 
JOIN Invoices 
ON Vendors.VendorID = Invoices.VendorID; 

---another way with alias
SELECT * FROM Vendors V
JOIN Invoices I
ON V.VendorID = I.VendorID; 

select * from Vendors;
select * from Invoices;
select * from GLAccounts;
select * from InvoiceLineItems;



--2.Write a SELECT statement that returns four columns: VendorName InvoiceNumber InvoiceDate Balance
------From the Vendors table From the Invoices table From the Invoices table
------InvoiceTotal minus the sum of PaymentTotal and CreditTotal
--The result set should have one row for each invoice with a non-zero balance. Sort the result set by VendorName in ascending order

     SELECT InvoiceNumber, VendorName, InvoiceDate, InvoiceTotal - PaymentTotal - CreditTotal AS Balance
     FROM Vendors 
     JOIN Invoices
      ON Vendors.VendorID = Invoices.VendorID 
      WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0 
      ORDER BY InvoiceDueDate Asc;

	  ---3  

	  SELECT AccountDescription, DefaultAccountNo ,VendorName
	  from GLAccounts
	  join Vendors
	  on  Vendors.defaultaccountno = GLAccounts.accountno;

	  ---4  Implicit join

	  SELECT  AccountDescription, DefaultAccountNo ,VendorName
	  FROM Vendors v, GLAccounts g
	  WHERE v.DefaultAccountNo = g.AccountNo;


	  --5 joining three tables

	  SELECT VendorName as vendor, InvoiceNumber as number, InvoiceDate as date, InvoiceLineItemAmount as lineitem ,InvoiceSequence as #
	  FROM Vendors v
      JOIN Invoices i
       ON v.VendorID = i.VendorID
	   JOIN InvoiceLineItems li
       ON i.InvoiceID = li.InvoiceID 
      ORDER BY VendorName, InvoiceDate, InvoiceNumber, InvoiceSequence;


	  --6 Self join

	  SELECT DISTINCT v1.VendorName, v1.VendorID, v1.VendorContactFName + ' ' + v1.VendorContactLName  as name
	  FROM Vendors v1 
	  JOIN Vendors v2
      ON v1.VendorID = v2.Vendorid
      ORDER BY name;

	  
	--  7 outer join

	-- Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription. 
	--The result set should have one row for each account number that has never been used.

	

   SELECT g.AccountNo, g.AccountDescription
FROM GLAccounts g
LEFT JOIN InvoiceLineItems li 
ON g.AccountNo = li.AccountNo
WHERE li.AccountNo IS NULL
ORDER BY g.AccountNo;


   select distinct AccountNo FROM GLAccounts where AccountNo not in (select AccountNo from InvoiceLineItems) ;

   ---8. Union

  --  Use the UNION operator to generate a result set consisting of two columns from the Vendors table: VendorName and VendorState.
	--If the vendor is in California, the VendorState value should be “CA”; otherwise, the VendorState value should be “Outside CA.” Sort the final result set by VendorName.



	SELECT  VendorName,VendorState as 'CA'
   FROM Vendors
    WHERE VendorState = 'CA'
	    UNION
    SELECT   VendorName,   'outside CA' as VendorState 
   FROM Vendors
   WHERE VendorState != 'CA'
   ORDER BY VendorName;
