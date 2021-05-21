Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33038C7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhEUNVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234099AbhEUNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621603164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=svG8Sugh9t0pcYUu5BPc0joM8XrQP4InyHchcRw1OeQ=;
        b=PMit/pjZYuKRynd6FmolcEA9L+DBWtnWlBw+j65Gd10Lq4x22L0KBekwh4SV/B+a/ve9mh
        r5Y2CWlUJ4hD/xLR846fATbB2+w7v7j2ghkyuYDM0TdzVMYLctqWnIPUYKjLKSMKVZt5Me
        TbZmJAnv5aBeIllNjSdmPO0XVLSndLM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-NOtzJDDVN3SbFVP0Hg-MRw-1; Fri, 21 May 2021 09:19:22 -0400
X-MC-Unique: NOtzJDDVN3SbFVP0Hg-MRw-1
Received: by mail-wr1-f69.google.com with SMTP id x10-20020adfc18a0000b029010d83c83f2aso9451952wre.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svG8Sugh9t0pcYUu5BPc0joM8XrQP4InyHchcRw1OeQ=;
        b=SH5WoaShiUkAMRnaIeJdiFbBuXhBn5p4WOthxEyvGz8YcJmW3Vw1JqkQeuoy6LMVI1
         aIoZsb37ylkMS1f24di1BKIYnvKVWdt4gFDqEht8S8kupACTr14nK4yXuuQAzZtwE0Dr
         EM7ZkQwgTddiM4mpSVTQK32M8bsoq+wY9/LlDXjYahZjlsDo4c6LrWtH7Z0tmgXNk/NP
         8JvnECS0ujDDZlXJ1jr6FX59JHrlHdlL/ezSdg9Sdz/af2Ak6KlwyDGmoar+NmeIO03V
         LKTsM5fjkzX3Z88BmBtfVDK4uE9RORx0B5ept7kUE7E9iElyQI/lquR/hEgHszU88SwL
         +N8Q==
X-Gm-Message-State: AOAM530VGNsDQOvmrOzqLccABqsQo/DOhoMlOsW5s9eWmcj+e7+gl1fW
        h/kDrNXoSjnrXhqxUbe4ge1mA+GnvQbTkntbqU7te8wrJvTL9XaIZ3VN+nWZbbOvX3kow1ARupC
        ymonR05eZqlykHmpYm+lo7wsj5eSYH7oCVxiSV0EaD0CFG2vB9gtdgvcGQamhCo42Umu94CgWsz
        8=
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr9574410wrm.212.1621603160888;
        Fri, 21 May 2021 06:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc305xT6zlfb+PcPn86ttBaAzcRsi0z+v9X45OCoUZSf6XL8B6HYzxPfoRb3ZCCBvtptJDMQ==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr9574388wrm.212.1621603160720;
        Fri, 21 May 2021 06:19:20 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm7489525wmc.5.2021.05.21.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:19:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/fb-helper: improve DRM fbdev emulation device names
Date:   Fri, 21 May 2021 15:19:10 +0200
Message-Id: <20210521131910.3000689-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Framebuffer devices that are registered by DRM drivers for fbdev emulation
have a "drmfb" suffix in their name. But makes them to be quite confusing
if a driver already has "drm" in its name:

$ cat /proc/fb
0 rockchipdrmdrmfb

$ cat /proc/fb
0 simpledrmdrmfb

Instead, let's just add a "-fb" suffix to denote that are DRM drivers FB:

$ cat /proc/fb
0 rockchipdrm-fb

$ cat /proc/fb
0 simpledrm-fb

Suggested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index f6baa204612..bbaff92c509 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1737,7 +1737,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			       sizes->fb_width, sizes->fb_height);
 
 	info->par = fb_helper;
-	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
+	snprintf(info->fix.id, sizeof(info->fix.id), "%s-fb",
 		 fb_helper->dev->driver->name);
 
 }
-- 
2.31.1

