Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55BB4155C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhIWDHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:07:37 -0400
Received: from mx22.baidu.com ([220.181.50.185]:60652 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238914AbhIWDHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:07:36 -0400
Received: from BC-Mail-Ex27.internal.baidu.com (unknown [172.31.51.21])
        by Forcepoint Email with ESMTPS id 0A421D838DA34BCD8F82;
        Thu, 23 Sep 2021 10:50:35 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex27.internal.baidu.com (172.31.51.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 23 Sep 2021 10:50:34 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:50:34 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: marvell: Kconfig: Add configuration menu for Marvell phy drivers
Date:   Thu, 23 Sep 2021 10:50:28 +0800
Message-ID: <20210923025028.295-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Marvell phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/marvell/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index bdb87c976243..44eb3632e7a3 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -2,6 +2,8 @@
 #
 # Phy drivers for Marvell platforms
 #
+menu "PHY drivers for Marvell platforms"
+
 config ARMADA375_USBCLUSTER_PHY
 	bool "Armada 375 USB cluster PHY support" if COMPILE_TEST
 	default y if MACH_ARMADA_375
@@ -136,3 +138,5 @@ config PHY_MMP3_HSIC
 	  components on MMP3-based boards.
 
 	  To compile this driver as a module, choose M here.
+
+endmenu
-- 
2.25.1

