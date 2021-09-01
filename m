Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5F3FD4A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbhIAHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:43:35 -0400
Received: from mx21.baidu.com ([220.181.3.85]:54330 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242794AbhIAHn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:43:28 -0400
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id 0E86B127D52D4CDB4906;
        Wed,  1 Sep 2021 15:42:29 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 1 Sep 2021 15:42:28 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:42:28 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: stm32_fmc2: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 1 Sep 2021 15:42:22 +0800
Message-ID: <20210901074222.9433-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 1c277fbb91f2..97b4e02e43e4 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1899,15 +1899,11 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 
 		nfc->data_phys_addr[chip_cs] = res->start;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM,
-					    mem_region + 1);
-		nfc->cmd_base[chip_cs] = devm_ioremap_resource(dev, res);
+		nfc->cmd_base[chip_cs] = devm_platform_ioremap_resource(pdev, mem_region + 1);
 		if (IS_ERR(nfc->cmd_base[chip_cs]))
 			return PTR_ERR(nfc->cmd_base[chip_cs]);
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM,
-					    mem_region + 2);
-		nfc->addr_base[chip_cs] = devm_ioremap_resource(dev, res);
+		nfc->addr_base[chip_cs] = devm_platform_ioremap_resource(pdev, mem_region + 2);
 		if (IS_ERR(nfc->addr_base[chip_cs]))
 			return PTR_ERR(nfc->addr_base[chip_cs]);
 	}
-- 
2.25.1

