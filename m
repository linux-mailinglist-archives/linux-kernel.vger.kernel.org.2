Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8641559A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbhIWCwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:52:46 -0400
Received: from mx22.baidu.com ([220.181.50.185]:45464 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238989AbhIWCwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:52:45 -0400
Received: from BC-Mail-Ex22.internal.baidu.com (unknown [172.31.51.16])
        by Forcepoint Email with ESMTPS id 07B80323EAD5CF7D5FF9;
        Thu, 23 Sep 2021 10:51:13 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex22.internal.baidu.com (172.31.51.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 23 Sep 2021 10:51:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:51:12 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: socionext: Kconfig: Add configuration menu for Socionext phy drivers
Date:   Thu, 23 Sep 2021 10:51:06 +0800
Message-ID: <20210923025106.560-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Socionext phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/socionext/Kconfig | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
index a3970e0f89da..44241cdca97a 100644
--- a/drivers/phy/socionext/Kconfig
+++ b/drivers/phy/socionext/Kconfig
@@ -2,11 +2,12 @@
 #
 # PHY drivers for Socionext platforms.
 #
+menu "PHY drivers for Socionext platforms"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && HAS_IOMEM
 
 config PHY_UNIPHIER_USB2
 	tristate "UniPhier USB2 PHY driver"
-	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
@@ -18,8 +19,6 @@ config PHY_UNIPHIER_USB2
 
 config PHY_UNIPHIER_USB3
 	tristate "UniPhier USB3 PHY driver"
-	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
 	select GENERIC_PHY
 	help
 	  Enable this to support USB PHY implemented in USB3 controller
@@ -27,8 +26,6 @@ config PHY_UNIPHIER_USB3
 
 config PHY_UNIPHIER_PCIE
 	tristate "Uniphier PHY driver for PCIe controller"
-	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
 	default PCIE_UNIPHIER
 	select GENERIC_PHY
 	help
@@ -37,10 +34,10 @@ config PHY_UNIPHIER_PCIE
 
 config PHY_UNIPHIER_AHCI
 	tristate "UniPhier AHCI PHY driver"
-	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
 	default SATA_AHCI_PLATFORM
 	select GENERIC_PHY
 	help
 	  Enable this to support PHY implemented in AHCI controller
 	  on UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.
+
+endmenu
-- 
2.25.1

