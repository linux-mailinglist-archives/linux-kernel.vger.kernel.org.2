Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86103BBDF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhGEOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhGEOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:05:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B3C061762;
        Mon,  5 Jul 2021 07:03:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:e614:ab69:6d29:3012])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6ABFD1F42A8F;
        Mon,  5 Jul 2021 15:03:19 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 2/2] drm/rockchip: dw_hdmi: add rk3568 support
Date:   Mon,  5 Jul 2021 16:03:04 +0200
Message-Id: <20210705140304.652929-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705140304.652929-1-benjamin.gaignard@collabora.com>
References: <20210705140304.652929-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new dw_hdmi_plat_data struct and new compatible for rk3568.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 830bdd5e9b7ce..5817c3a9fe64b 100644
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
@@ -467,6 +471,19 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
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
@@ -480,6 +497,9 @@ static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3399-dw-hdmi",
 	  .data = &rk3399_hdmi_drv_data
 	},
+	{ .compatible = "rockchip,rk3568-dw-hdmi",
+	  .data = &rk3568_hdmi_drv_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_hdmi_rockchip_dt_ids);
@@ -536,6 +556,14 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
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
-- 
2.25.1

