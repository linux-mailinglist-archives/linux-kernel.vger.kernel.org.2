Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16AE3C6BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhGMHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234569AbhGMHzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57E6261284;
        Tue, 13 Jul 2021 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162764;
        bh=4LtAZZO7EgUELA/458Z+YEg7jTxQU+YeZm4ZYwvW5Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5u8umqcHatW6ECmRkY3V2m4fyVQ5VC+cGu6RLFv1Axii/dj8twMVo0lJImZj1HD8
         t7bWZQ5T25XN3s+sdh6fWQkzhpebNafR4qu5XCabQHIkcsgZk6gi+lJhH9wfi+nW+f
         XutT4DhXTuN8usVli3O/gR0c3CuvBsjl647hM+9tD2chPQUpTQLRXGVrsL1BKa7t+1
         pFgXm/9iy6nmysb0KOFGEb8vZiMUuP0gyEQm8DKBglOoIHz19cUOzrVlAXECs08KWC
         ro+xfcuZMTSHy8TngErNZwlLzzXfzGfM7D4kXcOqZclzr4dgS4gunrrjJrfViuFuwi
         vKaRsfOj2VeSw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 11/11] habanalabs: add support for encapsulated signals submission
Date:   Tue, 13 Jul 2021 10:52:26 +0300
Message-Id: <20210713075226.11094-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

This commit is the second part of the encapsulated signals feature.
It contains the driver support for submission of cs with encapsulated
signals and the wait for them.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 187 ++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h   |  23 ++-
 drivers/misc/habanalabs/common/hw_queue.c     |  96 ++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  45 ++++-
 drivers/misc/habanalabs/goya/goya.c           |   2 +-
 5 files changed, 279 insertions(+), 74 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 84032b1bae5c..94b37ab08f90 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -106,38 +106,6 @@ int hl_gen_sob_mask(u16 sob_base, u8 sob_mask, u8 *mask)
 	return 0;
 }
 
-static void sob_reset_work(struct work_struct *work)
-{
-	struct hl_cs_compl *hl_cs_cmpl =
-		container_of(work, struct hl_cs_compl, sob_reset_work);
-	struct hl_device *hdev = hl_cs_cmpl->hdev;
-
-	/*
-	 * A signal CS can get completion while the corresponding wait
-	 * for signal CS is on its way to the PQ. The wait for signal CS
-	 * will get stuck if the signal CS incremented the SOB to its
-	 * max value and there are no pending (submitted) waits on this
-	 * SOB.
-	 * We do the following to void this situation:
-	 * 1. The wait for signal CS must get a ref for the signal CS as
-	 *    soon as possible in cs_ioctl_signal_wait() and put it
-	 *    before being submitted to the PQ but after it incremented
-	 *    the SOB refcnt in init_signal_wait_cs().
-	 * 2. Signal/Wait for signal CS will decrement the SOB refcnt
-	 *    here.
-	 * These two measures guarantee that the wait for signal CS will
-	 * reset the SOB upon completion rather than the signal CS and
-	 * hence the above scenario is avoided.
-	 */
-	kref_put(&hl_cs_cmpl->hw_sob->kref, hl_sob_reset);
-
-	if (hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)
-		hdev->asic_funcs->reset_sob_group(hdev,
-				hl_cs_cmpl->sob_group);
-
-	kfree(hl_cs_cmpl);
-}
-
 static void hl_fence_release(struct kref *kref)
 {
 	struct hl_fence *fence =
@@ -578,6 +546,11 @@ static inline void cs_release_sob_reset_handler(struct hl_device *hdev,
 
 	spin_lock(&hl_cs_cmpl->lock);
 
+	/*
+	 * we get refcount upon reservation of signals or signal/wait cs for the
+	 * hw_sob object, and need to put it when the first staged cs
+	 * (which cotains the encaps signals) or cs signal/wait is completed.
+	 */
 	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
 			(hl_cs_cmpl->type == CS_TYPE_WAIT) ||
 			(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT) ||
@@ -664,8 +637,20 @@ static void cs_do_release(struct kref *ref)
 			list_del(&cs->staged_cs_node);
 			spin_unlock(&hdev->cs_mirror_lock);
 		}
+
+		/* decrement refcount to handle when first staged cs
+		 * with encaps signals is completed.
+		 */
+		if (hl_cs_cmpl->encaps_signals)
+			kref_put(&hl_cs_cmpl->encaps_sig_hdl->refcount,
+						hl_encaps_handle_do_release);
 	}
 
