Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7084844419E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhKCMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232081AbhKCMf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635942771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WYRilsKXTSd9rCQl94c3WtrJx+PErIlJFSZVj4QEnnA=;
        b=cT5xaZkCgZl6c1soc6dSMfwreVmba4uKECqqvHhpi8zGp7/7ObSS791NXlC/OW74/Lfdme
        on+ToTyy3542oNWKjjXM6m9W9Ue1Rrlqm28+IUpQoh49E9wioXkcLKf424RdCll4EXoc7j
        pvShaHx2qiyhqgb3XzYEkbv2zSPYwKE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-danWSMkzNWG7Z6fnsmE0Sw-1; Wed, 03 Nov 2021 08:32:50 -0400
X-MC-Unique: danWSMkzNWG7Z6fnsmE0Sw-1
Received: by mail-wm1-f69.google.com with SMTP id f20-20020a05600c155400b0030db7b29174so1031114wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 05:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYRilsKXTSd9rCQl94c3WtrJx+PErIlJFSZVj4QEnnA=;
        b=CLt55H6mZC6PSlyCjEM1vqPbZohr4EoxXy850aCDfgTMIsrRQlfWd1ZOSAJNLu7w9V
         k3ez+A/Dq3Xyy5v5v9n2ORibJfhxWd80/alqq7cRDau8ugCoP43LWN9HCPbBWg73UnID
         VB50OK7a2NBhxE57vWtu+PfkmR4Cj3uFOZ29RuSU11dg66CFCzvEtTEtDtFDueqp6m8c
         5HBmA8j7yqwpyTApL2VbqG5St4yKVyQeHcmXB3xoUbkBHtjXroYzwNoKyoYSqQTK/kt9
         dvHUEVYof1dsdnRlsThi3MubqfLvoeZNNqciohGIHBz/VAPTRDPh+JzhBt5mS3uydV9b
         zulA==
X-Gm-Message-State: AOAM532ko7qz0gd0gZ7aO6N5tf9CIROJUSuTw5P5mhqm44tPLlQL1Aqt
        XrNkhU10IvyLfxdw6CLnwW+U4w/8Jp8wyqt04X65kNBwnb8mNjFdMy79eQwcMom0i3V1KWax7qj
        XyGoPI1SmpJmE0ImLl0koS7/zyS8yP4sDck+Wa2bBhc3h42xvge3CMrXIYhulB80jttTTv4qEaO
        4=
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr28163706wrs.272.1635942768525;
        Wed, 03 Nov 2021 05:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL3nl9ZIaxmy0TeQNyii+JJT5uC8lrIzi9b77Ccpfz42Wnw9LhvaMNMIW70Bij6uW32P/3dA==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr28163669wrs.272.1635942768316;
        Wed, 03 Nov 2021 05:32:48 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o8sm1774844wrm.67.2021.11.03.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:32:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RESEND PATCH 4/5] drm: Add a drm_drv_enabled() helper function
Date:   Wed,  3 Nov 2021 13:32:06 +0100
Message-Id: <20211103123206.1041442-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM drivers can use this to determine whether they can be enabled or not.

For now it's just a wrapper around drm_modeset_disabled() but having the
indirection level will allow to add other conditions besides "nomodeset".

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_drv.c | 21 +++++++++++++++++++++
 include/drm/drm_drv.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..70ef08941e06 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -975,6 +975,27 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
 }
 EXPORT_SYMBOL(drm_dev_set_unique);
 
+/**
+ * drm_drv_enabled - Checks if a DRM driver can be enabled
+ * @driver: DRM driver to check
+ *
+ * Checks whether a DRM driver can be enabled or not. This may be the case
+ * if the "nomodeset" kernel command line parameter is used.
+ *
+ * Returns:
+ * True if the DRM driver is enabled and false otherwise.
+ */
+bool drm_drv_enabled(const struct drm_driver *driver)
+{
+	if (drm_modeset_disabled()) {
+		DRM_INFO("%s driver is disabled\n", driver->name);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(drm_drv_enabled);
+
 /*
  * DRM Core
  * The DRM core module initializes all global DRM objects and makes them
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 0cd95953cdf5..48f2b6eec012 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -598,5 +598,6 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
 
 int drm_dev_set_unique(struct drm_device *dev, const char *name);
 
+bool drm_drv_enabled(const struct drm_driver *driver);
 
 #endif
-- 
2.33.1

