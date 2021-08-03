Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC93DF8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhHCXuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhHCXuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:50:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A66BC061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:49:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so228529wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9aJyKI6YNxJhGghb1OCNWhAUVytbZm5nZLNA+zRGmo=;
        b=HMiWUG5p/PReQkhk2TWfiuzhycTflQRt+XbtzhSdBQOAXjXNFZkY2QBRWj/rDt0hGr
         xymu6ZG8dQBffwPdiGz5aQPS75BxEF2sR37w24d/IxGFF34oFuMnVxH4Y8HIvCjYeYmC
         hhd7F2PSXoohScS+HvrpKMPzXLZRq4B/qgE1DHglJwUpP0gyq5ZVgua7V4Lw6FG00x2w
         qYOlYZVBeTPFwCyR3gAAW0usFbAl5nZ17ZjGTn9teOd2DP5zdb51lMif1TnrB0nyzXVt
         Gq3OoeYnK28a60z/KzutNjohTg33kIMyf3o8q7ac030177vISZytNadyIM6enNbqWCJf
         9T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9aJyKI6YNxJhGghb1OCNWhAUVytbZm5nZLNA+zRGmo=;
        b=hMU8qJQm8TV69w0CEiX3SEkpuEgLA9DFK70sEKxZOwknQgFeR+AuXZAtK7l/iW4CwD
         SNYv1BljwYvYqVZNmGU/l3qe/8xIMZcz6nJzwKqc07YgHnw+KM04kOLU5IeOL4ELBxtu
         cqGetGOVm3bBDjLBvlWVNdbemUbfx4fxAr41N5cnNV78vBnM3IjaI5Dsg3nvvWiTqUrb
         9Cgf6mXwDRiqUNUdVDEDZSfh4txfrb06jTFCivDColcuYNwCt/h2T1kJXorvYL/oBhNb
         M5f8HQ4UQagS1ajgVB5IW0tmFSQF/bojj+/1joEpJ8REXtt8Le8pbJ03rh0rs0SHcaHT
         eaSA==
X-Gm-Message-State: AOAM533TEGJ2Z7ejS6xZjRxABK7HvZG3b2EfVJVXrpasi1AUlLJqQePm
        aLIRUeHXR3jr5O6kyYTXuBE=
X-Google-Smtp-Source: ABdhPJzLy6gJManOGjC0HalkHJ2tahVWa4dunJhBJeoqFr92Yq+lnWCmsFl2AHRzq/kCfkJSBj3EeQ==
X-Received: by 2002:a5d:6442:: with SMTP id d2mr25882894wrw.425.1628034586651;
        Tue, 03 Aug 2021 16:49:46 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
        by smtp.gmail.com with ESMTPSA id j140sm406780wmj.37.2021.08.03.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:49:46 -0700 (PDT)
From:   "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
To:     airlied@linux.ie
Cc:     nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] DRM: amd: amdgpu: Fixed code style and removed unnecessary if statement
Date:   Wed,  4 Aug 2021 01:49:44 +0200
Message-Id: <20210803234944.142154-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file didn't follow the code style so it was changed. The "if" statement
checked if the framebuffer was initialized was also changed since that
condition is unlikely to happen. An unnecessary "if" was removed too since it
didn't execute any code if the condition was met.

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 09b048647523..d2ab07eb00fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -42,15 +42,16 @@
 #include "amdgpu_display.h"
 
 /* object hierarchy -
-   this contains a helper + a amdgpu fb
-   the helper contains a pointer to amdgpu framebuffer baseclass.
-*/
+ * this contains a helper + a amdgpu fb
+ * the helper contains a pointer to amdgpu framebuffer baseclass.
+ */
 
 static int
 amdgpufb_open(struct fb_info *info, int user)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	int ret = pm_runtime_get_sync(fb_helper->dev->dev);
+
 	if (ret < 0 && ret != -EACCES) {
 		pm_runtime_mark_last_busy(fb_helper->dev->dev);
 		pm_runtime_put_autosuspend(fb_helper->dev->dev);
@@ -182,9 +183,8 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 
 	ret = amdgpu_bo_kmap(abo, NULL);
 	amdgpu_bo_unreserve(abo);
-	if (ret) {
+	if (ret)
 		goto out_unref;
-	}
 
 	*gobj_p = gobj;
 	return 0;
@@ -233,7 +233,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
 					 &mode_cmd, gobj);
-	if (ret) {
+	if (unlikely(ret)) {
 		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
 		goto out;
 	}
@@ -258,7 +258,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
 
-	if (info->screen_base == NULL) {
+	if (unlikely(info->screen_base == NULL)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -273,9 +273,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	return 0;
 
 out:
-	if (abo) {
-
-	}
 	if (fb && ret) {
 		drm_gem_object_put(gobj);
 		drm_framebuffer_unregister_private(fb);
-- 
2.32.0

