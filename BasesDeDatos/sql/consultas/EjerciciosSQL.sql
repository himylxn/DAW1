--Proposta 1. Media de unidades vendidas de cada vendedor. O resultado ter� d�as
--columnas, na primeira o n�mero identificador do empregado (vendedor) e nunha
--segunda columna a media de unidades vendidas (campo cantidade) nos seus
--pedidos.
SELECT num_empregado, avg(cantidade) as media
FROM pedido
GROUP BY num_empregado


--� Proposta 2. Prezo m�is barato de produto, prezo m�is caro, prezo medio, suma total
--dos prezos de produto, e n�mero de produtos distintos existentes.
SELECT	min(prezo) as prezo_minimo,
		max(prezo) as prezo_maximo,
		avg(prezo) as prezo_medio,
		sum(prezo) as prezo_total,
		count(identificador) as num_productos

FROM PRODUTO




--� Proposta 3. N�mero de pedidos realizados polo cliente 1103.
SELECT count(numero) as numero_de_pedidos
FROM PEDIDO
WHERE num_cliente = 1103 

--� Proposta 4. N�mero de pedidos realizados por cada cliente. No resultado aparecer�
--o identificador do cliente e na segunda columna o n�mero de pedidos que leva
--feitos cada cliente ata o de agora.
SELECT num_cliente ,count(numero) as numero_de_pedidos
FROM PEDIDO
GROUP BY num_cliente


--� Proposta 5. Repite a consulta anterior, pero agora no resultado s� poder�n aparecer
--os clientes que fixeron m�is de 2 pedidos.

SELECT num_cliente ,count(numero) as numero_de_pedidos
FROM PEDIDO
GROUP BY num_cliente
HAVING count(numero) >= 2

--� Proposta 6. Repite a consulta anterior, pero agora no resultado s� poder�n aparecer
--os clientes que fixeron m�is de 2 pedidos e que ademais te�en unha media de
--unidades mercadas (cantidade) inferior a 10.

SELECT num_cliente ,count(numero) as numero_de_pedidos
FROM PEDIDO
GROUP BY num_cliente
HAVING	count(numero) >= 2 AND
		avg(cantidade) < 10

--� Proposta 7. Cantidade total de sucursais que hai por rexi�n. Aparecer� o nome da
--rexi�n e na mesma columna separado por un gui�n, a cantidade de sucursais
--situadas nesa rexi�n.

SELECT rexion + '-' + count (identificador) as num_        
FROM SUCURSAL
GROUP BY rexion

--Proposta 1. Nome de todos os fabricantes dos que se fixeron pedidos. Debes propo�er
--d�as soluci�ns, unha coa sintaxe coa condici�n de combinaci�n no WHERE, e outra coa
--sintaxe coa condici�n de combinaci�n no FROM.
SELECT DISTINCT f.nome
FROM FABRICANTE f inner join PEDIDO p
	on f.codigo = p.cod_fabricante;


--� Proposta 2. Nome de todos os fabricantes, fix�ranse ou non pedidos. Se tiveron pedidos
--aparecer� o nome e nunha segunda columna o n�mero de pedido. Se dun fabricante se
--fixeron m�is dun pedido, aparecer� tantas veces como pedidos se lle fixeron. No caso de
--non ter pedido, como n�mero de pedido deber� aparecer o valor 99.
SELECT DISTINCT f.nome, isnull(p.numero,99) as num_pedido
FROM FABRICANTE f left join PEDIDO p
	on f.codigo = p.cod_fabricante;


--� Proposta 3. Nome de todos os fabricantes, fix�ranse ou non pedidos. Se tiveron pedidos
--aparecer� o nome e nunha segunda columna o n�mero de pedido. Se dun fabricante se
--fixeron m�is dun pedido, aparecer� tantas veces como pedidos se lle fixeron. No caso de
--non ter pedido, como n�mero de pedido deber� aparecer a frase 'Sen pedidos.'.
SELECT DISTINCT f.nome, isnull(cast(p.numero as varchar(11)),'Sen pedidos') as num_pedido
FROM FABRICANTE f left join PEDIDO p
	on f.codigo = p.cod_fabricante
WHERE p.numero is NULL;

--� Proposta 4. C�digo dos produtos (co formato cod_fabricante-id_produto) e descrici�n, dos
--produtos que non foron pedidos nunca.
SELECT p.cod_fabricante, p.id_produto, pr.descricion
FROM PRODUTO pr inner join PEDIDO p
	on p.cod_fabricante = pr.cod_fabricante
WHERE pr.existencias=0;


