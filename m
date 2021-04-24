Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3691E369E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 03:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhDXBxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 21:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhDXBxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 21:53:18 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 18:52:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ef17so19085954qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcY6Lu3u2CeikGQuheX4lmNqK8mFEGOt+ZAL+7yU8Dc=;
        b=Jauv+uflVnnVf1sTvIAuyx6lYbj+w3YEeYLPo30ZDB/TwQ6WEYsR8KqnHRlXLb4ub8
         SDsx7nH6WGGhkVhCfo0mwxG/SS1BUu821BVZwt7bQvJyAq+BUyN7U37Rwyx8t/1djF5a
         KANU7RYbWXYohZK0kWujMdPCE5/CkQ+JLc0D84W4IhL3UKcvxiCD5rVzfA0N/knyjZtM
         9k9JJDltJ8qzQXvWT/zm/c1vEDMTmTw2AqSzpwJvOUWdYx0OhJD2INBO+Vpt+xk6qHof
         UjLXc1WQXSGIqtFky0qu7VK0YYh7OvwP4/Y7qQZ3uNN67SaqiKmVn7rm0EM8xGhNMIF/
         t6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcY6Lu3u2CeikGQuheX4lmNqK8mFEGOt+ZAL+7yU8Dc=;
        b=Dez42tNSK875yHpL5OA3TOSSSNy+AqiLv4+0B/ljOfO7uAUqEa7YIglo+Pptuyuptx
         bVAcT8f744w2MyOwO7akaytz1r7oO0k6Aw0K9PWMzRENVbP3HmLRdNW9Cq+aZ3itYaAw
         xleWYd662IUGKBtfZlkQowpAzL8F0J5BEPG1LhEg0MnkEClaYDZEeLMk2FvBGJLtA+aZ
         Dy+9yBIsowt3mw0hRL6Ikh87EXyrI/nbczK+uMhzLo66tHM+SMe7KNfV5S9pyOa4zudB
         JM722DGdNZYAMJpInj38Zn9oJe0YrKq1GLNNlBn8IOWpo+lgb9S2VYtv9Od6SFuCyyIB
         9NCg==
X-Gm-Message-State: AOAM530PxUE0tToa8EkdFTX9/p42uarismkpVDApq9NtKPBAU9jWvttk
        hGxoeN50gbyaU8XefTOd/qt6wA==
X-Google-Smtp-Source: ABdhPJyiOw7t62EyD1lV8XxKfvCZk/P/OPh7hCDSf08Jt2OMZoHDkUXqS9tnOiWkNCEYbON1Z5kV/g==
X-Received: by 2002:ad4:5543:: with SMTP id v3mr7495429qvy.32.1619229159334;
        Fri, 23 Apr 2021 18:52:39 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id r5sm5389259qtp.75.2021.04.23.18.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 18:52:38 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: fix LLC not being enabled for mmu500 targets
Date:   Fri, 23 Apr 2021 21:49:26 -0400
Message-Id: <20210424014927.1661-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmu500 targets don't have a "cx_mem" region, set llc_mmio to NULL in that
case to avoid the IS_ERR() condition in a6xx_llc_activate().

Fixes: 3d247123b5a1 ("drm/msm/a6xx: Add support for using system cache on MMU500 based targets")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1716984c68a8..727d111a413f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1153,10 +1153,6 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 {
 	struct device_node *phandle;
 
-	a6xx_gpu->llc_mmio = msm_ioremap(pdev, "cx_mem", "gpu_cx");
-	if (IS_ERR(a6xx_gpu->llc_mmio))
-		return;
-
 	/*
 	 * There is a different programming path for targets with an mmu500
 	 * attached, so detect if that is the case
@@ -1166,6 +1162,11 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 		of_device_is_compatible(phandle, "arm,mmu-500"));
 	of_node_put(phandle);
 
+	if (a6xx_gpu->have_mmu500)
+		a6xx_gpu->llc_mmio = NULL;
+	else
+		a6xx_gpu->llc_mmio = msm_ioremap(pdev, "cx_mem", "gpu_cx");
+
 	a6xx_gpu->llc_slice = llcc_slice_getd(LLCC_GPU);
 	a6xx_gpu->htw_llc_slice = llcc_slice_getd(LLCC_GPUHTW);
 
-- 
2.26.1

