/* THIS PROJECT SHOWS THE CAR SALES OF THE YEAR 2021-2022 DIVIDED INTO THEIR CORRESPONDING CATEGORIES, MANUFACTURER, BRAND NAME AND MODELS*/




USE MASTER
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME= 'PRO2')
	DROP DATABASE PRO2;
GO

CREATE DATABASE PRO2
GO

USE PRO2

CREATE TABLE MAKER ("NAME" VARCHAR (25)NOT NULL,
						COUNTRY VARCHAR(25),
						CONSTRAINT MAKER_NAME_PK PRIMARY KEY("NAME")
						)
GO						

CREATE TABLE BRAND (MAKER VARCHAR(25) NOT NULL,
					BNAME VARCHAR(25)NOT NULL,
					COUNTRY VARCHAR(25),
					CONSTRAINT BRAND_BNAME_PK PRIMARY KEY (BNAME),
					CONSTRAINT BRAND_MAKERNAME_FK FOREIGN KEY (MAKER) REFERENCES MAKER ("NAME")
					)
GO

CREATE TABLE CATEGORY (CATEGORYID INT,
						CATEGORYNAME VARCHAR(120),
						CONSTRAINT CATEGORY_CATEGORYNAME_PK PRIMARY KEY (CATEGORYNAME)
						)
GO

CREATE TABLE MODEL (BRAND_NAME VARCHAR (25)NOT NULL,
					MODELNAME VARCHAR(25) NOT NULL,
					CATEGORY VARCHAR(120)NOT NULL,
					[YEAR REVEALED] VARCHAR(4),
					CONSTRAINT MODEL_MODELNAME_PK PRIMARY KEY (MODELNAME),
					CONSTRAINT MODEL_BRANDNAME_FK FOREIGN KEY (BRAND_NAME) REFERENCES BRAND (BNAME),
					CONSTRAINT MODEL_CATEGORY_FK FOREIGN KEY (CATEGORY) REFERENCES CATEGORY(CATEGORYNAME)
					)
GO

CREATE TABLE SALES (CARMAKER VARCHAR(25) NOT NULL,
					BRAND VARCHAR(25)NOT NULL,
					MODEL VARCHAR(25) NOT NULL,
					TOTAL INT NOT NULL,
					SALESLY INT NOT NULL,
					JANUARY INT,
					FEBRUARY INT,
					MARCH INT,
					APRIL INT,
					MAY INT,
					JUNE INT,
					JULY INT,
					AUGUST INT,
					SEPTEMBER INT,
					OCTOBER INT,
					NOVEMBER INT,
					DECEMBER INT,
					CONSTRAINT SALES_BRAND_FK FOREIGN KEY (BRAND) REFERENCES BRAND (BNAME),
					CONSTRAINT SALES_MODEL_FK FOREIGN KEY (MODEL) REFERENCES MODEL (MODELNAME)
					)
GO				

INSERT INTO MAKER
VALUES  ('VOLKSWAGEN GROUP','GERMANY'),
		('BMW GROUP','GERMANY'),
		('FORD MOTOR COMPANY','USA'),
		('GENERAL MOTORS','USA'),
		('JEEP','USA'),
		('HYUNDAI MOTOR GROUP','SOUTHKOREA'),
		('MAZDA MOTOR CORPORATION','JAPAN'),
		('DAIMLER AG','GERMANY'),
		('TESLA INC.','USA'),('TOYOTA MOTOR CORP','JAPAN')
GO
		
INSERT INTO BRAND 
VALUES
		('VOLKSWAGEN GROUP','AUDI','GERMANY'),('BMW GROUP','BMW','GERMANY'),
		('FORD MOTOR COMPANY','FORD','USA'),
		('HYUNDAI MOTOR GROUP','HYUNDAI','SOUTHKOREA'),
		('HYUNDAI MOTOR GROUP','KIA','SOUTHKOREA'),
		('GENERAL MOTORS','CHEVROLET','USA'),
		('JEEP','JEEP','USA'),
		('MAZDA MOTOR CORPORATION','MAZDA','JAPAN'),
		('DAIMLER AG','MERCEDES-BENZ','GERMANY'),
		('TESLA INC.','TESLA','USA'),
		('TOYOTA MOTOR CORP','TOYOTA','JAPAN'),('VOLKSWAGEN GROUP','VW','GERMANY')
GO

INSERT INTO CATEGORY
VALUES  (1,'COMPACT CAR'),
		(2,'MID-SIZE CAR'),
		(3,'COMPACT EXECUTIVE'),
		(4,'EXECUTIVE'),
		(5,'SUBCOMPACT CROSSOVER SUV'),
		(6,'COMPACT CROSSOVER SUV'),
		(7,'SUBCOMPACT LUXURY CROSSOVER SUV'),
		(8,'COMPACT LUXURY CROSSOVER SUV'),
		(9,'LUXURY COMPACT SUV'),
		(10,'MID-SIZE CROSSOVER SUV'),
		(11,'MID-SIZE LUXURY CROSSOVER SUV'),
		(12,'PICKUP TRUCK')

