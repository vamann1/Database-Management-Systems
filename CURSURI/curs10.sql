CREATE OR REPLACE PROCEDURE get_total_orders
(p_id_cl comenzi.ID_CLIENT%type default null)
IS
v_val number;
BEGIN
Select sum(pret*cantitate) into v_val from rand_comenzi i,comenzi o 
where i. id_comanda=o. id_comanda and o. ID_CLIENT=nvl(p_id_cl,ID_CLIENT);
Dbms_output.put_line('Total value= '||v_val);
END;
/
set serveroutput on
CALL get_total_orders(109);
EXEC get_total_orders(109);
begin
get_total_orders;
end;
/


CREATE OR REPLACE PROCEDURE get_total_orders_o
(p_id_cl IN comenzi.ID_CLIENT%type, p_val out number) is
BEGIN
Select nvl(sum(pret*cantitate),0) into p_val from rand_comenzi i,comenzi o 
where i. id_comanda=o. id_comanda and o. ID_CLIENT=p_id_cl;
--Dbms_output.put_line('Total value= '||p_val);
END;
/
declare  
n number;
begin
get_total_orders_o(109,n);
dbms_output.put_line('Value='||n);
end;
/

VARIABLE n NUMBER
EXECUTE get_total_orders_o(109,:n)
print n 

VARIABLE n NUMBER
call get_total_orders_o(109,:n);
print n 


CREATE OR REPLACE PROCEDURE test_exc 
IS
BEGIN
raise zero_divide;
END;
/

call test_exc()
execute test_exc

begin
test_exc;
 exception 
   when zero_divide then
     dbms_output.put_line('a aparut o exeptie');
end;
/



CREATE OR REPLACE PROCEDURE test_authid(n out number) authid current_user
IS
BEGIN
select count(*) into n from angajati;
END;
/

grant execute on test_authid to vlad_eng;
grant select on angajati to vlad_eng;

CREATE OR REPLACE PROCEDURE test_at(p_id number) IS
pragma AUTONOMOUS_TRANSACTION;
BEGIN
update angajati e set e.salariul=e.salariul+10 where e.id_angajat=p_id;
commit;
END;
/

declare 
 s number;
begin
 select salariul into s from angajati where id_angajat=120;
 dbms_output.put_line('Before='||s);
 test_at(120);
 select salariul into s from angajati where id_angajat=120;
 dbms_output.put_line('After='||s);
 exception when others then null;
end;
/
CREATE OR REPLACE FUNCTION check_salary 
(p_id angajati.id_angajat%type, p_sal number)
RETURN Boolean 
IS
v_salariul angajati.salariul%type;
BEGIN
SELECT salariul into v_salariul from angajati where id_angajat=p_id;
IF p_sal > v_salariul then
return true;
ELSE
return false;
end if;
EXCEPTION
WHEN no_data_found THEN
return NULL;
end;
/

select check_salary(109,5000) from dual ;

declare
  v boolean;
begin
   v:=check_salary(109,5000);
end;
/


select check_salary_n(1009,50000) from dual;

select id_angajat,nume,salariul,check_salary_n(id_angajat,5000) from angajati;

delete from angajati where check_salary_n(id_angajat,5000)=-1;
select * from comenzi where check_salary_n(id_angajat,5000)=-1;
delete from comenzi where check_salary_n(id_angajat,5000)=-1;


create or replace function get_dept_emps(p_dep in number) return sys_refcursor is
  dep sys_refcursor;
begin
      open dep for 'select nume,prenume from angajati where id_departament = :1' using p_dep;
      return dep;
end;
/

variable x refcursor
exec :x:=get_dept_emps(80)
print x

declare
 x sys_refcursor;
begin
 x:=get_dept_emps(80);
 for r in x loop
   dbms_output.put_line(r.nume||' '||r.prenume);
end loop;
end;
/


set serveroutput on
declare
 x sys_refcursor;
 f_n varchar2(25);
 f_l varchar2(25);
begin
 x:=get_dept_emps(80);
 loop
 fetch x into f_n,f_l;
 exit when x%notfound;
   dbms_output.put_line(f_n||' '||f_l);
 end loop;
end;
/

CREATE OR REPLACE FUNCTION fibonacci(n NUMBER)
RETURN NUMBER
RESULT_CACHE -- If the cache contains the result from a previous call to the function with the same parameter values, the system returns the cached result to the invoker and does not reexecute the function body.
IS
BEGIN
IF n = 0 THEN
RETURN 0;
elsif n = 1 then return 1;
ELSE
RETURN fibonacci(n - 1) + fibonacci(n - 2);
END IF;
END;
/

variable x number
exec :x:=fibonacci(35)
print x

