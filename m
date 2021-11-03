Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C8444036
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKCK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhKCK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635936910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+XdS5d9m1YWB/4CDdTEFocUCY9ue1cwW8/9+csJIS5c=;
        b=a0Cd64ukV85b/kfbKWpFXi5/flLYgusWLHPSWfowVnTGMlBi8VLBW/rfgEptu/je+gxHT5
        9QtnDXTth+925HKc66eMN0RVwGhUPZCkV7ir2ltgs9/8k5asX4PnlHaAcD1oMgLGLIBt9a
        Gm22paygxTlyoC3igbE7d+ItKPG5poQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-LcbNrNMmPm-ymenvFRquDA-1; Wed, 03 Nov 2021 06:55:09 -0400
X-MC-Unique: LcbNrNMmPm-ymenvFRquDA-1
Received: by mail-wr1-f69.google.com with SMTP id c4-20020adfed84000000b00185ca4eba36so350474wro.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XdS5d9m1YWB/4CDdTEFocUCY9ue1cwW8/9+csJIS5c=;
        b=sv9wjIiRwDg3a/7loN8ygAca00NzGMtMhNo4tkyZn1han8S4JNypvRBOpISgZIcUN+
         bLUV9HB2EW6JR7/mXQWQIUUhq7x9snWOmDwjbWLSQnPvQUX14yBsLQGMdI0hy/3tnEeK
         RL4hNi2RN+CfT3JXfvWO5O3ZGZ9Af+pGvFXrzmqbjezKsKF0Sc4n6KGr+SvqWgsDLT8x
         xm+AYPXOBW9CkGBZgsL8W5wEzleePSq8xpXebnNEbmQCnoORYbPOF6/b/XNVTbunV26+
         m8g2yiN3aLBYctG9US5Ul2DERVYkbMaSo2c+CUnGLPoyELFtkoOzMvsHnDc8cRm25OcD
         Tu5Q==
X-Gm-Message-State: AOAM531U4AfijoOIXUPklNxTf79OVbD4ZyAfUL95oiq3GHO/F5C9aQTN
        cRSrI468ty9r1B2YbXCD2qsALR6bD5nADMt3W9fkD5qo7b8J34Ek8YHJyYJZ4L5zkwXv633aWAe
        100v2H9k9jWrfEVlaHjUhv+993tju8trHydoyX39iJ8DANRwc6/xAzmgMFFXiDmBne4tupqlZex
        4=
X-Received: by 2002:a5d:5888:: with SMTP id n8mr11264636wrf.234.1635936906688;
        Wed, 03 Nov 2021 03:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZlyfbV7WJ9xvcIGyWoIQTVilMG8Q47GoC9yWruFo3I4itHfnwkLqLyWeNYn1OC/XpbIdl2A==
X-Received: by 2002:a5d:5888:: with SMTP id n8mr11264601wrf.234.1635936906447;
        Wed, 03 Nov 2021 03:55:06 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q8sm1578777wrx.71.2021.11.03.03.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:55:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 5/5] drm: Use drm_drv_enabled() instead of drm_modeset_disabled()
Date:   Wed,  3 Nov 2021 11:54:50 +0100
Message-Id: <20211103105450.1024328-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is a helper function to check whether or not a DRM driver
should be enabled, use that instead of calling to drm_modeset_disabled().

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/ast/ast_drv.c           | 2 +-
 drivers/gpu/drm/i915/i915_module.c      | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_drv.c   | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 2 +-
 drivers/gpu/drm/qxl/qxl_drv.c           | 2 +-
 drivers/gpu/drm/radeon/radeon_drv.c     | 2 +-
 drivers/gpu/drm/tiny/bochs.c            | 2 +-
 drivers/gpu/drm/tiny/cirrus.c           | 2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c    | 2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c    | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 2 +-
 12 files changed, 14 insertions(+), 12 deletions(-)

