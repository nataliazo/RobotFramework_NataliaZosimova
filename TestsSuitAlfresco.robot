***Settings***
Library    SeleniumLibrary
Library    DateTime
Library    String
Library    Dialogs
Library    csv_module

*** Test Cases ***

RQ9.Modifier modele
    #Connecter
    Connect    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}    ${TIMEOUT}
    ${vCompleteDate}=    Init Date
    #Creation le model
    Creer modele    ${vEspaseNom}    ${vPrefix}    ${vNom}-${vCompleteDate}    ${vCreateur}    ${vDescription}
    Sleep    2
    #Clique sur le lien "Action"   
    Click Element    //*[(text()="${vNom}-${vCompleteDate}")]/following::*[(text()="Actions")] 
    #Clique sur le lien "Modifier" du menu "Actions"
    Click Element    //div[@class = \"dijitPopup Popup\"]/div/div/div[2]/table/tbody/tr[2]/td[2]
    Sleep    2s   
    #Effacer le contenue du champe "Espase de nome" du formulaire du Modele  
    Clear Element Text    //span[text() = "Modifier le modèle"]/following::input[@name="namespace"]
    Sleep    2s    
    #Saisir le noveau "Espase de nom"
    Input Text    //span[text() = "Modifier le modèle"]/following::input[@name="namespace"]    ${vEspaceNomModifie}    
    #Cliquer sur le button "Enregistrer"
    Click Element    id=CMM_EDIT_MODEL_DIALOG_OK_label   
    Sleep    2s    
    #Verifier que l'Espase du nom a ete change 
    Element Text Should Be    //span[text()="${vNom}-${vCompleteDate}"]/ancestor::tr/td[2]/span/span/span[2]    ${vEspaceNomModifie} 
    Sleep    2s       
    #Supprimer du modele:
    Supprimer modele    ${vNom}-${vCompleteDate}  
    Logout
    
RQ6.Ajouter un element dans une liste de donnee
    #Connecter
    Set Selenium Implicit Wait    3s
    Connect    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}    ${TIMEOUT}
    ${vCompleteDate}=    Init Date
    Log    1- Creation du site    
    #Creer une Site
    Create Site    ${vNom}-${vCompleteDate}    ${vNom}-${vCompleteDate}    ${vDescription}  
    Sleep    2s       
    click    id=CREATE_SITE_DIALOG_OK_label
    Sleep    2s      
    #****Personaliser le site pour que la création de liste de donnee soit accessible***
    #Cliquer sur le menu Sites 
    Click Element    //div[@id="HEADER_SITES_MENU"]/span[1]   
    Sleep    4s     
    #Cliquer sue le lien Mes sites     
    Click Link    //a[@title="Mes sites"]
    #S'assurer que la page est charge 
    Wait Until Element Is Visible  //span[@class='alfresco-header-Title__text has-max-width']
    #Clique sur le lien de votre site 
    Click Link    ${vNom}-${vCompleteDate}
    Sleep    3s    
    #Personnaliser le site pour être cabable de cree la Liste De Donnee
    # Click sur la roue dentee 
    Click Element    //*[@id="HEADER_SITE_CONFIGURATION_DROPDOWN"]/img 
    # Attendre que le bouton soit visible
    Wait Until Element Is Visible    id=HEADER_DELETE_SITE_text  
    # Click sur le bouton Personaliser le site
    Click Element    //a[@title="Personnaliser le site"] 
    #S'assurer que la page est charge
    Title Should Be    Alfresco » Personnaliser le site    
    Sleep    4s    
    #Drag and Drop element Liste de donne
    Drag And Drop    //h3[text()= "Listes de données"]/preceding::img[1]    //div[@class = "page-list-wrapper current-pages theme-border-3"]/ul[@class= "page-list"]
    Sleep    2s       
    #Clique sur le burron OK 
    Click Element    id=template_x002e_customise-pages_x002e_customise-site_x0023_default-save-button    
    Sleep    3s       
    #Creer une liste de donnee
    CreerListeDeDonnees    ${vNom}-${vCompleteDate}    ${vTypeDeListe}    ${vNomdeList}    ${vDescription}
    Sleep    3s    
    #Aller dans la list cree
    Click Element    //a[@title = "${vDescription}"]
    Sleep    2s  
    #Ajouter les elemets dans la liste
    Log    1- Ajouter les elements dans la liste de donnee 
    @{Lignes}=    return list from csv    ${ElementsListeDeDonnee}
    FOR    ${Ligne}    IN    @{Lignes}
        @{param}=    Split String    ${Ligne}    ;
         Ajouter element dans un liste de donnee    ${param}[0]    ${param}[1]    ${param}[2]    ${param}[3]    ${param}[4]    ${param}[5]    ${param}[6]
         Sleep    2s
         #Cliquer sur le bouton "Enregistrer"
         Click Element    //button[text() = "Enregistrer"]
         #Point verification
         Element Should Be Visible    //div[text() = "${param}[0]"]                       
         Sleep    2s  
    END     
    #*****Postcondition****
    #Supprimer le site
    Supprimer un site    ${vNom}-${vCompleteDate}
    #Se decconecter
    Logout
        
