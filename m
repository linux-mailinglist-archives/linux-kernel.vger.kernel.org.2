Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2C3C6BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhGMHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234515AbhGMHza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CD1461361;
        Tue, 13 Jul 2021 07:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162761;
        bh=0xRsudUEleFZK1Vqil+30C1aXcvOT1Mv+v7OUdVPsQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQYqiduM5+oNijrWuK+YM7JtP4Z7BFVBRhlDSbIwirjOsahtF4C8vEUScbiHOUzEu
         dUCiHt/moTTG6STiGzh9T7gTdGyOHIF95E2fcIO/F/zg5qudMlAhk7ZhuYWBNlar8Y
         38gBxeb1gZsOj1VdJ+a2fnRToENVVizhXYRPlxjPzAf48ZRBI/a2XY8KSpHvGrYRuG
         z7X0RCC8W7suadH39tx7ZnCftdQpwOE6d6aPvFDpZlfV5E45TjnIlMV01HXTp+LzYW
         s9EqPjYO+LMe+LK5JjgibMwOqIrX8tYK4v8r5DrpUpEs/G6OvS3iA+miCrnSJ8FDlO
         e5ULsQmR7dNhQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 09/11] habanalabs: signal/wait change sync object reset flow
Date:   Tue, 13 Jul 2021 10:52:24 +0300
Message-Id: <20210713075226.11094-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Currently the SOB reset was in fence release function which happens
only at the CS wraparound during the CS allocation time.

In order to support the new encapsulated signals reservation feature,
we need to move the SOB reset to an earlier phase because this SOB
could reach it's max value very fast using the signal reservation.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 104 ++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h   |   2 +-
 drivers/misc/habanalabs/common/hw_queue.c     |  56 +++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c         |  34 ++++--
 drivers/misc/habanalabs/goya/goya.c           |   4 +-
 5 files changed, 141 insertions(+), 59 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ba0c854b2ed4..458cdf2ddab5 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -52,6 +52,24 @@ void hl_sob_reset_error(struct kref *ref)
 		hw_sob->q_idx, hw_sob->sob_id);
 }
 
+static void hw_sob_put(struct hl_hw_sob *hw_sob)
+{
+	if (hw_sob)
+		kref_put(&hw_sob->kref, hl_sob_reset);
+}
+
+static void hw_sob_put_err(struct hl_hw_sob *hw_sob)
+{
+	if (hw_sob)
+		kref_put(&hw_sob->kref, hl_sob_reset_error);
+}
+
+static void hw_sob_get(struct hl_hw_sob *hw_sob)
+{
+	if (hw_sob)
+		kref_get(&hw_sob->kref);
+}
+
 /**
  * hl_gen_sob_mask() - Generates a sob mask to be used in a monitor arm packet
  * @sob_base: sob base id
@@ -122,31 +140,7 @@ static void hl_fence_release(struct kref *kref)
 		container_of(kref, struct hl_fence, refcount);
 	struct hl_cs_compl *hl_cs_cmpl =
 		container_of(fence, struct hl_cs_compl, base_fence);
-	struct hl_device *hdev = hl_cs_cmpl->hdev;
 
-	/* EBUSY means the CS was never submitted and hence we don't have
-	 * an attached hw_sob object that we should handle here
-	 */
-	if (fence->error == -EBUSY)
-		goto free;
-
-	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
-		(hl_cs_cmpl->type == CS_TYPE_WAIT) ||
-		(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)) {
-
-		dev_dbg(hdev->dev,
-			"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
-			hl_cs_cmpl->cs_seq,
-			hl_cs_cmpl->type,
-			hl_cs_cmpl->hw_sob->sob_id,
-			hl_cs_cmpl->sob_val);
-
-		queue_work(hdev->sob_reset_wq, &hl_cs_cmpl->sob_reset_work);
-
-		return;
-	}
-
-free:
 	kfree(hl_cs_cmpl);
 }
 
@@ -567,11 +561,46 @@ static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 	}
 }
 
