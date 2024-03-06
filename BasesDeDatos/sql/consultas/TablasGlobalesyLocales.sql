use SOCIEDADE_CULTURAL_Dylan;

select * into actividade2 -- Tabla permanente creada
from ACTIVIDADE;
select * from ACTIVIDADE;
select * from actividade2;

-- Las tablas temporales se borran cuando se cierra sesion o se borre manualmente.

select * into #actividade3 -- Tabla temporal local (solo se puede acceder desde aqui)
from ACTIVIDADE;

select * from #actividade3;


select * into ##actividade3 -- Tabla temporal global (se puede acceder desde cualquier lado)
from ACTIVIDADE;

select * from ##actividade3;









-- 2. Creaci�n de t�boas novas a partires de consultas (SELECT�INTO)

-- Consulta de exemplo 2: Crearase unha t�boa temporal local de nome SOCIO_MOROSO
-- co nif e nome completo dos socios que deben algunha actividade. Ao rematar
-- eliminarase a t�boa nova coa cl�usula DROP TABLE para non modificar o dese�o
-- orixinal da BD.

select DISTINCT s.nif, s.nome, s.ape1, isnull (s.ape2, '') as ape2
	into #consulta2
from SOCIO s inner join SOCIO_REALIZA_ACTI sra
	on s.numero=sra.num_socio
where sra.pagada='N';

select * from #consulta2












-- 3. Inserci�n de filas novas (INSERT)

-- Consulta de exemplo 3: Engadiranse d�as novas cotas de balde, unha con c�digo 20 e
-- nome COTA GRATIS, e a outra con c�digo 30 e nome OUTRA GRATIS. Antes e despois
-- do INSERT faremos a consulta que nos amosa a informaci�n da t�boa en cada
-- momento.
select * from cota;

insert into cota (codigo, nome, importe)
values (20, 'COTA GRATIS', 0),
	   (30, 'OUTRA GRATIS', 0);

-- Consulta de exemplo 4: Engadiranse na t�boa COTA unha nova de nome NOVA e
-- c�digo 80 co mesmo importe que a cota de nome HABITUAL. Antes e despois do
-- INSERT faremos a consulta que nos amosa a informaci�n da t�boa en cada momento

select * from cota;

insert into cota (codigo, nome, importe)
select 80, 'NOVA', importe
from cota
where nome = 'HABITUAL';













-- 4. Eliminaci�n de filas (DELETE e TRUNCATE TABLE)

select * from cota;

delete from cota
where codigo in (20,30,80)

-- Consulta de exemplo 6: Para facer esta consulta primeiro crearemos unha t�boa
-- temporal local SOCIO2 copia da t�boa SOCIO empregando a sentenza SELECT...INTO.
-- Despois teranse que eliminar os socios da t�boa SOCIO2 que deben algunha actividade.
-- A eliminaci�n farase de dous xeitos, nunha primeira soluci�n empregando unha
-- consulta subordinada e, nunha segunda cunha combinaci�n interna. 

select * into #SOCIO2
from SOCIO;

-- consulta subordinada

delete from #SOCIO2
where numero in (select sra.num_socio
				from SOCIO_REALIZA_ACTI sra
				where sra.pagada= 'N')

select * from #SOCIO2


drop table #SOCIO2


-- consulta de combinacion interna

select * into #SOCIO2 --creamos nueva tabla temporal
from SOCIO;

select * from #SOCIO2;

delete from #SOCIO2 -- borramos lo que nos pide
from #SOCIO2 s inner join SOCIO_REALIZA_ACTI sra
	on s.numero = sra.num_socio
where sra.pagada='N';

select * from #SOCIO2;



-- VALOR AUTONUMERICO
create table t1(
id int identity (10,15), -- valor autonumerico, el primer numero es COMO EMPIEZA y el segundo es DE CUANTO EN CUANTO VA A IR en este caso 15
saludo varchar(10) not null
);

select * from t1;

insert into t1 (saludo) -- el campo identity al crearse automaticamente no hace falta ponerlo aqui
values	('hola'),
		('bos dias');

drop table t1;











-- 4.2. Sentenza TRUNCATE TABLE
-- (Lo que borramos con trucate table se borra todo y no hay manera de recuperarlo)


-- Consulta de exemplo 7: Para facer esta consulta primeiro crearase unha t�boa
-- EMPREGADO2, copia da t�boa EMPREGADO coas mesmas filas e columnas. A
-- continuaci�n eliminaremos todas as filas da t�boa nova do xeito m�is r�pido e eficiente
-- posible. Antes e despois do borrado faremos a consulta que nos amosa o n�mero de da
-- t�boa EMPREGADO2 en cada momento. Ao rematar eliminarase a t�boa nova coa
-- cl�usula DROP TABLE para non modificar o dese�o orixinal da BD.

select * into EMPREGADO2 
from EMPREGADO;

truncate table EMPREGADO2; -- borramos todos los campos

select * from EMPREGADO2;

drop table EMPREGADO2;













-- 5. Modificaci�n de contido das filas (UPDATE)
-- Consulta de exemplo 8: Nesta consulta incrementarase o prezo das actividades en 4
-- euros. Para deixar os datos orixinais da BD, faremos unha segunda modificaci�n de
-- reduci�n do prezo en 4 euros. Faremos unha consulta antes e despois do incremento
-- do prezo.

select * from ACTIVIDADE;

update ACTIVIDADE
set prezo = prezo + 4;

select * from ACTIVIDADE;


-- Consulta de exemplo 9: Nesta consulta incrementarase en 7 o n�mero de prazas da
-- actividade con n�mero 10, o seu nome pasar� a ser CURSO TENIS e aumentarase o seu
-- prezo en 5'14%. Para deixar os datos orixinais da BD, faremos unha segunda
-- modificaci�n e a t�boa quedar� como estaba antes da modificaci�n. Faremos unha
-- consulta antes e despois da modificaci�n para comprobar os cambios.

select *
from ACTIVIDADE
where identificador= 10;

update ACTIVIDADE
set num_prazas = num_prazas + 7,
	nome = 'TENIS PARA PRINCIPIENTES',
	prezo = prezo * 1.0514
where identificador = 10;

select *
from ACTIVIDADE
where identificador= 10;


-- Consulta de exemplo 10: Modificarase o prezo das cotas gratis co valor do prezo m�is
-- alto das actividades. Para deixar os datos orixinais da BD, faremos unha segunda
-- modificaci�n e a t�boa quedar� como estaba antes da modificaci�n. Faremos unha
-- consulta antes e despois da modificaci�n para comprobar os cambios.

select * from cota;

update cota
set importe = (select max (prezo) from ACTIVIDADE)
where importe = 0

select * from cota;


-- Consulta de exemplo 11: Por�nselle como pagadas todas as actividades aos socios que
-- te�an abonada a cota anual. Para deixar os datos orixinais da BD, faremos unha
-- segunda modificaci�n e a t�boa quedar� como estaba antes da modificaci�n. Faremos
-- unha consulta antes e despois da modificaci�n para comprobar os cambios.

select * from SOCIO_REALIZA_ACTI
select * from SOCIO;

update SOCIO_REALIZA_ACTI
set pagada='S'
from socio s inner join SOCIO_REALIZA_ACTI sra
	on s.numero = sra.num_socio
where s.abonada='S';