RQ04.Modifier une regle
    #Connecter
    Connect    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}    ${TIMEOUT}
    #Creer un Dossier
    CreerElement    ${vNomDossier}    ${vTitreDossier}    ${vDescription}
    Sleep    3s    
    #Creer une Regle
    Creer une regle     ${vNomDossier}    ${vNom_Regle}    ${vDescription}    
    Sleep    2s    
    # Vérification du titre de la page
    Title Should Be    Alfresco » Règles de dossier  
    Sleep    4s      
    #Cliquer sur le button "Modifier"
    Click Element    //button[text()="Modifier"]    
    #Effacer la contenuer du champe "Nom" de formulaire de la Regle
    Clear Element Text    //input[@title = "Nom"]
    Sleep    2s    
    #Saisir le nouveau Nom
    Input Text    //input[@title = "Nom"]    ${NomRegleModifie}    
    #Cliquer sur le bouton "Enregistrer"
    Click Element    //button[text()="Enregistrer"]    
    Sleep    3s    
    #Point de Verification:
    Element Should Be Visible    //h2[text() = "${NomRegleModifie}"]  
    Sleep    10    
    #Supprimer le dossier
    Supprimer Element    ${vNomDossier}
    Sleep    1s    
    #Deconnecter
    Logout
    
RQ04.Executer une regle
    #Connecter
    Connect    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}    ${TIMEOUT}
    #Creer un Dossier_1
    CreerElement    ${vNomDossier}    ${vTitreDossier}    ${vDescription}
    Sleep    2    
    #Aller au Dossier_1
    Click Element    //a[text() = "${vNomDossier}"]   
    Sleep    2    
    #Creer un SousDossier Dans le Dossier_1
    Creer SousDossier   ${vNomSousDossier}    ${vTitreDossier}    ${vDescription}
    Sleep    2    
    #Creer un Regle pour le Dossier_1
    ${vCompleteDate}=    Init Date
    Log    1- Creation du site    
    #Creer une Site
    Creer un site    ${vNom}-${vCompleteDate} 
    Sleep    6s        
    #Creer une regle
    Сreer une regle executable    ${vNomDossier}    ${vNom_Regle}    ${vDescription}    ${vNom}-${vCompleteDate}    
    Sleep    4s        
    #S'assure que la page a ete charge
    Title Should Be    Alfresco » Règles de dossier    
    #Appuyer syr le boutton "Executer les regeles"
    Click Element    //button[text() = "Exécuter une règle..."]
    Sleep    2s    
    #Cliquer sur le lien "Exécuter des règles pour ce dossier et ses sous-dossiers"
    Click Element    //a[text()="Exécuter des règles pour ce dossier et ses sous-dossiers"]        
    #Point de verification: il faut aller au site ${vSiteName} et s'assure que la regle creer a ete executer 
    # et le dossier ${vNomSousDossier}  a ete copie dans le site ${vSiteName}.
    #Aller au site ${vSiteName}
    #Cliquer sur le menu Sites 
    Click Element    //span[@class="alfresco-menus-AlfMenuBarPopup__arrow"]
    Sleep   2
    #Cliquer sue le lien Mes sites 
    Click Link    //a[@title="Mes sites"]
    #S'assurer que la page est charge 
    Wait Until Element Is Visible  //span[@class='alfresco-header-Title__text has-max-width']
    #Clique sur le lien de votre site 
    Click Link    ${vNom}-${vCompleteDate}
    Sleep   2
    # Cliquer sur le lien "Espase documantaire du site"
    Click Element    //a[@title = "Espace documentaire"]      
    #Valider le presence de la copie du fishier ${vNomSousDossier}
    Element Should Be Visible    //a[text() = "SousDossierNatalia"]   
    Sleep    4s    
    #Postcondition:
    #Supprimer le dossier cree
    Supprimer Element    ${vNomDossier}   
    # supprimer le site cree
    Supprimer un site    ${vNom}-${vCompleteDate} 
    #Deconnecter
    Logout
    