+	if ((cs->type == CS_TYPE_WAIT || cs->type == CS_TYPE_COLLECTIVE_WAIT)
+			&& cs->encaps_signals)
+		kref_put(&cs->encaps_sig_hdl->refcount,
+					hl_encaps_handle_do_release);
+
 out:
 	/* Must be called before hl_ctx_put because inside we use ctx to get
 	 * the device
@@ -798,6 +783,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->completed = false;
 	cs->type = cs_type;
 	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
+	cs->encaps_signals = !!(flags & HL_CS_FLAGS_ENCAP_SIGNALS);
 	cs->timeout_jiffies = timeout;
 	cs->skip_reset_on_timeout =
 		hdev->skip_reset_on_timeout ||
@@ -808,9 +794,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	kref_init(&cs->refcount);
 	spin_lock_init(&cs->job_lock);
 
-	cs_cmpl = kmalloc(sizeof(*cs_cmpl), GFP_ATOMIC);
+	cs_cmpl = kzalloc(sizeof(*cs_cmpl), GFP_ATOMIC);
 	if (!cs_cmpl)
-		cs_cmpl = kmalloc(sizeof(*cs_cmpl), GFP_KERNEL);
+		cs_cmpl = kzalloc(sizeof(*cs_cmpl), GFP_KERNEL);
 
 	if (!cs_cmpl) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
@@ -834,9 +820,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	cs_cmpl->hdev = hdev;
 	cs_cmpl->type = cs->type;
-	cs_cmpl->encaps_signals = false;
 	spin_lock_init(&cs_cmpl->lock);
-	INIT_WORK(&cs_cmpl->sob_reset_work, sob_reset_work);
 	cs->fence = &cs_cmpl->base_fence;
 
 	spin_lock(&ctx->cs_lock);
@@ -1225,7 +1209,8 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 }
 
 static int cs_staged_submission(struct hl_device *hdev, struct hl_cs *cs,
-				u64 sequence, u32 flags)
+				u64 sequence, u32 flags,
+				u32 encaps_signal_handle)
 {
 	if (!(flags & HL_CS_FLAGS_STAGED_SUBMISSION))
 		return 0;
@@ -1237,6 +1222,9 @@ static int cs_staged_submission(struct hl_device *hdev, struct hl_cs *cs,
 		/* Staged CS sequence is the first CS sequence */
 		INIT_LIST_HEAD(&cs->staged_cs_node);
 		cs->staged_sequence = cs->sequence;