--� Proposta 5. Produto cartesiano entre a t�boa de sucursais e a de empregados. Nunha
--primeira columna aparecer� a cidade da sucursal e na segunda o nome completo do
--empregado (co formato nome ape1 ape2). D�bense propo�er d�as soluci�ns, segundo a
--sintaxe empregada para o produto cartesiano.
SELECT s.cidade ,e.nome + ' ' + e.ape1 + ' ' + ISNULL(e.ape2,' ') as nome_completo
FROM SUCURSAL s join EMPREGADO e
	on s.identificador = e.id_sucursal_traballa
order by e.nome;



--� Proposta 6. N�mero e nome completo (co formato nome ape1 ape2) de todos os
--empregados, as� como a cidade da sucursal que dirixen, se � que dirixen algunha. Na
--terceira columna, de nome sucursal_que_dirixe, nas filas dos empregados que non son
--directores de sucursais, deber� aparecer a frase 'Non � director.'.
SELECT e.nome + ' ' + ape1 + ' ' +  ISNULL( ape2, ' ') as nume_completo, ISNULL(s.cidade, 'Non � director') as sucursal_que_dirixe
FROM EMPREGADO e LEFT JOIN SUCURSAL s
	on e.numero = s.num_empregado_director





--� Proposta 7. N�mero e nome completo dos empregados que te�en xefe, co n�mero e o
--nome completo do seu xefe nunha segunda columna. (Revisa o concepto Autocombinaci�n
--ou Self join). Nas columnas aparecer� o n�mero separado do nome completo por un gui�n.
SELECT	e.numero,e.nome + ' ' + e.ape1 + ' ' + ISNULL (e.ape2, ' ') as nombre_completo, 
		x.numero,x.nome + ' ' + x.ape1 + ' ' + ISNULL (x.ape2, ' ') as nombre_completo_jefe
FROM EMPREGADO e inner join EMPREGADO x
	on e.num_empregado_xefe = x.numero


--� Proposta 8. N�mero e nome completo de todos os empregados, co n�mero e o nome
--completo do seu xefe nunha segunda columna. Nas columnas aparecer�n o n�mero
--separado do nome completo por un gui�n. Se alg�n empregado non tivese xefe, na
--segunda columna debe aparecer a frase 'Xefe por designar.'.
SELECT	cast (e.numero as varchar (3)) + '-' + e.nome + ' ' + e.ape1 + ' ' + ISNULL (e.ape2, ' ') as nombre_completo, 
		ISNULL (cast (x.numero as varchar (3) ) + '-' + x.nome + ' ' + x.ape1 + ' ' + ISNULL (x.ape2, ' '), 'Xefe por designar.') as nombre_completo_jefe
FROM EMPREGADO e left join EMPREGADO x
	on e.num_empregado_xefe = x.numero


--� Proposta 9. Nome completo de todos os empregados co nome do cliente que te�en
--asignado. No caso de que non tivesen ning�n cliente aparecer� no nome do cliente a frase
--'Sen cliente.'. Do mesmo xeito se un cliente non ten empregado asignado, na columna do
--empregado aparecer� 'Sen vendedor.'. � importante que aparezan todos os empregados,
--te�an ou non clientes e todos os clientes te�an ou non empregados.
SELECT isnull (e.nome + ' ' + e.ape1 + ' ' + ISNULL (e.ape2, ' '), 'Sen vendedor') as  nome_empregado, ISNULL (c.nome, 'Sin cliente') as nome_cliente 
FROM EMPREGADO e FULL JOIN CLIENTE c
	on e.numero = c.num_empregado_asignado


--� Proposta 10. Escolle unha das t�as soluci�ns das consultas propostas nas que
--empregaches un LEFT JOIN, e modif�caa usando RIGHT JOIN.
SELECT	cast (e.numero as varchar (3)) + '-' + e.nome + ' ' + e.ape1 + ' ' + ISNULL (e.ape2, ' ') as nombre_completo, 
		ISNULL (cast (x.numero as varchar (3) ) + '-' + x.nome + ' ' + x.ape1 + ' ' + ISNULL (x.ape2, ' '), 'Xefe por designar.') as nombre_completo_jefe
FROM EMPREGADO x RIGHT join EMPREGADO e
	on e.num_empregado_xefe = x.numero


--- SOCIEDADE_CULTURAL EJERCICIO. Nome das actividades co nome completo do profe 
--- que as imparten s� para as actividades que custan mais de 70�. Na primeira columna
--- actividade e na segunda de nombe Docente, aparecer� o nombe completo do docente
--- co formato apelido1, apelido2, nome.

