DROP TABLE FEE CASCADE CONSTRAINTS;
DROP TABLE COMPETETIVETEAMBILLING CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE PARENT CASCADE CONSTRAINTS;
DROP TABLE MERCHSALE CASCADE CONSTRAINTS;
DROP TABLE GYMMERCHANDISE CASCADE CONSTRAINTS;
DROP TABLE GYMNASTICSSTUDENT CASCADE CONSTRAINTS;
DROP TABLE GYMNASTICSCLASS CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE COMPETETIVESTUDENT CASCADE CONSTRAINTS;
DROP TABLE COMPETETIVETEAM CASCADE CONSTRAINTS;
DROP TABLE GYMNASTICSMEET CASCADE CONSTRAINTS;
DROP TABLE CHEERSTUDENT CASCADE CONSTRAINTS;
DROP TABLE CHEERLEADINGCLASS CASCADE CONSTRAINTS;

CREATE TABLE cheerleadingclass (
    "CheerleaderClassNo." CHAR(10) NOT NULL,
    classtimings          VARCHAR2(50),
    classprice            NUMBER(5, 2),
    classlevel            VARCHAR2(10),
    employee_employeeid   CHAR(10) NOT NULL
);

ALTER TABLE cheerleadingclass ADD CONSTRAINT cheerleadingclass_pk PRIMARY KEY ( "CheerleaderClassNo." );

CREATE TABLE cheerstudent (
    classdays                               VARCHAR2(20) NOT NULL, 
    "CHEERLEADINGCLASS_CheerleaderClassNo." CHAR(10) NOT NULL,
    student_studentid                       CHAR(10) NOT NULL,
    assessment                              VARCHAR2(50) NOT NULL,
    classlength                             VARCHAR2(20),
    skilllevel                              VARCHAR2(20)
);

ALTER TABLE cheerstudent
    ADD CONSTRAINT cheerstudent_pk PRIMARY KEY ( classdays,
                                                 "CHEERLEADINGCLASS_CheerleaderClassNo.",
                                                 student_studentid );

CREATE TABLE competetivestudent (
    classdays              VARCHAR2(20) NOT NULL,
    assessment             VARCHAR2(50) NOT NULL,
    classlength            VARCHAR2(20),
    student_studentid      CHAR(10) NOT NULL,
    competetiveteam_teamid CHAR(10) NOT NULL,
    skilllevel             VARCHAR2(20)
);

ALTER TABLE competetivestudent
    ADD CONSTRAINT competetivestudent_pk PRIMARY KEY ( classdays,
                                                       student_studentid,
                                                       competetiveteam_teamid );

CREATE TABLE competetiveteam (
    teamid              CHAR(10) NOT NULL,
    trainingtimes       VARCHAR2(50),
    teamlevel           VARCHAR2(10),
    employee_employeeid CHAR(10) NOT NULL
);

ALTER TABLE competetiveteam ADD CONSTRAINT competetiveteam_pk PRIMARY KEY ( teamid );

CREATE TABLE competetiveteambilling (
    billingid         CHAR(10) NOT NULL,
    fee_feeid         CHAR(10) NOT NULL,
    totalamount       NUMBER(5, 2),
    subtotal          NUMBER(5, 2),
    salestax          NUMBER(2, 2),
    student_studentid CHAR(10) NOT NULL
);

ALTER TABLE competetiveteambilling ADD CONSTRAINT competetiveteambilling_pk PRIMARY KEY ( billingid,
                                                                                          fee_feeid );

CREATE TABLE employee (
    employeeid   CHAR(10) NOT NULL,
    fname        VARCHAR2(20),
    lname        VARCHAR2(20),
    jobtitle     VARCHAR2(20),
    "ContactNo." CHAR(10),
    skilllevel   VARCHAR2(10)
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employeeid );

CREATE TABLE fee (
    feeid     CHAR(10) NOT NULL,
    type      VARCHAR2(20),
    feeamount NUMBER(5, 2),
    duedate   DATE
);

ALTER TABLE fee ADD CONSTRAINT fee_pk PRIMARY KEY ( feeid );

