Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881203BE599
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGGJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhGGJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:32:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:29:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j16-20020a05600c1c10b0290204b096b0caso1226323wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75Pe442XC795Mqdr0FOm/MJqYS49oNNUGmzmyZjAfj0=;
        b=BsiXJR/IH7T46e76s5Jz5X55HfJDMF/kIqyE2XkUxOtlboAbOXALx6iCV9To1S1NuE
         E5n+yL4yLsPBe4XkPaDLky9oxtLSxbmP30Ns5CiQX1EWUu3KNznS/2ZozwDnHRHfsZBs
         awIdQLN4DQIkEH01GtKNK/sCmBhuSLgO28cXpuj+IdMcmMWYAilGGm+Ivc4dCd9tUuBi
         kAb6aJXjGBkwjzpMXJACjlT/P7KOFhCo+ZG3bE2/wKsNJUy/Ak1PIKjhAvLA0CrMULYq
         aq+QEbrRIE5VoKP3vriGLIoxUsvE0jP1KQ98IlEHUGKj3aYW71147DMVVAqVQjJJ6LL0
         sVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75Pe442XC795Mqdr0FOm/MJqYS49oNNUGmzmyZjAfj0=;
        b=jW/ejyKUi/BtBtGs6ia2zPJsPGU2yRaObwpsp1aeIsHbmiNL17I+zF9yjoFlNV29RT
         f8AxwR7XST1d0Bu1oHIhhO0N6DgDLpz7PKXxtO79yWyhYwJZrbpbyfoXK0WzSo/+mGNW
         Qg9zy+f1U6z0/+/J+i32D5Nc+fijFWismESBd5H8jGJWfl0v6FObnkoSX4H747rM50aZ
         vl8g1A6aNVhoz1lzTru0Qnhbf1+RRdg/XJ0c0euBM6LbphmSKT7W40HZl4JTb5zwCy0i
         Ql5dPnOeES8VO759xeFI7pi6zM4xyVndYt6GIQdNhT/oKLvDmpLBST+HG1I+bWJaj/ta
         hQ6A==
X-Gm-Message-State: AOAM5314G9C8OtMJEmWpsdyLKI12iRmWcaShTVIgrs5NcRSdX0AUDWZx
        yrK5r8DohNAT1R9CO6MrziY=
X-Google-Smtp-Source: ABdhPJwJwKjnRHQl4w3t4ovGmdFFDfMRh8B4we/tAzj3xjGSsC/E8WlN4rbFg4rVa9KxvNPYiAg8ew==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr26481954wmq.169.1625650168814;
        Wed, 07 Jul 2021 02:29:28 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:a4f0:53c4:7466:d06e])
        by smtp.gmail.com with ESMTPSA id z11sm5424140wru.65.2021.07.07.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 02:29:28 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     melissa.srw@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vkms: Create vkms_config_debufs in vkms_drv.c
Date:   Wed,  7 Jul 2021 10:29:27 +0100
Message-Id: <20210707092927.336244-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Development vkms_config_debufs in vkms_drv.c for the long term plan of
making vkms configurable and have multiple different instances it's
useful to be able to get at the config of each instance in debugfs

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
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

