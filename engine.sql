-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 08, 2021 at 04:51 AM
-- Server version: 5.7.32
-- PHP Version: 7.3.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `engine_ahp`
--

-- --------------------------------------------------------

--
-- Table structure for table `engine_alternatives`
--

CREATE TABLE IF NOT EXISTS `engine_alternatives` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `engine_project_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `engine_alternatives`
--

INSERT INTO `engine_alternatives` (`id`, `name`, `engine_project_id`, `created`, `modified`) VALUES
(1, 'L車', 1, NULL, NULL),
(2, 'I車', 1, NULL, NULL),
(3, 'D車', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine_alternative_pairs`
--

CREATE TABLE IF NOT EXISTS `engine_alternative_pairs` (
  `id` int(11) NOT NULL,
  `engine_evaluation_id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `value` double NOT NULL,
  `engine_project_id` int(11) NOT NULL,
  `engine_user_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `engine_alternative_pairs`
--

INSERT INTO `engine_alternative_pairs` (`id`, `engine_evaluation_id`, `from_id`, `to_id`, `value`, `engine_project_id`, `engine_user_id`, `created`, `modified`) VALUES
(1, 6, 1, 1, 1, 1, 1, NULL, NULL),
(2, 6, 1, 2, 1, 1, 1, NULL, NULL),
(3, 6, 1, 3, 0.2, 1, 1, NULL, NULL),
(4, 6, 2, 1, 1, 1, 1, NULL, NULL),
(5, 6, 2, 2, 1, 1, 1, NULL, NULL),
(6, 6, 2, 3, 0.2, 1, 1, NULL, NULL),
(7, 6, 3, 1, 5, 1, 1, NULL, NULL),
(8, 6, 3, 2, 5, 1, 1, NULL, NULL),
(9, 6, 3, 3, 1, 1, 1, NULL, NULL),
(10, 7, 1, 1, 1, 1, 1, NULL, NULL),
(11, 7, 1, 2, 1, 1, 1, NULL, NULL),
(12, 7, 1, 3, 0.333333333, 1, 1, NULL, NULL),
(13, 7, 2, 1, 1, 1, 1, NULL, NULL),
(14, 7, 2, 2, 1, 1, 1, NULL, NULL),
(15, 7, 2, 3, 0.333333333, 1, 1, NULL, NULL),
(16, 7, 3, 1, 3, 1, 1, NULL, NULL),
(17, 7, 3, 2, 3, 1, 1, NULL, NULL),
(18, 7, 3, 3, 1, 1, 1, NULL, NULL),
(19, 8, 1, 1, 1, 1, 1, NULL, NULL),
(20, 8, 1, 2, 0.142857143, 1, 1, NULL, NULL),
(21, 8, 1, 3, 1, 1, 1, NULL, NULL),
(22, 8, 2, 1, 7, 1, 1, NULL, NULL),
(23, 8, 2, 2, 1, 1, 1, NULL, NULL),
(24, 8, 2, 3, 5, 1, 1, NULL, NULL),
(25, 8, 3, 1, 1, 1, 1, NULL, NULL),
(26, 8, 3, 2, 0.2, 1, 1, NULL, NULL),
(27, 8, 3, 3, 1, 1, 1, NULL, NULL),
(28, 9, 1, 1, 1, 1, 1, NULL, NULL),
(29, 9, 1, 2, 0.333333333, 1, 1, NULL, NULL),
(30, 9, 1, 3, 5, 1, 1, NULL, NULL),
(31, 9, 2, 1, 3, 1, 1, NULL, NULL),
(32, 9, 2, 2, 1, 1, 1, NULL, NULL),
(33, 9, 2, 3, 9, 1, 1, NULL, NULL),
(34, 9, 3, 1, 0.2, 1, 1, NULL, NULL),
(35, 9, 3, 2, 0.111111111, 1, 1, NULL, NULL),
(36, 9, 3, 3, 1, 1, 1, NULL, NULL),
(37, 3, 1, 1, 1, 1, 1, NULL, NULL),
(38, 3, 1, 2, 3, 1, 1, NULL, NULL),
(39, 3, 1, 3, 7, 1, 1, NULL, NULL),
(40, 3, 2, 1, 0.333333333, 1, 1, NULL, NULL),
(41, 3, 2, 2, 1, 1, 1, NULL, NULL),
(42, 3, 2, 3, 5, 1, 1, NULL, NULL),
(43, 3, 3, 1, 0.142857143, 1, 1, NULL, NULL),
(44, 3, 3, 2, 0.2, 1, 1, NULL, NULL),
(45, 3, 3, 3, 1, 1, 1, NULL, NULL),
(46, 4, 1, 1, 1, 1, 1, NULL, NULL),
(47, 4, 1, 2, 5, 1, 1, NULL, NULL),
(48, 4, 1, 3, 9, 1, 1, NULL, NULL),
(49, 4, 2, 1, 0.2, 1, 1, NULL, NULL),
(50, 4, 2, 2, 1, 1, 1, NULL, NULL),
(51, 4, 2, 3, 5, 1, 1, NULL, NULL),
(52, 4, 3, 1, 0.111111111, 1, 1, NULL, NULL),
(53, 4, 3, 2, 0.2, 1, 1, NULL, NULL),
(54, 4, 3, 3, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine_evaluations`
--

CREATE TABLE IF NOT EXISTS `engine_evaluations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `child` int(11) NOT NULL,
  `engine_project_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `engine_evaluations`
--

INSERT INTO `engine_evaluations` (`id`, `name`, `child`, `engine_project_id`, `created`, `modified`) VALUES
(2, '安全性', 0, 1, NULL, NULL),
(3, '値段', 0, 1, NULL, NULL),
(4, '大きさ', 0, 1, NULL, NULL),
(5, 'デザイン', 0, 1, NULL, NULL),
(6, 'エアバッグ', 2, 1, NULL, NULL),
(7, 'ABS', 2, 1, NULL, NULL),
(8, '色', 5, 1, NULL, NULL),
(9, 'スタイル', 5, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine_evaluation_pairs`
--

CREATE TABLE IF NOT EXISTS `engine_evaluation_pairs` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `value` double NOT NULL,
  `engine_project_id` int(11) NOT NULL,
  `engine_user_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `engine_evaluation_pairs`
--

INSERT INTO `engine_evaluation_pairs` (`id`, `from_id`, `to_id`, `value`, `engine_project_id`, `engine_user_id`, `created`, `modified`) VALUES
(1, 6, 6, 1, 1, 1, NULL, NULL),
(2, 6, 7, 7, 1, 1, NULL, NULL),
(3, 7, 6, 0.142857143, 1, 1, NULL, NULL),
(4, 7, 7, 1, 1, 1, NULL, NULL),
(5, 8, 8, 1, 1, 1, NULL, NULL),
(6, 8, 9, 5, 1, 1, NULL, NULL),
(7, 9, 8, 0.2, 1, 1, NULL, NULL),
(8, 9, 9, 1, 1, 1, NULL, NULL),
(9, 2, 2, 1, 1, 1, NULL, NULL),
(10, 2, 3, 5, 1, 1, NULL, NULL),
(11, 2, 4, 0.333333333, 1, 1, NULL, NULL),
(12, 2, 5, 3, 1, 1, NULL, NULL),
(13, 3, 2, 0.2, 1, 1, NULL, NULL),
(14, 3, 3, 1, 1, 1, NULL, NULL),
(15, 3, 4, 0.2, 1, 1, NULL, NULL),
(16, 3, 5, 0.333333333, 1, 1, NULL, NULL),
(17, 4, 2, 3, 1, 1, NULL, NULL),
(18, 4, 3, 5, 1, 1, NULL, NULL),
(19, 4, 4, 1, 1, 1, NULL, NULL),
(20, 4, 5, 7, 1, 1, NULL, NULL),
(21, 5, 2, 0.333333333, 1, 1, NULL, NULL),
(22, 5, 3, 3, 1, 1, NULL, NULL),
(23, 5, 4, 0.142857143, 1, 1, NULL, NULL),
(24, 5, 5, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine_projects`
--

CREATE TABLE IF NOT EXISTS `engine_projects` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `engine_projects`
--

INSERT INTO `engine_projects` (`id`, `name`, `created`, `modified`) VALUES
(1, '新車の選択(ORの基礎 P16)', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine_users`
--

CREATE TABLE IF NOT EXISTS `engine_users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `engine_users`
--

INSERT INTO `engine_users` (`id`, `name`, `created`, `modified`) VALUES
(1, 'Mizuno', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `engine_alternatives`
--
ALTER TABLE `engine_alternatives`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `engine_alternative_pairs`
--
ALTER TABLE `engine_alternative_pairs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `engine_evaluations`
--
ALTER TABLE `engine_evaluations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `engine_evaluation_pairs`
--
ALTER TABLE `engine_evaluation_pairs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `engine_projects`
--
ALTER TABLE `engine_projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `engine_users`
--
ALTER TABLE `engine_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--
--
-- AUTO_INCREMENT for table `engine_alternatives`
--
ALTER TABLE `engine_alternatives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `engine_alternative_pairs`
--
ALTER TABLE `engine_alternative_pairs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=55;
--
-- AUTO_INCREMENT for table `engine_evaluations`
--
ALTER TABLE `engine_evaluations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `engine_evaluation_pairs`
--
ALTER TABLE `engine_evaluation_pairs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `engine_projects`
--
ALTER TABLE `engine_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `engine_users`
--
ALTER TABLE `engine_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
