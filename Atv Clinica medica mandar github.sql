DROP DATABASE IF EXISTS db_clinicaMedica; -- Dropando o banco para deixar mais eficiente rodar o banco

/*EXERCICIO 1 */
CREATE DATABASE IF NOT EXISTS db_clinicaMedica; -- Criando o banco

USE db_clinicaMedica; -- acho que talvez seria melhor eu criar uma tabela separa só para telefone

/*EXERCICIO 2*/
CREATE TABLE IF NOT EXISTS tb_paciente ( -- Criando a tabela de paciente
	id_paciente INT NOT NULL AUTO_INCREMENT,
    nome_paciente VARCHAR(255),
    cpf_paciente char(11) unique, -- somente numeros do cpf
    dt_nascimento_paciente date,
    telefone_paciente char(11) unique, -- somente numeros do telefone
    endereco_paciente varchar(255),
    
	constraint pk_paciente primary key (id_paciente)
);

    create table if not exists tb_especialidade( -- Criando tabela da especialidade 
    id_especialidade int not null auto_increment,
    nome_especialidade varchar(60),
    
    constraint pk_especialidade primary key (id_especialidade)
    );


create table if not exists tb_medico ( -- Criando a tabela dos medicos
	id_medico int not null auto_increment,
    nome_medico varchar(255),
    crm_medico varchar(15) unique, -- exemplo de CRM (123456/SP)
    id_especialidade int,
    telefone_medico char(11) unique, 
    
    constraint pk_medico primary key (id_medico),
    foreign key (id_especialidade) references tb_especialidade(id_especialidade) on delete cascade -- EXERCICIO 3
    );
    
    create table if not exists tb_consulta ( -- Crindo a tabela de consultas
		id_consulta int not null auto_increment,
        id_paciente int,
        id_medico int,
        data_consulta date,
        hora_consulta time,
        observacoes text,
        
        constraint pk_consulta primary key (id_consulta),
		foreign key (id_paciente) references tb_paciente(id_paciente) on delete cascade, -- EXERCICIO 3
        foreign key (id_medico) references tb_medico(id_medico) on delete cascade -- EXERCICIO 3
	);
    
    show tables;
    
    -- ----------------------------------------------------------------------------------------------
    -- inserindo dados EXERCICIO 4 E ALGUNS DO 5
    
    
    insert into tb_especialidade (nome_especialidade) values
    ('Dentista'),
    ('Oftalmologista'),
    ('Ortopedista');
    
    insert into tb_paciente (nome_paciente, cpf_paciente, dt_nascimento_paciente, telefone_paciente, endereco_paciente) values
    ('Danton Meireles', '12345678900', '1111-11-11', '13912345696', 'Minha casa, numero tal, ap tal'),
    ('Carlos Pereira', '98765432100', '1985-10-20', '11988887777', 'Rua B, 456'),
	('Fernanda Lima', '11122233344', '2000-02-10', '11977776666', 'Rua C, 789'),
	('Ricardo Alves', '55566677788', '1975-12-25', '11966665555', 'Rua D, 101'),
	('Juliana Costa', '99988877766', '1995-07-30', '11955554444', 'Rua E, 202');
    
    insert into tb_medico (nome_medico, crm_medico, id_especialidade, telefone_medico) values
    ('Dr. Paulo Muzy', 'CRM12345/SP', 3, '11987654321'),
	('Dra. Deide da Silva', 'CRM54321/MG', 2, '11912345678'),
	('Dr. Pericles', 'CRM67890/PA', 1, '11955554444');
    
    insert into tb_consulta (id_paciente, id_medico, data_consulta, hora_consulta, observacoes) values
    (1, 1, '2025-02-20', '15:30:00', 'Paciente quer fazer uma avaliação geral'),
    (2, 2, '2023-10-11', '10:30:00', 'Paciente quer fazer exame de vista'),
	(3, 3, '2023-10-12', '09:00:00', 'Paciente quer clarear os dentes'),
	(4, 1, '2023-10-13', '15:00:00', 'Se se se'),
    (4, 2, '2023-10-15', '19:00:00', 'SLA SLA SLA'),
	(5, 2, '2023-10-14', '11:00:00', 'Paciente a');
    
select * from tb_consulta;
select * from tb_especialidade;
select * from tb_medico;
select * from tb_paciente;

/*EXERCICIO 5 FINAL*/

/* MOSTRANDO DUAS FORMAS DE EXIBIR TODOS OS MEDICOS DE UMA DETERMINADA ESPECIALIDADE*/
select * from tb_medico 
	where id_especialidade = 1;

select * from tb_medico m -- Selecionei tudo da tabela medico [m = tb_medico, é um apelido/alias]
	join tb_especialidade e -- Fiz um join para combinar os dados de duas ou mais tabelas [e = tb_especialidade, é um apelido/alias]
		on m.id_especialidade = e.id_especialidade -- ON é uma condição de junção, indica que as tabelas estão relacionada de alguma forma
			where e.nome_especialidade = 'Dentista'; -- WHERE é para buscar a informação que eu quero

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* MOSTRANDO DUAS FORMAS DE EXIBIR TODAS AS CONSULTAS DE UM PACIENTE ESPECIFICO*/
select * from tb_consulta -- Exibindo todas as consultas do paciente com id n° 4
	where id_paciente = 4;
    
select c.data_consulta, c.hora_consulta, c.observacoes, -- Selecionei data, hora e observação da tabela consulta
 m.nome_medico as medico, -- selecionei o nome do medico
 e.nome_especialidade as especialidade -- selecionei a especialidade do medico
	from tb_consulta c -- Tabela principal (consulta), com alias 'c'
		join tb_medico m on c.id_medico = m.id_medico -- Relacionei a consulta com a tabela médico, onde o id_medico na consulta deve ser igual ao id_medico na tabela tb_medico
			join tb_especialidade e on m.id_especialidade = e.id_especialidade -- Relacionei a tabela médico com a tabela especialidade, conectando pela coluna id_especialidade
				where c.id_paciente = ( -- Filtro para selecionar apenas consultas de um paciente específico
                select id_paciente from tb_paciente where nome_paciente = 'Danton Meireles'); -- Subconsulta para buscar o id_paciente de quem tem o nome 'Danton Meireles'
 
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
 /* MOSTRANDO DUAS FORMAS DE EXIBIR QUAIS PACIENTES FORAM ATENDIDOS POR UM MEDICO ESPECIFICO*/
select * from tb_consulta -- Exibindo quais pacientes foram atendidos por um medico especifico, nesse caso é o medico com id°1
	where id_medico = 1;
    
select p.nome_paciente as Nome_Paciente, p.id_paciente as pacienteID, -- Selecionei o nome e o id do paciente da tabela paciente
	c.data_consulta, c.hora_consulta
		from tb_consulta c -- Tabela Principal consulta
			join tb_paciente p on c.id_paciente = p.id_paciente
				where c.id_medico = (
				select id_medico from tb_medico where nome_medico = 'Dr. Paulo Muzy');