Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F13FE044
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbhIAQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhIAQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:45:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96323C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:44:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c6so2295040pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q3IargEtzXAWk12WDeyXf95r5c1qBudaWcqjDG08vIA=;
        b=bo8H9Mc5SOXkM03M+CVjgZSaRewamuVb1K6JCHjxLvv0YkiTvXmWyroAmd+DfExPUL
         hoVIppdF103P3NlEHQVj2xXA1pbt+5vo7T9pK/VgW/fPPYUe4RzDRqx52BXBIKvS/O9d
         wJ3IGhfPuIjvLxzEpuaYUIgFUnDqJTYWcIgnN3AIO+Eliq00KoU7LrAFEpCH5FdAaE2s
         PActsfTf6Ipt6mzgt8BxP6M63ie9uC11yswxFIQaHXoJTd1aA1X861oTlpL528zDdcqz
         Pk3+qA4bAVZzTio8v//y/ynY608FG+wdjjmkHqQKfch1V+sxcDYOM6NqUNwotVVLozr9
         VVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q3IargEtzXAWk12WDeyXf95r5c1qBudaWcqjDG08vIA=;
        b=e7+lfqRhoOclOasD6NJx0BdxDGIeMF5g3+65jW5HtPpT/4WhLunjjQEtfbElQ8NWxP
         gKQigUVEsY/svfjmyfa8nSGnZ0vKavttDMk5dbe4Ko47rcWSEUSOoCDzrDsc/M1vpP6u
         j4K35zl7VMgS9zfbEIp6BVMCkFBJpcgOHPO3hCUfOShOMgSzLQaCLFrNoaGO8uEMGoRE
         UtaaLDjTozeMkfQUazdqeAR/AcLW8DbbiqHbCg723cplFDfx7mSRfa1KllVY4g/cfW8W
         6qBF16JoVhoj6mvlLdQRWeY8Bpvq4e8YMBql6UufJvU+pdAQhXE74hu668b+ZTdfcypl
         8NOA==
X-Gm-Message-State: AOAM530g2kfjhBXzxe/+/4d9v9AS22/u0CNE2UtzG6MTrv/GV8dhOsS5
        dsEzN3wdbFp4BSMT1fBi0Z4eybqteGE=
X-Google-Smtp-Source: ABdhPJwaV+swi3HqzMT7V2OTL78lbH3Wc6HsnZ1f5n/kW4mIl4CXtrCHUFc9SHpz/mYNYcWwZBm+KQ==
X-Received: by 2002:a17:90b:4b44:: with SMTP id mi4mr295415pjb.23.1630514647178;
        Wed, 01 Sep 2021 09:44:07 -0700 (PDT)
Received: from adolin ([49.207.225.208])
        by smtp.gmail.com with ESMTPSA id x28sm50277pfu.51.2021.09.01.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:44:06 -0700 (PDT)
Date:   Wed, 1 Sep 2021 22:12:42 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/2] drm/vkms: Add support for virtual hardware mode
Message-ID: <9ba2c2aa6a607b09de5a0f4615550d3ccdbec0fd.1630512292.git.sylphrenadin@gmail.com>
References: <cover.1630512292.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1630512292.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a virtual hardware or vblank-less mode as a module
to enable VKMS to emulate virtual hardware drivers. This means
no vertical blanking events occur and pageflips are completed
arbitrarily and when required for updating the frame.

Add a new drm_crtc_funcs struct, vkms_vblankless_crtc_funcs and a
drm_crtc_helper_funcs struct, vkms_vblankless_crtc_helper_funcs()
which hold the atomic helpers for virtual hardware mode.
The existing vkms_crtc_funcs struct and vkms_crtc_helper_funcs
struct hold atomic helpers for the default vblank mode.
This makes the code flow clearer and testing
virtual hardware mode easier.

Add a function vkms_crtc_composer() which calls the helper function,
vkms_composer_common() for plane composition in vblank-less mode.
vkms_crtc_composer() is directly called in the atomic hook in
vkms_crtc_atomic_begin().

However, some crc captures still use vblanks which causes the crc-based
igt tests to crash. So, no CRC functions are called in vblankless mode
for now and will be implemented in a later patch.

This patchset has been tested with the igt tests- kms_writeback, kms_atomic
, kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
subtests related to crc reads and vertical blanking, in which case,
tests are skipped.

