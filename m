Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3795410484
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhIRG4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:56:45 -0400
Received: from mx22.baidu.com ([220.181.50.185]:48438 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238665AbhIRG4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:56:41 -0400
Received: from BC-Mail-Ex05.internal.baidu.com (unknown [172.31.51.45])
        by Forcepoint Email with ESMTPS id 77B19B1AE45D7A697128;
        Sat, 18 Sep 2021 14:55:16 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex05.internal.baidu.com (172.31.51.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 18 Sep 2021 14:55:16 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 18 Sep 2021 14:55:15 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: hisilicon: Kconfig: Add configuration menu for Hisilicon clock driver
Date:   Sat, 18 Sep 2021 14:55:09 +0800
Message-ID: <20210918065510.18699-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Hisilicon clock drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/clk/hisilicon/Kconfig | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index c1ec75aa4ccd..6f7742dc52c2 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
+menu "Clock driver support for Hisilicon"
+	depends on ARCH_HISI || COMPILE_TEST
+
 config COMMON_CLK_HI3516CV300
 	tristate "HI3516CV300 Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	select RESET_HISI
 	default ARCH_HISI
 	help
@@ -9,7 +11,6 @@ config COMMON_CLK_HI3516CV300
 
 config COMMON_CLK_HI3519
 	tristate "Hi3519 Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	select RESET_HISI
 	default ARCH_HISI
 	help
@@ -17,7 +18,6 @@ config COMMON_CLK_HI3519
 
 config COMMON_CLK_HI3559A
 	bool "Hi3559A Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	select RESET_HISI
 	default ARCH_HISI
 	help
@@ -25,21 +25,18 @@ config COMMON_CLK_HI3559A
 
 config COMMON_CLK_HI3660
 	bool "Hi3660 Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	default ARCH_HISI
 	help
 	  Build the clock driver for hi3660.
 
 config COMMON_CLK_HI3670
 	bool "Hi3670 Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	default ARCH_HISI
 	help
 	  Build the clock driver for hi3670.
 
 config COMMON_CLK_HI3798CV200
 	tristate "Hi3798CV200 Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	select RESET_HISI
 	default ARCH_HISI
 	help
@@ -47,21 +44,19 @@ config COMMON_CLK_HI3798CV200
 
 config COMMON_CLK_HI6220
 	bool "Hi6220 Clock Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	default ARCH_HISI
 	help
 	  Build the Hisilicon Hi6220 clock driver based on the common clock framework.
 
 config RESET_HISI
 	bool "HiSilicon Reset Controller Driver"
-	depends on ARCH_HISI || COMPILE_TEST
 	select RESET_CONTROLLER
 	help
 	  Build reset controller driver for HiSilicon device chipsets.
 
 config STUB_CLK_HI6220
 	bool "Hi6220 Stub Clock Driver" if EXPERT
-	depends on (COMMON_CLK_HI6220 || COMPILE_TEST)
+	depends on COMMON_CLK_HI6220
 	depends on MAILBOX
 	default COMMON_CLK_HI6220
 	help
@@ -69,8 +64,10 @@ config STUB_CLK_HI6220
 
 config STUB_CLK_HI3660
 	bool "Hi3660 Stub Clock Driver" if EXPERT
-	depends on (COMMON_CLK_HI3660 || COMPILE_TEST)
+	depends on COMMON_CLK_HI3660
 	depends on MAILBOX
 	default COMMON_CLK_HI3660
 	help
 	  Build the Hisilicon Hi3660 stub clock driver.
+
+endmenu
-- 
2.25.1

