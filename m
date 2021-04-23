Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AEE369ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbhDWTMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbhDWTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:12:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB02C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f12so37191975qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsSjtuHXUzVXrjNpljPImYq3qGMXxS9a3DZ+iKn3tAo=;
        b=SFEXTgKFMyoXwKvR8hGBN2EqjhGKhAVeC2fSHN8LtZU3j8QwSuaezEOLHc0HBYlF77
         +vmDdr7lfvp5mGYRQEkhQv1znIKGFGLyorirqodh02V2p/VkwfeZxVFFz/CseOYZamEg
         JZ5WPzf66VAio2wP6tgW4aOG4ibCq5uM8PMZzM6BXjqs6fyKApv+4E9eX1BZ0Zc/RDeV
         qSnbMlKNJvk9c2jAj0SLjO1nt7HIXWAozDxZ9CbpWsZ//RWCXEUPjwpXyR+4FsxGtsOx
         +4bsKARPD8X5O/J7B+WV7fkGX74w9IsbhacxeepHPDi4b5z/TLjn4Ginf2jGtioaW+X0
         ACLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsSjtuHXUzVXrjNpljPImYq3qGMXxS9a3DZ+iKn3tAo=;
        b=sRV6xC6gSaoEUwwvONOBUA5CvNyzlgVn8EF2EE99/wHo8BRItVUWa4jB7s6m425rHZ
         dL1GlPuTyxcXPtIfcJy8PnClTz1MdiXasWf8kOp4TXmHg20EfqustfciwHOCJFHkRqbP
         MK/cLIafRXc1Vp87FfePxbWiWB2xX1UtzfvHiz/wOJnKtSnhyS6qj69uCWBcgMbUT1SR
         YgDUKgDvpp/uZNtHzRucJnCFh52urI4Tq6Iycdlc/8dbL/JiAuhuWkgyMCmc9t3sqM+G
         EfD8hsg/bKLwreY7+PJPkJ7mc57MBIe0FWrY/r+0jL/an6V1tkK6oTZsVAcHPs8oR+t8
         V+lQ==
X-Gm-Message-State: AOAM532fAWog8Qlt9eQB4fbz23QvAN8HuG0+t5odc9svcZeyzP6VzGTZ
        /kx/sCkufLejdn0gEDUg6RXhKg==
X-Google-Smtp-Source: ABdhPJws23NrkTcrqMCUw+HPc2/jCj4j/EJ6kONToNrZm3DDUieqxomiZpJ2Eg0rUKjlrZVejMLBtA==
X-Received: by 2002:ac8:6b58:: with SMTP id x24mr5368602qts.77.1619205134101;
        Fri, 23 Apr 2021 12:12:14 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id a22sm4834630qtp.80.2021.04.23.12.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:12:13 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Eric Anholt <eric@anholt.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bernard Zhao <bernard@vivo.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/msm: replace MSM_BO_UNCACHED with MSM_BO_WC for internal objects
Date:   Fri, 23 Apr 2021 15:08:18 -0400
Message-Id: <20210423190833.25319-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210423190833.25319-1-jonathan@marek.ca>
References: <20210423190833.25319-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm_gem_get_vaddr() currently always maps as writecombine, so use the right
flag instead of relying on broken behavior (things don't actually work if
they are mapped as uncached).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       | 4 ++--
 drivers/gpu/drm/msm/adreno/a5xx_power.c     | 2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c   | 4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     | 2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c          | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index ce13d49e615b..eb0f884eaf30 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -902,7 +902,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 		if (!a5xx_gpu->shadow_bo) {
 			a5xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
 				sizeof(u32) * gpu->nr_rings,
-				MSM_BO_UNCACHED | MSM_BO_MAP_PRIV,
+				MSM_BO_WC | MSM_BO_MAP_PRIV,
 				gpu->aspace, &a5xx_gpu->shadow_bo,
 				&a5xx_gpu->shadow_iova);
 
