Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D411310D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 16:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBEON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:13:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:59196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231663AbhBEN4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:56:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58F50AED2;
        Fri,  5 Feb 2021 13:53:03 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Eric Anholt <eric@anholt.net>
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 07/11] drm/v3d: Get rid of pm code
Date:   Fri,  5 Feb 2021 14:52:43 +0100
Message-Id: <20210205135249.2924-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205135249.2924-1-nsaenzjulienne@suse.de>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runtime PM doesn't seem to work correctly on this driver. On top of
that, commit 8b6864e3e138 (drm/v3d/v3d_drv: Remove unused static
variable 'v3d_v3d_pm_ops') hints that it most likely never did properly
as the driver's PM ops were not hooked-up.

So, in order to support regular operation with V3D on BCM2711 (Raspberry
Pi 4), get rid of the PM code. PM will be reinstated once we figure out
the underlying issues.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 18 +-----------------
 drivers/gpu/drm/v3d/v3d_drv.c     | 11 -----------
 drivers/gpu/drm/v3d/v3d_gem.c     |  9 ---------
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index e76b24bb8828..e1d5f3423059 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -4,7 +4,6 @@
 #include <linux/circ_buf.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
-#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 
 #include <drm/drm_debugfs.h>
@@ -130,11 +129,7 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	struct drm_device *dev = node->minor->dev;
 	struct v3d_dev *v3d = to_v3d_dev(dev);
 	u32 ident0, ident1, ident2, ident3, cores;
-	int ret, core;
-
-	ret = pm_runtime_get_sync(v3d->drm.dev);
-	if (ret < 0)
-		return ret;
+	int core;
 
 	ident0 = V3D_READ(V3D_HUB_IDENT0);
 	ident1 = V3D_READ(V3D_HUB_IDENT1);
@@ -187,9 +182,6 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 			   (misccfg & V3D_MISCCFG_OVRTMUOUT) != 0);
 	}
 
-	pm_runtime_mark_last_busy(v3d->drm.dev);
-	pm_runtime_put_autosuspend(v3d->drm.dev);
-
 	return 0;
 }
 
@@ -217,11 +209,6 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	uint32_t cycles;
 	int core = 0;
 	int measure_ms = 1000;
-	int ret;
-
-	ret = pm_runtime_get_sync(v3d->drm.dev);
-	if (ret < 0)
-		return ret;
 
 	if (v3d->ver >= 40) {
 		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
@@ -245,9 +232,6 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 		   cycles / (measure_ms * 1000),
 		   (cycles / (measure_ms * 100)) % 10);
 
-	pm_runtime_mark_last_busy(v3d->drm.dev);
-	pm_runtime_put_autosuspend(v3d->drm.dev);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 99e22beea90b..7a3336443a12 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <drm/drm_drv.h>
@@ -43,7 +42,6 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_dev *v3d = to_v3d_dev(dev);
 	struct drm_v3d_get_param *args = data;
-	int ret;
 	static const u32 reg_map[] = {
 		[DRM_V3D_PARAM_V3D_UIFCFG] = V3D_HUB_UIFCFG,
 		[DRM_V3D_PARAM_V3D_HUB_IDENT1] = V3D_HUB_IDENT1,
@@ -69,17 +67,12 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 		if (args->value != 0)
 			return -EINVAL;
 
-		ret = pm_runtime_get_sync(v3d->drm.dev);
-		if (ret < 0)
-			return ret;
 		if (args->param >= DRM_V3D_PARAM_V3D_CORE0_IDENT0 &&
 		    args->param <= DRM_V3D_PARAM_V3D_CORE0_IDENT2) {
 			args->value = V3D_CORE_READ(0, offset);
 		} else {
 			args->value = V3D_READ(offset);
 		}
-		pm_runtime_mark_last_busy(v3d->drm.dev);
-		pm_runtime_put_autosuspend(v3d->drm.dev);
 		return 0;
 	}
 
@@ -271,10 +264,6 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, 50);
-	pm_runtime_enable(dev);
-
 	ret = v3d_gem_init(drm);
 	if (ret)
 		goto dma_free;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 4eb354226972..75582b03470b 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -6,7 +6,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
@@ -372,9 +371,6 @@ v3d_job_free(struct kref *ref)
 	dma_fence_put(job->irq_fence);
 	dma_fence_put(job->done_fence);
 
-	pm_runtime_mark_last_busy(job->v3d->drm.dev);
-	pm_runtime_put_autosuspend(job->v3d->drm.dev);
-
 	kfree(job);
 }
 
@@ -441,10 +437,6 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	job->v3d = v3d;
 	job->free = free;
 
-	ret = pm_runtime_get_sync(v3d->drm.dev);
-	if (ret < 0)
-		return ret;
-
 	xa_init_flags(&job->deps, XA_FLAGS_ALLOC);
 
 	ret = drm_syncobj_find_fence(file_priv, in_sync, 0, 0, &in_fence);
@@ -460,7 +452,6 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	return 0;
 fail:
 	xa_destroy(&job->deps);
-	pm_runtime_put_autosuspend(v3d->drm.dev);
 	return ret;
 }
 
-- 
2.30.0