+static inline void cs_release_sob_reset_handler(struct hl_device *hdev,
+					struct hl_cs *cs,
+					struct hl_cs_compl *hl_cs_cmpl)
+{
+	/* Skip this handler if the cs wasn't submitted, to avoid putting
+	 * the hw_sob twice, since this case already handled at this point,
+	 * also skip if the hw_sob pointer wasn't set.
+	 */
+	if (!hl_cs_cmpl->hw_sob || !cs->submitted)
+		return;
+
+	spin_lock(&hl_cs_cmpl->lock);
+
+	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
+			(hl_cs_cmpl->type == CS_TYPE_WAIT) ||
+			(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)) {
+		dev_dbg(hdev->dev,
+				"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
+				hl_cs_cmpl->cs_seq,
+				hl_cs_cmpl->type,
+				hl_cs_cmpl->hw_sob->sob_id,
+				hl_cs_cmpl->sob_val);
+
+		hw_sob_put(hl_cs_cmpl->hw_sob);
+
+		if (hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)
+			hdev->asic_funcs->reset_sob_group(hdev,
+					hl_cs_cmpl->sob_group);
+	}
+
+	spin_unlock(&hl_cs_cmpl->lock);
+}
+
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs, refcount);
 	struct hl_device *hdev = cs->ctx->hdev;
 	struct hl_cs_job *job, *tmp;
+	struct hl_cs_compl *hl_cs_cmpl =
+			container_of(cs->fence, struct hl_cs_compl, base_fence);
 
 	cs->completed = true;
 
