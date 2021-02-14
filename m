Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC831B24C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBNTmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBNTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:42:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8629BC0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t2so2627833pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WZPMnqVXps+lPno6HH29XofDRK8cGk3vtrNY/1y3YY=;
        b=kFSNtSVX/9Qv2bIkNFV++AVP0nkqI+cc9EHdDg0PlhQmMwSTZ1BhpkglzpmTgYz/zH
         NlxRFdynr7OBoW6qqiI+YLRnhjRW4zshCErSGK1wtcf/sdGXNIoHeROQ6c66i8RftGQD
         jEsGYR+v9T52a11C+iTNg/l6jYzuNL/RwPlPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WZPMnqVXps+lPno6HH29XofDRK8cGk3vtrNY/1y3YY=;
        b=hmhigxi0PvjucOxikkM4vVVoAcfjbwdHj+E8RXsQhliXOv0FXvcoM1fD1OJIQ318O3
         3mxkXgQVDRN+NYkZ91xHA0PlcR+azoOGNaVaH/DI62Nm+GhG4iEJCDi6C9CnBWLffmzZ
         jUshirEehCnv27jNrL1RdI/w2AEcO1q4yCzVSp26X6gx76GPJtXokamYpSSSSv0IIbNn
         88v5ANG5mAn+nxEixeK7NEbBRIsCaEgK1NnGHec7rZ1hN0PTZt30IRG8gaGJdrS02P5F
         Zr3D9PIN81M9JZ9DTQVY4lgxQoISDhQMdfg5Y38pAnRolL81xRAxJt+rKIupxxgnU5wo
         G93g==
X-Gm-Message-State: AOAM533Diernmi+R7qj8QL2S2tMbxYYSO3j5+HZ5LHr2yHNgXrBPxrQ6
        tAWNEr5Xr4TsbggPsBUTlwC77w==
X-Google-Smtp-Source: ABdhPJy1dx9CAbEewuwblQXsakhtnMJqea774EloTB5iaaa2mRAoGLCbBSR3NnhDVFg+Jn8I6uin6g==
X-Received: by 2002:a17:90a:fe09:: with SMTP id ck9mr12857176pjb.67.1613331687102;
        Sun, 14 Feb 2021 11:41:27 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id 125sm15129247pfu.7.2021.02.14.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:41:26 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/7] drm: sun4i: dsi: Add bridge support
Date:   Mon, 15 Feb 2021 01:10:57 +0530
Message-Id: <20210214194102.126146-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214194102.126146-1-jagan@amarulasolutions.com>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some display panels would come up with a non-DSI output which
can have an option to connect DSI interface by means of bridge
converter.

This DSI to non-DSI bridge converter would require a bridge
driver that would communicate the DSI controller for bridge
functionalities.

So, add support for bridge functionalities in Allwinner DSI
controller.

Cc: Samuel Holland <samuel@sholland.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: 
Samuel Holland, The existing kms hotplug dropped in order to 
attach the bridge properly. 

However, I did try several ways to support hotplug with the 
bridge but it's resulting in a deadlock where bind never attach 
bridge until bridge pointer found and bridge pointer cannot 
found until bind finishes. Any inputs on this would be appreciated.

Changes for v3:
- updated with new API's 

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 34 +++++++++++++++++---------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 +-
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 2e9e7b2d4145..39321299dc27 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -773,6 +773,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	if (dsi->panel)
 		drm_panel_prepare(dsi->panel);
 
+	if (dsi->panel_bridge)
+		dsi->panel_bridge->funcs->pre_enable(dsi->panel_bridge);
+
 	/*
 	 * FIXME: This should be moved after the switch to HS mode.
 	 *
@@ -788,6 +791,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	if (dsi->panel)
 		drm_panel_enable(dsi->panel);
 
+	if (dsi->panel_bridge)
+		dsi->panel_bridge->funcs->enable(dsi->panel_bridge);
+
 	sun6i_dsi_start(dsi, DSI_START_HSC);
 
 	udelay(1000);
@@ -804,6 +810,9 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
 	if (dsi->panel) {
 		drm_panel_disable(dsi->panel);
 		drm_panel_unprepare(dsi->panel);
+	} else if (dsi->panel_bridge) {
+		dsi->panel_bridge->funcs->disable(dsi->panel_bridge);
+		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
 	}
 
 	phy_power_off(dsi->dphy);
@@ -964,23 +973,17 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
 			    struct mipi_dsi_device *device)
 {
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
-	struct drm_panel *panel;
 	int ret;
 
 	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 0, 0,
-					  &panel, NULL);
+					  &dsi->panel, &dsi->panel_bridge);
 	if (ret)
 		return ret;
 
-	if (!dsi->drm || !dsi->drm->registered)
-		return -EPROBE_DEFER;
-
-	dsi->panel = panel;
 	dsi->device = device;
 
-	drm_kms_helper_hotplug_event(dsi->drm);
-
-	dev_info(host->dev, "Attached device %s\n", device->name);
+	dev_info(host->dev, "Attached %s %s\n",
+		 device->name, dsi->panel ? "panel" : "bridge");
 
 	return 0;
 }
@@ -991,9 +994,10 @@ static int sun6i_dsi_detach(struct mipi_dsi_host *host,
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
 
 	dsi->panel = NULL;
+	dsi->panel_bridge = NULL;
 	dsi->device = NULL;
 
-	drm_kms_helper_hotplug_event(dsi->drm);
+	drm_of_panel_bridge_remove(dsi->dev->of_node, 0, 0);
 
 	return 0;
 }
@@ -1082,7 +1086,13 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
 
-	dsi->drm = drm;
+	if (dsi->panel_bridge) {
+		ret = drm_bridge_attach(&dsi->encoder, dsi->panel_bridge, NULL, 0);
+		if (ret) {
+			dev_err(dsi->dev, "Couldn't attach drm bridge\n");
+			goto err_cleanup_connector;
+		}
+	}
 
 	return 0;
 
@@ -1096,7 +1106,7 @@ static void sun6i_dsi_unbind(struct device *dev, struct device *master,
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-	dsi->drm = NULL;
+	drm_encoder_cleanup(&dsi->encoder);
 }
 
 static const struct component_ops sun6i_dsi_ops = {
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index c863900ae3b4..370ecb356a63 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -29,8 +29,8 @@ struct sun6i_dsi {
 
 	struct device		*dev;
 	struct mipi_dsi_device	*device;
-	struct drm_device	*drm;
 	struct drm_panel	*panel;
+	struct drm_bridge	*panel_bridge;
 };
 
 static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
-- 
2.25.1

