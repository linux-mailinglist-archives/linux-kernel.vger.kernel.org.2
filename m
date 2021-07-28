Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5493D8503
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhG1BCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhG1BCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:02:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F84C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:02:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso7505463pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWHAAuOhk3NUAyAh/B2dsoKf1PQoiLne1nY0lFgXP48=;
        b=DmyFTtUHoyY/OdcTn4Rclp495TjYNYrswlT9rvrZ47hdEV4Ey/HlabaNLrxU0t9tl/
         v43yGVFMAcPGLhC31pwve3Ue6URK8eLr4DiEHpscDklYfpHfUa3EMgaQS6mCCL3HI/KK
         muewMmPMo3/vCzMGHm2KTPiiphfHSb1UaabxepX6gYwid1VWqdA9m5j28VKJpN4x+yrv
         bSMPF4C0krWTdMa1L2OsodFSxzIzWD7MdxxlZ+WgZ6YVw4ju3kOZtHWy1BbB9FpBvcQy
         rxXHrE52698EY5f1ryVGLW67bjMLL7f7QEFVqxjOEFZNp8YppuurJhpNZsfOMr8LmEnA
         UpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWHAAuOhk3NUAyAh/B2dsoKf1PQoiLne1nY0lFgXP48=;
        b=O5gQvmCb0YiVuEQjDvJOXza7AOkTFIXiv3Y+gmkiDmpwoVv3NCJn64VEBoE77GtjCb
         eQiMPHlVrAOT4BipPQS5BFfLA3g85sZnQV5FqzTgCmy6kisU7m8hS5s9W8Cvl9IjiEE5
         nCr7gRw+TlcqalLq2MAE16Wf6kMkG7w2qJIXG3rhKQiguGKSrWa9TIfm6frIqz25nw/z
         HB/8hptnrysSujU9lRyPwfleboPEITZiUZZGrhsZ5k6NvvxFDBlnD0fJ/MqU0THVR4C2
         DHyFYv9TJAekFg717lv4Tpv0Rul+8DTJc+8SFVbopJDsuos7E//qsfPa4rpi7WobMKF+
         t+Lg==
X-Gm-Message-State: AOAM530MXy0DlA7k9K43MF0DXAU1xAbBOkxvenTnyxVyCLoTswpg15K1
        CgAe4a8aw7vigypcRBLlm7M=
X-Google-Smtp-Source: ABdhPJyvXiFvIYVjvygOXnqPubsO7UO1JJJBiEyYjSdBO23OsM8bU0Mond1RL3SJtOuYc4A2W0MJ9g==
X-Received: by 2002:a17:90a:ea12:: with SMTP id w18mr25376118pjy.103.1627434162969;
        Tue, 27 Jul 2021 18:02:42 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id k8sm4575643pfu.116.2021.07.27.18.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 18:02:41 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 04/13] drm: Drop drm_gem_object_put_locked()
Date:   Tue, 27 Jul 2021 18:06:09 -0700
Message-Id: <20210728010632.2633470-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728010632.2633470-1-robdclark@gmail.com>
References: <20210728010632.2633470-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Now that no one is using it, remove it.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_gem.c | 22 ----------------------
 include/drm/drm_gem.h     |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index d62fb1a3c916..a34525332bef 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -973,28 +973,6 @@ drm_gem_object_free(struct kref *kref)
 }
 EXPORT_SYMBOL(drm_gem_object_free);
 
-/**
- * drm_gem_object_put_locked - release a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This releases a reference to @obj. Callers must hold the
- * &drm_device.struct_mutex lock when calling this function, even when the
- * driver doesn't use &drm_device.struct_mutex for anything.
- *
- * For drivers not encumbered with legacy locking use
- * drm_gem_object_put() instead.
- */
-void
-drm_gem_object_put_locked(struct drm_gem_object *obj)
-{
-	if (obj) {
-		WARN_ON(!mutex_is_locked(&obj->dev->struct_mutex));
-
-		kref_put(&obj->refcount, drm_gem_object_free);
-	}
-}
-EXPORT_SYMBOL(drm_gem_object_put_locked);
-
 /**
  * drm_gem_vm_open - vma->ops->open implementation for GEM
  * @vma: VM area structure
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 240049566592..35e7f44c2a75 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -384,8 +384,6 @@ drm_gem_object_put(struct drm_gem_object *obj)
 		__drm_gem_object_put(obj);
 }
 
-void drm_gem_object_put_locked(struct drm_gem_object *obj);
-
 int drm_gem_handle_create(struct drm_file *file_priv,
 			  struct drm_gem_object *obj,
 			  u32 *handlep);
-- 
2.31.1

