Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319DE37FC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhEMRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhEMRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:19:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0232C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:18:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v8so8253137qkv.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmggi1tOrZ/7NREacuaxcgryuSU/S1q+fl+YG5PANN4=;
        b=rbAflgboFf16SgYS+ys5CR+VSAB/JtRdCzBTbZQAwWW03Fv95nQDuCAaqv8IqsBIf/
         jLnU6oNbTj4urKlDmcbOImMWSGeuYXhVphoffBvMQ0AA5VXYTrbqn7rZCyFOQ97ru4p4
         4AhRiACQH8Es1QsyWFA3iZ3b8EMB60HkwsTDQ8CwrmJEDbqZGQt6nJ5/d1tOSnvicONj
         wLi4jkWdHdSnzDNAjQhJmBo8g6fUALqMIvszfEGFXE3Lenu1inRKVrMWA+ng1pUFdxfI
         L41RRPA2KZmcBUVVhTZDGmdcg7uVgifU9ouwvhtk5ghWuSHrHaZcTqbUK8gqgi/Nlwcc
         zxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmggi1tOrZ/7NREacuaxcgryuSU/S1q+fl+YG5PANN4=;
        b=SlbfdnzBXSDPIe9HFOEQThLqiaFxWOWInwB+IfGrl3Ioc4bxZ5LETyjfsfCjUZKKDw
         jw90vVrj5CSmf5OlbWWmeK4S0OGt1Jr2mVtaJrkFMGb4atZuO4RAhGNIHFUpa41msI3r
         owsEisl6AJezZPNHhOe15pM5OzxDASuPoMOeSRkIBEL9LUAjeEqrmhSWAtBnTUusKToZ
         i/2qzqHfPwZXpgYf3GcC7SbbnENR0nHDdj9Y2JA7d4f8i81hAD9h10x4rNmqPLv6ZKCr
         uxypxFOKgozRjO+GaE7IQEPtVIC+pZ9PiNPJPjYOmmjGfP56NClrJFFlLWmDiRCJfNqr
         ErLA==
X-Gm-Message-State: AOAM533+xoDpENRxGL03/9D9Iq+sZkv9PJtT/p+HV0P/YQDosxfvhCiE
        291ksaYKhELymfHLButRwz+8dg==
X-Google-Smtp-Source: ABdhPJwZ22eRt74l/hlI57Q4bM8PkfOSVTk500ebvRw6wWYM5yMzFkF7M3Vgmbr2uXsAuCtTa1ox0w==
X-Received: by 2002:a37:b947:: with SMTP id j68mr39397620qkf.108.1620926282029;
        Thu, 13 May 2021 10:18:02 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id f132sm2971117qke.104.2021.05.13.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:18:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Eric Anholt <eric@anholt.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/8] drm/msm/a6xx: update a6xx_ucode_check_version for a660
Date:   Thu, 13 May 2021 13:14:02 -0400
Message-Id: <20210513171431.18632-8-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513171431.18632-1-jonathan@marek.ca>
References: <20210513171431.18632-1-jonathan@marek.ca>
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
index 3cc23057b11d..ec66a24fc37e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -697,6 +697,11 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
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
@@ -720,27 +725,20 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
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

