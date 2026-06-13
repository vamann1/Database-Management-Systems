create or replace PACKAGE emp_pack AS 
   v_cota /*constant*/ number(2):=21;
   exc_cota exception;
   pragma exception_init(exc_cota,-20001);
   TYPE EmpRecTyp IS RECORD (id number, sal number, pren varchar2(25));
   Type v_col is table of EmpRecTyp index by pls_integer;
   CURSOR disp_emp RETURN EmpRecTyp;
   PROCEDURE increase_sal (
      id    NUMBER,
      sal_increase    NUMBER,
      new_sal out   NUMBER
      );
   PROCEDURE del_employee (id NUMBER);
   function get_with_vat(val number) return number;
   function get_with_vat(val number,p_cota number) return number;
END emp_pack;
/

set serveroutput on
declare
v emp_pack.v_col;
begin
  
  dbms_output.put_line('v1='||emp_pack.v_cota);
  emp_pack.v_cota:=emp_pack.v_cota+1;
  dbms_output.put_line('v2='||emp_pack.v_cota);
  emp_pack.del_employee(150);
  if emp_pack.v_cota>25 then
    raise_application_error(-20001,'Cota de impozit prea mare');
  end if;  
  
  exception
     when emp_pack.exc_cota then
        dbms_output.put_line('A aparut exceptia '||sqlerrm);     
end;
/


create or replace PACKAGE BODY emp_pack AS  
   CURSOR disp_emp RETURN EmpRecTyp IS
      SELECT id_angajat,salariul,prenume FROM angajati ORDER BY salariul DESC;
   PROCEDURE increase_sal (
      id    NUMBER,
      sal_increase    NUMBER,
      new_sal out   NUMBER
      ) IS
   BEGIN
     update angajati
       SET salariul = salariul +sal_increase where id_angajat=id
       returning salariul into new_sal;
   END increase_sal;
   
   function get_with_vat(val number,p_cota number) return number is
    begin
     return val+val*p_cota;
  end;
  -- o functie/procedure privata trebuie mai intai declarata si dupa aceea
  -- apelata in cadrul pachetului
 
   
   PROCEDURE del_employee (id NUMBER) IS
   BEGIN
      dbms_output.put_line(get_with_vat(100,0.25));
      DELETE FROM angajati WHERE id_angajat = id;
   END del_employee;
   
  function get_with_vat(val number) return number is
    begin
     return val+val*v_cota;
  end;
  
  
  
    
begin
 --v_cota:=21;
 select count(*) into v_cota from functii;
 insert into regiuni values(reg_id.nextval,'Region '||reg_id.currval);
END emp_pack;
/

declare
  v_new_sal number;
begin
    
    for r in emp_pack.disp_emp loop
      dbms_output.put_line(r.id||' '||r.sal||' '||r.pren);
    end loop;
    emp_pack.del_employee(150);
    if sql%found then dbms_output.put_line('angajatul a fost sters');
    end if;
    emp_pack.increase_sal(155,5,v_new_sal);
    dbms_output.put_line('sal nou='||v_new_sal);
    
end;
/


begin
 dbms_output.put_line(emp_pack.get_with_vat(100));
 dbms_output.put_line(emp_pack.get_with_vat(110));
 dbms_output.put_line(emp_pack.get_with_vat(120));
 dbms_output.put_line(emp_pack.get_with_vat(200,0.25));
end;
/

select * from regiuni;

