Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686033C6BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhGMHzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234393AbhGMHzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9C1261283;
        Tue, 13 Jul 2021 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162762;
        bh=F38xb+ea50o5DQwe1jjicpxTzqUUMQy/cHK1qDBfRG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Py6EGV07UT7X0DlNGSMCsDTdMNHyHMuDI3YmtWclc+Oo4G+wAnQqIEUqBtB9eWA8d
         CLTo3xZo6LupvGSitZnWva3z3ojmwCIB1zhgYgoP8mH/ffAhqSyCNcRY6yPR/lpedL
         He6aUpXidfbG+fKERD+FYZ+czYJ6cPUYB7IJ8IeBFZigmide2LnqHhf1CIDb/A0eCk
         jB29LudaWgdSy0lJyUTJTlpc3gUoRx+sWxScCUktSVEhyp2f41+6Tiieo0UahFh/E/
         lh5hlwI6mhOyHWiXhygzdckad2ZwVUDuy52DLCB3Ps2kXysQwwD7fATJh7zzdS2E3I
         BF8S2q9S1VrpA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 10/11] habanalabs: add support for encapsulated signals reservation
Date:   Tue, 13 Jul 2021 10:52:25 +0300
Message-Id: <20210713075226.11094-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

The signaling from within encapsulated OP capability is merged into the
existing stream architecture, such that one can trigger multiple
signaling from an encapsulated op, according to the time the event
was done in the graph execution and avoid the need to wait for the
whole encapsulated OP execution to be complete before the stream can
signal.

This commit implements only the reserve/unreserve part.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 255 +++++++++++++++++-
 drivers/misc/habanalabs/common/context.c      |  56 ++++
 drivers/misc/habanalabs/common/habanalabs.h   |  55 +++-
 .../misc/habanalabs/common/habanalabs_drv.c   |   1 -
 drivers/misc/habanalabs/common/hw_queue.c     |   5 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |   8 +-
 drivers/misc/habanalabs/goya/goya.c           |   6 +
 include/uapi/misc/habanalabs.h                | 110 +++++++-
 8 files changed, 468 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 458cdf2ddab5..84032b1bae5c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -38,7 +38,11 @@ static void hl_sob_reset(struct kref *ref)
 							kref);
 	struct hl_device *hdev = hw_sob->hdev;
 
+	dev_dbg(hdev->dev, "reset sob id %u\n", hw_sob->sob_id);
+
 	hdev->asic_funcs->reset_sob(hdev, hw_sob);
+
+	hw_sob->need_reset = false;
 }
 
 void hl_sob_reset_error(struct kref *ref)
@@ -52,7 +56,7 @@ void hl_sob_reset_error(struct kref *ref)
 		hw_sob->q_idx, hw_sob->sob_id);
 }
 
-static void hw_sob_put(struct hl_hw_sob *hw_sob)
+void hw_sob_put(struct hl_hw_sob *hw_sob)
 {
 	if (hw_sob)
 		kref_put(&hw_sob->kref, hl_sob_reset);
@@ -64,7 +68,7 @@ static void hw_sob_put_err(struct hl_hw_sob *hw_sob)
 		kref_put(&hw_sob->kref, hl_sob_reset_error);
 }
 
