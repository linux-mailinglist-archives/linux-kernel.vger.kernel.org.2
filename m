Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5F3FD49E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbhIAHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:43:08 -0400
Received: from mx20.baidu.com ([111.202.115.85]:53818 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242755AbhIAHnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:43:04 -0400
Received: from BC-Mail-Ex15.internal.baidu.com (unknown [172.31.51.55])
        by Forcepoint Email with ESMTPS id C1C3AB27D4FFF1ED20E8;
        Wed,  1 Sep 2021 15:42:06 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex15.internal.baidu.com (172.31.51.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 1 Sep 2021 15:42:06 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 1 Sep 2021 15:42:06 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: omap_elm: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 1 Sep 2021 15:41:59 +0800
Message-ID: <20210901074200.9283-1-caihuoqing@baidu.com>
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
 drivers/mtd/nand/raw/omap_elm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 2b21ce04b3ec..8bab753211e9 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -384,7 +384,7 @@ static irqreturn_t elm_isr(int this_irq, void *dev_id)
 static int elm_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	struct resource *res, *irq;
+	struct resource *irq;
 	struct elm_info *info;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -399,8 +399,7 @@ static int elm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->elm_base = devm_ioremap_resource(&pdev->dev, res);
+	info->elm_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->elm_base))
 		return PTR_ERR(info->elm_base);
 
-- 
2.25.1