RQ04.Associer un jeu de règles.
    #Se connecter
    Connect    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}    ${TIMEOUT}
    #Creer un Dossier
    CreerElement    ${vNomDossier}    ${vTitreDossier}    ${vDescription}
    Sleep    3s    
    #Creer une Regle
    Creer une regle    ${vNomDossier}    ${vNom_Regle}    ${vDescription}
    Sleep    4s 
    #Creer un Nouveau Dossier_2   
    CreerElement    ${vNomDossier_2}    ${vTitreDossier}    ${vDescription}
    Sleep    2        
    #Aller a la page de Gestion de regle du Dossier_2
    # Faire defilor la souris vers le dossier choisi    
    Mouse Over    //a[text()='${vNomDossier_2}'] 
    sleep   1
    # Clicker sur le lien 'Plus...' qui correspond au dossier choisi
    Click Element    //a[text()='${vNomDossier_2}']/ancestor::tr//span[text()='Plus...']
    sleep    1
    # Clicker sur le lien "Gérer les règles" du dossier choisi
    Click Element   //a[text()='${vNomDossier_2}']/ancestor::tr//span[text()='Gérer les règles']
    sleep    2
    #Cliquer sur le lien "Associer un jeu de règles"
    Click Element    //a[text()="Associer un jeu de règles"]    
    Sleep    1 
    #Selectionner destincion de regle a assosier
    Click Element    //button[text()="Mes fichiers"]
    Sleep    2    
    #Selectionner le chemin 
    Click Element    //h3[text()="Chemin"]/ancestor::div//child::*[text()="${vNomDossier}"] 
    Sleep    2          
    #Cliquer sur le bouton Lien
    Click Element    //button[text()="Lien"]
    Sleep    3s    
    #Point de verification:
    Element Should Be Visible    //h2[text()="Jeu de règles associé au dossier:"]/parent::div//child::*[text()="${vNomDossier}"]      
    Sleep    4s    
    #Supprimer les dossier crees
    Supprimer Element    ${vNomDossier}
    Sleep    3s    
    Supprimer Element    ${vNomDossier_2}
    #Se decconecter
    Logout



***Keywords***
Connect
    # vURL contient l'adresse URL de la page web
    # vBrowser contient l'identifiant du navigateur cible
    # vUsername contient le login
    # vPassword contient le mot de passe
    # vTitle contient le titre de la page de login 
    [Arguments]    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}    ${TIMEOUT}
    # Définir la valeur de timeout pour le cas de test
    Set Selenium Timeout    ${TIMEOUT}
    # Ouvrir le navigateur en précisant l'URL et le navigateur
    Open Browser    ${vURL}    ${vBrowser}
    # Maximiser la fenêtre du navigateur
    Maximize Browser Window
    # Vérification du titre de la page
    Title Should Be    ${vTitle}
    # Saisie du login
    Input Text    id=page_x002e_components_x002e_slingshot-login_x0023_default-username    ${vUsername}
    # Saisie du mot de passe
    Input Text    id=page_x002e_components_x002e_slingshot-login_x0023_default-password    ${vPassword}
    # Click sur le bouton Connexion
    Click Button    id=page_x002e_components_x002e_slingshot-login_x0023_default-submit-button
    # S'assurer que la page est chargéé
    Wait Until Element Is Visible    xpath://*[@id="HEADER_TITLE"]/span
    # S'assurer que l'utilisateur est connecté et que le tableau de bord est affiché
    Element Should Contain     xpath://*[@id="HEADER_TITLE"]/span    Tableau de bord de
    
