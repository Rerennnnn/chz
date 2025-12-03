-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2025 at 05:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `created_at`) VALUES
(1, 'ren', NULL, '2025-12-03 14:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `rider_id` int(11) DEFAULT NULL,
  `pickup_address` varchar(255) NOT NULL,
  `dropoff_address` varchar(255) NOT NULL,
  `pickup_lat` decimal(10,7) DEFAULT NULL,
  `pickup_lng` decimal(10,7) DEFAULT NULL,
  `dropoff_lat` decimal(10,7) DEFAULT NULL,
  `dropoff_lng` decimal(10,7) DEFAULT NULL,
  `distance_km` decimal(8,2) DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp(),
  `assigned_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `picked_up_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  `status` enum('assigned','accepted','picked_up','delivered','failed','cancelled') NOT NULL DEFAULT 'assigned',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `order_id`, `rider_id`, `pickup_address`, `dropoff_address`, `pickup_lat`, `pickup_lng`, `dropoff_lat`, `dropoff_lng`, `distance_km`, `created_at`, `assigned_at`, `accepted_at`, `picked_up_at`, `delivered_at`, `status`, `notes`) VALUES
(1, 22, 1, 'Cheeze Tea Main Store', '235', NULL, NULL, NULL, NULL, 0.00, '2025-12-02 21:47:51', NULL, '2025-12-02 21:47:58', '2025-12-02 21:48:03', '2025-12-02 22:02:26', 'delivered', NULL),
(2, 23, 1, 'Cheeze Tea Main Store', 'wqewqewqe', NULL, NULL, NULL, NULL, 0.00, '2025-12-03 19:58:28', NULL, '2025-12-03 20:23:16', '2025-12-03 20:23:30', '2025-12-03 20:24:24', 'delivered', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_proofs`
--

CREATE TABLE `delivery_proofs` (
  `id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_proofs`
--

INSERT INTO `delivery_proofs` (`id`, `delivery_id`, `image_path`, `uploaded_at`) VALUES
(1, 1, 'uploads/proofs/1764683312_bg.PNG', '2025-12-02 21:48:32'),
(2, 2, 'uploads/proofs/1764764636_1 (1).jpg', '2025-12-03 20:23:56');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','completed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_id` varchar(255) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(20) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total`, `status`, `created_at`, `payment_id`, `payment_status`, `payment_method`, `customer_name`, `customer_email`, `customer_phone`, `shipping_address`, `notes`) VALUES
(23, 7, 70.50, 'completed', '2025-12-03 11:58:23', 'pi_MysdH1B3Nyk1MGW3DfBVHUzL', 'paid', NULL, 'Rheinier Cuenca', 'cuencarenren@gmail.com', '0923123421', 'wqewqewqe', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(23, 23, 6, 1, 42.00),
(24, 23, 4, 1, 28.50);

-- --------------------------------------------------------

--
-- Table structure for table `payout_settings`
--

CREATE TABLE `payout_settings` (
  `id` int(11) NOT NULL DEFAULT 1,
  `base_pay` decimal(10,2) NOT NULL DEFAULT 30.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payout_settings`
--

INSERT INTO `payout_settings` (`id`, `base_pay`) VALUES
(1, 30.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) DEFAULT 'milktea',
  `stock` int(11) DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `category`, `stock`, `image`, `status`, `created_at`) VALUES
