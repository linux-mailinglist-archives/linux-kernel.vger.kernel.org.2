Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8850244AF04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhKINu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:50:58 -0500
Received: from mx22.baidu.com ([220.181.50.185]:54252 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231169AbhKINu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:50:57 -0500
Received: from BJHW-Mail-Ex10.internal.baidu.com (unknown [10.127.64.33])
        by Forcepoint Email with ESMTPS id E07FED0C67448A1F78BC;
        Tue,  9 Nov 2021 21:48:04 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex10.internal.baidu.com (10.127.64.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:48:04 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:48:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <miquel.raynal@bootlin.com>
CC:     Cai Huoqing <caihuoqing@baidu.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mtd: rawnand: denali: Add the dependency on HAS_IOMEM
Date:   Tue, 9 Nov 2021 21:47:58 +0800
Message-ID: <20211109134758.417-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex10_2021-11-09 21:48:04:890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper function devm_platform_ioremap_resource_xxx()
needs HAS_IOMEM enabled, so add the dependency on HAS_IOMEM.

Fixes: 5f14a8ca1b49 ("mtd: rawnand: denali: Make use of the helper function devm_platform_ioremap_resource_byname()")

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Add a Fixes tag.

 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 67b7cb67c030..0a45d3c6c15b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -26,7 +26,7 @@ config MTD_NAND_DENALI_PCI
 config MTD_NAND_DENALI_DT
 	tristate "Denali NAND controller as a DT device"
 	select MTD_NAND_DENALI
-	depends on HAS_DMA && HAVE_CLK && OF
+	depends on HAS_DMA && HAVE_CLK && OF && HAS_IOMEM
 	help
 	  Enable the driver for NAND flash on platforms using a Denali NAND
 	  controller as a DT device.
-- 
2.25.1

