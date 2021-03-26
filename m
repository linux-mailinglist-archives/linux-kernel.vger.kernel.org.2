Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C004F34B0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhCZUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhCZUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616791208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEFLlKqDDfptG4qDlaE26fbVsZb8N3oVigdwhGPdZaQ=;
        b=bbOCSvZR0G+SzowJsX0iLbQkQ0YYHPggUfwVBKohaTpr8FIM/gvNROx3ZJip39NR5XTvXJ
        hGxW5TdfNQy0Hh7QnFIlCmjYtTLavC5hm37Vu9EaKFbtP6IlcGXcbwmSJoieZ9a7ilVNRs
        06dGyLlSl23G39MH0zRiqjHVQomq2Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-w3yM6KwSOxCBcCjzySCyMA-1; Fri, 26 Mar 2021 16:40:04 -0400
X-MC-Unique: w3yM6KwSOxCBcCjzySCyMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 055D38143F0;
        Fri, 26 Mar 2021 20:40:01 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-114-133.rdu2.redhat.com [10.10.114.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4EF95DEAD;
        Fri, 26 Mar 2021 20:39:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/20] drm/dp_mst: Pass drm_dp_mst_topology_mgr to drm_dp_get_vc_payload_bw()
Date:   Fri, 26 Mar 2021 16:38:03 -0400
Message-Id: <20210326203807.105754-17-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-1-lyude@redhat.com>
References: <20210326203807.105754-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is one of the few functions in drm_dp_mst_topology.c that
doesn't have any way of getting access to a drm_device, let's pass the
drm_dp_mst_topology_mgr down to this function so that it can use
drm_dbg_kms().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c       | 7 +++++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 include/drm/drm_dp_mst_helper.h             | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 1a7a8b085de4..ec2285595c33 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3638,6 +3638,7 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
 
 /**
  * drm_dp_get_vc_payload_bw - get the VC payload BW for an MST link
+ * @mgr: The &drm_dp_mst_topology_mgr to use
  * @link_rate: link rate in 10kbits/s units
  * @link_lane_count: lane count
  *
@@ -3646,7 +3647,8 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
  * convert the number of PBNs required for a given stream to the number of
  * timeslots this stream requires in each MTP.
  */
-int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count)
+int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
+			     int link_rate, int link_lane_count)
 {
 	if (link_rate == 0 || link_lane_count == 0)
 		DRM_DEBUG_KMS("invalid link rate/lane count: (%d / %d)\n",
@@ -3711,7 +3713,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 			goto out_unlock;
 		}
 
-		mgr->pbn_div = drm_dp_get_vc_payload_bw(drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
+		mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr,
+							drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
 							mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
 		if (mgr->pbn_div == 0) {
 			ret = -EINVAL;
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 2daa3f67791e..860381d68d9d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -70,7 +70,8 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
 		slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
 						      connector->port,
 						      crtc_state->pbn,
-						      drm_dp_get_vc_payload_bw(crtc_state->port_clock,
+						      drm_dp_get_vc_payload_bw(&intel_dp->mst_mgr,
+									       crtc_state->port_clock,
 									       crtc_state->lane_count));
 		if (slots == -EDEADLK)
 			return slots;
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index bd1c39907b92..20dc705642bd 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -783,7 +783,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 
 struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
 
-int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count);
+int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
+			     int link_rate, int link_lane_count);
 
 int drm_dp_calc_pbn_mode(int clock, int bpp, bool dsc);
 
-- 
2.30.2