-static void hw_sob_get(struct hl_hw_sob *hw_sob)
+void hw_sob_get(struct hl_hw_sob *hw_sob)
 {
 	if (hw_sob)
 		kref_get(&hw_sob->kref);
@@ -576,7 +580,8 @@ static inline void cs_release_sob_reset_handler(struct hl_device *hdev,
 
 	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
 			(hl_cs_cmpl->type == CS_TYPE_WAIT) ||
-			(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT)) {
+			(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT) ||
+			(!!hl_cs_cmpl->encaps_signals)) {
 		dev_dbg(hdev->dev,
 				"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
 				hl_cs_cmpl->cs_seq,
@@ -829,6 +834,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	cs_cmpl->hdev = hdev;
 	cs_cmpl->type = cs->type;
+	cs_cmpl->encaps_signals = false;
 	spin_lock_init(&cs_cmpl->lock);
 	INIT_WORK(&cs_cmpl->sob_reset_work, sob_reset_work);
 	cs->fence = &cs_cmpl->base_fence;
@@ -1115,6 +1121,10 @@ static enum hl_cs_type hl_cs_get_cs_type(u32 cs_type_flags)
 		return CS_TYPE_WAIT;
 	else if (cs_type_flags & HL_CS_FLAGS_COLLECTIVE_WAIT)
 		return CS_TYPE_COLLECTIVE_WAIT;
+	else if (cs_type_flags & HL_CS_FLAGS_RESERVE_SIGNALS_ONLY)
+		return CS_RESERVE_SIGNALS;
+	else if (cs_type_flags & HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY)
+		return CS_UNRESERVE_SIGNALS;
 	else
 		return CS_TYPE_DEFAULT;
 }
@@ -1652,10 +1662,17 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
  * hl_cs_signal_sob_wraparound_handler: handle SOB value wrapaound case.
  * if the SOB value reaches the max value move to the other SOB reserved
  * to the queue.
+ * @hdev: pointer to device structure
+ * @q_idx: stream queue index
+ * @hw_sob: the H/W SOB used in this signal CS.
+ * @count: signals count
+ * @encaps_sig: tells whether it's reservation for encaps signals or not.
+ *
  * Note that this function must be called while hw_queues_lock is taken.
  */
 int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
-			struct hl_hw_sob **hw_sob, u32 count)
+			struct hl_hw_sob **hw_sob, u32 count, bool encaps_sig)
+
 {
 	struct hl_sync_stream_properties *prop;
 	struct hl_hw_sob *sob = *hw_sob, *other_sob;
@@ -1688,12 +1705,34 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 			return -EINVAL;
 		}
 
-		prop->next_sob_val = 1;
+		prop->next_sob_val = count;
 
 		/* only two SOBs are currently in use */
 		prop->curr_sob_offset = other_sob_offset;
 		*hw_sob = other_sob;
 
+		/*
+		 * check if other_sob needs reset, then do it before using it
+		 * for the reservation or the next signal cs.
+		 * we do it here, and for both encaps and regular signal cs
+		 * cases in order to avoid possible races of two kref_put
+		 * of the sob which can occur at the same time if we move the
+		 * sob reset(kref_put) to cs_do_release function.
+		 * in addition, if we have combination of cs signal and
+		 * encaps, and at the point we need to reset the sob there was
+		 * no more reservations and only signal cs keep coming,
+		 * in such case we need to signal_cs to put the refcount and
+		 * reset the sob.
+		 */
+		if (other_sob->need_reset)
+			kref_put(&other_sob->kref, hl_sob_reset);
+
+		if (encaps_sig) {
+			/* set reset indication for the sob */
+			sob->need_reset = true;
+			hw_sob_get(other_sob);
+		}
+
 		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
 				prop->curr_sob_offset, q_idx);
 	} else {
@@ -1817,6 +1856,187 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	return 0;
 }
 
