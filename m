Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BE3FD4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbhIAHno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:43:44 -0400
Received: from mx21.baidu.com ([220.181.3.85]:54604 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242744AbhIAHnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:43:41 -0400
Received: from BC-Mail-Ex10.internal.baidu.com (unknown [172.31.51.50])
        by Forcepoint Email with ESMTPS id E76E1257303A07114FE1;
        Wed,  1 Sep 2021 15:42:43 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex10.internal.baidu.com (172.31.51.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 1 Sep 2021 15:42:43 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:42:43 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: txx9ndfm: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 1 Sep 2021 15:42:37 +0800
Message-ID: <20210901074237.9533-1-caihuoqing@baidu.com>
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
 drivers/mtd/nand/raw/txx9ndfmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index b8894ac27073..b42d61b30c0b 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -284,13 +284,11 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 	int i;
 	struct txx9ndfmc_drvdata *drvdata;
 	unsigned long gbusclk = plat->gbus_clock;
-	struct resource *res;
 
 	drvdata = devm_kzalloc(&dev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	drvdata->base = devm_ioremap_resource(&dev->dev, res);
+	drvdata->base = devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-- 
2.25.1

