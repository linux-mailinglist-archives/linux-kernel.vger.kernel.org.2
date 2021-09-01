Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12A3FD4A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhIAHn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:43:29 -0400
Received: from mx21.baidu.com ([220.181.3.85]:54100 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242790AbhIAHnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:43:20 -0400
Received: from BC-Mail-HQEx02.internal.baidu.com (unknown [172.31.51.58])
        by Forcepoint Email with ESMTPS id 99FE6251F107F6DB2D04;
        Wed,  1 Sep 2021 15:42:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEx02.internal.baidu.com (172.31.51.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:42:21 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:42:21 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: plat_nand: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 1 Sep 2021 15:42:14 +0800
Message-ID: <20210901074215.9383-1-caihuoqing@baidu.com>
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
 drivers/mtd/nand/raw/plat_nand.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 7711e1020c21..c1b2072cb507 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -41,7 +41,6 @@ static int plat_nand_probe(struct platform_device *pdev)
 	struct platform_nand_data *pdata = dev_get_platdata(&pdev->dev);
 	struct plat_nand_data *data;
 	struct mtd_info *mtd;
-	struct resource *res;
 	const char **part_types;
 	int err = 0;
 
@@ -65,8 +64,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	nand_controller_init(&data->controller);
 	data->chip.controller = &data->controller;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->io_base = devm_ioremap_resource(&pdev->dev, res);
+	data->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->io_base))
 		return PTR_ERR(data->io_base);
 
-- 
2.25.1

