*** Settings ***
Documentation  This is some basic info about the whole suite
Library  SeleniumLibrary
Library  Collections
Test Setup  Initialize Test
Test Teardown  Cleanup Test

*** Variables ***
${BROWSER}  chrome
${URL}  http://www.amazon.com
${SEARCH_TERM}  Ferrari 458
${SEARCH_BOX}  id=twotabsearchtextbox
${SEARCH_BUTTON}  xpath=//*[@id="nav-search"]/form/div[2]/div/input
${FIRST_RESULT}  css=#result_0 a.s-access-detail-page
${ADD_TO_CART}  id=add-to-cart-button
${CHECKOUT_BUTTON}  id=hlb-ptc-btn-native
${SIGN_IN_BUTTON}  id=signInSubmit

*** Test Cases ***
User can search for products
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke
    Search For Product
    Verify Search Results
    
User can view a product
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke
    Search For Product
    Click First Result
    Verify Product Details

User can add product to cart
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke
    Search For Product
    Click First Result
    Add To Cart
    Verify Added To Cart

User must sign in to check out
    [Documentation]  This is some basic info about the test
    [Tags]  sign-in
    Search For Product
    Click First Result
    Add To Cart
    Proceed To Checkout
    Verify Sign In Required

*** Keywords ***
Initialize Test
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains  Shop by

Cleanup Test
    Close Browser

Search For Product
    Input Text  ${SEARCH_BOX}  ${SEARCH_TERM}
    Click Button  ${SEARCH_BUTTON}
    Wait Until Page Contains  results for "${SEARCH_TERM}"

Click First Result
    Wait Until Element Is Visible  ${FIRST_RESULT}
    Click Link  ${FIRST_RESULT}
    Wait Until Page Contains  Back to search results

Add To Cart
    Wait Until Element Is Visible  ${ADD_TO_CART}
    Click Button  ${ADD_TO_CART}

Verify Added To Cart
    Wait Until Page Contains  Added to Cart  timeout=10s

Proceed To Checkout
    Wait Until Element Is Visible  ${CHECKOUT_BUTTON}
    Click Link  ${CHECKOUT_BUTTON}

Verify Sign In Required
    Wait Until Element Is Visible  ${SIGN_IN_BUTTON}  timeout=10s

Verify Search Results
    Page Should Contain  results for "${SEARCH_TERM}"

Verify Product Details
    Page Should Contain  Back to search results