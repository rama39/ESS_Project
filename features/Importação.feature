Feature: importação de alunos
  As a professor
  I want to lançar dados de alunos de uma planilha no sistema
  so that I can inserir informações com mais facilidade

  Scenario: importação de planilha
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha tem um aluno "Cris"  de CPF 789
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  o sistema tem um aluno "Cris"  de CPF 789

  Scenario: importação de planilha (um aluno que já existe)
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha tem um aluno "Cris"  de CPF 123
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  eu vejo uma mensagem "Erro na importação (CPF de 1 aluno repetido)"

  Scenario: importação de planilha (planilha vazia)
    Given o sistema tem um aluno "João"  de CPF 123
    And   o sistema tem um aluno "Maria" de CPF 456
    And  a planilha não tem alunos
    When eu tento importar a planilha
    Then o sistema tem um aluno "João"  de CPF 123
    And  o sistema tem um aluno "Maria" de CPF 456
    And  eu vejo uma mensagem "Planilha vazia"