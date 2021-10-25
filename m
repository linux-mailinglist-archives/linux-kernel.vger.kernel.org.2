Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64094390AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhJYIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231204AbhJYIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYqAJMiMehgYdp+cI4y2X1DXGszUCH2Ol7ATB/O0Np0=;
        b=OTmJEM3sub9d1p2Fs6iGGWTLXfDqxng7rjyU0CjyY0Fqb9xoQrG4GOc1YaWoPOCoGpmZbD
        wIPQZk0P78VdWRP9GWtUX3Kd+qty0mDSWzSAbdhNoiBVF1tK8OUA/RuYGocxtJnRkfOWed
        TCLawrDSGR8seGky1VKtYKMZX9YKvMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-AKoyt0HvO76X7e4wNMwyqg-1; Mon, 25 Oct 2021 03:58:06 -0400
X-MC-Unique: AKoyt0HvO76X7e4wNMwyqg-1
Received: by mail-wm1-f72.google.com with SMTP id g188-20020a1c20c5000000b0032328337393so2766517wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYqAJMiMehgYdp+cI4y2X1DXGszUCH2Ol7ATB/O0Np0=;
        b=1ygdlZEewlOKLjpxDQgWg0gsVbbqKf3Jf+juSFUC0RcH9ubH5Ni+06Dq6LXe49pRpb
         MzgbvitVu3Oktg+ioqRubQrCHfK/YUCf0N2U+RJKLIYu+nfBFp66tlqSdEaoznpvTsjC
         eQ02r6syLGnYWRJje+dLLLB8zyqKt7pSS2GqDKxOqy2vVXVoWZ1KucTbm5BENAwdoJKq
         BRC4SgEDBqJ7rzq+WEO+S4QJmch/9huQ+EOk4c1JssgSBp3MOtmbaNCIIroBsB2trASb
         mFSwZRQZfWy3rtGqjT45fzkaDAQK/crGQbNyzWQZtEfIPyCHn9wAnC9RMt9y6/cAgJAJ
         N7FQ==
X-Gm-Message-State: AOAM532aZZIWJSz4BaUR3IXpsfsIyYKv26HXDM8X1b7dHMxNa8g82r+2
        ug26teHnLmBaAC602e0a4mNn7NwAe6hfCrJihoXCFT2VqncNNluwAL0G3zmUpRUeIa8aNOh+clP
        W42usvF06S4lAXP6ntTp5JtQmq/9jbP2HU3axRgPYhp4CYnUoWn6t2faUMaIkU0AIOeVwjYOPvv
        Y=
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr8909388wmj.54.1635148685305;
        Mon, 25 Oct 2021 00:58:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwYO5IXedqQl2OZFOdR0R166cWLfHsmJ4vD73vZAnbEkTR6bjbhzQlZ18zaAoPsiaVsGc+VQ==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr8909347wmj.54.1635148684962;
        Mon, 25 Oct 2021 00:58:04 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d1sm15939502wrr.72.2021.10.25.00.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:58:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/aperture: Move conflicting fbdev frame buffer removal to a helper
Date:   Mon, 25 Oct 2021 09:57:55 +0200
Message-Id: <20211025075756.3479157-2-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025075756.3479157-1-javierm@redhat.com>
References: <20211025075756.3479157-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to remove the conflicting frame buffers for fbdev devices that
use a given memory range is only compiled if CONFIG_FB option is enabled.

But having an ifdefery in drm_aperture_remove_conflicting_framebuffers()
makes the function harder to extend. Move the logic into its own helper.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/drm_aperture.c | 39 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 74bd4a76b253..1a8ed0c616d6 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -273,6 +273,30 @@ static void drm_aperture_detach_drivers(resource_size_t base, resource_size_t si
 	mutex_unlock(&drm_apertures_lock);
 }
 
+static int drm_aperture_remove_conflicting_fbdev_framebuffers(resource_size_t base,
+							      resource_size_t size, bool primary,
+							      const struct drm_driver *req_driver)
+{
+#if IS_REACHABLE(CONFIG_FB)
+	struct apertures_struct *a;
+	int ret;
+
+	a = alloc_apertures(1);
+	if (!a)
+		return -ENOMEM;
+
+	a->ranges[0].base = base;
+	a->ranges[0].size = size;
+
+	ret = remove_conflicting_framebuffers(a, req_driver->name, primary);
+	kfree(a);
+
+	if (ret)
+		return ret;
+#endif
+	return 0;
+}
+
 /**
  * drm_aperture_remove_conflicting_framebuffers - remove existing framebuffers in the given range
  * @base: the aperture's base address in physical memory
@@ -289,23 +313,12 @@ static void drm_aperture_detach_drivers(resource_size_t base, resource_size_t si
 int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_size_t size,
 						 bool primary, const struct drm_driver *req_driver)
 {
-#if IS_REACHABLE(CONFIG_FB)
-	struct apertures_struct *a;
 	int ret;
 
-	a = alloc_apertures(1);
-	if (!a)
-		return -ENOMEM;
-
-	a->ranges[0].base = base;
-	a->ranges[0].size = size;
-
-	ret = remove_conflicting_framebuffers(a, req_driver->name, primary);
-	kfree(a);
-
+	ret = drm_aperture_remove_conflicting_fbdev_framebuffers(base, size, primary,
+								 req_driver);
 	if (ret)
 		return ret;
-#endif
 
 	drm_aperture_detach_drivers(base, size);
 
-- 
2.31.1

