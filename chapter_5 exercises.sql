--chapter 5


1.

SELECT VendorID, SUM(PaymentTotal) AS PaymentSum
FROM Invoices
GROUP BY VendorID;

2. 

SELECT TOP 10 VendorName, SUM(PaymentTotal) AS PaymentSum
FROM Vendors v 
  JOIN Invoices i
    ON v.VendorID = i.VendorID
GROUP BY VendorName
ORDER BY PaymentSum DESC;



3

SELECT VendorName, COUNT(*) AS InvoiceCount,
       SUM(InvoiceTotal) AS InvoiceSum
FROM Vendors v 
  JOIN Invoices i
    ON v.VendorID = i.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC;

4

SELECT gl.AccountDescription, COUNT(*) AS LineItemCount,
       SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts gl
  JOIN InvoiceLineItems li
    ON gl.AccountNo = li.AccountNo
GROUP BY gl.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;

5

SELECT gl.AccountDescription, COUNT(*) AS LineItemCount,
       SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts gl
  JOIN InvoiceLineItems li
    ON gl.AccountNo = li.AccountNo
  JOIN Invoices i
    ON li.InvoiceID = i.InvoiceID
WHERE InvoiceDate BETWEEN '2022-10-01' AND '2022-12-31'
GROUP BY gl.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;


6

SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY AccountNo WITH ROLLUP;

7
SELECT VendorName, AccountDescription, COUNT(*) AS LineItemCount,
       SUM(InvoiceLineItemAmount) AS LineItemSum
FROM Vendors v 
  JOIN Invoices i
   ON v.VendorID = i.VendorID
 JOIN InvoiceLineItems li
   ON i.InvoiceID = li.InvoiceID
 JOIN GLAccounts gl
   ON li.AccountNo = gl.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName, AccountDescription;


8
SELECT VendorName,
       COUNT(DISTINCT li.AccountNo) AS [# of Accounts]
FROM Vendors v 
  JOIN Invoices i
    ON v.VendorID = i.VendorID
  JOIN InvoiceLineItems li
    ON i.InvoiceID = li.InvoiceID
GROUP BY VendorName
HAVING COUNT(DISTINCT li.AccountNo) > 1
ORDER BY VendorName;

9
SELECT VendorID, InvoiceDate, InvoiceTotal,
    SUM(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorTotal,
    COUNT(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorCount,
    AVG(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorAvg
FROM Invoices;







