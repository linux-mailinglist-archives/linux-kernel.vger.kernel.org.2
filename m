Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26193371F89
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhECSXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:23:04 -0400
Received: from srv6.fidu.org ([159.69.62.71]:56472 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhECSW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:22:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 1C499C800CE;
        Mon,  3 May 2021 20:21:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id GFqK7KxpKa2j; Mon,  3 May 2021 20:21:53 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37f3986001A8B79e0b24CB29D.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:1a8b:79e0:b24c:b29d])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id C8629C800D3;
        Mon,  3 May 2021 20:21:53 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     wse@tuxedocomputers.com, ville.syrjala@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Restructure output format computation for better expandability
Date:   Mon,  3 May 2021 20:21:47 +0200
Message-Id: <20210503182148.851790-4-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503182148.851790-1-wse@tuxedocomputers.com>
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couples the decission between RGB and YCbCr420 mode and the check if the port
clock can archive the required frequency. Other checks and configuration steps
that where previously done in between can also be done before or after.

This allows for are cleaner implementation of retrying different color
encodings.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---

From 57e42ec6e34ac32da29eb7bc3c691cbeb2534396 Mon Sep 17 00:00:00 2001
From: Werner Sembach <wse@tuxedocomputers.com>
Date: Mon, 3 May 2021 15:30:40 +0200
Subject: [PATCH 3/4] Restructure output format computation for better
 expandability

---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 57 +++++++++++------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ce165ef28e88..e2553ac6fd13 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1999,29 +1999,6 @@ static bool hdmi_deep_color_possible(const struct intel_crtc_state *crtc_state,
 					      INTEL_OUTPUT_FORMAT_YCBCR420);
 }
 
-static int
-intel_hdmi_ycbcr420_config(struct intel_crtc_state *crtc_state,
-			   const struct drm_connector_state *conn_state)
-{
-	struct drm_connector *connector = conn_state->connector;
-	struct drm_i915_private *i915 = to_i915(connector->dev);
-	const struct drm_display_mode *adjusted_mode =
-		&crtc_state->hw.adjusted_mode;
-
-	if (!drm_mode_is_420_only(&connector->display_info, adjusted_mode))
-		return 0;
-
-	if (!connector->ycbcr_420_allowed) {
-		drm_err(&i915->drm,
-			"Platform doesn't support YCBCR420 output\n");
-		return -EINVAL;
-	}
-
-	crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
-
-	return intel_pch_panel_fitting(crtc_state, conn_state);
-}
-
 static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
 				  struct intel_crtc_state *crtc_state,
 				  int clock)
@@ -2128,6 +2105,24 @@ static bool intel_hdmi_has_audio(struct intel_encoder *encoder,
 		return intel_conn_state->force_audio == HDMI_AUDIO_ON;
 }
 
+int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
+				     struct intel_crtc_state *crtc_state,
+				     const struct drm_connector_state *conn_state)
+{
+	const struct drm_connector *connector = conn_state->connector;
+	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
+	int ret;
+
+	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, adjusted_mode))
+		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
+	else
+		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;
+
+	ret = intel_hdmi_compute_clock(encoder, crtc_state);
+
+	return ret;
+}
+
 int intel_hdmi_compute_config(struct intel_encoder *encoder,
 			      struct intel_crtc_state *pipe_config,
 			      struct drm_connector_state *conn_state)
@@ -2152,23 +2147,23 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLCLK)
 		pipe_config->pixel_multiplier = 2;
 
-	ret = intel_hdmi_ycbcr420_config(pipe_config, conn_state);
-	if (ret)
-		return ret;
-
-	pipe_config->limited_color_range =
-		intel_hdmi_limited_color_range(pipe_config, conn_state);
-
 	if (HAS_PCH_SPLIT(dev_priv) && !HAS_DDI(dev_priv))
 		pipe_config->has_pch_encoder = true;
 
 	pipe_config->has_audio =
 		intel_hdmi_has_audio(encoder, pipe_config, conn_state);
 
-	ret = intel_hdmi_compute_clock(encoder, pipe_config);
+	ret = intel_hdmi_compute_output_format(encoder, pipe_config, conn_state);
 	if (ret)
 		return ret;
 
+	ret = intel_pch_panel_fitting(pipe_config, conn_state);
+	if (ret)
+		return ret;
+
+	pipe_config->limited_color_range =
+		intel_hdmi_limited_color_range(pipe_config, conn_state);
+
 	if (conn_state->picture_aspect_ratio)
 		adjusted_mode->picture_aspect_ratio =
 			conn_state->picture_aspect_ratio;
-- 
2.25.1

