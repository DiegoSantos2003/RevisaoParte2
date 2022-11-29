CREATE DATABASE ExerciciodeRevisao6
USE ExerciciodeRevisao6
CREATE TABLE motorista (
codigo int not null,
nome varchar(40) not null,
data_nascimento date not null,
naturalidade varchar (40)
PRIMARY KEY (codigo)
)
CREATE TABLE onibus (
Placa varchar (7) not null,
marca varchar (20) not null,
ano int not null,
descricao varchar (30) not null
PRIMARY KEY (placa)
)
CREATE TABLE viagem (
codigo int not null,
onibus varchar(7),
motorista int not null,
hora_saida time not null,
hora_chegada time not null,
destino varchar (20) not null
PRIMARY KEY (codigo)
FOREIGN KEY (motorista)
REFERENCES  motorista (codigo),
FOREIGN KEY (onibus)
REFERENCES onibus (placa)
)
INSERT INTO motorista VALUES
( 12341,'    Julio Cesar',    '1978-04-18',    'São Paulo' ),
(12342,'    Mario Carmo',    '2002-07-29',    'Americana'),
(12343,    'Lucio Castro',    '1969-12-01',    'Campinas'),
(12344,'    André Figueiredo',    '1999-05-14','    São Paulo'),
(12345,    'Luiz Carlos ',    '2001-01-09',    'São Paulo')
INSERT INTO onibus VALUES
('adf0965'   ,    'Mercedes'    ,            1999    ,'Leito ' ) ,            
('bhg7654 ' ,     'Mercedes  ' ,             2002    ,'Sem Banheiro '),       
('dtr2093' ,      'Mercedes'  ,              2001    ,'Ar Condicionado'),     
('gui7625',       'Volvo  '  ,               2001    ,'Ar Condicionado ')    
INSERT INTO viagem VALUES
(101,    'adf0965 '  ,    12343,    '10:00',    '12:00'    ,'Campinas'),
(102,    'gui7625'   ,    12341,    '7:00',    '12:00'    ,'Araraquara'),
(103,    'bhg7654 '  ,    12345,    '14:00',    '22:00',    'Rio de Janeiro'),
(104,    'dtr2093'  ,     12344,    '18:00',    '21:00'    ,'Sorocaba')
-- Consultar, da tabela viagem, todas as horas de chegada e saída, convertidas em formato HH:mm (108) e seus destinos
SELECT Convert(CHAR(5),hora_chegada,108)hora_saida, CONVERT (CHAR(5),hora_chegada,108) FROM viagem

-- Consultar, com subquery, o nome do motorista que viaja para Sorocaba
SELECT nome FROM motorista INNER JOIN viagem
ON motorista.codigo = viagem.motorista
WHERE destino = 'Sorocaba'

-- Consultar, com subquery, a descrição do ônibus que vai para o Rio de Janeiro
SELECT descricao FROM onibus INNER JOIN viagem
ON onibus.Placa = viagem.onibus
WHERE destino = 'Rio de Janeiro'
-- Consultar, com Subquery, a descrição, a marca e o ano do ônibus dirigido por Luiz Carlos
SELECT descricao, marca, ano FROM onibus INNER JOIN viagem
ON onibus.Placa = viagem.onibus
INNER JOIN motorista
ON motorista.codigo = viagem.motorista
WHERE nome = 'Luiz Carlos'
--Consultar o nome, a idade e a naturalidade dos motoristas com mais de 30 anos
SELECT nome, DATEDIFF(DAY, data_nascimento, GETDATE())/365, naturalidade FROM motorista 
WHERE  DATEDIFF(DAY, data_nascimento, GETDATE())/365 > 30
