Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13B42651B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJHHTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhJHHTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633677446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VBOxsLxxf+FVkHYJGJvqWe8yOt5UqmLKigzcG0fQrbU=;
        b=a7Xdkw5ppRLGEz75uLxn+0pGuu2Y0eEhMylrCRvzFkb+Xa4NVlc+TF6cC9D78MFpq75ir8
        amz05/9/G/WONe7H0jlk2ywNek9e70O8MnUCacMbJk/l4aQi3ZZ9jK7N+oi2Z6fGOjMujE
        Ksj754mmRaPl8rR7vPOfT6wk77tfmKA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-cKBVxsOoMyS4LHbkS3fK7w-1; Fri, 08 Oct 2021 03:17:23 -0400
X-MC-Unique: cKBVxsOoMyS4LHbkS3fK7w-1
Received: by mail-wr1-f72.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so5797218wrc.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBOxsLxxf+FVkHYJGJvqWe8yOt5UqmLKigzcG0fQrbU=;
        b=xNN+O1wf1vRm6acFbOY9eQZdOzIWWIQakTR9RMFZPlC0aKYednMBOlPmXEVWO9go0L
         W2hpwTzisgnzr1SlxhoteZWc+/ZJgneRXC4HtMDCu67U08DWmiSMOFcdyjNTFsj12qYV
         pjH9xG8+xvQAsDNEJVBORM8j4bf+tpBJx7ds5VHw0HfJQYzTn7/NJRxosomL0ayrhz0Y
         wZol4eE5JLjcAMQp/fqS7WA2jDfyDDaWi9uj9z3FEv9BKx3kZZr/aWz8phJnnE26jtmm
         ijtmpzZ39KhZ4+1TZhb5KfPJ1tnR2a/iXtPH5tSGKGTf4P/QA84VfC4Ju0aowzfRVBmz
         AHhA==
X-Gm-Message-State: AOAM530ogJP835u2hgiS04tPC6f0bZXWchDyFbK5WHnvEDq4n7W8Nl8D
        L90u7JqoSpIE3UqFMl1S+MYCJ9Jj8Uzl9dUFHKwOXMHVjyt8rbTmTM/YxjkIOY/DEvW55Fah10P
        0ffJyCgSDXoo4GlvW57kFsN6c15BoL2f36xHh0onktmgP3S5OgEBpqNITT9ljIuYi1v/nw+xPco
        I=
X-Received: by 2002:adf:fb50:: with SMTP id c16mr2025838wrs.120.1633677442367;
        Fri, 08 Oct 2021 00:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJtAbe3TBB4Yd2wrlfMF2cS7QqC6SU2LfwWwP1pVuG2EFJZrMXS/ZlRQi0XgjK21R/xyX5xg==
X-Received: by 2002:adf:fb50:: with SMTP id c16mr2025801wrs.120.1633677442066;
        Fri, 08 Oct 2021 00:17:22 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id n14sm1573459wrm.78.2021.10.08.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:17:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Stezenbach <js@sig21.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] Revert "drm/fb-helper: improve DRM fbdev emulation device names"
Date:   Fri,  8 Oct 2021 09:17:08 +0200
Message-Id: <20211008071708.1954041-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b3484d2b03e4c940a9598aa841a52d69729c582a.

That change attempted to improve the DRM drivers fbdev emulation device
names to avoid having confusing names like "simpledrmdrmfb" in /proc/fb.

But unfortunately there are user-space programs, such as pm-utils that
query that information and so broke after the mentioned commit. Since
the names in /proc/fb are used programs that consider it an ABI, let's
restore the old names even when this lead to silly naming like the one
mentioned above as an example.

Reported-by: Johannes Stezenbach <js@sig21.net>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 3ab07832104..8993b02e783 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1737,7 +1737,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			       sizes->fb_width, sizes->fb_height);
 
 	info->par = fb_helper;
-	snprintf(info->fix.id, sizeof(info->fix.id), "%s",
+	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
 		 fb_helper->dev->driver->name);
 
 }
-- 
2.31.1

