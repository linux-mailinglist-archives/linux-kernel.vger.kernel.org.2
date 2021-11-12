Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5C44E763
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhKLNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:35:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232373AbhKLNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLaL9JZ/L/NQxIKHNVpbSM1dEcBi90FRvIYDc1fdXrY=;
        b=JwpkJ60K4Asyn5uT5Jum4Tqyxmi57KVJ8OOdBzs/cldKswG7PNo//1K/qezzi3k5hOnAYa
        cceNZ+DMKuxfG8l1pWFHnFiZuEZ6doyofo9NoZMYXcE1/rE+QMvyGMtPFY7qEhWP8Rwbxj
        gTWuTXu4KpL2P+m+gb5jW/Svsc5Hjok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-mFqeoSbkPziWZFx87mnuVw-1; Fri, 12 Nov 2021 08:32:50 -0500
X-MC-Unique: mFqeoSbkPziWZFx87mnuVw-1
Received: by mail-wm1-f72.google.com with SMTP id 67-20020a1c0046000000b0032cd88916e5so4251299wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLaL9JZ/L/NQxIKHNVpbSM1dEcBi90FRvIYDc1fdXrY=;
        b=4mfVgibF33OnsSJDzNmAXAEneFWYZfkWG/cS2R33LOZY+1z9BlQjfU4CvF0mSKxRM2
         w4kquf7hDH7o0cApbJNNQmpW7xkNqZpK1DnzFpVbYNOjymS+iyXnEmI9F/uyBFlSRTaQ
         s+3xf8wZzlPRdRHtfjLyV2kgMrgMrLeZ6ON7iCbsii6kfj62rUjS2OZL3tlmnZlXgKg6
         GvS9aP34YO1y55OkrvEvwQ3G5e9YlI3jA7JqB7V5ekSBg+EVUYpS0X6T0pbwTEqZjJYN
         wf/bwu7kNtOXhdjfsMe0i5PmzjAuFwCcnemtDwXwyTXTcO6kd1CiNYmlul8VjhWbP5Ig
         tgPw==
X-Gm-Message-State: AOAM531jQf5mc4u1CWB3l+Cz0I9g/fWcFHAZEyzHLboZ8ZSdlCDB1joG
        HFVM2moEaikscQab91qTuYN/HoyIF6NOWa7EMgiH3NbrtULiOO0+XUNJAdz9YILeSL46lJgzu/a
        7OYUESQoXMbKaUmfkUNlKJ7vDMATxo3+xxJIK/VJLEAtTmj+dR34d7M5Kqd+izRnBbMxxTTqmIL
        U=
X-Received: by 2002:a5d:4989:: with SMTP id r9mr19032588wrq.14.1636723968676;
        Fri, 12 Nov 2021 05:32:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyf3Es8c/GzYUbtaVdHj/i+lj1ZAXpyeetue9BBTgBWOxPQKZ1EhV8CzIyD0A5jk57GUqcR0A==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr19032550wrq.14.1636723968436;
        Fri, 12 Nov 2021 05:32:48 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm5733470wrv.78.2021.11.12.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:32:48 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 1/6] drm: Don't print messages if drivers are disabled due nomodeset
Date:   Fri, 12 Nov 2021 14:32:25 +0100
Message-Id: <20211112133230.1595307-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112133230.1595307-1-javierm@redhat.com>
References: <20211112133230.1595307-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nomodeset kernel parameter handler already prints a message that the
DRM drivers will be disabled, so there's no need for drivers to do that.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +---
 drivers/gpu/drm/radeon/radeon_drv.c     | 8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c718fb5f3f8a..289d04999ced 100644
--- drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2514,10 +2514,8 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (vgacon_text_force()) {
-		DRM_ERROR("VGACON disables amdgpu kernel modesetting.\n");
+	if (vgacon_text_force())
 		return -EINVAL;
-	}
 
 	r = amdgpu_sync_init();
 	if (r)
diff --git drivers/gpu/drm/radeon/radeon_drv.c drivers/gpu/drm/radeon/radeon_drv.c
index b74cebca1f89..380adc61e71c 100644
--- drivers/gpu/drm/radeon/radeon_drv.c
+++ drivers/gpu/drm/radeon/radeon_drv.c
@@ -637,15 +637,11 @@ static struct pci_driver radeon_kms_pci_driver = {
 
 static int __init radeon_module_init(void)
 {
-	if (vgacon_text_force() && radeon_modeset == -1) {
-		DRM_INFO("VGACON disable radeon kernel modesetting.\n");
+	if (vgacon_text_force() && radeon_modeset == -1)
 		radeon_modeset = 0;
-	}
 
-	if (radeon_modeset == 0) {
-		DRM_ERROR("No UMS support in radeon module!\n");
+	if (radeon_modeset == 0)
 		return -EINVAL;
-	}
 
 	DRM_INFO("radeon kernel modesetting enabled.\n");
 	radeon_register_atpx_handler();
-- 
2.33.1

