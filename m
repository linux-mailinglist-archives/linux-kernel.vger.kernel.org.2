Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5C3BE795
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhGGMGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhGGMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:06:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E77C06175F;
        Wed,  7 Jul 2021 05:03:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:c375:7561:3857:648])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3C6231F43284;
        Wed,  7 Jul 2021 13:03:38 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, algea.cao@rock-chips.com,
        andy.yan@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 2/2] drm/rockchip: dw_hdmi: add rk3568 support
Date:   Wed,  7 Jul 2021 14:03:23 +0200
Message-Id: <20210707120323.401785-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
References: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new dw_hdmi_plat_data struct and new compatible for rk3568.
This version of the HDMI hardware block need two clocks to provide
phy reference clock: hclk_vio and hclk.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
- Add the clocks needed for the phy.

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 68 +++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 830bdd5e9b7ce..dc0e255e45745 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -50,6 +50,10 @@
 #define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_HDMI_LCDC_SEL		BIT(6)
 
+#define RK3568_GRF_VO_CON1		0x0364
+#define RK3568_HDMI_SDAIN_MSK		BIT(15)
+#define RK3568_HDMI_SCLIN_MSK		BIT(14)
+
 #define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
 
 /**
@@ -71,6 +75,8 @@ struct rockchip_hdmi {
 	const struct rockchip_hdmi_chip_data *chip_data;
 	struct clk *vpll_clk;
 	struct clk *grf_clk;
+	struct clk *hclk_vio;
+	struct clk *hclk_vop;
 	struct dw_hdmi *hdmi;
 	struct phy *phy;
 };
@@ -216,6 +222,26 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 		return PTR_ERR(hdmi->grf_clk);
 	}
 
+	hdmi->hclk_vio = devm_clk_get(hdmi->dev, "hclk_vio");
+	if (PTR_ERR(hdmi->hclk_vio) == -ENOENT) {
+		hdmi->hclk_vio = NULL;
+	} else if (PTR_ERR(hdmi->hclk_vio) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(hdmi->hclk_vio)) {
+		dev_err(hdmi->dev, "failed to get hclk_vio clock\n");
+		return PTR_ERR(hdmi->hclk_vio);
+	}
+
+	hdmi->hclk_vop = devm_clk_get(hdmi->dev, "hclk");
+	if (PTR_ERR(hdmi->hclk_vop) == -ENOENT) {
+		hdmi->hclk_vop = NULL;
+	} else if (PTR_ERR(hdmi->hclk_vop) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(hdmi->hclk_vop)) {
+		dev_err(hdmi->dev, "failed to get hclk_vop clock\n");
+		return PTR_ERR(hdmi->hclk_vop);
+	}
+
 	return 0;
 }
 
@@ -467,6 +493,19 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
 	.use_drm_infoframe = true,
 };
 
+static struct rockchip_hdmi_chip_data rk3568_chip_data = {
+	.lcdsel_grf_reg = -1,
+};
+
+static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
+	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.mpll_cfg   = rockchip_mpll_cfg,
+	.cur_ctr    = rockchip_cur_ctr,
+	.phy_config = rockchip_phy_config,
+	.phy_data = &rk3568_chip_data,
+	.use_drm_infoframe = true,
+};
+
 static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3228-dw-hdmi",
 	  .data = &rk3228_hdmi_drv_data
@@ -480,6 +519,9 @@ static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3399-dw-hdmi",
 	  .data = &rk3399_hdmi_drv_data
 	},
+	{ .compatible = "rockchip,rk3568-dw-hdmi",
+	  .data = &rk3568_hdmi_drv_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_hdmi_rockchip_dt_ids);
@@ -536,6 +578,28 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	ret = clk_prepare_enable(hdmi->hclk_vio);
+	if (ret) {
+		dev_err(hdmi->dev, "Failed to enable HDMI hclk_vio: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(hdmi->hclk_vop);
+	if (ret) {
+		dev_err(hdmi->dev, "Failed to enable HDMI hclk_vop: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (hdmi->chip_data == &rk3568_chip_data) {
+		regmap_write(hdmi->regmap, RK3568_GRF_VO_CON1,
+			     HIWORD_UPDATE(RK3568_HDMI_SDAIN_MSK |
+					   RK3568_HDMI_SCLIN_MSK,
+					   RK3568_HDMI_SDAIN_MSK |
+					   RK3568_HDMI_SCLIN_MSK));
+	}
+
 	hdmi->phy = devm_phy_optional_get(dev, "hdmi");
 	if (IS_ERR(hdmi->phy)) {
 		ret = PTR_ERR(hdmi->phy);
@@ -559,6 +623,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		ret = PTR_ERR(hdmi->hdmi);
 		drm_encoder_cleanup(encoder);
 		clk_disable_unprepare(hdmi->vpll_clk);
+		clk_disable_unprepare(hdmi->hclk_vio);
+		clk_disable_unprepare(hdmi->hclk_vop);
 	}
 
 	return ret;
@@ -571,6 +637,8 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 
 	dw_hdmi_unbind(hdmi->hdmi);
 	clk_disable_unprepare(hdmi->vpll_clk);
+	clk_disable_unprepare(hdmi->hclk_vio);
+	clk_disable_unprepare(hdmi->hclk_vop);
 }
 
 static const struct component_ops dw_hdmi_rockchip_ops = {
-- 
2.25.1

