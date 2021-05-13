Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9737F0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhEMArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhEMAly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:41:54 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0BC061761
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:39:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f8so14503630qth.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnRvE7q7omrM9Y7M/uG0pQjcGn/zVQ91DdwGZf18JUA=;
        b=iFEOAoOEidpxJv/4U3NRI+KV1cH/GGVonttUSD2VOPM9C7GQV676OVDzVjA8HMmmhC
         JY1GyxO8cKn0g338BG7veWQrpbp9Pi1hr7erSZ+KOebfeoeyCOVGTnvxAitzqWDsC+r8
         wvEdQaRtNr37lgaMcpE9kaPSzoAmMIq+I4uvaDp0hCIPMiIT3bTdu8d/ZDUCp1qKJYG5
         20wGITd/kcLjkgUH6z29AUqhxipV4NGc8rl4QZUs4dg5UQzMR1nCLcREjOlB4AMqzlQm
         SfjD9pYD2oPuhXw1sOXjyET227/Mg8rx3/HHvM47N11pzlPlDKNcpZDY0Eq+XDGVIvNc
         kVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnRvE7q7omrM9Y7M/uG0pQjcGn/zVQ91DdwGZf18JUA=;
        b=LiLT5zCWrt2Dc/p3e/acf623Q5f74wKLQQtqdg3idHRsfgYEBuUR7TyXwELoO9f4x/
         4DU03ULFBwnPBEKITf/ZR0eeZ0/FsxE4x4/edU3tQouvuZ0vLebuZLiZk62OPa4tt4aP
         7/8J+IQ8ICe7B1M+MavGDhaM+B8uNQcny5ydsi5Jbx7yvShdCjgowrwpCouaDsfJdQGJ
         towdxLDnwpst+vyIVW9oB6uN0+aLpWH7rReIL0HjXSVxCelDVsyL4f9TvSebX5qaPxJN
         PGYLt9BSxC32nr+UrmXXpMuC6ZqnBSP+TEeUH08xSvujUw4uGQ3NJmJQMpByaI2yYv9W
         0DRA==
X-Gm-Message-State: AOAM533JrWjgyQsgbJuAoeVrRIxideNMcZG/0Kg8l7ZvpvQ22GNlAvTh
        M8laPpfd78iNzVKPpPCiSAAJ8g==
X-Google-Smtp-Source: ABdhPJwZFkdm3qJWYphlBOa4pGjbVWYRWlHXshlrTtHqe59WzZni9+nU4+jmqVdZjXBBVRBn5sIEmA==
X-Received: by 2002:a05:622a:10e:: with SMTP id u14mr35186672qtw.229.1620866361837;
        Wed, 12 May 2021 17:39:21 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id w16sm1204201qts.70.2021.05.12.17.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 17:39:21 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Eric Anholt <eric@anholt.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/msm/a6xx: update a6xx_ucode_check_version for a660
Date:   Wed, 12 May 2021 20:37:48 -0400
Message-Id: <20210513003811.29578-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513003811.29578-1-jonathan@marek.ca>
References: <20210513003811.29578-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept all SQE firmware versions for A660.

Re-organize the function a bit and print an error message for unexpected
GPU IDs instead of failing silently.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 36 +++++++++++++--------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4467273e66c0..261a20076f9d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -541,6 +541,11 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
 	 * Targets up to a640 (a618, a630 and a640) need to check for a
 	 * microcode version that is patched to support the whereami opcode or
 	 * one that is new enough to include it by default.
+	 *
+	 * a650 tier targets don't need whereami but still need to be
+	 * equal to or newer than 0.95 for other security fixes
+	 *
+	 * a660 targets have all the critical security fixes from the start
 	 */
 	if (adreno_is_a618(adreno_gpu) || adreno_is_a630(adreno_gpu) ||
 		adreno_is_a640(adreno_gpu)) {
@@ -564,27 +569,20 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
 		DRM_DEV_ERROR(&gpu->pdev->dev,
 			"a630 SQE ucode is too old. Have version %x need at least %x\n",
 			buf[0] & 0xfff, 0x190);
-	}  else {
-		/*
-		 * a650 tier targets don't need whereami but still need to be
-		 * equal to or newer than 0.95 for other security fixes
-		 */
-		if (adreno_is_a650(adreno_gpu)) {
-			if ((buf[0] & 0xfff) >= 0x095) {
-				ret = true;
-				goto out;
-			}
-
-			DRM_DEV_ERROR(&gpu->pdev->dev,
-				"a650 SQE ucode is too old. Have version %x need at least %x\n",
-				buf[0] & 0xfff, 0x095);
+	} else if (adreno_is_a650(adreno_gpu)) {
+		if ((buf[0] & 0xfff) >= 0x095) {
+			ret = true;
+			goto out;
 		}
 
-		/*
-		 * When a660 is added those targets should return true here
-		 * since those have all the critical security fixes built in
-		 * from the start
-		 */
+		DRM_DEV_ERROR(&gpu->pdev->dev,
+			"a650 SQE ucode is too old. Have version %x need at least %x\n",
+			buf[0] & 0xfff, 0x095);
+	} else if (adreno_is_a660(adreno_gpu)) {
+		ret = true;
+	} else {
+		DRM_DEV_ERROR(&gpu->pdev->dev,
+			"unknown GPU, add it to a6xx_ucode_check_version()!!\n");
 	}
 out:
 	msm_gem_put_vaddr(obj);
-- 
2.26.1

