Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1817F415591
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhIWCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:51:58 -0400
Received: from mx22.baidu.com ([220.181.50.185]:44332 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238928AbhIWCv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:51:57 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id 5E0E8D2FE4E6757A21E8;
        Thu, 23 Sep 2021 10:50:12 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 23 Sep 2021 10:50:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:50:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: amlogic: Kconfig: Add configuration menu for Amlogic phy drivers
Date:   Thu, 23 Sep 2021 10:50:04 +0800
Message-ID: <20210923025005.136-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Amlogic phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/amlogic/Kconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index db5d0cd757e3..f16802831d56 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -2,10 +2,12 @@
 #
 # Phy drivers for Amlogic platforms
 #
+menu "PHY drivers for Amlogic platforms"
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+
 config PHY_MESON8B_USB2
 	tristate "Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	depends on USB_SUPPORT
 	select USB_COMMON
 	select GENERIC_PHY
@@ -18,7 +20,6 @@ config PHY_MESON8B_USB2
 config PHY_MESON_GXL_USB2
 	tristate "Meson GXL and GXM USB2 PHY drivers"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select REGMAP_MMIO
@@ -30,7 +31,6 @@ config PHY_MESON_GXL_USB2
 config PHY_MESON_G12A_USB2
 	tristate "Meson G12A USB2 PHY driver"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	help
@@ -41,7 +41,6 @@ config PHY_MESON_G12A_USB2
 config PHY_MESON_G12A_USB3_PCIE
 	tristate "Meson G12A USB3+PCIE Combo PHY driver"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	help
@@ -52,7 +51,6 @@ config PHY_MESON_G12A_USB3_PCIE
 config PHY_MESON_AXG_PCIE
 	tristate "Meson AXG PCIE PHY driver"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	help
@@ -63,7 +61,6 @@ config PHY_MESON_AXG_PCIE
 config PHY_MESON_AXG_MIPI_PCIE_ANALOG
 	tristate "Meson AXG MIPI + PCIE analog PHY driver"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	select GENERIC_PHY_MIPI_DPHY
@@ -75,7 +72,6 @@ config PHY_MESON_AXG_MIPI_PCIE_ANALOG
 config PHY_MESON_AXG_MIPI_DPHY
 	tristate "Meson AXG MIPI DPHY driver"
 	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	select GENERIC_PHY_MIPI_DPHY
@@ -83,3 +79,5 @@ config PHY_MESON_AXG_MIPI_DPHY
 	  Enable this to support the Meson MIPI DPHY found in Meson AXG
 	  SoCs.
 	  If unsure, say N.
+
+endmenu
-- 
2.25.1

