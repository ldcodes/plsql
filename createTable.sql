--bank
CREATE TABLE "SCOTT"."bank" 
   (	"bank_id" NUMBER(9,0) NOT NULL ENABLE, 
	"bank_name" VARCHAR2(30) NOT NULL ENABLE, 
	 PRIMARY KEY ("bank_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS";
--customer
CREATE TABLE "SCOTT"."customer" 
   (	"customer_id" NUMBER NOT NULL ENABLE, 
	"customer_name" VARCHAR2(30) NOT NULL ENABLE, 
	"addr" VARCHAR2(30) NOT NULL ENABLE, 
	"balance" NUMBER(9,2) NOT NULL ENABLE, 
	 PRIMARY KEY ("customer_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS";

--decice
CREATE TABLE "SCOTT"."device" 
   (	"device_id" NUMBER(9,0) NOT NULL ENABLE, 
	"customer_id" NUMBER(9,0) NOT NULL ENABLE, 
	"type" NUMBER(2,0) NOT NULL ENABLE, 
	 PRIMARY KEY ("device_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "customer_id" FOREIGN KEY ("customer_id")
	  REFERENCES "SCOTT"."customer" ("customer_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."DEVICE_TRIGGER" 
before insert on "device" 
for each row   
 WHEN (new."device_id" is null) begin  
      select   DEVICE_SEQ.nextval  into:new."device_id" from sys.dual ;   
end;
ALTER TRIGGER "SCOTT"."DEVICE_TRIGGER" ENABLE

--
CREATE TABLE "SCOTT"."ef_log" 
   (	"device_id" NUMBER(9,0), 
	"ef_id" NUMBER(9,0), 
	"use_amount" NUMBER(9,0), 
	"base_amount" NUMBER(9,2), 
	"additional_cost1" NUMBER(9,2), 
	"amount" NUMBER(9,2), 
	"deadline" DATE, 
	"pay_date" DATE, 
	"paid_fee" NUMBER(9,2) DEFAULT 0, 
	"state" NUMBER(1,0), 
	"additional_cost2" NUMBER(9,3), 
	"dat" DATE, 
	 CONSTRAINT "SYS_C0011209" PRIMARY KEY ("ef_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "ef_log_device_" FOREIGN KEY ("device_id")
	  REFERENCES "SCOTT"."device" ("device_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."EF_TRIGGER" 
before insert on "ef_log" 
for each row   
 WHEN (new."ef_id" is null) begin  
      select   ef_seq_1.nextval  into:new."ef_id" from sys.dual ;   
end; 
/*create or replace trigger ef_trigger   
after insert on "ef_log" 
for each row   
--when (new."base_amount" is null)
begin  
      select  :new."use_amount"*0.5 into:new."base_amount" from sys.dual ;   
end; 
*/
ALTER TRIGGER "SCOTT"."EF_TRIGGER" ENABLE

--

CREATE TABLE "SCOTT"."em_log" 
   (	"log_id" NUMBER(9,0) NOT NULL ENABLE, 
	"dat" DATE NOT NULL ENABLE, 
	"device_id" NUMBER NOT NULL ENABLE, 
	"elect_number" NUMBER(9,0) NOT NULL ENABLE, 
	"worker_name" VARCHAR2(30) DEFAULT 'name' NOT NULL ENABLE, 
	 PRIMARY KEY ("log_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "em_log_device_id" FOREIGN KEY ("device_id")
	  REFERENCES "SCOTT"."device" ("device_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."EM_TRIGGER" 
before insert on "em_log"
for each row   
 WHEN (new."log_id" is null) begin  
      select   DEVICE_SEQ.nextval  into:new."log_id" from sys.dual ;   
end;
ALTER TRIGGER "SCOTT"."EM_TRIGGER" ENABLE
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."SERIAL_TRIGGER_111" AFTER INSERT ON "SCOTT"."em_log" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW  WHEN (new."dat" is not null and new."elect_number" is not null and new."device_id" is not null  ) DECLARE
e_am number;
did number;
d date;
ad2 number;
typ number;
e1 number;
begin  
select   :new."device_id",:new."elect_number", :new."dat" into did,e_am,d  from sys.dual ;
 select count(*) into e1  from "device" where "device"."device_id"=did;
 --if e1 >0 then	
      select "type" into typ from "device" where "device"."device_id"=:new."device_id"; 
	
			if typ =1 then 
			     ad2 := e_am*0.1;
			 else--02
			     ad2 := e_am*0.15;
			 end if;
      
			--dbms_output.put_line(did||e_am||d);
			--if did is not null and e_am is not null then 
			  insert into
			  "ef_log"("device_id","use_amount","base_amount","additional_cost1","additional_cost2","amount","deadline","pay_date","paid_fee","dat","state")   
			  values(did,e_am,e_am*0.5,e_am*0.08*0.5,ad2*0.5,e_am*0.5+e_am*0.08*0.5+ad2*0.5, add_months(trunc(:new."dat",'mm'),1) ,null,0, last_day(add_months(trunc(:new."dat",'mm'),-1)),0);
			--end if;
	--end if;
end; 

--insert into "em_log"("dat","elect_number","device_id") values(sysdate,10,2002);
ALTER TRIGGER "SCOTT"."SERIAL_TRIGGER_111" ENABLE

--

CREATE TABLE "SCOTT"."error_account" 
   (	"ea_id" NUMBER(9,0) NOT NULL ENABLE, 
	"check_time" DATE NOT NULL ENABLE, 
	"bank_id" NUMBER(9,0) NOT NULL ENABLE, 
	"serial_id" NUMBER(9,0) NOT NULL ENABLE, 
	"customer_id" NUMBER(9,0) NOT NULL ENABLE, 
	"bank_amount" NUMBER(9,2), 
	"enterprise_amount" NUMBER(9,2), 
	"type" NUMBER(9,0) NOT NULL ENABLE, 
	 PRIMARY KEY ("ea_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "ea_bank" FOREIGN KEY ("bank_id")
	  REFERENCES "SCOTT"."bank" ("bank_id") ENABLE, 
	 CONSTRAINT "ea_custome" FOREIGN KEY ("customer_id")
	  REFERENCES "SCOTT"."customer" ("customer_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."ER_TRIGGER" 
before insert on "error_account"
for each row   
 WHEN (new."ea_id" is null) begin  
      select   DEVICE_SEQ.nextval  into:new."ea_id" from sys.dual ;
end;
ALTER TRIGGER "SCOTT"."ER_TRIGGER" ENABLE

--
CREATE TABLE "SCOTT"."pay_log" 
   (	"pay_id" NUMBER(9,0) NOT NULL ENABLE, 
	"customer_id" NUMBER(9,0) NOT NULL ENABLE, 
	"pay_time" DATE NOT NULL ENABLE, 
	"pay_amount" NUMBER(9,2) NOT NULL ENABLE, 
	"pay_type" NUMBER(9,0) NOT NULL ENABLE, 
	"bank_id" NUMBER(9,0) NOT NULL ENABLE, 
	"serial_id" NUMBER(9,0) NOT NULL ENABLE, 
	"device_id" NUMBER(9,0), 
	"ef_id" NUMBER(9,0), 
	"aim_customer_id" NUMBER(9,0), 
	"balance" NUMBER(9,2) DEFAULT 0.0 NOT NULL ENABLE, 
	 CONSTRAINT "SYS_C0011242" PRIMARY KEY ("pay_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "pay_log_customer" FOREIGN KEY ("customer_id")
	  REFERENCES "SCOTT"."customer" ("customer_id") ENABLE, 
	 CONSTRAINT "pay_log_bank" FOREIGN KEY ("bank_id")
	  REFERENCES "SCOTT"."bank" ("bank_id") ENABLE, 
	 CONSTRAINT "pay_log_device" FOREIGN KEY ("device_id")
	  REFERENCES "SCOTT"."device" ("device_id") ENABLE, 
	 CONSTRAINT "pay_log_ef" FOREIGN KEY ("ef_id")
	  REFERENCES "SCOTT"."ef_log" ("ef_id") ENABLE, 
	 CONSTRAINT "pay_log-aim_cid" FOREIGN KEY ("aim_customer_id")
	  REFERENCES "SCOTT"."customer" ("customer_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."PAY_TRIGGER" 
before insert on "pay_log"
for each row   
 WHEN (new."pay_id" is null) begin  
      select   DEVICE_SEQ.nextval  into:new."pay_id" from sys.dual ;
end;
ALTER TRIGGER "SCOTT"."PAY_TRIGGER" ENABLE


--

CREATE TABLE "SCOTT"."total_account" 
   (	"ta_id" NUMBER(9,0) NOT NULL ENABLE, 
	"check_date" DATE NOT NULL ENABLE, 
	"bank_id" NUMBER(9,0) NOT NULL ENABLE, 
	"bank_amount" NUMBER(9,2) NOT NULL ENABLE, 
	"enterprise_count" NUMBER(9,0) NOT NULL ENABLE, 
	"bank_count" NUMBER(9,0) NOT NULL ENABLE, 
	"enterprise_amount" NUMBER(9,2) NOT NULL ENABLE, 
	"is_consistent" NUMBER(1,0) NOT NULL ENABLE, 
	 PRIMARY KEY ("ta_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "a_bank" FOREIGN KEY ("bank_id")
	  REFERENCES "SCOTT"."bank" ("bank_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 ;

CREATE OR REPLACE TRIGGER "SCOTT"."TOT_TRIGGER" 
before insert on "total_account"
for each row   
 WHEN (new."ta_id" is null) begin  
      select   DEVICE_SEQ.nextval  into:new."ta_id" from sys.dual ;
end;
ALTER TRIGGER "SCOTT"."TOT_TRIGGER" ENABLE

--
CREATE TABLE "SCOTT"."transfer_log" 
   (	"serial_id" NUMBER(9,0) NOT NULL ENABLE, 
	"bank_id" NUMBER(9,0) NOT NULL ENABLE, 
	"customer_id" NUMBER(9,0) NOT NULL ENABLE, 
	"transfer_amount" NUMBER(9,2) NOT NULL ENABLE, 
	"time" DATE NOT NULL ENABLE, 
	 PRIMARY KEY ("serial_id")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "tl_bank" FOREIGN KEY ("bank_id")
	  REFERENCES "SCOTT"."bank" ("bank_id") ENABLE, 
	 CONSTRAINT "tl_custome" FOREIGN KEY ("customer_id")
	  REFERENCES "SCOTT"."customer" ("customer_id") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"