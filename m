Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC323CC624
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 22:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhGQU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbhGQU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 16:28:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B7C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 13:25:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y4so14236687pgl.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cpu/JXcQKTfGv+/P4wjqVns0dJiJutHghvO5fiTylFw=;
        b=SKchqjYpnhWqYce+ZM8vBpYTL8UUHhB3i8icGIUJcuaxCNqWQQcFTnoUr8flGM/232
         HkOxeqfslU7kvDft6DFVZ4UF91lrIc2/nb9B/1kpqDJjxvK3Unp0itEIVlQAw+IoYXfK
         qTP0ik3gKwmexsYt4bm279OyJKQHoJH6Iy4M9BE0TNCd7jTmFSwcDdy/XnhuR09sHIGZ
         JNB7XlYy8T7zxdc4+mu8PP43vrYFXSrVCF+7YZ0sR4KD/8nYKErSD6aGt66mRqLvCciR
         5dknzXqQKEVUrraXAWp+K/0FxelryRUuUhmnn73paKkdgckZ4VoqcmoY1ZDBxb2rDcDP
         yu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cpu/JXcQKTfGv+/P4wjqVns0dJiJutHghvO5fiTylFw=;
        b=UyyfGF9O3/SUjtuvFrEqOm6L+jBlTp34Ux+NZA3tfd4DlFTjoX+xpH7nRdbYOenH4L
         5i+By1PAIjmO+vSJeybwdJPk6CIfYsIDtStc0zSYLk1DSxKnUmhFEHI9Wm6bcSOTkBHV
         NCnMYGmJdle0zPX6+KZc6IWxKNk7ToIefb9NIcZn9vmmmibvpNkQj4rREyvh2o3NJb+z
         wAEzqnhm852Iu0TuPRSFqKPWGuKtkW21iG5L+Dg2XfRXSkCVNwRGKQqZ0zK+74hEEI74
         AjwutgtJpa4L/M3JxstAUJBAiqs2gbeMeAuyaY7rk1SBVUYm7NE9BYiGYAatwUZF11Bu
         dQfw==
X-Gm-Message-State: AOAM532h8HDpvMMYB3hqhvC+c057xVGeGpz98rLqmFjhZLNr7B8FNkih
        FkVdjQMBhlS5c45z1F989sc=
X-Google-Smtp-Source: ABdhPJxPGfbeZkXZO9yaxHD9xyVvR4MtcykxFtJLF8TY8HMqasAjFB/Goyt3keWPdHn07/3qnxpFhQ==
X-Received: by 2002:a62:3542:0:b029:332:c821:1ef3 with SMTP id c63-20020a6235420000b0290332c8211ef3mr16819007pfa.33.1626553533753;
        Sat, 17 Jul 2021 13:25:33 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id i18sm14869351pfa.149.2021.07.17.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 13:25:32 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/11] drm: Drop drm_gem_object_put_locked()
Date:   Sat, 17 Jul 2021 13:29:06 -0700
Message-Id: <20210717202924.987514-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210717202924.987514-1-robdclark@gmail.com>
References: <20210717202924.987514-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Now that no one is using it, remove it.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_gem.c | 22 ----------------------
 include/drm/drm_gem.h     |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 9989425e9875..c8866788b761 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -974,28 +974,6 @@ drm_gem_object_free(struct kref *kref)
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

