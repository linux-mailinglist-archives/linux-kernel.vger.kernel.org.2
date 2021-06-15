Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2952B3A7463
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFOCvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhFOCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:51:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F062C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:49:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t140so16627266oih.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mB54G1f2BMqsk/PpgeMUBY34ptNTL2FTGaPiB4Yuzg=;
        b=JzJ8Iuxsx3z0run2VPvrs1YOCVAzy6p5rjt9trA8nj1oMCeAxaymq8i1lqihTyDhND
         q6K1IHpI/90SVIdLxLBFQPB0ZMPoM6zrIos9JGmck2Ji0fNnP/Ps+D6Cv4gh9ZItgNGv
         P09JhtSZzvWj89m1762Z9KXmlYdtsJbgqbvquBWdVPzrcSqlS6eyBOlANiSOis6c+73l
         Fh0ObkTayhLnCBkqp5P7WimHEIscsVqu2tWE9BZseZtEFMRT5FEdEcDhN2Fef0LS2gou
         D6efwLz6SxohFFRI6dPeGQL/dZ6TgP5AL6jbsLcSMQFnZ1lmI0aWkQFHZNVL8FOmmPuH
         0wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mB54G1f2BMqsk/PpgeMUBY34ptNTL2FTGaPiB4Yuzg=;
        b=cdkPYXvZ2Xn46/PIRzbElaLh+RdxTOuQIhGxadvKQy6jkDOalcD6GunCKGwXe+Pver
         4R9lF5d69ApKfkuZqrPkIdLRrBMt/Exzofm1pKjzYwHFtjtsVss6d8gGBFRq0Zfu1Ov+
         ALDwVQV8fJYRuac0+ZfoWdu2QMLFxbjAZndG7FSaecPkV9/6y7/El7+9kl8RAx251wUY
         EsWQFjrlfQgQdP1NrsmfR0NFvdSp/WtGyc77n6aeUnxJp2wkSt5PK9XR+rLh5k6PNJcb
         fSdLmhwiiGklDgruyY+0mGkgX6fColt10eyG7u6wwmMxT4jvFuPvANRrwLGxtcRjo72g
         fJjQ==
X-Gm-Message-State: AOAM531+9Jdr0kMOBhYmqI/ywvUi1STKqvQ4Bozvk/Sd9plvC6gAX6CH
        1bxs6YlFMsqM+ndLSqXVOcFypS/YFXUHPKEzO4E=
X-Google-Smtp-Source: ABdhPJwKHBPhRor0uBHBiT3Sc9lmWQ4R/sBqLW16QjtJF3wH74+3EGUShH6H4OB2pSMYnNl6znN5ag==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr2445346pjq.55.1623724747504;
        Mon, 14 Jun 2021 19:39:07 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id b133sm14102623pfb.36.2021.06.14.19.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 19:39:07 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 2/2] drm: Protect drm_master pointers in drm_lease.c
