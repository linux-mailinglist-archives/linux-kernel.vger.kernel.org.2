Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B93FD493
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbhIAHlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:41:37 -0400
Received: from mx21.baidu.com ([220.181.3.85]:52210 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242681AbhIAHlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:41:35 -0400
Received: from BJHW-Mail-Ex07.internal.baidu.com (unknown [10.127.64.17])
        by Forcepoint Email with ESMTPS id 9C92A3482D16142C890C;
        Wed,  1 Sep 2021 15:40:37 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:40:37 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:40:36 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: atmel: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 1 Sep 2021 15:40:30 +0800
Message-ID: <20210901074031.8883-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex07_2021-09-01 15:40:37:499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index cbb023bf00f7..498e41ccabbd 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -834,7 +834,6 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct atmel_pmecc *pmecc;
-	struct resource *res;
 
 	pmecc = devm_kzalloc(dev, sizeof(*pmecc), GFP_KERNEL);
 	if (!pmecc)
@@ -844,13 +843,11 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 	pmecc->dev = dev;
 	mutex_init(&pmecc->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, pmecc_res_idx);
-	pmecc->regs.base = devm_ioremap_resource(dev, res);
+	pmecc->regs.base = devm_platform_ioremap_resource(pdev, pmecc_res_idx);
 	if (IS_ERR(pmecc->regs.base))
 		return ERR_CAST(pmecc->regs.base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, errloc_res_idx);
-	pmecc->regs.errloc = devm_ioremap_resource(dev, res);
+	pmecc->regs.errloc = devm_platform_ioremap_resource(pdev, errloc_res_idx);
 	if (IS_ERR(pmecc->regs.errloc))
 		return ERR_CAST(pmecc->regs.errloc);
 
-- 
2.25.1

