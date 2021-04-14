Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388B35ED3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhDNGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:30:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52907 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhDNGaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:30:55 -0400
Received: from 1-171-231-81.dynamic-ip.hinet.net ([1.171.231.81] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lWZ2f-0007lr-7U; Wed, 14 Apr 2021 06:30:26 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ville.syrjala@linux.intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915/dp: Use slow and wide link training for DPCP rev < 1.4
Date:   Wed, 14 Apr 2021 14:29:50 +0800
Message-Id: <20210414063011.996773-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Screen flickers on Innolux panel when clock rate 540000 is in use.

According to the panel vendor, though clock rate 540000 is advertised,
but the max clock rate it really supports is 270000.

So use slow and wide training for panels with DPCP rev < 1.4 to resolve
the issue. User also confirmed the new strategy doesn't introduce
regression on XPS 9380.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3384
References: https://gitlab.freedesktop.org/drm/intel/-/issues/272
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 775d89b6c3fc..ca73e2179659 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1461,12 +1461,12 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
 	    intel_dp_can_bigjoiner(intel_dp))
 		pipe_config->bigjoiner = true;
 
-	if (intel_dp_is_edp(intel_dp))
+	if (intel_dp_is_edp(intel_dp) && intel_dp->dpcd[DP_DPCD_REV] > 0x13)
 		/*
-		 * Optimize for fast and narrow. eDP 1.3 section 3.3 and eDP 1.4
-		 * section A.1: "It is recommended that the minimum number of
-		 * lanes be used, using the minimum link rate allowed for that
-		 * lane configuration."
+		 * Optimize for fast and narrow on DP 1.4. eDP 1.3 section 3.3
+		 * and eDP 1.4 section A.1: "It is recommended that the minimum
+		 * number of lanes be used, using the minimum link rate allowed
+		 * for that lane configuration."
 		 *
 		 * Note that we fall back to the max clock and lane count for eDP
 		 * panels that fail with the fast optimal settings (see
-- 
2.30.2

