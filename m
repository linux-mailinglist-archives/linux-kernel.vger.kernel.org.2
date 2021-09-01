Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605C93FD4B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbhIAHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:44:21 -0400
Received: from mx20.baidu.com ([111.202.115.85]:55228 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242886AbhIAHoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:44:11 -0400
Received: from BC-Mail-Ex06.internal.baidu.com (unknown [172.31.51.46])
        by Forcepoint Email with ESMTPS id A883CDE0611A31EF6C91;
        Wed,  1 Sep 2021 15:43:13 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex06.internal.baidu.com (172.31.51.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 1 Sep 2021 15:43:13 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:43:12 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        "Pratyush Yadav" <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: spi-nor: nxp-spifi: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 1 Sep 2021 15:43:06 +0800
Message-ID: <20210901074307.9733-1-caihuoqing@baidu.com>
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
 drivers/mtd/spi-nor/controllers/nxp-spifi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
index 2635c80231bb..9032b9ab2eaf 100644
--- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
@@ -381,20 +381,17 @@ static int nxp_spifi_probe(struct platform_device *pdev)
 {
 	struct device_node *flash_np;
 	struct nxp_spifi *spifi;
-	struct resource *res;
 	int ret;
 
 	spifi = devm_kzalloc(&pdev->dev, sizeof(*spifi), GFP_KERNEL);
 	if (!spifi)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "spifi");
-	spifi->io_base = devm_ioremap_resource(&pdev->dev, res);
+	spifi->io_base = devm_platform_ioremap_resource_byname(pdev, "spifi");
 	if (IS_ERR(spifi->io_base))
 		return PTR_ERR(spifi->io_base);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "flash");
-	spifi->flash_base = devm_ioremap_resource(&pdev->dev, res);
+	spifi->flash_base = devm_platform_ioremap_resource_byname(pdev, "flash");
 	if (IS_ERR(spifi->flash_base))
 		return PTR_ERR(spifi->flash_base);
 
-- 
2.25.1

