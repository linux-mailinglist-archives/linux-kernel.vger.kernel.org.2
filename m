Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F1403866
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351369AbhIHK6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:58:37 -0400
Received: from mx20.baidu.com ([111.202.115.85]:40796 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351239AbhIHK6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:58:32 -0400
Received: from BJHW-Mail-Ex11.internal.baidu.com (unknown [10.127.64.34])
        by Forcepoint Email with ESMTPS id 135F33BF63A00B1E202F;
        Wed,  8 Sep 2021 18:57:22 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:57:21 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:57:21 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] irqchip/stm32: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 18:57:15 +0800
Message-ID: <20210908105715.1780-1-caihuoqing@baidu.com>
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
 drivers/irqchip/irq-stm32-exti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 33c76710f845..b7cb2da71888 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -850,7 +850,6 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	struct irq_domain *parent_domain, *domain;
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct resource *res;
 
 	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
 	if (!host_data)
@@ -888,8 +887,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data->chips_data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host_data->base = devm_ioremap_resource(dev, res);
+	host_data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host_data->base))
 		return PTR_ERR(host_data->base);
 
-- 
2.25.1

