Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F783AC71C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhFRJOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:14:33 -0400
Received: from srv6.fidu.org ([159.69.62.71]:56618 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbhFRJNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:13:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 83120C800B3;
        Fri, 18 Jun 2021 11:11:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Lk_qPjcuFfw2; Fri, 18 Jun 2021 11:11:44 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37f3949001760E5710682cA7E.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:1760:e571:682:ca7e])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 24AD9C800BA;
        Fri, 18 Jun 2021 11:11:44 +0200 (CEST)
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
Subject: [PATCH v4 14/17] drm/i915/display: Add handling for new "preferred color format" property
Date:   Fri, 18 Jun 2021 11:11:13 +0200
Message-Id: <20210618091116.14428-15-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618091116.14428-1-wse@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
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
index 214010f7cbec..4c01ab887904 100644
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
@@ -4691,11 +4694,13 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
 		drm_connector_attach_active_bpc_property(connector, 6, 10);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 		drm_connector_attach_active_color_range_property(connector);
 	} else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
 		drm_connector_attach_active_bpc_property(connector, 6, 12);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 		drm_connector_attach_active_color_range_property(connector);
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
index dacac23a6c30..bce253bc5b16 100644
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
@@ -2516,6 +2521,7 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
 		drm_connector_attach_active_bpc_property(connector, 8, 12);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 		drm_connector_attach_active_color_range_property(connector);
 	}
-- 
2.25.1

