Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0120E369A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhDWSqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243843AbhDWSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aORR5BDLVuChgsGPTpiSbr2OxX85lHm3aaLawSJYbVM=;
        b=BM0ykOcwMaQoXsi2Y7Hv2OPEbsptqSywuPC2Nmy988I71CzMLjl2wSC60f+/tqmB0fsFQ9
        I3rGn+eDTakGGe3TwMUPezKd50gPvQO0zZnXvqEop05Eh7i/fBya+Jc2uphpQDXEAAD0xb
        e7RBlTPr5yJuJMEB/xYD0A/52JYYlwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-hNSzkSUCP0ykhaW1YxeijA-1; Fri, 23 Apr 2021 14:45:55 -0400
X-MC-Unique: hNSzkSUCP0ykhaW1YxeijA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CF210B728A;
        Fri, 23 Apr 2021 18:45:07 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACA706090F;
        Fri, 23 Apr 2021 18:45:04 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 13/17] drm/dp_mst: Pass drm_dp_mst_topology_mgr to drm_dp_get_vc_payload_bw()
Date:   Fri, 23 Apr 2021 14:43:05 -0400
Message-Id: <20210423184309.207645-14-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
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
index 276f7f054d62..9bac5bd050ab 100644
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
index 180f97cd74cb..eb04b3cefda2 100644
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

