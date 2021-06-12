Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34BD3A4EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFLM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:57:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:55:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e33so33106pgm.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hTuY7U1R+ySW1pBhYnqPXW/iY7lo4A0jpCZdHDRERo=;
        b=OHqcytAxEtLThghXPcTSEi53Ohzx6AgIjzBIhVcGvJReCNgvxY9AnjobCmUU4mdJVE
         pcf9tVP9Asz4EH9lh1l/mD9UX6t4unHIs7mNX8y1wB86fbPwEdHMgemFtR/9JMoiPMmZ
         yQZbYibwsJ7Odwcabf7KfwmtpkKfIBHc5Rf0bjJJh5IpVuJ3kTuQsB2wC2hGCjm7tmE5
         FPNtVx05YnNjDVpggnYZFjbNf6qIK0/TE+M8q4YnBH2d1apsP3eNXz91KCbCcqcwhfgO
         ANJDl5bowY1QyLXlUUtglUgkJWC4qlhFDE/8c3nngAUv5rwZMiIYRLi53Q+PT0hxQTTS
         y+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hTuY7U1R+ySW1pBhYnqPXW/iY7lo4A0jpCZdHDRERo=;
        b=EW3mq6HgHEGv6EhT8hGVEWAD6zZN7WyIZ2xLk0t35b91Tv0LuMmY6y9Yl/lb1QVKyd
         41Qq1UMBoxV5kOMWSbiA98z+WJZa1B+GPQsurslpK6+V7IAiHMXAWdtfyyfH18du6Yo8
         UUv2/t28GSNReUcwUXhVxrj5fhYEqq/SO19JuSMgPirbSnZgyfML9TSY7foofVTekOtQ
         UugEdR7scgoQs9U4wUbMqpQw7YAneH/OgKPbXon/jBJ0JzFGsaMGqKzf1zGoWh4Td2NJ
         MZWsc+tOrAX/EpMS3YoAWL/PkcvZNmiwCeleFWSyH4mU6Pfhgsr+Q5uPhAluyih7bV/9
         aLLQ==
X-Gm-Message-State: AOAM532eg/PaZJtcQa3Qd12oyxHRkFqCleWgIqRsls3kVp11iSzvjMUj
        ObmlHTrdEefDi8zpLy74LstYQ3J5RZWgyTL0ETA=
X-Google-Smtp-Source: ABdhPJxcPLkxJPfGeQDXgL6AeZKlPhDG/fM9lxRpRH8ptyrfytCsDXnGBvQV2fQLW2IWza2dLfQUug==
X-Received: by 2002:a62:7705:0:b029:2f0:94d6:78c9 with SMTP id s5-20020a6277050000b02902f094d678c9mr10155406pfc.25.1623502522053;
        Sat, 12 Jun 2021 05:55:22 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id c7sm8015498pgh.72.2021.06.12.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:55:21 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 1/2] drm: Add a locked version of drm_is_current_master
Date:   Sat, 12 Jun 2021 20:54:25 +0800
Message-Id: <20210612125426.6451-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612125426.6451-1-desmondcheongzx@gmail.com>
References: <20210612125426.6451-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While checking the master status of the DRM file in
drm_is_current_master(), the device's master mutex should be
held. Without the mutex, the pointer fpriv->master may be freed
concurrently by another process calling drm_setmaster_ioctl(). This
could lead to use-after-free errors when the pointer is subsequently
dereferenced in drm_lease_owner().

The callers of drm_is_current_master() from drm_auth.c hold the
device's master mutex, but external callers do not. Hence, we implement
drm_is_current_master_locked() to be used within drm_auth.c, and
modify drm_is_current_master() to grab the device's master mutex
before checking the master status.

Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/gpu/drm/drm_auth.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 232abbba3686..c6bf52c310a9 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -61,6 +61,8 @@
  * trusted clients.
  */
 
+static bool drm_is_current_master_locked(struct drm_file *fpriv);
+
 int drm_getmagic(struct drm_device *dev, void *data, struct drm_file *file_priv)
 {
 	struct drm_auth *auth = data;
@@ -223,7 +225,7 @@ int drm_setmaster_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto out_unlock;
 
-	if (drm_is_current_master(file_priv))
+	if (drm_is_current_master_locked(file_priv))
 		goto out_unlock;
 
 	if (dev->master) {
@@ -272,7 +274,7 @@ int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto out_unlock;
 
-	if (!drm_is_current_master(file_priv)) {
+	if (!drm_is_current_master_locked(file_priv)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -321,7 +323,7 @@ void drm_master_release(struct drm_file *file_priv)
 	if (file_priv->magic)
 		idr_remove(&file_priv->master->magic_map, file_priv->magic);
 
-	if (!drm_is_current_master(file_priv))
+	if (!drm_is_current_master_locked(file_priv))
 		goto out;
 
 	drm_legacy_lock_master_cleanup(dev, master);
@@ -342,6 +344,13 @@ void drm_master_release(struct drm_file *file_priv)
 	mutex_unlock(&dev->master_mutex);
 }
 
+static bool drm_is_current_master_locked(struct drm_file *fpriv)
+{
+	lockdep_assert_held_once(&fpriv->master->dev->master_mutex);
+
+	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
+}
+
 /**
  * drm_is_current_master - checks whether @priv is the current master
  * @fpriv: DRM file private
@@ -354,7 +363,13 @@ void drm_master_release(struct drm_file *file_priv)
  */
 bool drm_is_current_master(struct drm_file *fpriv)
 {
-	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
+	bool ret;
+
+	mutex_lock(&fpriv->master->dev->master_mutex);
+	ret = drm_is_current_master_locked(fpriv);
+	mutex_unlock(&fpriv->master->dev->master_mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL(drm_is_current_master);
 
-- 
2.25.1

