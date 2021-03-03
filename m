Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83C32BE31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385249AbhCCRJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbhCCMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:53:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B66C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:52:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s7so6795486plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfz7LbCE/9ee2waFM9pUCFSV+slUeSO+eMRq0Y7sYzQ=;
        b=LE7vmaMjD6qk4Hy+1rb+Kn/RU2NJNCLxVwXqCL17wciNi79Jn6aLEky/ySMenj7rCe
         fKARR499Ntha9Nc19fW5j7fgiMj2rVd7jaZkh8xYMGfmK9v+3Mju6JNtihZFtUVIP3UZ
         zpdKoeKfPvnxOQC3G7Cv0WQgkPd4FJIS2+8XhNfztegTA2VQ60hsxTd5iPHB62RXB3o6
         cf8e14ddH0xrBQozbNjPJTY+AzhLdEWg+I9GdDwlhgTsjOg3cZnMSLQaSdxGsN6yJSe4
         JuOYqu51ctGzJEDjTTfEYBbAoUWpXDQJtgSUXnnhvwwgRlBxDzmRbevezVbrjoBvGNBS
         XS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfz7LbCE/9ee2waFM9pUCFSV+slUeSO+eMRq0Y7sYzQ=;
        b=Y0CDdNBXP6ffX03OjmnSaatThdnLoT4NosTvE6FiFI+Ev4DapGP0KOo1GHaw9g6Lh7
         iMUbGEv4+eY1ZSWcxp2zaIozRzD3DYEDVXjiQ7eHmHf9URHrhQo4kAv8RObnPB8QRL5C
         Y/cGcYsGTrvhL8Rv4sCiWT1Zzr6lPBArjtBLUVtSZ2GtJSq0+Yo+23Xxb7k40g4B5cQn
         PgKmomgMKhYi59LUbwasK51k37vveaE/pdErW1+UeNU4RsDM5b+s82koNVSlK/LBell1
         3IvH3tuZYpUuOlFeV1gsvPW2kHQmDSUuodoBZN9+PDNnhVtdr90m2In5He5XJJt6eMaG
         glkA==
X-Gm-Message-State: AOAM5310h8fT2aAoKnBS9rnEkdO76sU3sYIWM8f+V3bQGsa7dxFVW2tG
        QMdwAjC+b4+Q8/XDiU+Cks4=
X-Google-Smtp-Source: ABdhPJzMSL9g/rmfaCbjn2qGGKflL+vpnTSU/Ooc545rRBtECtgKKSGsA+bhfPf54x47rnwmI9Itaw==
X-Received: by 2002:a17:902:7286:b029:e3:cec5:f0cb with SMTP id d6-20020a1709027286b02900e3cec5f0cbmr2633647pll.70.1614775937951;
        Wed, 03 Mar 2021 04:52:17 -0800 (PST)
Received: from adolin ([49.207.223.176])
        by smtp.gmail.com with ESMTPSA id m4sm22759663pgu.4.2021.03.03.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:52:17 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:22:12 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     daniel@ffwll.ch, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] drm/vkms: Add support for virtual hardware mode
Message-ID: <a3701bbf1370cd5a1859c715ce3ae834bb91f2fe.1614775351.git.sylphrenadin@gmail.com>
References: <cover.1614775351.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1614775351.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a virtual hardware or vblank-less mode as a module to enable
VKMS to emulate virtual graphic drivers.

Two new functions vkms_composer_common() and vkms_crtc_composer() have
been added. The actual plane composition work has been moved to
vkms_composer_common() which is called by both vkms_composer_worker()
and vkms_crtc_composer(). vkms_crtc_composer() is used in case of
vblank mode and is called directly in the atomic hook in
vkms_atomic_begin(). However, some crc captures still use vblanks
which causes the crc-based igt tests to crash. Currently, I am unsure
about how to approach one-shot implementation of crc reads so I am
still working on that.

