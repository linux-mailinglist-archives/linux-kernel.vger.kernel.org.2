Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A479447F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbhKHMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239448AbhKHMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKN5KjqJ+KRnaHGOwpSHiDENJCInQ2OqIClv005Af3M=;
        b=UOOJ64VInLgP4ulyNLwiCncNQK5hF4ICcOaBpOqrSnGQvI57uE1Q0q7384MGrpBpfDIgJ7
        nchxEs9sJLHW+EdCxWaDrcyL2B3w33yzSyX5WSRr0H0fAMOgfPhCuvGw3tTVx27R1a6+jC
        u/zbL/Mpju7uTT7G2vMPGlOkqdYp3VU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522--vPG8lHcOy-U7r9oT3WYiQ-1; Mon, 08 Nov 2021 07:16:04 -0500
X-MC-Unique: -vPG8lHcOy-U7r9oT3WYiQ-1
Received: by mail-wr1-f71.google.com with SMTP id a2-20020a5d4d42000000b0017b3bcf41b9so3978618wru.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKN5KjqJ+KRnaHGOwpSHiDENJCInQ2OqIClv005Af3M=;
        b=Ql7dppzSFYagLBV6SuJ7QPQXgVHczq7fYxshIqZILB8JSOprNrcOYUIr2cUc2aVD/z
         Kp+5qA3B861Pod3niydIgKXgaCy6q9FjgVW+P7tC/YzafMZxtW69/84ghAi38PVvssxp
         Au3qDNQeiWK5YRRZHvdQu3ZzzWJlqxLpBZa8aqa7c+jKHynHHXaVEmugjGxZybqOeERa
         xklBZbX6quu4UTz6Pkj3owoPIuUxbghO3xwAAudShzMIo12T9GJ/Yk0WpBrN7t1BS28f
         sNSc+nM3QYUOXxdDkzS1My0dNkyTYQEQMFrzlBh3/8u5avRPLY4xw3gqknOXgeEoWKjE
         Lgew==
X-Gm-Message-State: AOAM532imKk8OsvLcaL1sFVlNpsgayFRHiselVUPY/nMMELhDWYoS4l8
        XFz6Fl4EkGZW1jxF40xZZlDrG6EjUAnZsTQBz8UcbA9ZaJnE6uTgCn3qm06rT2kgCkofPP87srY
        LjYu6f/chw+SundZ2sDY1ZNxiAulOSaquu6py3gZgE7U61pRdxdnYe5qsLYDuFbY+LIsRwRCxh7
        4=
X-Received: by 2002:a5d:6152:: with SMTP id y18mr78918171wrt.271.1636373763463;
        Mon, 08 Nov 2021 04:16:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLO9Sz8FK6iWw4u45XTsQ+MXDa4qY4K+cEjRCPC5NDTtyoJkPljBpWWnh2Q6Jmp2Obx6u0aw==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr78918132wrt.271.1636373763251;
        Mon, 08 Nov 2021 04:16:03 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q4sm16866866wrs.56.2021.11.08.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:03 -0800 (PST)
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
Subject: [PATCH v3 2/6] drm/vboxvideo: Drop CONFIG_VGA_CONSOLE guard to call vgacon_text_force()
Date:   Mon,  8 Nov 2021 13:15:40 +0100
Message-Id: <20211108121544.776590-3-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108121544.776590-1-javierm@redhat.com>
References: <20211108121544.776590-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is already handled by the console.h macro since a stub inline function
is defined for vgacon_text_force() if CONFIG_VGA_CONSOLE is not set.

There's no need to have ifdefery in the driver when calling the function.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
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

