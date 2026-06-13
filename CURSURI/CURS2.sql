SET SERVEROUTPUT ON

DECLARE
  N NUMBER(2) DEFAULT 10;
BEGIN
  N:=N+100;
  N:=N/0;
  DBMS_OUTPUT.PUT_LINE('N='||N);
  EXCEPTION
       WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('IMPARTIREA LA ZERO NU ESTE PERMISA');
       WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('A APARUT O EXCEPTIE');
       DBMS_OUTPUT.PUT_LINE('SIGUR A APARUT O EXCEPTIE');

END;
/


create table mychar(nume varchar2(4000));
create table mychar2(IS_ACTIVE BOOLEAN);

DECLARE
  nume varchar2(20000);
  IS_ACTIVE BOOLEAN;
BEGIN
    NULL;
END;
/


SET SERVEROUTPUT ON
DECLARE
  V_ID_ANGAJAT angajati.ID_ANGAJAT%TYPE;
  V_PRENUME angajati.PRENUME%TYPE;
  V_NUME angajati.NUME%TYPE;
  V_EMAIL angajati.EMAIL%TYPE;
  V_IMPOZIT CONSTANT NUMBER(3) DEFAULT 16;
  V_NOTA NUMBER(2) NOT NULL:=10;
BEGIN
 --V_IMPOZIT:=20;
 V_NOTA:=9;
 select ID_ANGAJAT,PRENUME,NUME,EMAIL
   into V_ID_ANGAJAT,V_PRENUME,V_NUME,V_EMAIL
    from angajati where id_angajat=100;
 dbms_output.put_line(V_id_angajat);
 dbms_output.put_line(V_prenume);
 dbms_output.put_line(V_nume);
 dbms_output.put_line(V_email); 
END;
/

SET SERVEROUTPUT ON
DECLARE
  x angajati%rowtype;
BEGIN
 select * into x from angajati where id_angajat=100;
 dbms_output.put_line(x.id_angajat);
 dbms_output.put_line(x.prenume);
 dbms_output.put_line(x.nume);
 dbms_output.put_line(x.email); 
END;
/

DECLARE
   V_SALARIU NUMBER;
BEGIN
   IF V_SALARIU IS NULL THEN
    dbms_output.put_line('SALARIU LIPSA');
   ELSE IF V_SALARIU<10000 THEN -- NESTED IFS
     dbms_output.put_line('SALARIU MIC');
   ELSE
     dbms_output.put_line('SALARIU MARE');
   END IF;  
   END IF; 
END;
/

DECLARE
   V_SALARIU NUMBER:=100;
BEGIN
   IF V_SALARIU IS NULL THEN
   BEGIN
    dbms_output.put_line('SALARIU LIPSA');
    dbms_output.put_line('INTRODUCETI UN SALARIU');
    EXCEPTION WHEN OTHERS THEN NULL;
   END; 
   ELSIF V_SALARIU<1000 OR V_SALARIU>100000 THEN
     dbms_output.put_line('SALARIU ERONAT');
   ELSIF V_SALARIU<10000 THEN 
     dbms_output.put_line('SALARIU MIC');
   ELSE
     dbms_output.put_line('SALARIU MARE');
   END IF;     
END;
/

DECLARE
   V_SALARIU NUMBER;
BEGIN
   IF V_SALARIU IS NULL THEN   
    dbms_output.put_line('SALARIU LIPSA');
    dbms_output.put_line('INTRODUCETI UN SALARIU');      
   ELSIF V_SALARIU<1000 OR V_SALARIU>100000 THEN
     dbms_output.put_line('SALARIU ERONAT');
   ELSIF V_SALARIU<10000 THEN 
     dbms_output.put_line('SALARIU MIC');
   ELSE
     dbms_output.put_line('SALARIU MARE');
   END IF;     
   
END;
/


DECLARE
   V_SALARIU NUMBER:=15000;
BEGIN
   CASE
   WHEN V_SALARIU IS NULL THEN   
    dbms_output.put_line('SALARIU LIPSA');
    dbms_output.put_line('INTRODUCETI UN SALARIU');      
   WHEN V_SALARIU<1000 OR V_SALARIU>100000 THEN
     dbms_output.put_line('SALARIU ERONAT');
   WHEN V_SALARIU<10000 THEN 
     dbms_output.put_line('SALARIU MIC');   
  -- WHEN  V_SALARIU>=10000 THEN   
   ELSE
      --NULL;
      dbms_output.put_line('SALARIU MARE');   
   END CASE;    
   dbms_output.put_line('CONTINUAM');
   dbms_output.put_line('CONTINUAM');
   dbms_output.put_line('CONTINUAM');
END;
/


DECLARE
   V_SALARIU NUMBER:=15000;
BEGIN
   CASE
   WHEN V_SALARIU IS NULL THEN   
    dbms_output.put_line('SALARIU LIPSA');
    dbms_output.put_line('INTRODUCETI UN SALARIU');      
   WHEN V_SALARIU<1000 OR V_SALARIU>100000 THEN
     dbms_output.put_line('SALARIU ERONAT');
   WHEN V_SALARIU<10000 THEN 
     dbms_output.put_line('SALARIU MIC');   
  -- WHEN  V_SALARIU>=10000 THEN   
   END CASE;  
   dbms_output.put_line('CONTINUAM');
   dbms_output.put_line('CONTINUAM');
   dbms_output.put_line('CONTINUAM');
   
   EXCEPTION 
    WHEN CASE_NOT_FOUND THEN
      dbms_output.put_line('SALARIU MARE');   
END;
/

DECLARE
   I PLS_INTEGER:=5;
BEGIN
    dbms_output.put_line('I='||I);
    I:=I+1;
    FOR I IN 20..30 LOOP         
     dbms_output.put_line('I='||I);
    END LOOP;
    dbms_output.put_line('I='||I);
END;
/

-- SA SE AFISEZE NUMERELE PARE INTRE 20 SI 30
BEGIN
   
    FOR I IN 20..30 LOOP         
     IF I MOD 2 = 0 THEN
      dbms_output.put_line('I='||I);
     END IF;
    END LOOP;
   
END;
/

BEGIN
   
    FOR I IN 20..30 LOOP         
     CONTINUE WHEN I MOD 2 = 1;
      dbms_output.put_line('I='||I);     
    END LOOP;
   
END;
/

BEGIN
   
    FOR I IN 20..30 LOOP         
      dbms_output.put_line('I='||I);     
      EXIT WHEN I=25;          
    END LOOP;
   
END;
/


