Spool RyanEggertExam2.txt;

SET ECHO ON;

SET SERVEROUTPUT ON;

CLEAR SCR;

--@0000-main.sql;

--Q1.C

CREATE TABLE PRODUCT ( 
	ProductID 	NUMBER NOT NULL,
	ItemDescription	CHAR (255) NOT NULL,
	Category	CHAR (25) NOT NULL,
CONSTRAINT ProductID_PK PRIMARY KEY (ProductID)
);

DESCRIBE PRODUCT;

--Q1.E

DESCRIBE SHIPMENT_ITEM;

CREATE TABLE SHIPMENT_LINE_ITEM (
	ShipmentID		NUMBER (38)	NOT NULL,
	ShipmentLineNumber	NUMBER (38) 	NOT NULL,
	ItemID			NUMBER (38) 	NOT NULL,
	InsuredValue		NUMBER (12,2) 	NOT NULL,
CONSTRAINT SHIPMENTID_PK PRIMARY KEY (ShipmentID, ShipmentLineNumber),
CONSTRAINT ITEMID_FK	FOREIGN KEY (ItemID) REFERENCES PURCHASE_ITEM(PurchaseItemID)
);

DESCRIBE SHIPMENT_LINE_ITEM;

SELECT CONSTRAINT_NAME
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'SHIPMENT_ITEM';

ALTER TABLE SHIPMENT_ITEM
	DROP CONSTRAINT SHIP_ITEM_PURCHASE_ITEM_FK;

ALTER TABLE SHIPMENT_ITEM
	DROP CONSTRAINT SHIP_ITEM_SHIP_FK;

INSERT INTO SHIPMENT_LINE_ITEM (SHIPMENTID, SHIPMENTLINENUMBER, ITEMID, INSUREDVALUE)
	SELECT SHIPMENTID, SHIPMENTITEMID, ITEMID, INSUREDVALUE
FROM SHIPMENT_ITEM;

DESCRIBE SHIPMENT_LINE_ITEM;
SELECT * FROM SHIPMENT_LINE_ITEM;

DROP TABLE SHIPMENT_ITEM;

DESCRIBE SHIPMENT_ITEM;


--Q1.G

CREATE VIEW MajorSourcesView AS
	SELECT 		StoreName, TotalPurchases
	FROM 		StoreHistoryView
	WHERE		TotalPurchases > 100000;

DESCRIBE MAJORSOURCESVIEW;
	
SELECT * FROM MajorSourcesView;

--Q1.F

CREATE OR REPLACE FUNCTION STORECONTACTANDPHONE (varContact CHAR, varPhone CHAR)
RETURN Varchar AS
varStoreContact VARCHAR(66);
BEGIN
varStoreContact := (RTRIM(varContact)||': '||RTRIM(varPhone));
RETURN varStoreContact;
END;
/

DESCRIBE STORECONTACTANDPHONE;
SELECT STORECONTACTANDPHONE(CONTACT, PHONE) AS CONTACTINFO
FROM STORE;

SET SERVEROUTPUT OFF;

SET ECHO OFF;

SPOOL OFF;