The patch is based on Rodrigo Siqueira's
patch(https://patchwork.freedesktop.org/patch/316851/?series=48469&rev=3)
and the ensuing review.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
----
Changes in V2:
- Remove spinlock across 'vkms_output->lock' in vkms_crtc.c(Daniel)
- Add vkms_composer_common() (Daniel)
---
 drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_crtc.c     | 24 ++++++--
 drivers/gpu/drm/vkms/vkms_drv.c      | 18 ++++--
 drivers/gpu/drm/vkms/vkms_drv.h      |  4 ++
 4 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 66c6842d70db..df5b946f001f 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -169,6 +169,44 @@ static int compose_planes(void **vaddr_out,
 	return 0;
 }
 
+int vkms_composer_common(struct vkms_crtc_state *crtc_state,
+			  struct vkms_output *out, bool wb_pending, uint32_t *crc32)
+{
+	struct vkms_composer *primary_composer = NULL;
+	struct vkms_composer *cursor_composer = NULL;
+	void *vaddr_out = NULL;
+	int ret;
+
+	if (crtc_state->num_active_planes >= 1)
+		primary_composer = crtc_state->active_planes[0]->composer;
+	if (crtc_state->num_active_planes == 2)
+		cursor_composer = crtc_state->active_planes[1]->composer;
+	if (!primary_composer)
+		return -EINVAL;
+	if (wb_pending)
+		vaddr_out = crtc_state->active_writeback;
+
+	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
+	if (ret) {
+		if (ret == -EINVAL && !wb_pending)
+			kfree(vaddr_out);
+		return -EINVAL;
+	}
+
+	*crc32 = compute_crc(vaddr_out, primary_composer);
+
+	if (wb_pending) {
+		drm_writeback_signal_completion(&out->wb_connector, 0);
+		spin_lock_irq(&out->composer_lock);
+		crtc_state->wb_pending = false;
+		spin_unlock_irq(&out->composer_lock);
+	} else {
+		kfree(vaddr_out);
+	}
+
+	return 0;
+}
+
 /**
  * vkms_composer_worker - ordered work_struct to compute CRC
  *
@@ -185,12 +223,9 @@ void vkms_composer_worker(struct work_struct *work)
 						composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-	struct vkms_composer *primary_composer = NULL;
-	struct vkms_composer *cursor_composer = NULL;
 	bool crc_pending, wb_pending;
-	void *vaddr_out = NULL;
-	u32 crc32 = 0;
 	u64 frame_start, frame_end;
+	u32 crc32 = 0;
 	int ret;
 
 	spin_lock_irq(&out->composer_lock);
@@ -210,36 +245,9 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!crc_pending)
 		return;
 
-	if (crtc_state->num_active_planes >= 1)
-		primary_composer = crtc_state->active_planes[0]->composer;
-
-	if (crtc_state->num_active_planes == 2)
-		cursor_composer = crtc_state->active_planes[1]->composer;
-
-	if (!primary_composer)
-		return;
-
-	if (wb_pending)
-		vaddr_out = crtc_state->active_writeback;
-
-	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
-	if (ret) {
-		if (ret == -EINVAL && !wb_pending)
-			kfree(vaddr_out);
+	ret = vkms_composer_common(crtc_state, out, crtc_state->wb_pending, &crc32);
+	if (ret == -EINVAL)
 		return;
-	}
-
-	crc32 = compute_crc(vaddr_out, primary_composer);
-
-	if (wb_pending) {
-		drm_writeback_signal_completion(&out->wb_connector, 0);
-		spin_lock_irq(&out->composer_lock);
-		crtc_state->wb_pending = false;
-		spin_unlock_irq(&out->composer_lock);
-	} else {
-		kfree(vaddr_out);
-	}
-
 	/*
 	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
 	 */
@@ -247,6 +255,20 @@ void vkms_composer_worker(struct work_struct *work)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 }
 