Logout
    sleep    3s
    Click Element    id=HEADER_USER_MENU_POPUP    
    Wait Until Element Is Visible    id=HEADER_USER_MENU_LOGOUT_text
    Click Element    id=HEADER_USER_MENU_LOGOUT_text
    [Teardown]    Close Browser
    
Creer modele
    # Les arguments sont des donnees qui sont necessaires pour la creation de modeles
    # vEspaseNom - un espace de nom de modele unique. 
    # vPrefix -  un prefixe d'espace de nom pour le modele.
    # vNom - un nom pour le modele.
    # vCreateur - le nom d'auteur
    # vDescription - déscription de modele    
    [Arguments]    ${vEspaseNom}    ${vPrefix}    ${vNom}    ${vCreateur}    ${vDescription}        
    #Clique sur le lien "Outil admin"    
    Click Link    //a[@title="Outils admin"] 
    #Clique sur le lien "Gestionnaire de modèle" du menu "Outil admin"  
    Click Link    //a[@title="Gestionnaire de modèles"]
    # Verification qu'on est dans la page neccesaire
    Title Should Be    Alfresco » Gestionnaire de modèles
    #Clique sur le bouton "Creer un modele"
    Click Element    //span[text()="Créer un modèle"]  
    #Remplir le formulaire de creation du modele  
    Input Text    //input[@name="namespace"]    ${vEspaseNom}    
    Input Text    //input[@name="prefix"]    ${vPrefix} 
    Input Text    //input[@name="name"]    ${vNom} 
    Input Text    //input[@name="author"]    ${vCreateur}
    Input Text    //div[@class="control"]/textarea[@name="description"]    ${vDescription}      
    #Clique sur le bouton OK         
    Click Element    id=CMM_CREATE_MODEL_DIALOG_OK_label
    Sleep    4s
    #Point de verification:
    Element Should Be Visible    //span[(text()="${vNom}")]    
    
Supprimer modele
    # vNom - contien  le nom du modele a supprimer   
    [Arguments]    ${vNom}            
    #Clique sur le lien "Outil admin" 
    Click Link    //a[@title="Outils admin"]    
    #Clique sur le lien "Gestionnaire de modele" du menu "Outil admin"   
    Click Link    //a[@title="Gestionnaire de modèles"]     
    # Verification qu'on est dans la page neccesaire
    Title Should Be    Alfresco » Gestionnaire de modèles              
    #Clique sur le bouton "Action"       
    Sleep    2s    
    Click Element    //*[(text()="${vNom}")]/following::*[(text()="Actions")]         
    #Identifier le status du modele (Actife ou Inactif)
    ${status}    Get Text    //span[text()="${vNom}"]/ancestor::tr/td[3]/span/span/span[2]  
    Sleep    2s          
    #Si le modèle est "Actif" tout d'abour il faut le desactiver pour etre capable de le supprimer:
    Run Keyword If    "${status}" == "Actif"    Click Element    //div[@class = "dijitPopup Popup"]/div/div/div[2]/table/tbody/tr/td[2] 
    Sleep    2s
    #Clique sur le lien "Action"   
    Click Element    //*[(text()="${vNom}")]/following::*[(text()="Actions")]   
    Sleep    2s   
    #Clique sur le lien "Supprimer" du menu "Actions"
    Click Element    //div[@class = \"dijitPopup Popup\"]/div/div/div[2]/table/tbody/tr[3]/td[2]  
    Sleep    2s           
    #Clique sur le bouton "OK"    
    Click Element    //div[@class = "footer"] /span[1] 
    Sleep    2s       
    #Point de verification:
    Element Should Not Be Visible    //span[(text()="${vNom}")]   
    

    
Create Site
    [Arguments]    ${vSiteName}    ${url}    ${description}
    Click    id:HEADER_SITES_MENU_text
    Wait Until Element Is Visible    //*[@id="HEADER_SITES_MENU_CREATE_SITE_text"]
    Click    //*[@id="HEADER_SITES_MENU_CREATE_SITE_text"]
    Wait Until Element Is Visible    //*[@id="CREATE_SITE_FIELD_PRESET_CONTROL"]/tbody/tr/td[2]/input
    sleep    3s
    Click    //*[@id="CREATE_SITE_FIELD_PRESET_CONTROL"]/tbody/tr/td[2]/input
    Click    //*[@id="dijit_MenuItem_0_text"]
    Type    name:title    ${vSiteName}   
    Type    name:shortName    ${url}  
    Type    name:description     ${description}
    