@@ -587,8 +616,9 @@ static void cs_do_release(struct kref *ref)
 		complete_job(hdev, job);
 
 	if (!cs->submitted) {
-		/* In case the wait for signal CS was submitted, the put occurs
-		 * in init_signal_wait_cs() or collective_wait_init_cs()
+		/*
+		 * In case the wait for signal CS was submitted, the fence put
+		 * occurs in init_signal_wait_cs() or collective_wait_init_cs()
 		 * right before hanging on the PQ.
 		 */
 		if (cs->type == CS_TYPE_WAIT ||
@@ -661,6 +691,9 @@ static void cs_do_release(struct kref *ref)
 		cs->fence->timestamp = ktime_get();
 	complete_all(&cs->fence->completion);
 	complete_multi_cs(hdev, cs);
+
+	cs_release_sob_reset_handler(hdev, cs, hl_cs_cmpl);
+
 	hl_fence_put(cs->fence);
 
 	kfree(cs->jobs_in_queue_cnt);
@@ -1630,7 +1663,7 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 
 	prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
 
-	kref_get(&sob->kref);
+	hw_sob_get(sob);
 
 	/* check for wraparound */
 	if (prop->next_sob_val + count >= HL_MAX_SOB_VAL) {
@@ -1640,7 +1673,7 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 		 * just incremented the refcount right before calling this
 		 * function.
 		 */
-		kref_put(&sob->kref, hl_sob_reset_error);
+		hw_sob_put_err(sob);
 
 		/*
 		 * check the other sob value, if it still in use then fail
@@ -1797,6 +1830,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_fence *sig_fence = NULL;
 	struct hl_ctx *ctx = hpriv->ctx;
 	enum hl_queue_type q_type;
+	bool is_wait_cs = false;
 	struct hl_cs *cs;
 	u64 signal_seq;
 	int rc;
@@ -1849,6 +1883,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	}
 
 	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_COLLECTIVE_WAIT) {
+		is_wait_cs = true;
+
 		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq, ctx);
 		if (rc)
 			goto free_cs_chunk_array;
@@ -1894,9 +1930,9 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	rc = allocate_cs(hdev, ctx, cs_type, ULLONG_MAX, &cs, flags, timeout);
 	if (rc) {
-		if (cs_type == CS_TYPE_WAIT ||
-			cs_type == CS_TYPE_COLLECTIVE_WAIT)
+		if (is_wait_cs)
 			hl_fence_put(sig_fence);
+
 		goto free_cs_chunk_array;
 	}
 
@@ -1928,7 +1964,13 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
-		if (rc != -EAGAIN)
+		/* In case wait cs failed here, it means the signal cs
+		 * already completed. we want to free all it's related objects
+		 * but we don't want to fail the ioctl.
+		 */
+		if (is_wait_cs)
+			rc = 0;
+		else if (rc != -EAGAIN)
 			dev_err(hdev->dev,
 				"Failed to submit CS %d.%llu to H/W queues, error %d\n",
 				ctx->asid, cs->sequence, rc);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6d5154434637..bf327cb7ddd6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1244,7 +1244,7 @@ struct hl_asic_funcs {
 	void (*reset_sob_group)(struct hl_device *hdev, u16 sob_group);
 	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 	u64 (*get_device_time)(struct hl_device *hdev);
-	void (*collective_wait_init_cs)(struct hl_cs *cs);
+	int (*collective_wait_init_cs)(struct hl_cs *cs);
 	int (*collective_wait_create_jobs)(struct hl_device *hdev,
 			struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
 			u32 collective_engine_id);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index f05a0dbd0990..2494bd6e9358 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -416,8 +416,9 @@ static int init_signal_cs(struct hl_device *hdev,
 	cs_cmpl->sob_val = prop->next_sob_val;
 
 	dev_dbg(hdev->dev,
-		"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d\n",
-		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx);
+		"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d, seq: %llu\n",
+		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx,
+		cs_cmpl->cs_seq);
 
 	/* we set an EB since we must make sure all oeprations are done
 	 * when sending the signal
@@ -430,7 +431,7 @@ static int init_signal_cs(struct hl_device *hdev,
 	return rc;
 }
 
-static void init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
+static int init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
 		struct hl_cs_job *job, struct hl_cs_compl *cs_cmpl)
 {
 	struct hl_cs_compl *signal_cs_cmpl;
@@ -449,10 +450,33 @@ static void init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
 	cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
 	cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
 
+	/* check again if the signal cs already completed.
+	 * if yes then don't send any wait cs since the hw_sob
+	 * could be in reset already. if signal is not completed
+	 * then get refcount to hw_sob to prevent resetting the sob
+	 * while wait cs is not submitted.
+	 * note that this check is protected by two locks,
+	 * hw queue lock and completion object lock,
+	 * and the same completion object lock also protects
+	 * the hw_sob reset handler function.
+	 * The hw_queue lock prevent out of sync of hw_sob
+	 * refcount value, changed by signal/wait flows.
+	 */
+	spin_lock(&signal_cs_cmpl->lock);
+
+	if (completion_done(&cs->signal_fence->completion)) {
+		spin_unlock(&signal_cs_cmpl->lock);
+		return -EINVAL;
+	}
+
+	kref_get(&cs_cmpl->hw_sob->kref);
+
+	spin_unlock(&signal_cs_cmpl->lock);
+
 	dev_dbg(hdev->dev,
-		"generate wait CB, sob_id: %d, sob_val: 0x%x, mon_id: %d, q_idx: %d\n",
+		"generate wait CB, sob_id: %d, sob_val: 0x%x, mon_id: %d, q_idx: %d, seq: %llu\n",
 		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val,
-		prop->base_mon_id, q_idx);
+		prop->base_mon_id, q_idx, cs->sequence);
 
 	wait_prop.data = (void *) job->patched_cb;
 	wait_prop.sob_base = cs_cmpl->hw_sob->sob_id;
@@ -461,17 +485,14 @@ static void init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
 	wait_prop.mon_id = prop->base_mon_id;
 	wait_prop.q_idx = q_idx;
 	wait_prop.size = 0;
+
 	hdev->asic_funcs->gen_wait_cb(hdev, &wait_prop);
 
-	kref_get(&cs_cmpl->hw_sob->kref);
-	/*
-	 * Must put the signal fence after the SOB refcnt increment so
-	 * the SOB refcnt won't turn 0 and reset the SOB before the
-	 * wait CS was submitted.
-	 */
 	mb();
 	hl_fence_put(cs->signal_fence);
 	cs->signal_fence = NULL;
+
+	return 0;
 }
 
 /*
@@ -496,7 +517,7 @@ static int init_signal_wait_cs(struct hl_cs *cs)
 	if (cs->type & CS_TYPE_SIGNAL)
 		rc = init_signal_cs(hdev, job, cs_cmpl);
 	else if (cs->type & CS_TYPE_WAIT)
-		init_wait_cs(hdev, cs, job, cs_cmpl);
+		rc = init_wait_cs(hdev, cs, job, cs_cmpl);
 
 	return rc;
 }
@@ -571,12 +592,13 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 	if ((cs->type == CS_TYPE_SIGNAL) || (cs->type == CS_TYPE_WAIT)) {
 		rc = init_signal_wait_cs(cs);
-		if (rc) {
-			dev_err(hdev->dev, "Failed to submit signal cs\n");
+		if (rc)
 			goto unroll_cq_resv;
-		}
-	} else if (cs->type == CS_TYPE_COLLECTIVE_WAIT)
-		hdev->asic_funcs->collective_wait_init_cs(cs);
+	} else if (cs->type == CS_TYPE_COLLECTIVE_WAIT) {
+		rc = hdev->asic_funcs->collective_wait_init_cs(cs);
+		if (rc)
+			goto unroll_cq_resv;
+	}
 
 
 	spin_lock(&hdev->cs_mirror_lock);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a4b33b0b17d4..5b7a5692cd21 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1239,7 +1239,7 @@ static void gaudi_collective_slave_init_job(struct hl_device *hdev,
 			prop->collective_sob_id, cb_size, false);
 }
 
-static void gaudi_collective_wait_init_cs(struct hl_cs *cs)
+static int gaudi_collective_wait_init_cs(struct hl_cs *cs)
 {
 	struct hl_cs_compl *signal_cs_cmpl =
 		container_of(cs->signal_fence, struct hl_cs_compl, base_fence);
@@ -1261,6 +1261,29 @@ static void gaudi_collective_wait_init_cs(struct hl_cs *cs)
 	cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
 	cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
 
+	/* check again if the signal cs already completed.
+	 * if yes then don't send any wait cs since the hw_sob
+	 * could be in reset already. if signal is not completed
+	 * then get refcount to hw_sob to prevent resetting the sob
+	 * while wait cs is not submitted.
+	 * note that this check is protected by two locks,
+	 * hw queue lock and completion object lock,
+	 * and the same completion object lock also protects
+	 * the hw_sob reset handler function.
+	 * The hw_queue lock prevent out of sync of hw_sob
+	 * refcount value, changed by signal/wait flows.
+	 */
+	spin_lock(&signal_cs_cmpl->lock);
+
+	if (completion_done(&cs->signal_fence->completion)) {
+		spin_unlock(&signal_cs_cmpl->lock);
+		return -EINVAL;
+	}
+	/* Increment kref since all slave queues are now waiting on it */
+	kref_get(&cs_cmpl->hw_sob->kref);
+
+	spin_unlock(&signal_cs_cmpl->lock);
+
 	/* Calculate the stream from collective master queue (1st job) */
 	job = list_first_entry(&cs->job_list, struct hl_cs_job, cs_node);
 	stream = job->hw_queue_id % 4;
@@ -1304,16 +1327,11 @@ static void gaudi_collective_wait_init_cs(struct hl_cs *cs)
 				cprop->curr_sob_group_idx[stream], stream);
 	}
 
-	/* Increment kref since all slave queues are now waiting on it */
-	kref_get(&cs_cmpl->hw_sob->kref);
-	/*
-	 * Must put the signal fence after the SOB refcnt increment so
-	 * the SOB refcnt won't turn 0 and reset the SOB before the
-	 * wait CS was submitted.
-	 */
 	mb();
 	hl_fence_put(cs->signal_fence);
 	cs->signal_fence = NULL;
+
+	return 0;
 }
 
 static int gaudi_collective_wait_create_job(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f6251d8663b2..dd218a4bb62e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5480,9 +5480,9 @@ u64 goya_get_device_time(struct hl_device *hdev)
 	return device_time | RREG32(mmPSOC_TIMESTAMP_CNTCVL);
 }
 
-static void goya_collective_wait_init_cs(struct hl_cs *cs)
+static int goya_collective_wait_init_cs(struct hl_cs *cs)
 {
-
+	return 0;
 }
 
 static int goya_collective_wait_create_jobs(struct hl_device *hdev,
-- 
2.25.1

