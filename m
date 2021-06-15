Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE03A8265
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhFOOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:18:02 -0400
Received: from srv6.fidu.org ([159.69.62.71]:48258 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhFOOQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:16:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 3726EC800B1;
        Tue, 15 Jun 2021 16:14:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id X4xK1ReBfyd7; Tue, 15 Jun 2021 16:14:37 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F3949009F7CF2Abd5Da2787.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:9f7c:f2ab:d5da:2787])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id C8355C800A1;
        Tue, 15 Jun 2021 16:14:36 +0200 (CEST)
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
Subject: [PATCH v3 05/14] drm/i915/display: Add handling for new "active bpc" property
Date:   Tue, 15 Jun 2021 16:14:16 +0200
Message-Id: <20210615141426.6001-6-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141426.6001-1-wse@tuxedocomputers.com>
References: <20210615141426.6001-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the "active bpc" drm property for the Intel GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 14 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c      |  8 ++++++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c  |  5 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c    |  4 +++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 6be1b31af07b..ee3669bd4662 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -10839,6 +10839,9 @@ static int intel_atomic_commit(struct drm_device *dev,
 {
 	struct intel_atomic_state *state = to_intel_atomic_state(_state);
 	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct drm_connector *connector;
+	struct drm_connector_state *new_conn_state;
+	int i;
 	int ret = 0;
 
 	state->wakeref = intel_runtime_pm_get(&dev_priv->runtime_pm);
@@ -10907,6 +10910,17 @@ static int intel_atomic_commit(struct drm_device *dev,
 	intel_shared_dpll_swap_state(state);
 	intel_atomic_track_fbs(state);
 
+	/* Extract information from crtc to communicate it to userspace as connector properties */
+	for_each_new_connector_in_state(&state->base, connector, new_conn_state, i) {
+		struct intel_crtc *crtc = to_intel_crtc(new_conn_state->crtc);
+		if (crtc) {
+			struct intel_crtc_state *new_crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
+			drm_connector_set_active_bpc_property(connector, new_crtc_state->pipe_bpp / 3);
+		}
+		else
+			drm_connector_set_active_bpc_property(connector, 0);
+	}
+
 	drm_atomic_state_get(&state->base);
 	INIT_WORK(&state->base.commit_work, intel_atomic_commit_work);
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 5c9222283044..404a27e56ceb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4688,10 +4688,14 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 		intel_attach_force_audio_property(connector);
 
 	intel_attach_broadcast_rgb_property(connector);
-	if (HAS_GMCH(dev_priv))
+	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
-	else if (DISPLAY_VER(dev_priv) >= 5)
+		drm_connector_attach_active_bpc_property(connector, 6, 10);
+	}
+	else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
+		drm_connector_attach_active_bpc_property(connector, 6, 12);
+	}
 
 	/* Register HDMI colorspace for case of lspcon */
 	if (intel_bios_is_lspcon_present(dev_priv, port)) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index b170e272bdee..16bfc59570a5 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -851,6 +851,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 	if (connector->max_bpc_property)
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
 
+	connector->active_bpc_property =
+		intel_dp->attached_connector->base.active_bpc_property;
+	if (connector->active_bpc_property)
+		drm_connector_attach_active_bpc_property(connector, 6, 12);
+
 	return connector;
 
 err:
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 7e51c98c475e..9160e21ac9d6 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2513,8 +2513,10 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 	if (DISPLAY_VER(dev_priv) >= 10)
 		drm_connector_attach_hdr_output_metadata_property(connector);
 
-	if (!HAS_GMCH(dev_priv))
+	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
+		drm_connector_attach_active_bpc_property(connector, 8, 12);
+	}
 }
 
 /*
-- 
2.25.1

