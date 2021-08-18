Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674663F0A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhHRRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:15:48 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39732
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhHRRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:15:47 -0400
Received: from localhost.localdomain (1-171-94-217.dynamic-ip.hinet.net [1.171.94.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6944F412AE;
        Wed, 18 Aug 2021 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629306911;
        bh=iRuFjsARmqnJPsilk5plyw8IeGSZnpqAZVyvL098pEk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=jiYdyVSPQAebYzKXrA/NqUaZV1sUHDSbxQGXsxlfqNO9uybD9g3qxSuiW4cTMDysl
         xs/D5ia+LiIEXLnylbYYb9t/9fIojFas9I71n1ft78fbbcW2XxDq/QEJJLLYqhfoYB
         eXMGKrszNZ72RxBPVW5fMSqLfL9Y3f6Db4hPZY3BBglf36Br2ixp+GZ2jmzK0+37re
         slS1T5UeyBbbWsRwwa8B9eznbAbC40JXbyK8if+fz4AyR19c2LpYUuH43x+D4epSez
         Cl3I78opnMUdRdbw9XAE70VDbF98JnCs5bkZ1z8JU+9mEl6H/emeyPAc8FViLf1TEw
         77AxTaNLGTBPA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/dp: Use max params for panels < eDP 1.4
Date:   Thu, 19 Aug 2021 01:14:55 +0800
Message-Id: <20210818171457.536107-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users reported that after commit 2bbd6dba84d4 ("drm/i915: Try to use
fast+narrow link on eDP again and fall back to the old max strategy on
failure"), the screen starts to have wobbly effect.

Commit a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for
everything") doesn't help either, that means the affected eDP 1.2 panels
only work with max params.

So use max params for panels < eDP 1.4 as Windows does to solve the
issue.

v2:
 - Check eDP 1.4 instead of DPCD 1.1 to apply max params

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3714
Fixes: 2bbd6dba84d4 ("drm/i915: Try to use fast+narrow link on eDP again and fall back to the old max strategy on failure")
Fixes: a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for everything")
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 75d4ebc669411..f87fad78f1a9f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1330,14 +1330,16 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
 	limits.min_bpp = intel_dp_min_bpp(pipe_config->output_format);
 	limits.max_bpp = intel_dp_max_bpp(intel_dp, pipe_config);
 
-	if (intel_dp->use_max_params) {
+	if (intel_dp->use_max_params ||
+	    intel_dp->edp_dpcd[0] < DP_EDP_14) {
 		/*
 		 * Use the maximum clock and number of lanes the eDP panel
 		 * advertizes being capable of in case the initial fast
-		 * optimal params failed us. The panels are generally
-		 * designed to support only a single clock and lane
-		 * configuration, and typically on older panels these
-		 * values correspond to the native resolution of the panel.
+		 * optimal params failed us or the EDP rev is earlier than 1.4.
+		 * The panels are generally designed to support only a single
+		 * clock and lane configuration, and typically on older panels
+		 * these values correspond to the native resolution of the
+		 * panel.
 		 */
 		limits.min_lane_count = limits.max_lane_count;
 		limits.min_clock = limits.max_clock;
-- 
2.32.0

