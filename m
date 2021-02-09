Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D68315C81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhBJBpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233594AbhBIXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612914772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCgxYhlKqouW5On/JyHP4QhxHmQ7Rz3iIIznSUlIx+I=;
        b=G0PBxnW6lUNowJmUpLvBx4+Z7eeQGXCkjj4tNPX9wCkjEKKleie/jvFGuQ5gpljuORx7a2
        01/j/T4d6FowF0Y2Zcdv4e9p1sqajaDFdQXO+SGqFCGlcXLzjgE8kkNOCUhlBywTUVPM+1
        voL3dU1awsY8yxurXYOW/UzV2ou6tqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-Ex30AsQsPLG-6M6wmYfpQA-1; Tue, 09 Feb 2021 16:29:03 -0500
X-MC-Unique: Ex30AsQsPLG-6M6wmYfpQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97EA6192D794;
        Tue,  9 Feb 2021 21:29:00 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-53.rdu2.redhat.com [10.10.113.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74E1919C78;
        Tue,  9 Feb 2021 21:28:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Matt Roper <matthew.d.roper@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Yijun Shen <Yijun.Shen@dell.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Aditya Swarup <aditya.swarup@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/4] drm/i915/gen9_bc: Introduce TGP PCH DDC pin mappings
Date:   Tue,  9 Feb 2021 16:28:29 -0500
Message-Id: <20210209212832.1401815-3-lyude@redhat.com>
In-Reply-To: <20210209212832.1401815-1-lyude@redhat.com>
References: <20210209212832.1401815-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of gen9_bc, where Intel combines Cometlake CPUs with
a Tigerpoint PCH, we'll need to introduce new DDC pin mappings for this
platform in order to make all of the display connectors work. So, let's do
that.

Changes since v4:
* Split this into it's own patch - vsyrjala

Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
[originally from Tejas's work]
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c |  9 +++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.c | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 7118530a1c38..1289f9d437e4 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1638,6 +1638,12 @@ static const u8 adls_ddc_pin_map[] = {
 	[ADLS_DDC_BUS_PORT_TC4] = GMBUS_PIN_12_TC4_ICP,
 };
 
+static const u8 gen9bc_tgp_ddc_pin_map[] = {
+	[DDC_BUS_DDI_B] = GMBUS_PIN_2_BXT,
+	[DDC_BUS_DDI_C] = GMBUS_PIN_9_TC1_ICP,
+	[DDC_BUS_DDI_D] = GMBUS_PIN_10_TC2_ICP,
+};
+
 static u8 map_ddc_pin(struct drm_i915_private *dev_priv, u8 vbt_pin)
 {
 	const u8 *ddc_pin_map;
@@ -1651,6 +1657,9 @@ static u8 map_ddc_pin(struct drm_i915_private *dev_priv, u8 vbt_pin)
 	} else if (IS_ROCKETLAKE(dev_priv) && INTEL_PCH_TYPE(dev_priv) == PCH_TGP) {
 		ddc_pin_map = rkl_pch_tgp_ddc_pin_map;
 		n_entries = ARRAY_SIZE(rkl_pch_tgp_ddc_pin_map);
+	} else if (HAS_PCH_TGP(dev_priv) && IS_GEN9_BC(dev_priv)) {
+		ddc_pin_map = gen9bc_tgp_ddc_pin_map;
+		n_entries = ARRAY_SIZE(gen9bc_tgp_ddc_pin_map);
 	} else if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP) {
 		ddc_pin_map = icp_ddc_pin_map;
 		n_entries = ARRAY_SIZE(icp_ddc_pin_map);
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index dad54e116bc4..49528d07c7f3 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3138,6 +3138,24 @@ static u8 rkl_port_to_ddc_pin(struct drm_i915_private *dev_priv, enum port port)
 	return GMBUS_PIN_1_BXT + phy;
 }
 
+static u8 gen9bc_port_to_ddc_pin(struct drm_i915_private *i915, enum port port)
+{
+	enum phy phy = intel_port_to_phy(i915, port);
+
+	drm_WARN_ON(&i915->drm, port == PORT_A);
+
+	/*
+	 * Pin mapping for GEN9 BC depends on which PCH is present.  With TGP,
+	 * final two outputs use type-c pins, even though they're actually
+	 * combo outputs.  With CMP, the traditional DDI A-D pins are used for
+	 * all outputs.
+	 */
+	if (INTEL_PCH_TYPE(i915) >= PCH_TGP && phy >= PHY_C)
+		return GMBUS_PIN_9_TC1_ICP + phy - PHY_C;
+
+	return GMBUS_PIN_1_BXT + phy;
+}
+
 static u8 dg1_port_to_ddc_pin(struct drm_i915_private *dev_priv, enum port port)
 {
 	return intel_port_to_phy(dev_priv, port) + 1;
@@ -3202,6 +3220,8 @@ static u8 intel_hdmi_ddc_pin(struct intel_encoder *encoder)
 		ddc_pin = dg1_port_to_ddc_pin(dev_priv, port);
 	else if (IS_ROCKETLAKE(dev_priv))
 		ddc_pin = rkl_port_to_ddc_pin(dev_priv, port);
+	else if (IS_GEN9_BC(dev_priv) && HAS_PCH_TGP(dev_priv))
+		ddc_pin = gen9bc_port_to_ddc_pin(dev_priv, port);
 	else if (HAS_PCH_MCC(dev_priv))
 		ddc_pin = mcc_port_to_ddc_pin(dev_priv, port);
 	else if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
-- 
2.29.2

