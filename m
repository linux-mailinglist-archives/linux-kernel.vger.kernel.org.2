Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394E945803C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 20:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhKTT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 14:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhKTT7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 14:59:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B8C061574;
        Sat, 20 Nov 2021 11:56:02 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y7so10798696plp.0;
        Sat, 20 Nov 2021 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1dwVFSwPh1gZK9xVb840bb6p/IVMM8HN6jf7GNmsv8=;
        b=aiz3Znse4ZuHoB8Y27cqZz6Dc+xrqdlz4rmdfAbjMmrXoWPVZnTDa9qNsxcd0/UnFJ
         UDMLan7xSkiZGhoIeb8FZyj1WwsWulofWPesRO+Ms3+aCTBDPl+NMBa3MZ1wa+rc0Kg9
         kLj8GCLX5nDmgDGiEIygdMOX8ITS1p8iY0jpKlesTZAa24p0I8bE1PgCz1LfRYJuuxeI
         l8TJiHZnEIfa2uNiisjj4BaP6Dr1C84TzuIMCDitgnVzvr11jZ440mkUtg1rpQK5e/NY
         JgPf7QYygxILTrxRT6u4ljWgfFnlc6k6NflcpxT9SQUihvs60PqXXjrAMAuExKaS7Tyx
         0Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1dwVFSwPh1gZK9xVb840bb6p/IVMM8HN6jf7GNmsv8=;
        b=ax9mTZLttxp87jDc3OaLK/vkLoZWLGX7wVoaN9rXGzxa4hren2iVVk3I5k6oNNmUjH
         7cWwhK+EGma9RpQ48hcgo9/CqHSrOc+xF+Y6r19kVRGrQRnTIaii9iclsN83rHyfTAMi
         Dg3e7gaAOxAqVcQnoG52e0bbgN3ztsnHe/wEJNZ+aw4Qr3Wp1oQY0adxcVqA8zrcRw9I
         ABL8LIWiE1azpkoJa+VyLW/dLgwYam5vEe8vWlRtb3/4RDVP6i7tkTAwoynN1EK6GEPI
         4Kr7fMuDbrTkW7K+9e557BoxTbqT9fVr94SSOhYpu8kaIoqf800GVxtUlVbwG6WqQWWI
         Cqyw==
X-Gm-Message-State: AOAM5303UZjjyvz9PmfdU6TRLfvej6+Z7cMtf2T42/Rytt2YbffDgGCD
        zq29YSbim2+D2svbtMpKVAKh3n4eX58=
X-Google-Smtp-Source: ABdhPJyTUn25c2nvqG0xCnmcIBGI0u36ick202i9Hr17UaG9DR8rfq+1/Br42AhNlOriqwC9pmB9mA==
X-Received: by 2002:a17:902:c204:b0:142:2441:aa26 with SMTP id 4-20020a170902c20400b001422441aa26mr89673182pll.84.1637438161752;
        Sat, 20 Nov 2021 11:56:01 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id b19sm3960013pfv.63.2021.11.20.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 11:56:00 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm/gpu: Respect PM QoS constraints
Date:   Sat, 20 Nov 2021 12:01:03 -0800
Message-Id: <20211120200103.1051459-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120200103.1051459-1-robdclark@gmail.com>
References: <20211120200103.1051459-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Re-work the boost and idle clamping to use PM QoS requests instead, so
they get aggreggated with other requests (such as cooling device).

This does have the minor side-effect that devfreq sysfs min_freq/
max_freq files now reflect the boost and idle clamping, as they show
(despite what they are documented to show) the aggregated min/max freq.
Fixing that in devfreq does not look straightforward after considering
that OPPs can be dynamically added/removed.  However writes to the
sysfs files still behave as expected.

