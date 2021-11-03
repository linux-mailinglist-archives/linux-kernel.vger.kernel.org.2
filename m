Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A19444026
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhKCKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhKCKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635936507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nueR7blhl8sG9fui6fCyOgFvdzQ4dBq9rPCsy9D1mvM=;
        b=iezJmUvFl1WWYF+bGEDsj0fLLB4SvJOQynsV3ri9iNoC/3E+GgEnHa9QbCIQkPcbcgSI0v
        kZnQhqRm48zH8wXyaf0SPE43CqRvujhksrZN4ZB3RlSiIfdc0KgLtTqSulzejpKqAFEqcg
        IaZlOXw18asqxQy+qg+lx8NfAOIXfpU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-EvHJqPG4OGuSI_NCPchNuw-1; Wed, 03 Nov 2021 06:48:26 -0400
X-MC-Unique: EvHJqPG4OGuSI_NCPchNuw-1
Received: by mail-wm1-f72.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so854673wmj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nueR7blhl8sG9fui6fCyOgFvdzQ4dBq9rPCsy9D1mvM=;
        b=KJRMM3nGrgKNVBJtuz8TqDsWHwayWjsgEuROJvFqlIah0X/UBvBcWlBIXZB6AHgT5N
         UVVrB0yrQR5ZNYTROtch+qRxATI9s2P4te8g3KCb5yC3bcMpf79fCN0RlV0dTKtF3AHb
         bgO0UV/rMEjej527dlGJwrwxnUYaF2UvDTRTfyj/DTa0gxndh8/UrLK7tNVh+i73bL9S
         A3PflNXHE+ONLkGkfHCq2eZPDn5qnQaJE3q59V0qHYeCKvT3km0Z9MSc58Z7ifWGgngw
         5RbxzFtxPLFzGMgTPXr35Wo1YPAnUf1Aw3GDsFAUq69VIXYm9erlY2wNmuOxGqrQIKl1
         OkPQ==
X-Gm-Message-State: AOAM53137/ez8CFgp4IZCAmWrev48kC4edKj5teNvsMfm2V43YOthc0v
        G7EXd/xt7WQEE8s1galbPtHajzJ+a7zksVg0wq+l3QG8JMJmaydcNUShVqZlu5BuSGKBF9sgHH8
        dTcIet2A6ONgasNGMYPnjR7ICwRC5MDXvVgZLFou6EioWisMeslynT0JZuzquDTzAFyvueRn+2b
        g=
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr13900259wmb.112.1635936504573;
        Wed, 03 Nov 2021 03:48:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9zoPcF4VO7LxwRlLU9SmVPDlazXyfzs51vNZRacAJtg4cBYHx4mLXqDjvmJw+iGqcB5w/sA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr13900213wmb.112.1635936504193;
        Wed, 03 Nov 2021 03:48:24 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f15sm1651555wmg.30.2021.11.03.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:48:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the DRM subsystem
Date:   Wed,  3 Nov 2021 11:48:09 +0100
Message-Id: <20211103104812.1022936-3-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103104812.1022936-1-javierm@redhat.com>
References: <20211103104812.1022936-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "nomodeset" kernel cmdline parameter is handled by the vgacon driver
but the exported vgacon_text_force() symbol is only used by DRM drivers.

It makes much more sense for the parameter logic to be in the subsystem
of the drivers that are making use of it. Let's move that to DRM.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/Makefile                |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +--
 drivers/gpu/drm/ast/ast_drv.c           |  1 -
 drivers/gpu/drm/drm_nomodeset.c         | 26 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_module.c      |  2 --
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  1 -
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  1 -
 drivers/gpu/drm/qxl/qxl_drv.c           |  1 -
 drivers/gpu/drm/radeon/radeon_drv.c     |  1 -
 drivers/gpu/drm/tiny/bochs.c            |  1 -
 drivers/gpu/drm/tiny/cirrus.c           |  1 -
 drivers/gpu/drm/vboxvideo/vbox_drv.c    |  1 -
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 -
 drivers/video/console/vgacon.c          | 21 --------------------
 include/drm/drm_mode_config.h           |  6 ++++++
 include/linux/console.h                 |  6 ------
 17 files changed, 35 insertions(+), 41 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

