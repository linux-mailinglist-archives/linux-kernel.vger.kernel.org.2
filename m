Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13F4024A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbhIGHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:44:13 -0400
Received: from mx21.baidu.com ([220.181.3.85]:44866 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241589AbhIGHnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:43:23 -0400
Received: from BC-Mail-Ex27.internal.baidu.com (unknown [172.31.51.21])
        by Forcepoint Email with ESMTPS id 0376745EFBC73F9C5FD4;
        Tue,  7 Sep 2021 15:42:15 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex27.internal.baidu.com (172.31.51.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 7 Sep 2021 15:42:14 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:42:14 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH] mailbox: tegra-hsp: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 15:42:07 +0800
Message-ID: <20210907074208.2604-1-caihuoqing@baidu.com>
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
 drivers/mailbox/tegra-hsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index acd0675da681..bfd70934a25e 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -640,7 +640,6 @@ static int tegra_hsp_request_shared_irq(struct tegra_hsp *hsp)
 static int tegra_hsp_probe(struct platform_device *pdev)
 {
 	struct tegra_hsp *hsp;
-	struct resource *res;
 	unsigned int i;
 	u32 value;
 	int err;
@@ -654,8 +653,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&hsp->doorbells);
 	spin_lock_init(&hsp->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hsp->regs = devm_ioremap_resource(&pdev->dev, res);
+	hsp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsp->regs))
 		return PTR_ERR(hsp->regs);
 
-- 
2.25.1

