Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CF3FD495
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbhIAHmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:42:21 -0400
Received: from mx21.baidu.com ([220.181.3.85]:52980 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242699AbhIAHmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:42:20 -0400
Received: from BJHW-Mail-Ex01.internal.baidu.com (unknown [10.127.64.11])
        by Forcepoint Email with ESMTPS id 5E6A51F37D74CA70F191;
        Wed,  1 Sep 2021 15:41:22 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:41:22 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:41:21 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: denali: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 1 Sep 2021 15:41:15 +0800
Message-ID: <20210901074116.8983-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/mtd/nand/raw/denali_dt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index f08740ae282b..8513bb9fcfcc 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -113,7 +113,6 @@ static int denali_dt_chip_init(struct denali_controller *denali,
 static int denali_dt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct denali_dt *dt;
 	const struct denali_dt_data *data;
 	struct denali_controller *denali;
@@ -139,13 +138,11 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (denali->irq < 0)
 		return denali->irq;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "denali_reg");
-	denali->reg = devm_ioremap_resource(dev, res);
+	denali->reg = devm_platform_ioremap_resource_byname(pdev, "denali_reg");
 	if (IS_ERR(denali->reg))
 		return PTR_ERR(denali->reg);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_data");
-	denali->host = devm_ioremap_resource(dev, res);
+	denali->host = devm_platform_ioremap_resource_byname(pdev, "nand_data");
 	if (IS_ERR(denali->host))
 		return PTR_ERR(denali->host);
 
-- 
2.25.1