+static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
+				u32 q_idx, u32 count,
+				u32 *handle_id, u32 *sob_addr,
+				u32 *signals_count)
+{
+	struct hw_queue_properties *hw_queue_prop;
+	struct hl_sync_stream_properties *prop;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cs_encaps_sig_handle *handle;
+	struct hl_encaps_signals_mgr *mgr;
+	struct hl_hw_sob *hw_sob;
+	int hdl_id;
+	int rc = 0;
+
+	if (count >= HL_MAX_SOB_VAL) {
+		dev_err(hdev->dev, "signals count(%u) exceeds the max SOB value\n",
+						count);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (q_idx >= hdev->asic_prop.max_queues) {
+		dev_err(hdev->dev, "Queue index %d is invalid\n",
+			q_idx);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
+
+	if (!hw_queue_prop->supports_sync_stream) {
+		dev_err(hdev->dev,
+			"Queue index %d does not support sync stream operations\n",
+									q_idx);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	handle->count = count;
+	mgr = &hpriv->ctx->sig_mgr;
+
+	spin_lock(&mgr->lock);
+	hdl_id = idr_alloc(&mgr->handles, handle, 1, 0, GFP_KERNEL);
+	spin_unlock(&mgr->lock);
+
+	if (hdl_id < 0) {
+		dev_err(hdev->dev, "Failed to allocate IDR for a new signal reservation\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	handle->id = hdl_id;
+	handle->q_idx = q_idx;
+	handle->hdev = hdev;
+	kref_init(&handle->refcount);
+
+	hdev->asic_funcs->hw_queues_lock(hdev);
+
+	hw_sob = &prop->hw_sob[prop->curr_sob_offset];
+
+	/*
+	 * Increment the SOB value by count by user request
+	 * to reserve those signals
+	 * check if the signals amount to reserve is not exceeding the max sob
+	 * value, if yes then switch sob.
+	 */
+	rc = hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, count,
+						true);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to switch SOB\n");
+		hdev->asic_funcs->hw_queues_unlock(hdev);
+		rc = -EINVAL;
+		goto remove_idr;
+	}
+
+	/* set the hw_sob to the handle after calling the sob wraparound handler
+	 * since sob could have changed.
+	 */
+	handle->hw_sob = hw_sob;
+
+	/* store the current sob value for unreserve validity check, and
+	 * signal offset support
+	 */
+	handle->pre_sob_val = prop->next_sob_val - handle->count;
+
+	*signals_count = prop->next_sob_val;
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	*sob_addr = handle->hw_sob->sob_addr;
+	*handle_id = hdl_id;
+
+	dev_dbg(hdev->dev,
+		"Signals reserved, sob_id: %d, sob addr: 0x%x, sob val: 0x%x, q_idx: %d, hdl_id: %d\n",
+			hw_sob->sob_id, handle->hw_sob->sob_addr,
+			prop->next_sob_val, q_idx, hdl_id);
+	goto out;
+
+remove_idr:
+	spin_lock(&mgr->lock);
+	idr_remove(&mgr->handles, hdl_id);
+	spin_unlock(&mgr->lock);
+
+	kfree(handle);
+out:
+	return rc;
+}
+
+static int cs_ioctl_unreserve_signals(struct hl_fpriv *hpriv, u32 handle_id)
+{
+	struct hl_cs_encaps_sig_handle *encaps_sig_hdl;
+	struct hl_sync_stream_properties *prop;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_encaps_signals_mgr *mgr;
+	struct hl_hw_sob *hw_sob;
+	u32 q_idx, sob_addr;
+	int rc = 0;
+
+	mgr = &hpriv->ctx->sig_mgr;
+
+	spin_lock(&mgr->lock);
+	encaps_sig_hdl = idr_find(&mgr->handles, handle_id);
+	if (encaps_sig_hdl) {
+		dev_dbg(hdev->dev, "unreserve signals, handle: %u, SOB:0x%x, count: %u\n",
+				handle_id, encaps_sig_hdl->hw_sob->sob_addr,
+					encaps_sig_hdl->count);
+
+		hdev->asic_funcs->hw_queues_lock(hdev);
+
+		q_idx = encaps_sig_hdl->q_idx;
+		prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+		hw_sob = &prop->hw_sob[prop->curr_sob_offset];
+		sob_addr = hdev->asic_funcs->get_sob_addr(hdev, hw_sob->sob_id);
+
+		/* Check if sob_val got out of sync due to other
+		 * signal submission requests which were handled
+		 * between the reserve-unreserve calls or SOB switch
+		 * upon reaching SOB max value.
+		 */
+		if (encaps_sig_hdl->pre_sob_val + encaps_sig_hdl->count
+				!= prop->next_sob_val ||
+				sob_addr != encaps_sig_hdl->hw_sob->sob_addr) {
+			dev_err(hdev->dev, "Cannot unreserve signals, SOB val ran out of sync, expected: %u, actual val: %u\n",
+				encaps_sig_hdl->pre_sob_val,
+				(prop->next_sob_val - encaps_sig_hdl->count));
+
+			hdev->asic_funcs->hw_queues_unlock(hdev);
+			rc = -EINVAL;
+			goto out;
+		}
+
+		/*
+		 * Decrement the SOB value by count by user request
+		 * to unreserve those signals
+		 */
+		prop->next_sob_val -= encaps_sig_hdl->count;
+
+		hdev->asic_funcs->hw_queues_unlock(hdev);
+
+		hw_sob_put(hw_sob);
+
+		/* Release the id and free allocated memory of the handle */
+		idr_remove(&mgr->handles, handle_id);
+		kfree(encaps_sig_hdl);
+	} else {
+		rc = -EINVAL;
+		dev_err(hdev->dev, "failed to unreserve signals, cannot find handler\n");
+	}
+out:
+	spin_unlock(&mgr->lock);
+
+	return rc;
+}
+
 static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
 				u64 *cs_seq, u32 flags, u32 timeout)
@@ -1996,10 +2216,11 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cs_args *args = data;
-	enum hl_cs_type cs_type;
+	enum hl_cs_type cs_type = 0;
 	u64 cs_seq = ULONG_MAX;
 	void __user *chunks;
-	u32 num_chunks, flags, timeout;
+	u32 num_chunks, flags, timeout,
+		signals_count = 0, sob_addr = 0, handle_id = 0;
 	int rc;
 
 	rc = hl_cs_sanity_checks(hpriv, args);
@@ -2036,17 +2257,33 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks, num_chunks,
 					&cs_seq, args->in.cs_flags, timeout);
 		break;
+	case CS_RESERVE_SIGNALS:
+		rc = cs_ioctl_reserve_signals(hpriv,
+					args->in.encaps_signals_q_idx,
+					args->in.encaps_signals_count,
+					&handle_id, &sob_addr, &signals_count);
+		break;
+	case CS_UNRESERVE_SIGNALS:
+		rc = cs_ioctl_unreserve_signals(hpriv,
+					args->in.encaps_sig_handle_id);
+		break;
 	default:
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
 						args->in.cs_flags, timeout);
 		break;
 	}
