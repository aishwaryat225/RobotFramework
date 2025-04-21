*** Settings ***
Documentation       This is some basic info about the whole suite
Library             SeleniumLibrary
Test Setup         Initialize Test
Test Teardown      Cleanup Test

*** Variables ***
${BROWSER}         chrome
${URL}             https://automationplayground.com/crm/
${EMAIL}           admin@robotframeworktutorial.com
${PASSWORD}        qwe
${NEW_EMAIL}       janedoe@gmail.com
${FIRST_NAME}      Jane
${LAST_NAME}       Doe
${CITY}            Dallas
${STATE}           TX

*** Test Cases ***
Should be able to add new customer
    [Documentation]         This is some basic info about the test
    [Tags]                 1006    Smoke   Contacts
    Login To CRM
    Add New Customer
    Verify Customer Added Successfully
    Sign Out

*** Keywords ***
Initialize Test
    Set selenium speed          .2s
    Set selenium timeout        10s
    Open Browser               ${URL}    ${BROWSER}
    Set Window Position        x=341     y=169
    Set Window Size           width=1935  height=1090
    Page Should Contain       Customers Are Priority One

Login To CRM
    Click Link                id=SignIn
    Page Should Contain       Login
    Input Text               id=email-id    ${EMAIL}
    Input Text               id=password    ${PASSWORD}
    Click Button             id=submit-id
    Page Should Contain      Our Happy Customers

Add New Customer
    Click Link               id=new-customer
    Page Should Contain      Add Customer
    Input Text              id=EmailAddress     ${NEW_EMAIL}
    Input Text              id=FirstName        ${FIRST_NAME}
    Input Text              id=LastName         ${LAST_NAME}
    Input Text              id=City             ${CITY}
    Select From List By Value    id=StateOrRegion    ${STATE}
    Select Radio Button     gender    female
    Select Checkbox         name=promos-name
    Click Button           Submit

Verify Customer Added Successfully
    Wait Until Page Contains    Success! New customer added.

Sign Out
    Click Link              Sign Out
    Wait Until Page Contains    Signed Out

Cleanup Test
    Close Browser