v2: Use 64b math to avoid potential 32b overflow

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.h         | 33 +++++++---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 87 +++++++++++++++------------
 2 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 59cdd00b69d0..96d8d37dd5b7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -87,6 +87,21 @@ struct msm_gpu_devfreq {
 	/** devfreq: devfreq instance */
 	struct devfreq *devfreq;
 
+	/**
+	 * idle_constraint:
+	 *
+	 * A PM QoS constraint to limit max freq while the GPU is idle.
+	 */
+	struct dev_pm_qos_request idle_freq;
+
+	/**
+	 * boost_constraint:
+	 *
+	 * A PM QoS constraint to boost min freq for a period of time
+	 * until the boost expires.
+	 */
+	struct dev_pm_qos_request boost_freq;
+
 	/**
 	 * busy_cycles:
 	 *
@@ -103,22 +118,19 @@ struct msm_gpu_devfreq {
 	ktime_t idle_time;
 
 	/**
-	 * idle_freq:
+	 * idle_work:
 	 *
-	 * Shadow frequency used while the GPU is idle.  From the PoV of
-	 * the devfreq governor, we are continuing to sample busyness and
-	 * adjust frequency while the GPU is idle, but we use this shadow
-	 * value as the GPU is actually clamped to minimum frequency while
-	 * it is inactive.
+	 * Used to delay clamping to idle freq on active->idle transition.
 	 */
-	unsigned long idle_freq;
+	struct msm_hrtimer_work idle_work;
 
 	/**
-	 * idle_work:
+	 * boost_work:
 	 *
-	 * Used to delay clamping to idle freq on active->idle transition.
+	 * Used to reset the boost_constraint after the boost period has
+	 * elapsed
 	 */
-	struct msm_hrtimer_work idle_work;
+	struct msm_hrtimer_work boost_work;
 };
 
 struct msm_gpu {
@@ -498,6 +510,7 @@ void msm_devfreq_init(struct msm_gpu *gpu);
 void msm_devfreq_cleanup(struct msm_gpu *gpu);
 void msm_devfreq_resume(struct msm_gpu *gpu);
 void msm_devfreq_suspend(struct msm_gpu *gpu);
+void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor);
 void msm_devfreq_active(struct msm_gpu *gpu);
 void msm_devfreq_idle(struct msm_gpu *gpu);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 1f55242bb6a1..11be623de2ab 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -9,6 +9,7 @@
 
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
+#include <linux/units.h>
 
 /*
  * Power Management:
@@ -22,15 +23,6 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 
-	/*
-	 * If the GPU is idle, devfreq is not aware, so just ignore
-	 * it's requests
-	 */
-	if (gpu->devfreq.idle_freq) {
-		gpu->devfreq.idle_freq = *freq;
-		return 0;
-	}
-
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 
@@ -48,9 +40,6 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 
 static unsigned long get_freq(struct msm_gpu *gpu)
 {
-	if (gpu->devfreq.idle_freq)
-		return gpu->devfreq.idle_freq;
-
 	if (gpu->funcs->gpu_get_freq)
 		return gpu->funcs->gpu_get_freq(gpu);
 
@@ -88,6 +77,7 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
 	.get_cur_freq = msm_devfreq_get_cur_freq,
 };
 
+static void msm_devfreq_boost_work(struct kthread_work *work);
 static void msm_devfreq_idle_work(struct kthread_work *work);
 
 void msm_devfreq_init(struct msm_gpu *gpu)
@@ -98,6 +88,12 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 	if (!gpu->funcs->gpu_busy)
 		return;
 
