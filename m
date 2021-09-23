Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87838415592
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhIWCv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:51:59 -0400
Received: from mx22.baidu.com ([220.181.50.185]:44422 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238942AbhIWCv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:51:57 -0400
Received: from BC-Mail-Ex29.internal.baidu.com (unknown [172.31.51.23])
        by Forcepoint Email with ESMTPS id C9B9EC297416FE18DC11;
        Thu, 23 Sep 2021 10:50:19 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex29.internal.baidu.com (172.31.51.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 23 Sep 2021 10:50:19 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:50:19 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: broadcom: Kconfig: Add configuration menu for Broadcom phy drivers
Date:   Thu, 23 Sep 2021 10:50:13 +0800
Message-ID: <20210923025013.189-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Broadcom phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/broadcom/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index fd92b73b7109..f81e23742079 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -2,6 +2,8 @@
 #
 # Phy drivers for Broadcom platforms
 #
+menu "PHY drivers for Broadcom platforms"
+
 config PHY_BCM63XX_USBH
 	tristate "BCM63xx USBH PHY driver"
 	depends on BMIPS_GENERIC || COMPILE_TEST
@@ -112,3 +114,5 @@ config PHY_BCM_SR_PCIE
 	help
 	  Enable this to support the Broadcom Stingray PCIe PHY
 	  If unsure, say N.
+
+endmenu
-- 
2.25.1