-
 out:
 	if (rc != -EAGAIN) {
 		memset(args, 0, sizeof(*args));
+
+		if (cs_type == CS_RESERVE_SIGNALS) {
+			args->out.handle_id = handle_id;
+			args->out.sob_base_addr_offset = sob_addr;
+			args->out.count = signals_count;
+		} else {
+			args->out.seq = cs_seq;
+		}
 		args->out.status = rc;
-		args->out.seq = cs_seq;
 	}
 
 	return rc;
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 4d922e4d0393..abbba4194d3b 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -9,6 +9,59 @@
 
 #include <linux/slab.h>
 
+void hl_encaps_handle_do_release(struct kref *ref)
+{
+	struct hl_cs_encaps_sig_handle *handle =
+		container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
+	struct hl_ctx *ctx = handle->hdev->compute_ctx;
+	struct hl_encaps_signals_mgr *mgr = &ctx->sig_mgr;
+
+	idr_remove(&mgr->handles, handle->id);
+	kfree(handle);
+}
+
+static void hl_encaps_handle_do_release_sob(struct kref *ref)
+{
+	struct hl_cs_encaps_sig_handle *handle =
+		container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
+	struct hl_ctx *ctx = handle->hdev->compute_ctx;
+	struct hl_encaps_signals_mgr *mgr = &ctx->sig_mgr;
+
+	/* if we're here, then there was a signals reservation but cs with
+	 * encaps signals wasn't submitted, so need to put refcount
+	 * to hw_sob taken at the reservation.
+	 */
+	hw_sob_put(handle->hw_sob);
+
+	idr_remove(&mgr->handles, handle->id);
+	kfree(handle);
+}
+
+static void hl_encaps_sig_mgr_init(struct hl_encaps_signals_mgr *mgr)
+{
+	spin_lock_init(&mgr->lock);
+	idr_init(&mgr->handles);
+}
+
+static void hl_encaps_sig_mgr_fini(struct hl_device *hdev,
+			struct hl_encaps_signals_mgr *mgr)
+{
+	struct hl_cs_encaps_sig_handle *handle;
+	struct idr *idp;
+	u32 id;
+
+	idp = &mgr->handles;
+
+	if (!idr_is_empty(idp)) {
+		dev_warn(hdev->dev, "device released while some encaps signals handles are still allocated\n");
+		idr_for_each_entry(idp, handle, id)
+			kref_put(&handle->refcount,
+					hl_encaps_handle_do_release_sob);
+	}
+
+	idr_destroy(&mgr->handles);
+}
+
 static void hl_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
