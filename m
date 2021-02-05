Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD6311A91
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBFD6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231952AbhBFC62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612580221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qg0OOS5m94MqUzMPuQVuiHcWMuHoVtQIrp4RF85meQ=;
        b=gV1Xbpi8grE1TqsPFNAOTQNjK4PNdywDBio+oee2lLeg54GIfqvtVHjsCVQFoY0RFWumlo
        1G97oj4kxbLCUfozu25yg5L17ChbzVLrAA/fnVuUBVjpl6hdPGmopZGeO+HMZL15+w//60
        kYu9gPLjqnevFDuGXH9qEk7rHaT7xgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-BuvRR7lVPGaqq8G6DA9SHg-1; Fri, 05 Feb 2021 18:45:33 -0500
X-MC-Unique: BuvRR7lVPGaqq8G6DA9SHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C42C01005D49;
        Fri,  5 Feb 2021 23:45:30 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-116-79.rdu2.redhat.com [10.10.116.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D80319727;
        Fri,  5 Feb 2021 23:45:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@gmail.com>, greg.depoire@gmail.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 03/10] drm/i915/dpcd_bl: Remove redundant AUX backlight frequency calculations
Date:   Fri,  5 Feb 2021 18:45:07 -0500
Message-Id: <20210205234515.1216538-4-lyude@redhat.com>
In-Reply-To: <20210205234515.1216538-1-lyude@redhat.com>
References: <20210205234515.1216538-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while moving all of the VESA backlight code in i915 over to
DRM helpers: it would appear that we calculate the frequency value we want
to write to DP_EDP_BACKLIGHT_FREQ_SET twice even though this value never
actually changes during runtime. So, let's simplify things by just caching
this value in intel_panel.backlight, and re-writing it as-needed.

Changes since v1:
* Wrap panel->backlight.edp.vesa.pwm_freq_pre_divider in
  DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP check - Jani

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: greg.depoire@gmail.com
---
 .../drm/i915/display/intel_display_types.h    |  1 +
 .../drm/i915/display/intel_dp_aux_backlight.c | 65 ++++++-------------
 2 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 307ff4b771f4..f4b26e1dbaaf 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -264,6 +264,7 @@ struct intel_panel {
 		union {
 			struct {
 				u8 pwmgen_bit_count;
+				u8 pwm_freq_pre_divider;
 			} vesa;
 			struct {
 				bool sdr_uses_aux;
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 651884390137..62294967f430 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -373,50 +373,6 @@ intel_dp_aux_vesa_set_backlight(const struct drm_connector_state *conn_state,
 	}
 }
 
-/*
- * Set PWM Frequency divider to match desired frequency in vbt.
- * The PWM Frequency is calculated as 27Mhz / (F x P).
- * - Where F = PWM Frequency Pre-Divider value programmed by field 7:0 of the
- *             EDP_BACKLIGHT_FREQ_SET register (DPCD Address 00728h)
- * - Where P = 2^Pn, where Pn is the value programmed by field 4:0 of the
- *             EDP_PWMGEN_BIT_COUNT register (DPCD Address 00724h)
- */
-static bool intel_dp_aux_vesa_set_pwm_freq(struct intel_connector *connector)
-{
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	struct intel_dp *intel_dp = intel_attached_dp(connector);
-	const u8 pn = connector->panel.backlight.edp.vesa.pwmgen_bit_count;
-	int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
-
-	freq = dev_priv->vbt.backlight.pwm_freq_hz;
-	if (!freq) {
-		drm_dbg_kms(&dev_priv->drm,
-			    "Use panel default backlight frequency\n");
-		return false;
-	}
-
-	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
-	f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
-	fxp_actual = f << pn;
-
-	/* Ensure frequency is within 25% of desired value */
-	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
-	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
-
-	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
-		drm_dbg_kms(&dev_priv->drm, "Actual frequency out of range\n");
-		return false;
-	}
-
-	if (drm_dp_dpcd_writeb(&intel_dp->aux,
-			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
-		drm_dbg_kms(&dev_priv->drm,
-			    "Failed to write aux backlight freq\n");
-		return false;
-	}
-	return true;
-}
-
 static void
 intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
 				   const struct drm_connector_state *conn_state, u32 level)
@@ -459,9 +415,13 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
 		break;
 	}
 
-	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP)
-		if (intel_dp_aux_vesa_set_pwm_freq(connector))
+	if (panel->backlight.edp.vesa.pwm_freq_pre_divider) {
+		if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_BACKLIGHT_FREQ_SET,
+				       panel->backlight.edp.vesa.pwm_freq_pre_divider) == 1)
 			new_dpcd_buf |= DP_EDP_BACKLIGHT_FREQ_AUX_SET_ENABLE;
+		else
+			drm_dbg_kms(&i915->drm, "Failed to write aux backlight frequency\n");
+	}
 
 	if (new_dpcd_buf != dpcd_buf) {
 		if (drm_dp_dpcd_writeb(&intel_dp->aux,
@@ -482,6 +442,14 @@ static void intel_dp_aux_vesa_disable_backlight(const struct drm_connector_state
 				  false);
 }
 
+/*
+ * Compute PWM frequency divider value based off the frequency provided to us by the vbt.
+ * The PWM Frequency is calculated as 27Mhz / (F x P).
+ * - Where F = PWM Frequency Pre-Divider value programmed by field 7:0 of the
+ *             EDP_BACKLIGHT_FREQ_SET register (DPCD Address 00728h)
+ * - Where P = 2^Pn, where Pn is the value programmed by field 4:0 of the
+ *             EDP_PWMGEN_BIT_COUNT register (DPCD Address 00724h)
+ */
 static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connector)
 {
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
@@ -533,8 +501,10 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
 	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
 	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
 
+	/* Ensure frequency is within 25% of desired value */
 	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
 	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
+
 	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
 		drm_dbg_kms(&i915->drm,
 			    "VBT defined backlight frequency out of range\n");
@@ -555,7 +525,10 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
 			    "Failed to write aux pwmgen bit count\n");
 		return max_backlight;
 	}
+
 	panel->backlight.edp.vesa.pwmgen_bit_count = pn;
+	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP)
+		panel->backlight.edp.vesa.pwm_freq_pre_divider = f;
 
 	max_backlight = (1 << pn) - 1;
 
-- 
2.29.2

