--� Proposta 1. Aumentar o n�mero de prazas das actividades nun 15%.
use SOCIEDADE_CULTURAL_Dylan
begin tran
select * from ACTIVIDADE;
update ACTIVIDADE
set num_prazas = num_prazas * (num_prazas + 0.15)
select * from ACTIVIDADE;
rollback;



--� Proposta 2. Cambiar o estado da aula de nome AULA SUR a regular (R).
use SOCIEDADE_CULTURAL_Dylan
begin tran
select * from ACTIVIDADE;
update ACTIVIDADE
set num_prazas = num_prazas * (num_prazas + 0.15)
select * from ACTIVIDADE;
rollback;


--� Proposta 3. Engadir unha aula nova de n�mero 9, nome AULA NOVA e con
--superficie e estado os mesmos que os da aula COCI�A.
begin tran
select * from AULA;

insert into AULA (numero,descricion,superficie,estado)
select 9 ,'AULA NOVA', superficie,estado
from AULA
where descricion = 'COCI�A'

select * from AULA;
rollback;


--� Proposta 4. Engadir d�as novas cotas, unha cos datos 21, COTA1, 75 e outra cos
--datos 22, COTA2 e 74.3.
begin tran
select * from COTA;

insert into COTA(codigo, nome, importe)
values	(21,'COTA1',75), 
		(22,'COTA2',74.3);

select * from COTA;
rollback;


--� Proposta 5. Crear unha t�boa temporal global PROFE_ASISTENTE_ACTI co nif, nome
--e primeiro apelido do profesorado que asiste a actividades.
begin tran
select distinct nif,nome, apelido1 
into ##PROFE_ASISTENTE_ACTI
from SOCIO s inner join SOCIO_REALIZA_ACTI sr
	


--� Proposta 6. Crear unha t�boa permanente de nome AULA_MALA coas aulas en mal
--estado (Estado=M) e coas mesmas columnas da t�boa AULA. Os nomes dos campos
--de AULA_MALA ser�n codigo, nome, m2 e estado.
--� Proposta 7. Crear unha t�boa temporal local que sexa unha copia en canto a contido
--e columnas da t�boa ACTIVIDADE e que se chame ACTI2. Antes de pechar a
--transacci�n, farase unha consulta que elimine todas as actividades da t�boa nova
--que non te�an observaci�ns.
--� Proposta 8. Crear unha t�boa temporal local de nome SOCIO2 copia de SOCIO. A
--continuaci�n faremos a consulta que elimine de SOCIO2 aqueles socios que non
--te�en tel�fono alg�n.
--� Proposta 9. Substitu�r os espazos en branco das observaci�ns das actividades, as que
--asisten docentes, por gui�ns baixos(_).
--� Proposta 10. Retrasar nun d�a a data de inicio de t�dalas actividades que a�nda non
--comezaron a d�a de hoxe.
--- Proposta 11. Eliminar os fabricantes dos que non hai produtos na BD.
--� Proposta 12. Incrementar o obxectivo das sucursais da rexi�n OESTE nun 6% e
--modificar o nome da rexi�n por WEST.
--� Proposta 13. Crear unha t�boa de nome FABRICANTE2 que sexa unha copia de
--FABRICANTE en n�mero e nome de columnas e en contido. Elimina todas as filas da
--nova t�boa do xeito m�is r�pido e menos custoso posible.
--� Proposta 14. Transferir todos os empregados que traballan na sucursal de
--BARCELONA � sucursal de VIGO, e cambiar a s�a cota de vendas pola media das
--cotas de vendas de t�dolos empregados.
--� Proposta 15. Elimina os pedidos de empregados contratados antes do ano 2001.