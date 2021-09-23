Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39720415627
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhIWDjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:39:37 -0400
Received: from mx22.baidu.com ([220.181.50.185]:35938 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232419AbhIWDjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:39:36 -0400
Received: from BC-Mail-Ex24.internal.baidu.com (unknown [172.31.51.18])
        by Forcepoint Email with ESMTPS id 12C8927A6B80D3209585;
        Thu, 23 Sep 2021 10:50:58 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex24.internal.baidu.com (172.31.51.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 23 Sep 2021 10:50:57 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:50:57 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: rockchip: Kconfig: Add configuration menu for Rockchip phy drivers
Date:   Thu, 23 Sep 2021 10:50:50 +0800
Message-ID: <20210923025051.454-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Rockchip phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/rockchip/Kconfig | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index e812adad7242..8b6dd594f43e 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -2,16 +2,18 @@
 #
 # Phy drivers for Rockchip platforms
 #
+menu "PHY drivers for Rockchip platforms"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+
 config PHY_ROCKCHIP_DP
 	tristate "Rockchip Display Port PHY Driver"
-	depends on ARCH_ROCKCHIP && OF
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Enable this to support the Rockchip Display Port PHY.
 
 config PHY_ROCKCHIP_DPHY_RX0
 	tristate "Rockchip MIPI Synopsys DPHY RX0 driver"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select GENERIC_PHY_MIPI_DPHY
 	select GENERIC_PHY
 	help
@@ -23,14 +25,14 @@ config PHY_ROCKCHIP_DPHY_RX0
 
 config PHY_ROCKCHIP_EMMC
 	tristate "Rockchip EMMC PHY Driver"
-	depends on ARCH_ROCKCHIP && OF
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Enable this to support the Rockchip EMMC PHY.
 
 config PHY_ROCKCHIP_INNO_HDMI
 	tristate "Rockchip INNO HDMI PHY Driver"
-	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on OF
 	depends on COMMON_CLK
 	depends on HAS_IOMEM
 	select GENERIC_PHY
@@ -39,7 +41,7 @@ config PHY_ROCKCHIP_INNO_HDMI
 
 config PHY_ROCKCHIP_INNO_USB2
 	tristate "Rockchip INNO USB2PHY Driver"
-	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on OF
 	depends on COMMON_CLK
 	depends on EXTCON
 	depends on USB_SUPPORT
@@ -50,7 +52,7 @@ config PHY_ROCKCHIP_INNO_USB2
 
 config PHY_ROCKCHIP_INNO_CSIDPHY
 	tristate "Rockchip Innosilicon MIPI CSI PHY driver"
-	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on OF
 	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	help
@@ -59,7 +61,7 @@ config PHY_ROCKCHIP_INNO_CSIDPHY
 
 config PHY_ROCKCHIP_INNO_DSIDPHY
 	tristate "Rockchip Innosilicon MIPI/LVDS/TTL PHY driver"
-	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on OF
 	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	help
@@ -68,7 +70,7 @@ config PHY_ROCKCHIP_INNO_DSIDPHY
 
 config PHY_ROCKCHIP_PCIE
 	tristate "Rockchip PCIe PHY Driver"
-	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
@@ -77,7 +79,7 @@ config PHY_ROCKCHIP_PCIE
 
 config PHY_ROCKCHIP_TYPEC
 	tristate "Rockchip TYPEC PHY Driver"
-	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF
 	select EXTCON
 	select GENERIC_PHY
 	select RESET_CONTROLLER
@@ -86,7 +88,9 @@ config PHY_ROCKCHIP_TYPEC
 
 config PHY_ROCKCHIP_USB
 	tristate "Rockchip USB2 PHY Driver"
-	depends on ARCH_ROCKCHIP && OF
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Enable this to support the Rockchip USB 2.0 PHY.
+
+endmenu
-- 
2.25.1

