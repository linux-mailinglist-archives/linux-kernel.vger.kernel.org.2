Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C873C6BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhGMHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234370AbhGMHz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F039E61279;
        Tue, 13 Jul 2021 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162760;
        bh=ywPd+yISXC1sLChBsw3y5JWXoqZncLjocb9TM1I0HxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmIs7gATCDHv73iYeaXVElBHz+oAl93B201n+/r9GykoYaVSWenB1yzljvqqS7G4V
         UCgT1g4HtGZahp1isBcwfzFYtH0zkMqoCeJcoNK0PQXDc089IuMJdvQFrSIG1o0JWo
         0c3p1YxUUQI/ZF7sEhKX9mAEhqqEoRP/8vmaEXUSG6aVqonSp7oHS3aCyoVLifFu4X
         5d2Xuudoj/skbKHquPhs7634nZzn3KqI03bea1l7Mh53bkQZQFZLRojluvkJEZpCZl
         Ohb8l9xrkf++/Ctn/3GKVv1vQaiuxSAXIwSXsXllfFxgyUX3wnlnZ/puD0kOS16FOd
         tcFrFkO1iXfdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 08/11] habanalabs: add wait-for-multi-CS uAPI
Date:   Tue, 13 Jul 2021 10:52:23 +0300
Message-Id: <20210713075226.11094-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When user sends multiple CSs, waiting for each CS is not efficient
as it involves many user-kernel context switches.

In order to address this issue we add support to "wait on multiple CSs"
using a new uAPI which can wait on maximum of 32 CSs. The new uAPI is
defined using a new flag - WAIT_FOR_MULTI_CS - in the wait_for_cs IOCTL.

The input parameters for this uAPI will be:
@seq: user pointer to an array of up to 32 CS's sequence numbers.
@seq_array_len: length of sequence array.
@timeout_us: timeout for waiting for any CS.

The output paramateres for this API will be:
@status: multi CS ioctl completion status (dedicated status was added as
         well).
@flags: bitmap of output flags of the CS.
@cs_completion_map: bitmap for multi CS, if CS sequence that was placed
                    in index N in input seq array has completed- the N-th
		    bit in cs_completion_map will be 1, otherwise it will
		    be 0.
@timestamp_nsec: timestamp of the first completed CS

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 443 +++++++++++++++++-
 drivers/misc/habanalabs/common/context.c      |  22 +-
 drivers/misc/habanalabs/common/device.c       |   4 +
 drivers/misc/habanalabs/common/habanalabs.h   |  63 ++-
 drivers/misc/habanalabs/common/hw_queue.c     |   4 +
 drivers/misc/habanalabs/gaudi/gaudi.c         |   1 +
 drivers/misc/habanalabs/goya/goya.c           |   1 +
 include/uapi/misc/habanalabs.h                |  23 +-
 8 files changed, 556 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index b373a52a47a7..ba0c854b2ed4 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -482,6 +482,91 @@ static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 	spin_unlock(&hdev->cs_mirror_lock);
 }
 
