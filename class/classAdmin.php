<?php
require_once('../functions/db.php');

class Admin{
    public $login;
    public $password;
    public $id_droits;

    public function __construct()
    {
    }
//---------------------------------- UPDATE DROITS DEPUIS ADMIN.PHP -------------------------------------//
    public function updateRights($login, $id_droits){
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );
        $query = $connection->prepare ("UPDATE utilisateurs SET id_droits=:id WHERE id=:login");
        $query->bindValue(":id", $id_droits, PDO::PARAM_INT);
        $query->bindValue(":login", $login, PDO::PARAM_STR);

        $query->execute();
        var_dump($query);
    }




// ------------------------------------ REGISTER NEW USER DEPUIS ADMIN.PHP ------------------------------------------//

    public function registerNewUser ($login, $email, $password, $confirmPW, $id_droits){
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );

         $error_log = null;

         $login =  htmlspecialchars(trim($login));
         $email = htmlspecialchars(trim($email));
         $password =  htmlspecialchars(trim($password));
         $confirmPW =  htmlspecialchars(trim($confirmPW));

        if (!empty($login) && !empty($password) && !empty($confirmPW) && !empty($email) &&!empty($id_droits)) {
            echo"hardjojo";
        $logLength = strlen($login);
        $passLength = strlen($password);
        $confirmLength = strlen($confirmPW);
        $mailLength = strlen($email);

            if (($logLength >= 5) && ($passLength >= 5) && ($confirmLength >= 5) && ($mailLength >=5)) {
               $checkLength = $connection->prepare("SELECT login FROM utilisateurs WHERE login=:login");
               $checkLength->bindValue(":login", $login, PDO::PARAM_STR);
               $checkLength->execute();
               $count = $checkLength->fetch();
               var_dump($count);

                if (!$count) {
                    var_dump($password, $confirmPW);
                    if ( $password == $confirmPW) {


                       $cryptedpass = password_hash($password, PASSWORD_BCRYPT); // CRYPTED
                    //    $this->login = $login ;
                       $insert = $connection->prepare("INSERT INTO utilisateurs (login, password, email, id_droits ) VALUES (:login, :cryptedpass ,:email, :id_droits)"); 
                       $insert->bindValue(":login", $login, PDO::PARAM_STR);
                       $insert->bindValue(":cryptedpass", $cryptedpass, PDO::PARAM_STR);
                       $insert->bindValue(":email", $email, PDO::PARAM_STR);
                       $insert->bindValue(":id_droits", $id_droits, PDO::PARAM_INT);
                    //    $insert->bindValue();
                       $insert->execute();
                       echo"Nouvel utilisateur cr????";
                    }
                    else {
                        $error_log = "Les mots de passe ne correspondent pas";
                    }
                }
                else {
                    $error_log = "L'identifiant existe d??j??";
                }
         }
        else {
            $error_log = "5 caract??res minimum doivent ??tre ins??r??s dans chaques champs" ;
        }
    }
    else {
        $error_log = "Champs non remplis";
    }
    echo $error_log;
}
//-------------------------------------- UPDATE USER DEPUIS ADMIN.PHP -----------------------------------------------//
    public function UpdateNewUser($old_login, $login, $email, $password, $confirmPW){
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );

        $login =  htmlspecialchars(trim($login));
        $email = htmlspecialchars(trim($email));
        $password =  htmlspecialchars(trim($password));
        $confirmPW =  htmlspecialchars(trim($confirmPW));

        if (!empty($login) && !empty($email) && !empty($password) && !empty($confirmPW)){
            $logLength = strlen($login);
            $passLength = strlen($password);
            $confirmLength = strlen($confirmPW);
            $mailLength = strlen($email);

            if (($logLength >=5) && ($passLength >=5) && ($logLength >=5) && ($logLength >=5)) {
                $select = $connection->prepare("SELECT * FROM utilisateurs WHERE login = :login");
                $select->bindValue(":login", $old_login);
                $select->execute();
                $fetch = $select->fetch();

                var_dump($old_login);

                if ($confirmPW==$password) {
                    $cryptedpass = password_hash($password, PASSWORD_BCRYPT);
                    $update = ($connection)->prepare("UPDATE utilisateurs SET login = :login, password = :cryptedpass, email= :mail WHERE id = :old_login");
                    $update->bindParam(":old_login", $old_login, PDO::PARAM_INT);
                    $update->bindParam(":login", $login, PDO::PARAM_STR);
                    $update->bindParam(":cryptedpass",$cryptedpass, PDO::PARAM_STR);
                    $update->bindParam(":mail",$email, PDO::PARAM_STR);
                    var_dump($login);
                    $update->execute();
                }
                else  $error_log="Confirmation du mot de passe incorrect";
            }
            else $error_log = "Veuillez ins??rer au moins 5 caract??res dans chaques champs";
        }
        else {
            $error_log = "veuillez remplir les champs";
        }
        if (isset ($error_log)) {
            return $error_log;
        }
    }

    public function getArticles()
    {
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );

        $i = 0;
        $drop = $connection->prepare("SELECT * FROM articles");
        $drop->execute();
        //stockage des noms dans un tableau et dans le select du formulaire
        // TANT QUE
        while ($fetch = $drop->fetch(PDO::FETCH_ASSOC)) {
            // le crochets [] vides correspondent ?? un tableau vide dans lesquels on va ins??rer $fetch['id'] & $fetch['nom']
            $tableau[$i][] = $fetch['id'];
            $tableau[$i][] = $fetch['Titre'];
            $i++;
        }
        return $tableau;
    }

    public function getDisplay()
    {
        $display = new Admin();
        $tableau = $display->getArticles();
        foreach ($tableau as $value) {
            echo '<option value="' . $value[0] . '">' . $value[1] . '</option>';
        }
    }

    public function deleteArticle($titre){
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );
        $delete = $connection->prepare("DELETE FROM Articles WHERE id = :titre");
        $delete->bindValue(":titre", $titre, PDO::PARAM_STR);
        $delete->execute();
    }

