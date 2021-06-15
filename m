Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E343A8268
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFOOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:18:14 -0400
Received: from srv6.fidu.org ([159.69.62.71]:48256 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhFOOQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:16:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id E4C6FC800B4;
        Tue, 15 Jun 2021 16:14:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 5HnsCoV1Nqmm; Tue, 15 Jun 2021 16:14:37 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F3949009F7CF2Abd5Da2787.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:9f7c:f2ab:d5da:2787])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 7808CC80095;
        Tue, 15 Jun 2021 16:14:37 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v3 08/14] drm/i915/display: Add handling for new "active color format" property
Date:   Tue, 15 Jun 2021 16:14:19 +0200
Message-Id: <20210615141426.6001-9-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141426.6001-1-wse@tuxedocomputers.com>
References: <20210615141426.6001-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the "active color format" drm property for the Intel GPU
driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 21 +++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_dp.c      |  2 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c  |  5 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c    |  1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index ee3669bd4662..2cf09599ddc3 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -10609,6 +10609,21 @@ static void intel_atomic_prepare_plane_clear_colors(struct intel_atomic_state *s
 	}
 }
 
+static int convert_intel_output_format_into_drm_color_format(enum intel_output_format output_format)
+{
+	switch (output_format) {
+		case INTEL_OUTPUT_FORMAT_RGB:
+			return DRM_COLOR_FORMAT_RGB444;
+		case INTEL_OUTPUT_FORMAT_YCBCR420:
+			return DRM_COLOR_FORMAT_YCRCB420;
+		case INTEL_OUTPUT_FORMAT_YCBCR444:
+			return DRM_COLOR_FORMAT_YCRCB444;
+		default:
+			break;
+		}
+	return 0;
+}
+
 static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 {
 	struct drm_device *dev = state->base.dev;
@@ -10916,9 +10931,13 @@ static int intel_atomic_commit(struct drm_device *dev,
 		if (crtc) {
 			struct intel_crtc_state *new_crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 			drm_connector_set_active_bpc_property(connector, new_crtc_state->pipe_bpp / 3);
+			drm_connector_set_active_color_format_property(connector,
+				convert_intel_output_format_into_drm_color_format(new_crtc_state->output_format));
 		}
-		else
+		else {
 			drm_connector_set_active_bpc_property(connector, 0);
+			drm_connector_set_active_color_format_property(connector, 0);
+		}
 	}
 
 	drm_atomic_state_get(&state->base);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 404a27e56ceb..01fdb9141592 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4691,10 +4691,12 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
 		drm_connector_attach_active_bpc_property(connector, 6, 10);
+		drm_connector_attach_active_color_format_property(connector);
 	}
 	else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
 		drm_connector_attach_active_bpc_property(connector, 6, 12);
+		drm_connector_attach_active_color_format_property(connector);
 	}
 
 	/* Register HDMI colorspace for case of lspcon */
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 16bfc59570a5..3e4237df3360 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -856,6 +856,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 	if (connector->active_bpc_property)
 		drm_connector_attach_active_bpc_property(connector, 6, 12);
 
+	connector->active_color_format_property =
+		intel_dp->attached_connector->base.active_color_format_property;
+	if (connector->active_color_format_property)
+		drm_connector_attach_active_color_format_property(connector);
+
 	return connector;
 
 err:
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 9160e21ac9d6..367aba57b55f 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2516,6 +2516,7 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
 		drm_connector_attach_active_bpc_property(connector, 8, 12);
+		drm_connector_attach_active_color_format_property(connector);
 	}
 }
 
-- 
2.25.1

