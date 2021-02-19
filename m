Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368132011D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 23:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBSWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 17:02:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhBSV5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0oog+dTNpkeABRsp1t7RSocQRWoR5MLQumFpDthI3E=;
        b=ZkseM7aw2X2AznH59XJ+jw4CXeFHP8Ti9gNx+CT5hiIQ7258kfboScCcA/N3m0Y0faJJlX
        KAhjGo0jZfIcXvwF1pjwKkYyWG8cZwHF31Lf7N8uNmeTb125+HbQ3fR7/fFJleldVOPScM
        k3RAg3150tj8gPinA8sGkBij8LijrTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-VVgshI6EOmKNxAEkNGuo2Q-1; Fri, 19 Feb 2021 16:55:51 -0500
X-MC-Unique: VVgshI6EOmKNxAEkNGuo2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D61308710E6;
        Fri, 19 Feb 2021 21:55:48 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 773606EF55;
        Fri, 19 Feb 2021 21:55:46 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 27/30] drm/dp_mst: Pass drm_dp_mst_topology_mgr to drm_dp_get_vc_payload_bw()
Date:   Fri, 19 Feb 2021 16:53:23 -0500
Message-Id: <20210219215326.2227596-28-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index cf4f2f85711e..fb66df39e0bb 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3631,6 +3631,7 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
 
 /**
  * drm_dp_get_vc_payload_bw - get the VC payload BW for an MST link
+ * @mgr: The &drm_dp_mst_topology_mgr to use
  * @link_rate: link rate in 10kbits/s units
  * @link_lane_count: lane count
  *
@@ -3639,7 +3640,8 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
  * convert the number of PBNs required for a given stream to the number of
  * timeslots this stream requires in each MTP.
  */
-int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count)
+int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
+			     int link_rate, int link_lane_count)
 {
 	if (link_rate == 0 || link_lane_count == 0)
 		DRM_DEBUG_KMS("invalid link rate/lane count: (%d / %d)\n",
@@ -3704,7 +3706,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 			goto out_unlock;
 		}
 
-		mgr->pbn_div = drm_dp_get_vc_payload_bw(drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
+		mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr,
+							drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
 							mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
 		if (mgr->pbn_div == 0) {
 			ret = -EINVAL;
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 8e316146b6d1..60ca0fa32d15 100644
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
2.29.2

