Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA240D7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhIPK5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:57:54 -0400
Received: from mx24.baidu.com ([111.206.215.185]:35056 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235487AbhIPK5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:57:53 -0400
Received: from BC-Mail-Ex11.internal.baidu.com (unknown [172.31.51.51])
        by Forcepoint Email with ESMTPS id 6157DCA3F27F65723DA1;
        Thu, 16 Sep 2021 18:56:31 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex11.internal.baidu.com (172.31.51.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 16 Sep 2021 18:56:30 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:56:30 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/sun4i: dsi: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:56:24 +0800
Message-ID: <20210916105625.12109-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
And using dev_err_probe() can reduce code size, the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4f5efcace68e..be60b16bcea9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1128,10 +1128,9 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	}
 
 	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
-	if (IS_ERR(dsi->regulator)) {
-		dev_err(dev, "Couldn't get VCC-DSI supply\n");
-		return PTR_ERR(dsi->regulator);
-	}
+	if (IS_ERR(dsi->regulator))
+		return dev_err_probe(dev, PTR_ERR(dsi->regulator),
+				     "Couldn't get VCC-DSI supply\n");
 
 	dsi->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(dsi->reset)) {
@@ -1146,10 +1145,9 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	}
 
 	dsi->bus_clk = devm_clk_get(dev, bus_clk_name);
-	if (IS_ERR(dsi->bus_clk)) {
-		dev_err(dev, "Couldn't get the DSI bus clock\n");
-		return PTR_ERR(dsi->bus_clk);
-	}
+	if (IS_ERR(dsi->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(dsi->bus_clk),
+				     "Couldn't get the DSI bus clock\n");
 
 	ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
 	if (ret)
-- 
2.25.1