@@ -53,6 +106,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		hl_cb_va_pool_fini(ctx);
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
+		hl_encaps_sig_mgr_fini(hdev, &ctx->sig_mgr);
 
 		/* Scrub both SRAM and DRAM */
 		hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
@@ -200,6 +254,8 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 			goto err_cb_va_pool_fini;
 		}
 
+		hl_encaps_sig_mgr_init(&ctx->sig_mgr);
+
 		dev_dbg(hdev->dev, "create user context %d\n", ctx->asid);
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bf327cb7ddd6..81b6825e0c1c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -242,7 +242,9 @@ enum hl_cs_type {
 	CS_TYPE_DEFAULT,
 	CS_TYPE_SIGNAL,
 	CS_TYPE_WAIT,
-	CS_TYPE_COLLECTIVE_WAIT
+	CS_TYPE_COLLECTIVE_WAIT,
+	CS_RESERVE_SIGNALS,
+	CS_UNRESERVE_SIGNALS
 };
 
 /*
@@ -287,13 +289,17 @@ enum queue_cb_alloc_flags {
  * @hdev: habanalabs device structure.
  * @kref: refcount of this SOB. The SOB will reset once the refcount is zero.
  * @sob_id: id of this SOB.
+ * @sob_addr: the sob offset from the base address.
  * @q_idx: the H/W queue that uses this SOB.
+ * @need_reset: reset indication set when switching to the other sob.
  */
 struct hl_hw_sob {
 	struct hl_device	*hdev;
 	struct kref		kref;
 	u32			sob_id;
+	u32			sob_addr;
 	u32			q_idx;
+	bool			need_reset;
 };
 
 enum hl_collective_mode {
@@ -608,6 +614,8 @@ struct hl_fence {
  * @type: type of the CS - signal/wait.
  * @sob_val: the SOB value that is used in this signal/wait CS.
  * @sob_group: the SOB group that is used in this collective wait CS.
+ * @encaps_signals: indication whether it's a completion object of cs with
+ * encaps signals or not.
  */
 struct hl_cs_compl {
 	struct work_struct	sob_reset_work;
@@ -619,6 +627,7 @@ struct hl_cs_compl {
 	enum hl_cs_type		type;
 	u16			sob_val;
 	u16			sob_group;
+	bool			encaps_signals;
 };
 
 /*
@@ -730,6 +739,17 @@ struct hl_sync_stream_properties {
 	u8		curr_sob_offset;
 };
 
+/**
+ * struct hl_encaps_signals_mgr - describes sync stream encapsulated signals
+ * handlers manager
+ * @lock: protects handles.
+ * @handles: an idr to hold all encapsulated signals handles.
+ */
+struct hl_encaps_signals_mgr {
+	spinlock_t		lock;
+	struct idr		handles;
+};
+
 /**
  * struct hl_hw_queue - describes a H/W transport queue.
  * @shadow_queue: pointer to a shadow queue that holds pointers to jobs.
@@ -1135,6 +1155,7 @@ struct fw_load_mgr {
  * @init_firmware_loader: initialize data for FW loader.
  * @init_cpu_scrambler_dram: Enable CPU specific DRAM scrambling
  * @state_dump_init: initialize constants required for state dump
+ * @get_sob_addr: get SOB base address offset.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1261,6 +1282,7 @@ struct hl_asic_funcs {
 	void (*init_firmware_loader)(struct hl_device *hdev);
 	void (*init_cpu_scrambler_dram)(struct hl_device *hdev);
 	void (*state_dump_init)(struct hl_device *hdev);
+	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
 };
 
 
@@ -1353,6 +1375,7 @@ struct hl_pending_cb {
  * @cs_counters: context command submission counters.
  * @cb_va_pool: device VA pool for command buffers which are mapped to the
  *              device's MMU.
+ * @sig_mgr: encaps signals handle manager.
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
  *			to user so user could inquire about CS. It is used as
  *			index to cs_pending array.
@@ -1392,6 +1415,7 @@ struct hl_ctx {
 	struct list_head		hw_block_mem_list;
 	struct hl_cs_counters_atomic	cs_counters;
 	struct gen_pool			*cb_va_pool;
+	struct hl_encaps_signals_mgr	sig_mgr;
 	u64				cs_sequence;
 	u64				*dram_default_hops;
 	spinlock_t			pending_cb_lock;
@@ -2504,7 +2528,6 @@ struct hl_device {
 
 	struct multi_cs_completion	multi_cs_completion[
 							MULTI_CS_MAX_USER_CTX];
-
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2576,6 +2599,29 @@ struct hl_device {
 };
 
 
+/**
+ * struct hl_cs_encaps_sig_handle - encapsulated signals handle structure
+ * @refcount: refcount used to protect removing this id when several
+ *            wait cs are used to wait of the reserved encaps signals.
+ * @hdev: pointer to habanalabs device structure.
+ * @hw_sob: pointer to  H/W SOB used in the reservation.
+ * @cs_seq: staged cs sequence which contains encapsulated signals
+ * @id: idr handler id to be used to fetch the handler info
+ * @q_idx: stream queue index
+ * @pre_sob_val: current SOB value before reservation
+ * @count: signals number
+ */
+struct hl_cs_encaps_sig_handle {
+	struct kref refcount;
+	struct hl_device *hdev;
+	struct hl_hw_sob *hw_sob;
+	u64  cs_seq;
+	u32  id;
+	u32  q_idx;
+	u32  pre_sob_val;
+	u32  count;
+};
+
 /*
  * IOCTLs
  */
@@ -2889,9 +2935,12 @@ int hl_set_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
+void hl_encaps_handle_do_release(struct kref *ref);
+void hw_sob_get(struct hl_hw_sob *hw_sob);
+void hw_sob_put(struct hl_hw_sob *hw_sob);
 void hl_release_pending_user_interrupts(struct hl_device *hdev);
 int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
-			struct hl_hw_sob **hw_sob, u32 count);
+			struct hl_hw_sob **hw_sob, u32 count, bool encaps_sig);
 
 int hl_state_dump(struct hl_device *hdev);
 const char *hl_state_dump_get_sync_name(struct hl_device *hdev, u32 sync_id);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index bffca119946b..3df4313d72cd 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -194,7 +194,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
-
 	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 2494bd6e9358..9a59b8e9bf53 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -426,7 +426,8 @@ static int init_signal_cs(struct hl_device *hdev,
 	hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
 				cs_cmpl->hw_sob->sob_id, 0, true);
 
-	rc = hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1);
+	rc = hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1,
+								false);
 
 	return rc;
 }
