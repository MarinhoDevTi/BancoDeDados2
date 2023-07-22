drop database IF EXISTS subprova2;
create database subprova2;
use subprova2;   

 create table conta (
        conta_ID integer not null auto_increment,
        SALDO float,
        DATA_ENCERRAMENTO date,
        DATA_ULTIMA_ATIVIDADE date,
        DATA_ABERTURA date not null,
        SALDO_PENDENTE float,
        SITUACAO varchar(10),
        CLIENTE_ID integer,
        FILIAL_ID_ABERTURA integer not null,
        EMP_ID_ABERTURA integer not null,
        PRODUTO_CD varchar(10) not null,
        primary key (conta_ID)
    );

    create table transacao (
        TRANS_ID bigint not null auto_increment,
        VALOR float not null,
        DATA_DISPONIBILIDADE_FUNDOS datetime not null,
        DATA_TRANS datetime not null,
        TIPO_TRANS_CD varchar(10),
        conta_ID integer,
        FILIAL_ID_EXECUTADA integer,
        EMP_ID_CAIXA integer,
        primary key (TRANS_ID)
    );

    create table filial (
        FILIAL_ID integer not null auto_increment,
        ENDERECO varchar(30),
        CIDADE varchar(20),
        NOME varchar(20) not null,
        ESTADO varchar(10),
        CODIGO_POSTAL varchar(12),
        primary key (FILIAL_ID)
    );

    create table negocio (
        CLIENTE_ID integer not null,
        DATA_INCORPORACAO date,
        NOME varchar(255) not null,
        ESTADO_ID varchar(10) not null,
        primary key (CLIENTE_ID)
    );

    create table cliente (
        CLIENTE_ID integer not null auto_increment,
        ENDERECO varchar(30),
        CIDADE varchar(20),
        TIPO_CLIENTE varchar(1) not null,
        CLASSIFICACAO_ID varchar(12) not null,
        CODIGO_POSTAL varchar(10),
        ESTADO varchar(20),
        primary key (CLIENTE_ID)
    );

    create table departamento (
        DEPTO_ID integer not null auto_increment,
        NOME varchar(20) not null,
        primary key (DEPTO_ID)
    );

    create table empregado (
        EMP_ID integer not null auto_increment,
        DATA_FIM date,
        PRIMEIRO_NOME varchar(20) not null,
        ULTIMO_NOME varchar(20) not null,
        DATA_INICIO date not null,
        TITULO varchar(20),
        FILIAL_ID_ATRIBUIDO integer,
        DEPTO_ID integer,
        SUPERIOR_EMP_ID integer,
        primary key (EMP_ID)
    );

    create table individual (
        DATA_ANIVERSARIO date,
        PRIMEIRO_NOME varchar(30) not null,
        ULTIMO_NOME varchar(30) not null,
        CLIENTE_ID integer not null,
        primary key (CLIENTE_ID)
    );

    create table representante (
        REP_ID integer not null auto_increment,
        DATA_FIM date,
        PRIMEIRO_NOME varchar(30) not null,
        ULTIMO_NOME varchar(30) not null,
        DATA_INICIO date not null,
        TITULO varchar(20),
        CLIENTE_ID integer,
        primary key (REP_ID)
    );

    create table produto (
        PRODUTO_CD varchar(10) not null,
        DATA_OFERTA date,
        DATA_EXPIRACAO date,
        NOME varchar(50) not null,
        TIPO_PRODUTO_CD varchar(255),
        primary key (PRODUTO_CD)
    );

    create table tipo_produto (
        TIPO_PRODUTO_CD varchar(255) not null,
        NOME varchar(50),
        primary key (TIPO_PRODUTO_CD)
    );

    alter table conta 
        add constraint conta_CLIENTE_FK 
        foreign key (CLIENTE_ID) 
        references cliente (CLIENTE_ID);

    alter table conta 
        add constraint conta_FILIAL_FK 
        foreign key (FILIAL_ID_ABERTURA) 
        references filial (FILIAL_ID);

    alter table conta 
        add constraint conta_EMPREGADO_FK 
        foreign key (EMP_ID_ABERTURA) 
        references empregado (EMP_ID);

    alter table conta 
        add constraint conta_PRODUTO_FK 
        foreign key (PRODUTO_CD) 
        references produto (PRODUTO_CD);

    alter table transacao 
        add constraint ACC_TRANSACTION_conta_FK 
        foreign key (conta_ID) 
        references conta (conta_ID);

    alter table transacao 
        add constraint ACC_TRANSACTION_FILIAL_FK 
        foreign key (FILIAL_ID_EXECUTADA) 
        references filial (FILIAL_ID);

    alter table transacao 
        add constraint ACC_TRANSACTION_EMPREGADO_FK 
        foreign key (EMP_ID_CAIXA) 
        references empregado (EMP_ID);

    alter table negocio 
        add constraint NEGOCIO_EMPREGADO_FK 
        foreign key (CLIENTE_ID) 
        references cliente (CLIENTE_ID);

    alter table empregado 
        add constraint EMPREGADO_FILIAL_FK 
        foreign key (FILIAL_ID_ATRIBUIDO) 
        references filial (FILIAL_ID);

    alter table empregado 
        add constraint EMPREGADO_DEPARTAMENTO_FK 
        foreign key (DEPTO_ID) 
        references departamento (DEPTO_ID);

    alter table empregado 
        add constraint EMPREGADO_EMPREGADO_FK 
        foreign key (SUPERIOR_EMP_ID) 
        references empregado (EMP_ID);

    alter table individual 
        add constraint INDIVIDUAL_CLIENTE_FK 
        foreign key (CLIENTE_ID) 
        references cliente (CLIENTE_ID);

    alter table representante
        add constraint REPRESENTANTE_CLIENTE_FK 
        foreign key (CLIENTE_ID) 
        references cliente (CLIENTE_ID);

    alter table produto 
        add constraint PRODUTO_TIPO_PRODUTO_FK 
        foreign key (TIPO_PRODUTO_CD) 
        references tipo_produto (TIPO_PRODUTO_CD);


 