(4, 'Cookies and Cream', 'Smooth milk tea loaded with crushed Oreo bits. Dessert in every sip!', 29.00, 'milktea', 999, 'matcha.jpg', 'active', '2025-11-30 01:32:34'),
(6, 'Wintermelon', 'Light, refreshing, and naturally sweet. The all-time bestseller!', 42.00, 'milktea', 0, '1764500935_692c25c739927.png', 'inactive', '2025-11-30 01:32:34'),
(11, 'Cucumber Fruit Tea', 'Super light and clean, like cold spa water but tastier. Ultra-refreshing on a hot day.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:50:03'),
(12, 'Kiwi Fruit Tea', 'Bright, tangy-sweet with a little tropical zing. Tastes like biting into a fresh kiwi.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:50:30'),
(13, 'Green Apple Fruit Tea', 'Crisp, sour-sweet kick that wakes up your taste buds. Perfect if you love that candy-apple vibe.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:50:52'),
(14, 'Strawberry Fruit Tea', 'Sweet, juicy, and smells exactly like ripe strawberries. The crowd favorite!', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:52:50'),
(15, 'Blueberry Fruit Tea', 'Rich, deep berry sweetness with a soft tart finish. Feels premium and fruity.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:53:12'),
(16, 'Watermelon Fruit Tea', 'Pure summer in a cup. Sweet, watery, and instantly cools you down.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:53:33'),
(17, 'Orange Fruit Tea', 'Fresh-squeezed sunshine. Sweet citrus burst with no bitter aftertaste.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:53:59'),
(18, 'Peach Fruit Tea', 'Soft, fragrant, and naturally sweet—like eating ripe peach slices. So smooth!', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:54:26'),
(19, 'Mango Fruit Tea', 'Thick, sweet Philippine mango goodness. Tastes like mango shake but lighter and iced.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:57:01'),
(20, 'Lychee Fruit Tea', 'Delicately floral and sweet, with that signature lychee perfume. Elegant and addictive.', 29.00, 'fruittea', 999, 'placeholder.jpg', 'active', '2025-12-03 15:57:24'),
(22, 'Lemon Sparkling Soda', 'Bright, zesty lemon with fizzy bubbles that pop in your mouth. The ultimate thirst-killer!', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:01:11'),
(23, 'Cucumber Sparkling Soda', 'Super clean and refreshing, like sparkling spa water with a cool cucumber twist.', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:01:30'),
(24, 'Kiwi Sparkling Soda', 'Tangy-sweet kiwi meets fizzy soda—tropical, vibrant, and insanely refreshing.', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:01:50'),
(25, 'Green Apple Sparkling Soda', 'Crisp, sour-sweet green apple fizz that feels like biting into a cold apple.', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:02:07'),
(27, 'Blueberry Sparkling Soda', 'Rich, jammy blueberry sweetness dancing with sparkling fizz. So satisfying.', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:02:41'),
(28, 'Watermelon Sparkling Soda', 'Pure summer vibes—sweet, light watermelon with effervescent bubbles.', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:02:57'),
(29, 'Orange Sparkling Soda', 'Fresh-squeezed orange brightness in every fizzy sip. Sunshine in a cup!', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:03:14'),
(30, 'Peach Sparkling Soda', 'Soft, fragrant peach flavor with gentle carbonation—smooth and dreamy.', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:03:28'),
(31, 'Mango Sparkling Soda', 'Ripe Philippine mango sweetness + bubbly sparkle. Tastes like mango float, but lighter!', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:03:44'),
(33, 'Passion Fruit Sparkling Soda', 'Bold, tangy passion fruit punch with popping seeds and intense fizz. The most exciting one!', 29.00, 'sparkling', 999, 'placeholder.jpg', 'active', '2025-12-03 16:04:15'),
(34, 'Java Chips', 'Rich coffee milkshake loaded with crunchy chocolate chips. Your caffeine fix in dessert form!', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:07:06'),
(35, 'Oreo Cream', 'Classic Oreo cookies blended into smooth vanilla cream. Every sip has that satisfying cookie crunch.', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:07:22'),
(36, 'Rocky Road', 'Chocolate milkshake packed with marshmallows, nuts, and chocolate bits—heaven for chocolate lovers!', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:07:38'),
(37, 'Strawberry Cream', 'Sweet, fresh strawberry swirled into creamy vanilla ice. Tastes like strawberry ice cream in a cup!', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:07:56'),
(38, 'Blueberry Cream', 'Tangy-sweet blueberry blended with rich cream. Bright, fruity, and ultra-smooth.', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:08:17'),
(39, 'Black Forest', 'Decadent dark chocolate + cherry hints + whipped cream on top. Just like the cake, but drinkable!', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:08:32'),
(40, 'Matcha Cream', 'Premium Japanese matcha blended with sweet cream. Earthy, creamy, and perfectly balanced.', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:08:45'),
(41, 'Mango Graham', 'Ripe Philippine mango + crushed graham crackers + creamy base. Tastes exactly like mango graham float!', 69.00, 'milkshake', 999, 'placeholder.jpg', 'active', '2025-12-03 16:08:58'),
(43, 'Dark Choco', 'Rich, velvety dark chocolate milk tea. Pure chocolate heaven.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:12:22'),
(44, 'Red Velvet', 'Sweet cream cheese flavor with a hint of cocoa—like drinking red velvet cake!', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:12:36'),
(45, 'Okinawa', 'Deep roasted brown sugar milk tea. Caramel-like, super addictive.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:12:50'),
(47, 'Brown Sugar', 'Freshly torched brown sugar syrup with creamy milk. Tiger stripes guaranteed.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:13:20'),
(48, 'Hazelnut', 'Nutty, fragrant hazelnut swirled into fresh milk tea. Smells amazing!', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:13:34'),
(49, 'Black Forest', 'Dark chocolate + cherry hints in milk tea. Decadent and delicious.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:13:46'),
(50, 'Taro', 'Creamy purple taro with that signature sweet, earthy taste. So smooth!', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:13:56'),
(51, 'Hokkaido', 'Rich Japanese caramel milk tea—sweet, buttery, and luxurious.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:14:08'),
(52, 'Chocolate', 'Classic chocolate milk tea. Perfect for chocolate lovers.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:14:17'),
(53, 'Matcha', 'Premium green matcha with fresh milk. Earthy, creamy, and refreshing.', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:14:31'),
(54, 'Candy', 'Fun, sweet cotton-candy flavor that brings back childhood memories!', 29.00, 'milktea', 999, 'placeholder.jpg', 'active', '2025-12-03 16:14:45'),
(55, 'Americano (Black Coffee)', 'Strong and bold classic coffee', 29.00, 'coffee', 999, 'placeholder.jpg', 'active', '2025-12-03 16:15:13'),
(56, 'Latte (Milk and Coffee)', 'Smooth espresso with steamed milk', 29.00, 'coffee', 999, 'placeholder.jpg', 'active', '2025-12-03 16:15:29'),
(57, 'Caramel Macchiato', 'Espresso + milk + caramel drizzle', 29.00, 'coffee', 999, 'placeholder.jpg', 'active', '2025-12-03 16:15:44'),
(58, 'White Chocolate', 'Sweet white chocolate mocha', 29.00, 'coffee', 999, 'placeholder.jpg', 'active', '2025-12-03 16:15:58'),
(60, 'Salted Caramel', 'Sweet-salty caramel coffee bliss', 29.00, 'coffee', 999, 'placeholder.jpg', 'active', '2025-12-03 16:16:23'),
(61, 'Hamburger', 'Juicy burger patty with fresh lettuce and creamy dressing.', 49.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:33:13'),
(62, 'Overload hotdog sandwich', 'Tender, juicy hotdog topped with lots of cheese and sauce.', 49.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:33:34'),
(63, 'Ham & cheese sandwich', 'Classic ham and melted cheese with fresh greens.', 49.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:33:49'),
(64, 'Chicken / tuna sandwich', 'Choice of chicken or tuna with fresh lettuce and mayo.', 49.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:34:04'),
(65, 'Taco', 'Crispy taco shell filled with tasty meat and cheese.', 49.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:34:36'),
(66, 'Pork empanada – 3 pcs', 'Golden, crispy pastry stuffed with seasoned pork.', 69.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:34:58'),
(67, 'Overload Hungarian sausage', 'Big, smoky sausage topped with cheese and sauce.', 69.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:35:12'),
(68, 'French fries', 'Crispy fries with your choice of BBQ, cheese, sour and cream.', 89.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:35:32'),
(69, 'Cheesy fries', 'Fries loaded with rich melted cheese on top.', 109.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:35:46'),
(70, 'Fav shots – 10 pcs', 'Bite-sized snacks, crispy outside and soft inside.', 89.00, 'food', 999, 'placeholder.jpg', 'active', '2025-12-03 16:36:04');

-- --------------------------------------------------------

--
-- Table structure for table `rider_earnings`
--

CREATE TABLE `rider_earnings` (
  `id` int(11) NOT NULL,
  `rider_id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `base_pay` decimal(8,2) NOT NULL DEFAULT 30.00,
  `distance_km` decimal(8,2) NOT NULL DEFAULT 0.00,
  `rate_per_km` decimal(8,2) NOT NULL DEFAULT 10.00,
  `bonus` decimal(8,2) NOT NULL DEFAULT 0.00,
  `penalty` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total` decimal(8,2) GENERATED ALWAYS AS (`base_pay` + `distance_km` * `rate_per_km` + `bonus` - `penalty`) STORED,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rider_earnings`
--

INSERT INTO `rider_earnings` (`id`, `rider_id`, `delivery_id`, `base_pay`, `distance_km`, `rate_per_km`, `bonus`, `penalty`, `created_at`) VALUES
(1, 1, 1, 30.00, 0.00, 10.00, 0.00, 0.00, '2025-12-02 22:02:26'),
(2, 1, 2, 30.00, 0.00, 10.00, 0.00, 0.00, '2025-12-03 20:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `rider_logs`
--

CREATE TABLE `rider_logs` (
  `id` int(11) NOT NULL,
  `rider_id` int(11) NOT NULL,
  `log_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rider_logs`
--

INSERT INTO `rider_logs` (`id`, `rider_id`, `log_type`, `description`, `created_at`) VALUES
(1, 1, 'accepted_delivery', 'Accepted delivery ID 1', '2025-12-02 21:47:58'),
(2, 1, 'picked_up', 'Picked up delivery ID 1', '2025-12-02 21:48:03'),
(3, 1, 'uploaded_proof', 'Uploaded proof for delivery ID 1', '2025-12-02 21:48:32'),
(4, 1, 'delivery_verified', 'Admin verified delivery ID 1 via dashboard', '2025-12-02 22:02:26'),
(5, 1, 'accepted_delivery', 'Accepted delivery ID 2', '2025-12-03 20:23:16'),
(6, 1, 'picked_up', 'Picked up delivery ID 2', '2025-12-03 20:23:30'),
(7, 1, 'uploaded_proof', 'Uploaded proof for delivery ID 2', '2025-12-03 20:23:56'),
(8, 1, 'delivery_verified', 'Admin verified delivery ID 2 via dashboard', '2025-12-03 20:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `rider_status`
--

CREATE TABLE `rider_status` (
  `rider_id` int(11) NOT NULL,
  `status` enum('offline','available','on_delivery','suspended') NOT NULL DEFAULT 'offline',
  `last_update` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rider_status`
--

INSERT INTO `rider_status` (`rider_id`, `status`, `last_update`) VALUES
(1, 'available', '2025-12-03 20:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fb_id` varchar(255) DEFAULT NULL,
  `role` enum('admin','customer') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `fb_id`, `role`, `created_at`) VALUES
(1, 'Admin', 'admin@shop.com', '$2y$10$O4BqyoJDDakmbWDOefEP..dnVXqPa/VRStPVgWBXgvnWkZdgpmmGq', NULL, 'admin', '2025-11-30 01:32:34'),
(7, 'Rheinier Cuenca', 'cuencarenren@gmail.com', '', NULL, '', '2025-11-30 11:57:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rider_id` (`rider_id`);

--
-- Indexes for table `delivery_proofs`
--
ALTER TABLE `delivery_proofs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_id` (`delivery_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payout_settings`
--
ALTER TABLE `payout_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rider_earnings`
--
ALTER TABLE `rider_earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rider_id` (`rider_id`),
  ADD KEY `delivery_id` (`delivery_id`);

--
-- Indexes for table `rider_logs`
--
ALTER TABLE `rider_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rider_id` (`rider_id`);

--
-- Indexes for table `rider_status`
--
ALTER TABLE `rider_status`
  ADD PRIMARY KEY (`rider_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `fb_id` (`fb_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `delivery_proofs`
--
ALTER TABLE `delivery_proofs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `rider_earnings`
--
ALTER TABLE `rider_earnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rider_logs`
--
ALTER TABLE `rider_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `delivery_proofs`
--
ALTER TABLE `delivery_proofs`
  ADD CONSTRAINT `delivery_proofs_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `rider_earnings`
--
ALTER TABLE `rider_earnings`
  ADD CONSTRAINT `rider_earnings_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rider_earnings_ibfk_2` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `rider_logs`
--
ALTER TABLE `rider_logs`
  ADD CONSTRAINT `rider_logs_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
