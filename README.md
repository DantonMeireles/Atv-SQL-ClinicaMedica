# Descrição da Atividade

Você foi contratado para desenvolver o banco de dados de uma clínica médica que precisa armazenar e gerenciar informações sobre seus pacientes, médicos, especialidades e consultas. Para isso, siga as etapas abaixo:  

1️⃣ Criação do Banco de Dados  
Crie um banco de dados chamado ClinicaMedica.  

2️⃣Criação das Tabelas  
: Armazena dados dos pacientes, como ID (autoincrementável e chave primária), nome, CPF, data de nascimento, telefone e endereço.  
: Contém informações dos médicos, incluindo ID (autoincrementável e chave primária) , nome, CRM, especialidade e telefone.  
: Lista as especialidades médicas disponíveis na clínica: id (autoincrementável e chave primária) e nome da especialidade.  
: Registra as consultas agendadas, relacionando médicos e pacientes: id_consulta, id_paciente, id_medico, data_consulta, hora_consulta  

3️⃣ Chaves estrangeiras:  
id_paciente, id_medico, id_especialidade  

4️⃣ Inserção de Dados  
Cada médico pertence a uma única especialidade.  
Um paciente pode marcar várias consultas com diferentes médicos.  
Cada consulta deve conter data, hora e observações.  
 
5️⃣Consultas SQL  
Insira pelo menos cinco pacientes, três médicos, três especialidades e cinco consultas.  
Liste todos os médicos de uma especialidade específica.  
Exiba todas as consultas de um determinado paciente.  
Mostre quais pacientes foram atendidos por um médico específico.  