Creer un site
    
    # ${vSiteName} contient le nom du site
    [Arguments]    ${vSiteName}
    # Cliquer sur l'onglet 'Sites'
    Click Element    //span[text()='Sites']
    # Attendre que la ligne 'Créer un site' est visible
    Wait Until Element Is Visible    //td[text()='Créer un site']   
    # Cliquer sur 'Créer un site'
    Click Element    //td[text()='Créer un site']  
    # Entrer le nom du site  
    Input Text    //input[@name='title']    ${vSiteName} 
    sleep    2
    # Cliquer 'Créer' pour términer la création
    Click Element    //div[@class='footer']//span[@id='CREATE_SITE_DIALOG_OK_label']
    sleep    5
	# Vérifier si le site est créé
    Element Should Be Visible    //a[@title='${vSiteName}']
    
Type
    [Arguments]    ${vId}    ${vValue}
    Input Text    ${vId}    ${vValue}

Click
    [Arguments]    ${vId}
    Click Element    ${vId}
    
Delete Site using name
    [Arguments]    ${vSiteName}
    Go To    ${vURL}site/${vSiteName}
    Click    css=#HEADER_SITE_CONFIGURATION_DROPDOWN > span.alfresco-menus-AlfMenuBarPopup__arrow
    Wait Until Element Is Visible    id=HEADER_DELETE_SITE_text
    Click    id=HEADER_DELETE_SITE_text
    Wait Until Element Is Visible    id=ALF_SITE_SERVICE_DIALOG_CONFIRMATION_label
    Click    id=ALF_SITE_SERVICE_DIALOG_CONFIRMATION_label
    
Supprimer un site 
    # vSite contient le nom du site a supprimer
    [Arguments]    ${vSiteName}   
    # Click sur le menu Sites 
    Click Element    id=HEADER_SITES_MENU_text 
    # Attendre que l'element Mes sites soit visible
    Wait Until Element Is Visible    link=Mes sites
    # Click sur l'option Mes sites
    Click Element    link=Mes sites 
    # La page doit contenir le nom du site 
    Page Should Contain Element    link=${vSiteName}   
    # Click sur le nom du site    
    Click Element    link=${vSiteName}  
    # Click sur la roue dentee 
    Click Element    //*[@id="HEADER_SITE_CONFIGURATION_DROPDOWN"]/img 
    # Attendre que le bouton supprimer soit visible
    Wait Until Element Is Visible    id=HEADER_DELETE_SITE_text  
    # Click sur le bouton Supprimer     
    Click Element   id=HEADER_DELETE_SITE_text   
    # Click sur le bouton de confirmation de suppression
    Click Element    id=ALF_SITE_SERVICE_DIALOG_CONFIRMATION_label 
    # Point de verification
    # # Click sur le menu Sites
    Click Element    id=HEADER_SITES_MENU_text 
    # Attendre que l'element Mes sites soit visible
    Wait Until Element Is Visible    link=Mes sites
    # Click sur l'option Mes sites
    Click Element    link=Mes sites 
    # La page ne doit pas contenir le nom du site supprime
    Page Should Not Contain    link=${vSiteName}   
	
    
