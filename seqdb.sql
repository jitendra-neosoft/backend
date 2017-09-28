-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 28, 2017 at 12:22 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seqdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `cat_name` varchar(255) DEFAULT NULL,
  `category_sequence` int(11) DEFAULT NULL,
  `featureid` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `cat_name`, `category_sequence`, `featureid`, `createdAt`, `updatedAt`) VALUES
(1, 'Programming', 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` int(11) NOT NULL,
  `feature_name` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `feature_name`, `createdAt`, `updatedAt`) VALUES
(1, 'feature_name', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `lang_name` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `lang_name`, `createdAt`, `updatedAt`) VALUES
(1, 'java', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` int(11) NOT NULL,
  `program_name` varchar(255) DEFAULT NULL,
  `program_description` varchar(255) DEFAULT NULL,
  `program_category` int(11) DEFAULT NULL,
  `description_image_base64` varchar(255) DEFAULT NULL,
  `description_image_url` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`id`, `program_name`, `program_description`, `program_category`, `description_image_base64`, `description_image_url`, `createdAt`, `updatedAt`) VALUES
(1, 'print hello world', 'print hello world in java', 1, 'image base 64', 'image url', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `program_details`
--

CREATE TABLE `program_details` (
  `id` int(11) NOT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `prog_id` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `codewithoutcomments` varchar(255) DEFAULT NULL,
  `codewithoutlogic` varchar(255) DEFAULT NULL,
  `exampleoutput` varchar(255) DEFAULT NULL,
  `difficultylevel` int(11) DEFAULT NULL,
  `exampleoutputtype` varchar(255) DEFAULT NULL,
  `isrunnable` tinyint(1) DEFAULT NULL,
  `canbeusedforchallenges` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `program_details`
--

INSERT INTO `program_details` (`id`, `lang_id`, `prog_id`, `code`, `codewithoutcomments`, `codewithoutlogic`, `exampleoutput`, `difficultylevel`, `exampleoutputtype`, `isrunnable`, `canbeusedforchallenges`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 'console.log(\"Java Script\");', 'code without comment', 'code without logic', 'example output', 1, 'example output', 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `program_ios`
--

CREATE TABLE `program_ios` (
  `id` int(11) NOT NULL,
  `prog_id` int(11) DEFAULT NULL,
  `input` varchar(255) DEFAULT NULL,
  `output` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `program_ios`
--

INSERT INTO `program_ios` (`id`, `prog_id`, `input`, `output`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'input of program', 'output of program', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `requestlogs`
--

CREATE TABLE `requestlogs` (
  `id` int(11) NOT NULL,
  `versionno` int(11) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `appname` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requestlogs`
--

INSERT INTO `requestlogs` (`id`, `versionno`, `client`, `appname`, `language`, `timestamp`, `createdAt`, `updatedAt`) VALUES
(25, 123, 'android', 'expressjs', 'lang1', '2017-09-28 15:47:02', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `featureid` (`featureid`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `program_category` (`program_category`);

--
-- Indexes for table `program_details`
--
ALTER TABLE `program_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lang_id` (`lang_id`),
  ADD KEY `prog_id` (`prog_id`);

--
-- Indexes for table `program_ios`
--
ALTER TABLE `program_ios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prog_id` (`prog_id`);

--
-- Indexes for table `requestlogs`
--
ALTER TABLE `requestlogs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `requestlogs`
--
ALTER TABLE `requestlogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`featureid`) REFERENCES `features` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`program_category`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `program_details`
--
ALTER TABLE `program_details`
  ADD CONSTRAINT `program_details_ibfk_1` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `program_details_ibfk_2` FOREIGN KEY (`prog_id`) REFERENCES `programs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `program_ios`
--
ALTER TABLE `program_ios`
  ADD CONSTRAINT `program_ios_ibfk_1` FOREIGN KEY (`prog_id`) REFERENCES `program_details` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
