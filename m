Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC724480D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbhKHOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236375AbhKHOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636380427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBLSYCGNnxL90t/5H+fXmKYwqgv0hYBDnt/wGxwYShQ=;
        b=OTojkj72o4mE+SN2MZ3hbja4SBHIi3G3hHo8t8nT0LHDf/92OJ2ADHm5qgDXaKwmfitkjP
        R3SPtkq6v50Y07zF6Sh2qjyg+HS/OC+X7iXkGZM8VgG66X7YzlAr/jN7N0hE12VWO+66iO
        s5c7vrsyiSDr7CpcSBMxwd3FDdmA6e8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-a9XAWYDCPK-HjmXjjy5ajg-1; Mon, 08 Nov 2021 09:07:06 -0500
X-MC-Unique: a9XAWYDCPK-HjmXjjy5ajg-1
Received: by mail-wr1-f70.google.com with SMTP id q17-20020adff791000000b00183e734ba48so4078297wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBLSYCGNnxL90t/5H+fXmKYwqgv0hYBDnt/wGxwYShQ=;
        b=q6KnaqfdXEIddpwXVv+lu1hWLHkEAlTTiBYuackUSOUQnsqN6IWI50bSlhD+NvMr7E
         GkL0ZjjIMuQ8o0a5nTW+uLA5S69VrSqNzpNyJb0JHLMPVkDnvL5p1/YzEL5g3ruCGca5
         46S2pNTCHjYwqs5qJBICFQgqTOlaHk0G4tQtW06/dG6YHOsG9y3NttMHSar4SLAZ5p5K
         c83DG9XLXjvjN5DuO0eVVhjcm1rbmdHGOMP7uJT5nVBFNGHa+WH3eLNMzNV1uGewRpKh
         zimRJSgPKchqtmgfK3m5kC0jqt/oC+oFID66hHKxWBCnP3fe4MgATwqjWm7IKSiZgp/E
         2dQw==
X-Gm-Message-State: AOAM530IB0ntx0dXSZ0H49x5rtuJb66tiPJ0/YAw7JgdaBZ3xbiqqDEb
        TBWFK/Z77LN8xeI6xC7dhHz0BYwIxYNNvPOH4wLIEUWy09tY/jSt4pqPfCUMhFeKecpHgDanD8G
        5Zv9txrwwzXY2hQ/E+kcyIzrb/nprRvwJgJzEp+i4lMe3rGM7RqKgNEOE90xKZ6+tAFvG+dw7Ku
        0=
X-Received: by 2002:a5d:5651:: with SMTP id j17mr68117wrw.166.1636380425304;
        Mon, 08 Nov 2021 06:07:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHyDgAew+dtCqACNkmDLzBa0RJwibVQ2fmqgfKLQQb8uNEyhZ+QodkcyI1wWViqtj63Ut+JA==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr68067wrw.166.1636380425058;
        Mon, 08 Nov 2021 06:07:05 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m14sm10081696wrp.28.2021.11.08.06.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:07:04 -0800 (PST)
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
Subject: [PATCH v4 2/6] drm/vboxvideo: Drop CONFIG_VGA_CONSOLE guard to call vgacon_text_force()
Date:   Mon,  8 Nov 2021 15:06:44 +0100
Message-Id: <20211108140648.795268-3-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108140648.795268-1-javierm@redhat.com>
References: <20211108140648.795268-1-javierm@redhat.com>
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

