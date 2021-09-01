Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173933FD4B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbhIAHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:44:20 -0400
Received: from mx20.baidu.com ([111.202.115.85]:55050 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242852AbhIAHoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:44:03 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id 21D9AE589A3ED9A32759;
        Wed,  1 Sep 2021 15:43:06 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 1 Sep 2021 15:43:06 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:43:05 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: spi-nor: hisi-sfc: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 1 Sep 2021 15:42:59 +0800
Message-ID: <20210901074259.9683-1-caihuoqing@baidu.com>
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
 drivers/mtd/spi-nor/controllers/hisi-sfc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
index 47fbf1d1e557..5b6d1d994641 100644
--- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
@@ -421,7 +421,6 @@ static int hisi_spi_nor_register_all(struct hifmc_host *host)
 static int hisi_spi_nor_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct hifmc_host *host;
 	int ret;
 
@@ -432,13 +431,11 @@ static int hisi_spi_nor_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	host->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
-	host->regbase = devm_ioremap_resource(dev, res);
+	host->regbase = devm_platform_ioremap_resource_byname(pdev, "control");
 	if (IS_ERR(host->regbase))
 		return PTR_ERR(host->regbase);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
-	host->iobase = devm_ioremap_resource(dev, res);
+	host->iobase = devm_platform_ioremap_resource_byname(pdev, "memory");
 	if (IS_ERR(host->iobase))
 		return PTR_ERR(host->iobase);
 
-- 
2.25.1