+/*
+ * force_complete_multi_cs - complete all contexts that wait on multi-CS
+ *
+ * @hdev: pointer to habanalabs device structure
+ */
+static void force_complete_multi_cs(struct hl_device *hdev)
+{
+	int i;
+
+	for (i = 0; i < MULTI_CS_MAX_USER_CTX; i++) {
+		struct multi_cs_completion *mcs_compl;
+
+		mcs_compl = &hdev->multi_cs_completion[i];
+
+		spin_lock(&mcs_compl->lock);
+
+		if (!mcs_compl->used) {
+			spin_unlock(&mcs_compl->lock);
+			continue;
+		}
+
+		/* when calling force complete no context should be waiting on
+		 * multi-cS.
+		 * We are calling the function as a protection for such case
+		 * to free any pending context and print error message
+		 */
+		dev_err(hdev->dev,
+				"multi-CS completion context %d still waiting when calling force completion\n",
+				i);
+		complete_all(&mcs_compl->completion);
+		spin_unlock(&mcs_compl->lock);
+	}
+}
+
+/*
+ * complete_multi_cs - complete all waiting entities on multi-CS
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @cs: CS structure
+ *
+ * The function signals waiting entity that its waiting stream has common
+ * stream with the completed CS.
+ * For example:
+ * - a completed CS worked on streams 0 and 1, multi CS completion
+ *   is actively waiting on stream 3. don't send signal as no common stream
+ * - a completed CS worked on streams 0 and 1, multi CS completion
+ *   is actively waiting on streams 1 and 3. send signal as stream 1 is common
+ */
+static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
+{
+	struct hl_fence *fence = cs->fence;
+	int i;
+
+	/* in case of multi CS check for completion only for the first CS */
+	if (cs->staged_cs && !cs->staged_first)
+		return;
+
+	for (i = 0; i < MULTI_CS_MAX_USER_CTX; i++) {
+		struct multi_cs_completion *mcs_compl;
+
+		mcs_compl = &hdev->multi_cs_completion[i];
+		if (!mcs_compl->used)
+			continue;
+
+		spin_lock(&mcs_compl->lock);
+
+		/*
+		 * complete if:
+		 * 1. still waiting for completion
+		 * 2. the completed CS has at least one overlapping stream
+		 *    with the streams in the completion
+		 */
+		if (mcs_compl->used &&
+				(fence->stream_map & mcs_compl->stream_map)) {
+			/* extract the timestamp only of first completed CS */
+			if (!mcs_compl->timestamp)
+				mcs_compl->timestamp =
+						ktime_to_ns(fence->timestamp);
+			complete_all(&mcs_compl->completion);
+		}
+
+		spin_unlock(&mcs_compl->lock);
+	}
+}
+
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs, refcount);
@@ -575,6 +660,7 @@ static void cs_do_release(struct kref *ref)
 	if (cs->timestamp)
 		cs->fence->timestamp = ktime_get();
 	complete_all(&cs->fence->completion);
+	complete_multi_cs(hdev, cs);
 	hl_fence_put(cs->fence);
 
 	kfree(cs->jobs_in_queue_cnt);
@@ -804,6 +890,8 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 		cs_rollback(hdev, cs);
 		cs_put(cs);
 	}
+
+	force_complete_multi_cs(hdev);
 }
 
 void hl_pending_cb_list_flush(struct hl_ctx *ctx)
@@ -1134,6 +1222,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	struct hl_cs *cs;
 	struct hl_cb *cb;
 	u64 user_sequence;
+	u8 stream_map = 0;
 	int rc, i;
 
 	cntr = &hdev->aggregated_cs_counters;
@@ -1192,9 +1281,18 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 			cb = (struct hl_cb *) (uintptr_t) chunk->cb_handle;
 		}
 
-		if (queue_type == QUEUE_TYPE_EXT || queue_type == QUEUE_TYPE_HW)
+		if (queue_type == QUEUE_TYPE_EXT ||
+						queue_type == QUEUE_TYPE_HW) {
 			int_queues_only = false;
 
+			/*
+			 * store which stream are being used for external/HW
+			 * queues of this CS
+			 */
+			if (hdev->supports_wait_for_multi_cs)
+				stream_map |= BIT((chunk->queue_index % 4));
+		}
+
 		job = hl_cs_allocate_job(hdev, queue_type,
 						is_kernel_allocated_cb);
 		if (!job) {
@@ -1255,6 +1353,13 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		goto free_cs_object;
 	}
 
+	/*
+	 * store the (external/HW queues) streams used by the CS in the
+	 * fence object for multi-CS completion
+	 */
+	if (hdev->supports_wait_for_multi_cs)
+		cs->fence->stream_map = stream_map;
+
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
 		if (rc != -EAGAIN)
@@ -1959,6 +2064,95 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
 	return rc;
 }
 
