Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00B844E765
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhKLNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233855AbhKLNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cq+5GX1LGAlrdEVaEfUGXIHfDu19zJU/Yjhmzl1bGJc=;
        b=c2cya4wiod0iRyQ0g7cayHt27pOkofQ9HMCN5ZFuI7FDIJV0lDM9obDrRST/hNnbsq96Fc
        7PUoNz8jmZy/vVRlcyacGbtGgA3LOV8Ifa1kPrUyQG818JaGWAJrXKn1BGbRL1xolqJ2ZR
        sgwBl/5s0hUld4VvCLk0nRYFnZpMzYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-PNGRLQUxM4SRBG9sqsYicA-1; Fri, 12 Nov 2021 08:32:51 -0500
X-MC-Unique: PNGRLQUxM4SRBG9sqsYicA-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so3345532wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cq+5GX1LGAlrdEVaEfUGXIHfDu19zJU/Yjhmzl1bGJc=;
        b=CjTdon3N/JiYvqqWAfqtFIWH65uBBAQToO7rR8c/8wsK7hf363xJLklOto0uI/xcjz
         /Z/JGp9CstnV7mesRgAUTkGLwfkKmK7I544hdSJwRgekRQfsQLiC9x3OEpzYECO7oHd/
         pY14SNOU7yoMBBb1SAl+klVZhLRTikOlczShViQcN/DDAlqIQWQvVq8rISliH3lrk5gB
         iB80BDTLCT+6P0+LqVN/4oKQYY0Z2iy0zwHkcQtwtT6hi2hBrfSJVGXZcngVUbnFNJ1B
         CJwFy7+VLEaNyIBdxm0xyZBiQ8zHk4pY8xhYTsBqm6Xt89WuB3CeufKb+xW7bgjHRNBG
         kkHA==
X-Gm-Message-State: AOAM530pgydyi2bXunCHWAX7NV5Ct3FJeiy0tD3qCv6Nbx44nxjdhHKh
        ZnlujnR8zLAN0RB0wlNNUAqn2z/EoRAeko6HUQNsPeBP0m5Nyv6YB/0lM+rahsPP3Q1S8VwqOjO
        VzlxGd9ahrhAM2pEDPyMNZu7V5gTkbSZ6tKO6lH5Rp+LoqVQ+YtwXg+BajaPyEe2juF6ne63bgW
        M=
X-Received: by 2002:a05:600c:5101:: with SMTP id o1mr34460080wms.81.1636723970014;
        Fri, 12 Nov 2021 05:32:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoWQcfWmWVvV0JYnbwieSBAuTFS5D1rKq/HCQc0RO5OF48GRcTM2rvN71XU0UWSo8x16SIlA==
X-Received: by 2002:a05:600c:5101:: with SMTP id o1mr34460043wms.81.1636723969780;
        Fri, 12 Nov 2021 05:32:49 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm5733470wrv.78.2021.11.12.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:32:49 -0800 (PST)
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
Subject: [PATCH v5 2/6] drm/vboxvideo: Drop CONFIG_VGA_CONSOLE guard to call vgacon_text_force()
Date:   Fri, 12 Nov 2021 14:32:26 +0100
Message-Id: <20211112133230.1595307-3-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112133230.1595307-1-javierm@redhat.com>
References: <20211112133230.1595307-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is already handled by the console.h macro since a stub inline function
is defined for vgacon_text_force() if CONFIG_VGA_CONSOLE is not set.

There's no need to have ifdefery in the driver when calling the function.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/vboxvideo/vbox_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git drivers/gpu/drm/vboxvideo/vbox_drv.c drivers/gpu/drm/vboxvideo/vbox_drv.c
index a6c81af37345..fd7abb029c65 100644
--- drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -193,10 +193,8 @@ static const struct drm_driver driver = {
 
 static int __init vbox_init(void)
 {
-#ifdef CONFIG_VGA_CONSOLE
 	if (vgacon_text_force() && vbox_modeset == -1)
 		return -EINVAL;
-#endif
 
 	if (vbox_modeset == 0)
 		return -EINVAL;
-- 
2.33.1

