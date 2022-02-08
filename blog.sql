-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 07 fév. 2022 à 17:23
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `blog`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Titre` varchar(80) COLLATE utf8_bin NOT NULL,
  `article` text COLLATE utf8_bin NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_categorie` int(11) NOT NULL,
  `date` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`id`, `Titre`, `article`, `id_utilisateur`, `id_categorie`, `date`) VALUES
(20, 'OM 0-0 Metz', 'En supériorité numérique pendant plus d\'une demi-heure, l\'Olympique de Marseille n\'a pas réussi à faire la différence face à Metz (0-0) ce dimanche. L\'OM a été sauvé deux fois par ses montants, Payet a aussi trouvé la barre.', 19, 4, '2022-02-04 16:04:13'),
(21, 'Emran Soglo s’engage avec l’OM', 'Annoncé récemment, l’Olympique de Marseille vient d’officialiser le recrutement d’Emran Soglo (16 ans). Le milieu offensif arrive tout droit de Chelsea où il était considéré comme une pépite du club. Il débutera au centre de formation de l’OM.\r\n\r\nLe jeune Soglo est arrivé à Chelsea à l’âge de 10 ans où il était considéré comme une pépite du club. Suivi par de nombreux grands clubs, c’est bien à l’Olympique de Marseille qu’il évoluera désormais.', 19, 3, '2022-02-04 16:19:53'),
(22, 'OM – Angers', 'Pour démarrer cette nouvelle journée de Ligue 1 Uber Eats le calendrier nous offre un duel entre l’OM et Angers. Après plus de la moitié des rencontres disputées, l’OM pointe à la troisième place du classement, à deux encablures de Nice qui a disputé un match en plus. À l’heure d’entamer cette rencontre contre Angers, les joueurs de l’OM comptent 40 points acquis grâce à un bilan comptable de 11 victoires, 7 matchs nuls et seulement 3 défaites, le plus petit total de défaites après celui du Paris Saint-Germain, large leader du championnat. ', 19, 1, '2022-02-04 16:21:41'),
(23, 'Résultats Ligue 1: Succès 2-1 de l\'OL face à l\'OM', 'À l\'occasion de la 14ème journée de Ligue 1, l\'OL l\'OM à Parc Olympique Lyonnais. L\'OL a remporté cette confrontation 2 à 1. Bosz et Sampaoli ont suivi le même schéma tactique en plaçant leurs joueurs en 1-le 3-4-2-1 pour débuter la rencontre.\r\n\r\nLa première mi-temps a bien démarré. En effet, l\'Olympique de Marseille est rentré rapidement dans le vif du sujet dès la 11ème minute, avec un but inscrit par Guendouzi sur un service de Payet. Les équipes sont rentrées au vestiaire à la mi-temps sur le score de 0-1. Puis, Shaqiri a réussi à tromper le gardien, inscrivant le deuxième but du match. À la 90ème, Dembélé a tué le suspense, offrant la victoire à l\'Olympique Lyonnais.', 19, 2, '2022-02-04 17:31:28'),
(24, 'Lyon a puni un Marseille endormi ! ', 'L\'Olympique de Marseille a trop joué avec le feu ! Pourtant dominateur et devant au score à la pause, le club phocéen a été renversé par Lyon (1-2) ce mardi à l\'occasion d\'un match à rejouer de la 14e journée de Ligue 1. Auteurs d\'une bonne première période avec un but de Mattéo Guendouzi, les Marseillais ont laissé des libertés après la pause aux Gones, qui l\'ont finalement emporté grâce à des buts de Xherdan Shaqiri et Moussa Dembélé. Au classement, l\'OL remonte à la 7e place, à 6 points de l\'OM, toujours au 3e rang. ', 19, 4, '2022-02-07 10:47:33'),
(25, 'AMA LA MEILLEURE ', 'QZSEDRFTGYH UIJKO', 19, 1, '2022-02-07 16:59:03');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `nom`) VALUES
(3, 'Annonces officielles'),
(1, 'Rencontres'),
(2, 'Resultats'),
(4, 'Debriefs');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE IF NOT EXISTS `commentaires` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commentaire` varchar(1024) COLLATE utf8_bin NOT NULL,
  `id_article` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `date` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`id`, `commentaire`, `id_article`, `id_utilisateur`, `date`) VALUES
(7, 'Pire match je suis degouté!! Naze', 20, 20, '2022-02-04 17:25:19'),
(8, 'Trop bien.', 21, 20, '2022-02-04 17:25:33'),
(9, 'On croise les doigts....', 22, 20, '2022-02-04 17:25:50');

-- --------------------------------------------------------

--
-- Structure de la table `droits`
--

DROP TABLE IF EXISTS `droits`;
CREATE TABLE IF NOT EXISTS `droits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1338 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `droits`
--

INSERT INTO `droits` (`id`, `nom`) VALUES
(1, 'utilisateur'),
(42, 'modérateur'),
(1337, 'administrateur');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `id_droits` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_droits`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `login`, `password`, `email`, `id_droits`) VALUES
(20, 'Laurent13', '$2y$10$JoJd8riIoLHFxmxhBIh.D.CDx659QIQWkcTG74dmI4N5rWSsXM5l.', 'laurent13@yahoo.fr', 1),
(19, 'admin1', '$2y$10$JivSU0vq.TmJM4ANfyhf4OS9O6KujSYCxBp1vDcH5d3Ec06WFp7zS', 'amarilystenorio@yahoo.fr', 1337);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
