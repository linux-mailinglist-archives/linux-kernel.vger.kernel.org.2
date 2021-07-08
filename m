Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E713BF780
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhGHJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhGHJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:22:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD11C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 02:20:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p8so6652861wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8wOYuGgW5dxV41LrFT+/grkfGnQ13pyFW8oHR7OIZw=;
        b=IWXWukGJ+sYxiBpJibUmxHiqApl6N+DEulPAvNQ/b2VL/rwieZfZp75c0X7vLZ7TJ3
         0g5Gf6cVNpOGW+gR1Syy7MbfuG+hTjErP9dwW+0H51UwTQ8mi0v1L849+pmDSzTTVqkJ
         hooulS78YJSUBUtnvAqCwO/nCq8PKrJbic1qTpunf0ly+mWpOHPgqYlA4r+2PvgJSSNT
         O62eIYPcVRZYNb0NiuUCihI1ETeyo5JJyO2ju4/y0YmS9tss/tGaKGIM2EFtHWwbBkY+
         LhU94BKNnWJgSAYBqhwsy1iWmpPaDgrZv62rUaPsJxbiXdoGEevvKIIT4MOm64D/R8/p
         np+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8wOYuGgW5dxV41LrFT+/grkfGnQ13pyFW8oHR7OIZw=;
        b=fHCmA1eLKvIXn/cRbhSn2Veo8aayCszWpUswAz4DDOIroGvEXUuCXk9C/GSFIna/n2
         26kNEtKj1WntRBfB4nLx+2U06s8KmdCczOG9+2kbmRXT1yh0imFSbs0duK8OmLqJ20+q
         FzZFPpI/0f/gXfM+LrlQPOnGYb+xdS9fp6kavwohRSZrMlWhwiV6zj2dAQDno7d/yxu6
         71rBDaMF1tiFbkllbtF9xOVSp67uT8c3kIL2RwF/uTcNyjwNBCtOzPML2gnydGF1c3WP
         OVE6qlM6nYxkTDS3Sj3yxT37cFuADH8YVg+hs+Kfse5TSAsQSW9n7+Wwu2gTQuJb/vPZ
         mj4g==
X-Gm-Message-State: AOAM530N9vrIQstFLwLBvwB4prAuhCKQN8zTkJMCFcCDZMD/VOAuJSmF
        zBJ5v5WObjpxCcmJGZlv6Vs=
X-Google-Smtp-Source: ABdhPJzeCR07d1y8gCpicm/rcIXFt9UWWOn6W0Tb2/O83UCOlBFXjE1O5HjKURZbqEnAIZvYGAJdeg==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr32765405wrv.323.1625736004038;
        Thu, 08 Jul 2021 02:20:04 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:4d1a:56e6:44c6:5764])
        by smtp.gmail.com with ESMTPSA id y11sm5594308wmi.33.2021.07.08.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 02:20:03 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/vkms: Creating a debug file to get/track vkms config in vkms_drv.c
Date:   Thu,  8 Jul 2021 10:20:02 +0100
Message-Id: <20210708092002.11847-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating a vkms_config_debufs file in vkms_drv.c to get/track vkms config
data, for the long-term plan of making vkms configurable and have multiple
different instances.

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>
Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
Changes in v2:
    - corrected subject to make clear in terms of its purpose
    - corrected commit message
---
 drivers/gpu/drm/vkms/vkms_drv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 027ffe759440..c81fba6c72f0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -28,6 +28,9 @@
 
 #include "vkms_drv.h"
 
+#include <drm/drm_print.h>
+#include <drm/drm_debugfs.h>
+
 #define DRIVER_NAME	"vkms"
 #define DRIVER_DESC	"Virtual Kernel Mode Setting"
 #define DRIVER_DATE	"20180514"
@@ -86,12 +89,37 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_cleanup_planes(dev, old_state);
 }
 
+static int vkms_config_show(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+
+	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
+	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
+	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+
+	return 0;
+}
+
+static const struct drm_info_list vkms_config_debugfs_list[] = {
+	{ "vkms_config", vkms_config_show, 0 },
+};
+
+static void vkms_config_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(vkms_config_debugfs_list, ARRAY_SIZE(vkms_config_debugfs_list),
+				 minor->debugfs_root, minor);
+}
+
 static const struct drm_driver vkms_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
 	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 
+	.debugfs_init           = vkms_config_debugfs_init,
+
 	.name			= DRIVER_NAME,
 	.desc			= DRIVER_DESC,
 	.date			= DRIVER_DATE,
-- 
2.25.1