Date:   Tue, 15 Jun 2021 10:36:45 +0800
Message-Id: <20210615023645.6535-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615023645.6535-1-desmondcheongzx@gmail.com>
References: <20210615023645.6535-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that the device's master mutex is acquired before
accessing pointers to struct drm_master that are subsequently
dereferenced. Without the mutex, the struct drm_master may be freed
concurrently by another process calling drm_setmaster_ioctl(). This
could then lead to use-after-free errors.

Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/gpu/drm/drm_lease.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index da4f085fc09e..3e6f689236e5 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -107,10 +107,16 @@ static bool _drm_has_leased(struct drm_master *master, int id)
  */
 bool _drm_lease_held(struct drm_file *file_priv, int id)
 {
+	bool ret;
+
 	if (!file_priv || !file_priv->master)
 		return true;
 
-	return _drm_lease_held_master(file_priv->master, id);
+	mutex_lock(&file_priv->master->dev->master_mutex);
+	ret = _drm_lease_held_master(file_priv->master, id);
+	mutex_unlock(&file_priv->master->dev->master_mutex);
+
+	return ret;
 }
 
 /**
@@ -132,10 +138,12 @@ bool drm_lease_held(struct drm_file *file_priv, int id)
 	if (!file_priv || !file_priv->master || !file_priv->master->lessor)
 		return true;
 
+	mutex_lock(&file_priv->master->dev->master_mutex);
 	master = file_priv->master;
 	mutex_lock(&master->dev->mode_config.idr_mutex);
 	ret = _drm_lease_held_master(master, id);
 	mutex_unlock(&master->dev->mode_config.idr_mutex);
+	mutex_unlock(&file_priv->master->dev->master_mutex);
 	return ret;
 }
 
@@ -158,6 +166,7 @@ uint32_t drm_lease_filter_crtcs(struct drm_file *file_priv, uint32_t crtcs_in)
 	if (!file_priv || !file_priv->master || !file_priv->master->lessor)
 		return crtcs_in;
 
+	mutex_lock(&file_priv->master->dev->master_mutex);
 	master = file_priv->master;
 	dev = master->dev;
 
@@ -177,6 +186,7 @@ uint32_t drm_lease_filter_crtcs(struct drm_file *file_priv, uint32_t crtcs_in)
 		count_in++;
 	}
 	mutex_unlock(&master->dev->mode_config.idr_mutex);
+	mutex_unlock(&file_priv->master->dev->master_mutex);
 	return crtcs_out;
 }
 
@@ -490,7 +500,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	size_t object_count;
 	int ret = 0;
 	struct idr leases;
-	struct drm_master *lessor = lessor_priv->master;
+	struct drm_master *lessor;
 	struct drm_master *lessee = NULL;
 	struct file *lessee_file = NULL;
 	struct file *lessor_file = lessor_priv->filp;
@@ -502,12 +512,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
-	/* Do not allow sub-leases */
-	if (lessor->lessor) {
-		DRM_DEBUG_LEASE("recursive leasing not allowed\n");
-		return -EINVAL;
-	}
-
 	/* need some objects */
 	if (cl->object_count == 0) {
 		DRM_DEBUG_LEASE("no objects in lease\n");
@@ -519,12 +523,23 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&dev->master_mutex);
+	lessor = lessor_priv->master;
+	/* Do not allow sub-leases */
+	if (lessor->lessor) {
+		DRM_DEBUG_LEASE("recursive leasing not allowed\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	object_count = cl->object_count;
 
 	object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
 			array_size(object_count, sizeof(__u32)));
-	if (IS_ERR(object_ids))
-		return PTR_ERR(object_ids);
+	if (IS_ERR(object_ids)) {
+		ret = PTR_ERR(object_ids);
+		goto unlock;
+	}
 
 	idr_init(&leases);
 
@@ -535,14 +550,15 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	if (ret) {
 		DRM_DEBUG_LEASE("lease object lookup failed: %i\n", ret);
 		idr_destroy(&leases);
-		return ret;
+		goto unlock;
 	}
 
 	/* Allocate a file descriptor for the lease */
 	fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
 	if (fd < 0) {
 		idr_destroy(&leases);
-		return fd;
+		ret = fd;
+		goto unlock;
 	}
 
 	DRM_DEBUG_LEASE("Creating lease\n");
@@ -578,6 +594,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	/* Hook up the fd */
 	fd_install(fd, lessee_file);
 
+	mutex_unlock(&dev->master_mutex);
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
 	return 0;
 
@@ -587,6 +604,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 out_leases:
 	put_unused_fd(fd);
 
+unlock:
+	mutex_unlock(&dev->master_mutex);
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
 	return ret;
 }
@@ -609,7 +628,7 @@ int drm_mode_list_lessees_ioctl(struct drm_device *dev,
 	struct drm_mode_list_lessees *arg = data;
 	__u32 __user *lessee_ids = (__u32 __user *) (uintptr_t) (arg->lessees_ptr);
 	__u32 count_lessees = arg->count_lessees;
-	struct drm_master *lessor = lessor_priv->master, *lessee;
+	struct drm_master *lessor, *lessee;
 	int count;
 	int ret = 0;
 
@@ -620,6 +639,8 @@ int drm_mode_list_lessees_ioctl(struct drm_device *dev,
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&dev->master_mutex);
+	lessor = lessor_priv->master;
 	DRM_DEBUG_LEASE("List lessees for %d\n", lessor->lessee_id);
 
 	mutex_lock(&dev->mode_config.idr_mutex);
@@ -643,6 +664,7 @@ int drm_mode_list_lessees_ioctl(struct drm_device *dev,
 		arg->count_lessees = count;
 
 	mutex_unlock(&dev->mode_config.idr_mutex);
+	mutex_unlock(&dev->master_mutex);
 
 	return ret;
 }
@@ -662,7 +684,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
 	struct drm_mode_get_lease *arg = data;
 	__u32 __user *object_ids = (__u32 __user *) (uintptr_t) (arg->objects_ptr);
 	__u32 count_objects = arg->count_objects;
-	struct drm_master *lessee = lessee_priv->master;
+	struct drm_master *lessee;
 	struct idr *object_idr;
 	int count;
 	void *entry;
@@ -676,6 +698,8 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&dev->master_mutex);
+	lessee = lessee_priv->master;
 	DRM_DEBUG_LEASE("get lease for %d\n", lessee->lessee_id);
 
 	mutex_lock(&dev->mode_config.idr_mutex);
@@ -703,6 +727,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
 		arg->count_objects = count;
 
 	mutex_unlock(&dev->mode_config.idr_mutex);
+	mutex_unlock(&dev->master_mutex);
 
 	return ret;
 }
@@ -721,7 +746,7 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
 				void *data, struct drm_file *lessor_priv)
 {
 	struct drm_mode_revoke_lease *arg = data;
-	struct drm_master *lessor = lessor_priv->master;
+	struct drm_master *lessor;
 	struct drm_master *lessee;
 	int ret = 0;
 
@@ -731,8 +756,10 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&dev->master_mutex);
 	mutex_lock(&dev->mode_config.idr_mutex);
 
+	lessor = lessor_priv->master;
 	lessee = _drm_find_lessee(lessor, arg->lessee_id);
 
 	/* No such lessee */
@@ -751,6 +778,7 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
 
 fail:
 	mutex_unlock(&dev->mode_config.idr_mutex);
+	mutex_unlock(&dev->master_mutex);
 
 	return ret;
 }
-- 
2.25.1

