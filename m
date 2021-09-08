Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932DF403516
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhIHHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:16:31 -0400
Received: from mx20.baidu.com ([111.202.115.85]:33482 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233764AbhIHHQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:16:29 -0400
Received: from BC-Mail-Ex19.internal.baidu.com (unknown [172.31.51.13])
        by Forcepoint Email with ESMTPS id 4CEA44D27B4514C9CA82;
        Wed,  8 Sep 2021 15:15:20 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex19.internal.baidu.com (172.31.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:15:20 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:15:19 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] soc: mediatek: pwrap: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 8 Sep 2021 15:15:12 +0800
Message-ID: <20210908071512.551-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 952bc554f443..29f1bd42f7a8 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2116,7 +2116,6 @@ static int pwrap_probe(struct platform_device *pdev)
 	struct pmic_wrapper *wrp;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_slave_id = NULL;
-	struct resource *res;
 
 	if (np->child)
 		of_slave_id = of_match_node(of_slave_match_tbl, np->child);
@@ -2136,8 +2135,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	wrp->slave = of_slave_id->data;
 	wrp->dev = &pdev->dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwrap");
-	wrp->base = devm_ioremap_resource(wrp->dev, res);
+	wrp->base = devm_platform_ioremap_resource_byname(pdev, "pwrap");
 	if (IS_ERR(wrp->base))
 		return PTR_ERR(wrp->base);
 
@@ -2151,9 +2149,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	}
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-				"pwrap-bridge");
-		wrp->bridge_base = devm_ioremap_resource(wrp->dev, res);
+		wrp->bridge_base = devm_platform_ioremap_resource_byname(pdev, "pwrap-bridge");
 		if (IS_ERR(wrp->bridge_base))
 			return PTR_ERR(wrp->bridge_base);
 
-- 
2.25.1