diff --git drivers/gpu/drm/Makefile drivers/gpu/drm/Makefile
index 1c41156deb5f..0e2d60ea93ca 100644
--- drivers/gpu/drm/Makefile
+++ drivers/gpu/drm/Makefile
@@ -33,6 +33,8 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += drm_privacy_screen.o drm_privacy_screen_x86.
 
 obj-$(CONFIG_DRM_DP_AUX_BUS) += drm_dp_aux_bus.o
 
+obj-y += drm_nomodeset.o
+
 drm_cma_helper-y := drm_gem_cma_helper.o
 obj-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_cma_helper.o
 
diff --git drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c718fb5f3f8a..2680a2aaa877 100644
--- drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -31,7 +31,6 @@
 #include "amdgpu_drv.h"
 
 #include <drm/drm_pciids.h>
-#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
@@ -2515,7 +2514,7 @@ static int __init amdgpu_init(void)
 	int r;
 
 	if (vgacon_text_force()) {
-		DRM_ERROR("VGACON disables amdgpu kernel modesetting.\n");
+		DRM_ERROR("amdgpu kernel modesetting disabled.\n");
 		return -EINVAL;
 	}
 
diff --git drivers/gpu/drm/ast/ast_drv.c drivers/gpu/drm/ast/ast_drv.c
index 86d5cd7b6318..048be607b182 100644
--- drivers/gpu/drm/ast/ast_drv.c
+++ drivers/gpu/drm/ast/ast_drv.c
@@ -26,7 +26,6 @@
  * Authors: Dave Airlie <airlied@redhat.com>
  */
 
-#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
diff --git drivers/gpu/drm/drm_nomodeset.c drivers/gpu/drm/drm_nomodeset.c
new file mode 100644
index 000000000000..1ac9a8d5a8fe
--- /dev/null
+++ drivers/gpu/drm/drm_nomodeset.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+static bool vgacon_text_mode_force;
+
+bool vgacon_text_force(void)
+{
+	return vgacon_text_mode_force;
+}
+EXPORT_SYMBOL(vgacon_text_force);
+
+static int __init text_mode(char *str)
+{
+	vgacon_text_mode_force = true;
+
+	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
+	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
+	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
+
+	return 1;
+}
+
+/* force text mode - used by kernel modesetting */
+__setup("nomodeset", text_mode);
diff --git drivers/gpu/drm/i915/i915_module.c drivers/gpu/drm/i915/i915_module.c
index c7507266aa83..14a59226519d 100644
--- drivers/gpu/drm/i915/i915_module.c
+++ drivers/gpu/drm/i915/i915_module.c
@@ -4,8 +4,6 @@
  * Copyright © 2021 Intel Corporation
  */
 
-#include <linux/console.h>
-
 #include "gem/i915_gem_context.h"
 #include "gem/i915_gem_object.h"
 #include "i915_active.h"
diff --git drivers/gpu/drm/mgag200/mgag200_drv.c drivers/gpu/drm/mgag200/mgag200_drv.c
index 6b9243713b3c..685e766db6a4 100644
--- drivers/gpu/drm/mgag200/mgag200_drv.c
+++ drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -6,7 +6,6 @@
  *          Dave Airlie
  */
 
-#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
diff --git drivers/gpu/drm/nouveau/nouveau_drm.c drivers/gpu/drm/nouveau/nouveau_drm.c
index 1f828c9f691c..029997f50d1a 100644
--- drivers/gpu/drm/nouveau/nouveau_drm.c
+++ drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -22,7 +22,6 @@
  * Authors: Ben Skeggs
  */
 
-#include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git drivers/gpu/drm/qxl/qxl_drv.c drivers/gpu/drm/qxl/qxl_drv.c
index fc47b0deb021..3cd6bd9f059d 100644
--- drivers/gpu/drm/qxl/qxl_drv.c
+++ drivers/gpu/drm/qxl/qxl_drv.c
@@ -29,7 +29,6 @@
 
 #include "qxl_drv.h"
 
-#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
diff --git drivers/gpu/drm/radeon/radeon_drv.c drivers/gpu/drm/radeon/radeon_drv.c
index b74cebca1f89..9b606c1b11ec 100644
--- drivers/gpu/drm/radeon/radeon_drv.c
+++ drivers/gpu/drm/radeon/radeon_drv.c
@@ -31,7 +31,6 @@
 
 
 #include <linux/compat.h>
