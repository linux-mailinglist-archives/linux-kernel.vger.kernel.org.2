Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B927D3FCE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbhHaUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbhHaUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:46 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B2C061292
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b10so544779ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+08hq9MDL1yzT8HxFNaQNtrlEM6Xv6fhZuNRn1F1mc=;
        b=kkg/vsJwa/PC9gwR6TjotF0CzvHRDa/wuXMq9HtcCwPhn1g2Qx8JJRgXcybbEg67Jh
         pVs6K3PIw1uNZjI8XQTu7Gtu2rAgJyLE3S5fqrjQn/gMx+Y+ZO5dzNZ0DPUeD6YISBEy
         TG2cM2xh57GL/+uZmpfJRK2sRGyI0rb9Bs14sl0GkLes6WrhB4wj4vZvj6dOBBEzdlaG
         5tejIMovQXK8GpOcVIzJi8bR0T/1clUcGK/JHxg+3kfVG8T5AUOiTcBh0wzfwmTQICTb
         50e4FgMlhKbkfsSHYjgKlmdQFZwHO4m0OmtQizYHYx42HivYCa029Jn1NkPAE/Dw4/qN
         cn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+08hq9MDL1yzT8HxFNaQNtrlEM6Xv6fhZuNRn1F1mc=;
        b=W9oOG8iiI1yByaQUam1zssnZtVNdjMKf9uckQO0FZzPuj7bW2BDVfZbvJf2HCOyDNh
         jAEJ65rpWecloGYxswBI92FElQf/wkKMw56k5ou2hRRRS0C6dtjIYQFJ9zPhGvWx6S7Y
         gsEshY7gPqLseSl92vuA6dUTbHO0em5s0H3TKpBA1r4XhKA+gLUh/uRip75HVNicurG/
         ij5uHeKKJTRtOte8VRAJRfpde1vC2KP4AvXRowwyZo3TPailFQBebhxWjYyGdQOsa8lM
         wGCp8+KcrlPv9wcaym4lABDJZ4ZbAmC0Y7AbdOJ8eWvmf0uCGOKAcLpJGoF72HZpRsfr
         UQ+g==
X-Gm-Message-State: AOAM5317DhN3WQObn33T+idkdlX9EF2lCiwHmvlXqEOl+RC3OUnMFhAj
        pJwqfII2YN2hu1P45GaOp4k=
X-Google-Smtp-Source: ABdhPJzGE5W/brNtojRAI3ODL+k+VqSv5/EuvNY5lJztWnokfQOk0zya7SQYN7UHGJl6it18QB3GDQ==
X-Received: by 2002:a05:6638:1613:: with SMTP id x19mr4431178jas.77.1630441308243;
        Tue, 31 Aug 2021 13:21:48 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id u15sm10597384ilk.53.2021.08.31.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:21:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 8/8] nouveau: fold multiple DRM_DEBUG_DRIVERs together
Date:   Tue, 31 Aug 2021 14:21:33 -0600
Message-Id: <20210831202133.2165222-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831202133.2165222-1-jim.cromie@gmail.com>
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DRM_USE_DYNAMIC_DEBUG, each callsite record requires 56 bytes.
We can combine 12 into one here and save ~620 bytes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 36 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ba4cd5f83725..0f45399535bf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1245,19 +1245,29 @@ nouveau_drm_pci_table[] = {
 
 static void nouveau_display_options(void)
 {
-	DRM_DEBUG_DRIVER("Loading Nouveau with parameters:\n");
-
-	DRM_DEBUG_DRIVER("... tv_disable   : %d\n", nouveau_tv_disable);
-	DRM_DEBUG_DRIVER("... ignorelid    : %d\n", nouveau_ignorelid);
-	DRM_DEBUG_DRIVER("... duallink     : %d\n", nouveau_duallink);
-	DRM_DEBUG_DRIVER("... nofbaccel    : %d\n", nouveau_nofbaccel);
-	DRM_DEBUG_DRIVER("... config       : %s\n", nouveau_config);
-	DRM_DEBUG_DRIVER("... debug        : %s\n", nouveau_debug);
-	DRM_DEBUG_DRIVER("... noaccel      : %d\n", nouveau_noaccel);
-	DRM_DEBUG_DRIVER("... modeset      : %d\n", nouveau_modeset);
-	DRM_DEBUG_DRIVER("... runpm        : %d\n", nouveau_runtime_pm);
-	DRM_DEBUG_DRIVER("... vram_pushbuf : %d\n", nouveau_vram_pushbuf);
-	DRM_DEBUG_DRIVER("... hdmimhz      : %d\n", nouveau_hdmimhz);
+	DRM_DEBUG_DRIVER("Loading Nouveau with parameters:\n"
+			 "... tv_disable   : %d\n"
+			 "... ignorelid    : %d\n"
+			 "... duallink     : %d\n"
+			 "... nofbaccel    : %d\n"
+			 "... config       : %s\n"
+			 "... debug        : %s\n"
+			 "... noaccel      : %d\n"
+			 "... modeset      : %d\n"
+			 "... runpm        : %d\n"
+			 "... vram_pushbuf : %d\n"
+			 "... hdmimhz      : %d\n"
+			 , nouveau_tv_disable
+			 , nouveau_ignorelid
+			 , nouveau_duallink
+			 , nouveau_nofbaccel
+			 , nouveau_config
+			 , nouveau_debug
+			 , nouveau_noaccel
+			 , nouveau_modeset
+			 , nouveau_runtime_pm
+			 , nouveau_vram_pushbuf
+			 , nouveau_hdmimhz);
 }
 
 static const struct dev_pm_ops nouveau_pm_ops = {
-- 
2.31.1

