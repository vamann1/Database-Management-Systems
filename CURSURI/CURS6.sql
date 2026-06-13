set SERVEROUTPUT on
DECLARE  
  TYPE T_REC IS RECORD(
    NUME_CLIENT CLIENTI.NUME_CLIENT%TYPE,
    PRENUME_CLIENT CLIENTI.PRENUME_CLIENT%TYPE,
    LIMITA_CREDIT CLIENTI.LIMITA_CREDIT%TYPE
  );
  TYPE T_CLIENT IS TABLE OF T_REC INDEX BY PLS_INTEGER;
  V T_CLIENT;  
BEGIN
  SELECT NUME_CLIENT,PRENUME_CLIENT,LIMITA_CREDIT
  BULK COLLECT INTO V FROM CLIENTI 
    WHERE ID_CLIENT IN (SELECT ID_CLIENT FROM COMENZI)
    AND LIMITA_CREDIT>30000
    ORDER BY LIMITA_CREDIT DESC; 
   DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);    
   DBMS_OUTPUT.PUT_LINE(v.count);    
  V.DELETE;  
END;
/

DECLARE
  V_LIMITA NUMBER;
BEGIN
  SELECT LIMITA_CREDIT INTO V_LIMITA FROM CLIENTI 
     WHERE ID_CLIENT=170;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);   
  DBMS_OUTPUT.PUT_LINE(1);   
END;
/

SA SE MAREASCA CU 5% PRETUL PRODUSELOR CARE AU FOST COMANDATE
IN COMENZI CU VALOARE TOTALA DE MIN 50000
SA SE AFISEZE CATE PRODUSE AU AVUT PRETUL MARIT

BEGIN
  UPDATE PRODUSE SET PRET_LISTA=PRET_LISTA*1.05
   WHERE ID_PRODUS IN (SELECT ID_PRODUS FROM RAND_COMENZI
     GROUP BY ID_PRODUS HAVING SUM(CANTITATE*PRET)>50000);
  DBMS_OUTPUT.PUT_LINE('NUMAR DE PRETURI MODIFICATE: '||SQL%ROWCOUNT);    
  DELETE FROM ISTORIC_FUNCTII WHERE ID_ANGAJAT=101;  
  DBMS_OUTPUT.PUT_LINE('NUMAR DE RADURI STERSE: '||SQL%ROWCOUNT);    
  ROLLBACK;
END;
/

DECLARE
    TYPE T_COL IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    V T_COL;
BEGIN   
  DELETE FROM ISTORIC_FUNCTII WHERE ID_ANGAJAT=101
  RETURNING ID_FUNCTIE BULK COLLECT INTO V;  
  DBMS_OUTPUT.PUT_LINE('NUMAR DE RADURI STERSE: '||SQL%ROWCOUNT);   
  FOR I IN 1..V.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(V(I));
  END LOOP;  
  ROLLBACK;
END;
/

set serveroutput on
begin
if SQL%found then dbms_output.put_line(0) ;
 else
 dbms_output.put_line(1) ;
end if;
end;
/

set serveroutput on
begin
If not SQL%found then dbms_output.put_line(0) ;
 else
 dbms_output.put_line(1) ;
end if;
end;
/

set serveroutput on
begin
if SQL%ISOPEN then dbms_output.put_line(0) ;
 else
 dbms_output.put_line(1) ;
end if;
end;
/

set serveroutput on
begin
If not SQL%ISOPEN then dbms_output.put_line(0) ;
 else
 dbms_output.put_line(1) ;
end if;
end;
/



set serveroutput on
DECLARE
  N NUMBER;
begin
N:=ROUND(7,25);
N:=decode(1,NULL,0,1);
--dbms_output.put_line(decode(SQL%ROWCOUNT,NULL,0,1)) ;
end;
/
DECLARE
  N NUMBER;
begin
N:=ROUND(7,25);
dbms_output.put_line(N);
SELECT decode(1,NULL,0,100) INTO N FROM DUAL;
dbms_output.put_line(N);
end;
/

set serveroutput on
declare 
n pls_integer;
begin
select decode(NULL,NULL,1,0) into n from dual;
dbms_output.put_line(n) ; 
IF NULL = NULL THEN --NU E TRUE, E NULL
dbms_output.put_line(100);
END IF;
end;
/


set serveroutput on
begin
 
 if SQL%ISOPEN then
  dbms_output.put_line('Is opened');
 else 
 dbms_output.put_line('Is not opened');
 end if;
 update angajati set salariul=salariul+10 where ID_DEPARTAMENT=30;
end;
/

declare 
 cursor c is select id_angajat,prenume,nume,salariul from angajati order by salariul desc;
 r c%rowtype;
begin
 if NOT c%ISOPEN THEN
 open c;
 END IF;
 --OPEN C;
 if c%ISOPEN then dbms_output.put_line('AAA');
  else dbms_output.put_line('BBB');
 end if;
 
 loop
 fetch c into r; 
 exit when c%notfound;
 dbms_output.put_line(C%ROWCOUNT||'->'||R.prenume||' '||r.nume||' '||r.salariul);
 
 end loop;
 
 close c;
 --CLOSE C;
 if c%ISOPEN then dbms_output.put_line('AAA');
  else dbms_output.put_line('BBB');
 end if;
end;
/


declare 
 cursor c is select id_angajat,prenume,nume,salariul from angajati order by salariul desc;
 r c%rowtype;
begin
 
 open c;
 
 loop
 fetch c into r; 
 exit when c%notfound;
 dbms_output.put_line(C%ROWCOUNT||'->'||R.prenume||' '||r.nume||' '||r.salariul);
 
 end loop; 
 close c; 
end;
/


declare 
 cursor c is select id_angajat,prenume,nume, salariul from angajati order by salariul desc;
 r c%rowtype;
begin
 open c;
 fetch c into r;
 while c%found loop
  dbms_output.put_line(r.prenume||' '||r.nume||' '||r. salariul); 
  fetch c into r;
 end loop;
 dbms_output.put_line(C%ROWCOUNT);
close c;
end;
/
declare 
 cursor c is select id_angajat,prenume,nume, salariul from angajati order by salariul desc; 
begin
 for r in c loop 
 dbms_output.put_line(r.prenume||' '||r.nume||' '||r. salariul);
 end loop;
 --dbms_output.put_line(C%ROWCOUNT);
end;
/




