Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499A40248E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbhIGHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:42:28 -0400
Received: from mx21.baidu.com ([220.181.3.85]:43564 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240031AbhIGHmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:42:25 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id 24C9E6A0FB6738AAFE7B;
        Tue,  7 Sep 2021 15:41:17 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 15:41:17 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:41:16 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailbox: hi6220: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 15:41:10 +0800
Message-ID: <20210907074111.2196-1-caihuoqing@baidu.com>
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
 drivers/mailbox/hi6220-mailbox.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index 560cd09538b1..fca61f5312d9 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -264,7 +264,6 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct hi6220_mbox *mbox;
-	struct resource *res;
 	int i, err;
 
 	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
@@ -287,15 +286,13 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 	if (mbox->irq < 0)
 		return mbox->irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mbox->ipc = devm_ioremap_resource(dev, res);
+	mbox->ipc = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mbox->ipc)) {
 		dev_err(dev, "ioremap ipc failed\n");
 		return PTR_ERR(mbox->ipc);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	mbox->base = devm_ioremap_resource(dev, res);
+	mbox->base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(mbox->base)) {
 		dev_err(dev, "ioremap buffer failed\n");
 		return PTR_ERR(mbox->base);
-- 
2.25.1

