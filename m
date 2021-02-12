Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41A31A4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhBLSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhBLSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613155907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=da6s7P7IlSNAeSqqosARqkvFvXSTPR626wK9BcIsjkc=;
        b=g5gp11Xe5c3qCU10JL/Shp1tejUEPB5AJmKiyYZjgzz+91P82DOQi36xgVHovyYnJYgsuS
        caImf3zD4nIPMtzX4GVmUch2Ps8dh4k3Rk8etDOrG6YGuDW5YDwkOH3Xn4SKupi0sHeRc5
        5Gn0NFqVsN9Ch+hstbarOtZDoKKcjKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-GbPTAnNnMvyBcXdH5bgGQw-1; Fri, 12 Feb 2021 13:51:45 -0500
X-MC-Unique: GbPTAnNnMvyBcXdH5bgGQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 148956EE20;
        Fri, 12 Feb 2021 18:51:43 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-114-167.rdu2.redhat.com [10.10.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FDD75C3E0;
        Fri, 12 Feb 2021 18:51:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/i915/gen9bc: Handle TGP PCH during suspend/resume
Date:   Fri, 12 Feb 2021 13:50:53 -0500
Message-Id: <20210212185053.1689716-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>

For Legacy S3 suspend/resume GEN9 BC needs to enable and
setup TGP PCH.

v2:
* Move Wa_14010685332 into it's own function - vsyrjala
* Add TODO comment about figuring out if we can move this workaround - imre

Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/i915_irq.c | 53 ++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 98145a7f28a4..7d912aa950ee 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -3040,6 +3040,19 @@ static void valleyview_irq_reset(struct drm_i915_private *dev_priv)
 	spin_unlock_irq(&dev_priv->irq_lock);
 }
 
+static void cnp_irq_post_reset(struct drm_i915_private *dev_priv)
+{
+	struct intel_uncore *uncore = &dev_priv->uncore;
+
+	/*
+	 * Wa_14010685332:cnp/cmp,tgp,adp
+	 * TODO: Figure out if this workaround can be applied in the s0ix suspend/resume handlers as
+	 * on earlier platforms and whether the workaround is also needed for runtime suspend/resume
+	 */
+	intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS, SBCLK_RUN_REFCLK_DIS);
+	intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS, 0);
+}
+
 static void gen8_irq_reset(struct drm_i915_private *dev_priv)
 {
 	struct intel_uncore *uncore = &dev_priv->uncore;
@@ -3061,8 +3074,14 @@ static void gen8_irq_reset(struct drm_i915_private *dev_priv)
 	GEN3_IRQ_RESET(uncore, GEN8_DE_MISC_);
 	GEN3_IRQ_RESET(uncore, GEN8_PCU_);
 
-	if (HAS_PCH_SPLIT(dev_priv))
+	if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
+		GEN3_IRQ_RESET(uncore, SDE);
+	else if (HAS_PCH_SPLIT(dev_priv))
 		ibx_irq_reset(dev_priv);
+
+	if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
+	    (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv) < PCH_DG1))
+		cnp_irq_post_reset(dev_priv);
 }
 
 static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
@@ -3104,15 +3123,9 @@ static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
 	if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
 		GEN3_IRQ_RESET(uncore, SDE);
 
-	/* Wa_14010685332:cnp/cmp,tgp,adp */
 	if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
-	    (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
-	     INTEL_PCH_TYPE(dev_priv) < PCH_DG1)) {
-		intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
-				 SBCLK_RUN_REFCLK_DIS, SBCLK_RUN_REFCLK_DIS);
-		intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
-				 SBCLK_RUN_REFCLK_DIS, 0);
-	}
+	    (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv) < PCH_DG1))
+		cnp_irq_post_reset(dev_priv);
 }
 
 static void gen11_irq_reset(struct drm_i915_private *dev_priv)
@@ -3474,6 +3487,9 @@ static void spt_hpd_irq_setup(struct drm_i915_private *dev_priv)
 	ibx_display_interrupt_update(dev_priv, hotplug_irqs, enabled_irqs);
 
 	spt_hpd_detection_setup(dev_priv);
+
+	if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
+		icp_hpd_irq_setup(dev_priv);
 }
 
 static u32 ilk_hotplug_enables(struct drm_i915_private *i915,
@@ -3764,9 +3780,19 @@ static void gen8_de_irq_postinstall(struct drm_i915_private *dev_priv)
 	}
 }
 
+static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
+{
+	struct intel_uncore *uncore = &dev_priv->uncore;
+	u32 mask = SDE_GMBUS_ICP;
+
+	GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
+}
+
 static void gen8_irq_postinstall(struct drm_i915_private *dev_priv)
 {
-	if (HAS_PCH_SPLIT(dev_priv))
+	if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
+		icp_irq_postinstall(dev_priv);
+	else if (HAS_PCH_SPLIT(dev_priv))
 		ibx_irq_postinstall(dev_priv);
 
 	gen8_gt_irq_postinstall(&dev_priv->gt);
@@ -3775,13 +3801,6 @@ static void gen8_irq_postinstall(struct drm_i915_private *dev_priv)
 	gen8_master_intr_enable(dev_priv->uncore.regs);
 }
 
-static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
-{
-	struct intel_uncore *uncore = &dev_priv->uncore;
-	u32 mask = SDE_GMBUS_ICP;
-
-	GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
-}
 
 static void gen11_irq_postinstall(struct drm_i915_private *dev_priv)
 {
-- 
2.29.2