CreerListeDeDonnees

    #vSite le nom du site où vous voulez creer la liste de données
    #vTypeDeListe le type de liste de données :
      #Type Agenda //a[contains(text(),"Agenda d'événement")]
      #Type carnet d'adresse //a[contains(text(),"Carnet d'adresses")]
      #Type liste de contacts //a[contains(text(),'Liste de contacts')]
      #Type liste de publication //a[contains(text(),'Liste de publications')]
      #Type liste de taches //a[contains(text(),'Liste de publications')]
      #Type liste de taches (avancees) //a[contains(text(),'Liste de tâches (avancées)')]
      #Type liste de taches simple  //a[contains(text(),'Liste de tâches (simples)')]
    #vNomdeList le titre de la liste de données 
    #vDescription la description de la liste de données  
    
    [Arguments]   ${vSiteName}  ${vTypeDeListe}  ${vNomdeList}  ${vDescription} 


    #Cliquer sur le menu Sites 
    Click Element    //span[@class="alfresco-menus-AlfMenuBarPopup__arrow"]
    Sleep   5
    #Cliquer sue le lien Mes sites 
    Click Link    //a[@title="Mes sites"]
    #S'assurer que la page est charge 
    Wait Until Element Is Visible  //span[@class='alfresco-header-Title__text has-max-width']
    #Clique sur le lien de votre site 
    Click Link    ${vSiteName}
    Sleep   5
    #Cliquer sur le lien Liste de donnees
    Click Link    //a[contains(text(),"Listes de données")]
    Sleep    5s    
    #Cliquer sur le button Nouvelle liste 
    #Click Button    //button[@id="template_x002e_datalists_x002e_data-lists_x0023_default-newListButton-button"]
    Sleep   5
    #Choisir le type de la liste de donnees 
   
    Click Link    //a[contains(text(),"${vTypeDeListe}")]
    Sleep   5
    #Saisire le titre de la liste de donnees
    Input Text    id=template_x002e_datalists_x002e_data-lists_x0023_default-newList_prop_cm_title    ${vNomdeList} 
    Sleep    4s    
    #Saisire la desription de la liste 
    Input Text    id=template_x002e_datalists_x002e_data-lists_x0023_default-newList_prop_cm_description     ${vDescription} 
    #Cliquer sur Enregestrer
    Click Element    //button[@name="-"]
	#Afficher un message dans la console 
    log to console   La liste de données est créée 
    
CreerElement
    
    [Arguments]       ${vNomDossier}    ${vTitreDossier}    ${vDescription} 
    Sleep    1    
    #cliquer sur "mes fichiers"   
    Click Element     //span[@id="HEADER_MY_FILES_text"]/a  
    Sleep    2 
    #cliquer sur le bouton creer
    Click Element    //button[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createContent-button-button"]        
    Sleep    2  
   #cliquer sur le element dossier
    Click Element    //span[text() = "Dossier"] 
    #verification  du resultat   
    Wait Until Element Is Visible    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_name"]  
    #remplir le champ nom  
    Input Text    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_name"]    ${vNomDossier}
    #remplir le champ titre
    Input Text    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_title"]    ${vTitreDossier}
    #remplir le champ description
    Input Text    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_description"]    ${vDescription}
    Sleep    3s    
    #cliquer sur le bouton enregistrer    
    Click Element    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder-form-submit-button"]  
    #verification du resultat "l existance du dossier"
    #Element Should Be Visible    //a[text()="${vNomDossier}"]   
    #Sleep    10s     

Creer SousDossier
    
    [Arguments]       ${vNomSousDossier}    ${vTitreDossier}    ${vDescription}   
    Sleep    2 
    #cliquer sur le bouton creer
    Click Element    //button[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createContent-button-button"]        
    Sleep    2  
   #cliquer sur leelement dossier
    Click Element    //*[@id="yui-gen0"]/a/span 
    #verification  du resultat   
    Wait Until Element Is Visible    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_name"]  
    #remplir le champ nom  
    Input Text    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_name"]    ${vNomSousDossier}
    #remplir le champ titre
    Input Text    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_title"]    ${vTitreDossier}
    #remplir le champ description
    Input Text    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder_prop_cm_description"]    ${vDescription}
    #cliquer sur le bouton enregistrer   
    Sleep    3s     
    Click Element    //*[@id="template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createFolder-form-submit-button"]  
    #verification du resultat "l existance du dossier"
    Sleep    4s 
    Element Should Be Visible    //a[text()="${vNomSousDossier}"]    
       
    
Supprimer Element
     # ${vNomfichier} contien le nom de Fichier
     [Arguments]     ${vNomDossier} 
     #cliquer sur mes fichiers
	 Click Link    //a[@title="Mes fichiers"]
     Sleep    3
     # Selectionner le fiche à supprimer
     Click Element    //label[text()="Sélectionner ${vNomDossier}"]//following-sibling::input
     Sleep    3
     #Verifier que fichier a supprimer is visible
     Wait Until Element Is Visible     //span[text()='${vNomDossier}']
     Sleep    3
     # menu à droite cliquer sur "Eléments sélectionnés" (Plus)
     Click Element  //div[@class='action-set detailed']//span[contains(text(),'Plus...')]
     Sleep    3
     # cliquer sur supprimer
     Click Element     //span[contains(text(),'Supprimer le Dossier')]
     Sleep    3
     #Affichage boite de dialogue
     Wait Until Page Contains Element    //div[@id='prompt_h']        10
     #click sur bouton Supprimer
     Click Button   //button[contains(text(),'Supprimer')]  
     #Point the verification
     #Element Should Not Be Visible    //span[text()='${vNomDossier}']
     Sleep    10    
     
