Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8237C6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhELPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:54:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234968AbhELP0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:26:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB59231B;
        Wed, 12 May 2021 08:24:54 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84CF73F718;
        Wed, 12 May 2021 08:24:53 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH] drm/panfrost: Handle failure in panfrost_job_hw_submit()
Date:   Wed, 12 May 2021 16:24:19 +0100
Message-Id: <20210512152419.30003-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently panfrost_job_hw_submit() returns void and therefore cannot
propagate failures to it's caller, which is a shame because it has two
failure paths. Currently these are handled by waiting for a job timeout
on the job even though it was never submitted. But we can do better.

Refactor to return a failure code from panfrost_job_hw_submit() and
report the failure back to the DRM scheduler. This means there's no need
to wait for the scheduler to timeout on the job and the failure can be
handled immediately.

Signed-off-by: Steven Price <steven.price@arm.com>

---
This hopefully will also stop future reports of a PM reference
leak[1][2] which doesn't actually exist.

[1] https://lore.kernel.org/r/20200520110504.24388-1-dinghao.liu%40zju.edu.cn
[2] https://lore.kernel.org/r/1620714551-106976-1-git-send-email-zou_wei%40huawei.com
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 27 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 6003cfeb1322..ac1ae38aaf12 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -148,21 +148,22 @@ static void panfrost_job_write_affinity(struct panfrost_device *pfdev,
 	job_write(pfdev, JS_AFFINITY_NEXT_HI(js), affinity >> 32);
 }
 
-static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
+static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
 	u32 cfg;
 	u64 jc_head = job->jc;
 	int ret;
 
-	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
-
-	ret = pm_runtime_get_sync(pfdev->dev);
+	ret = pm_runtime_resume_and_get(pfdev->dev);
 	if (ret < 0)
-		return;
+		return ret;
+
+	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		return;
+		pm_runtime_put_autosuspend(pfdev->dev);
+		return -EBUSY;
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
@@ -194,6 +195,8 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 				job, js, jc_head);
 
 	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
+
+	return 0;
 }
 
 static void panfrost_acquire_object_fences(struct drm_gem_object **bos,
@@ -347,12 +350,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int err;
 
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
 
-	pfdev->jobs[slot] = job;
-
 	fence = panfrost_fence_create(pfdev, slot);
 	if (IS_ERR(fence))
 		return NULL;
@@ -361,7 +363,14 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	panfrost_job_hw_submit(job, slot);
+	err = panfrost_job_hw_submit(job, slot);
+
+	if (err) {
+		dma_fence_put(fence);
+		return NULL;
+	}
+
+	pfdev->jobs[slot] = job;
 
 	return fence;
 }
-- 
2.20.1