@@ -850,6 +851,8 @@ static void sync_stream_queue_init(struct hl_device *hdev, u32 q_idx)
 		hw_sob = &sync_stream_prop->hw_sob[sob];
 		hw_sob->hdev = hdev;
 		hw_sob->sob_id = sync_stream_prop->base_sob_id + sob;
+		hw_sob->sob_addr =
+			hdev->asic_funcs->get_sob_addr(hdev, hw_sob->sob_id);
 		hw_sob->q_idx = q_idx;
 		kref_init(&hw_sob->kref);
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 5b7a5692cd21..ae1a8b4e694c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8720,6 +8720,11 @@ static u32 gaudi_get_wait_cb_size(struct hl_device *hdev)
 			sizeof(struct packet_msg_prot) * 2;
 }
 
+static u32 gaudi_get_sob_addr(struct hl_device *hdev, u32 sob_id)
+{
+	return mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0 + (sob_id * 4);
+}
+
 static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
 				u32 size, bool eb)
 {
@@ -9424,7 +9429,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx,
 	.init_firmware_loader = gaudi_init_firmware_loader,
 	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm,
-	.state_dump_init = gaudi_state_dump_init
+	.state_dump_init = gaudi_state_dump_init,
+	.get_sob_addr = gaudi_get_sob_addr
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dd218a4bb62e..8a689bf42397 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5575,6 +5575,11 @@ static void goya_state_dump_init(struct hl_device *hdev)
 	hdev->state_dump_specs.funcs = goya_state_dump_funcs;
 }
 