+/*
+ * hl_cs_poll_fences - iterate CS fences to check for CS completion
+ *
+ * @mcs_data: multi-CS internal data
+ *
+ * @return 0 on success, otherwise non 0 error code
+ *
+ * The function iterates on all CS sequence in the list and set bit in
+ * completion_bitmap for each completed CS.
+ * while iterating, the function can extracts the stream map to be later
+ * used by the waiting function.
+ * this function shall be called after taking context ref
+ */
+static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
+{
+	struct hl_fence **fence_ptr = mcs_data->fence_arr;
+	struct hl_device *hdev = mcs_data->ctx->hdev;
+	int i, rc, arr_len = mcs_data->arr_len;
+	u64 *seq_arr = mcs_data->seq_arr;
+	ktime_t max_ktime, first_cs_time;
+	enum hl_cs_wait_status status;
+
+	memset(fence_ptr, 0, arr_len * sizeof(*fence_ptr));
+
+	/* get all fences under the same lock */
+	rc = hl_ctx_get_fences(mcs_data->ctx, seq_arr, fence_ptr, arr_len);
+	if (rc)
+		return rc;
+
+	/*
+	 * set to maximum time to verify timestamp is valid: if at the end
+	 * this value is maintained- no timestamp was updated
+	 */
+	max_ktime = ktime_set(KTIME_SEC_MAX, 0);
+	first_cs_time = max_ktime;
+
+	for (i = 0; i < arr_len; i++, fence_ptr++) {
+		struct hl_fence *fence = *fence_ptr;
+
+		/*
+		 * function won't sleep as it is called with timeout 0 (i.e.
+		 * poll the fence)
+		 */
+		rc = hl_wait_for_fence(mcs_data->ctx, seq_arr[i], fence,
+						&status, 0, NULL);
+		if (rc) {
+			dev_err(hdev->dev,
+				"wait_for_fence error :%d for CS seq %llu\n",
+								rc, seq_arr[i]);
+			break;
+		}
+
+		mcs_data->stream_map |= fence->stream_map;
+
+		if (status == CS_WAIT_STATUS_BUSY)
+			continue;
+
+		mcs_data->completion_bitmap |= BIT(i);
+
+		/*
+		 * best effort to extract timestamp. few notes:
+		 * - if even single fence is gone we cannot extract timestamp
+		 *   (as fence not exist anymore)
+		 * - for all completed CSs we take the earliest timestamp.
+		 *   for this we have to validate that:
+		 *       1. given timestamp was indeed set
+		 *       2. the timestamp is earliest of all timestamps so far
+		 */
+
+		if (status == CS_WAIT_STATUS_GONE) {
+			mcs_data->update_ts = false;
+			mcs_data->gone_cs = true;
+		} else if (mcs_data->update_ts &&
+			(ktime_compare(fence->timestamp,
+						ktime_set(0, 0)) > 0) &&
+			(ktime_compare(fence->timestamp, first_cs_time) < 0)) {
+			first_cs_time = fence->timestamp;
+		}
+	}
+
+	hl_fences_put(mcs_data->fence_arr, arr_len);
+
+	if (mcs_data->update_ts &&
+			(ktime_compare(first_cs_time, max_ktime) != 0))
+		mcs_data->timestamp = ktime_to_ns(first_cs_time);
+
+	return rc;
+}
+
 static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 seq,
 				enum hl_cs_wait_status *status, s64 *timestamp)
@@ -1980,6 +2174,251 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	return rc;
 }
 