The patch is based on Rodrigo Siqueira's
patch(https://patchwork.freedesktop.org/patch/316851/?series=48469&rev=3)
and the ensuing review.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V6:
- Skip CRC functions in vblankless mode
- Refactor helper function names(Melissa)
Changes in V5:
- Move vkms_crtc_composer() to this patch(Melissa)
- Add more clarification for "vblank-less" mode(Pekka)
- Replace kzalloc() with kvmalloc() in compose_active_planes()
to fix memory allocation error for output frame
- Fix checkpatch warnings (Melissa)
Changes in V3:
- Refactor patchset(Melissa)
Changes in V2:
- Add atomic helper functions in a separate struct for virtual hardware
mode (Daniel)
- Remove spinlock across 'vkms_output->lock' in vkms_crtc.c(Daniel)
- Add vkms_composer_common() (Daniel)
---
 drivers/gpu/drm/vkms/vkms_composer.c  | 21 +++++++++++--
 drivers/gpu/drm/vkms/vkms_crtc.c      | 43 +++++++++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.c       | 16 +++++++---
 drivers/gpu/drm/vkms/vkms_drv.h       |  2 ++
 drivers/gpu/drm/vkms/vkms_writeback.c |  3 +-
 5 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index bca746fb5b53..a009589b2c3a 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -176,11 +176,12 @@ static int compose_active_planes(void **vaddr_out,
 {
 	struct drm_framebuffer *fb = &primary_composer->fb;
 	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
+
 	const void *vaddr;
 	int i;
 
 	if (!*vaddr_out) {
-		*vaddr_out = kzalloc(gem_obj->size, GFP_KERNEL);
+		*vaddr_out = kvmalloc(gem_obj->size, GFP_KERNEL);
 		if (!*vaddr_out) {
 			DRM_ERROR("Cannot allocate memory for output frame.");
 			return -ENOMEM;
@@ -229,7 +230,7 @@ int vkms_composer_common(struct vkms_crtc_state *crtc_state,
 
 	if (ret) {
 		if ((ret == -EINVAL || ret == -ENOMEM) && !wb_pending)
-			kfree(vaddr_out);
+			kvfree(vaddr_out);
 		return ret;
 	}
 
@@ -241,7 +242,7 @@ int vkms_composer_common(struct vkms_crtc_state *crtc_state,
 		crtc_state->wb_pending = false;
 		spin_unlock_irq(&out->composer_lock);
 	} else {
-		kfree(vaddr_out);
+		kvfree(vaddr_out);
 	}
 
 	return 0;
@@ -296,6 +297,20 @@ void vkms_composer_worker(struct work_struct *work)
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
index 57bbd32e9beb..4a933553e0e4 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -174,6 +174,15 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
 	.verify_crc_source	= vkms_verify_crc_source,
 };
 
+static const struct drm_crtc_funcs vkms_vblankless_crtc_funcs = {
+	.set_config             = drm_atomic_helper_set_config,
+	.destroy                = drm_crtc_cleanup,
+	.page_flip              = drm_atomic_helper_page_flip,
+	.reset                  = vkms_atomic_crtc_reset,
+	.atomic_duplicate_state = vkms_atomic_crtc_duplicate_state,
+	.atomic_destroy_state   = vkms_atomic_crtc_destroy_state,
+};
+
 static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 				  struct drm_atomic_state *state)
 {
@@ -268,6 +277,20 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 	spin_unlock_irq(&vkms_output->lock);
 }
 
+/*
+ * Crtc functions for virtual hardware/vblankless mode
+ */
+static void vkms_vblankless_crtc_atomic_flush(struct drm_crtc *crtc,
+					      struct drm_atomic_state *state)
+{
+	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
+	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc->state);
+
+	vkms_crtc_composer(vkms_state);
+
+	vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
+}
+
 static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
 	.atomic_check	= vkms_crtc_atomic_check,
 	.atomic_begin	= vkms_crtc_atomic_begin,
@@ -276,20 +299,34 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
 	.atomic_disable	= vkms_crtc_atomic_disable,
 };
 
+static const struct drm_crtc_helper_funcs vkms_vblankless_crtc_helper_funcs = {
+	.atomic_check	= vkms_crtc_atomic_check,
+	.atomic_flush	= vkms_vblankless_crtc_atomic_flush,
+};
+
 int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		   struct drm_plane *primary, struct drm_plane *cursor)
 {
 	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	int ret;
 
-	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
-					&vkms_crtc_funcs, NULL);
+	if (vkmsdev->config->virtual_hw)
+		ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
+						&vkms_vblankless_crtc_funcs, NULL);
+	else
+		ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
+						&vkms_crtc_funcs, NULL);
+
 	if (ret) {
 		DRM_ERROR("Failed to init CRTC\n");
 		return ret;
 	}
 
-	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
+	if (vkmsdev->config->virtual_hw)
+		drm_crtc_helper_add(crtc, &vkms_vblankless_crtc_helper_funcs);
+	else
+		drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
 
 	spin_lock_init(&vkms_out->lock);
 	spin_lock_init(&vkms_out->composer_lock);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 0ffe5f0e33f7..ee78f5eef653 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -51,6 +51,10 @@ static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
 MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
+static bool enable_virtual_hw;
+module_param_named(enable_virtual_hw, enable_virtual_hw, bool, 0444);
+MODULE_PARM_DESC(enable_virtual_hw, "Enable/Disable virtual hardware mode(vblank-less mode)");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_release(struct drm_device *dev)
@@ -98,6 +102,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
 	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
 	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+	seq_printf(m, "virtual_hw=%d\n", vkmsdev->config->virtual_hw);
 
 	return 0;
 }
@@ -191,10 +196,12 @@ static int vkms_create(struct vkms_config *config)
 		goto out_devres;
 	}
 
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
@@ -229,6 +236,7 @@ static int __init vkms_init(void)
 	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
 	config->overlay = enable_overlay;
+	config->virtual_hw = enable_virtual_hw;
 
 	return vkms_create(config);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 6f5f63591c20..d64554f21838 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -97,6 +97,7 @@ struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
+	bool virtual_hw;
 	/* only set when instantiated */
 	struct vkms_device *dev;
 };
@@ -141,6 +142,7 @@ int vkms_composer_common(struct vkms_crtc_state *crtc_state, struct vkms_output
 			 bool wb_pending, uint32_t *crcs);
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
+void vkms_crtc_composer(struct vkms_crtc_state *crtc_state);
 
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 8694227f555f..6082cacbca1e 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -120,7 +120,8 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
-	vkms_set_composer(&vkmsdev->output, true);
+	if (!vkmsdev->config->virtual_hw)
+		vkms_set_composer(&vkmsdev->output, true);
 
 	spin_lock_irq(&output->composer_lock);
 	crtc_state->active_writeback = conn_state->writeback_job->priv;
-- 
2.31.1

