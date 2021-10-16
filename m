Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB8430553
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbhJPWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbhJPWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 18:19:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A74C06176A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 15:16:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so305696ote.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8CkjnvD4XYRJbxbrS217o1yjl7s34UqdCCgpWSb1Mk=;
        b=AwNEKj9pbK/6em9liphva8EPTdEhaVRayPPdnsAA6F/l6pw8BaPCPLNq8bUoVeXjWQ
         Nw4FQj+jSQhS8ILFhIvZYoUDCQj9EY6nzxLW7Mq4V+hc0nfU1IN/PYnrDOu7WFNdwYV8
         ESvgmjqGlyDtGmcPr7J9dMq54Dvwm27Sq16AegCuDSxdx8OJodxBGOWibYukb6zB9/Cj
         d7mjEGc5HKbgIMT659oc/daYTQxQO4n+wfZVgcf7BdRnMFvgcRnG3bCfMmS76TjXm7Ij
         Hi+ExykxQHHt/WvU9PA/FzGDhMyNAMesFXpYekBR7qDQOjI15PMzaA352oFoVgr0VB5g
         E18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8CkjnvD4XYRJbxbrS217o1yjl7s34UqdCCgpWSb1Mk=;
        b=De0A9IJCu/q76irvbhoEbwdB48eh0A4dXD/OHD6arQivRXvTeNIpH9k/VuF6vp8B/n
         TZePpGDE5pyHPQz607Kqdo3G/FCiDAHtRnA2cXyt9xRtP7xuEDedxJ54tGe/4mCcWWwE
         41XDDHe3z1WbcAkrwjJi5rAYC+P0lLGQIz3FzWqZ+o3Z8DRaI3r2eTOTmBrMplrjOSVl
         wUfUdV3eBzNLBqb+urlY/C/Rd/03pHx+1RYgUp9PjkXZ0HnCIrW2wnVn9r/qFvZtiPhL
         0axs1knIp+BiX+SrKb9F/nlRYLfiC4pGLVyLGtCab5Vtipj1rLVhR4N4OU4S6bcNXHcz
         zfMw==
X-Gm-Message-State: AOAM5302iIU+A1Cb8i3w1gkiwnQLLdqLf8z6eHnSO50TsSzmTCLA2kPd
        hONnKAOz1mACQc+Uxb6INwlqGg==
X-Google-Smtp-Source: ABdhPJxgl7avB2mLcg2PB6GA+phwgmJNxUz+VaE+2gzimNVpdXjoF6ly/4xdO8ldK04YhM8pLLehQA==
X-Received: by 2002:a9d:718e:: with SMTP id o14mr15089096otj.299.1634422618854;
        Sat, 16 Oct 2021 15:16:58 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d15sm1747058oic.32.2021.10.16.15.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 15:16:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] drm/msm/dp: Allow attaching a drm_panel
Date:   Sat, 16 Oct 2021 15:18:40 -0700
Message-Id: <20211016221843.2167329-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211016221843.2167329-1-bjorn.andersson@linaro.org>
References: <20211016221843.2167329-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDP panels might need some power sequencing and backlight management,
so make it possible to associate a drm_panel with an eDP instance and
prepare and enable the panel accordingly.

Now that we know which hardware instance is DP and which is eDP,
parser->parse() is passed the connector_type and the parser is limited
to only search for a panel in the eDP case.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- None

 drivers/gpu/drm/msm/dp/dp_display.c |  9 ++++++---
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     | 11 +++++++++++
 drivers/gpu/drm/msm/dp/dp_parser.c  | 30 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_parser.h  |  3 ++-
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6913970c8cf9..c663cd619925 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
+#include <drm/drm_panel.h>
 
 #include "msm_drv.h"
 #include "msm_kms.h"
@@ -230,12 +231,14 @@ static int dp_display_bind(struct device *dev, struct device *master,
 	priv = drm->dev_private;
 	priv->dp = &(dp->dp_display);
 
-	rc = dp->parser->parse(dp->parser);
+	rc = dp->parser->parse(dp->parser, dp->dp_display.connector_type);
 	if (rc) {
 		DRM_ERROR("device tree parsing failed\n");
 		goto end;
 	}
 
+	dp->dp_display.panel_bridge = dp->parser->panel_bridge;
+
 	dp->aux->drm_dev = drm;
 	rc = dp_aux_register(dp->aux);
 	if (rc) {
@@ -822,7 +825,7 @@ static int dp_display_set_mode(struct msm_dp *dp_display,
 	return 0;
 }
 
-static int dp_display_prepare(struct msm_dp *dp)
+static int dp_display_prepare(struct msm_dp *dp_display)
 {
 	return 0;
 }
@@ -896,7 +899,7 @@ static int dp_display_disable(struct dp_display_private *dp, u32 data)
 	return 0;
 }
 
-static int dp_display_unprepare(struct msm_dp *dp)
+static int dp_display_unprepare(struct msm_dp *dp_display)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 75fcabcfbbdd..8e80e3bac394 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -15,6 +15,7 @@ struct msm_dp {
 	struct device *codec_dev;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
+	struct drm_bridge *panel_bridge;
 	bool is_connected;
 	bool audio_enabled;
 	bool power_on;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index f33e31523f56..76856c4ee1d6 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 
 #include "msm_drv.h"
@@ -160,5 +161,15 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
 
 	drm_connector_attach_encoder(connector, dp_display->encoder);
 
+	if (dp_display->panel_bridge) {
+		ret = drm_bridge_attach(dp_display->encoder,
+					dp_display->panel_bridge, NULL,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (ret < 0) {
+			DRM_ERROR("failed to attach panel bridge: %d\n", ret);
+			return ERR_PTR(ret);
+		}
+	}
+
 	return connector;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 4d6e047f803d..eb6bbfbea484 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -6,6 +6,7 @@
 #include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
 
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 
 #include "dp_parser.h"
@@ -263,7 +264,28 @@ static int dp_parser_clock(struct dp_parser *parser)
 	return 0;
 }
 
-static int dp_parser_parse(struct dp_parser *parser)
+static int dp_parser_find_panel(struct dp_parser *parser)
+{
+	struct device *dev = &parser->pdev->dev;
+	struct drm_panel *panel;
+	int rc;
+
+	rc = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
+	if (rc) {
+		DRM_ERROR("failed to acquire DRM panel: %d\n", rc);
+		return rc;
+	}
+
+	parser->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	if (IS_ERR(parser->panel_bridge)) {
+		DRM_ERROR("failed to create panel bridge\n");
+		return PTR_ERR(parser->panel_bridge);
+	}
+
+	return 0;
+}
+
+static int dp_parser_parse(struct dp_parser *parser, int connector_type)
 {
 	int rc = 0;
 
@@ -284,6 +306,12 @@ static int dp_parser_parse(struct dp_parser *parser)
 	if (rc)
 		return rc;
 
+	if (connector_type == DRM_MODE_CONNECTOR_eDP) {
+		rc = dp_parser_find_panel(parser);
+		if (rc)
+			return rc;
+	}
+
 	/* Map the corresponding regulator information according to
 	 * version. Currently, since we only have one supported platform,
 	 * mapping the regulator directly.
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index dac10923abde..3172da089421 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -123,8 +123,9 @@ struct dp_parser {
 	struct dp_display_data disp_data;
 	const struct dp_regulator_cfg *regulator_cfg;
 	u32 max_dp_lanes;
+	struct drm_bridge *panel_bridge;
 
-	int (*parse)(struct dp_parser *parser);
+	int (*parse)(struct dp_parser *parser, int connector_type);
 };
 
 /**
-- 
2.29.2