+/*
+ * hl_wait_multi_cs_completion_init - init completion structure
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @stream_map: stream map, set bit indicates stream to wait on
+ *
+ * @return valid completion struct pointer on success, otherwise error pointer
+ *
+ * up to MULTI_CS_MAX_USER_CTX calls can be done concurrently to the driver.
+ * the function gets the first available completion (by marking it "used")
+ * and initialize its values.
+ */
+static struct multi_cs_completion *hl_wait_multi_cs_completion_init(
+							struct hl_device *hdev,
+							u8 stream_map)
+{
+	struct multi_cs_completion *mcs_compl;
+	int i;
+
+	/* find free multi_cs completion structure */
+	for (i = 0; i < MULTI_CS_MAX_USER_CTX; i++) {
+		mcs_compl = &hdev->multi_cs_completion[i];
+		spin_lock(&mcs_compl->lock);
+		if (!mcs_compl->used) {
+			mcs_compl->used = 1;
+			mcs_compl->timestamp = 0;
+			mcs_compl->stream_map = stream_map;
+			reinit_completion(&mcs_compl->completion);
+			spin_unlock(&mcs_compl->lock);
+			break;
+		}
+		spin_unlock(&mcs_compl->lock);
+	}
+
+	if (i == MULTI_CS_MAX_USER_CTX) {
+		dev_err(hdev->dev,
+				"no available multi-CS completion structure\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	return mcs_compl;
+}
+
+/*
+ * hl_wait_multi_cs_completion_fini - return completion structure and set as
+ *                                    unused
+ *
+ * @mcs_compl: pointer to the completion structure
+ */
+static void hl_wait_multi_cs_completion_fini(
+					struct multi_cs_completion *mcs_compl)
+{
+	/*
+	 * free completion structure, do it under lock to be in-sync with the
+	 * thread that signals completion
+	 */
+	spin_lock(&mcs_compl->lock);
+	mcs_compl->used = 0;
+	spin_unlock(&mcs_compl->lock);
+}
+
+/*
+ * hl_wait_multi_cs_completion - wait for first CS to complete
+ *
+ * @mcs_data: multi-CS internal data
+ *
+ * @return 0 on success, otherwise non 0 error code
+ */
+static int hl_wait_multi_cs_completion(struct multi_cs_data *mcs_data)
+{
+	struct hl_device *hdev = mcs_data->ctx->hdev;
+	struct multi_cs_completion *mcs_compl;
+	long completion_rc;
+
+	mcs_compl = hl_wait_multi_cs_completion_init(hdev,
+							mcs_data->stream_map);
+	if (IS_ERR(mcs_compl))
+		return PTR_ERR(mcs_compl);
+
+	completion_rc = wait_for_completion_interruptible_timeout(
+					&mcs_compl->completion,
+					usecs_to_jiffies(mcs_data->timeout_us));
+
+	/* update timestamp */
+	if (completion_rc > 0)
+		mcs_data->timestamp = mcs_compl->timestamp;
+
+	hl_wait_multi_cs_completion_fini(mcs_compl);
+
+	mcs_data->wait_status = completion_rc;
+
+	return 0;
+}
+
+/*
+ * hl_multi_cs_completion_init - init array of multi-CS completion structures
+ *
+ * @hdev: pointer to habanalabs device structure
+ */
+void hl_multi_cs_completion_init(struct hl_device *hdev)
+{
+	struct multi_cs_completion *mcs_cmpl;
+	int i;
+
+	for (i = 0; i < MULTI_CS_MAX_USER_CTX; i++) {
+		mcs_cmpl = &hdev->multi_cs_completion[i];
+		mcs_cmpl->used = 0;
+		spin_lock_init(&mcs_cmpl->lock);
+		init_completion(&mcs_cmpl->completion);
+	}
+}
+
+/*
+ * hl_multi_cs_wait_ioctl - implementation of the multi-CS wait ioctl
+ *
+ * @hpriv: pointer to the private data of the fd
+ * @data: pointer to multi-CS wait ioctl in/out args
+ *
+ */
+static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct multi_cs_data mcs_data = {0};
+	union hl_wait_cs_args *args = data;
+	struct hl_ctx *ctx = hpriv->ctx;
+	struct hl_fence **fence_arr;
+	void __user *seq_arr;
+	u32 size_to_copy;
+	u64 *cs_seq_arr;
+	u8 seq_arr_len;
+	int rc;
+
+	if (!hdev->supports_wait_for_multi_cs) {
+		dev_err(hdev->dev, "Wait for multi CS is not supported\n");
+		return -EPERM;
+	}
+
+	seq_arr_len = args->in.seq_arr_len;
+
+	if (seq_arr_len > HL_WAIT_MULTI_CS_LIST_MAX_LEN) {
+		dev_err(hdev->dev, "Can wait only up to %d CSs, input sequence is of length %u\n",
+				HL_WAIT_MULTI_CS_LIST_MAX_LEN, seq_arr_len);
+		return -EINVAL;
+	}
+
+	/* allocate memory for sequence array */
+	cs_seq_arr =
+		kmalloc_array(seq_arr_len, sizeof(*cs_seq_arr), GFP_KERNEL);
+	if (!cs_seq_arr)
+		return -ENOMEM;
+
+	/* copy CS sequence array from user */
+	seq_arr = (void __user *) (uintptr_t) args->in.seq;
+	size_to_copy = seq_arr_len * sizeof(*cs_seq_arr);
+	if (copy_from_user(cs_seq_arr, seq_arr, size_to_copy)) {
+		dev_err(hdev->dev, "Failed to copy multi-cs sequence array from user\n");
+		rc = -EFAULT;
+		goto free_seq_arr;
+	}
+
+	/* allocate array for the fences */
+	fence_arr = kmalloc_array(seq_arr_len, sizeof(*fence_arr), GFP_KERNEL);
+	if (!fence_arr) {
+		rc = -ENOMEM;
+		goto free_seq_arr;
+	}
+
+	/* initialize the multi-CS internal data */
+	mcs_data.ctx = ctx;
+	mcs_data.seq_arr = cs_seq_arr;
+	mcs_data.fence_arr = fence_arr;
+	mcs_data.arr_len = seq_arr_len;
+
+	hl_ctx_get(hdev, ctx);
+
+	/* poll all CS fences, extract timestamp */
+	mcs_data.update_ts = true;
+	rc = hl_cs_poll_fences(&mcs_data);
+	/*
+	 * skip wait for CS completion when one of the below is true:
+	 * - an error on the poll function
+	 * - one or more CS in the list completed
+	 * - the user called ioctl with timeout 0
+	 */
+	if (rc || mcs_data.completion_bitmap || !args->in.timeout_us)
+		goto put_ctx;
+
+	/* wait (with timeout) for the first CS to be completed */
+	mcs_data.timeout_us = args->in.timeout_us;
+	rc = hl_wait_multi_cs_completion(&mcs_data);
+	if (rc)
+		goto put_ctx;
+
+	if (mcs_data.wait_status > 0) {
+		/*
+		 * poll fences once again to update the CS map.
+		 * no timestamp should be updated this time.
+		 */
+		mcs_data.update_ts = false;
+		rc = hl_cs_poll_fences(&mcs_data);
+
+		/*
+		 * if hl_wait_multi_cs_completion returned before timeout (i.e.
+		 * it got a completion) we expect to see at least one CS
+		 * completed after the poll function.
+		 */
+		if (!mcs_data.completion_bitmap) {
+			dev_err(hdev->dev, "Multi-CS got completion on wait but no CS completed\n");
+			rc = -EFAULT;
+		}
+	}
+
+put_ctx:
+	hl_ctx_put(ctx);
+	kfree(fence_arr);
+
+free_seq_arr:
+	kfree(cs_seq_arr);
+
+	/* update output args */
+	memset(args, 0, sizeof(*args));
+	if (rc)
+		return rc;
+
+	if (mcs_data.completion_bitmap) {
+		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
+		args->out.cs_completion_map = mcs_data.completion_bitmap;
+
+		/* if timestamp not 0- it's valid */
+		if (mcs_data.timestamp) {
+			args->out.timestamp_nsec = mcs_data.timestamp;
+			args->out.flags |= HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD;
+		}
+
+		/* update if some CS was gone */
+		if (mcs_data.timestamp)
+			args->out.flags |= HL_WAIT_CS_STATUS_FLAG_GONE;
+	} else if (mcs_data.wait_status == -ERESTARTSYS) {
+		args->out.status = HL_WAIT_CS_STATUS_INTERRUPTED;
+	} else {
+		args->out.status = HL_WAIT_CS_STATUS_BUSY;
+	}
+
+	return 0;
+}
+
 static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_device *hdev = hpriv->hdev;
@@ -2221,6 +2660,8 @@ int hl_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	if (flags & HL_WAIT_CS_FLAGS_INTERRUPT)
 		rc = hl_interrupt_wait_ioctl(hpriv, data);
+	else if (flags & HL_WAIT_CS_FLAGS_MULTI_CS)
+		rc = hl_multi_cs_wait_ioctl(hpriv, data);
 	else
 		rc = hl_cs_wait_ioctl(hpriv, data);
 
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 1001c65c5e7a..4d922e4d0393 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -229,7 +229,17 @@ int hl_ctx_put(struct hl_ctx *ctx)
 	return kref_put(&ctx->refcount, hl_ctx_do_release);
 }
 
