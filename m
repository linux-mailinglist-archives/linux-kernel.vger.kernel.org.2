Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904AC402498
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbhIGHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:43:58 -0400
Received: from mx21.baidu.com ([220.181.3.85]:44530 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240577AbhIGHnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:43:08 -0400
Received: from BC-Mail-Ex29.internal.baidu.com (unknown [172.31.51.23])
        by Forcepoint Email with ESMTPS id 2EC1CA7FC10E219AA099;
        Tue,  7 Sep 2021 15:42:00 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex29.internal.baidu.com (172.31.51.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 15:42:00 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:41:59 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] mailbox: stm32-ipcc: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 15:41:53 +0800
Message-ID: <20210907074154.2502-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/mailbox/stm32-ipcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index b84e0587937c..15d538fe2113 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -205,7 +205,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct stm32_ipcc *ipcc;
-	struct resource *res;
 	unsigned long i;
 	int ret;
 	u32 ip_ver;
@@ -235,8 +234,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	}
 
 	/* regs */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ipcc->reg_base = devm_ioremap_resource(dev, res);
+	ipcc->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ipcc->reg_base))
 		return PTR_ERR(ipcc->reg_base);
 
-- 
2.25.1

