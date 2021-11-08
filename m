Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E8C447F63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhKHMS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239452AbhKHMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvpqxJ0h/KARiUJklDyPTF0UTcSFrdOggpTVbohw2n0=;
        b=NUewj4ZaMJqGAAIuVG49nVOuzcyXHg9d1qR2cmjuDOQ/Mp6w3HmBFWQgqbh8DcptMzc6vU
        qCbZIlUgq3oAqBz0bVJrCxZd5x28BwtP87oZwKOez7DZ9oCQRfOel+KAa8qa82NkGGmkPb
        /TLoTPqyCK7CiEQ5x4GLr71AjUvsqsE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-zEhGcJ7JPYiKuPGqlONM_g-1; Mon, 08 Nov 2021 07:16:06 -0500
X-MC-Unique: zEhGcJ7JPYiKuPGqlONM_g-1
Received: by mail-wm1-f70.google.com with SMTP id 67-20020a1c0046000000b0032cd88916e5so6119862wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvpqxJ0h/KARiUJklDyPTF0UTcSFrdOggpTVbohw2n0=;
        b=JpkbjDTzYjUEQAlfWt64lw4Ca5378DCJLntmJxCH9KhDRG6aq1TarL3ELEvUkkDwpe
         lQo8Axh9jlRLt4mkUOxCW5f/gKIRni9YamSRqvCDAnX0y3rQLhGjBGZaHAD3BvKqetU5
         yjCH12so0Ak4hxSQWivA7cFKgvzYhSg8YRvKeurh81ldxE9sFxsT0dFtujxcusLgY984
         4YlCzfo9MC/N2hAvVc0OlttATGVbT5EDwvFxRN6yQE8NFDr9myuFXHj+tz90Plp4SMAc
         +wt77geq4209IgIlaF8DC9ZdnB5zQuzlyeRSHUCA40LY3FS16c1VxmkFQjTJ2/8faC8n
         uSWg==
X-Gm-Message-State: AOAM5314YoO4xy6hnJ49JuB3q0uEyHuIOc50B7+01supa5r2b1HM7sOf
        tjvnpcW3T56sCpDuRZsopHGMIB43MTZvK9g/G8v4l39h6caim8g9uNAqSp6EDUlum5Ln5ow+R4c
        BZFBbUZy2VZ+UXrJX8+6R5+31L/eFgPKhbiAo8pQfIiIFiOoZyEujm7L14obQ/UomrhrrCsr1Ya
        c=
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr53317376wmq.62.1636373763797;
        Mon, 08 Nov 2021 04:16:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzlvEYbpw4g7ENtWhZB1VcX9c/BLzL1OXMXSYWBRM+1DfGtRdBeaMAQRctQX+FLnaEOlGCfg==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr53317154wmq.62.1636373761895;
        Mon, 08 Nov 2021 04:16:01 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q4sm16866866wrs.56.2021.11.08.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:01 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 1/6] drm: Don't print messages if drivers are disabled due nomodeset
Date:   Mon,  8 Nov 2021 13:15:39 +0100
Message-Id: <20211108121544.776590-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108121544.776590-1-javierm@redhat.com>
References: <20211108121544.776590-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nomodeset kernel parameter handler already prints a message that the
DRM drivers will be disabled, so there's no need for drivers to do that.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
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

