Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76573E0012
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhHDLVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbhHDLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:21:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7FC06179B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 04:21:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p5so1813732wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3Udre+J49huHIZ5aCaOfLGfaPv+Y/oIDQGc1oL/nzk=;
        b=m5+lER8SHkuEkoYjXnlsemTpJAZh8p/KxNM8bIPdPMjLwa6I0zDhTCttM+Ejzcy3DQ
         /le3Rpihi/cQuW3u/n49NfnnJxCORmMlqXDa0bBjTV4DKadG6M+yIv/txjV77csXZpj4
         8JJZel1JEFPWa0cenr+K/5UrmIMQJRmxtBC9h3U/oXfy8wPBdisZG5j78Z2LJwOCy/vR
         WBE7HmfDSUlGVlfvWya8DEMvgCh6xZPSiOpgtSwPbS71uaLiKtrUk9x/wL9pjPJcDn55
         jXFwLRQeO080iun5VR9nX4zgPM7TKWM16Yx0fjvyK7STn0JWBr+ik5qSB6tUd1cx/IDe
         F6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3Udre+J49huHIZ5aCaOfLGfaPv+Y/oIDQGc1oL/nzk=;
        b=ISRTI/d19hvn1EGVpnTWOtgG9UtvFgAaANVroM3N0WU0sgc2PGP1Jw600qqjWgYIX5
         HUnBn3OjaikdFrUad4c5yOtjPoOyWxk/VjZ3hX6MsnN92vSHsDU/kBrr0AxAW2wuN+md
         59cA+hJssFc/hcK30TDaBvBeTAKrQZWAm2aTZqrR06OAUx+nLKrU6k4UErCslFau3xnA
         an72TjDM5k2HPrKYazNXKyiSCxOIYEGd8HqIWFUaP47gMDa3KAk7jobBNnmmMBo38DCZ
         LI9tiEVIAQPgMtV85RXmimg1Gv1/ruTy/GI8oDcWl1cCd97UhkNjfvNXhcstB//U+JAK
         hVOA==
X-Gm-Message-State: AOAM533Qnri9e1n+TP3h0M9qzhgYiL43wI+K1v3owqoCUwFsB13V3U1r
        7EqUpIPnSMpjER/UAp5KKb1nBerzNgkjXg==
X-Google-Smtp-Source: ABdhPJyrf+s52V4b7YbOxf3F300f5NCbA2yGUzTHP2D7dvNV50iCrgjcTayTRz/wKD8aGeygtC4h2w==
X-Received: by 2002:adf:d091:: with SMTP id y17mr18944879wrh.311.1628076081548;
        Wed, 04 Aug 2021 04:21:21 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
        by smtp.gmail.com with ESMTPSA id y192sm5555384wmy.1.2021.08.04.04.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:21:21 -0700 (PDT)
From:   "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] DRM: gpu: radeon: Fixed coding style issues
Date:   Wed,  4 Aug 2021 13:20:53 +0200
Message-Id: <20210804112053.263887-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed braces, an unnecessary if statement and added a missing space.

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/gpu/drm/radeon/radeon_fb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 0b206b052972..6640b7c947fe 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -54,6 +54,7 @@ radeonfb_open(struct fb_info *info, int user)
 	struct radeon_fbdev *rfbdev = info->par;
 	struct radeon_device *rdev = rfbdev->rdev;
 	int ret = pm_runtime_get_sync(rdev->ddev->dev);
+
 	if (ret < 0 && ret != -EACCES) {
 		pm_runtime_mark_last_busy(rdev->ddev->dev);
 		pm_runtime_put_autosuspend(rdev->ddev->dev);
@@ -196,9 +197,8 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 		radeon_bo_check_tiling(rbo, 0, 0);
 	ret = radeon_bo_kmap(rbo, NULL);
 	radeon_bo_unreserve(rbo);
-	if (ret) {
+	if (ret)
 		goto out_unref;
-	}
 
 	*gobj_p = gobj;
 	return 0;
@@ -294,9 +294,6 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 	return 0;
 
 out:
-	if (rbo) {
-
-	}
 	if (fb && ret) {
 		drm_gem_object_put(gobj);
 		drm_framebuffer_unregister_private(fb);
-- 
2.32.0

