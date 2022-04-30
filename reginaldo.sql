CREATE database bibliotecas;
USE bibliotecas;

drop table livros;
drop table editoras;

create table if not exists editoras(
id int primary key auto_increment,
nome varchar(100) not null,
telefone varchar(19) not null,
nome_gerente varchar(100) not null
);

create table if not exists livros (
	id int unsigned primary key auto_increment,
	nome varchar(100) not null,
	preco float(10,2) not null check (preco > 0),
    editora_id int unsigned
);

alter table livros add constraint fk_editora_id foreign key (editora_id) references editoras(id);
alter table livros add column autor varchar(100) not null;

insert into editoras (nome, telefone, nome_gerente) values ("abril","(12) 9 3456-7890","Luan"),
("sextante","(12) 9 3456-7890","matheus"),
("Editora Rocco","(12) 9 3456-7890","fernando"),
("vale das letras","(12) 9 3456-7890","reginaldo");

select * from livros;

insert into livros (nome, autor, preco, editora_id) values ("Pai rico, pai pobre","Robert Kiyosaki",29.99, 1);
insert into livros (nome, autor, preco, editora_id) values ("Memórias Póstumas de Brás Cubas","Machado de Assis",40.00, 2);
insert into livros (nome, autor, preco, editora_id) values ("Manual do Confeiteiro","Edir Macedo",49.99, 3);
insert into livros (nome, autor, preco, editora_id) values ("Harry Potter","J.K. Rowling",9.99, 4);
insert into livros (nome, autor, preco, editora_id) values ("biblia 2","Olavo de Carvalho",399.99, 1);

update livros set nome = "Manual do Chef" where id = 3;

select nome, autor, preco from livros order by nome desc;

select
	livros.nome as livro_nome,
    editoras.nome as editora_nome
from
	livros
inner join
	editoras
on
	livros.editora_id = editoras.id;
    
select 
	livros.nome,
    editora.nome
from
	livros,
    editoras
where
	livros.editora_id = editoras.id;
    
create table if not exists vendas (
	id int unsigned primary key auto_increment,
    nome_vendedor varchar(255) not null,
    quantidade int not null,
    produto varchar(255) not null,
    cidade varchar(255) not null
    );
    
insert into vendas (nome_vendedor, quantidade, produto, cidade) values
("Jorge", 10, "Mouse", "São Paulo"),
("Ana", 06, "Teclado", "Rio de Janeiro"),
("Mario","23","Mouse","Blumenau"),
("Felipe","25","Webcam","Blumenau"),
("João","2","Teclado","Recife"),
("Pedro","3","Monitor","São Paulo"),
("João","5","Monitor","Rio de Janeiro");

select cidade, count(quantidade) from vendas group by cidade order by quantidade desc;
select nome_vendedor, sum(quantidade) from vendas group by nome_vendedor order by quantidade desc;

create table if not exists vendas(
	id_nf int unsigned auto_increment,
    id_item int unsigned not null,
	cod_prod int unsigned not null,
    valor_unit float(10,2) not null,
    qtd int not null,
    desconto int,
    primary key (id_nf,id_item,cod_prod)
);

insert into vendas (id_nf, id_item, cod_prod, valor_unit, qtd, desconto) values
(1,1,1,25.00,10,5),
(1,2,2,13.00,3,null),	
(1,3,3,15.00,2,null),	
(1,4,4,10.00,1,null),
(1,5,5,30.00,1,null),
(2,1,3,15.00,4,null),
(2,2,4,10.00,5,null),
(2,3,5,30.00,7,null),
(3,1,1,25.00,5,null),
(3,2,4,10.00,4,null),
(3,3,5,30.00,5,null),
(3,4,2,13.50,7,null),
(4,1,5,30.00,10,15),
(4,2,4,10.00,12,5),
(4,3,1,25.00,13,5),
(4,4,2,13.00,15,5),
(5,1,3,15.00,3,null),
(5,2,5,30.00,6,null),
(6,1,1,25.00,22,15),
(6,2,3,15.00,25,20),
(7,1,1,25.00,10,3),
(7,2,2,13.50,10,4),
(7,3,3,15.00,10,4),
(7,4,5,30.00,10,1);

select * from vendas;

select id_nf, id_item, cod_prod, valor_unit from vendas where desconto is not null;

select 
id_nf, 
id_item, 
cod_prod, 
valor_unit, 
round(valor_unit-(valor_unit*(desconto/100))) as valor_vendido 
from vendas where desconto is not null;