-- begin data population


-- SET MODE -- 
-- 
SET SQL_SAFE_UPDATES = 0;


-- departamento data  
insert into departamento (depto_id, nome) values (null, 'Operations');
insert into departamento (depto_id, nome) values (null, 'Loans');
insert into departamento (depto_id, nome) values (null, 'Administration');
insert into departamento (depto_id, nome) values (null, 'IT');

/* filial data */
insert into filial (filial_id, nome, endereco, cidade, estado, Codigo_Postal)
values (null, 'Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451');
insert into filial (filial_id, nome, endereco, cidade, estado, Codigo_Postal)
values (null, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801');
insert into filial (filial_id, nome, endereco, cidade, estado, Codigo_Postal)
values (null, 'Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169');
insert into filial (filial_id, nome, endereco, cidade, estado, Codigo_Postal)
values (null, 'So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');

/* empregado data */
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Michael', 'Smith', '2001-06-22', 
  (select depto_id from departamento where nome = 'Administration'), 
  'President', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Susan', 'Barker', '2002-09-12', 
  (select depto_id from departamento where nome = 'Administration'), 
  'Vice President', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Robert', 'Tyler', '2000-02-09',
  (select depto_id from departamento where nome = 'Administration'), 
  'Treasurer', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Susan', 'Hawthorne', '2002-04-24', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Operations Manager', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'John', 'Gooding', '2003-11-14', 
  (select depto_id from departamento where nome = 'Loans'), 
  'Loan Manager', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Helen', 'Fleming', '2004-03-17', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Head Teller', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Chris', 'Tucker', '2004-09-15', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Sarah', 'Parker', '2002-12-02', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Jane', 'Grossman', '2002-05-03', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Headquarters'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Paula', 'Roberts', '2002-07-27', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Head Teller', 
  (select filial_id from filial where nome = 'Woburn Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Thomas', 'Ziegler', '2000-10-23', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Woburn Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Samantha', 'Jameson', '2003-01-08', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Woburn Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'John', 'Blake', '2000-05-11', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Head Teller', 
  (select filial_id from filial where nome = 'Quincy Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Cindy', 'Mason', '2002-08-09', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Quincy Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Frank', 'Portman', '2003-04-01', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'Quincy Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Theresa', 'Markham', '2001-03-15', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Head Teller', 
  (select filial_id from filial where nome = 'So. NH Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Beth', 'Fowler', '2002-06-29', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'So. NH Branch'));
insert into empregado (emp_id, Primeiro_Nome, Ultimo_Nome,data_inicio, depto_id, titulo, filial_id_atribuido)
values (null, 'Rick', 'Tulman', '2002-12-12', 
  (select depto_id from departamento where nome = 'Operations'), 
  'Teller', 
  (select filial_id from filial where nome = 'So. NH Branch'));

/* create data for self-referencing foreign key 'superior_emp_id' */
create temporary table emp_tmp as
select emp_id, Primeiro_Nome, Ultimo_Nome from empregado;



update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Smith' and Primeiro_Nome = 'Michael')
where ((Ultimo_Nome = 'Barker' and Primeiro_Nome = 'Susan')
  or (Ultimo_Nome = 'Tyler' and Primeiro_Nome = 'Robert'));
update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Tyler' and Primeiro_Nome = 'Robert')
where Ultimo_Nome = 'Hawthorne' and Primeiro_Nome = 'Susan';
update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Hawthorne' and Primeiro_Nome = 'Susan')
where ((Ultimo_Nome = 'Gooding' and Primeiro_Nome = 'John')
  or (Ultimo_Nome = 'Fleming' and Primeiro_Nome = 'Helen')
  or (Ultimo_Nome = 'Roberts' and Primeiro_Nome = 'Paula') 
  or (Ultimo_Nome = 'Blake' and Primeiro_Nome = 'John') 
  or (Ultimo_Nome = 'Markham' and Primeiro_Nome = 'Theresa')); 
update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Fleming' and Primeiro_Nome = 'Helen')
where ((Ultimo_Nome = 'Tucker' and Primeiro_Nome = 'Chris') 
  or (Ultimo_Nome = 'Parker' and Primeiro_Nome = 'Sarah') 
  or (Ultimo_Nome = 'Grossman' and Primeiro_Nome = 'Jane'));  
update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Roberts' and Primeiro_Nome = 'Paula')
where ((Ultimo_Nome = 'Ziegler' and Primeiro_Nome = 'Thomas')  
  or (Ultimo_Nome = 'Jameson' and Primeiro_Nome = 'Samantha'));   
update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Blake' and Primeiro_Nome = 'John')
where ((Ultimo_Nome = 'Mason' and Primeiro_Nome = 'Cindy')   
  or (Ultimo_Nome = 'Portman' and Primeiro_Nome = 'Frank'));    
update empregado set superior_emp_id =
 (select emp_id from emp_tmp where Ultimo_Nome = 'Markham' and Primeiro_Nome = 'Theresa')
where ((Ultimo_Nome = 'Fowler' and Primeiro_Nome = 'Beth')   
  or (Ultimo_Nome = 'Tulman' and Primeiro_Nome = 'Rick'));    

drop table emp_tmp;

/* produto type data */
insert into tipo_produto (tipo_produto_cd, nome)
values ('conta','Customer contas');
insert into tipo_produto (tipo_produto_cd, nome)
values ('LOAN','Individual and Business Loans');
insert into tipo_produto (tipo_produto_cd, nome)
values ('INSURANCE','Insurance Offerings');

/* produto data */
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('CHK','checking conta','conta','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('SAV','savings conta','conta','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('MM','money market conta','conta','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('CD','certificate of deposit','conta','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('MRT','home mortgage','LOAN','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('AUT','auto loan','LOAN','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('BUS','negocio line of credit','LOAN','2000-01-01');
insert into produto (produto_cd, nome, tipo_produto_cd, DATA_OFERTA)
values ('SBL','small negocio loan','LOAN','2000-01-01');

/* residential cliente data */
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'James', 'Hadley', '1972-04-22' from cliente where CLASSIFICACAO_ID = '111-11-1111';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'Susan', 'Tingley', '1968-08-15' from cliente where CLASSIFICACAO_ID = '222-22-2222';
insert into cliente (cliente_id, classificacao_id, tipo_cliente,   endereco, cidade, estado, codigo_postal)
values (null, '333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'Frank', 'Tucker', '1958-02-06' from cliente where CLASSIFICACAO_ID = '333-33-3333';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'John', 'Hayward', '1966-12-22' from cliente where CLASSIFICACAO_ID = '444-44-4444';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'Charles', 'Frasier', '1971-08-25' from cliente where CLASSIFICACAO_ID = '555-55-5555';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'John', 'Spencer', '1962-09-14' from cliente where CLASSIFICACAO_ID = '666-66-6666';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'Margaret', 'Young', '1947-03-19' from cliente where CLASSIFICACAO_ID = '777-77-7777';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'Louis', 'Blake', '1977-07-01' from cliente where CLASSIFICACAO_ID = '888-88-8888';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458');
insert into individual (cliente_id, Primeiro_Nome, Ultimo_Nome, data_aniversario)
select cliente_id, 'Richard', 'Farley', '1968-06-16' from cliente where CLASSIFICACAO_ID = '999-99-9999';

/* corporate cliente data */
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079');
insert into negocio (cliente_id, nome, estado_id, data_incorporacao) 
select cliente_id, 'Chilton Engineering', '12-345-678', '1995-05-01' from cliente
where CLASSIFICACAO_ID = '04-1111111';
insert into representante (rep_id, cliente_id, Primeiro_Nome, Ultimo_Nome,  titulo, data_inicio)
select null, cliente_id, 'John', 'Chilton', 'President', '1995-05-01'
from cliente
where CLASSIFICACAO_ID = '04-1111111';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887');
insert into negocio (cliente_id, nome, estado_id, data_incorporacao)
select cliente_id, 'Northeast Cooling Inc.', '23-456-789', '2001-01-01' from cliente
where CLASSIFICACAO_ID = '04-2222222';
insert into representante (rep_id, cliente_id, Primeiro_Nome, Ultimo_Nome,  titulo, data_inicio)
select null, cliente_id, 'Paul', 'Hardy', 'President', '2001-01-01'
from cliente
where CLASSIFICACAO_ID = '04-2222222';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079');
insert into negocio (cliente_id, nome, estado_id, data_incorporacao)
select cliente_id, 'Superior Auto Body', '34-567-890', '2002-06-30' from cliente
where CLASSIFICACAO_ID = '04-3333333';
insert into representante (rep_id, cliente_id, Primeiro_Nome, Ultimo_Nome,  titulo, data_inicio)
select null, cliente_id, 'Carl', 'Lutz', 'President', '2002-06-30'
from cliente
where CLASSIFICACAO_ID = '04-3333333';
insert into cliente (cliente_id, classificacao_id, tipo_cliente, endereco, cidade, estado, codigo_postal)
values (null, '04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');
insert into negocio (cliente_id, nome, estado_id, data_incorporacao)
select cliente_id, 'AAA Insurance Inc.', '45-678-901', '1999-05-01' from cliente
where CLASSIFICACAO_ID = '04-4444444';
insert into representante (rep_id, cliente_id, Primeiro_Nome, Ultimo_Nome,  titulo, data_inicio)
select null, cliente_id, 'Stanley', 'Cheswick', 'President', '1999-05-01'
from cliente
where CLASSIFICACAO_ID = '04-4444444';

/* residential conta data */
insert into conta (conta_id, produto_cd, cliente_id, data_abertura, 
  data_ultima_atividade, situacao,filial_id_abertura, emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2000-01-15' open_date, '2005-01-04' last_date,
    1057.75 avail, 1057.75 pend union all
  select 'SAV' prod_cd, '2000-01-15' open_date, '2004-12-19' last_date,
    500.00 avail, 500.00 pend union all
  select 'CD' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
    3000.00 avail, 3000.00 pend) a
where c.CLASSIFICACAO_ID = '111-11-1111';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura, emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2001-03-12' open_date, '2004-12-27' last_date,
    2258.02 avail, 2258.02 pend union all
  select 'SAV' prod_cd, '2001-03-12' open_date, '2004-12-11' last_date,
    200.00 avail, 200.00 pend) a
where c.CLASSIFICACAO_ID = '222-22-2222';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Quincy' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-11-23' open_date, '2004-11-30' last_date,
    1057.75 avail, 1057.75 pend union all
  select 'MM' prod_cd, '2002-12-15' open_date, '2004-12-05' last_date,
    2212.50 avail, 2212.50 pend) a
where c.CLASSIFICACAO_ID = '333-33-3333';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-09-12' open_date, '2005-01-03' last_date,
    534.12 avail, 534.12 pend union all
  select 'SAV' prod_cd, '2000-01-15' open_date, '2004-10-24' last_date,
    767.77 avail, 767.77 pend union all
  select 'MM' prod_cd, '2004-09-30' open_date, '2004-11-11' last_date,
    5487.09 avail, 5487.09 pend) a
where c.CLASSIFICACAO_ID = '444-44-4444';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2004-01-27' open_date, '2005-01-05' last_date,
    2237.97 avail, 2897.97 pend) a
where c.CLASSIFICACAO_ID = '555-55-5555';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-08-24' open_date, '2004-11-29' last_date,
    122.37 avail, 122.37 pend union all
  select 'CD' prod_cd, '2004-12-28' open_date, '2004-12-28' last_date,
    10000.00 avail, 10000.00 pend) a
