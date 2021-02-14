Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC231B24D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBNTm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBNTmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:42:11 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB3EC061786
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ba1so2561209plb.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bf5bVF/V5mY1BZUCCppx1dZ4tCXtGjp23rohASbcBPw=;
        b=EgPf4vqR/zBJ4fhi76+l20KOIlr0QjBN013wIMcoM2wiR4tPdkayZ9w+h6vCZOgY8X
         F+FEWS1k/va/bp9VhfDwmEiDZjTQO8dwfTYvk65ttsYs/Z1FY529PkCSH3PVcDdR8He4
         cneko4X96/vWJo+LiwzTmV7V2huwgLkpzEUe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bf5bVF/V5mY1BZUCCppx1dZ4tCXtGjp23rohASbcBPw=;
        b=ulF25bQHZFOD9/LNxjow1eX28r5znt+jsuzUHFjzPDjxj46vykcHEs383k0RxG5uA+
         6rlBsJwS0d2/phE2Dh56D88I1C7t/vH4/FEL62Aa/QoUHqW0vmyt7zQXLtEYhf08Bnzn
         Cv5Q6LV9WnhcvcMMYlyxwaNUHVdH2Mjm0ADVQVY1zSOvIz26unWmu8pTX9eOWnltrXHj
         skJ7i1k0RiXq/2Kg8vsyCrXXWI7FYw/5du5dJE/4VuqhAGkCF7v5bZeNMGKy61JjMEJd
         OuvtjiQpyP+sO+Ud5S4w7DBhmk1pTvEuIIlQMvFaVWGZ/WqZb8tHP9/MQXYhCvxmIZFA
         XfuA==
X-Gm-Message-State: AOAM531HPIkobOWZ4lFF8+e0GejsjvLq3XaULFB+W1TKUofA6rgFB6m/
        fsH0qTCRnP515vACU9WxJz5+8g==
X-Google-Smtp-Source: ABdhPJwPwCNcwlAUsWS5/+FaZxoXxf/8pEHUEP2jFGuMeLBc4DXzF+O4eU7ry1PqloOvnMYMZfP4Xw==
X-Received: by 2002:a17:90a:1b6c:: with SMTP id q99mr12487478pjq.137.1613331691135;
        Sun, 14 Feb 2021 11:41:31 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id 125sm15129247pfu.7.2021.02.14.11.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:41:30 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 3/7] drm: sun4i: dsi: Convert to bridge driver
Date:   Mon, 15 Feb 2021 01:10:58 +0530
Message-Id: <20210214194102.126146-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214194102.126146-1-jagan@amarulasolutions.com>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM bridge drivers have build-in handling of treating all display
pipeline components as bridges.

So, convert the existing to a drm bridge driver with a built-in
encoder support for compatibility with existing component drivers.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 75 ++++++++++++++++----------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  6 +++
 2 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 39321299dc27..6f3c5330a468 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -714,10 +714,10 @@ static int sun6i_dsi_start(struct sun6i_dsi *dsi,
 	return 0;
 }
 
-static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
+static void sun6i_dsi_bridge_enable(struct drm_bridge *bridge)
 {
-	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
-	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
+	struct drm_display_mode *mode = &bridge->encoder->crtc->state->adjusted_mode;
+	struct sun6i_dsi *dsi = bridge_to_sun6i_dsi(bridge);
 	struct mipi_dsi_device *device = dsi->device;
 	union phy_configure_opts opts = { };
 	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
@@ -801,9 +801,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	sun6i_dsi_start(dsi, DSI_START_HSD);
 }
 
