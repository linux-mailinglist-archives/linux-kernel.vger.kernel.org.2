Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60A3B4D71
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFZHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 03:35:17 -0400
Received: from mta-07-4.privateemail.com ([68.65.122.27]:32048 "EHLO
        MTA-07-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 03:35:16 -0400
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id BA1B7600FF;
        Sat, 26 Jun 2021 03:32:52 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.203])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id DFBB0600E2;
        Sat, 26 Jun 2021 03:32:50 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karthik B S <karthik.b.s@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/i915/display: replace boilerplate code with helper macros
Date:   Sat, 26 Jun 2021 03:32:27 -0400
Message-Id: <20210626073230.41803-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per commit 22be87401289 ("drm: TODO: Add DRM_MODESET_LOCK_ALL*
conversion to todo.rst"),
drm_modeset_lock_all()/drm_modeset_unlock_all() and boilerplate code
surrounding instances of drm_modeset_lock_all_ctx() with a local acquire
context should be replaced with the relevant helper macros.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 64e9107d70f7..e8cb2881d2b4 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -40,6 +40,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
+#include "drm/drm_modeset_lock.h"
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_rect.h>
@@ -11836,6 +11837,7 @@ int intel_modeset_init_nogem(struct drm_i915_private *i915)
 	struct drm_device *dev = &i915->drm;
 	enum pipe pipe;
 	struct intel_crtc *crtc;
+	struct drm_modeset_acquire_ctx ctx;
 	int ret;
 
 	intel_init_pm(i915);
@@ -11884,9 +11886,9 @@ int intel_modeset_init_nogem(struct drm_i915_private *i915)
 	intel_vga_disable(i915);
 	intel_setup_outputs(i915);
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 	intel_modeset_setup_hw_state(dev, dev->mode_config.acquire_ctx);
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
 
 	for_each_intel_crtc(dev, crtc) {
 		struct intel_initial_plane_config plane_config = {};
@@ -12795,22 +12797,14 @@ void intel_display_resume(struct drm_device *dev)
 	if (state)
 		state->acquire_ctx = &ctx;
 
-	drm_modeset_acquire_init(&ctx, 0);
-
-	while (1) {
-		ret = drm_modeset_lock_all_ctx(dev, &ctx);
-		if (ret != -EDEADLK)
-			break;
-
-		drm_modeset_backoff(&ctx);
-	}
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 
 	if (!ret)
 		ret = __intel_display_resume(dev, state, &ctx);
 
 	intel_enable_ipc(dev_priv);
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
+
+	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
 
 	if (ret)
 		drm_err(&dev_priv->drm,
-- 
2.32.0

