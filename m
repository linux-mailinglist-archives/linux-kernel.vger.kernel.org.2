Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E673C3664C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhDUFVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:21:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41019 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhDUFVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:21:37 -0400
Received: from 36-229-230-199.dynamic-ip.hinet.net ([36.229.230.199] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lZ5II-0007QW-03; Wed, 21 Apr 2021 05:20:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ville.syrjala@linux.intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915/dp: Use slow and wide link training for everything
Date:   Wed, 21 Apr 2021 13:20:31 +0800
Message-Id: <20210421052054.1434718-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Screen flickers on Innolux eDP 1.3 panel when clock rate 540000 is in use.

According to the panel vendor, though clock rate 540000 is advertised,
but the max clock rate it really supports is 270000.

Ville Syrjälä mentioned that fast and narrow also breaks some eDP 1.4
panel, so use slow and wide training for all panels to resolve the
issue.

User also confirmed that the new strategy doesn't introduce any
regression on XPS 9380.

v2:
 - Use slow and wide for everything.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3384
References: https://gitlab.freedesktop.org/drm/intel/-/issues/272
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 59 +++----------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 52ea09fc5e70..4ad12dde5938 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1095,44 +1095,6 @@ intel_dp_compute_link_config_wide(struct intel_dp *intel_dp,
 	return -EINVAL;
 }
 
-/* Optimize link config in order: max bpp, min lanes, min clock */
-static int
-intel_dp_compute_link_config_fast(struct intel_dp *intel_dp,
-				  struct intel_crtc_state *pipe_config,
-				  const struct link_config_limits *limits)
-{
-	const struct drm_display_mode *adjusted_mode = &pipe_config->hw.adjusted_mode;
-	int bpp, clock, lane_count;
-	int mode_rate, link_clock, link_avail;
-
-	for (bpp = limits->max_bpp; bpp >= limits->min_bpp; bpp -= 2 * 3) {
-		int output_bpp = intel_dp_output_bpp(pipe_config->output_format, bpp);
-
-		mode_rate = intel_dp_link_required(adjusted_mode->crtc_clock,
-						   output_bpp);
-
-		for (lane_count = limits->min_lane_count;
-		     lane_count <= limits->max_lane_count;
-		     lane_count <<= 1) {
-			for (clock = limits->min_clock; clock <= limits->max_clock; clock++) {
-				link_clock = intel_dp->common_rates[clock];
-				link_avail = intel_dp_max_data_rate(link_clock,
-								    lane_count);
-
-				if (mode_rate <= link_avail) {
-					pipe_config->lane_count = lane_count;
-					pipe_config->pipe_bpp = bpp;
-					pipe_config->port_clock = link_clock;
-
-					return 0;
-				}
-			}
-		}
-	}
-
-	return -EINVAL;
-}
-
 static int intel_dp_dsc_compute_bpp(struct intel_dp *intel_dp, u8 dsc_max_bpc)
 {
 	int i, num_bpc;
@@ -1382,22 +1344,11 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
 	    intel_dp_can_bigjoiner(intel_dp))
 		pipe_config->bigjoiner = true;
 
-	if (intel_dp_is_edp(intel_dp))
-		/*
-		 * Optimize for fast and narrow. eDP 1.3 section 3.3 and eDP 1.4
-		 * section A.1: "It is recommended that the minimum number of
-		 * lanes be used, using the minimum link rate allowed for that
-		 * lane configuration."
-		 *
-		 * Note that we fall back to the max clock and lane count for eDP
-		 * panels that fail with the fast optimal settings (see
-		 * intel_dp->use_max_params), in which case the fast vs. wide
-		 * choice doesn't matter.
-		 */
-		ret = intel_dp_compute_link_config_fast(intel_dp, pipe_config, &limits);
-	else
-		/* Optimize for slow and wide. */
-		ret = intel_dp_compute_link_config_wide(intel_dp, pipe_config, &limits);
+	/*
+	 * Optimize for slow and wide for everything, because there are some
+	 * eDP 1.3 and 1.4 panels don't work well with fast and narrow.
+	 */
+	ret = intel_dp_compute_link_config_wide(intel_dp, pipe_config, &limits);
 
 	/* enable compression if the mode doesn't fit available BW */
 	drm_dbg_kms(&i915->drm, "Force DSC en = %d\n", intel_dp->force_dsc_en);
-- 
2.30.2