// ------------------------------------- TABLEAU ADMIN -----------------------------------------// 

public function userTable() {
    $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );

    $tableUser = $connection->query("SELECT d.nom, u.login, u.id_droits, d.id FROM droits d INNER JOIN utilisateurs u ON u.id_droits = d.id WHERE u.id_droits = 1337"); 
    // SI PAS DE VARIABLE = PAS DE bindValue 
    $result = $tableUser->fetchAll(PDO::FETCH_ASSOC);
    echo"<table> <th> Admin </th>"; 
    for ($i=0; $i < count($result) ; $i++) {       
      echo"<tr>
      <td>" . $result[$i]['login'] . "</td>
        </tr>";
    }
    echo"</table>"; 
    $tableUser = $connection->query("SELECT d.nom, u.login, u.id_droits, d.id FROM droits d INNER JOIN utilisateurs u ON u.id_droits = d.id WHERE u.id_droits = 1"); 
    // SI PAS DE VARIABLE = PAS DE bindValue 
    $result = $tableUser->fetchAll(PDO::FETCH_ASSOC);
    echo"<table> <th> Utilisateur  </th>"; 
    
    for ($i=0; $i < count($result) ; $i++) {       
      echo"<tr>
      <td>" . $result[$i]['login'] . "</td>
        </tr>";
    }
    echo"</table>"; 
    
    $tableUser = $connection->query("SELECT d.nom, u.login, u.id_droits, d.id FROM droits d INNER JOIN utilisateurs u ON u.id_droits = d.id WHERE u.id_droits = 42"); 
    // SI PAS DE VARIABLE = PAS DE bindValue 
    $result = $tableUser->fetchAll(PDO::FETCH_ASSOC);
    echo"<table><th> Mod??rateur </th>"; 
    for ($i=0; $i < count($result) ; $i++) {       
      echo"<tr>
      <td>" . $result[$i]['login'] . "</td>
        </tr>";
    }
    echo"</table>"; 

}



    public function deleteUser($login)
    {
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );

        $deleteQuery = $connection->prepare("DELETE FROM utilisateurs WHERE id = :login");
        $deleteQuery->bindValue(":login", $login, PDO::PARAM_INT);
        $deleteQuery->execute();
    }

    public function updateArticle($old_titre, $titre, $article, $categorie){
        $connection = new \PDO('mysql:host=localhost; dbname=blog; charset=utf8', 'root', '' );

        $update = $connection->prepare("UPDATE articles SET Titre = :titre, article = :txtArticle, id_categorie = :categorie, date = NOW() WHERE id = :old_titre");
        $update->bindValue(":old_titre", $old_titre, PDO::PARAM_INT);
        $update->bindValue(":titre", $titre, PDO::PARAM_STR);
        $update->bindValue(":txtArticle", $article, PDO::PARAM_STR);
        $update->bindValue(":categorie", $categorie, PDO::PARAM_INT);
        $update->execute();
    }
}

?>