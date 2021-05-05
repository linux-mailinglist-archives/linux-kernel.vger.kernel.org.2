Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63A1374718
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhEERnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbhEERlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:41:04 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E2C061261
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:15:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 747F1C800B6;
        Wed,  5 May 2021 19:14:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 5GdBOnZDcIJG; Wed,  5 May 2021 19:14:58 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F39860005A4018A54F094b9.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:5a4:18a:54f0:94b9])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 05AAAC800B1;
        Wed,  5 May 2021 19:14:58 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     wse@tuxedocomputers.com, ville.syrjala@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] New function to avoid duplicate code in upcomming commits
Date:   Wed,  5 May 2021 19:14:51 +0200
Message-Id: <20210505171453.1403560-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505171453.1403560-1-wse@tuxedocomputers.com>
References: <20210505171453.1403560-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moves some checks that later will be performed 2 times to an own fuction. This
avoids duplicate code later on.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---

From 42a4a3a7d9ea9948b4071f406e7fcae23bfa0bdf Mon Sep 17 00:00:00 2001
From: Werner Sembach <wse@tuxedocomputers.com>
Date: Mon, 3 May 2021 14:35:39 +0200
Subject: [PATCH 1/3] New function to avoid duplicate code in upcomming commits

---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 41 ++++++++++++++---------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 46de56af33db..576d3d910d06 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1861,6 +1861,31 @@ static int intel_hdmi_port_clock(int clock, int bpc)
 	return clock * bpc / 8;
 }
 
+static enum drm_mode_status
+intel_hdmi_mode_clock_valid(struct intel_hdmi *hdmi, int clock, bool has_hdmi_sink)
+{
+	struct drm_device *dev = intel_hdmi_to_dev(hdmi);
+	struct drm_i915_private *dev_priv = to_i915(dev);
+	enum drm_mode_status status;
+
+	/* check if we can do 8bpc */
+	status = hdmi_port_clock_valid(hdmi, clock, true, has_hdmi_sink);
+
+	if (has_hdmi_sink) {
+		/* if we can't do 8bpc we may still be able to do 12bpc */
+		if (status != MODE_OK && !HAS_GMCH(dev_priv))
+			status = hdmi_port_clock_valid(hdmi, clock * 3 / 2,
+						       true, has_hdmi_sink);
+
+		/* if we can't do 8,12bpc we may still be able to do 10bpc */
+		if (status != MODE_OK && INTEL_GEN(dev_priv) >= 11)
+			status = hdmi_port_clock_valid(hdmi, clock * 5 / 4,
+						       true, has_hdmi_sink);
+	}
+
+	return status;
+}
+
 static enum drm_mode_status
 intel_hdmi_mode_valid(struct drm_connector *connector,
 		      struct drm_display_mode *mode)
@@ -1891,21 +1916,7 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
 	if (drm_mode_is_420_only(&connector->display_info, mode))
 		clock /= 2;
 
-	/* check if we can do 8bpc */
-	status = hdmi_port_clock_valid(hdmi, intel_hdmi_port_clock(clock, 8),
-				       true, has_hdmi_sink);
-
-	if (has_hdmi_sink) {
-		/* if we can't do 8bpc we may still be able to do 12bpc */
-		if (status != MODE_OK && !HAS_GMCH(dev_priv))
-			status = hdmi_port_clock_valid(hdmi, intel_hdmi_port_clock(clock, 12),
-						       true, has_hdmi_sink);
-
-		/* if we can't do 8,12bpc we may still be able to do 10bpc */
-		if (status != MODE_OK && DISPLAY_VER(dev_priv) >= 11)
-			status = hdmi_port_clock_valid(hdmi, intel_hdmi_port_clock(clock, 10),
-						       true, has_hdmi_sink);
-	}
+	status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
 	if (status != MODE_OK)
 		return status;
 
-- 
2.25.1

