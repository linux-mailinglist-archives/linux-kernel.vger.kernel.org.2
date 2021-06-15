Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E393A8263
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFOOR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:17:56 -0400
Received: from srv6.fidu.org ([159.69.62.71]:48054 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhFOOQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:16:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id EF3A3C800AF;
        Tue, 15 Jun 2021 16:14:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id DkCBs6n-haNd; Tue, 15 Jun 2021 16:14:36 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F3949009F7CF2Abd5Da2787.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:9f7c:f2ab:d5da:2787])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 90F91C80095;
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
Subject: [PATCH v3 04/14] drm/amd/display: Add handling for new "active bpc" property
Date:   Tue, 15 Jun 2021 16:14:15 +0200
Message-Id: <20210615141426.6001-5-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141426.6001-1-wse@tuxedocomputers.com>
References: <20210615141426.6001-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the "active bpc" drm property for the AMD GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd1df5cf4815..f31bbcb11f03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7713,8 +7713,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.underscan_vborder_property,
 				0);
 
-	if (!aconnector->mst_port)
+	if (!aconnector->mst_port) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
+	}
 
 	/* This defaults to the max in the range, but we want 8bpc for non-edp. */
 	aconnector->base.state->max_bpc = (connector_type == DRM_MODE_CONNECTOR_eDP) ? 16 : 8;
@@ -9083,6 +9085,21 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
+	/* Extract information from crtc to communicate it to userspace as connector properties */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		struct drm_crtc *crtc = new_con_state->crtc;
+		if (crtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+			if (dm_new_crtc_state->stream)
+				drm_connector_set_active_bpc_property(connector,
+					convert_dc_color_depth_into_bpc(
+					dm_new_crtc_state->stream->timing.display_color_depth));
+		}
+		else
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