+static u32 goya_get_sob_addr(struct hl_device *hdev, u32 sob_id)
+{
+	return 0;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5662,6 +5667,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.init_firmware_loader = goya_init_firmware_loader,
 	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram,
 	.state_dump_init = goya_state_dump_init,
+	.get_sob_addr = &goya_get_sob_addr
 };
 
 /*
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 49c737c4a2f6..eca86c545916 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -628,12 +628,21 @@ struct hl_cs_chunk {
 		__u64 cb_handle;
 
 		/* Relevant only when HL_CS_FLAGS_WAIT or
-		 * HL_CS_FLAGS_COLLECTIVE_WAIT is set.
+		 * HL_CS_FLAGS_COLLECTIVE_WAIT is set
 		 * This holds address of array of u64 values that contain
-		 * signal CS sequence numbers. The wait described by this job
-		 * will listen on all those signals (wait event per signal)
+		 * signal CS sequence numbers. The wait described by
+		 * this job will listen on all those signals
+		 * (wait event per signal)
 		 */
 		__u64 signal_seq_arr;
+
+		/*
+		 * Relevant only when HL_CS_FLAGS_WAIT or
+		 * HL_CS_FLAGS_COLLECTIVE_WAIT is set
+		 * along with HL_CS_FLAGS_ENCAP_SIGNALS.
+		 * This is the CS sequence which has the encapsulated signals.
+		 */
+		__u64 encaps_signal_seq;
 	};
 
 	/* Index of queue to put the CB on */
@@ -651,6 +660,17 @@ struct hl_cs_chunk {
 		 * Number of entries in signal_seq_arr
 		 */
 		__u32 num_signal_seq_arr;
+
+		/* Relevant only when HL_CS_FLAGS_WAIT or
+		 * HL_CS_FLAGS_COLLECTIVE_WAIT is set along
+		 * with HL_CS_FLAGS_ENCAP_SIGNALS
+		 * This set the signals range that the user want to wait for
+		 * out of the whole reserved signals range.
+		 * e.g if the signals range is 20, and user don't want
+		 * to wait for signal 8, so he set this offset to 7, then
+		 * he call the API again with 9 and so on till 20.
+		 */
+		__u32 encaps_signal_offset;
 	};
 
 	/* HL_CS_CHUNK_FLAGS_* */