CREATE TABLE gymmerchandise (
    merchid  CHAR(10) NOT NULL,
    price    NUMBER(5, 2),
    type     VARCHAR2(20),
    quantity NUMBER(2)
);

ALTER TABLE gymmerchandise ADD CONSTRAINT gymmerchandise_pk PRIMARY KEY ( merchid );

CREATE TABLE gymnasticsclass (
    "GymnasticsClassNo." CHAR(10) NOT NULL,
    classtimings         VARCHAR2(50),
    classprice           NUMBER(5, 2),
    classlevel           VARCHAR2(10),
    employee_employeeid  CHAR(10) NOT NULL
);

ALTER TABLE gymnasticsclass ADD CONSTRAINT gymnasticsclass_pk PRIMARY KEY ( "GymnasticsClassNo." );

CREATE TABLE gymnasticsmeet (
    meetid                 CHAR(10) NOT NULL,
    time                   VARCHAR2(10),
    "Date"                 DATE,
    location               VARCHAR2(30),
    competetiveteam_teamid CHAR(10) NOT NULL
);

ALTER TABLE gymnasticsmeet ADD CONSTRAINT gymnasticsmeet_pk PRIMARY KEY ( meetid );

CREATE TABLE gymnasticsstudent (
    classdays                            VARCHAR2(20) NOT NULL, 
    "GYMNASTICSCLASS_GymnasticsClassNo." CHAR(10) NOT NULL,
    student_studentid                    CHAR(10) NOT NULL,
    assessment                           VARCHAR2(50) NOT NULL,
    classlength                          VARCHAR2(20),
    skilllevel                           VARCHAR2(20)
);

ALTER TABLE gymnasticsstudent
    ADD CONSTRAINT gymnasticsstudent_pk PRIMARY KEY ( classdays,
                                                      student_studentid,
                                                      "GYMNASTICSCLASS_GymnasticsClassNo." );

CREATE TABLE merchsale (
    saleid                 CHAR(10) NOT NULL,
    totalprice             NUMBER(5, 2),
    salestax               NUMBER(2, 2),
    subtotal               NUMBER(5, 2),
    gymmerchandise_merchid CHAR(10) NOT NULL,
    student_studentid      CHAR(10) NOT NULL
);

ALTER TABLE merchsale ADD CONSTRAINT merchsale_pk PRIMARY KEY ( saleid,
                                                                gymmerchandise_merchid );

CREATE TABLE parent (
    "ReferenceNo." CHAR(10) NOT NULL,
    "ContactNo."   CHAR(10),
    fname          VARCHAR2(20),
    lname          VARCHAR2(20)
);

ALTER TABLE parent ADD CONSTRAINT parent_pk PRIMARY KEY ( "ReferenceNo." );

