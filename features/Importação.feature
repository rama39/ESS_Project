Feature: importing students
  As a professor
  I want to upload student data from a spreadsheet to the system
  so that I can input information more easily

  Scenario: importing spreadsheet (successfull)
    Given    the system has a student of name "João"  and CPF 123
    And      the system has a student of name "Maria" and CPF 456
    And the spreadsheet has a student of name "Cris"  and CPF 789
    When I try to import the spreadsheet
    Then the system has a student of name "João"  and CPF 123
    And  the system has a student of name "Maria" and CPF 456
    And  the system has a student of name "Cris"  and CPF 789

  Scenario: importing spreadsheet (existing student)
    Given    the system has a student of name "João"  and CPF 123
    And      the system has a student of name "Maria" and CPF 456
    And the spreadsheet has a student of name "Cris"  and CPF 123
    When I try to import the spreadsheet
    Then the system has a student of name "João"  and CPF 123
    And  the system has a student of name "Maria" and CPF 456
    And  I see the message "Erro na importação (CPF de 1 aluno repetido)"

  Scenario: importing spreadsheet (invalid CPF)
    Given    the system has a student of name "João"  and CPF 123
    And      the system has a student of name "Maria" and CPF 456
    And the spreadsheet has a student of name "Cris"  and CPF "789"
    When I try to import the spreadsheet
    Then the system has a student of name "João"  and CPF 123
    And  the system has a student of name "Maria" and CPF 456
    And  I see the message "Erro na importação (CPF de 1 aluno inválido)"

  Scenario: importação de planilha (planilha vazia)
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha não tem alunos
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  eu vejo uma mensagem "Planilha vazia"
    And  a planilha não tem alunos

  Scenario: importação de planilha (um aluno com nome inválido [vazio])
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha tem um aluno " "  de CPF 789
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  eu vejo uma mensagem "Erro na importação (nome de 1 aluno inválido [nome vazio])"

  Scenario: importação de planilha (um aluno com nome inválido [muito longo])
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha tem um aluno com nome de 257 caracteres e CPF 789
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  eu vejo uma mensagem "Erro na importação (nome de 1 aluno inválido [nome muito longo, máximo 256])"

  Scenario: importação de planilha (um aluno com nome inválido [tipo de valor])
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha tem um aluno 200 e CPF 789
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  eu vejo uma mensagem "Erro na importação (nome de 1 aluno inválido [tipo de valor])"
