Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24BB409A93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbhIMRXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbhIMRXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:23:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:21:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so15865601wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrzTc/1zoYYYGD7G7LJ59jCYQOmSJ3iceMMpSlQqQiA=;
        b=hT0mhz+Zvp3enG3kIlyNKe7Pc6CrBCXJG2KsFsBH7q2E6R2L2B0PQi3PIdknvdFocY
         fVDesyoCuyuzHbgFaJjKsPGKOPSCg0TPX5CGEcYMZ9CzUrT1Jvy7luyfuQUqnRui3671
         RVV9M7FkQGZjdLUuU0wh6C+rmTA0MzLfVbC/l6MTJ1X8stAV0UTw+n59jY9FbPhgRfza
         LXRrUIeG1OJ0yFy1mSdXo85wpg/B5mWiVsUlJ1rxyvngHlB6zp+oRRPIbJBxoEnuhsoT
         Z0Lzl3yH1Syk7IDthwa/F+vr3fB+9VbSiIX+sIqxC/bXQEyHUnbAu7IYD2TBJRERF+cw
         zPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrzTc/1zoYYYGD7G7LJ59jCYQOmSJ3iceMMpSlQqQiA=;
        b=GsVOAyJdMMSxV69EI/yiFy0AfIuwdnaSg/qRwNmnqroWx+IeaEq5F9WpedAYWSKvXo
         MrwO3O9fVKxvoO9bJlr0D6tBRiYWqD+aFCNhDIRagpWndsRbS+MAFxwMvoIiFXgVvlYs
         lVHCePLZbRL0ScYxyBMO9SlDWDRXjGcmToAUv8cplPSsDegHhwejk80WOJqSBbfHyujs
         5Z4Hpe/TaTthKyRwHVfn73iA4iBGZpMUmJSSnCMph9nmIUI5tET40tU2KK9dCfWmDMIz
         NoeIVhBVu0JymLaYv3veE8wMHDXvrxG6x+zoOPg7YMPTYukQco5cFN4JBcwgX09DLaM0
         a3hQ==
X-Gm-Message-State: AOAM531afo7aDY2wVCJ0akKRIg3sKIzbrA5CwER635nvFdpw/wPoXDqX
        AKWzB17LhMW34DH3PdIdpKU=
X-Google-Smtp-Source: ABdhPJxjz+O3ZFSrqcGDTtlgKhXzBClcWM+vqoE/AfEAO11MukJmqzep7AYV+x6J9r/6tJ1odVNIbg==
X-Received: by 2002:adf:ec81:: with SMTP id z1mr13644572wrn.181.1631553718521;
        Mon, 13 Sep 2021 10:21:58 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id x11sm7555633wmk.21.2021.09.13.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:21:58 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, saravanak@google.com,
        megous@megous.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/sun4i: dw-hdmi: Fix HDMI PHY clock setup
Date:   Mon, 13 Sep 2021 19:21:54 +0200
Message-Id: <20210913172154.2686-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent rework, which made HDMI PHY driver a platform device, inadvertely
reversed clock setup order. HW is very touchy about it. Proper way is to
handle controllers resets and clocks first and HDMI PHYs second.

Currently, without this fix, first mode set completely fails (nothing on
HDMI monitor) on H3 era PHYs. On H6, it still somehow work.

Move HDMI PHY reset & clocks handling to sun8i_hdmi_phy_init() which
will assure that code is executed after controllers reset & clocks are
handled. Additionally, add sun8i_hdmi_phy_deinit() which will deinit
them at controllers driver unload.

Tested on A64, H3, H6 and R40.

Fixes: 9bf3797796f5 ("drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  7 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  4 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 97 ++++++++++++++------------
 3 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index f75fb157f2ff..5fa5407ac583 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -216,11 +216,13 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 	}
 
+	ret = sun8i_hdmi_phy_init(hdmi->phy);
+	if (ret)
+		return ret;
+
 	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
 	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 
-	sun8i_hdmi_phy_init(hdmi->phy);
-
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;
 	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
@@ -262,6 +264,7 @@ static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
 	struct sun8i_dw_hdmi *hdmi = dev_get_drvdata(dev);
 
 	dw_hdmi_unbind(hdmi->hdmi);
+	sun8i_hdmi_phy_deinit(hdmi->phy);
 	clk_disable_unprepare(hdmi->clk_tmds);
 	reset_control_assert(hdmi->rst_ctrl);
 	gpiod_set_value(hdmi->ddc_en, 0);
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 74f6ed0e2570..bffe1b9cd3dc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -169,6 +169,7 @@ struct sun8i_hdmi_phy {
 	struct clk			*clk_phy;
 	struct clk			*clk_pll0;
 	struct clk			*clk_pll1;
+	struct device			*dev;
 	unsigned int			rcal;
 	struct regmap			*regs;
 	struct reset_control		*rst_phy;
@@ -205,7 +206,8 @@ encoder_to_sun8i_dw_hdmi(struct drm_encoder *encoder)
 
 int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node);
 