GO

INSERT INTO MODEL
VALUES 
('AUDI','A5','COMPACT EXECUTIVE',2017),
('AUDI','Q3','SUBCOMPACT LUXURY CROSSOVER SUV',2018),
('AUDI','Q5','LUXURY COMPACT SUV',2021),
('BMW','4-SERIES','COMPACT EXECUTIVE',2020),
('BMW','X3','COMPACT LUXURY CROSSOVER SUV ',2017),
('BMW','X5','MID-SIZE LUXURY CROSSOVER SUV',2019),
('CHEVROLET','SILVERADO','PICKUP TRUCK',2017),
('CHEVROLET','EQUINOX','COMPACT CROSSOVER SUV',2018),
('CHEVROLET','MALIBU','MID-SIZE CAR',2016),
('FORD','F-SERIES','PICKUP TRUCK',2021),
('FORD','EXPLORER','MID-SIZE CROSSOVER SUV',2020),
('FORD','ESCAPE','COMPACT CROSSOVER SUV',2020),
('HYUNDAI','TUCSON','COMPACT CROSSOVER SUV',2020),
('HYUNDAI','ELANTRA','COMPACT CAR',2020),
('HYUNDAI','SANTA FE','MID-SIZE CROSSOVER SUV',2018),
('JEEP','GRAND CHEROKEE','MID-SIZE CROSSOVER SUV',2021),
('JEEP','WRANGLER','MID-SIZE CROSSOVER SUV',2017),
('JEEP','COMPASS','COMPACT CROSSOVER SUV',2016),
('KIA','SPORTAGE','COMPACT CROSSOVER SUV',2021),
('KIA','TELLURIDE','MID-SIZE CROSSOVER SUV',2019),
('KIA','FORTE','COMPACT CAR',2018),
('MAZDA','CX-30','SUBCOMPACT CROSSOVER SUV',2019),
('MAZDA','CX-5','COMPACT CROSSOVER SUV',2017),
('MAZDA','CX-9','MID-SIZE CROSSOVER SUV',2016),
('MERCEDES-BENZ','GLE-CLASS','MID-SIZE LUXURY CROSSOVER SUV',2019),
('MERCEDES-BENZ','C-CLASS','COMPACT EXECUTIVE',2021),
('MERCEDES-BENZ','GLC','COMPACT LUXURY CROSSOVER SUV',2015),
('TESLA','MODEL Y','MID-SIZE CROSSOVER SUV',2020),
('TESLA','MODEL 3','COMPACT EXECUTIVE',2017),
('TESLA','MODEL S','EXECUTIVE',2012),
('TOYOTA','CAMRY','MID-SIZE CAR',2017),
('TOYOTA','HIGHLANDER','MID-SIZE CROSSOVER SUV',2019),
('TOYOTA','RAV4','COMPACT CROSSOVER SUV',2018),
('VW','TAOS','COMPACT CROSSOVER SUV',2018),
('VW','TIGUAN','COMPACT CROSSOVER SUV',2016),
('VW','ATLAS','MID-SIZE CROSSOVER SUV',2017)

GO