+void vkms_crtc_composer(struct vkms_crtc_state *crtc_state)
+{
+	struct drm_crtc *crtc = crtc_state->base.crtc;
+	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
+	u32 crc32 = 0;
+	int ret;
+
+	ret = vkms_composer_common(crtc_state, out, crtc_state->wb_pending, &crc32);
+	if (ret == -EINVAL)
+		return;
+
+	drm_crtc_add_crc_entry(crtc, true, 0, &crc32);
+}
+
 static const char * const pipe_crc_sources[] = {"auto"};
 
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 6164349cdf11..6cc8dc23bd5d 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -224,32 +224,45 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
 				    struct drm_atomic_state *state)
 {
-	drm_crtc_vblank_on(crtc);
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(crtc->dev);
+
+	if (!vkmsdev->config->virtual_hw)
+		drm_crtc_vblank_on(crtc);
 }
 
 static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_atomic_state *state)
 {
-	drm_crtc_vblank_off(crtc);
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(crtc->dev);
+
+	if (!vkmsdev->config->virtual_hw)
+		drm_crtc_vblank_off(crtc);
 }
 
 static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(crtc->dev);
 
 	/* This lock is held across the atomic commit to block vblank timer
 	 * from scheduling vkms_composer_worker until the composer is updated
 	 */
-	spin_lock_irq(&vkms_output->lock);
+	if (!vkmsdev->config->virtual_hw)
+		spin_lock_irq(&vkms_output->lock);
 }
 
 static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
+	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc->state);
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(crtc->dev);
+
+	if (vkmsdev->config->virtual_hw)
+		vkms_crtc_composer(vkms_state);
 
-	if (crtc->state->event) {
+	if (crtc->state->event && !vkmsdev->config->virtual_hw) {
 		spin_lock(&crtc->dev->event_lock);
 
 		if (drm_crtc_vblank_get(crtc) != 0)
@@ -264,7 +277,8 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
 
-	spin_unlock_irq(&vkms_output->lock);
+	if (!vkmsdev->config->virtual_hw)
+		spin_unlock_irq(&vkms_output->lock);
 }
 
 static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 2173b82606f6..945c4495d62a 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -44,6 +44,11 @@ static bool enable_writeback = true;
 module_param_named(enable_writeback, enable_writeback, bool, 0444);
 MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector support");
 
+static bool enable_virtual_hw = false;
+module_param_named(enable_virtual_hw, enable_virtual_hw, bool, 0444);
+MODULE_PARM_DESC(enable_virtual_hw, "Enable/Disable virtual hardware mode(virtual \
+hardware mode disables vblank interrupts)");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_release(struct drm_device *dev)
@@ -159,12 +164,14 @@ static int vkms_create(struct vkms_config *config)
 		goto out_devres;
 	}
 
-	vkms_device->drm.irq_enabled = true;
+	vkms_device->drm.irq_enabled = !vkms_device->config->virtual_hw;
 
-	ret = drm_vblank_init(&vkms_device->drm, 1);
-	if (ret) {
-		DRM_ERROR("Failed to vblank\n");
-		goto out_devres;
+	if (!vkms_device->config->virtual_hw) {
+		ret = drm_vblank_init(&vkms_device->drm, 1);
+		if (ret) {
+			DRM_ERROR("Failed to vblank\n");
+			goto out_devres;
+		}
 	}
 
 	ret = vkms_modeset_init(vkms_device);
@@ -198,6 +205,7 @@ static int __init vkms_init(void)
 
 	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
+	config->virtual_hw = enable_virtual_hw;
 
 	return vkms_create(config);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 35540c7c4416..0730970d24bf 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -85,6 +85,7 @@ struct vkms_device;
 struct vkms_config {
 	bool writeback;
 	bool cursor;
+	bool virtual_hw;
 	/* only set when instantiated */
 	struct vkms_device *dev;
 };
@@ -125,8 +126,11 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 			   size_t *values_cnt);
 
 /* Composer Support */
+int vkms_composer_common(struct vkms_crtc_state *crtc_state, struct vkms_output *out,
+			   bool wb_pending, uint32_t *crcs);
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
+void vkms_crtc_composer(struct vkms_crtc_state *crtc_state);
 
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
-- 
2.25.1

