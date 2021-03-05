Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8261D32F09D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCEREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhCERD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:03:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E45C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 09:03:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d15so2861618wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RsjSwA8oB0o8PW0ry99uhxTdXQdH9BOaf5mimdTgeO0=;
        b=oNEKdz6xPt7rWWlY08YTlqJ+lKrJjFhTuySIUMQ0e+4R72ftmlHWkmFwbJE/yj/0L9
         KQMDY7H55bE4DUmCGgWXZyl+eFIMBmfgbneFavsgAAhHFKhJqgZ0E2SRJFr8EYlYdBX3
         HLYPLXCO66AqeADhGbMjohltUr1f+KTc3M9FN9QB1IMSKfgOS5XfD/kaKEdd5SRqmln3
         ckKfK0l4tR15SPjWq+QWJuU49+H+lNH4Fuxx/IhwJfx6LBmYllz+9uOYVE1kgQg8wMgQ
         DUzBop11GMlwrMWg2owHd0e46fK8c8XFG/ErkGfIy15tj6hntwGkhRBFjr1eyuGxUJT6
         9Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RsjSwA8oB0o8PW0ry99uhxTdXQdH9BOaf5mimdTgeO0=;
        b=JL2YQwHABZ5UdNNM02RxKMaC1I/w0fhWT1pJL8s63JfxccVFAlTJP+l9exr9BDqvA1
         lvigACVi6PD6rwdyj+/qHS8zcba/dRaZCRbQSdoHuSAc3x3bUmZH6Ib3TJ+N5WqRkp2x
         e1SLhYLkCL0qWk8Os1mac/furs6CJH9jGGtOGDbwCGYAGCA2hp2Op0c1IUeT/hxNB0XR
         NnTqrI+BtXONlYwQS3dwQrd0jB5i1qtFu2/j4fqxwRqgxZ1Hm6AIJm399atHuw/4/Dx7
         G5793XNPD+i4yBstLu4sudWGWblvfEITg5QUMunx2l1L0GDS60k4zmi3YavhBMP7PLNn
         SxXQ==
X-Gm-Message-State: AOAM533xQ6pzrW/7G2/5ocT0VVhOJ96B9p4pNz956q2ocPG2ATO2nHyT
        GDmh2X9nmjZaQNeupoFhkABTqw==
X-Google-Smtp-Source: ABdhPJydYEppXPz3sewV0+dccHxbmeBJKVjPuVHQAf0k543BYpWsmppZxZNmbBiyB1toc0Djs2GAuA==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr10821095wrw.247.1614963833977;
        Fri, 05 Mar 2021 09:03:53 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id p17sm4760934wmq.47.2021.03.05.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:03:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU)
Subject: [PATCH v2 3/4] devfreq/drivers/msm: Use devfreq cooling device registration
Date:   Fri,  5 Mar 2021 18:03:36 +0100
Message-Id: <20210305170338.13647-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305170338.13647-1-daniel.lezcano@linaro.org>
References: <20210305170338.13647-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq core code is able to register the devfreq device as a
cooling device if the 'is_cooling_device' flag is set in the profile.

Use this flag and remove the cooling device registering code.

Tested on dragonboard 845c

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 12 +-----------
 drivers/gpu/drm/msm/msm_gpu.h |  2 --
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index ab7c167b0623..eade94271a60 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -14,7 +14,6 @@
 #include <generated/utsrelease.h>
 #include <linux/string_helpers.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/devcoredump.h>
 #include <linux/sched/task.h>
 
@@ -82,6 +81,7 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
 	.target = msm_devfreq_target,
 	.get_dev_status = msm_devfreq_get_dev_status,
 	.get_cur_freq = msm_devfreq_get_cur_freq,
+	.is_cooling_device = true,
 };
 
 static void msm_devfreq_init(struct msm_gpu *gpu)
@@ -112,14 +112,6 @@ static void msm_devfreq_init(struct msm_gpu *gpu)
 	}
 
 	devfreq_suspend_device(gpu->devfreq.devfreq);
-
-	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node,
-			gpu->devfreq.devfreq);
-	if (IS_ERR(gpu->cooling)) {
-		DRM_DEV_ERROR(&gpu->pdev->dev,
-				"Couldn't register GPU cooling device\n");
-		gpu->cooling = NULL;
-	}
 }
 
 static int enable_pwrrail(struct msm_gpu *gpu)
@@ -1056,6 +1048,4 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 	if (gpu->worker) {
 		kthread_destroy_worker(gpu->worker);
 	}
-
-	devfreq_cooling_unregister(gpu->cooling);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d7cd02cd2109..93419368bac8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -155,8 +155,6 @@ struct msm_gpu {
 	struct msm_gpu_state *crashstate;
 	/* True if the hardware supports expanded apriv (a650 and newer) */
 	bool hw_apriv;
-
-	struct thermal_cooling_device *cooling;
 };
 
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
-- 
2.17.1