+
+		if (cs->encaps_signals)
+			cs->encaps_sig_hdl_id = encaps_signal_handle;
 	} else {
 		/* User sequence will be validated in 'hl_hw_queue_schedule_cs'
 		 * under the cs_mirror_lock
@@ -1254,7 +1242,7 @@ static int cs_staged_submission(struct hl_device *hdev, struct hl_cs *cs,
 
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 				u32 num_chunks, u64 *cs_seq, u32 flags,
-				u32 timeout)
+				u32 encaps_signals_handle, u32 timeout)
 {
 	bool staged_mid, int_queues_only = true;
 	struct hl_device *hdev = hpriv->hdev;
@@ -1293,7 +1281,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 	hl_debugfs_add_cs(cs);
 
-	rc = cs_staged_submission(hdev, cs, user_sequence, flags);
+	rc = cs_staged_submission(hdev, cs, user_sequence, flags,
+						encaps_signals_handle);
 	if (rc)
 		goto free_cs_object;
 
@@ -1604,7 +1593,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 			rc = 0;
 		} else {
 			rc = cs_ioctl_default(hpriv, chunks, num_chunks,
-					cs_seq, 0, hdev->timeout_jiffies);
+					cs_seq, 0, 0, hdev->timeout_jiffies);
 		}
 
 		mutex_unlock(&hpriv->restore_phase_mutex);
@@ -1743,12 +1732,18 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 }
 
 static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
-		struct hl_cs_chunk *chunk, u64 *signal_seq, struct hl_ctx *ctx)
+		struct hl_cs_chunk *chunk, u64 *signal_seq, struct hl_ctx *ctx,
+		bool encaps_signals)
 {
 	u64 *signal_seq_arr = NULL;
 	u32 size_to_copy, signal_seq_arr_len;
 	int rc = 0;
 
+	if (encaps_signals) {
+		*signal_seq = chunk->encaps_signal_seq;
+		return 0;
+	}
+
 	signal_seq_arr_len = chunk->num_signal_seq_arr;
 
 	/* currently only one signal seq is supported */
@@ -1773,7 +1768,7 @@ static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 		return -ENOMEM;
 	}
 
-	size_to_copy = chunk->num_signal_seq_arr * sizeof(*signal_seq_arr);
+	size_to_copy = signal_seq_arr_len * sizeof(*signal_seq_arr);
 	if (copy_from_user(signal_seq_arr,
 				u64_to_user_ptr(chunk->signal_seq_arr),
 				size_to_copy)) {
@@ -1795,8 +1790,8 @@ static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 }
 
 static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
-		struct hl_ctx *ctx, struct hl_cs *cs, enum hl_queue_type q_type,
-		u32 q_idx)
+		struct hl_ctx *ctx, struct hl_cs *cs,
+		enum hl_queue_type q_type, u32 q_idx, u32 encaps_signal_offset)
 {
 	struct hl_cs_counters_atomic *cntr;
 	struct hl_cs_job *job;
@@ -1834,6 +1829,9 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = q_idx;
 
+	if ((cs->type == CS_TYPE_WAIT || cs->type == CS_TYPE_COLLECTIVE_WAIT)
+			&& cs->encaps_signals)
+		job->encaps_sig_wait_offset = encaps_signal_offset;
 	/*
 	 * No need in parsing, user CB is the patched CB.
 	 * We call hl_cb_destroy() out of two reasons - we don't need the CB in
@@ -1931,13 +1929,22 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	 * value, if yes then switch sob.
 	 */
 	rc = hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, count,
-						true);
+								true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to switch SOB\n");
 		hdev->asic_funcs->hw_queues_unlock(hdev);
 		rc = -EINVAL;
 		goto remove_idr;
 	}
