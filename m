Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C534176F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhCSIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhCSIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76057C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hq27so8274900ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDb62l+8C+YekUvtP2oUdE/QSSZdTHGqGLcmgtoRZ6A=;
        b=fH44IuNWOT0gzD6ZDTpIA6Ik59/TezQetQjXfZCUitBkzSKS+ixlThvf4S2c4z24cR
         v9A2hvCloFo6enmQJULhrlvhLslpAa3OylYUAhVahQ0DFcq9p3SApUfigyhYrfPYbOrx
         5oHB+zplzVnHfUyn0TnAgQR2ekgdd7RiP0JcI2yo1lyFoyfqotZU/s2LrJfGx6xGGArD
         SZJe92Das2D14/RPj+IkMR57XFYlLxJtpRUzoL9Ns/q/ExyaowNLvTTl8LYKvqwvwf2F
         eY6l+uTTJSI0CA5NWvGVQmu7tiFOEDgKAR0vSc8twz3TBFsV2/1yNzjo09TQ9pVbQseb
         PURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDb62l+8C+YekUvtP2oUdE/QSSZdTHGqGLcmgtoRZ6A=;
        b=eEWFmBNFeXm5AhB4SJ8SDE9qMjy6+s0hnrxVlZ2fVE6JDYy9Y3mrRcOSmxdijcdLVY
         NiGV5VSHKM8pkBdgpynVG3MavaN3QpslWrc/MYH1Ht0FQZnh424hThIDBGbMHCJdCFaP
         GlqfBNKCM5n/HoXKq5tFXl7jnjjilTn1h/quivzsqcB/C3Ok6jt9Dc3tXyrPgaOwvh89
         TQgEv9mm1fLVlPmSJ1otO9s2d86fmrlq63MNajdvcwwveSDGEQ+UgwqSiE+0UpR+uc/d
         Bx/n9v5z+MCTP8BhNqMCk8upMv3MkzUIbm4przYZMg7elsXRyedeofP8BUcCqSNl8Ml3
         IKJg==
X-Gm-Message-State: AOAM530yGc3hrZ6IiuZIqMZETv3nFDYaeXDhzGlEEE3J7p+3+E3WvDQs
        zsyRA/ZNVj0eCsQi+KB5eYReYg==
X-Google-Smtp-Source: ABdhPJyNb/fOjzcFnA+jISAx3+fw5LpZGcDKcbMm/A9AcKdX1Vod6gM5IT6T6hUSVhBEzP8gkYxL9Q==
X-Received: by 2002:a17:906:340d:: with SMTP id c13mr3036223ejb.29.1616142283208;
        Fri, 19 Mar 2021 01:24:43 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 11/19] drm/nouveau/nouveau_display: Remove set but unused variable 'width'
Date:   Fri, 19 Mar 2021 08:24:20 +0000
Message-Id: <20210319082428.3294591-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_display.c: In function ‘nouveau_framebuffer_new’:
 drivers/gpu/drm/nouveau/nouveau_display.c:309:15: warning: variable ‘width’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index dac02c7be54dc..be2327ce7394c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -306,7 +306,7 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct drm_framebuffer *fb;
 	const struct drm_format_info *info;
-	unsigned int width, height, i;
+	unsigned int height, i;
 	uint32_t tile_mode;
 	uint8_t kind;
 	int ret;
@@ -343,9 +343,9 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	info = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < info->num_planes; i++) {
-		width = drm_format_info_plane_width(info,
-						    mode_cmd->width,
-						    i);
+		drm_format_info_plane_width(info,
+					    mode_cmd->width,
+					    i);
 		height = drm_format_info_plane_height(info,
 						      mode_cmd->height,
 						      i);
-- 
2.27.0

