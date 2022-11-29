CREATE DATABASE ExerciciodeRevisao7
USE ExerciciodeRevisao7
CREATE TABLE cliente (
RG varchar(20) not null,
CPF char(11) not null,
nome varchar (40) not null,
logradouro varchar (150) not null,
numero int not null
PRIMARY KEY (RG)
)
GO
CREATE TABLE pedido (
nota_fiscal int not null,
valor int not null,
data date not null,
Rg_cliente varchar(20) not null,
PRIMARY KEY (nota_fiscal),
Foreign Key (RG_cliente)   
 References cliente (RG)
)
GO
CREATE TABLE fornecedor (
codigo        int                not null,
nome        varchar(20)        not null,
logradouro    varchar(100)    not null,
numero        int                null,
pais        varchar(5)        not null,
area        int                not null,
telefone    char(11)        null,
cnpj        char(13)        null,
cidade        varchar(30)        null,
transporte    varchar(30)        null,
moeda        varchar(5)        not null
Primary key (codigo)
)
Go

CREATE TABLE mercadoria (
codigo int not null,
descricao varchar (30) not null,
preco decimal (7,2) not null,
qtd int not null,
cod_fornecedor int not null
PRIMARY KEY (codigo) ,
Foreign Key (cod_fornecedor)    
References fornecedor (codigo)
)
GO

INSERT INTO cliente Values
('29531844',    34519878040,    'Luiz André',    'R. Astorga',    500),
('13514996x',    84984285630, 'Maria Luiza',    'R. Piauí',    174),
('121985541',    23354997310,     'Ana Barbara',    'Av. Jaceguai',    1141),
('23987746x',    43587669920,    'Marcos Alberto',    'R. Quinze',    22)
Go

INSERT INTO pedido Values
(1001,    754, '2018-04-01',    '121985541'),
(1002,    350, '2018-04-02',    '121985541'),
(1003,    30,    '2018-04-02',    '29531844'),
(1004,    1500,    '2018-04-03', '13514996x')
Go


INSERT INTO fornecedor Values
(1,    'Clone',    'Av. Nações Unidas, 12000',    12000,    'BR',    55,    1141487000,    NULL,    'São Paulo',    NULL,    'R$'),
(2,' Logitech',    '28th Street, 100',    100,    'USA',    1,    2127695100,    NULL,    NULL,    'Avião', 'US$'),
(3,    'LG',    'Rod. Castello Branco',    NULL,    'BR',    55,    800664400,    '4159978100001',    'Sorocaba',    NULL,    'R$'),
(4, 'PcChips',    'Ponte da Amizade',    NULL,    'PY',    595,    NULL,    NULL,    NULL,    'Navio',    'US$')
Go

INSERT INTO mercadoria Values
(10, 'Mouse', 24, 30,    1),
(11, 'Teclado',    50,    20,    1),
(12, 'Cx. De Som', 30,    8,    2),
(13, 'Monitor 17', 350, 4,    3),
(14, 'Notebook', 1500, 7, 4)

--Pede-se: (Quando o endereço concatenado não tiver número, colocar só o logradouro e o país, quando tiver colocar, também o número)	
Select Case When numero is null 
       then logradouro + ',' + ' Pais:' + pais
	   else logradouro + ',' + convert(char(5),numero) + ' Pais:' + pais
	   end As endereco_completo
From fornecedor
--Nota: (CPF deve vir sempre mascarado no formato XXX.XXX.XXX-XX e RG Sempre com um traçao antes do último dígito (Algo como XXXXXXXX-X), mas alguns tem 8 e outros 9 dígitos)	
Select Substring(cpf,1,3) + '.' + Substring(cpf,4,3) + '.' + Substring(cpf,7,3) + '-' + Substring(cpf,10,1), Case When Len(rg )= 9 FROM cliente
--Consultar 10% de desconto no pedido 1003	
Select valor * 0.90 As valor_com_desconto
From pedido
Where nota_fiscal = 1003
--Consultar 5% de desconto em pedidos com valor maior de R$700,00	
Select valor * 0.95 As valor_com_desconto
From pedido
Where valor > 700
--Consultar e atualizar aumento de 20% no valor de marcadorias com estoque menor de 10	
Update mercadoria
Set preco = preco * 1.20
Where qtd < 10
--Data e valor dos pedidos do Luiz	
Select data, valor
From pedido Inner Join cliente
On pedido.Rg_cliente = cliente.RG
Where nome Like 'Luiz%'
--CPF, Nome e endereço concatenado do cliente de nota 1004	
Select cpf, nome, logradouro + ',' + convert(char(5),numero) As endereco_completo
From cliente Inner Join pedido
On cliente.RG = pedido.Rg_cliente
Where nota_fiscal = 1004
--País e meio de transporte da Cx. De som	
Select pais, transporte
From fornecedor Inner Join mercadoria
On fornecedor.codigo = mercadoria.cod_fornecedor
Where descricao = 'Cx. De Som'
--Nome e Quantidade em estoque dos produtos fornecidos pela Clone	
Select descricao, qtd
From mercadoria Inner Join fornecedor
On mercadoria.cod_fornecedor = fornecedor.codigo
Where nome =  'Clone'
--Endereço concatenado e telefone dos fornecedores do monitor. (Telefone brasileiro (XX)XXXX-XXXX ou XXXX-XXXXXX (Se for 0800), Telefone Americano (XXX)XXX-XXXX)	
Select logradouro + ',' + num As endereco_completo, Case When telefone = 10 
													Then '(' + Substring(telefone,1,2) + ')' + Substring(telefone,3,4) + '-' + Substring(telefone,7,4)
													Else telefone 
--Tipo de moeda que se compra o notebook	
Select moeda
From fornecedor Inner Join mercadoria
On fornecedor.codigo = mercadoria.cod_fornecedor
Where descricao = 'Notebook'

