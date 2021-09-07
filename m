Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6C40248A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhIGHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:42:06 -0400
Received: from mx21.baidu.com ([220.181.3.85]:42820 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233439AbhIGHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:42:04 -0400
Received: from Bc-Mail-Ex13.internal.baidu.com (unknown [172.31.51.53])
        by Forcepoint Email with ESMTPS id AF4D3DCF314260B8D9AE;
        Tue,  7 Sep 2021 15:40:55 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 Bc-Mail-Ex13.internal.baidu.com (172.31.51.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 15:40:55 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:40:55 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailbox: altera: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 15:40:48 +0800
Message-ID: <20210907074049.2043-1-caihuoqing@baidu.com>
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
 drivers/mailbox/mailbox-altera.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index 75282666fb06..afb320e9d69c 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -285,7 +285,6 @@ static const struct mbox_chan_ops altera_mbox_ops = {
 static int altera_mbox_probe(struct platform_device *pdev)
 {
 	struct altera_mbox *mbox;
-	struct resource	*regs;
 	struct mbox_chan *chans;
 	int ret;
 
@@ -299,9 +298,7 @@ static int altera_mbox_probe(struct platform_device *pdev)
 	if (!chans)
 		return -ENOMEM;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	mbox->mbox_base = devm_ioremap_resource(&pdev->dev, regs);
+	mbox->mbox_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mbox->mbox_base))
 		return PTR_ERR(mbox->mbox_base);
 
-- 
2.25.1

