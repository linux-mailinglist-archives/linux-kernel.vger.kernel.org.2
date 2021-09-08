Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348D4403860
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349105AbhIHK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:58:13 -0400
Received: from mx20.baidu.com ([111.202.115.85]:40340 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349073AbhIHK6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:58:09 -0400
Received: from BJHW-Mail-Ex07.internal.baidu.com (unknown [10.127.64.17])
        by Forcepoint Email with ESMTPS id DDA0A672C11877F805F4;
        Wed,  8 Sep 2021 18:56:59 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:56:59 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:56:59 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/irq-mvebu-icu: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 18:56:52 +0800
Message-ID: <20210908105653.1627-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex07_2021-09-08 18:56:59:842
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 090bc3f4f7d8..3e7297fc5948 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -347,7 +347,6 @@ builtin_platform_driver(mvebu_icu_subset_driver);
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct resource *res;
 	int i;
 
 	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
@@ -357,8 +356,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	icu->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icu->base = devm_ioremap_resource(&pdev->dev, res);
+	icu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(icu->base))
 		return PTR_ERR(icu->base);
 
-- 
2.25.1

