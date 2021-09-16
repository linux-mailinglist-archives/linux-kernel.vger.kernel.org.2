Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA08940D7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhIPK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:58:02 -0400
Received: from mx24.baidu.com ([111.206.215.185]:35222 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237193AbhIPK6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:58:01 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id 35A309D0935FBB00736D;
        Thu, 16 Sep 2021 18:56:39 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 16 Sep 2021 18:56:39 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:56:38 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/sun4i: dw-hdmi: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:56:32 +0800
Message-ID: <20210916105633.12162-1-caihuoqing@baidu.com>
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
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index f75fb157f2ff..21d473deb757 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -153,22 +153,19 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		return -EPROBE_DEFER;
 
 	hdmi->rst_ctrl = devm_reset_control_get(dev, "ctrl");
-	if (IS_ERR(hdmi->rst_ctrl)) {
-		dev_err(dev, "Could not get ctrl reset control\n");
-		return PTR_ERR(hdmi->rst_ctrl);
-	}
+	if (IS_ERR(hdmi->rst_ctrl))
+		return dev_err_probe(dev, PTR_ERR(hdmi->rst_ctrl),
+				     "Could not get ctrl reset control\n");
 
 	hdmi->clk_tmds = devm_clk_get(dev, "tmds");
-	if (IS_ERR(hdmi->clk_tmds)) {
-		dev_err(dev, "Couldn't get the tmds clock\n");
-		return PTR_ERR(hdmi->clk_tmds);
-	}
+	if (IS_ERR(hdmi->clk_tmds))
+		return dev_err_probe(dev, PTR_ERR(hdmi->clk_tmds),
+				     "Couldn't get the tmds clock\n");
 
 	hdmi->regulator = devm_regulator_get(dev, "hvcc");
-	if (IS_ERR(hdmi->regulator)) {
-		dev_err(dev, "Couldn't get regulator\n");
-		return PTR_ERR(hdmi->regulator);
-	}
+	if (IS_ERR(hdmi->regulator))
+		return dev_err_probe(dev, PTR_ERR(hdmi->regulator),
+				     "Couldn't get regulator\n");
 
 	ret = sun8i_dw_hdmi_find_connector_pdev(dev, &connector_pdev);
 	if (!ret) {
-- 
2.25.1