Creer une regle  
    [Arguments]    ${vNomDossier}    ${vNom_Regle}    ${vDescription}
    # Clicker sur le bouton 'Mes Fichier'
    Click link     //*[@id="HEADER_MY_FILES_text"]/a
    sleep     2
    # Faire defilor la souris vers le dossier choisi    
    Mouse Over    //a[text()='${vNomDossier}'] 
    sleep   2
    # Clicker sur le lien 'Plus...' qui correspond au dossier choisi
    Click Element    //a[text()='${vNomDossier}']/ancestor::tr//span[text()='Plus...']
    sleep    2
    # Clicker sur le lien "Gérer les règles" du dossier choisi
    Click Element   //a[text()='${vNomDossier}']/ancestor::tr//span[text()='Gérer les règles']
    sleep    2   
    # Clicker sur le lien "Créer des règles"
    Click link     //*[@id="template_x002e_rules-none_x002e_folder-rules_x0023_default-body"]/div[2]/div[1]/a
    sleep    4
    #  Saisir le nom de la nouvelle regle
    Input Text     //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-title"]    ${vNom_Regle}
    sleep    2
    # Saisir la description de la nouvelle regle
    Input Text     //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-description"]    ${vDescription}
    sleep    2
    # Clicker sur la liste deroulante "Exécuter une action"
    Click Element   //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-ruleConfigAction-configs"]//child::select[@class="config-name"]    
    sleep    2
    # Choisir "Executer le script" dans la liste deroulante "Exécuter une action"
    Click Element    //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-ruleConfigAction-configs"]//child::option[@value="script"]    
    sleep    2
    # Clicker sur le bouton "Creer"
    Click Element    //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-create-button-button"]       
    
    
Сreer une regle executable  
    #Le keaword a ete modifier par mois
    # ${value} est la selection dans le chapme Executer une action:
        #-Executer un script: ${value} = script
        #Copier ${value} = copier
    [Arguments]    ${vNomDossier}    ${vNom_Regle}    ${vDescription}    ${vSiteName}      
    # Clicker sur le bouton 'Mes Fichier'
    Click link     //*[@id="HEADER_MY_FILES_text"]/a
    sleep     1
    # Faire defilor la souris vers le dossier choisi    
    Mouse Over    //a[text()='${vNomDossier}'] 
    sleep   1
    # Clicker sur le lien 'Plus...' qui correspond au dossier choisi
    Click Element    //a[text()='${vNomDossier}']/ancestor::tr//span[text()='Plus...']
    sleep    1
    # Clicker sur le lien "Gérer les règles" du dossier choisi
    Click Element   //a[text()='${vNomDossier}']/ancestor::tr//span[text()='Gérer les règles']
    sleep    2   
    # Clicker sur le lien "Créer des règles"
    Click link     //*[@id="template_x002e_rules-none_x002e_folder-rules_x0023_default-body"]/div[2]/div[1]/a
    sleep    4
    #  Saisir le nom de la nouvelle regle
    Input Text     //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-title"]    ${vNom_Regle}
    sleep    3
    # Saisir la description de la nouvelle regle
    Input Text     //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-description"]    ${vDescription}
    sleep    2
    # Choisir l<action dans la list  la liste deroulante de criteres qui doivent etre rimplis:
    Click Element    //*[(text() ="Si tous les critères sont remplis :")]/ancestor::div[@class="if"]//select 
    Sleep    2       
    Click Element    //*[(text() ="Si tous les critères sont remplis :")]/ancestor::div[@class="if"]//child::*[text()="Nom"]
    #Remplir le champe "Commence par"
    Input Text    // input[@class = "param mandatory"]    ${ValeurCommencePar}   
    # Clicker sur la liste deroulante "Exécuter une action"
    Click Element   //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-ruleConfigAction-configs"]//child::select[@class="config-name"]
    Sleep    2     
    Click Element    //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-ruleConfigAction-configs"]//child::option[@value="copy"] 
    sleep    2
    #Cliquer sur le bouton Selectionner
    Click Element    // button[text() = "Sélectionner..."]
    Sleep    2s        
    # Choisir la plase de souvgarder le copie
    Click Element    // div[@class = "site-picker"]//child::h4[text() = "${vSiteName}"] 
    Sleep    2   
    #Clique sur le button OK:
    Click Element    // span[@class = "first-child"]/button[text()="OK"]
    Sleep    2            
    #Cocher "Appliquer la règle aux sous-dossiers"
    Select Checkbox    // input[@title= "Appliquer la règle aux sous-dossiers"]
    Sleep    2    
    # Clicker sur le bouton "Creer"
    Click Element    //*[@id="template_x002e_rule-edit_x002e_rule-edit_x0023_default-create-button-button"]  
    
