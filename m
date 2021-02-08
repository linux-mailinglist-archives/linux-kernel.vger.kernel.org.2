Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0888314429
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBHXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhBHXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612827573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrrEsuBcP8pWJgM1IDUnWMIDU5eAc7wMjcswTZ/KrXA=;
        b=HG1oE9o9SnLTRir+wzWfUVowT3KG99O/XJbD19gZU41HY+gJviaeBgpaZi1jpDMFaanBNn
        SpiPEn+FpbUlANaqYT749YwQ6mWyHg+0D8XqCK2PIzRTFYYxOIbgDZPxEHUAffb/G6dz4M
        2MIf8/VV/3Pu1da085VvL629NCTJ4ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-WCLe8itPMqCeyJv5s0PDLA-1; Mon, 08 Feb 2021 18:39:29 -0500
X-MC-Unique: WCLe8itPMqCeyJv5s0PDLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFE94345B9;
        Mon,  8 Feb 2021 23:39:27 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-114-219.rdu2.redhat.com [10.10.114.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E197F60938;
        Mon,  8 Feb 2021 23:39:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 07/11] drm/i915/dpcd_bl: Move VESA backlight enabling code closer together
Date:   Mon,  8 Feb 2021 18:38:57 -0500
Message-Id: <20210208233902.1289693-8-lyude@redhat.com>
In-Reply-To: <20210208233902.1289693-1-lyude@redhat.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, just move set_vesa_backlight_enable() closer to it's
only caller: intel_dp_aux_vesa_enable_backlight().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c | 54 +++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 74001b479d80..611eb3a7cc08 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -270,33 +270,6 @@ intel_dp_aux_hdr_setup_backlight(struct intel_connector *connector, enum pipe pi
 }
 
 /* VESA backlight callbacks */
-static void set_vesa_backlight_enable(struct intel_connector *connector, bool enable)
-{
-	struct intel_dp *intel_dp = intel_attached_dp(connector);
-	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
-	u8 reg_val = 0;
-
-	/* Early return when display use other mechanism to enable backlight. */
-	if (!connector->panel.backlight.edp.vesa.aux_enable)
-		return;
-
-	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER, &reg_val) != 1) {
-		drm_dbg_kms(&i915->drm, "Failed to read DPCD register 0x%x\n",
-			    DP_EDP_DISPLAY_CONTROL_REGISTER);
-		return;
-	}
-	if (enable)
-		reg_val |= DP_EDP_BACKLIGHT_ENABLE;
-	else
-		reg_val &= ~(DP_EDP_BACKLIGHT_ENABLE);
-
-	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,
-			       reg_val) != 1) {
-		drm_dbg_kms(&i915->drm, "Failed to %s aux backlight\n",
-			    enable ? "enable" : "disable");
-	}
-}
-
 static bool intel_dp_aux_vesa_backlight_dpcd_mode(struct intel_connector *connector)
 {
 	struct intel_dp *intel_dp = intel_attached_dp(connector);
@@ -378,6 +351,33 @@ intel_dp_aux_vesa_set_backlight(const struct drm_connector_state *conn_state,
 	}
 }
 
+static void set_vesa_backlight_enable(struct intel_connector *connector, bool enable)
+{
+	struct intel_dp *intel_dp = intel_attached_dp(connector);
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+	u8 reg_val = 0;
+
+	/* Early return when display use other mechanism to enable backlight. */
+	if (!connector->panel.backlight.edp.vesa.aux_enable)
+		return;
+
+	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER, &reg_val) != 1) {
+		drm_dbg_kms(&i915->drm, "Failed to read DPCD register 0x%x\n",
+			    DP_EDP_DISPLAY_CONTROL_REGISTER);
+		return;
+	}
+	if (enable)
+		reg_val |= DP_EDP_BACKLIGHT_ENABLE;
+	else
+		reg_val &= ~(DP_EDP_BACKLIGHT_ENABLE);
+
+	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,
+			       reg_val) != 1) {
+		drm_dbg_kms(&i915->drm, "Failed to %s aux backlight\n",
+			    enable ? "enable" : "disable");
+	}
+}
+
 static void
 intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
 				   const struct drm_connector_state *conn_state, u32 level)
-- 
2.29.2

