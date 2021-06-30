Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31A23B85D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhF3PNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:13:02 -0400
Received: from srv6.fidu.org ([159.69.62.71]:45306 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235542AbhF3PMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:12:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 31EE0C8007C;
        Wed, 30 Jun 2021 17:10:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id HJAJKjwcvRQL; Wed, 30 Jun 2021 17:10:25 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F394900095779a208783f8e.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:957:79a2:878:3f8e])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id C9198C80085;
        Wed, 30 Jun 2021 17:10:24 +0200 (CEST)
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
Subject: [PATCH v5 04/17] drm/amd/display: Add handling for new "active bpc" property
Date:   Wed, 30 Jun 2021 17:10:05 +0200
Message-Id: <20210630151018.330354-5-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630151018.330354-1-wse@tuxedocomputers.com>
References: <20210630151018.330354-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the "active bpc" drm property for the AMD GPU
driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f4abb5f215d1..d984de82ae63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7708,8 +7708,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.underscan_vborder_property,
 				0);
 
-	if (!aconnector->mst_port)
+	if (!aconnector->mst_port) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
+	}
 
 	/* This defaults to the max in the range, but we want 8bpc for non-edp. */
 	aconnector->base.state->max_bpc = (connector_type == DRM_MODE_CONNECTOR_eDP) ? 16 : 8;
@@ -9078,6 +9080,26 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
+	/* Extract information from crtc to communicate it to userspace as connector properties */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		struct drm_crtc *crtc = new_con_state->crtc;
+		struct dc_stream_state *stream;
+
+		if (crtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+			stream = dm_new_crtc_state->stream;
+
+			if (stream)
+				drm_connector_set_active_bpc_property(connector,
+					stream->timing.flags.DSC ?
+						stream->timing.dsc_cfg.bits_per_pixel / 16 / 3 :
+						convert_dc_color_depth_into_bpc(
+							stream->timing.display_color_depth));
+		} else
+			drm_connector_set_active_bpc_property(connector, 0);
+	}
+
 	/* Count number of newly disabled CRTCs for dropping PM refs later. */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5568d4e518e6..0cf38743ec47 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -409,6 +409,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->max_bpc_property)
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
+	connector->active_bpc_property = master->base.active_bpc_property;
+	if (connector->active_bpc_property)
+		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
+
 	connector->vrr_capable_property = master->base.vrr_capable_property;
 	if (connector->vrr_capable_property)
 		drm_connector_attach_vrr_capable_property(connector);
-- 
2.25.1