@@ -678,6 +698,28 @@ struct hl_cs_chunk {
 #define HL_CS_FLAGS_CUSTOM_TIMEOUT		0x200
 #define HL_CS_FLAGS_SKIP_RESET_ON_TIMEOUT	0x400
 
+/*
+ * The encapsulated signals CS is merged into the existing CS ioctls.
+ * In order to use this feature need to follow the below procedure:
+ * 1. Reserve signals, set the CS type to HL_CS_FLAGS_RESERVE_SIGNALS_ONLY
+ *    the output of this API will be the SOB offset from CFG_BASE.
+ *    this address will be used to patch CB cmds to do the signaling for this
+ *    SOB by incrementing it's value.
+ *    for reverting the reservation use HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY
+ *    CS type, note that this might fail if out-of-sync happened to the SOB
+ *    value, in case other signaling request to the same SOB occurred between
+ *    reserve-unreserve calls.
+ * 2. Use the staged CS to do the encapsulated signaling jobs.
+ *    use HL_CS_FLAGS_STAGED_SUBMISSION and HL_CS_FLAGS_STAGED_SUBMISSION_FIRST
+ *    along with HL_CS_FLAGS_ENCAP_SIGNALS flag, and set encaps_signal_offset
+ *    field. This offset allows app to wait on part of the reserved signals.
+ * 3. Use WAIT/COLLECTIVE WAIT CS along with HL_CS_FLAGS_ENCAP_SIGNALS flag
+ *    to wait for the encapsulated signals.
+ */
+#define HL_CS_FLAGS_ENCAP_SIGNALS		0x800
+#define HL_CS_FLAGS_RESERVE_SIGNALS_ONLY	0x1000
+#define HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY	0x2000
+
 #define HL_CS_STATUS_SUCCESS		0
 
 #define HL_MAX_JOBS_PER_CS		512
@@ -690,10 +732,35 @@ struct hl_cs_in {
 	/* holds address of array of hl_cs_chunk for execution phase */
 	__u64 chunks_execute;
 
-	/* Sequence number of a staged submission CS
-	 * valid only if HL_CS_FLAGS_STAGED_SUBMISSION is set
-	 */
-	__u64 seq;
+	union {
+		/*
+		 * Sequence number of a staged submission CS
+		 * valid only if HL_CS_FLAGS_STAGED_SUBMISSION is set and
+		 * HL_CS_FLAGS_STAGED_SUBMISSION_FIRST is unset.
+		 */
+		__u64 seq;
+
+		/*
+		 * Encapsulated signals handle id
+		 * Valid for two flows:
+		 * 1. CS with encapsulated signals:
+		 *    when HL_CS_FLAGS_STAGED_SUBMISSION and
+		 *    HL_CS_FLAGS_STAGED_SUBMISSION_FIRST
+		 *    and HL_CS_FLAGS_ENCAP_SIGNALS are set.
+		 * 2. unreserve signals:
+		 *    valid when HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY is set.
+		 */
+		__u32 encaps_sig_handle_id;
+
+		/* Valid only when HL_CS_FLAGS_RESERVE_SIGNALS_ONLY is set */
+		struct {
+			/* Encapsulated signals number */
+			__u32 encaps_signals_count;
+
+			/* Encapsulated signals queue index (stream) */
+			__u32 encaps_signals_q_idx;
+		};
+	};
 
 	/* Number of chunks in restore phase array. Maximum number is
 	 * HL_MAX_JOBS_PER_CS
@@ -718,14 +785,31 @@ struct hl_cs_in {
 };
 
 struct hl_cs_out {
+	union {
+		/*
+		 * seq holds the sequence number of the CS to pass to wait
+		 * ioctl. All values are valid except for 0 and ULLONG_MAX
+		 */
+		__u64 seq;
+
+		/* Valid only when HL_CS_FLAGS_RESERVE_SIGNALS_ONLY is set */
+		struct {
+			/* This is the resereved signal handle id */
+			__u32 handle_id;
+
+			/* This is the signals count */
+			__u32 count;
+		};
+	};
+
+	/* HL_CS_STATUS */
+	__u32 status;
+
 	/*
-	 * seq holds the sequence number of the CS to pass to wait ioctl. All
-	 * values are valid except for 0 and ULLONG_MAX
+	 * SOB base address offset
+	 * Valid only when HL_CS_FLAGS_RESERVE_SIGNALS_ONLY is set
 	 */
-	__u64 seq;
-	/* HL_CS_STATUS_* */
-	__u32 status;
-	__u32 pad;
+	__u32 sob_base_addr_offset;
 };
 
 union hl_cs_args {
-- 
2.25.1

