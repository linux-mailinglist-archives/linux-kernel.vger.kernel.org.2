Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1241A380
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhI0XCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhI0XCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:02:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9DCC061575;
        Mon, 27 Sep 2021 16:00:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so317041pjv.5;
        Mon, 27 Sep 2021 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rbLOO10kE7IzUzgrNCp18mct+mNdp/gWXsyE0YgXgA=;
        b=I62cA8quqW9adN9QhJVpPFvFlzGroeNfhwxgIjahjW4W1zokWRtF3RBXmvV9qpzKZR
         KlzsEK2U7EJLFR6aeVm31MQUvxnvInsreHPjdbiDeguDnkPWr6mS+gDqVZrT+K7G/1U/
         AYSIcE6rq2wkMze3oMZ2PgeGY1Asqh2ELq6vE/IrEzb/QctT5XxBgkXApJU+0tHb5MEG
         rWjZLC6bz7PVqlgd35/BR0XJFGZgBIdKSmB5wSZrDs8a/HB4VHVCWaGw3wCIVSfTNnKo
         kaOM2AMiQlYk1/9bp9KCKk6okR2sORxBnPgvotwNc5hECpKhsDhPnfQfR2nUOO4ywO5o
         Tpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rbLOO10kE7IzUzgrNCp18mct+mNdp/gWXsyE0YgXgA=;
        b=BF3zLtOCtXdkApLHpLR8OQ1ZqkcP9xMFqmZ3wRDKIKxWbBo+66Gtkw7IDrc9O5sqFt
         PncFb8Eh7Im9rtRs28R7o10bH3mxMhjPen+jdZeqpWOX228162hjesxm/K5/TSpBE5nv
         N37DWgusUl/PWRKq1Hj/mrcNm+atMCCyFvJ8UYZ/aa3fpHRT+BkIOV7/QqJiovYrva1w
         m/CCwyE9GXiSRQ8THr+RNsqa9i/IrU7X/bURgdHS5CBZnPtBaW+/4IJaBz7WwUh0irDy
         jDH8m//felrCfYV8avluhAlUGCwuKt0actqKokAxQChxWGYsdvcPWwjTKXLbfScBc0Ud
         diGA==
X-Gm-Message-State: AOAM532/K4fa50ashbvTWOBUrHTxADm2BjDKT7+0mw6DmgdwXp9tGPqw
        tzXyqrXCmw/tFDcmjjFUdM8Wgdgm8ek=
X-Google-Smtp-Source: ABdhPJzuknYifE3KPt5cVuBI+RL/qmqMB1RznGFPDXHlgg/SO4wWp2Q/1kzjyHxtcauARjqGVJ7rGg==
X-Received: by 2002:a17:90a:728b:: with SMTP id e11mr1729887pjg.107.1632783621244;
        Mon, 27 Sep 2021 16:00:21 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id 23sm20582922pfw.97.2021.09.27.16.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:00:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/devfreq: Add 1ms delay before clamping freq
Date:   Mon, 27 Sep 2021 16:04:54 -0700
Message-Id: <20210927230455.1066297-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927230455.1066297-1-robdclark@gmail.com>
References: <20210927230455.1066297-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add a short delay before clamping to idle frequency on active->idle
transition.  It takes ~0.5ms to increase the freq again on the next
idle->active transition, so this helps avoid extra freq transitions
on workloads that bounce between CPU and GPU.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Note that this sort of re-introduces the theoretical race solved
by [1].. but that should not be a problem with something along the
lines of [2]. 

[1] https://patchwork.freedesktop.org/patch/455910/?series=95111&rev=1
[2] https://patchwork.freedesktop.org/patch/455928/?series=95119&rev=1

 drivers/gpu/drm/msm/msm_gpu.h         |  7 +++++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 38 +++++++++++++++++++++------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 32a859307e81..2fcb6c195865 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -120,6 +120,13 @@ struct msm_gpu_devfreq {
 	 * it is inactive.
 	 */
 	unsigned long idle_freq;
+
+	/**
+	 * idle_work:
+	 *
+	 * Used to delay clamping to idle freq on active->idle transition.
+	 */
+	struct msm_hrtimer_work idle_work;
 };
 
 struct msm_gpu {
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 15b64f35c0f6..36e1930ee26d 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -96,8 +96,12 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
 	.get_cur_freq = msm_devfreq_get_cur_freq,
 };
 
+static void msm_devfreq_idle_work(struct kthread_work *work);
+
 void msm_devfreq_init(struct msm_gpu *gpu)
 {
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+
 	/* We need target support to do devfreq */
 	if (!gpu->funcs->gpu_busy)
 		return;
@@ -113,25 +117,27 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 	msm_devfreq_profile.freq_table = NULL;
 	msm_devfreq_profile.max_state = 0;
 
-	gpu->devfreq.devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
+	df->devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
 			&msm_devfreq_profile, DEVFREQ_GOV_SIMPLE_ONDEMAND,
 			NULL);
 
-	if (IS_ERR(gpu->devfreq.devfreq)) {
+	if (IS_ERR(df->devfreq)) {
 		DRM_DEV_ERROR(&gpu->pdev->dev, "Couldn't initialize GPU devfreq\n");
-		gpu->devfreq.devfreq = NULL;
+		df->devfreq = NULL;
 		return;
 	}
 
-	devfreq_suspend_device(gpu->devfreq.devfreq);
+	devfreq_suspend_device(df->devfreq);
 
-	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node,
-			gpu->devfreq.devfreq);
+	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node, df->devfreq);
 	if (IS_ERR(gpu->cooling)) {
 		DRM_DEV_ERROR(&gpu->pdev->dev,
 				"Couldn't register GPU cooling device\n");
 		gpu->cooling = NULL;
 	}
+
+	msm_hrtimer_work_init(&df->idle_work, gpu->worker, msm_devfreq_idle_work,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 
 void msm_devfreq_cleanup(struct msm_gpu *gpu)
@@ -179,6 +185,11 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	unsigned int idle_time;
 	unsigned long target_freq = df->idle_freq;
 
+	/*
+	 * Cancel any pending transition to idle frequency:
+	 */
+	hrtimer_cancel(&df->idle_work.timer);
+
 	/*
 	 * Hold devfreq lock to synchronize with get_dev_status()/
 	 * target() callbacks
@@ -209,9 +220,12 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	mutex_unlock(&df->devfreq->lock);
 }
 
-void msm_devfreq_idle(struct msm_gpu *gpu)
+
+static void msm_devfreq_idle_work(struct kthread_work *work)
 {
-	struct msm_gpu_devfreq *df = &gpu->devfreq;
+	struct msm_gpu_devfreq *df = container_of(work,
+			struct msm_gpu_devfreq, idle_work.work);
+	struct msm_gpu *gpu = container_of(df, struct msm_gpu, devfreq);
 	unsigned long idle_freq, target_freq = 0;
 
 	/*
@@ -229,3 +243,11 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
 
 	mutex_unlock(&df->devfreq->lock);
 }
+
+void msm_devfreq_idle(struct msm_gpu *gpu)
+{
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+
+	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
+			       HRTIMER_MODE_ABS);
+}
-- 
2.31.1

