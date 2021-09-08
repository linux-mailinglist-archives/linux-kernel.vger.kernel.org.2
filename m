Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6866E403864
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349148AbhIHK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:58:24 -0400
Received: from mx21.baidu.com ([220.181.3.85]:40672 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348945AbhIHK6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:58:23 -0400
Received: from BJHW-Mail-Ex01.internal.baidu.com (unknown [10.127.64.11])
        by Forcepoint Email with ESMTPS id 944D7EEFCA29336A46B0;
        Wed,  8 Sep 2021 18:57:14 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:57:14 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:57:14 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/irq-ts4800: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 18:57:07 +0800
Message-ID: <20210908105708.1729-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/irqchip/irq-ts4800.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 34337a61b1ef..f032db23b30f 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -93,15 +93,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct ts4800_irq_data *data;
 	struct irq_chip *irq_chip;
-	struct resource *res;
 	int parent_irq;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
2.25.1