use SOCIEDADE_CULTURAL_Dylan 
SELECT a.nome as Actividade
FROM  ACTIVIDADE a inner join EMPREGADO e
	on a.num_profesorado_imparte= e.numero
WHERE a.prezo>70;

--- Listaxe dos productos da BD ordenados alfabeticamente por descripcion.

use EMPRESA_Dylan

SELECT f.nome, p.descricion
FROM PRODUTO p inner join FABRICANTE f
	on p.cod_fabricante= f.codigo
order by p.descricion




















--SUBCONSULTAS - Consultas propostas na BD EMPRESA.

--� Proposta 1. Nome de todos os fabricantes dos que hai produtos na BD. Non se permite
--usar combinaci�ns nesta consulta.
SELECT f.nome
FROM FABRICANTE f
WHERE codigo IN (SELECT cod_fabricante 
				FROM PRODUTO)

--� Proposta 2. Nome de todos os fabricantes dos que non hai produtos na BD. Non se
--permite usar combinaci�ns nesta consulta.

SELECT  f.nome
FROM FABRICANTE f
WHERE  codigo NOT IN (SELECT cod_fabricante
					 FROM PRODUTO)




--� Proposta 3. N�mero de pedido, cantidade e data de pedido para aqueles pedidos recibidos
--nos d�as en que un novo empregado foi contratado. Non se permite usar combinaci�ns
--nesta consulta.

SELECT p.numero, p.cantidade, p.data_pedido
FROM PEDIDO p
WHERE p.numero IN (SELECT e.numero
					FROM EMPREGADO e
					WHERE p.data_pedido = e.data_contrato)




--� Proposta 4. Cidade e obxectivo das sucursais cuxo obxectivo supera a media das cotas de
--todos os vendedores da BD. Non se permite usar combinaci�ns nesta consulta.

SELECT s.cidade, s.obxectivo
FROM SUCURSAL s
WHERE s.obxectivo > (SELECT AVG (e.cota_de_vendas)
								FROM EMPREGADO e)



--� Proposta 5. N�mero de empregado e cantidade media dos pedidos daqueles empregados
--cuxa cantidade media de pedido � superior � cantidade media global (de todos os
--pedidos). Non se permite usar combinaci�ns nesta consulta.

SELECT p.num_empregado, avg(cantidade) as cantidade_media
FROM PEDIDO p
GROUP BY num_empregado
HAVING avg(cantidade) > (SELECT avg(cantidade) 
					FROM PEDIDO)


--� Proposta 6. Nome dos clientes que a�nda non fixeron pedidos. Non se permite usar
--combinaci�ns nesta consulta.
SELECT c.nome as nome_cliente
FROM CLIENTE c
WHERE c.numero NOT IN (SELECT p.num_cliente
					FROM PEDIDO p)



--� Proposta 7. Nome completo dos empregados cuxas cotas son iguais ou superiores ao
--obxectivo da sucursal da cidade de Vigo. Ten en conta que se a cota dun vendedor
--(empregado) � nula debemos considerala como un 0, e do mesmo xeito actuaremos co
--obxectivo da sucursal. Non se permite usar combinaci�ns nesta consulta.

SELECT e.nome, e.ape1, e.ape2
FROM EMPREGADO e
WHERE isnull (e.cota_de_vendas,0) >= (SELECT isnull (s.obxectivo, 0)
							FROM SUCURSAL s
							WHERE cidade='Vigo')


--� Proposta 8. Nome dos produtos para os que existe polo menos un pedido que ten unha
--cantidade de polo menos 20 unidades. Hai que lembrar que a identificaci�n dun produto
--faise pola combinaci�n do c�digo do fabricante e o do produto. A soluci�n deber� facerse
--empregando o predicado EXISTS cunha subconsulta correlacionada. Non se permite usar
--combinaci�ns.

SELECT p.descricion 
FROM PRODUTO p
WHERE EXISTS (SELECT pe.numero
			FROM PEDIDO pe
			WHERE pe.cantidade >= 20 AND
				p.cod_fabricante = pe.cod_fabricante AND	
					p.identificador = pe.id_produto)






--� Proposta 9. Cidades das sucursais onde exista alg�n empregado cuxa cota de vendas
--represente m�is do 80% do obxectivo da oficina onde traballa. Para resolver esta consulta
--deberase empregar unha subconsulta correlacionada precedida de ANY.

SELECT
FROM
WHERE




--� Proposta 10. Nome dos clientes cuxos empregados asignados traballan en sucursais da
--rexi�n OESTE. Non se poden usar joins, s� subconsultas encadeadas.

