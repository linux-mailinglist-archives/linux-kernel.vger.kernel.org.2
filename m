Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9003B85E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhF3PNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:13:17 -0400
Received: from srv6.fidu.org ([159.69.62.71]:45416 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235792AbhF3PNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:13:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id E9049C80091;
        Wed, 30 Jun 2021 17:10:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 7AKlkCiZ2qq5; Wed, 30 Jun 2021 17:10:27 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F394900095779a208783f8e.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:957:79a2:878:3f8e])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id DD0D9C80099;
        Wed, 30 Jun 2021 17:10:26 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        emil.l.velikov@gmail.com
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v5 14/17] drm/i915/display: Add handling for new "preferred color format" property
Date:   Wed, 30 Jun 2021 17:10:15 +0200
Message-Id: <20210630151018.330354-15-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630151018.330354-1-wse@tuxedocomputers.com>
References: <20210630151018.330354-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the "preferred color format" drm property for the
Intel GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c     | 7 ++++++-
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 5 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c   | 6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index fd33f753244d..29bb181ec4be 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -616,9 +616,12 @@ intel_dp_output_format(struct drm_connector *connector,
 {
 	struct intel_dp *intel_dp = intel_attached_dp(to_intel_connector(connector));
 	const struct drm_display_info *info = &connector->display_info;
+	const struct drm_connector_state *connector_state = connector->state;
 
 	if (!connector->ycbcr_420_allowed ||
-	    !drm_mode_is_420_only(info, mode))
+	    !(drm_mode_is_420_only(info, mode) ||
+	    (drm_mode_is_420_also(info, mode) && connector_state &&
+	    connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCRCB420)))
 		return INTEL_OUTPUT_FORMAT_RGB;
 
 	if (intel_dp->dfp.rgb_to_ycbcr &&
@@ -4692,10 +4695,12 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
 		drm_connector_attach_active_bpc_property(connector, 6, 10);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 	} else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
 		drm_connector_attach_active_bpc_property(connector, 6, 12);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index cb876175258f..67f0fb649876 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -856,6 +856,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 	if (connector->active_bpc_property)
 		drm_connector_attach_active_bpc_property(connector, 6, 12);
 
+	connector->preferred_color_format_property =
+		intel_dp->attached_connector->base.preferred_color_format_property;
+	if (connector->preferred_color_format_property)
+		drm_connector_attach_preferred_color_format_property(connector);
+
 	connector->active_color_format_property =
 		intel_dp->attached_connector->base.active_color_format_property;
 	if (connector->active_color_format_property)
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 3ee25e0cc3b9..a7b85cd13227 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2153,6 +2153,11 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 		crtc_state->output_format = INTEL_OUTPUT_FORMAT_RGB;
 	}
 
+	if (connector->ycbcr_420_allowed &&
+	    conn_state->preferred_color_format == DRM_COLOR_FORMAT_YCRCB420 &&
+	    drm_mode_is_420_also(&connector->display_info, adjusted_mode))
+		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
+
 	ret = intel_hdmi_compute_clock(encoder, crtc_state);
 	if (ret) {
 		if (crtc_state->output_format != INTEL_OUTPUT_FORMAT_YCBCR420 &&
@@ -2517,6 +2522,7 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
 		drm_connector_attach_active_bpc_property(connector, 8, 12);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 	}
 }
-- 
2.25.1

