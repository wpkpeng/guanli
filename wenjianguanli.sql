DROP DATABASE IF EXISTS `wenjianguanli`;
CREATE DATABASE `wenjianguanli`;
use `wenjianguanli`;

DROP DATABASE IF EXISTS `wenjianguanli`;
CREATE DATABASE `wenjianguanli`;
use `wenjianguanli`;

set global innodb_large_prefix=on;

set global innodb_file_per_table=on;

set global innodb_file_format=BARRACUDA;

-- ----------------------------
-- Table structure for admin_info
-- ----------------------------
DROP TABLE IF EXISTS `admin_info`;
CREATE TABLE `admin_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(10) NULL DEFAULT NULL COMMENT '年龄',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `level` int(10) NOT NULL DEFAULT 1 COMMENT '权限等级',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_info
-- ----------------------------
INSERT INTO `admin_info` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '男', 22, '18843232356', 'aa@163.com', 1);
INSERT INTO `admin_info` VALUES (2, 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '男', 23, '18843232356', 'bb@163.com', 1);
INSERT INTO `admin_info` VALUES (3, 'admin3', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '女', 32, '18843232356', 'cc@163.com', 1);

-- ----------------------------
-- Table structure for file_info
-- ----------------------------
DROP TABLE IF EXISTS `file_info`;
CREATE TABLE `file_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上传时间',
  `typeId` bigint(20) NULL DEFAULT NULL COMMENT '文件分类id',
  `fileId` bigint(20) NULL DEFAULT NULL COMMENT '文件id',
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名',
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上传人',
  `level` int(10) NULL DEFAULT NULL COMMENT '用户等级',
  `uploadUserId` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `danwei` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '单位名称',
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关键字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_info
-- ----------------------------
INSERT INTO `file_info` VALUES (4, '保时捷911', '2021-06-08 17:08:09', 4, 15, '保时捷911.jpg', 'admin', 1, 1, '单位A', '豪车');
INSERT INTO `file_info` VALUES (5, '保时捷SUV', '2021-06-09 17:09:26', 5, 16, '保时捷SUV.mp4', 'admin', 1, 1, '单位B', '豪车');
INSERT INTO `file_info` VALUES (6, 'Java基础核心总结', '2021-06-10 16:51:51', 7, 17, 'Java基础核心总结.pdf', 'admin', 1, 1, '单位A', '知识');
INSERT INTO `file_info` VALUES (7, '多啦A梦', '2021-06-10 16:56:17', 4, 18, 'src=http___img.alicdn.com_tfscom_TB-2784154082.jpg%3f_TB2NOdcnhXkpuFjy0FiXXbUfFXa_!!2909201442.jpg&refer=http___img.alicdn.jpg', '张天志', 2, 1, '单位A', '卡通');
INSERT INTO `file_info` VALUES (8, '测试', '2022-04-15 01:37:08', 4, 19, '1.jpg', 'admin', 1, 1, '单位C', '零食');

-- ----------------------------
-- Table structure for nx_system_file_info
-- ----------------------------
DROP TABLE IF EXISTS `nx_system_file_info`;
CREATE TABLE `nx_system_file_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `originName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '存储文件名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nx_system_file_info
-- ----------------------------
INSERT INTO `nx_system_file_info` VALUES (15, '保时捷911.jpg', '保时捷9111623229717317.jpg');
INSERT INTO `nx_system_file_info` VALUES (16, '保时捷SUV.mp4', '保时捷SUV1623229760767.mp4');
INSERT INTO `nx_system_file_info` VALUES (17, 'Java基础核心总结.pdf', 'Java基础核心总结1623315098847.pdf');
INSERT INTO `nx_system_file_info` VALUES (18, 'src=http___img.alicdn.com_tfscom_TB-2784154082.jpg%3f_TB2NOdcnhXkpuFjy0FiXXbUfFXa_!!2909201442.jpg&refer=http___img.alicdn.jpg', 'src=http___img.alicdn.com_tfscom_TB-2784154082.jpg%3f_TB2NOdcnhXkpuFjy0FiXXbUfFXa_!!2909201442.jpg&refer=http___img.alicdn1623315372554.jpg');
INSERT INTO `nx_system_file_info` VALUES (19, '1.jpg', '11649957846561.jpg');

-- ----------------------------
-- Table structure for type_info
-- ----------------------------
DROP TABLE IF EXISTS `type_info`;
CREATE TABLE `type_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件分类信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_info
-- ----------------------------
INSERT INTO `type_info` VALUES (4, '图片文件');
INSERT INTO `type_info` VALUES (5, '视频文件');
INSERT INTO `type_info` VALUES (6, 'word文件');
INSERT INTO `type_info` VALUES (7, 'pdf文件');
INSERT INTO `type_info` VALUES (8, '压缩包文件');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(10) NULL DEFAULT NULL COMMENT '年龄',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `level` int(10) NOT NULL DEFAULT 2 COMMENT '权限等级',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, '张天志', 'e10adc3949ba59abbe56e057f20f883e', '老张', '男', 22, '18843232356', 'aa@163.com', 2);
INSERT INTO `user_info` VALUES (2, '赵千里', 'e10adc3949ba59abbe56e057f20f883e', '老赵', '男', 23, '18843232356', 'bb@163.com', 2);
INSERT INTO `user_info` VALUES (3, '钱优优', 'e10adc3949ba59abbe56e057f20f883e', '老钱', '女', 32, '18843232356', 'cc@163.com', 2);

SET FOREIGN_KEY_CHECKS = 1;
