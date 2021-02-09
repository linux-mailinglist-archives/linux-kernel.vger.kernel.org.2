Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0929E315BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhBJBDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234263AbhBIWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612909112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2N3ca9p7lH/QIyPYN9HaRFvz+R5PWguxowknFdwLol8=;
        b=dHAww2ch9qDtkuqJN76GKslFGXyHz9RWR/ImiOt4Rn+HV9b2nmT2Bznbaaa+h3efRMTK36
        JDwLCqplOHC6DbiVOLwoOUD701NfKoM4VkfSp28rbzyLkb8LsLyYrVg/90LwjH4L4Sg19L
        m8OvXChtKL+kCUnGWMKg5Y4oRjkg+IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-OYYlAEAZMyiimlEYYG6IaQ-1; Tue, 09 Feb 2021 16:28:57 -0500
X-MC-Unique: OYYlAEAZMyiimlEYYG6IaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71B68107ACE6;
        Tue,  9 Feb 2021 21:28:55 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-53.rdu2.redhat.com [10.10.113.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 136AD19C78;
        Tue,  9 Feb 2021 21:28:53 +0000 (UTC)
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
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/4] drm/i915/gen9_bc: Recognize TGP PCH + CML combos
Date:   Tue,  9 Feb 2021 16:28:28 -0500
Message-Id: <20210209212832.1401815-2-lyude@redhat.com>
In-Reply-To: <20210209212832.1401815-1-lyude@redhat.com>
References: <20210209212832.1401815-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Intel has introduced the gen9_bc platform, a combination of
Tigerpoint PCHs and CML CPUs, let's recognize such platforms as valid and
avoid WARNing on them.

Changes since v4:
* Split this into it's own patch - vsyrjala

Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
[originally from Tejas's work]
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/intel_pch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_pch.c b/drivers/gpu/drm/i915/intel_pch.c
index 4813207fc053..7476f0e063c6 100644
--- a/drivers/gpu/drm/i915/intel_pch.c
+++ b/drivers/gpu/drm/i915/intel_pch.c
@@ -121,7 +121,8 @@ intel_pch_type(const struct drm_i915_private *dev_priv, unsigned short id)
 	case INTEL_PCH_TGP2_DEVICE_ID_TYPE:
 		drm_dbg_kms(&dev_priv->drm, "Found Tiger Lake LP PCH\n");
 		drm_WARN_ON(&dev_priv->drm, !IS_TIGERLAKE(dev_priv) &&
-			    !IS_ROCKETLAKE(dev_priv));
+			    !IS_ROCKETLAKE(dev_priv) &&
+			    !IS_GEN9_BC(dev_priv));
 		return PCH_TGP;
 	case INTEL_PCH_JSP_DEVICE_ID_TYPE:
 	case INTEL_PCH_JSP2_DEVICE_ID_TYPE:
-- 
2.29.2

