Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07A4303D7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbhJPQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbhJPQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:59:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC6C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:57:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 75so11678328pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YalpFpEwrjTZgx4SBUn577705skSf8T2nrPpiS9fHsk=;
        b=hXLtmpPFFfrYOCYsVdq6OnFzruqkgUQWCa0Xb2AZOF6Ofye/9Bgt1wKzXGPLYsPmNY
         4W68jcb7oybu+mRXUzbihCg1DekTErAFx17Z/8KBMXK6OmBOdJRQJKEvL5nC1ODR44QL
         syTQ8U5+g7R78m5xUDmvbBTs5QCe8fpp58dfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YalpFpEwrjTZgx4SBUn577705skSf8T2nrPpiS9fHsk=;
        b=gnnJ1X5uZS8Ku6jI4QUZaXXvL8aDCY7pF0jjQI3vWf6bfrIOyvB+BpJfaLhciVLaVo
         dJNoidXaTXbDUwSC9CSNbrO0RnCcrV2SDiXIsk4s4Uircei2tAPNAg/k3yiJCuulHz9M
         LxvQezgBUIZBqS5IsJizH/e0rh/9nCOcUfD5dhzlvndi1Z2aKu+XAXzJkrch0pZ0oua/
         zwLN8Ik1K/ZVp4Eph460YSg63Cgsinr4hKClQn05ZUtoRZHjJjSVBsZT7sX6DWhNnKk+
         VW98K5o6Y+1FRPyHGqE+I4pFn3nU2BfAqt+aq8kGuHBi6Uo3dRsHeEMZusn6Bq0QPwEf
         V28Q==
X-Gm-Message-State: AOAM530JrbOfzM4/FlH9UGo58+CkarkXW3kN/Fo8JG0NNYWka5OijnI4
        wmzEmrmQFwfkSWvqPZ+Ic3nKhF/cpau79Q==
X-Google-Smtp-Source: ABdhPJwbPZQc5DY0eg59r3wHqIZD4JnS9HE1ybVukmt4NTwHDOH3zZ2ZHtkcMTNPomv7iCT8wGeeEw==
X-Received: by 2002:a05:6a00:2181:b0:44d:c18d:7af9 with SMTP id h1-20020a056a00218100b0044dc18d7af9mr124194pfi.16.1634403433494;
        Sat, 16 Oct 2021 09:57:13 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:f81c:fe70:b049:bd51])
        by smtp.gmail.com with ESMTPSA id e9sm8407616pjl.41.2021.10.16.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 09:57:13 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
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
Subject: [PATCH 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
Date:   Sat, 16 Oct 2021 09:57:04 -0700
Message-Id: <20211016095644.2.I44ee57ef73528243acf8f29af8d2416b810e1a9d@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
References: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conventionally, panel is listed under the root in the device tree.
When userland asks for display mode, ps8640 bridge is responsible
for returning EDID when ps8640_bridge_get_edid() is called.

Now enable a new option of listing the panel under "aux-bus" of ps8640
bridge node in the device tree. In this case, panel driver can retrieve
EDID by triggering AUX transactions, without ps8640_bridge_get_edid()
calls at all.

To prevent the "old" and "new" options from interfering with each
other's logic flow, disable DRM_BRIDGE_OP_EDID when the new option
is taken.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 52 ++++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index acfe1bf0f936..98884f799ea8 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_dp_aux_bus.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
@@ -149,6 +150,24 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
 	return container_of(aux, struct ps8640, aux);
 }
 
+static bool ps8640_of_panel_on_aux_bus(struct device *dev)
+{
+	struct device_node *bus, *panel;
+
+	if (!dev->of_node)
+		return false;
+
+	bus = of_get_child_by_name(dev->of_node, "aux-bus");
+	if (!bus)
+		return false;
+
+	panel = of_get_child_by_name(bus, "panel");
+	if (!panel)
+		return false;
+
+	return true;
+}
+
 static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
@@ -546,17 +565,6 @@ static int ps8640_probe(struct i2c_client *client)
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
@@ -579,9 +587,16 @@ static int ps8640_probe(struct i2c_client *client)
 
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
@@ -615,6 +630,19 @@ static int ps8640_probe(struct i2c_client *client)
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