+	/* set the hw_sob to the handle after calling the sob wraparound handler
+	 * since sob could have changed.
+	 */
+	handle->hw_sob = hw_sob;
+
+	/* store the current sob value for unreserve validity check, and
+	 * signal offset support
+	 */
+	handle->pre_sob_val = prop->next_sob_val - handle->count;
 
 	/* set the hw_sob to the handle after calling the sob wraparound handler
 	 * since sob could have changed.
@@ -2041,7 +2048,12 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
 				u64 *cs_seq, u32 flags, u32 timeout)
 {
+	struct hl_cs_encaps_sig_handle *encaps_sig_hdl = NULL;
+	bool handle_found = false, is_wait_cs = false,
+			wait_cs_submitted = false,
+			cs_encaps_signals = false;
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
+	bool staged_cs_with_encaps_signals = false;
 	struct hw_queue_properties *hw_queue_prop;
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_compl *sig_waitcs_cmpl;
@@ -2050,7 +2062,6 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_fence *sig_fence = NULL;
 	struct hl_ctx *ctx = hpriv->ctx;
 	enum hl_queue_type q_type;
-	bool is_wait_cs = false;
 	struct hl_cs *cs;
 	u64 signal_seq;
 	int rc;
@@ -2102,13 +2113,56 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		collective_engine_id = chunk->collective_engine_id;
 	}
 
-	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_COLLECTIVE_WAIT) {
-		is_wait_cs = true;
+	is_wait_cs = !!(cs_type == CS_TYPE_WAIT ||
+			cs_type == CS_TYPE_COLLECTIVE_WAIT);
+
+	cs_encaps_signals = !!(flags & HL_CS_FLAGS_ENCAP_SIGNALS);
 
-		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq, ctx);
+	if (is_wait_cs) {
+		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq,
+				ctx, cs_encaps_signals);
 		if (rc)
 			goto free_cs_chunk_array;
 
+		if (cs_encaps_signals) {
+			/* check if cs sequence has encapsulated
+			 * signals handle
+			 */
+			struct idr *idp;
+			u32 id;
+
+			spin_lock(&ctx->sig_mgr.lock);
+			idp = &ctx->sig_mgr.handles;
+			idr_for_each_entry(idp, encaps_sig_hdl, id) {
+				if (encaps_sig_hdl->cs_seq == signal_seq) {
+					handle_found = true;
+					/* get refcount to protect removing
+					 * this handle from idr, needed when
+					 * multiple wait cs are used with offset
+					 * to wait on reserved encaps signals.
+					 */
+					kref_get(&encaps_sig_hdl->refcount);
+					break;
+				}
+			}
+			spin_unlock(&ctx->sig_mgr.lock);
+
+			if (!handle_found) {
+				dev_err(hdev->dev, "Cannot find encapsulated signals handle for seq 0x%llx\n",
+						signal_seq);
+				goto free_cs_chunk_array;
+			}
+
+			/* validate also the signal offset value */
+			if (chunk->encaps_signal_offset >
+					encaps_sig_hdl->count) {
+				dev_err(hdev->dev, "offset(%u) value exceed max reserved signals count(%u)!\n",
+						chunk->encaps_signal_offset,
+						encaps_sig_hdl->count);
+				goto free_cs_chunk_array;
+			}
+		}
+
 		sig_fence = hl_ctx_get_fence(ctx, signal_seq);
 		if (IS_ERR(sig_fence)) {
 			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
@@ -2129,11 +2183,16 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		sig_waitcs_cmpl =
 			container_of(sig_fence, struct hl_cs_compl, base_fence);
 
-		if (sig_waitcs_cmpl->type != CS_TYPE_SIGNAL) {
+		staged_cs_with_encaps_signals = !!
+				(sig_waitcs_cmpl->type == CS_TYPE_DEFAULT &&
+				(flags & HL_CS_FLAGS_ENCAP_SIGNALS));
+
+		if (sig_waitcs_cmpl->type != CS_TYPE_SIGNAL &&
+				!staged_cs_with_encaps_signals) {
 			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
 			atomic64_inc(&cntr->validation_drop_cnt);
 			dev_err(hdev->dev,
-				"CS seq 0x%llx is not of a signal CS\n",
+				"CS seq 0x%llx is not of a signal/encaps-signal CS\n",
 				signal_seq);
 			hl_fence_put(sig_fence);
 			rc = -EINVAL;
@@ -2159,9 +2218,18 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	/*
 	 * Save the signal CS fence for later initialization right before
 	 * hanging the wait CS on the queue.
+	 * for encaps signals case, we save the cs sequence and handle pointer
+	 * for later initialization.
 	 */
-	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_COLLECTIVE_WAIT)
+	if (is_wait_cs) {
 		cs->signal_fence = sig_fence;
+		/* store the handle pointer, so we don't have to
+		 * look for it again, later on the flow
+		 * when we need to set SOB info in hw_queue.
+		 */
+		if (cs->encaps_signals)
+			cs->encaps_sig_hdl = encaps_sig_hdl;
+	}
 
 	hl_debugfs_add_cs(cs);
 
@@ -2169,10 +2237,11 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_SIGNAL)
 		rc = cs_ioctl_signal_wait_create_jobs(hdev, ctx, cs, q_type,
-				q_idx);
+				q_idx, chunk->encaps_signal_offset);
 	else if (cs_type == CS_TYPE_COLLECTIVE_WAIT)
 		rc = hdev->asic_funcs->collective_wait_create_jobs(hdev, ctx,
-				cs, q_idx, collective_engine_id);
+				cs, q_idx, collective_engine_id,
+				chunk->encaps_signal_offset);
 	else {
 		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
 		atomic64_inc(&cntr->validation_drop_cnt);
@@ -2198,6 +2267,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	}
 
 	rc = HL_CS_STATUS_SUCCESS;