where c.CLASSIFICACAO_ID = '666-66-6666';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Woburn' limit 1) e
  cross join
 (select 'CD' prod_cd, '2004-01-12' open_date, '2004-01-12' last_date,
    5000.00 avail, 5000.00 pend) a
where c.CLASSIFICACAO_ID = '777-77-7777';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2001-05-23' open_date, '2005-01-03' last_date,
    3487.19 avail, 3487.19 pend union all
  select 'SAV' prod_cd, '2001-05-23' open_date, '2004-10-12' last_date,
    387.99 avail, 387.99 pend) a
where c.CLASSIFICACAO_ID = '888-88-8888';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura,
  emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
    125.67 avail, 125.67 pend union all
  select 'MM' prod_cd, '2004-10-28' open_date, '2004-10-28' last_date,
    9345.55 avail, 9845.55 pend union all
  select 'CD' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
    1500.00 avail, 1500.00 pend) a
where c.CLASSIFICACAO_ID = '999-99-9999';

-- corporate conta data  
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura, emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-09-30' open_date, '2004-12-15' last_date,
    23575.12 avail, 23575.12 pend union all
  select 'BUS' prod_cd, '2002-10-01' open_date, '2004-08-28' last_date,
    0 avail, 0 pend) a
where c.CLASSIFICACAO_ID = '04-1111111';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura, emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Woburn' limit 1) e
  cross join
 (select 'BUS' prod_cd, '2004-03-22' open_date, '2004-11-14' last_date,
    9345.55 avail, 9345.55 pend) a
