Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6A30D60D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhBCJQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhBCJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:14:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C6C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:13:29 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g15so4185850pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blstrkczrF0azHzWZ1ftNKo3a6psEv5FLcX/MloVE5M=;
        b=FWgUNKiSG8o4zE4RPWoN096MvbZyytIRr+Lf8sbZx1J4Ug1Lw1FkSdrBIE231ibPvv
         jMyPlnLTQ3ipp/RGecO9HgJGl17pGmFR8wMEI0MDIM57K0aofUe3ceMGGmDgJtAh5BM0
         jO2ZZfbYxz0avCxBx7IgDDEAcmvGLceyzWG20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blstrkczrF0azHzWZ1ftNKo3a6psEv5FLcX/MloVE5M=;
        b=mmY86iJdUbSZeyMETiJOP3sSU7I7/eu3V1leRbTaCJz/fIgyu1LKErnFDZzq6osolJ
         JCSZNJw8adZVVSK7pLiBFfj49x1xWgPQIpYKj5ldvvMwqjj8b//9yYuGmlkr9nC6oGJt
         tcUlLbcZZYD9pxMsLTbvf524d32Q1GMjjbLhELyBcBTiEJnkWgpTjAHeUA9mAgByZT4S
         FLb5ylA/Ijor1JqdcnAx+WEoA2JfHPdWKv76ldcPeO+AcgExfaU0b3Sj077WfAEVelfw
         4OkNuXfwOUJkA6yfnObGw11t5WrRhKBm+YMDSbA1sQXnAhc0sSZ07fYBIp3F7ywYLy9S
         eiKw==
X-Gm-Message-State: AOAM532IiIczydf29RN3nPoP6rVEdM8Ka6nh5u0TSIOrp1uxvt4ilYgq
        lBNiimDdr84qjzMlFVys1YfAzA==
X-Google-Smtp-Source: ABdhPJz1mOojiY2wys2t36rkXJ+/Ao36pKJC/pVwWEiOARQIUS/P4A/yXaNJ2k07D6X99kzvQ4ju/w==
X-Received: by 2002:a17:90a:6589:: with SMTP id k9mr2260723pjj.100.1612343608990;
        Wed, 03 Feb 2021 01:13:28 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id l3sm1794520pgn.8.2021.02.03.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:13:27 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
Date:   Wed,  3 Feb 2021 14:43:06 +0530
Message-Id: <20210203091306.140518-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usual I2C configured DSI bridge drivers have drm_bridge_add
in probe and mipi_dsi_attach in bridge attach functions.

With, this approach the drm pipeline is unable to find the
dsi bridge in stm drm drivers since the dw-mipi-dsi bridge is
adding drm bridge during bridge attach operations instead of
the probe.

This specific issue may not encounter for rockchip drm dsi
drivers, since rockchip drm uses component binding operations,
unlike stm drm drivers.

So, possible solutions are
1. Move drm_bridge_add into the dw-mipi-dsi probe.
2. Add mipi_dsi_attach in the bridge drivers probe.
3. Add component binding operations for stm drm drivers.

Option 1 is a relatively possible solution as most of the
mainline drm dsi with bridge drivers have a similar approach
to their dsi host vs bridge registration.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 35 +++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 6b268f9445b3..8a535041f071 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -314,8 +314,6 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 	const struct dw_mipi_dsi_plat_data *pdata = dsi->plat_data;
-	struct drm_bridge *bridge;
-	struct drm_panel *panel;
 	int ret;
 
 	if (device->lanes > dsi->plat_data->max_data_lanes) {
@@ -329,22 +327,6 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;
 
-	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0,
-					  &panel, &bridge);
-	if (ret)
-		return ret;
-
-	if (panel) {
-		bridge = drm_panel_bridge_add_typed(panel,
-						    DRM_MODE_CONNECTOR_DSI);
-		if (IS_ERR(bridge))
-			return PTR_ERR(bridge);
-	}
-
-	dsi->panel_bridge = bridge;
-
-	drm_bridge_add(&dsi->bridge);
-
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(pdata->priv_data, device);
 		if (ret < 0)
@@ -1105,6 +1087,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct reset_control *apb_rst;
 	struct dw_mipi_dsi *dsi;
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
 	int ret;
 
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
@@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	dw_mipi_dsi_debugfs_init(dsi);
 	pm_runtime_enable(dev);
 
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
+					  &panel, &bridge);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (panel) {
+		bridge = drm_panel_bridge_add_typed(panel,
+						    DRM_MODE_CONNECTOR_DSI);
+		if (IS_ERR(bridge))
+			return ERR_PTR(-ENODEV);
+	}
+
+	dsi->panel_bridge = bridge;
+
 	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
 	ret = mipi_dsi_host_register(&dsi->dsi_host);
@@ -1181,6 +1179,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 #ifdef CONFIG_OF
 	dsi->bridge.of_node = pdev->dev.of_node;
 #endif
+	drm_bridge_add(&dsi->bridge);
 
 	return dsi;
 }
-- 
2.25.1

