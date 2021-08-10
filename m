Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582363D6A14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhGZWfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZWfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:35:13 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06424C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:15:42 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so10272705otu.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMU3dlNhHc2GMbUZbls+/71C5/GmwZOSbo7SVTlRAII=;
        b=SrG2N5ee7wquGKS/862qxUTzO2dKuqeTGjZPhO2vDmpyz9CVonrM3b0AeITcFeUF0R
         nxV4P7inceNPdw9ot1cdNIevGjAdU2t4ErvoBTzBb0ZioMgm8OteeqEbwHGte3Wyv07L
         tegS1YfM34a1398S69XYI5WSLkI1OKTVMA+2T9XlpqwvOqW/9to9tmh8VtLVCAvqf6g5
         qc8mU1gFCDARhCm/A2dHENlXeZBB2iSYhBu/3JUb79EJLjmoK5c3+ZsSErTXnpkYAYDW
         pdwnmOdg65hpHzev1PagDul17VbBEunNoJfq5El08Q39O5LyBgTDXiGXaCFbNySB7MM4
         o+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMU3dlNhHc2GMbUZbls+/71C5/GmwZOSbo7SVTlRAII=;
        b=P7g6mJmNHc48RyLK3vRyx31oHDkGR04LzJsmbBy3BTgsF8XYPYsRyOi4q6Zv/mWGLj
         5EUsr2Wt/nScXF1pnr19kE0HMApxuRNOi0rUM9OS8MmrxTh5NVr+OlPHVmR5DBnFVMdK
         wkav7LLbKdTsS+yL7uVYr2QXfMZ+IPgHKLiQDpiiBCv/wyANtyo62Ira2oyZppRiWbJ0
         VPEaYiCddYDqtOjGPqAJylgo+uyEosDWhFHXeTW1ap2JzVDzb6zg3IfeBScW3Uyjp0GW
         XxgtMFuLceRtuARSbCcxPBT0ewof2LVClvwqlLKifRPxejhY1dz3es1vRd7fDpikRtXu
         lX1Q==
X-Gm-Message-State: AOAM531ZVwf06887pOu7+YUL5BBLHEBCiRastcyz7HUilPS42JW7q4XF
        liLtwGc3zQiSurn/C6SBAccGxA==
X-Google-Smtp-Source: ABdhPJws9wE+8uZqQrov+1Rz2BhcJsfTiMLaHYXyp24fHfRn/SZMw1Hbn5X3FBjtd0yMFhvFlV6+qQ==
X-Received: by 2002:a9d:1911:: with SMTP id j17mr13055960ota.70.1627341341218;
        Mon, 26 Jul 2021 16:15:41 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n7sm260844otf.45.2021.07.26.16.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:15:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC] drm/msm/dp: Allow attaching a drm_panel
Date:   Mon, 26 Jul 2021 16:13:51 -0700
Message-Id: <20210726231351.655302-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDP panels might need some power sequencing and backlight management,
so make it possible to associate a drm_panel with a DP instance and
prepare and enable the panel accordingly.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This solves my immediate problem on my 8cx laptops, of indirectly controlling
the backlight during DPMS. But my panel is powered when I boot it and as such I
get the hpd interrupt and I don't actually have to deal with a power on
sequence - so I'm posting this as an RFC, hoping to get some input on these
other aspects.

If this is acceptable I'd be happy to write up an accompanying DT binding
change that marks port 2 of the DP controller's of_graph as a reference to the
attached panel.

 drivers/gpu/drm/msm/dp/dp_display.c | 15 +++++++++++++--
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_parser.h  |  1 +
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 206bf7806f51..1db5a3f752d2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
+#include <drm/drm_panel.h>
 
 #include "msm_drv.h"
 #include "msm_kms.h"
@@ -252,6 +253,8 @@ static int dp_display_bind(struct device *dev, struct device *master,
 		goto end;
 	}
 
+	dp->dp_display.drm_panel = dp->parser->drm_panel;
+
 	rc = dp_aux_register(dp->aux, drm);
 	if (rc) {
 		DRM_ERROR("DRM DP AUX register failed\n");
@@ -867,8 +870,10 @@ static int dp_display_set_mode(struct msm_dp *dp_display,
 	return 0;
 }
 
-static int dp_display_prepare(struct msm_dp *dp)
+static int dp_display_prepare(struct msm_dp *dp_display)
 {
+	drm_panel_prepare(dp_display->drm_panel);
+
 	return 0;
 }
 
@@ -886,6 +891,8 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)
 	if (!rc)
 		dp_display->power_on = true;
 
+	drm_panel_enable(dp_display->drm_panel);
+
 	return rc;
 }
 
@@ -915,6 +922,8 @@ static int dp_display_disable(struct dp_display_private *dp, u32 data)
 	if (!dp_display->power_on)
 		return 0;
 
+	drm_panel_disable(dp_display->drm_panel);
+
 	/* wait only if audio was enabled */
 	if (dp_display->audio_enabled) {
 		/* signal the disconnect event */
@@ -939,8 +948,10 @@ static int dp_display_disable(struct dp_display_private *dp, u32 data)
 	return 0;
 }
 
-static int dp_display_unprepare(struct msm_dp *dp)
+static int dp_display_unprepare(struct msm_dp *dp_display)
 {
+	drm_panel_unprepare(dp_display->drm_panel);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 8b47cdabb67e..ce337824c95d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -15,6 +15,7 @@ struct msm_dp {
 	struct device *codec_dev;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
+	struct drm_panel *drm_panel;
 	bool is_connected;
 	bool audio_enabled;
 	bool power_on;
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index fc8a6452f641..e6a6e9007bfd 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -6,6 +6,7 @@
 #include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
 
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 
 #include "dp_parser.h"
@@ -276,6 +277,20 @@ static int dp_parser_clock(struct dp_parser *parser)
 	return 0;
 }
 
+static int dp_parser_find_panel(struct dp_parser *parser)
+{
+	struct device_node *np = parser->pdev->dev.of_node;
+	int rc;
+
+	rc = drm_of_find_panel_or_bridge(np, 2, 0, &parser->drm_panel, NULL);
+	if (rc == -ENODEV)
+		rc = 0;
+	else if (rc)
+		DRM_ERROR("failed to acquire DRM panel: %d\n", rc);
+
+	return rc;
+}
+
 static int dp_parser_parse(struct dp_parser *parser)
 {
 	int rc = 0;
@@ -297,6 +312,10 @@ static int dp_parser_parse(struct dp_parser *parser)
 	if (rc)
 		return rc;
 
+	rc = dp_parser_find_panel(parser);
+	if (rc)
+		return rc;
+
 	/* Map the corresponding regulator information according to
 	 * version. Currently, since we only have one supported platform,
 	 * mapping the regulator directly.
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index 3266b529c090..994ca9336acd 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -122,6 +122,7 @@ struct dp_parser {
 	struct dp_display_data disp_data;
 	const struct dp_regulator_cfg *regulator_cfg;
 	u32 max_dp_lanes;
+	struct drm_panel *drm_panel;
 
 	int (*parse)(struct dp_parser *parser);
 };
-- 
2.29.2

