Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC23904CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEYPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhEYPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621955599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G/fCjyB7iNAHQ0ure1mFwutfJ1NArBGdlauCkoAWAjw=;
        b=DmRm2mqx6v4wuc9gfC9lQsVMkaeXVI0xWR9J/h4BKQuf4tWqb4b9JmmTanGuFOno57LUcA
        rA/pCR6U3hcp1/FM4EdGM9nr0fNeoh2q6wnn5O/YHOEfKLh1OqUKaKHEmSFIdyg4OV7MBO
        I2H7LwL45inYdn83BUmdkwfKlqR6pEo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-R-6ngoSZN5W6pICfaDxokg-1; Tue, 25 May 2021 11:13:18 -0400
X-MC-Unique: R-6ngoSZN5W6pICfaDxokg-1
Received: by mail-wr1-f72.google.com with SMTP id h22-20020adfa4d60000b029011244156c68so4709160wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G/fCjyB7iNAHQ0ure1mFwutfJ1NArBGdlauCkoAWAjw=;
        b=VhaZ6gdMRyRmmKM+aK1Si+AloMhM6ZYYO/IrReQfHUhYV06ZIsd6NJaxoES4dKSrOr
         qmUfaV43JvG+vR/nmCZFnozQuIhUSu8e85F2VZQiDw3hAGxwPOtiMRRlzqIMS71AWz0S
         Zc9w60qq29+qsY8tdLFm13dLWMuKPl2Pa6UgfAHHwRcQNFeTwo7qD8yJfhElMdRtdOTF
         TdE/D74R4CQ5nICvetKHVVv++KQJXtyclsEeNexs7goAS52cx8Soe3hjZEXvLfxGGTme
         cVhS+pVDGp2RlkKvjYJoNs/vxntBvbmxWpM4YfFUyVOpKFGJaOI9/lNsmClobFN0/lvw
         uL7g==
X-Gm-Message-State: AOAM532Ix9mPIUg2/fFBy6a5I8rctIqJDIj8Fz5dn4QhoVcrIIejWw8a
        RQU3dfe4ofqhfJHaMApVpnNSBgH2A8IDT/iNfxay9c9wv5W10QzUD8O67P7JlmH8Ju3nvqGSmMm
        /beZP2vhdb8Z0vC8yTAuIIxx9iOpnvyAV5tUAcZ3Zyl6c0L4oBt3PwoxOeMWSais8EwhKmi/zy2
        U=
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr27334647wrw.272.1621955596580;
        Tue, 25 May 2021 08:13:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRW+ZtNXlXygGeJ2boKH56TGYwHy3jnjhrNP1uaP2v8xyPBBzPxW/IypraSH2vxWBBzjo0ZA==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr27334620wrw.272.1621955596297;
        Tue, 25 May 2021 08:13:16 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id g11sm16396801wri.59.2021.05.25.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:13:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/fb-helper: improve DRM fbdev emulation device names
Date:   Tue, 25 May 2021 17:13:13 +0200
Message-Id: <20210525151313.3379622-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Framebuffer devices that are registered by DRM drivers for fbdev emulation
have a "drmfb" suffix in their name. But makes them to be quite confusing
for drivers that already have "drm" in their name:

$ cat /proc/fb
0 rockchipdrmdrmfb

$ cat /proc/fb
0 simpledrmdrmfb

Also, there isn't a lot of value in adding these "drmfb" suffices to their
names, since users shouldn't really care if the FB devices were registered
by a real fbdev driver or a DRM driver using the fbdev emulation.

What programs should be interested about is if there's a DRM device, and
there are better ways to query that info than reading this procfs entry.

So let's just remove the suffix, which leads to much better device names:

$ cat /proc/fb
0 rockchipdrm

$ cat /proc/fb
0 simpledrm

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Just remove the "drmfb" suffix instead of using a different one (tzimmermann).

 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index f6baa204612..d77a24507d3 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1737,7 +1737,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			       sizes->fb_width, sizes->fb_height);
 
 	info->par = fb_helper;
-	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
+	snprintf(info->fix.id, sizeof(info->fix.id), "%s",
 		 fb_helper->dev->driver->name);
 
 }
-- 
2.31.1

