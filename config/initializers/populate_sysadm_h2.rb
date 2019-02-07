class PopulateSysadmH2 < ActiveRecord::Base
  include ClassLogger
  Rails.application.config.after_initialize do
    logger.warn('Initializing SYSADM')
    if Settings.edodb.adapter == 'h2'
      logger.warn('Connecting to SYSADM')
      establish_connection :edodb
      sql = <<-SQL

      DROP SCHEMA IF EXISTS SYSADM;
      CREATE SCHEMA SYSADM;

      DROP ALIAS IF EXISTS TO_DATE;
      CREATE ALIAS TO_DATE AS $$
        java.util.Date to_date(String value, String format) throws java.text.ParseException {

        java.text.DateFormat dateFormat = new java.text.SimpleDateFormat(format);
          return dateFormat.parse(value);
        }
      $$;

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_FAT;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_FAT (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR),
        DESCR3                      VARCHAR2(30 CHAR),
        DESCR4                      VARCHAR2(30 CHAR),
        DESCR5                      VARCHAR2(30 CHAR),
        DESCR6                      VARCHAR2(30 CHAR),
        DESCRFORMAL                 VARCHAR2(50 CHAR),
        DESCR7                      VARCHAR2(30 CHAR),
        DESCR8                      VARCHAR2(30 CHAR),
        TITLE                       VARCHAR2(30 CHAR),
        MESSAGE_TEXT_LONG           CLOB
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_FAT (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4,DESCR5,DESCR6,DESCRFORMAL,DESCR7,DESCR8,TITLE,MESSAGE_TEXT_LONG) VALUES ('11667051','61889','UCB01','2017','Undergraduate','Spring 2019','Meeting Satis Acad Progress','Non Select','Packaged','0',null,null,'$0','Financial Aid Profile','We take many factors into consideration when determining your funding package. Updates made elsewhere to your personal information may affect the amount of aid provided to you.');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_FAT (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4,DESCR5,DESCR6,DESCRFORMAL,DESCR7,DESCR8,TITLE,MESSAGE_TEXT_LONG) VALUES ('11667051','61889','UCB01','2018','Undergraduate','Spring 2019','Meeting Satis Acad Progress','Verified','Packaged','0',null,null,'$0','Financial Aid Profile','We take many factors into consideration when determining your funding package. Updates made elsewhere to your personal information may affect the amount of aid provided to you.');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_FAT (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4,DESCR5,DESCR6,DESCRFORMAL,DESCR7,DESCR8,TITLE,MESSAGE_TEXT_LONG) VALUES ('11667051','61889','UCB01','2019','Undergraduate','Spring 2019','Meeting Satis Acad Progress','Verified','Packaged','0',null,null,'$0','Financial Aid Profile','We take many factors into consideration when determining your funding package. Updates made elsewhere to your personal information may affect the amount of aid provided to you.');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_LVL;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_LVL (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','3rd Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','3rd Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2018','2185','Summer 2018','4th Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2019','2188','Fall 2018','4th Year');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_LVL (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2) VALUES ('11667051','61889','UCB01','2019','2192','Spring 2019','4th Year');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_ENR;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_ENR (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR),
        DESCR3                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','12 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','12 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2018','2185','Summer 2018','7 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2019','2188','Fall 2018','12 Units','Enrolled');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ENR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR2,DESCR3) VALUES ('11667051','61889','UCB01','2019','2192','Spring 2019','16 Units','Enrolled');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_RES;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_RES (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        STRM                        VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR100                    VARCHAR2(100 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2018','2178','Fall 2017','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2018','2182','Spring 2018','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2018','2185','Summer 2018','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2019','2188','Fall 2018','Resident');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_RES (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,STRM,DESCR,DESCR100) VALUES ('11667051','61889','UCB01','2019','2192','Spring 2019','Resident');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_FA_PRFL_ISR;
      CREATE TABLE SYSADM.PS_UCC_FA_PRFL_ISR (
        EMPLID                      VARCHAR2(11 CHAR),
        CAMPUS_ID                   VARCHAR2(16 CHAR),
        INSTITUTION                 VARCHAR2(5 CHAR),
        AID_YEAR                    VARCHAR2(4 CHAR),
        DESCR                       VARCHAR2(30 CHAR),
        DESCR2                      VARCHAR2(30 CHAR),
        DESCR3                      VARCHAR2(30 CHAR),
        DESCR4                      VARCHAR2(30 CHAR)
      );

      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ISR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4) values ('11667051','61889','UCB01','2017','Independent','$342',null,'1');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ISR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4) values ('11667051','61889','UCB01','2018','Independent','$425','$0','1');
      INSERT INTO SYSADM.PS_UCC_FA_PRFL_ISR (EMPLID,CAMPUS_ID,INSTITUTION,AID_YEAR,DESCR,DESCR2,DESCR3,DESCR4) values ('11667051','61889','UCB01','2019','Independent','$0',null,'2');

      DROP TABLE IF EXISTS SYSADM.PS_UCC_AD_ADMITSIR;
      CREATE TABLE SYSADM.PS_UCC_AD_ADMITSIR (
        UC_ADMITTED_GEP VARCHAR2(1),
        UC_EXPIRE_DT_ADTL DATE,
        UC_EXPIRE_DT_TDTL DATE,
        UC_ATHLETE VARCHAR2(1),
        EMPLID VARCHAR2(11),
        ACAD_CAREER VARCHAR2(4),
        DESCR VARCHAR2(30),
        STDNT_CAR_NBR NUMBER(38),
        ADM_APPL_NBR VARCHAR2(8),
        APPL_PROG_NBR NUMBER(38),
        ADM_APPL_CTR VARCHAR2(4),
        ADMIT_TERM VARCHAR2(4),
        DESCR1 VARCHAR2(30),
        ADMIT_TYPE VARCHAR2(3),
        DESCR2 VARCHAR2(30),
        PROG_STATUS VARCHAR2(4),
        PROG_REASON VARCHAR2(4),
        XLATLONGNAME VARCHAR2(30),
        PROG_ACTION VARCHAR2(4),
        DESCR3 VARCHAR2(30),
        ACAD_PROG VARCHAR2(5),
        DESCR4 VARCHAR2(30),
        EVALUATION_CODE VARCHAR2(10),
        EVALUATION_NBR NUMBER(38),
        EVALUATOR_ID VARCHAR2(11),
        EVALUATOR_NAME VARCHAR2(50),
        EVALUATOR_EMAIL VARCHAR2(70)
      );
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-10-01', 'N', '11667051', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2185', '2018 Summer', 'FYR', 'First Year Student', 'AC', '', 'Active in Program', 'MATR', 'Matriculation', 'UCCH', 'Undergrad Chemistry');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-07-01', 'N', '12345678', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2185', '2018 Summer', 'FYR', 'First Year Student', 'AD', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345679', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2185', '2018 Summer', 'FYR', 'First Year Student', 'AD', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345680', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345681', 'UGRD', 'Undergraduate', 0, '00157689', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345681', 'UGRD', 'Undergraduate', 0, '00157690', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('Y', '2018-07-15', '2018-07-01', 'N', '12345681', 'UGRD', 'Undergraduate', 0, '00157691', 0, 'UGRD', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', '', 'Active in Program', 'MATR', 'Matriculation', 'UCLS', 'College of Letters and Science');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-07-01', 'N', '12345681', 'LAW', 'Law', 0, '00157695', 0, 'LAW', '2165', '2016 Fall', 'TRN', 'Transfer', 'APP', 'LMAY', 'Active in Program', 'MATR', 'Matriculation', 'LPRFL', 'Law Professional Programs');
      INSERT INTO SYSADM.PS_UCC_AD_ADMITSIR (UC_ADMITTED_GEP, UC_EXPIRE_DT_ADTL, UC_EXPIRE_DT_TDTL, UC_ATHLETE, EMPLID, ACAD_CAREER, DESCR, STDNT_CAR_NBR, ADM_APPL_NBR, APPL_PROG_NBR, ADM_APPL_CTR, ADMIT_TERM, DESCR1, ADMIT_TYPE, DESCR2, PROG_STATUS, PROG_REASON, XLATLONGNAME, PROG_ACTION, DESCR3, ACAD_PROG, DESCR4) VALUES('N', '2018-07-15', '2018-07-01', 'N', '12345682', 'LAW', 'Law', 0, '00157692', 0, 'LAW', '2185', '2018 Summer', 'FYR', 'First Year Student', 'PM', '', 'Prematriculant', 'DEIN', 'Intention to Matriculate', 'LPRFL', 'Law Professional Programs');

      SQL

      connection.execute sql
    end
  end
end
