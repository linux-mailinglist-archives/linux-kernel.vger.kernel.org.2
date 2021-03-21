Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230A434348A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCUULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhCUULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:11:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29F8761947;
        Sun, 21 Mar 2021 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616357497;
        bh=Ga42NTyzBBeMU2Kia8p7ZqYAhTxDbLuFHioHE3qY0Ps=;
        h=From:To:Cc:Subject:Date:From;
        b=gLXLMa6OrdJX3icUGZp71xpIExzEP1PVeIvkFt5ghHkC9YWe5BqLM0LomeTEkceWT
         K77kCFEG0WRYFgP909SNkxCJFds74U4sj1+l/YQoOj9nyYvSosL1abI/k4yrO2Radw
         UpzesWb1r9HOQ14v1u5Nbd0KgcF+NPPWboxs2JjQ63W+r9qOEuqfqv9aPXJHI2kSmB
         U6U+1e6lcC5iHAkYZOPr8A376q9PPPJMREpIQpm6mBCG2SQ2sgKhCYu+vKkLMWo7Hh
         tx6ezYv6IE3abXUq1/dmriye1SdJvODaOKlbgqj0AIXwc+ggElV10VyiPRZdqiBLMo
         d2rHQDqjZVf5A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs: move relevant datapath work outside cs lock
Date:   Sun, 21 Mar 2021 22:11:28 +0200
Message-Id: <20210321201130.4670-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to shorten the time cs lock is being held, we move any
possible work outside of the cs lock.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 86 +++++++++++--------
 drivers/misc/habanalabs/common/device.c       | 13 ++-
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +
 3 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 720588aed28b..ba6d3e317255 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -84,6 +84,38 @@ int hl_gen_sob_mask(u16 sob_base, u8 sob_mask, u8 *mask)
 	return 0;
 }
 
+static void sob_reset_work(struct work_struct *work)
+{
+	struct hl_cs_compl *hl_cs_cmpl =
+		container_of(work, struct hl_cs_compl, sob_reset_work);
+	struct hl_device *hdev = hl_cs_cmpl->hdev;
+
+	/*
+	 * A signal CS can get completion while the corresponding wait
+	 * for signal CS is on its way to the PQ. The wait for signal CS
+	 * will get stuck if the signal CS incremented the SOB to its
+	 * max value and there are no pending (submitted) waits on this
+	 * SOB.
+	 * We do the following to void this situation:
+	 * 1. The wait for signal CS must get a ref for the signal CS as
+	 *    soon as possible in cs_ioctl_signal_wait() and put it
+	 *    before being submitted to the PQ but after it incremented
+	 *    the SOB refcnt in init_signal_wait_cs().
+	 * 2. Signal/Wait for signal CS will decrement the SOB refcnt
+	 *    here.
+	 * These two measures guarantee that the wait for signal CS will
+	 * reset the SOB upon completion rather than the signal CS and
+	 * hence the above scenario is avoided.
+	 */
+	kref_put(&hl_cs_cmpl->hw_sob->kref, hl_sob_reset);
+
+	if (hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)
+		hdev->asic_funcs->reset_sob_group(hdev,
+				hl_cs_cmpl->sob_group);
+
+	kfree(hl_cs_cmpl);
+}
+
 static void hl_fence_release(struct kref *kref)
 {
 	struct hl_fence *fence =
@@ -109,28 +141,9 @@ static void hl_fence_release(struct kref *kref)
 			hl_cs_cmpl->hw_sob->sob_id,
 			hl_cs_cmpl->sob_val);
 
-		/*
-		 * A signal CS can get completion while the corresponding wait
-		 * for signal CS is on its way to the PQ. The wait for signal CS
-		 * will get stuck if the signal CS incremented the SOB to its
-		 * max value and there are no pending (submitted) waits on this
-		 * SOB.
-		 * We do the following to void this situation:
-		 * 1. The wait for signal CS must get a ref for the signal CS as
-		 *    soon as possible in cs_ioctl_signal_wait() and put it
-		 *    before being submitted to the PQ but after it incremented
-		 *    the SOB refcnt in init_signal_wait_cs().
-		 * 2. Signal/Wait for signal CS will decrement the SOB refcnt
-		 *    here.
-		 * These two measures guarantee that the wait for signal CS will
-		 * reset the SOB upon completion rather than the signal CS and
-		 * hence the above scenario is avoided.
-		 */
-		kref_put(&hl_cs_cmpl->hw_sob->kref, hl_sob_reset);
+		queue_work(hdev->sob_reset_wq, &hl_cs_cmpl->sob_reset_work);
 
-		if (hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)
-			hdev->asic_funcs->reset_sob_group(hdev,
-					hl_cs_cmpl->sob_group);
+		return;
 	}
 
 free:
