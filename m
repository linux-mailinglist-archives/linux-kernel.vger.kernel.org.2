Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DD415596
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbhIWCwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:52:17 -0400
Received: from mx22.baidu.com ([220.181.50.185]:44854 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238976AbhIWCwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:52:14 -0400
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id 9EED3CAAFF364093A5D0;
        Thu, 23 Sep 2021 10:50:42 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 23 Sep 2021 10:50:42 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:50:41 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: mediatek: Kconfig: Add configuration menu for Mediatek phy drivers
Date:   Thu, 23 Sep 2021 10:50:35 +0800
Message-ID: <20210923025036.348-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Mediatek phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/mediatek/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 55f8e6c048ab..5da045813b5a 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -2,9 +2,11 @@
 #
 # Phy drivers for Mediatek devices
 #
+menu "PHY drivers for Mediatek platforms"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+
 config PHY_MTK_TPHY
 	tristate "MediaTek T-PHY Driver"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF && OF_ADDRESS
 	depends on HAS_IOMEM
 	select GENERIC_PHY
@@ -18,7 +20,6 @@ config PHY_MTK_TPHY
 
 config PHY_MTK_UFS
 	tristate "MediaTek UFS M-PHY driver"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	help
@@ -29,7 +30,6 @@ config PHY_MTK_UFS
 
 config PHY_MTK_XSPHY
 	tristate "MediaTek XS-PHY Driver"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF && OF_ADDRESS
 	depends on HAS_IOMEM
 	select GENERIC_PHY
@@ -40,7 +40,6 @@ config PHY_MTK_XSPHY
 
 config PHY_MTK_HDMI
 	tristate "MediaTek HDMI-PHY Driver"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on OF
 	select GENERIC_PHY
@@ -49,9 +48,10 @@ config PHY_MTK_HDMI
 
 config PHY_MTK_MIPI_DSI
 	tristate "MediaTek MIPI-DSI Driver"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on OF
 	select GENERIC_PHY
 	help
 	  Support MIPI DSI for Mediatek SoCs.
+
+endmenu
-- 
2.25.1

