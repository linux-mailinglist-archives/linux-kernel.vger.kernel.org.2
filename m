Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A173A3F5A28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhHXIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:50:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18030 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhHXIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:50:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gv2ks6JVDzbh7G;
        Tue, 24 Aug 2021 16:45:57 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 16:49:46 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 24 Aug
 2021 16:49:46 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-aspeed@lists.ozlabs.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>
Subject: [PATCH -next v2] soc: aspeed-lpc-ctrl: Fix missing clk_disable_unprepare() on error in aspeed_lpc_ctrl_probe()
Date:   Tue, 24 Aug 2021 16:55:22 +0800
Message-ID: <20210824085522.1849410-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move syscon_regmap_lookup_by_compatible() above the
devm_clk_get() to avoid missing clk_disable_unprepare().

Fixes: 2f9b25fa6682 ("soc: aspeed: Re-enable FWH2AHB on AST2600")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 6893c5ec3259..72771e018c42 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -295,6 +295,16 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl")) {
+		lpc_ctrl->fwh2ahb = true;
+
+		lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
+		if (IS_ERR(lpc_ctrl->scu)) {
+			dev_err(dev, "couldn't find scu\n");
+			return PTR_ERR(lpc_ctrl->scu);
+		}
+	}
+
 	lpc_ctrl->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(lpc_ctrl->clk)) {
 		dev_err(dev, "couldn't get clock\n");
@@ -306,16 +316,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl")) {
-		lpc_ctrl->fwh2ahb = true;
-
-		lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
-		if (IS_ERR(lpc_ctrl->scu)) {
-			dev_err(dev, "couldn't find scu\n");
-			return PTR_ERR(lpc_ctrl->scu);
-		}
-	}
-
 	lpc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_ctrl->miscdev.name = DEVICE_NAME;
 	lpc_ctrl->miscdev.fops = &aspeed_lpc_ctrl_fops;
-- 
2.25.1

