Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24A444027
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhKCKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhKCKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635936509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCckWj+DVQ/XSKZ1KwQ8WVBmlh1EX5e7dR6B197qkRs=;
        b=QYMgiz8ekrh2THXJngLiV4/BHRIIUNExowkZh44mQLRjpZqXEGPq8eAsHlEoT6sm4qGhpv
        RuiBf5VcwyYiiDcWWTYfZEssKZaZBLR1bzQNzp2yHom/LeGAfEAbavk1nfNXwIGh1cyxy+
        GzGioVCSXkpk341/GdzeeIvgcXdEV9M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Q-l52UwAOS6gWhnKrSCoNQ-1; Wed, 03 Nov 2021 06:48:28 -0400
X-MC-Unique: Q-l52UwAOS6gWhnKrSCoNQ-1
Received: by mail-wm1-f72.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so2541241wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCckWj+DVQ/XSKZ1KwQ8WVBmlh1EX5e7dR6B197qkRs=;
        b=ux29LIaIXmUJyAhfPknDUEgwqmyNudW754m+r8UdZkx1nEghdjzHFR2MoeadzdU+am
         G9UKZeqJzuf1aOAF7uXNXsA55UxGEvBQqVCKCI35oNfl9ngVUC76zZ+8STiPi8Tcgwwo
         gBUlTmuQwKZLaj1T2KFGBgpMZQRGRQ7ig42qB96mpDV7blNgeH6anNc5SqufuXy9KenD
         3uI98JMAge/Zv6WEoKhZzZ9yqMHhb9z0mkRGMjbZ+FRns1p7I3UVm/Llr22qtVAAiOdZ
         ybP0+34CF4A21oos3Dq9WAv2tpCc+ZseC2gUNFoXAufXNwydYNqZLLFkUzN4WsFe2Sdz
         GShw==
X-Gm-Message-State: AOAM531E4Me3Jl6P9rVINXjB4dJ85EMEdz4UVCExfpBNU8bjn+N3AFHW
        eTCbKZnKHhKyd9H0nIIOahQWPIkyvZvW23AUIu7SB/KHfLbXE4mH8VeH+XDYuuSjb4Ibmtfl7No
        cIKpA+boLiJ+9/+b8CyO//ljNyptCVn3VugRp+XHTVqojP8x/Jn2sJd52IcXc/cpOT/Lxl3Okrw
        I=
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr13502356wmj.77.1635936506165;
        Wed, 03 Nov 2021 03:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIEPsZRgUYob3wlj3vBbxdLjaQyqqSwGPuO760GrdZQ5AoxALIs/w9pqwAerQWfmWJQBxCRQ==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr13502318wmj.77.1635936505783;
        Wed, 03 Nov 2021 03:48:25 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f15sm1651555wmg.30.2021.11.03.03.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:48:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 3/5] drm: Rename vgacon_text_force() function to drm_modeset_disabled()
Date:   Wed,  3 Nov 2021 11:48:10 +0100
Message-Id: <20211103104812.1022936-4-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103104812.1022936-1-javierm@redhat.com>
References: <20211103104812.1022936-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used by some DRM drivers to determine if the "nomodeset"
kernel command line parameter was set and prevent these drivers to probe.

But the function name is quite confusing and does not reflect what really
the drivers are testing when calling it. Use a better naming now that it
is part of the DRM subsystem.

Also, vgacon_text_force() is guarded by #ifdef CONFIG_VGA_CONSOLE already
so there is no need to do the same when calling the function.

Suggested-by: Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/ast/ast_drv.c           |  2 +-
 drivers/gpu/drm/drm_nomodeset.c         | 16 ++++++++--------
 drivers/gpu/drm/i915/i915_module.c      |  2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  2 +-
 drivers/gpu/drm/qxl/qxl_drv.c           |  2 +-
 drivers/gpu/drm/radeon/radeon_drv.c     |  2 +-
 drivers/gpu/drm/tiny/bochs.c            |  2 +-
 drivers/gpu/drm/tiny/cirrus.c           |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c    |  4 +---
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  2 +-
 include/drm/drm_mode_config.h           |  4 ++--
 14 files changed, 22 insertions(+), 24 deletions(-)

