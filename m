Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40232BE6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573589AbhCCRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383285AbhCCNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F1C0611C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so23755415wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhEuhGFXr/bQGRE4okPVNID5UMggkL9a7rhCimuP+ao=;
        b=MYUt36BHKi3+/nFVEwYOKehOixCmGYE75NoUp9lQ8IyUA60ZXrT1kCGasQIb3lerEi
         lxYGVvqkhzzo/2mnZiWA+W4MS59e6NtKYarYxEBxC+js4/3KVp0aw5VOIjykL++ohZVw
         vfAvPed6+VgGAZbh06xm+D8naHhdyuSh/hTJR8EzknQF2KvLpM+rdVOOq60lPonItUL4
         mPzZ+j8K33j6sFxolR4hFZhxfXxg7yM1dbjJwGafe1/xdnM1EWJtn1mUjQdFepJh+Cuv
         jBBIrRfR6UP7ZgbhkaPzubfZrW0jzRTPi5ZxfRdjQ5OiMSMzrpkw0VqIeg9AvY+dXGRH
         DHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhEuhGFXr/bQGRE4okPVNID5UMggkL9a7rhCimuP+ao=;
        b=G6MT+ACq28lRXmnpb0EWvMs4jU6dwFATxg0OqvDzCfdNZmQIxW76arujE1Av4g8cJB
         GIK81LLa0TwjrslszKownvImTHC0pi+x68n7C9gxNmsX5iuDjPqviqapsbgoR8s6/ijX
         KXOyyCeVSGosKxnfdSNcxBkv0B3l/ycRARJvW8DsnbxkWXxHoG7sF35CPimqXj2kzRNQ
         mGNT3f5/DeByLJMDBE/ZRNhEwb9MaMIQNQwPcNGAwGfmVdUEM6hdlBg/AsQEDLHlsCj5
         O0eCK2FbPJYch9Uohnq1bR+LErDovxlxnWsSSYH6jEIk6gRT5/h7i85F39evJj2RuhiA
         /HrA==
X-Gm-Message-State: AOAM533k44GaV7b5lFuob3c3iqiXDn3b/c2fwNUwGLYzDsoWROAnZPTb
        8NAy+J/Y2kUlpp7GECTgu4ZeGKQCKI5Wvg==
X-Google-Smtp-Source: ABdhPJzbgvSx7PDjj6EWPiA7QS1Lk+De+efwgOaWw8y4Wly/hMcIVBgcrSDjwZGcEBeSjtKchb0ojQ==
X-Received: by 2002:a5d:5104:: with SMTP id s4mr28478476wrt.62.1614779025255;
        Wed, 03 Mar 2021 05:43:45 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 14/53] drm/nouveau/nouveau_display: Remove set but unused variable 'width'
Date:   Wed,  3 Mar 2021 13:42:40 +0000
Message-Id: <20210303134319.3160762-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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
index 17831ee897ea4..0849f367631a9 100644
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
@@ -346,9 +346,9 @@ nouveau_framebuffer_new(struct drm_device *dev,
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

