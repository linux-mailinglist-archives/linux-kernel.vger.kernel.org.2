Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3840C42BF99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhJMMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:16:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59260 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMMQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DA090FB03;
        Wed, 13 Oct 2021 14:14:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tODvGRgMKZMh; Wed, 13 Oct 2021 14:14:33 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Andrzej Hajda <andrzej.hajda@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: nwl-dsi: Move bridge add/remove to dsi callbacks
Date:   Wed, 13 Oct 2021 14:14:25 +0200
Message-Id: <4d0ec577fdeb01fa232ffa743fde06129353396a.1634126587.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the panel and bridge_{add,remove} from the bridge callbacks to the
DSI callbacks to make sure we don't indicate readiness to participate in
the display pipeline before the panel is attached.

This was prompted by commit fb8d617f8fd6 ("drm/bridge: Centralize error
message when bridge attach fails") which triggered

  [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/mipi-dsi@30a0 0000 to encoder None-34: -517

during boot.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
This was prompted by the discussion at
https://lore.kernel.org/dri-devel/00493cc61d1443dab1c131c46c5890f95f6f9b25.1634068657.git.agx@sigxcpu.org/

 drivers/gpu/drm/bridge/nwl-dsi.c | 64 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index a7389a0facfb..77aa6f13afef 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -355,6 +355,9 @@ static int nwl_dsi_host_attach(struct mipi_dsi_host *dsi_host,
 {
 	struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi, dsi_host);
 	struct device *dev = dsi->dev;
+	struct drm_bridge *panel_bridge;
+	struct drm_panel *panel;
+	int ret;
 
 	DRM_DEV_INFO(dev, "lanes=%u, format=0x%x flags=0x%lx\n", device->lanes,
 		     device->format, device->mode_flags);
@@ -362,10 +365,43 @@ static int nwl_dsi_host_attach(struct mipi_dsi_host *dsi_host,
 	if (device->lanes < 1 || device->lanes > 4)
 		return -EINVAL;
 
+	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
+					  &panel_bridge);
+	if (ret)
+		return ret;
+
+	if (panel) {
+		panel_bridge = drm_panel_bridge_add(panel);
+		if (IS_ERR(panel_bridge))
+			return PTR_ERR(panel_bridge);
+	}
+	if (!panel_bridge)
+		return -EPROBE_DEFER;
+
+	dsi->panel_bridge = panel_bridge;
 	dsi->lanes = device->lanes;
 	dsi->format = device->format;
 	dsi->dsi_mode_flags = device->mode_flags;
 
+	/*
+	 * The DSI output has been properly configured, we can now safely
+	 * register the input to the bridge framework so that it can take place
+	 * in a display pipeline.
+	 */
+	drm_bridge_add(&dsi->bridge);
+
+	return 0;
+}
+
+static int nwl_dsi_host_detach(struct mipi_dsi_host *dsi_host,
+			       struct mipi_dsi_device *dev)
+{
+	struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi, dsi_host);
+
+	drm_bridge_remove(&dsi->bridge);
+	if (dsi->panel_bridge)
+		drm_panel_bridge_remove(dsi->panel_bridge);
+
 	return 0;
 }
 
@@ -632,6 +668,7 @@ static ssize_t nwl_dsi_host_transfer(struct mipi_dsi_host *dsi_host,
 
 static const struct mipi_dsi_host_ops nwl_dsi_host_ops = {
 	.attach = nwl_dsi_host_attach,
+	.detach = nwl_dsi_host_detach,
 	.transfer = nwl_dsi_host_transfer,
 };
 
@@ -910,35 +947,11 @@ static int nwl_dsi_bridge_attach(struct drm_bridge *bridge,
 				 enum drm_bridge_attach_flags flags)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
-	struct drm_bridge *panel_bridge;
-	struct drm_panel *panel;
-	int ret;
-
-	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
-					  &panel_bridge);
-	if (ret)
-		return ret;
-
-	if (panel) {
-		panel_bridge = drm_panel_bridge_add(panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
-	}
-	dsi->panel_bridge = panel_bridge;
-
-	if (!dsi->panel_bridge)
-		return -EPROBE_DEFER;
 
 	return drm_bridge_attach(bridge->encoder, dsi->panel_bridge, bridge,
 				 flags);
 }
 
-static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
-{	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
-
-	drm_of_panel_bridge_remove(dsi->dev->of_node, 1, 0);
-}
-
 static u32 *nwl_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 						 struct drm_bridge_state *bridge_state,
 						 struct drm_crtc_state *crtc_state,
@@ -984,7 +997,6 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
 	.mode_set		= nwl_dsi_bridge_mode_set,
 	.mode_valid		= nwl_dsi_bridge_mode_valid,
 	.attach			= nwl_dsi_bridge_attach,
-	.detach			= nwl_dsi_bridge_detach,
 };
 
 static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
@@ -1210,7 +1222,6 @@ static int nwl_dsi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	drm_bridge_add(&dsi->bridge);
 	return 0;
 }
 
@@ -1220,7 +1231,6 @@ static int nwl_dsi_remove(struct platform_device *pdev)
 
 	nwl_dsi_deselect_input(dsi);
 	mipi_dsi_host_unregister(&dsi->dsi_host);
-	drm_bridge_remove(&dsi->bridge);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
2.33.0