diff --git drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2680a2aaa877..f7bd2616cf23 100644
--- drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2513,7 +2513,7 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (vgacon_text_force()) {
+	if (drm_modeset_disabled()) {
 		DRM_ERROR("amdgpu kernel modesetting disabled.\n");
 		return -EINVAL;
 	}
diff --git drivers/gpu/drm/ast/ast_drv.c drivers/gpu/drm/ast/ast_drv.c
index 048be607b182..6706050414c3 100644
--- drivers/gpu/drm/ast/ast_drv.c
+++ drivers/gpu/drm/ast/ast_drv.c
@@ -232,7 +232,7 @@ static struct pci_driver ast_pci_driver = {
 
 static int __init ast_init(void)
 {
-	if (vgacon_text_force() && ast_modeset == -1)
+	if (drm_modeset_disabled() && ast_modeset == -1)
 		return -EINVAL;
 
 	if (ast_modeset == 0)
diff --git drivers/gpu/drm/drm_nomodeset.c drivers/gpu/drm/drm_nomodeset.c
index 1ac9a8d5a8fe..dfc8b30f0625 100644
--- drivers/gpu/drm/drm_nomodeset.c
+++ drivers/gpu/drm/drm_nomodeset.c
@@ -3,17 +3,17 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-static bool vgacon_text_mode_force;
+static bool drm_nomodeset;
 
-bool vgacon_text_force(void)
+bool drm_modeset_disabled(void)
 {
-	return vgacon_text_mode_force;
+	return drm_nomodeset;
 }
-EXPORT_SYMBOL(vgacon_text_force);
+EXPORT_SYMBOL(drm_modeset_disabled);
 
-static int __init text_mode(char *str)
+static int __init disable_modeset(char *str)
 {
-	vgacon_text_mode_force = true;
+	drm_nomodeset = true;
 
 	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
 	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
@@ -22,5 +22,5 @@ static int __init text_mode(char *str)
 	return 1;
 }
 
-/* force text mode - used by kernel modesetting */
-__setup("nomodeset", text_mode);
+/* Disable kernel modesetting */
+__setup("nomodeset", disable_modeset);
diff --git drivers/gpu/drm/i915/i915_module.c drivers/gpu/drm/i915/i915_module.c
index 14a59226519d..3e5531040e4d 100644
--- drivers/gpu/drm/i915/i915_module.c
+++ drivers/gpu/drm/i915/i915_module.c
@@ -29,7 +29,7 @@ static int i915_check_nomodeset(void)
 	if (i915_modparams.modeset == 0)
 		use_kms = false;
 
-	if (vgacon_text_force() && i915_modparams.modeset == -1)
+	if (drm_modeset_disabled() && i915_modparams.modeset == -1)
 		use_kms = false;
 
 	if (!use_kms) {
diff --git drivers/gpu/drm/mgag200/mgag200_drv.c drivers/gpu/drm/mgag200/mgag200_drv.c
index 685e766db6a4..7ee87564bade 100644
--- drivers/gpu/drm/mgag200/mgag200_drv.c
+++ drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -377,7 +377,7 @@ static struct pci_driver mgag200_pci_driver = {
 
 static int __init mgag200_init(void)
 {
-	if (vgacon_text_force() && mgag200_modeset == -1)
+	if (drm_modeset_disabled() && mgag200_modeset == -1)
 		return -EINVAL;
 
 	if (mgag200_modeset == 0)
diff --git drivers/gpu/drm/nouveau/nouveau_drm.c drivers/gpu/drm/nouveau/nouveau_drm.c
index 029997f50d1a..903d0e626954 100644
--- drivers/gpu/drm/nouveau/nouveau_drm.c
+++ drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1321,7 +1321,7 @@ nouveau_drm_init(void)
 	nouveau_display_options();
 
 	if (nouveau_modeset == -1) {
-		if (vgacon_text_force())
+		if (drm_modeset_disabled())
 			nouveau_modeset = 0;
 	}
 
diff --git drivers/gpu/drm/qxl/qxl_drv.c drivers/gpu/drm/qxl/qxl_drv.c
index 3cd6bd9f059d..e4ab16837fad 100644
--- drivers/gpu/drm/qxl/qxl_drv.c
+++ drivers/gpu/drm/qxl/qxl_drv.c
@@ -294,7 +294,7 @@ static struct drm_driver qxl_driver = {
 
 static int __init qxl_init(void)
 {
-	if (vgacon_text_force() && qxl_modeset == -1)
+	if (drm_modeset_disabled() && qxl_modeset == -1)
 		return -EINVAL;
 
 	if (qxl_modeset == 0)
diff --git drivers/gpu/drm/radeon/radeon_drv.c drivers/gpu/drm/radeon/radeon_drv.c
index 9b606c1b11ec..36c8dac68cca 100644
--- drivers/gpu/drm/radeon/radeon_drv.c
+++ drivers/gpu/drm/radeon/radeon_drv.c
@@ -636,7 +636,7 @@ static struct pci_driver radeon_kms_pci_driver = {
 
 static int __init radeon_module_init(void)
 {
-	if (vgacon_text_force() && radeon_modeset == -1) {
+	if (drm_modeset_disabled() && radeon_modeset == -1) {
 		DRM_INFO("VGACON disable radeon kernel modesetting.\n");
 		radeon_modeset = 0;
 	}
diff --git drivers/gpu/drm/tiny/bochs.c drivers/gpu/drm/tiny/bochs.c
index 04333f78be55..59189f7c1840 100644
--- drivers/gpu/drm/tiny/bochs.c
+++ drivers/gpu/drm/tiny/bochs.c
@@ -718,7 +718,7 @@ static struct pci_driver bochs_pci_driver = {
 
 static int __init bochs_init(void)
 {
-	if (vgacon_text_force() && bochs_modeset == -1)
+	if (drm_modeset_disabled() && bochs_modeset == -1)
 		return -EINVAL;
 
 	if (bochs_modeset == 0)
diff --git drivers/gpu/drm/tiny/cirrus.c drivers/gpu/drm/tiny/cirrus.c
index 8bd674f0d682..fcf98379c641 100644
--- drivers/gpu/drm/tiny/cirrus.c
+++ drivers/gpu/drm/tiny/cirrus.c
@@ -635,7 +635,7 @@ static struct pci_driver cirrus_pci_driver = {
 
 static int __init cirrus_init(void)
 {
-	if (vgacon_text_force())
+	if (drm_modeset_disabled())
 		return -EINVAL;
 	return pci_register_driver(&cirrus_pci_driver);
 }
diff --git drivers/gpu/drm/vboxvideo/vbox_drv.c drivers/gpu/drm/vboxvideo/vbox_drv.c
index e6d983121d0b..09356dbd69b2 100644
--- drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -192,10 +192,8 @@ static const struct drm_driver driver = {
 
 static int __init vbox_init(void)
 {
-#ifdef CONFIG_VGA_CONSOLE
-	if (vgacon_text_force() && vbox_modeset == -1)
+	if (drm_modeset_disabled() && vbox_modeset == -1)
 		return -EINVAL;
-#endif
 
 	if (vbox_modeset == 0)
 		return -EINVAL;
diff --git drivers/gpu/drm/virtio/virtgpu_drv.c drivers/gpu/drm/virtio/virtgpu_drv.c
index cd4c170236f1..d96797d70fae 100644
--- drivers/gpu/drm/virtio/virtgpu_drv.c
+++ drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -103,7 +103,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	struct drm_device *dev;
 	int ret;
 
-	if (vgacon_text_force() && virtio_gpu_modeset == -1)
+	if (drm_modeset_disabled() && virtio_gpu_modeset == -1)
 		return -EINVAL;
 
 	if (virtio_gpu_modeset == 0)
diff --git drivers/gpu/drm/vmwgfx/vmwgfx_drv.c drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index fcc4b5a7f639..22dab9beea03 100644
--- drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1650,7 +1650,7 @@ static int __init vmwgfx_init(void)
 {
 	int ret;
 
-	if (vgacon_text_force())
+	if (drm_modeset_disabled())
 		return -EINVAL;
 
 	ret = pci_register_driver(&vmw_pci_driver);
diff --git include/drm/drm_mode_config.h include/drm/drm_mode_config.h
index e1d2042a7b77..a5a2dc02e892 100644
--- include/drm/drm_mode_config.h
+++ include/drm/drm_mode_config.h
@@ -970,9 +970,9 @@ void drm_mode_config_reset(struct drm_device *dev);
 void drm_mode_config_cleanup(struct drm_device *dev);
 
 #ifdef CONFIG_VGA_CONSOLE
-extern bool vgacon_text_force(void);
+extern bool drm_modeset_disabled(void);
 #else
-static inline bool vgacon_text_force(void) { return false; }
+static inline bool drm_modeset_disabled(void) { return false; }
 #endif
 
 #endif
-- 
2.33.1

