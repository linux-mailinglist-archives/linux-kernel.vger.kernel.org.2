Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6B402491
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhIGHm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:42:58 -0400
Received: from mx20.baidu.com ([111.202.115.85]:43846 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239680AbhIGHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:42:39 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id 72C195C032E891CFF8AE;
        Tue,  7 Sep 2021 15:41:31 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 15:41:31 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:41:30 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailbox: omap: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 15:41:24 +0800
Message-ID: <20210907074125.2298-1-caihuoqing@baidu.com>
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
 drivers/mailbox/omap-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 7295e3835e30..58f3d569f095 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -699,7 +699,6 @@ static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
 
 static int omap_mbox_probe(struct platform_device *pdev)
 {
-	struct resource *mem;
 	int ret;
 	struct mbox_chan *chnls;
 	struct omap_mbox **list, *mbox, *mboxblk;
@@ -776,8 +775,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (!mdev)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdev->mbox_base = devm_ioremap_resource(&pdev->dev, mem);
+	mdev->mbox_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdev->mbox_base))
 		return PTR_ERR(mdev->mbox_base);
 
-- 
2.25.1

