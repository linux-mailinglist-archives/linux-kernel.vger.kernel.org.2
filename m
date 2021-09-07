Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976704025A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbhIGIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:53:46 -0400
Received: from mx21.baidu.com ([220.181.3.85]:35964 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244400AbhIGIxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:53:42 -0400
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
        by Forcepoint Email with ESMTPS id A06ECE442B7AAB127D14;
        Tue,  7 Sep 2021 16:52:34 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:52:34 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:52:33 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: sunxi-ng: ccu-sun8i-r40: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 16:52:27 +0800
Message-ID: <20210907085228.4764-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex09.internal.baidu.com (172.31.51.49) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-09-07 16:52:34:658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 84153418453f..886906d151ea 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1307,14 +1307,12 @@ static struct regmap_config sun8i_r40_ccu_regmap_config = {
 
 static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct regmap *regmap;
 	void __iomem *reg;
 	u32 val;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(&pdev->dev, res);
+	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.25.1

