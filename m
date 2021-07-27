Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A113D7BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhG0RHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhG0RHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:07:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB99C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:07:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a20so16733162plm.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWHAAuOhk3NUAyAh/B2dsoKf1PQoiLne1nY0lFgXP48=;
        b=HuAxCLAcCntmvHPS5xPXkjg85XFoiQAtEot6LSWDBjoxwI2326UscNbdG86m9dU3u6
         oiZoymfKW26Byw/rg6OixHW6lPsWfFVhqw1plyGU5BDCVL24wTVhm3tjU3q9brAyw8fb
         dtDDG1psSkiI/mF0yc7I6JBg6+RCVSIx2WvfYdtPOhFlMRrPtikiIOViLPuFPnCxGcki
         y4pKC1jFP9bejSsHw8VtyOXwe4XB6P9vkc623GvJZhjpr5ah78wk8FIrg6f0wEtWDCrt
         xaIbcahHw+fI4NivXgO3/QNc7MuTWaS0jIGCWps3HD3VYMeKwbtX1GvGKub/8EH08K1+
         3XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWHAAuOhk3NUAyAh/B2dsoKf1PQoiLne1nY0lFgXP48=;
        b=KxNYsvKy2H6PWTQQFoZiA+wKkVWdSBEdsXCBADzghdznszZf5+mqJkI5xjfabxDdDK
         8ZPCgw+S2dGWABwCxNaHTLhROLx/0Hy4jRM29duEX8CsS05yGC/Qo424c3/ok3KQNf5w
         D7ejhBORgX0XPzO++AXopOtfiWddSVJUarLHydFx2hSu4CDwxOQFJEcz9NZC/uFsoeHh
         WW71aRUg9pFJ0DMipJ9oi47SzgD/kS0bym7p3f+7+CssCpWkhj9Gv/TgHvCzg5J1vZmP
         7/SBOmWzYfQa0jdgrbhKnmeNPCK4l4dVagdZxti0Jjue7aRKOsf9cifq/dYNwFUwwfNz
         04tA==
X-Gm-Message-State: AOAM531TML4OvgoA+0JAp7nABcFq0/g5jZbPEZCGf1itPD+MPY+UfCcE
        RgqxkcsLmAmpMPI8BFkL/cs=
X-Google-Smtp-Source: ABdhPJyU60w2Ipm/wjWxUhwrlRU+SS/A8y9U+gaRP8f+ttHRP7zb8Esy7FS8MT3LzNZ9kG7kr7KCVA==
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr4603271pjo.22.1627405669745;
        Tue, 27 Jul 2021 10:07:49 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id 33sm4978043pgs.59.2021.07.27.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:07:48 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/13] drm: Drop drm_gem_object_put_locked()
Date:   Tue, 27 Jul 2021 10:11:20 -0700
Message-Id: <20210727171143.2549475-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210727171143.2549475-1-robdclark@gmail.com>
References: <20210727171143.2549475-1-robdclark@gmail.com>
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

