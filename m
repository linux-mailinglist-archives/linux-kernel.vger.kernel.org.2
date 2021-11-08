Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34544480D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbhKHOJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237676AbhKHOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636380426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQLIAbh+UwGTeTD7BCUD1byG8sr2htzPW9HYf/GbWOQ=;
        b=CHQAiRtmR/CHhn5DL7cBcOr7TTgVD9qhMY78jx/RKxY0d0Dbb8sgsDdPFfLpYQVZXgO7vK
        WADIFhClenzbV8mkVdeTZQnSRohUBS4X2MfuCIzfJyORlQveOubmIcNSKQ+SPWCSg8l1EI
        TzHjozgz229/U+SoZyrYNQ5H5s3FXTE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-qG4OnFOJOUWO5Fi1NMp7CA-1; Mon, 08 Nov 2021 09:07:05 -0500
X-MC-Unique: qG4OnFOJOUWO5Fi1NMp7CA-1
Received: by mail-wr1-f69.google.com with SMTP id z5-20020a5d6405000000b00182083d7d2aso4073109wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQLIAbh+UwGTeTD7BCUD1byG8sr2htzPW9HYf/GbWOQ=;
        b=LVRmfEaYXIfUUxRfa4+glzJJrRnKs33TjmFSMMKVcOQUj75YoiF0/vsaqOidm0EaKL
         WwFT0MpqaRKwHiPzhSvrzejhJEKDOEj1NB6CHv7HoU7fxUMR3zNu1Ux/G4LJj3vc6ht1
         6U9TKQ/2M3kx4iGWVB6e1s2UL+EmRG7B8ySc7Dh31U6fj5Y7qy/wYc/3/O0zGDJDAhaz
         iXxUoLvmNyzpkNR0RBegsXcdqMySfc1Nq4r9erJzNKHerxDZtXFv2mCqEAVDmsbufEeu
         GAtwtG+6NtCN/PruTmS3dcyWzt/DnJc46VfyuDnpEdmbzKN18IERQRSkSrIwi3rRuy3e
         224A==
X-Gm-Message-State: AOAM532mVKkXW3i9Ga492nxcQwbmvqIzFBOtg+SNFUk4gAKmzIFvdmeE
        FltOZrUWfMw0eiUABrdkQDdGtI93mVx2WmtB1gaYLc3Yj+JCLg0NxpfUsNZkp6loqvKlKtO19zW
        2hcGnalH98kcolTDCey5XezDq7jCpiHrC87G77+qCoKGN9ykIwMZJXBvM8hQsMmWHVFFdX+eUvB
        U=
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr47543284wmq.34.1636380424214;
        Mon, 08 Nov 2021 06:07:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvtINAP8QSTe4tTfHVmZkm28rbBCr0xKoz60mO3RAPdu9pz4/mqVyT59DP/qN1jloJAVX4uA==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr47543247wmq.34.1636380423968;
        Mon, 08 Nov 2021 06:07:03 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m14sm10081696wrp.28.2021.11.08.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:07:03 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 1/6] drm: Don't print messages if drivers are disabled due nomodeset
Date:   Mon,  8 Nov 2021 15:06:43 +0100
Message-Id: <20211108140648.795268-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108140648.795268-1-javierm@redhat.com>
References: <20211108140648.795268-1-javierm@redhat.com>
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