INSERT INTO SALES
VALUES 
('VOLKSWAGEN GROUP','AUDI','A5',18349,17128,1229,1229,1383,1635,1574,1574,1630,1693,1630,1591,1527,1654),
('VOLKSWAGEN GROUP','AUDI','Q3',23045,34464,1676,1676,1885,2183,2102,2102,2307,366,2307,2147,2061,2233),
('VOLKSWAGEN GROUP','AUDI','Q5',57053,60299,3318,3318,3732,5339,5141,5141,5642,0,5642,6593,6330,6857),
('BMW GROUP','BMW','4-SERIES',36952,22938,2361,2361,2656,2271,2187,2187,3086,3205,3086,4517,4337,4698),
('BMW GROUP','BMW','X3',65800,75858,4462,4461,5019,6395,6158,6158,6073,6307,6073,4898,4702,5094),
('BMW GROUP','BMW','X5',82373,60724,5273,5273,5932,6510,6269,6269,6937,7204,6937,8590,8246,8933),
('GENERAL MOTORS','CHEVROLET','SILVERADO',520936,529765,38754,38754,43599,48094,46313,46313,38571,40055,38571,47304,45412,49196),
('GENERAL MOTORS','CHEVROLET','EQUINOX',212072,165325,17932,17932,20173,20726,19958,19958,15352,15942,15352,16249,15599,16899),
('GENERAL MOTORS','CHEVROLET','MALIBU',115468,39376,8218,8218,9246,11103,10692,10692,7119,7393,7119,11889,11414,12365),
('FORD MOTOR COMPANY','FORD','F-SERIES',653957,726003,50543,45252,44906,51517,49454,57673,63341,58283,46338,56405,55169,75076),
('FORD MOTOR COMPANY','FORD','EXPLORER',207763,219871,16255,9566,16915,20801,19594,19786,17763,19076,16577,15887,16440,19103),
('FORD MOTOR COMPANY','FORD','ESCAPE',137370,145415,13120,11706,15136,15502,8899,9557,9854,13272,12265,9966,8893,9200),
('HYUNDAI MOTOR GROUP','HYUNDAI','TUCSON',175307,140721,13085,12928,13642,14616,14152,15648,14278,14305,12971,15066,16059,18557),
('HYUNDAI MOTOR GROUP','HYUNDAI','ELANTRA',117177,127360,5081,6786,10205,10669,7731,8372,12021,14238,10761,8530,11040,11743),
('HYUNDAI MOTOR GROUP','HYUNDAI','SANTA FE',115226,112705,2991,8104,10124,11074,10548,10691,9532,9510,9192,10806,10955,11699),
('HYUNDAI MOTOR GROUP','KIA','SPORTAGE',124244,88688,5993,2689,7778,11380,10363,14153,11985,11985,12412,11877,10554,13075),
('HYUNDAI MOTOR GROUP','KIA','TELLURIDE',99564,93705,6790,7618,7668,8233,7398,9186,8318,8318,8440,8179,8558,10858),
('HYUNDAI MOTOR GROUP','KIA','FORTE',97303,113051,5748,8141,9609,9798,9211,0,10016,10016,8404,8942,9725,7693),
('JEEP','JEEP','GRAND CHEROKEE',223344,254445,24037,24037,27042,20251,19501,19501,12564,13047,12564,16933,16256,17611),
('JEEP','JEEP','WRANGLER',181410,204610,14579,14576,16398,18437,17754,17754,15685,16289,15685,11418,10961,11874),
('JEEP','JEEP','COMPASS',86175,75642,7811,7811,8787,7494,7216,7216,6790,7051,6790,6403,6147,6659),
('MAZDA MOTOR CORPORATION','MAZDA','CX-30',52808,55180,6024,8063,8003,9000,5742,6053,3795,2052,1520,2499,3150,2032),
('MAZDA MOTOR CORPORATION','MAZDA','CX-5',151594,163940,12604,16404,21645,16404,8093,6654,11009,12920,10216,9441,12692,13512),
('MAZDA MOTOR CORPORATION','MAZDA','CX-9',34580,31803,2512,3803,4148,3107,1453,1157,1919,2106,3264,3391,4025,3695),
('DAIMLER AG','MERCEDES-BENZ','GLE-CLASS',57933,65073,6024,8063,8003,9000,5742,6053,3795,2052,1520,2499,3150,2032),
('DAIMLER AG','MERCEDES-BENZ','C-CLASS',26161,30816,158,158,178,2926,2847,2847,2955,3069,2955,2689,2582,2797),
('DAIMLER AG','MERCEDES-BENZ','GLC',65531,51805,5274,4475,1469,1900,15165,2650,361,3177,3148,17636,3471,6805),
('TESLA INC.','TESLA','MODEL Y',225799,161527,18797,18101,18101,18114,17443,17443,17772,18456,17772,21267,20416,22117),
('TESLA INC.','TESLA','MODEL 3',195698,121610,13739,13230,13230,17054,16423,16423,15797,16405,15797,19200,18432,19968),
('TESLA INC.','TESLA','MODEL S',90473,11556,3930,3785,57158,3008,2896,2896,2633,2734,2633,2933,2816,3051),
('TOYOTA MOTOR CORP','TOYOTA','CAMRY',295201,313795,19665,15612,26228,26323,24905,23192,25119,25500,27859,29707,25185,25906),
('TOYOTA MOTOR CORP','TOYOTA','HIGHLANDER',222805,264128,17161,22949,25916,19788,15619,15970,12529,14776,19743,17962,20145,20247),
('TOYOTA MOTOR CORP','TOYOTA','RAV4',366741,407739,29457,34407,37328,33610,32883,0,37749,32390,32317,35089,28022,33489),
('VOLKSWAGEN GROUP','VW','TAOS',50371,31703,4376,4376,4923,4881,4700,4700,6214,6453,6214,1178,1131,1225),
('VOLKSWAGEN GROUP','VW','TIGUAN',71085,109742,5835,5835,6564,6013,6745,6745,8428,8752,8428,2580,2477,268),
('VOLKSWAGEN GROUP','VW','ATLAS',43900,72383,5005,4520,4826,3200,6805,5248,3795,2951,2801,1498,1120,2131)
GO

