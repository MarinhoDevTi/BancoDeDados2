DROP DATABASE IF EXISTS voebem;
create database voebem;
use voebem;
create table piloto (
	codigo_piloto int not null AUTO_INCREMENT,
    nome_piloto   varchar(50)  not null,
	salario       numeric(9,2) not null,
	gratificacao  numeric(7,2),
	companhia     varchar(30),
	pais          varchar(15),
    primary key (codigo_piloto));
	
create table aeroporto (
	codigo_aeroporto 	varchar(3)   not null,
	nome_aeroporto 		varchar(100) not null,
	cidade 			varchar(50)  not null,
	pais 			varchar(15)  not null,
	primary key (codigo_aeroporto)
	);
	
create table voo (
	codigo_voo 		varchar(6),
	aeroporto_origem 	varchar(3),
	aeroporto_destino 	varchar(3),
	hora			time,
	primary key (codigo_voo),
	foreign key (aeroporto_origem)  references aeroporto (codigo_aeroporto),
	foreign key (aeroporto_destino) references aeroporto (codigo_aeroporto)
	);

create table escala (
	codigo_voo 		varchar(6) not null,
	data_voo 		Date not null,
	codigo_piloto 	int,
	aviao			varchar(30),
	primary key (codigo_voo, data_voo),
	foreign key (codigo_piloto) references piloto (codigo_piloto),
	foreign key (codigo_voo) references voo(codigo_voo)
	);