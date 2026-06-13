-- EROARE LA COMPILARE
BEGIN
 I:=100;
END;
/
-- EXCEPTIE (RUN TIME ERROR)
 -- PREDEFINITE
 -- NON PREDEFINITE
 -- DEFINITE DE UTILIZATOR
SET SERVEROUTPUT ON
DECLARE
 I NUMBER(2);
BEGIN
 I:=100;
 EXCEPTION WHEN VALUE_ERROR THEN
   DBMS_OUTPUT.PUT_LINE('VARIABILA NU ARE DIMENSIUNEA CORECTA');
END;
/

declare
 fn angajati.prenume%type;
 q number(2);
begin
 q:=1;
 select prenume into fn from angajati where id_angajat=200;
 q:=2;
 select prenume into fn from angajati where id_angajat=301;
 q:=3;
exception
 when no_data_found then
   dbms_output.put_line('Angajatul nu a fost gasit la interogarea '||q);
   dbms_output.put_line(sqlerrm);
   dbms_output.put_line(sqlcode);
  when others then 
   dbms_output.put_line(sqlerrm);
   dbms_output.put_line(sqlcode);
end;
/

declare
 fn varchar2(128);
 q number(2);
begin
 for i in 1..500 loop
   if (i mod 2=1) then 
       i:=i+1;
   end if;
   select prenume||'  '||nume into fn from angajati where id_angajat=i;
   dbms_output.put_line(fn);
 end loop;
 exception when others then null;
end;
/

Set serveroutput on
declare
 fn varchar2(128);
 q number(2);
begin
 for i in 1..500 loop
  begin
  select prenume||' '||nume||' '||i into fn from angajati where id_angajat=i;
  dbms_output.put_line(fn);  
  exception when 
    no_data_found then dbms_output.put_line(sqlerrm);
  end;  
 end loop;
  
end;
/

SELECT USER,SYSDATE FROM DUAL;


drop table occurred_exc;
create table occurred_exc (exc_user varchar2(32), exc_date date, exc_code number(32), exc_message varchar2(256));
begin
 raise no_data_found;
exception
  when others then
     insert into occurred_exc values(user,sysdate,SQLCODE,SQLERRM);
end;
/
declare
 c number(10);
 s varchar2(50);
begin
 raise no_data_found;
exception
  when others then
     c:=SQLCODE;
     s:=SQLERRM;
     insert into occurred_exc values(user,sysdate,c,s);
     commit;
end;
/

SELECT * FROM occurred_exc;

set serveroutput on
declare
 c number(10);
 s varchar2(5);
begin
 raise no_data_found;
exception
  when others then
     c:=SQLCODE;   
     begin
     dbms_output.put_line('Er1='||SQLERRM); 
     s:=SQLERRM;
     dbms_output.put_line('Er2='||s);
     exception
       when others then
          dbms_output.put_line('Er3='||SQLERRM); 
          insert into occurred_exc values(user,sysdate,c+1,s);
     end;     
end;
/


Set serveroutput on
declare
cursor c is select prenume from angajati;
r c%rowtype;
begin
 begin
  OPEN C;
  fetch c into r;   dbms_output.put_line('Name='||r.prenume );
  exception when no_data_found then
     dbms_output.put_line('A');
  end;
  dbms_output.put_line('B');
 exception
 when others then
   dbms_output.put_line('C');
end;
/


set SERVEROUTPUT on
DECLARE
  NN_EXC EXCEPTION;
  PRAGMA EXCEPTION_INIT(NN_EXC,-2290);
begin
 insert into angajati(id_angajat,prenume) values (2002, 'John');
 EXCEPTION WHEN NN_EXC THEN
    dbms_output.put_line('Exceptie');
end;
/

