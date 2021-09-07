Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70A74025AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbhIGIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:54:07 -0400
Received: from mx21.baidu.com ([220.181.3.85]:36360 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244491AbhIGIyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:54:06 -0400
Received: from BC-Mail-Ex16.internal.baidu.com (unknown [172.31.51.56])
        by Forcepoint Email with ESMTPS id C2893B6FE7BD9E7CFBBB;
        Tue,  7 Sep 2021 16:52:56 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex16.internal.baidu.com (172.31.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 16:52:56 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:52:56 +0800
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
Subject: [PATCH] clk: sunxi-ng: ccu-sun9i-a80-usb: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 7 Sep 2021 16:52:49 +0800
Message-ID: <20210907085250.4917-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex09.internal.baidu.com (172.31.51.49) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index 4b4a507d04ed..adac159a5f63 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -92,13 +92,11 @@ static const struct sunxi_ccu_desc sun9i_a80_usb_clk_desc = {
 
 static int sun9i_a80_usb_clk_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct clk *bus_clk;
 	void __iomem *reg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(&pdev->dev, res);
+	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.25.1