+	dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
+			       DEV_PM_QOS_MAX_FREQUENCY,
+			       PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	dev_pm_qos_add_request(&gpu->pdev->dev, &df->boost_freq,
+			       DEV_PM_QOS_MIN_FREQUENCY, 0);
+
 	msm_devfreq_profile.initial_freq = gpu->fast_rate;
 
 	/*
@@ -128,13 +124,19 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 		gpu->cooling = NULL;
 	}
 
+	msm_hrtimer_work_init(&df->boost_work, gpu->worker, msm_devfreq_boost_work,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	msm_hrtimer_work_init(&df->idle_work, gpu->worker, msm_devfreq_idle_work,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 
 void msm_devfreq_cleanup(struct msm_gpu *gpu)
 {
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+
 	devfreq_cooling_unregister(gpu->cooling);
+	dev_pm_qos_remove_request(&df->boost_freq);
+	dev_pm_qos_remove_request(&df->idle_freq);
 }
 
 void msm_devfreq_resume(struct msm_gpu *gpu)
@@ -150,12 +152,40 @@ void msm_devfreq_suspend(struct msm_gpu *gpu)
 	devfreq_suspend_device(gpu->devfreq.devfreq);
 }
 
+static void msm_devfreq_boost_work(struct kthread_work *work)
+{
+	struct msm_gpu_devfreq *df = container_of(work,
+			struct msm_gpu_devfreq, boost_work.work);
+
+	dev_pm_qos_update_request(&df->boost_freq, 0);
+}
+
+void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
+{
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+	uint64_t freq;
+
+	freq = get_freq(gpu);
+	freq *= factor;
+
+	/*
+	 * A nice little trap is that PM QoS operates in terms of KHz,
+	 * while devfreq operates in terms of Hz:
+	 */
+	do_div(freq, HZ_PER_KHZ);
+
+	dev_pm_qos_update_request(&df->boost_freq, freq);
+
+	msm_hrtimer_queue_work(&df->boost_work,
+			       ms_to_ktime(msm_devfreq_profile.polling_ms),
+			       HRTIMER_MODE_REL);
+}
+
 void msm_devfreq_active(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 	struct devfreq_dev_status status;
 	unsigned int idle_time;
-	unsigned long target_freq = df->idle_freq;
 
 	if (!df->devfreq)
 		return;
@@ -165,12 +195,6 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	 */
 	hrtimer_cancel(&df->idle_work.timer);
 
-	/*
-	 * Hold devfreq lock to synchronize with get_dev_status()/
-	 * target() callbacks
-	 */
-	mutex_lock(&df->devfreq->lock);
-
 	idle_time = ktime_to_ms(ktime_sub(ktime_get(), df->idle_time));
 
 	/*
@@ -179,20 +203,17 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	 * the governor to ramp up the freq.. so give some boost
 	 */
 	if (idle_time > msm_devfreq_profile.polling_ms) {
-		target_freq *= 2;
+		msm_devfreq_boost(gpu, 2);
 	}
 
-	df->idle_freq = 0;
-
-	msm_devfreq_target(&gpu->pdev->dev, &target_freq, 0);
+	dev_pm_qos_update_request(&df->idle_freq,
+				  PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
 
 	/*
 	 * Reset the polling interval so we aren't inconsistent
 	 * about freq vs busy/total cycles
 	 */
 	msm_devfreq_get_dev_status(&gpu->pdev->dev, &status);
-
-	mutex_unlock(&df->devfreq->lock);
 }
 
 
@@ -201,23 +222,11 @@ static void msm_devfreq_idle_work(struct kthread_work *work)
 	struct msm_gpu_devfreq *df = container_of(work,
 			struct msm_gpu_devfreq, idle_work.work);
 	struct msm_gpu *gpu = container_of(df, struct msm_gpu, devfreq);
-	unsigned long idle_freq, target_freq = 0;
-
-	/*
-	 * Hold devfreq lock to synchronize with get_dev_status()/
-	 * target() callbacks
-	 */
-	mutex_lock(&df->devfreq->lock);
-
-	idle_freq = get_freq(gpu);
-
-	if (gpu->clamp_to_idle)
-		msm_devfreq_target(&gpu->pdev->dev, &target_freq, 0);
 
 	df->idle_time = ktime_get();
-	df->idle_freq = idle_freq;
 
-	mutex_unlock(&df->devfreq->lock);
+	if (gpu->clamp_to_idle)
+		dev_pm_qos_update_request(&df->idle_freq, 0);
 }
 
 void msm_devfreq_idle(struct msm_gpu *gpu)
-- 
2.33.1

