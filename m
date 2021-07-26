Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C973D5C55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhGZOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhGZOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:16:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F337C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:56:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso11681923pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mpo+wl5fFAaPwy9LhhWqMdEGPZHP7/RgunVOfmhcQvA=;
        b=m+xar5oljPu5b7j1i+Pnq36g4tJO/HABAejzytqbbTTAAr5Er089Rs9dCuiMpOsnvr
         A83/KtP9V4mX0EGZNOTvPz8o/jZgswQidJkFjGISCJljbPMyPsKsB08DiMU7tcTxoyQV
         vp12ETq4ELVeiFlEijR02lfCzsaXtXJRvVl/qTq+6D7Fz+Qm6owWAcwXOUXxTUM/yUFx
         lLWxCUjwfcl0FTJD1pm6CXmnAp1WpS52Y6JvekAYO1RkARlSNFpAMQwuWowAUkVOPuiZ
         v7LrZjWd3wQCe1aI1ci8jcJVCGGZIfe/6jrWnf+fZQOU24iuNcJdzSDqweKwFQ7YQntd
         ChgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mpo+wl5fFAaPwy9LhhWqMdEGPZHP7/RgunVOfmhcQvA=;
        b=LSzXCsqgyCM85S1fghrb/i5MmrEdn7akdxUGtNcJeGNoZ3WpkRf8qV8mw/Y2D9AK8N
         1lQHnbdn0EG/9b2qNsFUzI0NasdmF3icHfsmS3O3su6cRe4ue2eqtyXF3LxSSW4uA/MB
         rNawPrtRze4etTzeeffuEEstf2W2FxinkSnfeSQqW4aC/YphHNHaUbVKvF97EKLtGpTy
         gchqyZrJvpAuluK1l7dHkyC+EGyX6jJDAMiS10JKkmfntGvQwyp5GFKZl3mqamMoZ7BL
         NESXPnk2rqD3sgoTwR+/RpLLoZBUFzJ7VeAvqfdHL3Ilv1J9amDf7EJx/6yCR52xYvve
         nU9w==
X-Gm-Message-State: AOAM533n95BUPU26R3HOloZKvRnBCChNadGSeZZWRWQJ4FqwUfgkzTBQ
        sjQx5GH9x8KyHMf6/fR4kDA=
X-Google-Smtp-Source: ABdhPJzV0hJboRK/ViXBzFZMeD86kD6NbVVHPyQfPoyu+yBjPb9rek/658SULrll+AaDkwO+QlV6xA==
X-Received: by 2002:a65:40c6:: with SMTP id u6mr18965527pgp.390.1627311402803;
        Mon, 26 Jul 2021 07:56:42 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id s7sm268020pfk.12.2021.07.26.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:56:41 -0700 (PDT)
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
Subject: [PATCH v2 04/12] drm: Drop drm_gem_object_put_locked()
Date:   Mon, 26 Jul 2021 08:00:18 -0700
Message-Id: <20210726150038.2187631-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726150038.2187631-1-robdclark@gmail.com>
References: <20210726150038.2187631-1-robdclark@gmail.com>
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

