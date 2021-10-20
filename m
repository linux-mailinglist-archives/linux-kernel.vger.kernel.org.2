Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CDE4350D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJTRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhJTRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634749074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XMrjtmMFCodzmOkKBCAts1KmNdWqk5crMuC4nhTRFUU=;
        b=eXjbzMCfs52HvoNPkqrWRZWMvpjuYAMAg1Cl2F2T1ZZMvKRQdGCEwdthMETglXXJvnK9bJ
        HNhEgfd78Zy+TmuzMoy/QlAfNNHgxxkMGq+Y+xwPuAEFIhB7eUjtf4rNnIWLMiCg/1k/ti
        e6YxZojoXDYBxU6v1AuZe7ZoiQSMp84=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-EI69-RT2OPyqvL7vivH3tw-1; Wed, 20 Oct 2021 12:57:53 -0400
X-MC-Unique: EI69-RT2OPyqvL7vivH3tw-1
Received: by mail-wm1-f72.google.com with SMTP id l39-20020a05600c1d2700b0030dba1dc6eeso3559383wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMrjtmMFCodzmOkKBCAts1KmNdWqk5crMuC4nhTRFUU=;
        b=pF02w4Jsg7W2v7/NQRJnKjVAxPdzG3sKARXwYl4hbWZ9BWiuvIforxfUggXpdBMFZf
         plZtr1IavCYiBnoTPJ6t90kxKBRIaFs7Yds2FVqVH5yZ9gH+I6y0RpTFThwx0tw6d5ev
         3Hq635nmW2Bh1G4Eg7UY0FcIO8eVJdhp/TzGjpPT+HqMKm1TiB/Vmb/ZtF5tWO1VrPce
         JXuvja3Y8osr4+r4Ec1D38MOsfyvR/gb3Wd/xH5hTEZHs+d+sSx3mOa4iTkLuGrQu6qT
         1+YoaeGtvR//Li1mnQYuFuGsO+0N9RE0J5Ti9aTh8MBCLCGgbV6mF+ZTv+bZMoy6Z2ch
         v28g==
X-Gm-Message-State: AOAM530Imb0zJeJtQObk8FMSVeBqY2EFjfwD/RPk3S+0ghVy+hywV1my
        ldb2WzUDTo8GwHFb94zhzqeGYQ2mUad0C16dGlK328TaiV5nK5b79R906Ek0EyWToJYzEx97lg1
        Lt7xU7rmEw41dcngf+wFCoQrLpA7PF9zd4LRmsDg3MhABhjDSsvcfu6dM9OMTYOK/s4trDd8nTd
        8=
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr14759734wmq.97.1634749071676;
        Wed, 20 Oct 2021 09:57:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzt4IdDIt4JK7oFknnDd0KYdkLwueKH68lcDLzxFYYyytVkRjTBJ2NloP8e5wzUs9Lm+OI5Q==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr14759702wmq.97.1634749071403;
        Wed, 20 Oct 2021 09:57:51 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z2sm2419999wrn.89.2021.10.20.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:57:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Johannes Stezenbach <js@sig21.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] Revert "drm/fb-helper: improve DRM fbdev emulation device names"
Date:   Wed, 20 Oct 2021 18:57:40 +0200
Message-Id: <20211020165740.3011927-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b3484d2b03e4c940a9598aa841a52d69729c582a.

That change attempted to improve the DRM drivers fbdev emulation device
names to avoid having confusing names like "simpledrmdrmfb" in /proc/fb.

But unfortunately, there are user-space programs such as pm-utils that
match against the fbdev names and so broke after the mentioned commit.

Since the names in /proc/fb are used by tools that consider it an uAPI,
let's restore the old names even when this lead to silly names like the
one mentioned above.

Fixes: b3484d2b03e4 ("drm/fb-helper: improve DRM fbdev emulation device names")
Reported-by: Johannes Stezenbach <js@sig21.net>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---

Changes in v2:
- Add a comment explaining that the current /proc/fb names are an uAPI.
- Add a Fixes: tag so it can be cherry-picked by stable kernels.
- Add Ville Syrjälä's Reviewed-by tag.

 drivers/gpu/drm/drm_fb_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 8e7a124d6c5a..22bf690910b2 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1743,7 +1743,13 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			       sizes->fb_width, sizes->fb_height);
 
 	info->par = fb_helper;
-	snprintf(info->fix.id, sizeof(info->fix.id), "%s",
+	/*
+	 * The DRM drivers fbdev emulation device name can be confusing if the
+	 * driver name also has a "drm" suffix on it. Leading to names such as
+	 * "simpledrmdrmfb" in /proc/fb. Unfortunately, it's an uAPI and can't
+	 * be changed due user-space tools (e.g: pm-utils) matching against it.
+	 */
+	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
 		 fb_helper->dev->driver->name);
 
 }
-- 
2.31.1