-/* this function shall be called with cs_lock locked */
+/*
+ * hl_ctx_get_fence_locked - get CS fence under CS lock
+ *
+ * @ctx: pointer to the context structure.
+ * @seq: CS sequences number
+ *
+ * @return valid fence pointer on success, NULL if fence is gone, otherwise
+ *         error pointer.
+ *
+ * NOTE: this function shall be called with cs_lock locked
+ */
 static struct hl_fence *hl_ctx_get_fence_locked(struct hl_ctx *ctx, u64 seq)
 {
 	struct asic_fixed_properties *asic_prop = &ctx->hdev->asic_prop;
@@ -259,6 +269,16 @@ struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 	return fence;
 }
 
+/*
+ * hl_ctx_get_fences - get multiple CS fences under the same CS lock
+ *
+ * @ctx: pointer to the context structure.
+ * @seq_arr: array of CS sequences to wait for
+ * @fence: fence array to store the CS fences
+ * @arr_len: length of seq_arr and fence_arr
+ *
+ * @return 0 on success, otherwise non 0 error code
+ */
 int hl_ctx_get_fences(struct hl_ctx *ctx, u64 *seq_arr,
 				struct hl_fence **fence, u32 arr_len)
 {
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 4f76c7a51605..3751c915f731 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1297,6 +1297,10 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto user_interrupts_fini;
 
+
+	/* initialize completion structure for multi CS wait */
+	hl_multi_cs_completion_init(hdev);
+
 	/*
 	 * Initialize the H/W queues. Must be done before hw_init, because
 	 * there the addresses of the kernel queue are being written to the
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 26f75d070f72..6d5154434637 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -585,7 +585,8 @@ struct asic_fixed_properties {
  * @cs_sequence: sequence of the corresponding command submission
  * @error: mark this fence with error
  * @timestamp: timestamp upon completion
- *
+ * @stream_map: streams bitmap to represent all streams that multi cs is
+ *              waiting on
  */
 struct hl_fence {
 	struct completion	completion;
@@ -593,6 +594,7 @@ struct hl_fence {
 	u64			cs_sequence;
 	int			error;
 	ktime_t			timestamp;
+	u8			stream_map;
 };
 
 /**
@@ -2234,6 +2236,58 @@ struct hl_mmu_funcs {
 			u64 virt_addr, struct hl_mmu_hop_info *hops);
 };
 
+/**
+ * number of user contexts allowed to call wait_for_multi_cs ioctl in
+ * parallel
+ */
+#define MULTI_CS_MAX_USER_CTX	2
+
+/**
+ * struct multi_cs_completion - multi CS wait completion.
+ * @completion: completion of any of the CS in the list
+ * @lock: spinlock for the completion structure
+ * @timestamp: timestamp for the multi-CS completion
+ * @used: 1 if in use, otherwise 0
+ * @stream_map: bitmap of all HW/external queues streams on which the multi-CS
+ *              is waiting
+ */
+struct multi_cs_completion {
+	struct completion	completion;
+	spinlock_t		lock;
+	s64			timestamp;
+	u8			used;
+	u8			stream_map;
+};
+
+/**
+ * struct multi_cs_data - internal data for multi CS call
+ * @ctx: pointer to the context structure
+ * @fence_arr: array of fences of all CSs
+ * @seq_arr: array of CS sequence numbers
+ * @timeout_us: timeout in usec for waiting for CS to complete
+ * @timestamp: timestamp of first completed CS
+ * @wait_status: wait for CS status
+ * @completion_bitmap: bitmap of completed CSs (1- completed, otherwise 0)
+ * @arr_len: fence_arr and seq_arr array length
+ * @stream_map: bitmap of all HW/external queues streams on which the multi-CS
+ *              is waiting
+ * @gone_cs: indication of gone CS (1- there was gone CS, otherwise 0)
+ * @update_ts: update timestamp. 1- update the timestamp, otherwise 0.
+ */
+struct multi_cs_data {
+	struct hl_ctx	*ctx;
+	struct hl_fence	**fence_arr;
+	u64		*seq_arr;
+	s64		timeout_us;
+	s64		timestamp;
+	long		wait_status;
+	u32		completion_bitmap;
+	u8		arr_len;
+	u8		stream_map;
+	u8		gone_cs;
+	u8		update_ts;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -2300,6 +2354,7 @@ struct hl_mmu_funcs {
  * @fw_loader: FW loader manager.
  * @pci_mem_region: array of memory regions in the PCI
  * @state_dump_specs: constants and dictionaries needed to dump system state.
+ * @multi_cs_completion: array of multi-CS completion.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2376,6 +2431,7 @@ struct hl_mmu_funcs {
  *                        halted. We can't halt it again because the COMMS
  *                        protocol will throw an error. Relevant only for
  *                        cases where Linux was not loaded to device CPU
+ * @supports_wait_for_multi_cs: true if wait for multi CS is supported
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2446,6 +2502,9 @@ struct hl_device {
 
 	struct hl_state_dump_specs	state_dump_specs;
 
+	struct multi_cs_completion	multi_cs_completion[
+							MULTI_CS_MAX_USER_CTX];
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2495,6 +2554,7 @@ struct hl_device {
 	u8				curr_reset_cause;
 	u8				skip_reset_on_timeout;
 	u8				device_cpu_is_halted;
+	u8				supports_wait_for_multi_cs;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -2701,6 +2761,7 @@ bool cs_needs_completion(struct hl_cs *cs);
 bool cs_needs_timeout(struct hl_cs *cs);
 bool is_staged_cs_last_exists(struct hl_device *hdev, struct hl_cs *cs);
 struct hl_cs *hl_staged_cs_find_first(struct hl_device *hdev, u64 cs_seq);
+void hl_multi_cs_completion_init(struct hl_device *hdev);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 0afead229e97..f05a0dbd0990 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -603,6 +603,10 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		}
 
 		list_add_tail(&cs->staged_cs_node, &staged_cs->staged_cs_node);
+
+		/* update stream map of the first CS */
+		if (hdev->supports_wait_for_multi_cs)
+			staged_cs->fence->stream_map |= cs->fence->stream_map;
 	}
 
 	list_add_tail(&cs->mirror_node, &hdev->cs_mirror_list);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 561485dcddaf..a4b33b0b17d4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1814,6 +1814,7 @@ static int gaudi_sw_init(struct hl_device *hdev)
 	hdev->supports_sync_stream = true;
 	hdev->supports_coresight = true;
 	hdev->supports_staged_submission = true;
+	hdev->supports_wait_for_multi_cs = true;
 
 	gaudi_set_pci_memory_regions(hdev);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c8d58dd2c041..f6251d8663b2 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -958,6 +958,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	hdev->supports_coresight = true;
 	hdev->supports_soft_reset = true;
 	hdev->allow_external_soft_reset = true;
+	hdev->supports_wait_for_multi_cs = false;
 
 	goya_set_pci_memory_regions(hdev);
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 18765eb75b65..49c737c4a2f6 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -735,11 +735,18 @@ union hl_cs_args {
 
 #define HL_WAIT_CS_FLAGS_INTERRUPT	0x2
 #define HL_WAIT_CS_FLAGS_INTERRUPT_MASK 0xFFF00000
+#define HL_WAIT_CS_FLAGS_MULTI_CS	0x4
+
+#define HL_WAIT_MULTI_CS_LIST_MAX_LEN	32
 
 struct hl_wait_cs_in {
 	union {
 		struct {
-			/* Command submission sequence number */
+			/*
+			 * In case of wait_cs holds the CS sequence number.
+			 * In case of wait for multi CS hold a user pointer to
+			 * an array of CS sequence numbers
+			 */
 			__u64 seq;
 			/* Absolute timeout to wait for command submission
 			 * in microseconds
@@ -767,12 +774,17 @@ struct hl_wait_cs_in {
 
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
+
 	/* HL_WAIT_CS_FLAGS_*
 	 * If HL_WAIT_CS_FLAGS_INTERRUPT is set, this field should include
 	 * interrupt id according to HL_WAIT_CS_FLAGS_INTERRUPT_MASK, in order
 	 * not to specify an interrupt id ,set mask to all 1s.
 	 */
 	__u32 flags;
+
+	/* Multi CS API info- valid entries in multi-CS array */
+	__u8 seq_arr_len;
+	__u8 pad[7];
 };
 
 #define HL_WAIT_CS_STATUS_COMPLETED	0
@@ -789,8 +801,15 @@ struct hl_wait_cs_out {
 	__u32 status;
 	/* HL_WAIT_CS_STATUS_FLAG* */
 	__u32 flags;
-	/* valid only if HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD is set */
+	/*
+	 * valid only if HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD is set
+	 * for wait_cs: timestamp of CS completion
+	 * for wait_multi_cs: timestamp of FIRST CS completion
+	 */
 	__s64 timestamp_nsec;
+	/* multi CS completion bitmap */
+	__u32 cs_completion_map;
+	__u32 pad;
 };
 
 union hl_wait_cs_args {
-- 
2.25.1

