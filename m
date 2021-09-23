Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA79B415599
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhIWCwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:52:45 -0400
Received: from mx24.baidu.com ([111.206.215.185]:45396 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238995AbhIWCwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:52:43 -0400
Received: from BC-Mail-Ex23.internal.baidu.com (unknown [172.31.51.17])
        by Forcepoint Email with ESMTPS id D35246FDBC66701E5D7B;
        Thu, 23 Sep 2021 10:51:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex23.internal.baidu.com (172.31.51.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 23 Sep 2021 10:51:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:51:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: samsung: Kconfig: Add configuration menu for Samsung phy drivers
Date:   Thu, 23 Sep 2021 10:50:58 +0800
Message-ID: <20210923025059.507-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex13.internal.baidu.com (172.31.51.53) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a configuration menu to hold many Samsung phy drivers
helps to make the menu display more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/samsung/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index e20d2fcc9fe7..5145230e314b 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -2,6 +2,8 @@
 #
 # Phy drivers for Samsung platforms
 #
+menu "PHY drivers for Samsung platforms"
+
 config PHY_EXYNOS_DP_VIDEO
 	tristate "Exynos SoC series Display Port PHY driver"
 	depends on OF
@@ -103,3 +105,5 @@ config PHY_EXYNOS5250_SATA
 	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
 	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host
 	  port to accept one SATA device.
+
+endmenu
-- 
2.25.1

