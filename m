Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75831D419
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 03:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBQCzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 21:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230071AbhBQCzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613530452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGpyvpoZaV2XZR1+BH6GoXWIxB5qeFgJto6v9O6bjeo=;
        b=Eu3GpsuMk+opfPsQ8PaPnSDgFHi07orILvqXJytC1Ri/2d8gxAxkEZA3DFqwR+Ksd303R9
        /5ygOswVmmFj99f+OrgE1DB0t7cIGMvoy0S71XyM2S99kanjRKbB0V52PxftSeINhV5SSq
        M18QAd3ZY1Bkbhg+dApGbgpX/8vDhKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-PYuQhyyoOl6d2aqUESWFYA-1; Tue, 16 Feb 2021 21:54:10 -0500
X-MC-Unique: PYuQhyyoOl6d2aqUESWFYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBBEAC28A;
        Wed, 17 Feb 2021 02:54:08 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-106.rdu2.redhat.com [10.10.113.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1F010016F7;
        Wed, 17 Feb 2021 02:54:07 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Imre Deak <imre.deak@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] drm/i915/icp+: Use icp_hpd_irq_setup() instead of spt_hpd_irq_setup()
Date:   Tue, 16 Feb 2021 21:53:37 -0500
Message-Id: <20210217025337.1929015-2-lyude@redhat.com>
In-Reply-To: <20210217025337.1929015-1-lyude@redhat.com>
References: <20210217025337.1929015-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing patches for handling workarounds related to gen9 bc, Imre
from Intel discovered that we're using spt_hpd_irq_setup() on ICP+ PCHs
despite it being almost the same as icp_hpd_irq_setup(). Since we need to
be calling icp_hpd_irq_setup() to ensure that CML-S/TGP platforms function
correctly anyway, let's move platforms using PCH_ICP which aren't handled
by gen11_hpd_irq_setup() over to icp_hpd_irq_setup().

Cc: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/i915_irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index f86b147f588f..7ec61187a315 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -4320,6 +4320,8 @@ void intel_irq_init(struct drm_i915_private *dev_priv)
 			dev_priv->display.hpd_irq_setup = gen11_hpd_irq_setup;
 		else if (IS_GEN9_LP(dev_priv))
 			dev_priv->display.hpd_irq_setup = bxt_hpd_irq_setup;
+		else if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
+			dev_priv->display.hpd_irq_setup = icp_hpd_irq_setup;
 		else if (INTEL_PCH_TYPE(dev_priv) >= PCH_SPT)
 			dev_priv->display.hpd_irq_setup = spt_hpd_irq_setup;
 		else
-- 
2.29.2

