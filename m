Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA03E0417
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbhHDPYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:24:33 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59554
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238324AbhHDPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:24:32 -0400
Received: from localhost (1.general.khfeng.us.vpn [10.172.68.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F412D3F0FA;
        Wed,  4 Aug 2021 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628090659;
        bh=hDbB0bm93+F0EguMHBiaxBXcE+njk5ShWnWQKqO10PI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vH/SIvcVPIFscAqYBu+yXAN1EUgQeBD+dcWc4tbmT3Id60CC3HYE7XacIrpjg8Nxn
         xtfYqnwq8gG6nBiX+obB9syTzKVVKjvAbRwzv+BHP3EIUGyMu1Ss2rAaK/avMHAuJd
         YXF7nAaFeMcirAVIhvA8fWaKXvmkXxXBeCPlPJhKbFCN3IdlG/kn6ESWl1Z7hrUtaC
         v0n8kEkiosrjMAhZSKvQgJYn9dU2rqZDRpdnO4uGRaFLjI9b9Y0PuDKLxpCDoPlRVM
         Kfrm1r9uE/UZOD7F6V09EJ/zb43y/5wV8PiKYaB7bniXZdEbmqbvCq8CP3jQg/Tsdj
         +bnS0Gb/itH4A==
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
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915/dp: Use max params for older panels
Date:   Wed,  4 Aug 2021 23:24:02 +0800
Message-Id: <20210804152408.584823-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users reported that after commit 2bbd6dba84d4 ("drm/i915: Try to use
fast+narrow link on eDP again and fall back to the old max strategy on
failure"), the screen starts to have wobbly effect.

Commit a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for
everything") doesn't help either, that means the affected panels only
work with max params.

The panels are all DP 1.1 ones, so apply max params to them to resolve
the issue.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3714
Fixes: 2bbd6dba84d4 ("drm/i915: Try to use fast+narrow link on eDP again and fall back to the old max strategy on failure")
Fixes: a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for everything")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 75d4ebc669411..e64bab4b016e1 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1330,14 +1330,16 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
 	limits.min_bpp = intel_dp_min_bpp(pipe_config->output_format);
 	limits.max_bpp = intel_dp_max_bpp(intel_dp, pipe_config);
 
-	if (intel_dp->use_max_params) {
+	if (intel_dp->use_max_params ||
+	    intel_dp->dpcd[DP_DPCD_REV] <= DP_DPCD_REV_11) {
 		/*
 		 * Use the maximum clock and number of lanes the eDP panel
 		 * advertizes being capable of in case the initial fast
-		 * optimal params failed us. The panels are generally
-		 * designed to support only a single clock and lane
-		 * configuration, and typically on older panels these
-		 * values correspond to the native resolution of the panel.
+		 * optimal params failed us or the panel is DP 1.1 or earlier.
+		 * The panels are generally designed to support only a single
+		 * clock and lane configuration, and typically on older panels
+		 * these values correspond to the native resolution of the
+		 * panel.
 		 */
 		limits.min_lane_count = limits.max_lane_count;
 		limits.min_clock = limits.max_clock;
-- 
2.31.1