-void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
+int sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
+void sun8i_hdmi_phy_deinit(struct sun8i_hdmi_phy *phy);
 void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
 			    struct dw_hdmi_plat_data *plat_data);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index c9239708d398..78b152973957 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -506,9 +506,60 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
 	phy->rcal = (val & SUN8I_HDMI_PHY_ANA_STS_RCAL_MASK) >> 2;
 }
 
-void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
+int sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
 {
+	int ret;
+
+	ret = reset_control_deassert(phy->rst_phy);
+	if (ret) {
+		dev_err(phy->dev, "Cannot deassert phy reset control: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(phy->clk_bus);
+	if (ret) {
+		dev_err(phy->dev, "Cannot enable bus clock: %d\n", ret);
+		goto err_deassert_rst_phy;
+	}
+
+	ret = clk_prepare_enable(phy->clk_mod);
+	if (ret) {
+		dev_err(phy->dev, "Cannot enable mod clock: %d\n", ret);
+		goto err_disable_clk_bus;
+	}
+
+	if (phy->variant->has_phy_clk) {
+		ret = sun8i_phy_clk_create(phy, phy->dev,
+					   phy->variant->has_second_pll);
+		if (ret) {
+			dev_err(phy->dev, "Couldn't create the PHY clock\n");
+			goto err_disable_clk_mod;
+		}
+
+		clk_prepare_enable(phy->clk_phy);
+	}
+
 	phy->variant->phy_init(phy);
+
+	return 0;
+
+err_disable_clk_mod:
+	clk_disable_unprepare(phy->clk_mod);
+err_disable_clk_bus:
+	clk_disable_unprepare(phy->clk_bus);
+err_deassert_rst_phy:
+	reset_control_assert(phy->rst_phy);
+
+	return ret;
+}
+
+void sun8i_hdmi_phy_deinit(struct sun8i_hdmi_phy *phy)
+{
+	clk_disable_unprepare(phy->clk_mod);
+	clk_disable_unprepare(phy->clk_bus);
+	clk_disable_unprepare(phy->clk_phy);
+
+	reset_control_assert(phy->rst_phy);
 }
 
 void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
@@ -638,6 +689,7 @@ static int sun8i_hdmi_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	phy->variant = (struct sun8i_hdmi_phy_variant *)match->data;
+	phy->dev = dev;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
@@ -696,47 +748,10 @@ static int sun8i_hdmi_phy_probe(struct platform_device *pdev)
 		goto err_put_clk_pll1;
 	}
 
-	ret = reset_control_deassert(phy->rst_phy);
-	if (ret) {
-		dev_err(dev, "Cannot deassert phy reset control: %d\n", ret);
-		goto err_put_rst_phy;
-	}
-
-	ret = clk_prepare_enable(phy->clk_bus);
-	if (ret) {
-		dev_err(dev, "Cannot enable bus clock: %d\n", ret);
-		goto err_deassert_rst_phy;
-	}
-
-	ret = clk_prepare_enable(phy->clk_mod);
-	if (ret) {
-		dev_err(dev, "Cannot enable mod clock: %d\n", ret);
-		goto err_disable_clk_bus;
-	}
-
-	if (phy->variant->has_phy_clk) {
-		ret = sun8i_phy_clk_create(phy, dev,
-					   phy->variant->has_second_pll);
-		if (ret) {
-			dev_err(dev, "Couldn't create the PHY clock\n");
-			goto err_disable_clk_mod;
-		}
-
-		clk_prepare_enable(phy->clk_phy);
-	}
-
 	platform_set_drvdata(pdev, phy);
 
 	return 0;
 
-err_disable_clk_mod:
-	clk_disable_unprepare(phy->clk_mod);
-err_disable_clk_bus:
-	clk_disable_unprepare(phy->clk_bus);
-err_deassert_rst_phy:
-	reset_control_assert(phy->rst_phy);
-err_put_rst_phy:
-	reset_control_put(phy->rst_phy);
 err_put_clk_pll1:
 	clk_put(phy->clk_pll1);
 err_put_clk_pll0:
@@ -753,12 +768,6 @@ static int sun8i_hdmi_phy_remove(struct platform_device *pdev)
 {
 	struct sun8i_hdmi_phy *phy = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(phy->clk_mod);
-	clk_disable_unprepare(phy->clk_bus);
-	clk_disable_unprepare(phy->clk_phy);
-
-	reset_control_assert(phy->rst_phy);
-
 	reset_control_put(phy->rst_phy);
 
 	clk_put(phy->clk_pll0);
-- 
2.33.0

