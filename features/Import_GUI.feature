Feature: importing student data
  As a professor
  I want to upload student data from a spreadsheet to a class I have access to
  so that I can input information more easily

  Scenario: importing spreadsheet (successfull)
    Given I am logged in as a professor who has access to the class "ESS 2025.2"
    And   the class "ESS 2025.2" has a student of name, login, discord, github: 
            "Maria Andrade da Silva" "MAS3" "Mandrade" "mas3_"
    And   the spreadsheet has a student of name, login, discord, github: 
            "Cris de Trindade Rocha" "CTR" "Crizin" "Cris___"
    When I try to import the spreadsheet into the class "ESS 2025.2"
    Then  the class "ESS 2025.2" has a student of name, login, discord, github: 
            "Maria Andrade da Silva" "MAS3" "Mandrade" "mas3_"
    And   the class "ESS 2025.2" has a student of name, login, discord, github: 
            "Cris de Trindade Rocha" "CTR" "Crizin" "Cris___"
    And   I see the message "Importação bem sucedida!"

  Scenario: importing spreadsheet (existing student)
    Given I am logged in as a professor who has access to the class "ESS 2025.2"
    And   the class "ESS 2025.2" has a student of login "JPMS"
    And   the class "ESS 2025.2" has a student of login "MAS3"
    And   the spreadsheet has a student of login "MAS3"
    When I try to import the spreadsheet into the class "ESS 2025.2"
    Then the class "ESS 2025.2" has a student of login "JPMS"
    And  the class "ESS 2025.2" has a student of login "MAS3"
    And  I see the message "Erro na importação (login de 1 aluno repetido)"

  Scenario: importing spreadsheet (empty spreadsheet)
    Given I am logged in as a professor who has access to the class "ESS 2025.2"
    And   the class "ESS 2025.2" has a student of login "JPMS"
    And   the class "ESS 2025.2" has a student of login "MAS3"
    And   the spreadsheet has no students
    When I try to import the spreadsheet into the class "ESS 2025.2"
    Then the class "ESS 2025.2" has a student of login "JPMS"
    And  the class "ESS 2025.2" has a student of login "MAS3"
    And  I see the message "Erro na importação (planilha vazia)"

  Scenario: importing spreadsheet (one student has an invalid login [empty])
    Given I am logged in as a professor who has access to the class "ESS 2025.2"
    And   the class "ESS 2025.2" has a student of login "JPMS"
    And   the class "ESS 2025.2" has a student of login "MAS3"
    And   the spreadsheet has a student of login " "
    When I try to import the spreadsheet into the class "ESS 2025.2"
    Then the class "ESS 2025.2" has a student of login "JPMS"
    And  the class "ESS 2025.2" has a student of login "MAS3"
    And  I see the message "Erro na importação (login de 1 aluno inválido [login vazio])"

  Scenario: importing spreadsheet (one student has an invalid login [too long])
    Given I am logged in as a professor who has access to the class "ESS 2025.2"
    And   the class "ESS 2025.2" has a student of login "JPMS"
    And   the class "ESS 2025.2" has a student of login "MAS3"
    And   the spreadsheet has a student whose login has 17 characters
    When I try to import the spreadsheet into the class "ESS 2025.2"
    Then the class "ESS 2025.2" has a student of login "JPMS"
    And  the class "ESS 2025.2" has a student of login "MAS3"
    And  I see the message "Erro na importação (login de 1 aluno inválido [login muito longo, máximo 16])"

  Scenario: importing spreadsheet (one student has an invalid login [type error])
    Given I am logged in as a professor who has access to the class "ESS 2025.2"
    And   the class "ESS 2025.2" has a student of login "JPMS"
    And   the class "ESS 2025.2" has a student of login "MAS3"
    And   the spreadsheet has a student of login 7
    When I try to import the spreadsheet into the class "ESS 2025.2"
    Then the class "ESS 2025.2" has a student of login "JPMS"
    And  the class "ESS 2025.2" has a student of login "MAS3"
    And  I see the message "Erro na importação (login de 1 aluno inválido [tipo de valor, esperava string])"