@@ -670,9 +683,23 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto free_cs;
 	}
 
+	cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
+			sizeof(*cs->jobs_in_queue_cnt), GFP_ATOMIC);
+	if (!cs->jobs_in_queue_cnt)
+		cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
+				sizeof(*cs->jobs_in_queue_cnt), GFP_KERNEL);
+
+	if (!cs->jobs_in_queue_cnt) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
+		rc = -ENOMEM;
+		goto free_cs_cmpl;
+	}
+
 	cs_cmpl->hdev = hdev;
 	cs_cmpl->type = cs->type;
 	spin_lock_init(&cs_cmpl->lock);
+	INIT_WORK(&cs_cmpl->sob_reset_work, sob_reset_work);
 	cs->fence = &cs_cmpl->base_fence;
 
 	spin_lock(&ctx->cs_lock);
@@ -702,19 +729,6 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto free_fence;
 	}
 
-	cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
-			sizeof(*cs->jobs_in_queue_cnt), GFP_ATOMIC);
-	if (!cs->jobs_in_queue_cnt)
-		cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
-				sizeof(*cs->jobs_in_queue_cnt), GFP_KERNEL);
-
-	if (!cs->jobs_in_queue_cnt) {
-		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
-		atomic64_inc(&cntr->out_of_mem_drop_cnt);
-		rc = -ENOMEM;
-		goto free_fence;
-	}
-
 	/* init hl_fence */
 	hl_fence_init(&cs_cmpl->base_fence, cs_cmpl->cs_seq);
 
@@ -737,6 +751,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 free_fence:
 	spin_unlock(&ctx->cs_lock);
+	kfree(cs->jobs_in_queue_cnt);
+free_cs_cmpl:
 	kfree(cs_cmpl);
 free_cs:
 	kfree(cs);
@@ -759,6 +775,8 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 	int i;
 	struct hl_cs *cs, *tmp;
 
+	flush_workqueue(hdev->sob_reset_wq);
+
 	/* flush all completions before iterating over the CS mirror list in
 	 * order to avoid a race with the release functions
 	 */
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index e22df6824bc3..53bc5ccb612f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -368,11 +368,19 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cq_wq;
 	}
 
+	hdev->sob_reset_wq = alloc_workqueue("hl-sob-reset", WQ_UNBOUND, 0);
+	if (!hdev->sob_reset_wq) {
+		dev_err(hdev->dev,
+			"Failed to allocate SOB reset workqueue\n");
+		rc = -ENOMEM;
+		goto free_eq_wq;
+	}
+
 	hdev->hl_chip_info = kzalloc(sizeof(struct hwmon_chip_info),
 					GFP_KERNEL);
 	if (!hdev->hl_chip_info) {
 		rc = -ENOMEM;
-		goto free_eq_wq;
+		goto free_sob_reset_wq;
 	}
 
 	hdev->idle_busy_ts_arr = kmalloc_array(HL_IDLE_BUSY_TS_ARR_SIZE,
@@ -418,6 +426,8 @@ static int device_early_init(struct hl_device *hdev)
 	kfree(hdev->idle_busy_ts_arr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
+free_sob_reset_wq:
+	destroy_workqueue(hdev->sob_reset_wq);
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
@@ -454,6 +464,7 @@ static void device_early_fini(struct hl_device *hdev)
 	kfree(hdev->idle_busy_ts_arr);
 	kfree(hdev->hl_chip_info);
 
+	destroy_workqueue(hdev->sob_reset_wq);
 	destroy_workqueue(hdev->eq_wq);
 	destroy_workqueue(hdev->device_reset_work.wq);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2dcefd6485e5..65f34918faed 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -528,6 +528,7 @@ struct hl_fence {
 
 /**
  * struct hl_cs_compl - command submission completion object.
+ * @sob_reset_work: workqueue object to run SOB reset flow.
  * @base_fence: hl fence object.
  * @lock: spinlock to protect fence.
  * @hdev: habanalabs device structure.
@@ -538,6 +539,7 @@ struct hl_fence {
  * @sob_group: the SOB group that is used in this collective wait CS.
  */
 struct hl_cs_compl {
+	struct work_struct	sob_reset_work;
 	struct hl_fence		base_fence;
 	spinlock_t		lock;
 	struct hl_device	*hdev;
@@ -1905,6 +1907,7 @@ struct hl_mmu_funcs {
  * @cq_wq: work queues of completion queues for executing work in process
  *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
+ * @sob_reset_wq: work queue for sob reset executions.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
@@ -2022,6 +2025,7 @@ struct hl_device {
 	struct hl_user_interrupt	common_user_interrupt;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
+	struct workqueue_struct		*sob_reset_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		cs_mirror_list;
-- 
2.25.1