-#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
diff --git drivers/gpu/drm/tiny/bochs.c drivers/gpu/drm/tiny/bochs.c
index 2ce3bd903b70..04333f78be55 100644
--- drivers/gpu/drm/tiny/bochs.c
+++ drivers/gpu/drm/tiny/bochs.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include <linux/console.h>
 #include <linux/pci.h>
 
 #include <drm/drm_aperture.h>
diff --git drivers/gpu/drm/tiny/cirrus.c drivers/gpu/drm/tiny/cirrus.c
index 4611ec408506..8bd674f0d682 100644
--- drivers/gpu/drm/tiny/cirrus.c
+++ drivers/gpu/drm/tiny/cirrus.c
@@ -16,7 +16,6 @@
  * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
  */
 
-#include <linux/console.h>
 #include <linux/dma-buf-map.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git drivers/gpu/drm/vboxvideo/vbox_drv.c drivers/gpu/drm/vboxvideo/vbox_drv.c
index a6c81af37345..e6d983121d0b 100644
--- drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -7,7 +7,6 @@
  *          Michael Thayer <michael.thayer@oracle.com,
  *          Hans de Goede <hdegoede@redhat.com>
  */
-#include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vt_kern.h>
diff --git drivers/gpu/drm/virtio/virtgpu_drv.c drivers/gpu/drm/virtio/virtgpu_drv.c
index 749db18dcfa2..cd4c170236f1 100644
--- drivers/gpu/drm/virtio/virtgpu_drv.c
+++ drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -27,7 +27,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/console.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/wait.h>
diff --git drivers/gpu/drm/vmwgfx/vmwgfx_drv.c drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index ab9a1750e1df..fcc4b5a7f639 100644
--- drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -25,7 +25,6 @@
  *
  **************************************************************************/
 
-#include <linux/console.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git drivers/video/console/vgacon.c drivers/video/console/vgacon.c
index ef9c57ce0906..d4320b147956 100644
--- drivers/video/console/vgacon.c
+++ drivers/video/console/vgacon.c
@@ -97,30 +97,9 @@ static int 		vga_video_font_height;
 static int 		vga_scan_lines		__read_mostly;
 static unsigned int 	vga_rolled_over; /* last vc_origin offset before wrap */
 
-static bool vgacon_text_mode_force;
 static bool vga_hardscroll_enabled;
 static bool vga_hardscroll_user_enable = true;
 
-bool vgacon_text_force(void)
-{
-	return vgacon_text_mode_force;
-}
-EXPORT_SYMBOL(vgacon_text_force);
-
-static int __init text_mode(char *str)
-{
-	vgacon_text_mode_force = true;
-
-	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
-	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
-	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
-
-	return 1;
-}
-
-/* force text mode - used by kernel modesetting */
-__setup("nomodeset", text_mode);
-
 static int __init no_scroll(char *str)
 {
 	/*
diff --git include/drm/drm_mode_config.h include/drm/drm_mode_config.h
index 48b7de80daf5..e1d2042a7b77 100644
--- include/drm/drm_mode_config.h
+++ include/drm/drm_mode_config.h
@@ -969,4 +969,10 @@ static inline int drm_mode_config_init(struct drm_device *dev)
 void drm_mode_config_reset(struct drm_device *dev);
 void drm_mode_config_cleanup(struct drm_device *dev);
 
+#ifdef CONFIG_VGA_CONSOLE
+extern bool vgacon_text_force(void);
+#else
+static inline bool vgacon_text_force(void) { return false; }
+#endif
+
 #endif
diff --git include/linux/console.h include/linux/console.h
index 20874db50bc8..d4dd8384898b 100644
--- include/linux/console.h
+++ include/linux/console.h
@@ -217,12 +217,6 @@ extern atomic_t ignore_console_lock_warning;
 #define VESA_HSYNC_SUSPEND      2
 #define VESA_POWERDOWN          3
 
-#ifdef CONFIG_VGA_CONSOLE
-extern bool vgacon_text_force(void);
-#else
-static inline bool vgacon_text_force(void) { return false; }
-#endif
-
 extern void console_init(void);
 
 /* For deferred console takeover */
-- 
2.33.1

