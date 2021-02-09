Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FBA315BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhBJBDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233669AbhBIWUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612909083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vu/MgDLq9F074IoGVBKpvw/wkMsGon8jwgEBBiJIJa4=;
        b=XgB2Q4LFj1rpoKGDrZpnVD3b88PR3Y1g7JBrqjvbYGh/Oqb3pYEnbZA6mIWZH0rSPMFyy3
        ou52fZmYCnGmyjCeLpXN9Mf4QvV/JjMk5pIizUByuFJsuTSGPCf/6SN9IG8vVH93YIWfrN
        nvoHsjFHqpEYgiGppYotlVKnrcGjre4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-iDxa6JzZP4CZXyHn1GTHZg-1; Tue, 09 Feb 2021 16:29:07 -0500
X-MC-Unique: iDxa6JzZP4CZXyHn1GTHZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A16100B3B1;
        Tue,  9 Feb 2021 21:29:05 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-53.rdu2.redhat.com [10.10.113.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8D7819C78;
        Tue,  9 Feb 2021 21:29:02 +0000 (UTC)
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
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/4] drm/i915/gen9_bc: Introduce HPD pin mappings for TGP PCH + CML combos
Date:   Tue,  9 Feb 2021 16:28:30 -0500
Message-Id: <20210209212832.1401815-4-lyude@redhat.com>
In-Reply-To: <20210209212832.1401815-1-lyude@redhat.com>
References: <20210209212832.1401815-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next, let's start introducing the HPD pin mappings for Intel's new gen9_bc
platform in order to make hotplugging display connectors work. Since
gen9_bc is just a TGP PCH along with a CML CPU, except with the same HPD
mappings as ICL, we simply add a skl_hpd_pin function that is shared
between gen9 and gen9_bc which handles both the traditional gen9 HPD pin
mappings and the Icelake HPD pin mappings that gen9_bc uses.

Changes since v4:
* Split this into its own commit
* Introduce skl_hpd_pin() like vsyrjala suggested and use that instead of
  sticking our HPD pin mappings in TGP code

Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
[originally from Tejas's work]
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 3c4003605f93..01b171f52694 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3954,6 +3954,14 @@ static enum hpd_pin cnl_hpd_pin(struct drm_i915_private *dev_priv,
 	return HPD_PORT_A + port - PORT_A;
 }
 
+static enum hpd_pin skl_hpd_pin(struct drm_i915_private *dev_priv, enum port port)
+{
+	if (HAS_PCH_TGP(dev_priv))
+		return icl_hpd_pin(dev_priv, port);
+
+	return HPD_PORT_A + port - PORT_A;
+}
+
 #define port_tc_name(port) ((port) - PORT_TC1 + '1')
 #define tc_port_name(tc_port) ((tc_port) - TC_PORT_1 + '1')
 
@@ -4070,6 +4078,8 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
 		encoder->hpd_pin = icl_hpd_pin(dev_priv, port);
 	else if (IS_GEN(dev_priv, 10))
 		encoder->hpd_pin = cnl_hpd_pin(dev_priv, port);
+	else if (IS_GEN(dev_priv, 9))
+		encoder->hpd_pin = skl_hpd_pin(dev_priv, port);
 	else
 		encoder->hpd_pin = intel_hpd_pin_default(dev_priv, port);
 
-- 
2.29.2

