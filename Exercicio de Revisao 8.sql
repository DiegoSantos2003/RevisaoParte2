CREATE DATABASE ExerciciodeRevisao8
Use ExerciciodeRevisao8
CREATE TABLE Cliente  (
codigo			int					not null,
nome			varchar(50)			not null,
endereco		varchar(80)			not null,
telefone		char(8)				not null,
telefoneC		char(8)					null
Primary key (codigo)
)
CREATE TABLE TipoMercadoria (
codigo			int				not null,
nome			varchar(30)		not null
Primary Key (codigo)
)
CREATE TABLE Compra (
notafiscal			int				not null,
valor				decimal(5,2)	not null,
cliente_codigo		int				not null
Primary Key (notafiscal, valor)
Foreign key (cliente_codigo) References Cliente (codigo)
)
CREATE TABLE Corredor (
codigo				int				not null,
mercadoria_tipo	    int				not null,
nome				varchar(30)			null
Primary key (codigo)
Foreign Key (mercadoria_tipo) References TipoMercadoria (codigo)
)
CREATE TABLE Mercadoria (
codigo				int				not null,
nome				varchar(30)		not null,
valor				decimal(7,2)	not null,
corredor_codigo		int				not null,
mercadoria_tipo		int				not null
Primary key (codigo)
Foreign Key (corredor_codigo) References Corredor (codigo),
Foreign Key (mercadoria_tipo) References TipoMercadoria (codigo)
)
INSERT INTO Cliente Values
(1,	'Luis Paulo',	'R. Xv de Novembro, 100',	'45657878', null),	
(2,	'Maria Fernanda',	'R. Anhaia, 1098',	'27289098',	'40040090'),
(3, 'Ana Claudia',	'Av. Voluntários da Pátria, 876',	'21346548', null),	
(4,	'Marcos Henrique',	'R. Pantojo, 76',	'51425890',	'30394540'),
(5,	'Emerson Souza',	'R. Pedro Álvares Cabral, 97',	'44236545',	'39389900'),
(6,	'Ricardo Santos',	'Trav. Hum, 10',	'98789878', null)
INSERT INTO TipoMercadoria Values 
(10001,	'Pães'),
(10002,	'Frios'),
(10003,	'Bolacha'),
(10004,	'Clorados'),
(10005,	'Frutas'),
(10006,	'Esponjas'),
(10007,	'Massas'),
(10008,	'Molhos')
INSERT INTO Compra Values 
(1234,	2,	200),
(2345,	4,	156),
(3456,	6,	354),
(4567,	3,	19)
INSERT INTO Corredor Values 
(101,	10001,	'Padaria'),
(102,	10002,	'Calçados'),
(103,	10003,	'Biscoitos'),
(104,	10004,	'Limpeza'),
(105,   null,	null	),
(106,	null,	null	),
(107,	10007,	'Congelados')
INSERT INTO Mercadoria Values 
(1001,	'Pão de Forma',	101,	10001,	3.5),
(1002,	'Presunto',	101,	10002,	2.0),
(1003,	'Cream Cracker',	103,	10003,	4.5),
(1004,	'Água Sanitária',	104,	10004,	6.5),
(1005,	'Maçã',	105,	10005,	0.9),
(1006,	'Palha de Aço',	106,	10006,	1.3),
(1007,	'Lasanha',	107,	10007,	9.7)