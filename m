Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820E43DCC96
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhHAQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHAQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 12:05:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194CC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 09:04:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mt6so22088416pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5SL+RQylcOWI34I2yhfIX6PZj28aHRgG2r+bmTmVtdk=;
        b=s6Lngi1YHRL5OsZ+HzBQ0aTBI7y0ccfNZ0iU6ajqBgyOLQWvMNFXKtrk5Tg98KsHBs
         +m3KCk1mljl0iesmLrf4sbeJvPY/aP+EiupF+lCnbuKm6lm5wNFy2ItzbOqaXo0C/IpF
         FD0so6fodUtbnx5h26jDqb1Jea26XVZ9N+/dRbeViaZ7pYXLkfcnb1L4hTVw46swmcas
         CUpacDilUvnuqdu2YW9AAMgGviu3ANewIUOq8XW2pJgVywD6HsxD71Sgm2ro2DQNlClC
         duDffcCniBcXgahJzsxw0gsLGSNIa1tzq5CS2hPdCUYiYU86U9Y5WAIYNjCUKjoCcHTe
         yCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SL+RQylcOWI34I2yhfIX6PZj28aHRgG2r+bmTmVtdk=;
        b=OUjXNdVTTKgcqGGw4fQVPcHSLtwiPNV63sXZhxz6A7F1ciVzopIPgqHfReK31FAaTc
         DYtYTTX3o8N8oGCPvDRUYbyIzJualtdZcXXWDQ6O7rBjtomlGbnjI4MDzmQuDJ5RajL0
         G7dn1b9FnKPJ60iRfSZ5FH+QGXYSTF+oDj7aJASBRIINI7Lr7fd3vOJ9RdCKl+e+H7zc
         OJNMVlNCpDE88TOt7v9MSI6Mbrs3qhhUWVBztzrS21+eAb5EuUhD8Ks1lVR5C3aBtFHo
         JBERQiIaamMdupt2ErZUHKPqP+0OOUUDm5XgGZHaa8G6LFzz/otXZqtq31sr0x9tY1X2
         AJPw==
X-Gm-Message-State: AOAM533sz1FovkU7uw0dxETsI+Q+3EatBvbkYsy0212825n8ZlNXWpzi
        nlH70xfSuUVNZWuXLh4tNuY=
X-Google-Smtp-Source: ABdhPJwbVcFaHrX080oCLbtIPHmLnsmqqFJrbKo9fteCN1SR/2rfkC9DHDJMFrJe02lIhLkP5gimHw==
X-Received: by 2002:a05:6a00:148e:b029:331:5b07:c89a with SMTP id v14-20020a056a00148eb02903315b07c89amr13145814pfu.41.1627833898546;
        Sun, 01 Aug 2021 09:04:58 -0700 (PDT)
Received: from adolin ([49.207.203.94])
        by smtp.gmail.com with ESMTPSA id 26sm10113047pgx.72.2021.08.01.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 09:04:58 -0700 (PDT)
Date:   Sun, 1 Aug 2021 21:33:48 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/2] drm/vkms: Add support for virtual hardware mode
Message-ID: <8881e29603540485e464d46f2ef1d15f8c4969cf.1627831087.git.sylphrenadin@gmail.com>
References: <cover.1627831087.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627831087.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a virtual hardware or vblank-less mode as a module
to enable VKMS to emulate virtual hardware drivers. This means
no vertical blanking events occur and pageflips are completed
arbitrarily and when required for updating the frame.

Add a new drm_crtc_helper_funcs struct,
vkms_virtual_crtc_helper_funcs() which holds the atomic helpers
for virtual hardware mode. Rename the existing
vkms_crtc_helper_funcs struct to vkms_vblank_crtc_helper_funcs
which holds atomic helpers for the vblank mode.
This makes the code flow clearer and testing
virtual hardware mode.

Add a function vkms_crtc_composer() which calls the helper function,
vkms_composer_common() for plane composition in vblank-less mode.
vkms_crtc_composer() is directly called in the atomic hook in
vkms_crtc_atomic_begin().

However, some crc captures still use vblanks which causes the crc-based
igt tests to crash. Currently, I am unsure about how to approach the
one-shot implementation of crc reads so I am still working on that.