Init Date
    ${vDateSys}=    Get Current Date    exclude_millis=yes
    ${vDate}=    Get Substring   ${vDateSys}    0    10
    ${vHeure}=    Get Substring   ${vDateSys}    11    13
    ${vMinute}=    Get Substring   ${vDateSys}    14    16
    ${vSeconde}=    Get Substring   ${vDateSys}    17    19
    ${vCompleteDate}=    catenate    ${vDate}-${vHeure}${vMinute}${vSeconde}
    [return]    ${vCompleteDate}
  
Ajouter element dans un liste de donnee
    [Arguments]    ${vReference}    ${vHeureDebut}    ${vHeurFin}    ${vNomSeanse}    ${vAuditoire}    ${Intervenant}    ${vNote}    
    # Cliquer sur le boutton "Nouvel element"
    Sleep    5s    
    Click Element    //button[text()="Nouvel élément"]       
    Sleep    2s    
    # Rempril le formulaire de nouvel element
    #Reference
    Input Text    //input[@name = "prop_dl_eventAgendaRef"]    ${vReference}    
    #Heure de debut
    Input Text    //input[@name = "prop_dl_eventAgendaStartTime"]    ${vHeureDebut}    
    #Heur de fin
    Input Text    //input[@name = "prop_dl_eventAgendaEndTime"]    ${vHeurFin}
    #Nom de la seanse
    Input Text    //input[@name = "prop_dl_eventAgendaSessionName"]    ${vNomSeanse} 
    #Auditoire
    Input Text    //input[@name = "prop_dl_eventAgendaAudience"]    ${vAuditoire}
    #intervenant
    Input Text    //input[@name = "prop_dl_eventAgendaPresenter"]     ${Intervenant}    
    Sleep    3s    
    #Note
    Input Text    //textarea[@name = "prop_dl_eventAgendaNotes"]    ${vNote}   
    Sleep    2s 
    
***Variables***
${vURL}    http://localhost:8085/
${vBrowser}    gc
${vUsername}    1995405
${vPassword}    alfresco    
${vTitle}    Alfresco » Connexion
${TIMEOUT}    3s
${vEspaseNom}    hhh
${vEspaceNomModifie}    EspaceNomModifie
${vPrefix}    kkk
${vNom}    1Natalia
${vCreateur}    Natalia
${vDescription}    blabla
${vSiteName}    SiteNatalia10
${vTypeDeListe}    Agenda d'événement
${vNomdeList}    ListeNatalia
${vNomDossier}    DossierNatalia
${vTitreDossier}    titreNAtalia
${vNom_Regle}    RegleNatalia
${NomRegleModifie}    NewName
${vNomSousDossier}    SousDossierNatalia
${ValeurCommencePar}    ${vNomSousDossier}  
#variable d<Element de Liste de donnee:
${vReference}    ElementNatalia 
${vHeureDebut}    9:00
${vHeurFin}    18:00
${vNomSeanse}    Test
${vAuditoire}    Natalia
${vNote}    Tout va bien    
${Intervenant}     Natalia
${vNomDossier_2}    DossierNatalia_2
${ElementsListeDeDonnee}    ElementsListeDonee.csv    

       


    
               
       
    
    
    




    


    
    
    
      
    
    
    
    
    
    
    
    
    



