@@ -1407,7 +1407,7 @@ static int a5xx_crashdumper_init(struct msm_gpu *gpu,
 		struct a5xx_crashdumper *dumper)
 {
 	dumper->ptr = msm_gem_kernel_new_locked(gpu->dev,
-		SZ_1M, MSM_BO_UNCACHED, gpu->aspace,
+		SZ_1M, MSM_BO_WC, gpu->aspace,
 		&dumper->bo, &dumper->iova);
 
 	if (!IS_ERR(dumper->ptr))
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_power.c b/drivers/gpu/drm/msm/adreno/a5xx_power.c
index c35b06b46fcc..cdb165236a88 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_power.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_power.c
@@ -363,7 +363,7 @@ void a5xx_gpmu_ucode_init(struct msm_gpu *gpu)
 	bosize = (cmds_size + (cmds_size / TYPE4_MAX_PAYLOAD) + 1) << 2;
 
 	ptr = msm_gem_kernel_new_locked(drm, bosize,
-		MSM_BO_UNCACHED | MSM_BO_GPU_READONLY, gpu->aspace,
+		MSM_BO_WC | MSM_BO_GPU_READONLY, gpu->aspace,
 		&a5xx_gpu->gpmu_bo, &a5xx_gpu->gpmu_iova);
 	if (IS_ERR(ptr))
 		return;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 42eaef7ad7c7..ee72510ff8ce 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -230,7 +230,7 @@ static int preempt_init_ring(struct a5xx_gpu *a5xx_gpu,
 
 	ptr = msm_gem_kernel_new(gpu->dev,
 		A5XX_PREEMPT_RECORD_SIZE + A5XX_PREEMPT_COUNTER_SIZE,
-		MSM_BO_UNCACHED | MSM_BO_MAP_PRIV, gpu->aspace, &bo, &iova);
+		MSM_BO_WC | MSM_BO_MAP_PRIV, gpu->aspace, &bo, &iova);
 
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
@@ -238,7 +238,7 @@ static int preempt_init_ring(struct a5xx_gpu *a5xx_gpu,
 	/* The buffer to store counters needs to be unprivileged */
 	counters = msm_gem_kernel_new(gpu->dev,
 		A5XX_PREEMPT_COUNTER_SIZE,
-		MSM_BO_UNCACHED, gpu->aspace, &counters_bo, &counters_iova);
+		MSM_BO_WC, gpu->aspace, &counters_bo, &counters_iova);
 	if (IS_ERR(counters)) {
 		msm_gem_kernel_put(bo, gpu->aspace, true);
 		return PTR_ERR(counters);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 5214a15db95f..1716984c68a8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -852,7 +852,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 		if (!a6xx_gpu->shadow_bo) {
 			a6xx_gpu->shadow = msm_gem_kernel_new_locked(gpu->dev,
 				sizeof(u32) * gpu->nr_rings,
-				MSM_BO_UNCACHED | MSM_BO_MAP_PRIV,
+				MSM_BO_WC | MSM_BO_MAP_PRIV,
 				gpu->aspace, &a6xx_gpu->shadow_bo,
 				&a6xx_gpu->shadow_iova);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index c1699b4f9a89..21c49c5b4519 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -113,7 +113,7 @@ static int a6xx_crashdumper_init(struct msm_gpu *gpu,
 		struct a6xx_crashdumper *dumper)
 {
 	dumper->ptr = msm_gem_kernel_new_locked(gpu->dev,
-		SZ_1M, MSM_BO_UNCACHED, gpu->aspace,
+		SZ_1M, MSM_BO_WC, gpu->aspace,
 		&dumper->bo, &dumper->iova);
 
 	if (!IS_ERR(dumper->ptr))
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 17f3e45fd5ff..c1332b2459ec 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -391,7 +391,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 	void *ptr;
 
 	ptr = msm_gem_kernel_new_locked(gpu->dev, fw->size - 4,
-		MSM_BO_UNCACHED | MSM_BO_GPU_READONLY, gpu->aspace, &bo, iova);
+		MSM_BO_WC | MSM_BO_GPU_READONLY, gpu->aspace, &bo, iova);
 
 	if (IS_ERR(ptr))
 		return ERR_CAST(ptr);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 055cd1c7c9fe..18c80744e331 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1155,7 +1155,7 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 	uint64_t iova;
 	u8 *data;
 
-	data = msm_gem_kernel_new(dev, size, MSM_BO_UNCACHED,
+	data = msm_gem_kernel_new(dev, size, MSM_BO_WC,
 					priv->kms->aspace,
 					&msm_host->tx_gem_obj, &iova);
 
-- 
2.26.1