This patchset has been tested with the igt tests- kms_writeback, kms_atomic
, kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
subtests related to crc reads and skips tests that rely on vertical
blanking.

The patch is based on Rodrigo Siqueira's
patch(https://patchwork.freedesktop.org/patch/316851/?series=48469&rev=3)
and the ensuing review.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
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
 drivers/gpu/drm/vkms/vkms_composer.c | 21 ++++++++++--
 drivers/gpu/drm/vkms/vkms_crtc.c     | 51 ++++++++++++++++++++--------
 drivers/gpu/drm/vkms/vkms_drv.c      | 16 ++++++---
 drivers/gpu/drm/vkms/vkms_drv.h      |  2 ++
 4 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index bf3d576db225..2988d5b49eb6 100644
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
@@ -295,6 +296,20 @@ void vkms_composer_worker(struct work_struct *work)
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
index 57bbd32e9beb..8477b33c4d09 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -222,20 +222,20 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
 
-static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
-				    struct drm_atomic_state *state)
+static void vkms_vblank_crtc_atomic_enable(struct drm_crtc *crtc,
+					   struct drm_atomic_state *state)
 {
 	drm_crtc_vblank_on(crtc);
 }
 
-static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
-				     struct drm_atomic_state *state)
+static void vkms_vblank_crtc_atomic_disable(struct drm_crtc *crtc,
+					    struct drm_atomic_state *state)
 {
 	drm_crtc_vblank_off(crtc);
 }
 
-static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
-				   struct drm_atomic_state *state)
+static void vkms_vblank_crtc_atomic_begin(struct drm_crtc *crtc,
+					  struct drm_atomic_state *state)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 
@@ -245,8 +245,8 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 	spin_lock_irq(&vkms_output->lock);
 }
 
-static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
-				   struct drm_atomic_state *state)
+static void vkms_vblank_crtc_atomic_flush(struct drm_crtc *crtc,
+					  struct drm_atomic_state *state)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 
@@ -268,18 +268,38 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 	spin_unlock_irq(&vkms_output->lock);
 }
 
-static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
+/*
+ * Crtc functions for virtual hardware/vblankless mode
+ */
+static void vkms_virtual_crtc_atomic_flush(struct drm_crtc *crtc,
+					   struct drm_atomic_state *state)
+{
+	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
+	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc->state);
+
+	vkms_crtc_composer(vkms_state);
+
+	vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
+}
+
+static const struct drm_crtc_helper_funcs vkms_vblank_crtc_helper_funcs = {
 	.atomic_check	= vkms_crtc_atomic_check,
-	.atomic_begin	= vkms_crtc_atomic_begin,
-	.atomic_flush	= vkms_crtc_atomic_flush,
-	.atomic_enable	= vkms_crtc_atomic_enable,
-	.atomic_disable	= vkms_crtc_atomic_disable,
+	.atomic_begin	= vkms_vblank_crtc_atomic_begin,
+	.atomic_flush	= vkms_vblank_crtc_atomic_flush,
+	.atomic_enable	= vkms_vblank_crtc_atomic_enable,
+	.atomic_disable	= vkms_vblank_crtc_atomic_disable,
+};
+
+static const struct drm_crtc_helper_funcs vkms_virtual_crtc_helper_funcs = {
+	.atomic_check	= vkms_crtc_atomic_check,
+	.atomic_flush	= vkms_virtual_crtc_atomic_flush,
 };
 
 int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		   struct drm_plane *primary, struct drm_plane *cursor)
 {
 	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	int ret;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
@@ -289,7 +309,10 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		return ret;
 	}
 
-	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
+	if (vkmsdev->config->virtual_hw)
+		drm_crtc_helper_add(crtc, &vkms_virtual_crtc_helper_funcs);
+	else
+		drm_crtc_helper_add(crtc, &vkms_vblank_crtc_helper_funcs);
 
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
index 01beba424f18..770594e07f0e 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -92,6 +92,7 @@ struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
+	bool virtual_hw;
 	/* only set when instantiated */
 	struct vkms_device *dev;
 };
@@ -136,6 +137,7 @@ int vkms_composer_common(struct vkms_crtc_state *crtc_state, struct vkms_output
 			 bool wb_pending, uint32_t *crcs);
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
+void vkms_crtc_composer(struct vkms_crtc_state *crtc_state);
 
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
-- 
2.31.1