-static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
+static void sun6i_dsi_bridge_disable(struct drm_bridge *bridge)
 {
-	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
+	struct sun6i_dsi *dsi = bridge_to_sun6i_dsi(bridge);
 
 	DRM_DEBUG_DRIVER("Disabling DSI output\n");
 
@@ -852,9 +852,40 @@ static const struct drm_connector_funcs sun6i_dsi_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
-static const struct drm_encoder_helper_funcs sun6i_dsi_enc_helper_funcs = {
-	.disable	= sun6i_dsi_encoder_disable,
-	.enable		= sun6i_dsi_encoder_enable,
+static int sun6i_dsi_bridge_attach(struct drm_bridge *bridge,
+				   enum drm_bridge_attach_flags flags)
+{
+	struct sun6i_dsi *dsi = bridge_to_sun6i_dsi(bridge);
+	int ret;
+
+	if (dsi->panel_bridge)
+		return drm_bridge_attach(bridge->encoder, dsi->panel_bridge, NULL, 0);
+
+	if (dsi->panel) {
+		drm_connector_helper_add(&dsi->connector,
+					 &sun6i_dsi_connector_helper_funcs);
+		ret = drm_connector_init(bridge->dev, &dsi->connector,
+					 &sun6i_dsi_connector_funcs,
+					 DRM_MODE_CONNECTOR_DSI);
+		if (ret) {
+			dev_err(dsi->dev, "Couldn't initialise the DSI connector\n");
+			goto err_cleanup_connector;
+		}
+
+		drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
+	}
+
+	return 0;
+
+err_cleanup_connector:
+	drm_encoder_cleanup(&dsi->encoder);
+	return ret;
+}
+
+static const struct drm_bridge_funcs sun6i_dsi_bridge_funcs = {
+	.enable		= sun6i_dsi_bridge_enable,
+	.disable	= sun6i_dsi_bridge_disable,
+	.attach		= sun6i_dsi_bridge_attach,
 };
 
 static u32 sun6i_dsi_dcs_build_pkt_hdr(struct sun6i_dsi *dsi,
@@ -1063,8 +1094,6 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 	int ret;
 
-	drm_encoder_helper_add(&dsi->encoder,
-			       &sun6i_dsi_enc_helper_funcs);
 	ret = drm_simple_encoder_init(drm, &dsi->encoder,
 				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
@@ -1073,27 +1102,12 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	}
 	dsi->encoder.possible_crtcs = BIT(0);
 
-	drm_connector_helper_add(&dsi->connector,
-				 &sun6i_dsi_connector_helper_funcs);
-	ret = drm_connector_init(drm, &dsi->connector,
-				 &sun6i_dsi_connector_funcs,
-				 DRM_MODE_CONNECTOR_DSI);
+	ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
 	if (ret) {
-		dev_err(dsi->dev,
-			"Couldn't initialise the DSI connector\n");
+		dev_err(dsi->dev, "Couldn't attach drm bridge\n");
 		goto err_cleanup_connector;
 	}
 
-	drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
-
-	if (dsi->panel_bridge) {
-		ret = drm_bridge_attach(&dsi->encoder, dsi->panel_bridge, NULL, 0);
-		if (ret) {
-			dev_err(dsi->dev, "Couldn't attach drm bridge\n");
-			goto err_cleanup_connector;
-		}
-	}
-
 	return 0;
 
 err_cleanup_connector:
@@ -1199,6 +1213,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		goto err_unprotect_clk;
 	}
 
+	dsi->bridge.funcs = &sun6i_dsi_bridge_funcs;
+	dsi->bridge.of_node = dev->of_node;
+	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
+
+	drm_bridge_add(&dsi->bridge);
+
 	ret = component_add(&pdev->dev, &sun6i_dsi_ops);
 	if (ret) {
 		dev_err(dev, "Couldn't register our component\n");
@@ -1222,6 +1242,7 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
+	drm_bridge_remove(&dsi->bridge);
 	component_del(&pdev->dev, &sun6i_dsi_ops);
 	mipi_dsi_host_unregister(&dsi->host);
 	clk_rate_exclusive_put(dsi->mod_clk);
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 370ecb356a63..5e70666089ad 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -16,6 +16,7 @@
 #define SUN6I_DSI_TCON_DIV	4
 
 struct sun6i_dsi {
+	struct drm_bridge	bridge;
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
 	struct mipi_dsi_host	host;
@@ -38,6 +39,11 @@ static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
 	return container_of(host, struct sun6i_dsi, host);
 };
 
+static inline struct sun6i_dsi *bridge_to_sun6i_dsi(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct sun6i_dsi, bridge);
+}
+
 static inline struct sun6i_dsi *connector_to_sun6i_dsi(struct drm_connector *connector)
 {
 	return container_of(connector, struct sun6i_dsi, connector);
-- 
2.25.1

