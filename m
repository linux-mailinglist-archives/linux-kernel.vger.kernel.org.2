Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6F353831
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhDDNLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhDDNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 09:11:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B48EC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 06:11:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so6643167pjh.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KnebAHcN/54k3ocGY8IQZpxhBTA+JacuxCbZLGW2F6M=;
        b=Li2cZni4nYxYD6cqEmLVm1aWoEAK832A3V50Vctw4FdEbdKpa9wShi4ok2BHprbfmN
         aSzkiPszs538asJAJCovXbuYgPxMDhEAFS+qd6jyjd7SKo4B7qy0FegsWsVZBKSJbQB4
         Al3iTzrT+VuOJc4G8PSSx7D/RVN8EMCVfsoYpe/e4bM2EVTV27Nj9q3zzw8QOYZmLwo8
         aiVA3+mpM9FQot3E7cGhHPS4C3jaY5t0gHjsr89itV8Q/KpWSDfrDEZtgByF40/acOTx
         orC40+h+CNi6NIpNn1lwBUP3ReNiQJ/5uwK2T2aF0gSs4RITLbEnsmlNFaTvstXRegsD
         xDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KnebAHcN/54k3ocGY8IQZpxhBTA+JacuxCbZLGW2F6M=;
        b=ajnZ/Qmp0zCh8O5goOnb1FxUapow/zvVb/HQ0kQkC9XzApBJgYHU1RGGUmM+jekQQw
         hu55qbDGssMrZ7odvmD0rEO574XSzXVqSPQeZLBV/P39gK+FlRINvqptxbfnM07lcpaB
         HxSv0KhUZaSemX/sumtRWbYQrkfULdJHFNh2KaFHKlja+0688i9xeo/MUC4thnB805iq
         g3+FXOhF+MzuTIhlw5hTtKGYSUWnjor/urz5lFAvF4MbSONzVUQVjde5XEX9OYpHOWnh
         XyQORmE/ezm7Al87JW4AqAeMV/DMeMN1rVo0M85Y5lizFauh6VeEljCHeF4WbK97rkCg
         yDBA==
X-Gm-Message-State: AOAM531BxPy1NhOJhDdO8mouiTxWNw4RCnVV1fVYfjsx5UNoMSEsKo14
        ten8Cx1ZsLxUfmIV5KXP+ctUZYHLWGYo5Q==
X-Google-Smtp-Source: ABdhPJyh8403X6e7XydMhfm/1/9zvX5I4uspsZ57Hl99gOjpF45cW5huoubbhj9Tx9tBlwYY2j3pog==
X-Received: by 2002:a17:90a:ce03:: with SMTP id f3mr21994579pju.195.1617541898795;
        Sun, 04 Apr 2021 06:11:38 -0700 (PDT)
Received: from adolin ([49.207.202.237])
        by smtp.gmail.com with ESMTPSA id k127sm13347994pfd.63.2021.04.04.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 06:11:38 -0700 (PDT)
Date:   Sun, 4 Apr 2021 18:41:33 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] drm/vkms: Add support for virtual hardware mode
Message-ID: <67941611d8ac9264d1b2c0178aa26008e07b311c.1617539357.git.sylphrenadin@gmail.com>
References: <cover.1617539357.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617539357.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a virtual hardware or vblank-less mode as a module to
enable VKMS to emulate virtual graphic drivers.

Add a new drm_crtc_helper_funcs struct,
vkms_virtual_crtc_helper_funcs() which holds the atomic helpers
for virtual hardware mode. Change the existing
vkms_crtc_helper_funcs struct to vkms_vblank_crtc_helper_funcs
which holds atomic helpers for the vblank mode.
This makes the code flow clearer and easier to test
virtual hardware mode.

The first patch of this patchset added the function vkms_crtc_composer()
for plane composition which is used in case of vblank-less mode and
is directly called in the atomic hook in vkms_crtc_atomic_begin().
However, some crc captures still use vblanks which causes the crc-based
igt tests to crash. Currently, I am unsure about how to approach the
one-shot implementation of crc reads so I am still working on that.

This patchset has been tested with the igt tests- kms_writeback, kms_atomic,
kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
subtests related to crc reads and skips tests that rely on vertical
blanking. This patchset must be tested after incorporating the
igt-tests patch:
https://lists.freedesktop.org/archives/igt-dev/2021-February/029355.html .

The patch is based on Rodrigo Siqueira's
patch(https://patchwork.freedesktop.org/patch/316851/?series=48469&rev=3)
and the ensuing review.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V3:
- Refactor patchset(Melissa)
Changes in V2:
- Add atomic helper functions in a separate struct for virtual hardware
mode (Daniel)
- Remove spinlock across 'vkms_output->lock' in vkms_crtc.c(Daniel)
- Add vkms_composer_common() (Daniel)
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 51 +++++++++++++++++++++++---------
 drivers/gpu/drm/vkms/vkms_drv.c  | 18 +++++++----
 drivers/gpu/drm/vkms/vkms_drv.h  |  1 +
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 57bbd32e9beb..e6286f98d5b6 100644
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
+		struct drm_atomic_state *state)
 {
 	drm_crtc_vblank_off(crtc);
 }
 
-static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
-				   struct drm_atomic_state *state)
+static void vkms_vblank_crtc_atomic_begin(struct drm_crtc *crtc,
+		struct drm_atomic_state *state)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 
@@ -245,8 +245,8 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 	spin_lock_irq(&vkms_output->lock);
 }
 
-static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
-				   struct drm_atomic_state *state)
+static void vkms_vblank_crtc_atomic_flush(struct drm_crtc *crtc,
+		struct drm_atomic_state *state)
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
+		struct drm_atomic_state *state)
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
index 538315140585..a44f530ffaf0 100644
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
-- 
2.25.1