+	if (is_wait_cs)
+		wait_cs_submitted = true;
 	goto put_cs;
 
 free_cs_object:
@@ -2208,6 +2279,10 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	/* We finished with the CS in this function, so put the ref */
 	cs_put(cs);
 free_cs_chunk_array:
+	if (!wait_cs_submitted && cs_encaps_signals && handle_found &&
+							is_wait_cs)
+		kref_put(&encaps_sig_hdl->refcount,
+				hl_encaps_handle_do_release);
 	kfree(cs_chunk_array);
 out:
 	return rc;
@@ -2269,7 +2344,9 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 	default:
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
-						args->in.cs_flags, timeout);
+						args->in.cs_flags,
+						args->in.encaps_sig_handle_id,
+						timeout);
 		break;
 	}
 out:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 81b6825e0c1c..1ea8e70a5a34 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -605,11 +605,11 @@ struct hl_fence {
 
 /**
  * struct hl_cs_compl - command submission completion object.
- * @sob_reset_work: workqueue object to run SOB reset flow.
  * @base_fence: hl fence object.
  * @lock: spinlock to protect fence.
  * @hdev: habanalabs device structure.
  * @hw_sob: the H/W SOB used in this signal/wait CS.
+ * @encaps_sig_hdl: encaps signals hanlder.
  * @cs_seq: command submission sequence number.
  * @type: type of the CS - signal/wait.
  * @sob_val: the SOB value that is used in this signal/wait CS.
@@ -618,11 +618,11 @@ struct hl_fence {
  * encaps signals or not.
  */
 struct hl_cs_compl {
-	struct work_struct	sob_reset_work;
 	struct hl_fence		base_fence;
 	spinlock_t		lock;
 	struct hl_device	*hdev;
 	struct hl_hw_sob	*hw_sob;
+	struct hl_cs_encaps_sig_handle *encaps_sig_hdl;
 	u64			cs_seq;
 	enum hl_cs_type		type;
 	u16			sob_val;
@@ -1267,8 +1267,9 @@ struct hl_asic_funcs {
 	u64 (*get_device_time)(struct hl_device *hdev);
 	int (*collective_wait_init_cs)(struct hl_cs *cs);
 	int (*collective_wait_create_jobs)(struct hl_device *hdev,
-			struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
-			u32 collective_engine_id);
+			struct hl_ctx *ctx, struct hl_cs *cs,
+			u32 wait_queue_id, u32 collective_engine_id,
+			u32 encaps_signal_offset);
 	u64 (*scramble_addr)(struct hl_device *hdev, u64 addr);
 	u64 (*descramble_addr)(struct hl_device *hdev, u64 addr);
 	void (*ack_protection_bits_errors)(struct hl_device *hdev);
@@ -1485,12 +1486,14 @@ struct hl_userptr {
  * @mirror_node : node in device mirror list of command submissions.
  * @staged_cs_node: node in the staged cs list.
  * @debugfs_list: node in debugfs list of command submissions.
+ * @encaps_sig_hdl: holds the encaps signals handle.
  * @sequence: the sequence number of this CS.
  * @staged_sequence: the sequence of the staged submission this CS is part of,
  *                   relevant only if staged_cs is set.
  * @timeout_jiffies: cs timeout in jiffies.
  * @submission_time_jiffies: submission time of the cs
  * @type: CS_TYPE_*.
+ * @encaps_sig_hdl_id: encaps signals handle id, set for the first staged cs.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
  * @timedout : true if CS was timedout.
@@ -1504,6 +1507,7 @@ struct hl_userptr {
  * @staged_cs: true if this CS is part of a staged submission.
  * @skip_reset_on_timeout: true if we shall not reset the device in case
  *                         timeout occurs (debug scenario).
+ * @encaps_signals: true if this CS has encaps reserved signals.
  */
 struct hl_cs {
 	u16			*jobs_in_queue_cnt;
@@ -1518,11 +1522,13 @@ struct hl_cs {
 	struct list_head	mirror_node;
 	struct list_head	staged_cs_node;
 	struct list_head	debugfs_list;
+	struct hl_cs_encaps_sig_handle *encaps_sig_hdl;
 	u64			sequence;
 	u64			staged_sequence;
 	u64			timeout_jiffies;
 	u64			submission_time_jiffies;
 	enum hl_cs_type		type;
+	u32			encaps_sig_hdl_id;
 	u8			submitted;
 	u8			completed;
 	u8			timedout;
@@ -1533,6 +1539,7 @@ struct hl_cs {
 	u8			staged_first;
 	u8			staged_cs;
 	u8			skip_reset_on_timeout;
+	u8			encaps_signals;
 };
 
 /**
@@ -1552,6 +1559,8 @@ struct hl_cs {
  * @hw_queue_id: the id of the H/W queue this job is submitted to.
  * @user_cb_size: the actual size of the CB we got from the user.
  * @job_cb_size: the actual size of the CB that we put on the queue.
+ * @encaps_sig_wait_offset: encapsulated signals offset, which allow user
+ *                          to wait on part of the reserved signals.
  * @is_kernel_allocated_cb: true if the CB handle we got from the user holds a
  *                          handle to a kernel-allocated CB object, false
  *                          otherwise (SRAM/DRAM/host address).
@@ -1576,6 +1585,7 @@ struct hl_cs_job {
 	u32			hw_queue_id;
 	u32			user_cb_size;
 	u32			job_cb_size;
+	u32			encaps_sig_wait_offset;
 	u8			is_kernel_allocated_cb;
 	u8			contains_dma_pkt;
 };
@@ -2935,9 +2945,12 @@ int hl_set_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
-void hl_encaps_handle_do_release(struct kref *ref);
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
+void hl_encaps_handle_do_release(struct kref *ref);
+void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
+			struct hl_cs *cs, struct hl_cs_job *job,
+			struct hl_cs_compl *cs_cmpl);
 void hl_release_pending_user_interrupts(struct hl_device *hdev);
 int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 			struct hl_hw_sob **hw_sob, u32 count, bool encaps_sig);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 9a59b8e9bf53..3d9b24ce2020 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -432,12 +432,27 @@ static int init_signal_cs(struct hl_device *hdev,
 	return rc;
 }
 
+void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
+			struct hl_cs *cs, struct hl_cs_job *job,
+			struct hl_cs_compl *cs_cmpl)
+{
+	struct hl_cs_encaps_sig_handle *handle = cs->encaps_sig_hdl;
+
+	cs_cmpl->hw_sob = handle->hw_sob;
+
+	/* Note that encaps_sig_wait_offset was validated earlier in the flow
+	 * for offset value which exceeds the max reserved signal count.
+	 */
+	cs_cmpl->sob_val = handle->pre_sob_val +
+			(job->encaps_sig_wait_offset);
+}
+
 static int init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
 		struct hl_cs_job *job, struct hl_cs_compl *cs_cmpl)
 {
-	struct hl_cs_compl *signal_cs_cmpl;
-	struct hl_sync_stream_properties *prop;
 	struct hl_gen_wait_properties wait_prop;
+	struct hl_sync_stream_properties *prop;
+	struct hl_cs_compl *signal_cs_cmpl;
 	u32 q_idx;
 
 	q_idx = job->hw_queue_id;
@@ -447,9 +462,23 @@ static int init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
 					struct hl_cs_compl,
 					base_fence);
 
-	/* copy the SOB id and value of the signal CS */
-	cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
-	cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+	if (cs->encaps_signals) {
+		/* use the encaps signal handle stored earlier in the flow
+		 * and set the SOB information from the encaps
+		 * signals handle
+		 */
+		hl_hw_queue_encaps_sig_set_sob_info(hdev, cs, job, cs_cmpl);
+
+		dev_dbg(hdev->dev, "Wait for encaps signals handle, qidx(%u), CS sequence(%llu), sob val: %u, offset: %u\n",
+				cs->encaps_sig_hdl->q_idx,
+				cs->encaps_sig_hdl->cs_seq,
+				cs_cmpl->sob_val,
+				job->encaps_sig_wait_offset);
+	} else {
+		/* Copy the SOB id and value of the signal CS */
+		cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
+		cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+	}
 
 	/* check again if the signal cs already completed.
 	 * if yes then don't send any wait cs since the hw_sob
@@ -523,6 +552,57 @@ static int init_signal_wait_cs(struct hl_cs *cs)
 	return rc;
 }
 
+static int encaps_sig_first_staged_cs_handler
+			(struct hl_device *hdev, struct hl_cs *cs)
+{
+	struct hl_cs_compl *cs_cmpl =
+			container_of(cs->fence,
+					struct hl_cs_compl, base_fence);
+	struct hl_cs_encaps_sig_handle *encaps_sig_hdl;
+	struct hl_encaps_signals_mgr *mgr;
+	int rc = 0;
+
+	mgr = &hdev->compute_ctx->sig_mgr;
+
+	spin_lock(&mgr->lock);
+	encaps_sig_hdl = idr_find(&mgr->handles, cs->encaps_sig_hdl_id);
+	if (encaps_sig_hdl) {
+		/*
+		 * Set handler CS sequence,
+		 * the CS which contains the encapsulated signals.
+		 */
+		encaps_sig_hdl->cs_seq = cs->sequence;
+		/* store the handle and set encaps signal indication,
+		 * to be used later in cs_do_release to put the last
+		 * reference to encaps signals handlers.
+		 */
+		cs_cmpl->encaps_signals = true;
+		cs_cmpl->encaps_sig_hdl = encaps_sig_hdl;
+
+		/* set hw_sob pointer in completion object
+		 * since it's used in cs_do_release flow to put
+		 * refcount to sob
+		 */
+		cs_cmpl->hw_sob = encaps_sig_hdl->hw_sob;
+		cs_cmpl->sob_val = encaps_sig_hdl->pre_sob_val +
+						encaps_sig_hdl->count;
+
+		dev_dbg(hdev->dev, "CS seq (%llu) added to encaps signal handler id (%u), count(%u), qidx(%u)\n",
+				cs->sequence, encaps_sig_hdl->id,
+				encaps_sig_hdl->count,
+				encaps_sig_hdl->q_idx);
+
+	} else {
+		dev_err(hdev->dev, "encaps handle id(%u) wasn't found!\n",
+				cs->encaps_sig_hdl_id);
+		rc = -EINVAL;
+	}
+
+	spin_unlock(&mgr->lock);
+
+	return rc;
+}
+
 /*
  * hl_hw_queue_schedule_cs - schedule a command submission
  * @cs: pointer to the CS
@@ -602,6 +682,12 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	}
 
 
+	if (cs->encaps_signals && cs->staged_first) {
+		rc = encaps_sig_first_staged_cs_handler(hdev, cs);
+		if (rc)
+			goto unroll_cq_resv;
+	}
+
 	spin_lock(&hdev->cs_mirror_lock);
 
 	/* Verify staged CS exists and add to the staged list */
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae1a8b4e694c..529ccd8b8911 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1215,6 +1215,19 @@ static void gaudi_collective_slave_init_job(struct hl_device *hdev,
 	queue_id = job->hw_queue_id;
 	prop = &hdev->kernel_queues[queue_id].sync_stream_prop;
 
+	if (job->cs->encaps_signals) {
+		/* use the encaps signal handle store earlier in the flow
+		 * and set the SOB information from the encaps
+		 * signals handle
+		 */
+		hl_hw_queue_encaps_sig_set_sob_info(hdev, job->cs, job,
+						cs_cmpl);
+
+		dev_dbg(hdev->dev, "collective wait: Sequence %llu found, sob val incremented to: %u\n",
+				job->cs->sequence,
+				job->cs->encaps_sig_hdl->pre_sob_val);
+	}
+
 	/* Add to wait CBs using slave monitor */
 	wait_prop.data = (void *) job->user_cb;
 	wait_prop.sob_base = cs_cmpl->hw_sob->sob_id;
@@ -1257,9 +1270,14 @@ static int gaudi_collective_wait_init_cs(struct hl_cs *cs)
 	gaudi = hdev->asic_specific;
 	cprop = &gaudi->collective_props;
 
-	/* copy the SOB id and value of the signal CS */
-	cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
-	cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+	/* In encaps signals case the SOB info will be retrieved from
+	 * the handle in gaudi_collective_slave_init_job.
+	 */
+	if (!cs->encaps_signals) {
+		/* copy the SOB id and value of the signal CS */
+		cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
+		cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+	}
 
 	/* check again if the signal cs already completed.
 	 * if yes then don't send any wait cs since the hw_sob
@@ -1336,7 +1354,8 @@ static int gaudi_collective_wait_init_cs(struct hl_cs *cs)
 
 static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 		struct hl_ctx *ctx, struct hl_cs *cs,
-		enum hl_collective_mode mode, u32 queue_id, u32 wait_queue_id)
+		enum hl_collective_mode mode, u32 queue_id, u32 wait_queue_id,
+		u32 encaps_signal_offset)
 {
 	struct hw_queue_properties *hw_queue_prop;
 	struct hl_cs_counters_atomic *cntr;
@@ -1396,6 +1415,13 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = queue_id;
 
+	/* since its guaranteed to have only one chunk in the collective wait
+	 * cs, we can use this chunk to set the encapsulated signal offset
+	 * in the jobs.
+	 */
+	if (cs->encaps_signals)
+		job->encaps_sig_wait_offset = encaps_signal_offset;
+
 	/*
 	 * No need in parsing, user CB is the patched CB.
 	 * We call hl_cb_destroy() out of two reasons - we don't need
@@ -1424,8 +1450,9 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 }
 
 static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
-		struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
-		u32 collective_engine_id)
+		struct hl_ctx *ctx, struct hl_cs *cs,
+		u32 wait_queue_id, u32 collective_engine_id,
+		u32 encaps_signal_offset)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	struct hw_queue_properties *hw_queue_prop;
@@ -1475,7 +1502,8 @@ static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
 		if (i == 0) {
 			queue_id = wait_queue_id;
 			rc = gaudi_collective_wait_create_job(hdev, ctx, cs,
-				HL_COLLECTIVE_MASTER, queue_id, wait_queue_id);
+				HL_COLLECTIVE_MASTER, queue_id,
+				wait_queue_id, encaps_signal_offset);
 		} else {
 			if (nic_idx < NIC_NUMBER_OF_ENGINES) {
 				if (gaudi->hw_cap_initialized &
@@ -1495,7 +1523,8 @@ static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
 			}
 
 			rc = gaudi_collective_wait_create_job(hdev, ctx, cs,
-				HL_COLLECTIVE_SLAVE, queue_id, wait_queue_id);
+				HL_COLLECTIVE_SLAVE, queue_id,
+				wait_queue_id, encaps_signal_offset);
 		}
 
 		if (rc)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 8a689bf42397..c070cd14753e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5487,7 +5487,7 @@ static int goya_collective_wait_init_cs(struct hl_cs *cs)
 
 static int goya_collective_wait_create_jobs(struct hl_device *hdev,
 		struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
-		u32 collective_engine_id)
+		u32 collective_engine_id, u32 encaps_signal_offset)
 {
 	return -EINVAL;
 }
-- 
2.25.1