CREATE TABLE student (
    studentid             CHAR(10) NOT NULL,
    fname                 VARCHAR2(20),
    lname                 VARCHAR2(20),
    birthdate             DATE,
    "PARENT_ReferenceNo." CHAR(10) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( studentid );

ALTER TABLE cheerleadingclass
    ADD CONSTRAINT cheerleadingclass_employee_fk FOREIGN KEY ( employee_employeeid )
        REFERENCES employee ( employeeid );
        
ALTER TABLE cheerstudent
    ADD CONSTRAINT cheerstudent_cheerleadingclass_fk FOREIGN KEY ( "CHEERLEADINGCLASS_CheerleaderClassNo." )
        REFERENCES cheerleadingclass ( "CheerleaderClassNo." );

ALTER TABLE cheerstudent
    ADD CONSTRAINT cheerstudent_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE competetivestudent
    ADD CONSTRAINT competetivestudent_competetiveteam_fk FOREIGN KEY ( competetiveteam_teamid )
        REFERENCES competetiveteam ( teamid );

ALTER TABLE competetivestudent
    ADD CONSTRAINT competetivestudent_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE competetiveteam
    ADD CONSTRAINT competetiveteam_employee_fk FOREIGN KEY ( employee_employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE competetiveteambilling
    ADD CONSTRAINT competetiveteambilling_fee_fk FOREIGN KEY ( fee_feeid )
        REFERENCES fee ( feeid );

ALTER TABLE competetiveteambilling
    ADD CONSTRAINT competetiveteambilling_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE gymnasticsclass
    ADD CONSTRAINT gymnasticsclass_employee_fk FOREIGN KEY ( employee_employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE gymnasticsmeet
    ADD CONSTRAINT gymnasticsmeet_competetiveteam_fk FOREIGN KEY ( competetiveteam_teamid )
        REFERENCES competetiveteam ( teamid );
 
ALTER TABLE gymnasticsstudent
    ADD CONSTRAINT gymnasticsstudent_gymnasticsclass_fk FOREIGN KEY ( "GYMNASTICSCLASS_GymnasticsClassNo." )
        REFERENCES gymnasticsclass ( "GymnasticsClassNo." );

ALTER TABLE gymnasticsstudent
    ADD CONSTRAINT gymnasticsstudent_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE merchsale
    ADD CONSTRAINT merchsale_gymmerchandise_fk FOREIGN KEY ( gymmerchandise_merchid )
        REFERENCES gymmerchandise ( merchid );

ALTER TABLE merchsale
    ADD CONSTRAINT merchsale_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE student
    ADD CONSTRAINT student_parent_fk FOREIGN KEY ( "PARENT_ReferenceNo." )
        REFERENCES parent ( "ReferenceNo." );

/*
-------------- Parents ----------------
*/
insert into parent values('110000000P', '3171234567', 'Eddy', 'Wan');
insert into parent values('120000000P', '3171534667', 'Stewart', 'Fetzko');
insert into parent values('130000000P', '7651234567', 'Priyen', 'Shah');
insert into parent values('140000000P', '8340284721', 'Robert', 'Daniels');
insert into parent values('150000000P', '8256781365', 'Leo', 'Khamis');
insert into parent values('160000000P', '3141224557', 'John', 'Smith');
insert into parent values('170000000P', '8492947583', 'Karen', 'Johnson');
insert into parent values('180000000P', '9572831632', 'Emma', 'Tolbert');
insert into parent values('190000000P', '8902703257', 'Mitchell', 'Eggers');
insert into parent values('200000000P', '3948583920', 'Michael', 'Sanders');

insert into parent values('220000000P', '7652384234', 'Michael', 'hasket');
insert into parent values('230000000P', '3234234563', 'Karen', 'Shein');
insert into parent values('240000000P', '3922342240', 'Rose', 'Alexander');
insert into parent values('250000000P', '3943242342', 'Hayden', 'Smithinson');
insert into parent values('260000000P', '4157657462', 'Patrick', 'Smithy');
insert into parent values('270000000P', '9255796674', 'Loreli', 'Bobby');


/*
-------------- Student ----------------
*/
insert into student values('111111111S', 'Joe', 'Wan', '10-DEC-2001', '110000000P');
insert into student values('111111112S', 'Sarah', 'Fetzko', '08-FEB-2004', '120000000P');
insert into student values('111111113S', 'Jennifer', 'Shah', '09-OCT-2003', '130000000P');
insert into student values('111111114S', 'Tom', 'Daniels', '15-JAN-2002', '140000000P');
insert into student values('111111115S', 'Ralph', 'Khamis', '24-FEB-2004', '150000000P');
insert into student values('111111116S', 'Max', 'Smith', '26-MAY-2007', '160000000P');
insert into student values('111111117S', 'Eric', 'Johnson', '29-APR-2000', '170000000P');
insert into student values('111111118S', 'Jackson', 'Tolbert', '03-JUN-2006', '180000000P');
insert into student values('111111119S', 'Meredith', 'Eggers', '05-JUL-2004', '190000000P');
insert into student values('111111120S', 'Maria', 'Sanders', '16-AUG-2001', '200000000P');

insert into student values('111111121S', 'Max', 'Wan', '10-DEC-2001', '130000000P');
insert into student values('111111122S', 'Mills', 'Hasket', '08-FEB-2004', '220000000P');
insert into student values('111111123S', 'Jen', 'Shien', '09-OCT-2003', '230000000P');
insert into student values('111111124S', 'Tommy', 'Alexander', '15-JAN-2002', '240000000P');
insert into student values('111111125S', 'Kevin', 'Smithinson', '24-FEB-2004', '250000000P');
insert into student values('111111126S', 'Maxwell', 'Smithy', '26-MAY-2007', '260000000P');
insert into student values('111111127S', 'Eric', 'Bobby', '29-APR-2000', '270000000P');
insert into student values('111111128S', 'Matthew', 'Tolbert', '03-JUN-2006', '180000000P');
insert into student values('111111129S', 'Johnathan', 'Eggers', '05-JUL-2004', '190000000P');
insert into student values('111111130S', 'Josie', 'Sanders', '16-AUG-2001', '200000000P');





/*
-------------- Fee ----------------
*/
insert into fee values('100000000F', 'Merchandise', 40, '18-DEC-2021');
insert into fee values('200000000F', 'Lesson Beginner', 30, '10-OCT-2021');
insert into fee values('300000000F', 'Merchandise', 20, '20-JAN-2021');
insert into fee values('400000000F', 'Lesson Intermediate', 40, '09-FEB-2021');
insert into fee values('500000000F', 'Registration', 100, '28-AUG-2021');
insert into fee values('600000000F', 'Merchandise', 40, '24-FEB-2021');
insert into fee values('700000000F', 'Lesson Advanced', 50, '05-MAY-2021');
insert into fee values('800000000F', 'Registration', 100, '23-APR-2021');
insert into fee values('900000000F', 'Merchandise', 10, '02-MAR-2021');
insert into fee values('110000000F', 'Merchandise', 40, '12-JUL-2021');
/*
-------------- Employee ----------------
*/
insert into employee values('100000000A', 'Morgan', 'Tracy', 'Coach','7573859683', 'Beginner');
insert into employee values('200000000A', 'Jerald', 'Roydon', 'Assistant Coach','5049384756', 'Intermed');
insert into employee values('300000000A', 'Adaline', 'Garner', 'Coach','4857386970', 'Advanced');
insert into employee values('400000000A', 'Norman', 'Peck', 'Trainer','2736485967', 'Beginner');
insert into employee values('500000000A', 'Dawn', 'Lucas', 'Coach','9384756478', 'Intermed');
insert into employee values('600000000A', 'Reese', 'Herman', 'Trainer','2938475636', 'Intermed');
insert into employee values('700000000A', 'Franklin', 'Mills', 'Assistant Coach','3587469856', 'Beginner');
insert into employee values('800000000A', 'Lily', 'Thrussell', 'Coach','9874556984', 'Intermed');
insert into employee values('900000000A', 'Terry', 'Braxton', 'Trainer','2947563758', 'Advanced');
insert into employee values('110000000A', 'Brandi', 'Wilson', 'Assistant Coach','2394859381', 'Advanced');
/*
-------------- Gymmerchandise ----------------
*/
insert into gymmerchandise values('111111112M', 40, 'Shorts Red', 10);
insert into gymmerchandise values('111111113M', 40, 'Shorts Blue', 15);
insert into gymmerchandise values('111111114M', 40, 'Shorts Black', 8);
insert into gymmerchandise values('111111115M', 40, 'Shorts White', 20);
insert into gymmerchandise values('111111116M', 20, 'Sweatband Red', 30);
insert into gymmerchandise values('111111117M', 20, 'Sweatband Blue', 15);
insert into gymmerchandise values('111111118M', 20, 'Sweatband Black', 20);
insert into gymmerchandise values('111111119M', 20, 'Sweatband White', 10);
insert into gymmerchandise values('111111120M', 60, 'Leotard White', 6);
insert into gymmerchandise values('111111121M', 60, 'Leotard Black', 3);


/*
-------------- Competetiveteam  ----------------
*/

insert into competetiveteam values('1000000001', 'Monday', 'Advanced', '100000000A');
insert into competetiveteam values('1000000002', 'Monday', 'Advanced', '200000000A');
insert into competetiveteam values('1000000003', 'Tuesday', 'Beginner', '300000000A');
insert into competetiveteam values('1000000004', 'Tuesday', 'Advanced', '400000000A');
insert into competetiveteam values('1000000005', 'Wednesday', 'Int', '500000000A');
insert into competetiveteam values('1000000006', 'Wednesday', 'Int', '600000000A');
insert into competetiveteam values('1000000007', 'Wednesday', 'Int', '700000000A');
insert into competetiveteam values('1000000008', 'Thursday', 'Beginner', '800000000A');
insert into competetiveteam values('1000000009', 'Thursday', 'Advanced', '900000000A');
insert into competetiveteam values('1000000010', 'Friday', 'Advanced', '110000000A');

/*
-------------- Gymnasticsmeet  ----------------
*/

insert into gymnasticsmeet values('100000000B', '1PM', '09-FEB-2021', 'Colorado', '1000000001');
insert into gymnasticsmeet values('200000000B', '3PM', '09-MAR-2021', 'California', '1000000002');
insert into gymnasticsmeet values('300000000B', '8PM', '21-FEB-2021', 'Wisconsin', '1000000003');
insert into gymnasticsmeet values('400000000B', '1PM', '12-JUN-2021', 'New York', '1000000004');
insert into gymnasticsmeet values('500000000B', '11AM', '15-JUL-2021', 'Colorado', '1000000005');
insert into gymnasticsmeet values('600000000B', '8AM', '08-AUG-2021', 'Colorado', '1000000006');
insert into gymnasticsmeet values('700000000B', '1PM', '02-SEP-2021', 'New Mexico', '1000000007');
insert into gymnasticsmeet values('800000000B', '1PM', '06-JAN-2021', 'Texas', '1000000008');
insert into gymnasticsmeet values('900000000B', '4PM', '09-OCT-2021', 'Maine', '1000000009');
insert into gymnasticsmeet values('110000000B', '5PM', '25-OCT-2021', 'Colorado', '1000000010');

/*
-------------- Competetivestudent  ----------------
*/

insert into competetivestudent values('01-FEB-2021', 'COMP-A', '2HRS', '111111111S', '1000000001','7/10');
insert into competetivestudent values('01-FEB-2021', 'COMP-A', '2HRS', '111111112S', '1000000002','4/10');
insert into competetivestudent values('02-FEB-2021', 'COMP-B', '2HRS', '111111113S', '1000000003','5/10');
insert into competetivestudent values('02-FEB-2021', 'COMP-A', '2HRS', '111111114S', '1000000004','6/10');
insert into competetivestudent values('03-FEB-2021', 'COMP-I', '2HRS', '111111115S', '1000000005','9/10');
insert into competetivestudent values('03-FEB-2021', 'COMP-I', '2HRS', '111111116S', '1000000006','10/10');
insert into competetivestudent values('03-FEB-2021', 'COMP-I', '2HRS', '111111117S', '1000000007','7/10');
insert into competetivestudent values('04-FEB-2021', 'COMP-B', '2HRS', '111111118S', '1000000008','8/10');
insert into competetivestudent values('04-FEB-2021', 'COMP-A', '2HRS', '111111119S', '1000000009','6/10');
insert into competetivestudent values('05-FEB-2021', 'COMP-A', '2HRS', '111111120S', '1000000010','3/10');

INSERT INTO CompetetiveTeamBilling VALUES ('RXG66RTI9D','100000000F',31,41,.07,'111111121S');
INSERT INTO CompetetiveTeamBilling VALUES ('XOH11MDC2X','200000000F',32,44,.07,'111111122S');
INSERT INTO CompetetiveTeamBilling VALUES ('UNG72LIJ3L','300000000F',37,40,.07,'111111123S');
INSERT INTO CompetetiveTeamBilling VALUES ('YLJ15CJS4N','400000000F',35,50,.07,'111111124S');
INSERT INTO CompetetiveTeamBilling VALUES ('LFT96IGV1D','500000000F',45,42, .07,'111111125S');
INSERT INTO CompetetiveTeamBilling VALUES ('PKK08XQE7I','600000000F',39,41,.07,'111111126S');
INSERT INTO CompetetiveTeamBilling VALUES ('IYR55KSS5E','700000000F',38,38,.07,'111111127S');
INSERT INTO CompetetiveTeamBilling VALUES ('IHM77WXG8R','800000000F',47,40,.07,'111111128S');
INSERT INTO CompetetiveTeamBilling VALUES ('VYD03QEC1Q','900000000F',38,46,.07,'111111129S');
INSERT INTO CompetetiveTeamBilling VALUES ('WOU51FOC2S','110000000F',46,46,.07,'111111130S');

INSERT INTO MERCHSALE VALUES ('RXG66RTI9D',147,.07,155,'111111112M','111111111S');
INSERT INTO MERCHSALE VALUES ('XOH11MDC2X',188,.07,198,'111111113M','111111112S');
INSERT INTO MERCHSALE VALUES ('UNG72LIJ3L',107,.07,110,'111111114M','111111113S');
INSERT INTO MERCHSALE VALUES ('YLJ15CJS4N',102,.07,104,'111111115M','111111114S');
INSERT INTO MERCHSALE VALUES ('LFT96IGV1D',109,.07,111,'111111116M','111111115S');
INSERT INTO MERCHSALE VALUES ('DZW44CMR5O',185,.07,186,'111111117M','111111116S');
INSERT INTO MERCHSALE VALUES ('QJK76CAL8D',187,.07,192,'111111118M','111111117S');
INSERT INTO MERCHSALE VALUES ('FDB23WNG3Q',190,.07,194,'111111119M','111111118S');
INSERT INTO MERCHSALE VALUES ('XBP57NFK6F',142,.07,151,'111111120M','111111119S');
INSERT INTO MERCHSALE VALUES ('KKW44DTF7M',159,.07,167,'111111121M','111111120S');

INSERT INTO GYMNASTICSCLASS VALUES ('UOD94JYF0A','2:00-4:00pm',99,'beginner','100000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('COQ22QLG5P','2:00-4:00pm',99, 'beginner','200000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('KLF60VIC5R','4:00-6:00pm',99,'beginner','300000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('QPX07TRK5T','4:00-6:00pm', 99, 'beginner','400000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('DSR51XPS3U','6:00-8:00pm',30, 'Intermed','500000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('TVT28MNC5U','6:00-8:00pm',99,'advance','600000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('FRP83NMU8G','6:00-8:00pm',99, 'beginner','700000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('ESS95BMV8R','8:00-10:00pm',99,'advance','800000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('NFW80GHA4K','8:00-10:00pm',99, 'beginner','900000000A');
INSERT INTO GYMNASTICSCLASS VALUES ('IIV28SGL4Z','6:00-8:00pm',30,'Intermed','110000000A');

INSERT INTO GYMNASTICSSTUDENT VALUES ('Monday','UOD94JYF0A','111111111S', 'Good', '2 HOURS', null);
INSERT INTO GYMNASTICSSTUDENT VALUES ('Tuesday','COQ22QLG5F','111111112S', 'Good', '2 HOURS',null);
INSERT INTO GYMNASTICSSTUDENT VALUES ('Monday','KLF60VIC5R','111111113S', 'Average', '1 HOURS','10/10');
INSERT INTO GYMNASTICSSTUDENT VALUES ('Tuesday','QPX07TRK5T','111111114S', 'Bad', '2 HOURS','7/10');
INSERT INTO GYMNASTICSSTUDENT VALUES ('Monday','DSR51XPS3U','111111115S', 'Good', '2 HOURS','3/10');
INSERT INTO GYMNASTICSSTUDENT VALUES ('Wednesday','TVT28MNC5U','111111116S', 'Bad', '3 HOURS',null);
INSERT INTO GYMNASTICSSTUDENT VALUES ('Wednesday','FRP83NMU8G','111111117S', 'Good', '2 HOURS', null);
INSERT INTO GYMNASTICSSTUDENT VALUES ('Thursday','ESS95BMV8R','111111118S', 'Bad', '1 HOURS','8/10');
INSERT INTO GYMNASTICSSTUDENT VALUES ('Thursday','NFW80GHA4K','111111119S', 'Bad', '1 HOURS',null);
INSERT INTO GYMNASTICSSTUDENT VALUES ('Thursday','IIV28SGL4Z','111111120S', 'Good', '1.5 HOURS',null);

INSERT INTO CHEERLEADINGCLASS VALUES('11000000CL' ,'2:00-4:00pm', 99, 'beginner','100000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('12000000CL' ,'6:00-8:00pm',99, 'beginner','100000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('13000000CL' ,'2:00-4:00pm', 99, 'beginner','100000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('14000000CL' ,'2:00-4:00pm', 99, 'beginner','200000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('15000000CL' ,'8:00-10:00pm',99, 'beginner','300000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('16000000CL' ,'2:00-4:00pm', 99, 'beginner','400000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('17000000CL' ,'6:00-8:00pm',30, 'Interm','600000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('18000000CL' ,'6:00-8:00pm',99,'advance','700000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('19000000CL' ,'6:00-8:00pm',30,'Interm','800000000A');
INSERT INTO CHEERLEADINGCLASS VALUES('11100000CL' ,'2:00-4:00pm', 99, 'beginner','900000000A');
/*
-------------- Cheerstudent  ----------------
*/

insert into cheerstudent values('06-FEB-2021', '11100000CL', '111111121S', 'CHEER-A', '1HRS','5/10');
insert into cheerstudent values('07-FEB-2021', '16000000CL', '111111122S', 'CHEER-A', '1HRS','6/10');
insert into cheerstudent values('08-FEB-2021', '11100000CL', '111111123S', 'CHEER-A', '1HRS','6/10');
insert into cheerstudent values('09-FEB-2021', '16000000CL', '111111124S', 'CHEER-A', '1HRS','7/10');
insert into cheerstudent values('10-FEB-2021', '14000000CL', '111111125S', 'CHEER-A', '1HRS','5/10');
insert into cheerstudent values('11-FEB-2021', '11000000CL', '111111126S', 'CHEER-A', '1HRS','4/10');
insert into cheerstudent values('12-FEB-2021', '18000000CL', '111111127S', 'CHEER-A', '1HRS','3/10');
insert into cheerstudent values('13-FEB-2021', '11100000CL', '111111128S', 'CHEER-A', '1HRS','9/10');
insert into cheerstudent values('14-FEB-2021', '13000000CL', '111111129S', 'CHEER-A', '1HRS','8/10');
insert into cheerstudent values('15-FEB-2021', '13000000CL', '111111130S', 'CHEER-A', '1HRS','5/10');

DESCRIBE FEE;
DESCRIBE COMPETETIVETEAMBILLING;
DESCRIBE STUDENT;
DESCRIBE PARENT;
DESCRIBE MERCHSALE;
DESCRIBE GYMMERCHANDISE;
DESCRIBE GYMNASTICSSTUDENT;
DESCRIBE GYMNASTICSCLASS;
DESCRIBE EMPLOYEE;
DESCRIBE COMPETETIVESTUDENT;
DESCRIBE COMPETETIVETEAM;
DESCRIBE GYMNASTICSMEET;
DESCRIBE CHEERSTUDENT;
DESCRIBE CHEERLEADINGCLASS;

SELECT * from FEE;
SELECT * from COMPETETIVETEAMBILLING;
SELECT * from STUDENT;
SELECT * from PARENT;
SELECT * from MERCHSALE;
SELECT * from GYMMERCHANDISE;
SELECT * from GYMNASTICSSTUDENT;
SELECT * from GYMNASTICSCLASS;
SELECT * from EMPLOYEE;
SELECT * from COMPETETIVESTUDENT;
SELECT * from COMPETETIVETEAM;
SELECT * from GYMNASTICSMEET;
SELECT * from CHEERSTUDENT;
SELECT * from CHEERLEADINGCLASS;




