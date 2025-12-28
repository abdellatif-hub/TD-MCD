-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 28 déc. 2025 à 16:56
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `exercice 3 – sql`
--

-- --------------------------------------------------------

--
-- Structure de la table `assure_td`
--

CREATE TABLE `assure_td` (
  `numPoste` int(11) NOT NULL,
  `numTD` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE `cours` (
  `idCours` int(11) NOT NULL,
  `titre` varchar(50) DEFAULT NULL,
  `salle` varchar(30) DEFAULT NULL,
  `jour` varchar(10) DEFAULT NULL,
  `heure` time DEFAULT NULL,
  `nbHeures` int(11) DEFAULT NULL,
  `numPoste` int(11) DEFAULT NULL,
  `codeUE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `diplome`
--

CREATE TABLE `diplome` (
  `numDiplome` int(11) NOT NULL,
  `intitule` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `enseignant`
--

CREATE TABLE `enseignant` (
  `numPoste` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `statut` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `numEtudiant` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `dateNaissance` date DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `numDiplome` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `examen`
--

CREATE TABLE `examen` (
  `idExamen` int(11) NOT NULL,
  `annee` int(11) DEFAULT NULL,
  `numSession` int(11) DEFAULT NULL,
  `dateExam` date DEFAULT NULL,
  `heureExam` time DEFAULT NULL,
  `coefficient` float DEFAULT NULL,
  `idCours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `passer`
--

CREATE TABLE `passer` (
  `numEtudiant` int(11) NOT NULL,
  `idExamen` int(11) NOT NULL,
  `note` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `td`
--

CREATE TABLE `td` (
  `numTD` int(11) NOT NULL,
  `salle` varchar(30) DEFAULT NULL,
  `jour` varchar(10) DEFAULT NULL,
  `heure` time DEFAULT NULL,
  `nbHeuresTD` int(11) DEFAULT NULL,
  `idCours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ue`
--

CREATE TABLE `ue` (
  `codeUE` varchar(10) NOT NULL,
  `intitule` varchar(50) DEFAULT NULL,
  `numDiplome` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `assure_td`
--
ALTER TABLE `assure_td`
  ADD PRIMARY KEY (`numPoste`,`numTD`),
  ADD KEY `numTD` (`numTD`);

--
-- Index pour la table `cours`
--
ALTER TABLE `cours`
  ADD PRIMARY KEY (`idCours`),
  ADD KEY `numPoste` (`numPoste`),
  ADD KEY `codeUE` (`codeUE`);

--
-- Index pour la table `diplome`
--
ALTER TABLE `diplome`
  ADD PRIMARY KEY (`numDiplome`);

--
-- Index pour la table `enseignant`
--
ALTER TABLE `enseignant`
  ADD PRIMARY KEY (`numPoste`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`numEtudiant`),
  ADD KEY `numDiplome` (`numDiplome`);

--
-- Index pour la table `examen`
--
ALTER TABLE `examen`
  ADD PRIMARY KEY (`idExamen`),
  ADD KEY `idCours` (`idCours`);

--
-- Index pour la table `passer`
--
ALTER TABLE `passer`
  ADD PRIMARY KEY (`numEtudiant`,`idExamen`),
  ADD KEY `idExamen` (`idExamen`);

--
-- Index pour la table `td`
--
ALTER TABLE `td`
  ADD PRIMARY KEY (`numTD`),
  ADD KEY `idCours` (`idCours`);

--
-- Index pour la table `ue`
--
ALTER TABLE `ue`
  ADD PRIMARY KEY (`codeUE`),
  ADD KEY `numDiplome` (`numDiplome`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `assure_td`
--
ALTER TABLE `assure_td`
  ADD CONSTRAINT `assure_td_ibfk_1` FOREIGN KEY (`numPoste`) REFERENCES `enseignant` (`numPoste`),
  ADD CONSTRAINT `assure_td_ibfk_2` FOREIGN KEY (`numTD`) REFERENCES `td` (`numTD`);

--
-- Contraintes pour la table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `cours_ibfk_1` FOREIGN KEY (`numPoste`) REFERENCES `enseignant` (`numPoste`),
  ADD CONSTRAINT `cours_ibfk_2` FOREIGN KEY (`codeUE`) REFERENCES `ue` (`codeUE`);

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `etudiant_ibfk_1` FOREIGN KEY (`numDiplome`) REFERENCES `diplome` (`numDiplome`);

--
-- Contraintes pour la table `examen`
--
ALTER TABLE `examen`
  ADD CONSTRAINT `examen_ibfk_1` FOREIGN KEY (`idCours`) REFERENCES `cours` (`idCours`);

--
-- Contraintes pour la table `passer`
--
ALTER TABLE `passer`
  ADD CONSTRAINT `passer_ibfk_1` FOREIGN KEY (`numEtudiant`) REFERENCES `etudiant` (`numEtudiant`),
  ADD CONSTRAINT `passer_ibfk_2` FOREIGN KEY (`idExamen`) REFERENCES `examen` (`idExamen`);

--
-- Contraintes pour la table `td`
--
ALTER TABLE `td`
  ADD CONSTRAINT `td_ibfk_1` FOREIGN KEY (`idCours`) REFERENCES `cours` (`idCours`);

--
-- Contraintes pour la table `ue`
--
ALTER TABLE `ue`
  ADD CONSTRAINT `ue_ibfk_1` FOREIGN KEY (`numDiplome`) REFERENCES `diplome` (`numDiplome`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