diff --git drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f7bd2616cf23..47e0c21bb0e8 100644
--- drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2513,7 +2513,7 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (drm_modeset_disabled()) {
+	if (!drm_drv_enabled(&amdgpu_kms_driver)) {
 		DRM_ERROR("amdgpu kernel modesetting disabled.\n");
 		return -EINVAL;
 	}
diff --git drivers/gpu/drm/ast/ast_drv.c drivers/gpu/drm/ast/ast_drv.c
index 6706050414c3..177537647531 100644
--- drivers/gpu/drm/ast/ast_drv.c
+++ drivers/gpu/drm/ast/ast_drv.c
@@ -232,7 +232,7 @@ static struct pci_driver ast_pci_driver = {
 
 static int __init ast_init(void)
 {
-	if (drm_modeset_disabled() && ast_modeset == -1)
+	if (!drm_drv_enabled(&ast_driver) && ast_modeset == -1)
 		return -EINVAL;
 
 	if (ast_modeset == 0)
diff --git drivers/gpu/drm/i915/i915_module.c drivers/gpu/drm/i915/i915_module.c
index 3e5531040e4d..6cba45bbcbc9 100644
--- drivers/gpu/drm/i915/i915_module.c
+++ drivers/gpu/drm/i915/i915_module.c
@@ -16,6 +16,8 @@
 #include "i915_selftest.h"
 #include "i915_vma.h"
 
+static const struct drm_driver driver;
+
 static int i915_check_nomodeset(void)
 {
 	bool use_kms = true;
@@ -29,7 +31,7 @@ static int i915_check_nomodeset(void)
 	if (i915_modparams.modeset == 0)
 		use_kms = false;
 
-	if (drm_modeset_disabled() && i915_modparams.modeset == -1)
+	if (!drm_drv_enabled(&driver) && i915_modparams.modeset == -1)
 		use_kms = false;
 
 	if (!use_kms) {
diff --git drivers/gpu/drm/mgag200/mgag200_drv.c drivers/gpu/drm/mgag200/mgag200_drv.c
index 7ee87564bade..100c958e3c90 100644
--- drivers/gpu/drm/mgag200/mgag200_drv.c
+++ drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -377,7 +377,7 @@ static struct pci_driver mgag200_pci_driver = {
 
 static int __init mgag200_init(void)
 {
-	if (drm_modeset_disabled() && mgag200_modeset == -1)
+	if (!drm_drv_enabled(&mgag200_driver) && mgag200_modeset == -1)
 		return -EINVAL;
 
 	if (mgag200_modeset == 0)
diff --git drivers/gpu/drm/nouveau/nouveau_drm.c drivers/gpu/drm/nouveau/nouveau_drm.c
index 903d0e626954..db7168a9d0f1 100644
--- drivers/gpu/drm/nouveau/nouveau_drm.c
+++ drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1321,7 +1321,7 @@ nouveau_drm_init(void)
 	nouveau_display_options();
 
 	if (nouveau_modeset == -1) {
-		if (drm_modeset_disabled())
+		if (!drm_drv_enabled(&driver_stub))
 			nouveau_modeset = 0;
 	}
 
diff --git drivers/gpu/drm/qxl/qxl_drv.c drivers/gpu/drm/qxl/qxl_drv.c
index e4ab16837fad..f03000bf32be 100644
--- drivers/gpu/drm/qxl/qxl_drv.c
+++ drivers/gpu/drm/qxl/qxl_drv.c
@@ -294,7 +294,7 @@ static struct drm_driver qxl_driver = {
 
 static int __init qxl_init(void)
 {
-	if (drm_modeset_disabled() && qxl_modeset == -1)
+	if (!drm_drv_enabled(&qxl_driver) && qxl_modeset == -1)
 		return -EINVAL;
 
 	if (qxl_modeset == 0)
diff --git drivers/gpu/drm/radeon/radeon_drv.c drivers/gpu/drm/radeon/radeon_drv.c
index 36c8dac68cca..e17a1cd23933 100644
--- drivers/gpu/drm/radeon/radeon_drv.c
+++ drivers/gpu/drm/radeon/radeon_drv.c
@@ -636,7 +636,7 @@ static struct pci_driver radeon_kms_pci_driver = {
 
 static int __init radeon_module_init(void)
 {
-	if (drm_modeset_disabled() && radeon_modeset == -1) {
+	if (!drm_drv_enabled(&kms_driver) && radeon_modeset == -1) {
 		DRM_INFO("VGACON disable radeon kernel modesetting.\n");
 		radeon_modeset = 0;
 	}
diff --git drivers/gpu/drm/tiny/bochs.c drivers/gpu/drm/tiny/bochs.c
index 59189f7c1840..dab3ca37dddb 100644
--- drivers/gpu/drm/tiny/bochs.c
+++ drivers/gpu/drm/tiny/bochs.c
@@ -718,7 +718,7 @@ static struct pci_driver bochs_pci_driver = {
 
 static int __init bochs_init(void)
 {
-	if (drm_modeset_disabled() && bochs_modeset == -1)
+	if (!drm_drv_enabled(&bochs_driver) && bochs_modeset == -1)
 		return -EINVAL;
 
 	if (bochs_modeset == 0)
diff --git drivers/gpu/drm/tiny/cirrus.c drivers/gpu/drm/tiny/cirrus.c
index fcf98379c641..48e2a9509722 100644
--- drivers/gpu/drm/tiny/cirrus.c
+++ drivers/gpu/drm/tiny/cirrus.c
@@ -635,7 +635,7 @@ static struct pci_driver cirrus_pci_driver = {
 
 static int __init cirrus_init(void)
 {
-	if (drm_modeset_disabled())
+	if (!drm_drv_enabled(&cirrus_driver))
 		return -EINVAL;
 	return pci_register_driver(&cirrus_pci_driver);
 }
diff --git drivers/gpu/drm/vboxvideo/vbox_drv.c drivers/gpu/drm/vboxvideo/vbox_drv.c
index 09356dbd69b2..daa53ec1b517 100644
--- drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -192,7 +192,7 @@ static const struct drm_driver driver = {
 
 static int __init vbox_init(void)
 {
-	if (drm_modeset_disabled() && vbox_modeset == -1)
+	if (!drm_drv_enabled(&driver) && vbox_modeset == -1)
 		return -EINVAL;
 
 	if (vbox_modeset == 0)
diff --git drivers/gpu/drm/virtio/virtgpu_drv.c drivers/gpu/drm/virtio/virtgpu_drv.c
index d96797d70fae..2f3d4d010b16 100644
--- drivers/gpu/drm/virtio/virtgpu_drv.c
+++ drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -103,7 +103,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	struct drm_device *dev;
 	int ret;
 
-	if (drm_modeset_disabled() && virtio_gpu_modeset == -1)
+	if (!drm_drv_enabled(&driver) && virtio_gpu_modeset == -1)
 		return -EINVAL;
 
 	if (virtio_gpu_modeset == 0)
diff --git drivers/gpu/drm/vmwgfx/vmwgfx_drv.c drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 22dab9beea03..969c765ef146 100644
--- drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1650,7 +1650,7 @@ static int __init vmwgfx_init(void)
 {
 	int ret;
 
-	if (drm_modeset_disabled())
+	if (!drm_drv_enabled(&driver))
 		return -EINVAL;
 
 	ret = pci_register_driver(&vmw_pci_driver);
-- 
2.33.1