where c.CLASSIFICACAO_ID = '04-2222222';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura, emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
    38552.05 avail, 38552.05 pend) a
where c.CLASSIFICACAO_ID = '04-3333333';
insert into conta (conta_id, produto_cd, cliente_id, data_abertura,
  data_ultima_atividade, situacao,filial_id_abertura, emp_id_abertura, saldo, saldo_pendente)
select null, a.prod_cd, c.cliente_id, a.open_date, a.last_date, 'ACTIVE',
  e.filial_id, e.emp_id, a.avail, a.pend
from cliente c cross join 
 (select b.filial_id, e.emp_id 
  from filial b inner join empregado e on e.filial_id_atribuido = b.filial_id
  where b.cidade = 'Quincy' limit 1) e
  cross join
 (select 'SBL' prod_cd, '2004-02-22' open_date, '2004-12-17' last_date,
    50000.00 avail, 50000.00 pend) a
where c.CLASSIFICACAO_ID = '04-4444444';

-- put $100 in all checking/savings contas on date conta opened  
insert into transacao (trans_id, data_trans, conta_id, tipo_trans_cd, valor, data_disponibilidade_fundos)
select null, a.data_abertura, a.conta_id, 'CDT', 100, a.data_abertura
from conta a
where a.produto_cd IN ('CHK','SAV','CD','MM');
 
