*** Settings ***
Library           SeleniumLibrary
Library           String

*** Variables ***
${BROWSER}        Chrome
${URL}           https://www.python.org
${SEARCH_TERM}    pycon

*** Test Cases ***
Search Python.org
    [Setup]    Open Browser To Python.org
    Input Search Term
    Submit Search
    Verify Search Results
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Python.org
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Welcome to Python.org

Input Search Term
    Input Text    name=q    ${SEARCH_TERM}

Submit Search
    Click Button    id:submit

Verify Search Results
    Wait Until Page Contains Element    css:#content
    ${results_text}=    Get Text    css:#content
    ${lower_results_text}=    Convert To Lower Case    ${results_text}
    ${lower_search_term}=    Convert To Lower Case    ${SEARCH_TERM}
    Should Contain    ${lower_results_text}    ${lower_search_term}
    Page Should Contain Element    css:.list-recent-events