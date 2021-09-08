Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1717403870
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbhIHK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:59:19 -0400
Received: from mx21.baidu.com ([220.181.3.85]:41506 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348997AbhIHK7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:59:00 -0400
Received: from BC-Mail-Ex15.internal.baidu.com (unknown [172.31.51.55])
        by Forcepoint Email with ESMTPS id 6C437233306795A43B4D;
        Wed,  8 Sep 2021 18:57:51 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex15.internal.baidu.com (172.31.51.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 18:57:51 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:57:50 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: ti-abb: Make use of the helper function devm_ioremap related
Date:   Wed, 8 Sep 2021 18:57:44 +0800
Message-ID: <20210908105745.1984-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap/devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/regulator/ti-abb-regulator.c | 31 ++++++----------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index 9f0a4d50cead..2931a0b89bff 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -725,9 +725,7 @@ static int ti_abb_probe(struct platform_device *pdev)
 
 	/* Map ABB resources */
 	if (abb->regs->setup_off || abb->regs->control_off) {
-		pname = "base-address";
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, pname);
-		abb->base = devm_ioremap_resource(dev, res);
+		abb->base = devm_platform_ioremap_resource_byname(pdev, "base-address");
 		if (IS_ERR(abb->base))
 			return PTR_ERR(abb->base);
 
@@ -735,35 +733,18 @@ static int ti_abb_probe(struct platform_device *pdev)
 		abb->control_reg = abb->base + abb->regs->control_off;
 
 	} else {
-		pname = "control-address";
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, pname);
-		abb->control_reg = devm_ioremap_resource(dev, res);
+		abb->control_reg = devm_platform_ioremap_resource_byname(pdev, "control-address");
 		if (IS_ERR(abb->control_reg))
 			return PTR_ERR(abb->control_reg);
 
-		pname = "setup-address";
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, pname);
-		abb->setup_reg = devm_ioremap_resource(dev, res);
+		abb->setup_reg = devm_platform_ioremap_resource_byname(pdev, "setup-address");
 		if (IS_ERR(abb->setup_reg))
 			return PTR_ERR(abb->setup_reg);
 	}
 
-	pname = "int-address";
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, pname);
-	if (!res) {
-		dev_err(dev, "Missing '%s' IO resource\n", pname);
-		return -ENODEV;
-	}
-	/*
-	 * We may have shared interrupt register offsets which are
-	 * write-1-to-clear between domains ensuring exclusivity.
-	 */
-	abb->int_base = devm_ioremap(dev, res->start,
-					     resource_size(res));
-	if (!abb->int_base) {
-		dev_err(dev, "Unable to map '%s'\n", pname);
-		return -ENOMEM;
-	}
+	abb->int_base = devm_platform_ioremap_resource_byname(pdev, "int-address");
+	if (IS_ERR(abb->int_base))
+		return PTR_ERR(abb->int_base);
 
 	/* Map Optional resources */
 	pname = "efuse-address";
-- 
2.25.1

