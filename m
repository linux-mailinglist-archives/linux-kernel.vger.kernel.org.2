Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8843BA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhJZTNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhJZTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:13:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D8C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:11:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3140421pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0h1RnUd5PARdrga1EYHETqmlrMDbPxICwyZdeM0MwaA=;
        b=Xgp1RRotfKk+B9adJOK8VfJB9qYti/n8D/hDo+cpgwU6AhDUqB/LP910crAIqywtWH
         pj/VUbnzA5JRa2fwp7v3cimNE7Q3RYUM4pAADt0m5RJcj2PSTRQdGIskQCj+ShFCZAOP
         IseWPteey1fvnTyLaJNuXJjhL9ZY+GZi1M1TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0h1RnUd5PARdrga1EYHETqmlrMDbPxICwyZdeM0MwaA=;
        b=Clkr+9LapbdBoy8wpnhOmPhSFmCaRKul6O8q9SsRq/tlBH00JtEOk3bAkTNxl6gN76
         UNBDCM2CxOgFFJeUTR3kiBvcnNdN8LVuXW3rNRuFNaHvlBc4movjXoZX+ePQqTURzQu5
         nIUFbIZ2bNC/R9sInc+17StrcGwecjKqcYK8iLg+yyOXQ6fJ0fdtWAlzio3KQZ+IPWUK
         +u4IfLnTPIXIQlLxeM0KXA9GaK8OJg93ejfZ7RS+5RxDkSEj2/UPK2u9fvrkya6oWovr
         mQrOBkL+1HS+uANW1B02zjj63W3VIw3QR1MIesZcrYYU7XCCuxwidsjXtoFC3DfVGfqt
         V0hA==
X-Gm-Message-State: AOAM533Bq0wndUdJljL3OjlqvfzwdkB59AX+wYQ3G6Ws21pW+LHRnhU+
        H1dfz6wY0L2s3J8V+bMveU9mbEd8tRLj2g==
X-Google-Smtp-Source: ABdhPJy92bVOEeUiK1EZRoh5T4Mty2fOyhWuZ9REegD827EDvnT+LjJNQytmWJd7ymsywJ+4wm7imQ==
X-Received: by 2002:a17:90a:af93:: with SMTP id w19mr730703pjq.10.1635275477955;
        Tue, 26 Oct 2021 12:11:17 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:dad:6684:6674:b268])
        by smtp.gmail.com with ESMTPSA id il17sm1591179pjb.52.2021.10.26.12.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:11:17 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
Date:   Tue, 26 Oct 2021 12:11:10 -0700
Message-Id: <20211026121058.v3.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026121058.v3.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
References: <20211026121058.v3.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conventionally, panel is listed under the root of the device tree.
When userland asks for display mode, ps8640 bridge is responsible
for returning EDID when ps8640_bridge_get_edid() is called.

Now enable a new option of listing panel under "aux-bus" of ps8640
bridge node in the device tree. In this case, panel driver can retrieve
EDID by triggering AUX transactions, without ps8640_bridge_get_edid()
calls at all.

To prevent the "old" and "new" options from interfering with each
other's logic flow, disable DRM_BRIDGE_OP_EDID when the new option
is taken.

Signed-off-by: Philip Chen <philipchen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3:
- Fix when to call of_node_put() in ps8640_of_panel_on_aux_bus()

Changes in v2:
- Add of_node_put() calls in ps8640_of_panel_on_aux_bus()
- Select DRM_DP_AUX_BUS for PS8640 driver in Kconfig
- Replace _put_sync() with _put_sync_suspend() in ps8640_post_disable()

 drivers/gpu/drm/bridge/Kconfig         |  1 +
 drivers/gpu/drm/bridge/parade-ps8640.c | 53 +++++++++++++++++++-------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 431b6e12a81f..61db5a66b493 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -182,6 +182,7 @@ config DRM_PARADE_PS8622
 config DRM_PARADE_PS8640
 	tristate "Parade PS8640 MIPI DSI to eDP Converter"
 	depends on OF
+	select DRM_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index ac42a3473770..e737f1a27f30 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_dp_aux_bus.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
@@ -149,7 +150,24 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
 	return container_of(aux, struct ps8640, aux);
 }
 
-static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)
+static bool ps8640_of_panel_on_aux_bus(struct device *dev)
+{
+	struct device_node *bus, *panel;
+
+	bus = of_get_child_by_name(dev->of_node, "aux-bus");
+	if (!bus)
+		return false;
+
+	panel = of_get_child_by_name(bus, "panel");
+	of_node_put(bus);
+	if (!panel)
+		return false;
+	of_node_put(panel);
+
+	return true;
+}
+
+static int ps8640_ensure_hpd(struct ps8640 *ps_bridge)
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
 	struct device *dev = &ps_bridge->page[PAGE2_TOP_CNTL]->dev;
@@ -556,17 +574,6 @@ static int ps8640_probe(struct i2c_client *client)
 	if (!ps_bridge)
 		return -ENOMEM;
 
-	/* port@1 is ps8640 output port */
-	ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
-	if (ret < 0)
-		return ret;
-	if (!panel)
-		return -ENODEV;
-
-	ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-	if (IS_ERR(ps_bridge->panel_bridge))
-		return PTR_ERR(ps_bridge->panel_bridge);
-
 	ps_bridge->supplies[0].supply = "vdd33";
 	ps_bridge->supplies[1].supply = "vdd12";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ps_bridge->supplies),
@@ -589,9 +596,16 @@ static int ps8640_probe(struct i2c_client *client)
 
 	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
 	ps_bridge->bridge.of_node = dev->of_node;
-	ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
 	ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
 
+	/*
+	 * In the device tree, if panel is listed under aux-bus of the bridge
+	 * node, panel driver should be able to retrieve EDID by itself using
+	 * aux-bus. So let's not set DRM_BRIDGE_OP_EDID here.
+	 */
+	if (!ps8640_of_panel_on_aux_bus(&client->dev))
+		ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
+
 	ps_bridge->page[PAGE0_DP_CNTL] = client;
 
 	ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
@@ -630,6 +644,19 @@ static int ps8640_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	devm_of_dp_aux_populate_ep_devices(&ps_bridge->aux);
+
+	/* port@1 is ps8640 output port */
+	ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
+	if (ret < 0)
+		return ret;
+	if (!panel)
+		return -ENODEV;
+
+	ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	if (IS_ERR(ps_bridge->panel_bridge))
+		return PTR_ERR(ps_bridge->panel_bridge);
+
 	drm_bridge_add(&ps_bridge->bridge);
 
 	return 0;
-- 
2.33.0.1079.g6e70778dc9-goog

