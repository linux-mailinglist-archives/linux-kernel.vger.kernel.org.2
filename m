Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AB3F0509
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhHRNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237598AbhHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF54B610CD;
        Wed, 18 Aug 2021 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293977;
        bh=K1WwLJ2b72Jje+7uVrJoBJTVNzdBzdJoZqZEOWLymQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZwSH2hU6utR5ojeaBKx0VkcHk3nPHxzw39MUYOVLr2ZqYCvdha5TlLr3GdGqssqN
         kRDHT1Gp8ecuwl8VE9RTJYQxG7EXhJg13MXTEpuh/B9RMaPXOGvKj4uGCW6vx2Rmq1
         hJSkCl0uXOlNOeABmS8swNTUQL+tbUh5neG/D+BSWklrLo5WNAyEneoK8ApG0WD7qX
         Hs6xbuH796wjIloimZWS6pnTM2VZULsgimZm3mMNU/Il1xywc19TxXI2AcerULrgy3
         en8GACxco/JSdL4iNgvhYdaN/wUz+8hv2WMrOP+OWPMKXUhV98IbXVQ1+kuyrfca4+
         y3c4/BBoTa6hA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 10/16] habanalabs: modify multi-CS to wait on stream masters
Date:   Wed, 18 Aug 2021 16:39:16 +0300
Message-Id: <20210818133922.63637-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

During the integration, the multi-CS requirements were refined:
- The multi CS call shall wait on "per-ASIC" predefined stream masters
  instead of set of streams.
- Stream masters are set of QIDs used by the upper SW layers (synapse)
  for completion (must be an external/HW queue).

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 50 ++++++++++++-------
 drivers/misc/habanalabs/common/habanalabs.h   | 22 ++++----
 drivers/misc/habanalabs/common/hw_queue.c     |  3 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 22 +++++++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  2 +
 drivers/misc/habanalabs/goya/goya.c           |  6 +++
 6 files changed, 77 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index d71bd48cbc44..3a67265312ee 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -487,14 +487,15 @@ static void force_complete_multi_cs(struct hl_device *hdev)
  *
  * @hdev: pointer to habanalabs device structure
  * @cs: CS structure
- *
- * The function signals waiting entity that its waiting stream has common
- * stream with the completed CS.
+ * The function signals a waiting entity that has an overlapping stream masters
+ * with the completed CS.
  * For example:
- * - a completed CS worked on streams 0 and 1, multi CS completion
- *   is actively waiting on stream 3. don't send signal as no common stream
- * - a completed CS worked on streams 0 and 1, multi CS completion
- *   is actively waiting on streams 1 and 3. send signal as stream 1 is common
+ * - a completed CS worked on stream master QID 4, multi CS completion
+ *   is actively waiting on stream master QIDs 3, 5. don't send signal as no
+ *   common stream master QID
+ * - a completed CS worked on stream master QID 4, multi CS completion
+ *   is actively waiting on stream master QIDs 3, 4. send signal as stream
+ *   master QID 4 is common
  */
 static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 {
@@ -518,10 +519,11 @@ static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 		 * complete if:
 		 * 1. still waiting for completion
 		 * 2. the completed CS has at least one overlapping stream
-		 *    with the streams in the completion
+		 *    master with the stream masters in the completion
 		 */
 		if (mcs_compl->used &&
-				(fence->stream_map & mcs_compl->stream_map)) {
+				(fence->stream_master_qid_map &
+					mcs_compl->stream_master_qid_map)) {
 			/* extract the timestamp only of first completed CS */
 			if (!mcs_compl->timestamp)
 				mcs_compl->timestamp =
@@ -1228,6 +1230,17 @@ static int cs_staged_submission(struct hl_device *hdev, struct hl_cs *cs,
 	return 0;
 }
 
+static u32 get_stream_master_qid_mask(struct hl_device *hdev, u32 qid)
+{
+	int i;
+
+	for (i = 0; i < hdev->stream_master_qid_arr_size; i++)
+		if (qid == hdev->stream_master_qid_arr[i])
+			return BIT(i);
+
+	return 0;
+}
+
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 				u32 num_chunks, u64 *cs_seq, u32 flags,
 				u32 encaps_signals_handle, u32 timeout)
@@ -1241,7 +1254,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	struct hl_cs *cs;
 	struct hl_cb *cb;
 	u64 user_sequence;
-	u8 stream_map = 0;
+	u8 stream_master_qid_map = 0;
 	int rc, i;
 
 	cntr = &hdev->aggregated_cs_counters;
@@ -1310,7 +1323,9 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 			 * queues of this CS
 			 */
 			if (hdev->supports_wait_for_multi_cs)
-				stream_map |= BIT((chunk->queue_index % 4));
+				stream_master_qid_map |=
+					get_stream_master_qid_mask(hdev,
+							chunk->queue_index);
 		}
 
 		job = hl_cs_allocate_job(hdev, queue_type,
@@ -1378,7 +1393,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	 * fence object for multi-CS completion
 	 */
 	if (hdev->supports_wait_for_multi_cs)
-		cs->fence->stream_map = stream_map;
+		cs->fence->stream_master_qid_map = stream_master_qid_map;
 
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
@@ -2332,7 +2347,7 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 			break;
 		}
 
-		mcs_data->stream_map |= fence->stream_map;
+		mcs_data->stream_master_qid_map |= fence->stream_master_qid_map;
 
 		if (status == CS_WAIT_STATUS_BUSY)
 			continue;
@@ -2394,7 +2409,8 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
  * hl_wait_multi_cs_completion_init - init completion structure
  *
  * @hdev: pointer to habanalabs device structure
- * @stream_map: stream map, set bit indicates stream to wait on
+ * @stream_master_bitmap: stream master QIDs map, set bit indicates stream
+ *                        master QID to wait on
  *
  * @return valid completion struct pointer on success, otherwise error pointer
  *
@@ -2404,7 +2420,7 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
  */
 static struct multi_cs_completion *hl_wait_multi_cs_completion_init(
 							struct hl_device *hdev,
-							u8 stream_map)
+							u8 stream_master_bitmap)
 {
 	struct multi_cs_completion *mcs_compl;
 	int i;
@@ -2416,7 +2432,7 @@ static struct multi_cs_completion *hl_wait_multi_cs_completion_init(
 		if (!mcs_compl->used) {
 			mcs_compl->used = 1;
 			mcs_compl->timestamp = 0;
-			mcs_compl->stream_map = stream_map;
+			mcs_compl->stream_master_qid_map = stream_master_bitmap;
 			reinit_completion(&mcs_compl->completion);
 			spin_unlock(&mcs_compl->lock);
 			break;
@@ -2464,7 +2480,7 @@ static int hl_wait_multi_cs_completion(struct multi_cs_data *mcs_data)
 	long completion_rc;
 
 	mcs_compl = hl_wait_multi_cs_completion_init(hdev,
-							mcs_data->stream_map);
+					mcs_data->stream_master_qid_map);
 	if (IS_ERR(mcs_compl))
 		return PTR_ERR(mcs_compl);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b950b5140610..74c2a587d907 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -593,18 +593,18 @@ struct asic_fixed_properties {
  * @completion: fence is implemented using completion
  * @refcount: refcount for this fence
  * @cs_sequence: sequence of the corresponding command submission
+ * @stream_master_qid_map: streams masters QID bitmap to represent all streams
+ *                         masters QIDs that multi cs is waiting on
  * @error: mark this fence with error
  * @timestamp: timestamp upon completion
- * @stream_map: streams bitmap to represent all streams that multi cs is
- *              waiting on
  */
 struct hl_fence {
 	struct completion	completion;
 	struct kref		refcount;
 	u64			cs_sequence;
+	u32			stream_master_qid_map;
 	int			error;
 	ktime_t			timestamp;
-	u8			stream_map;
 };
 
 /**
@@ -1161,6 +1161,7 @@ struct fw_load_mgr {
  * @state_dump_init: initialize constants required for state dump
  * @get_sob_addr: get SOB base address offset.
  * @set_pci_memory_regions: setting properties of PCI memory regions
+ * @get_stream_master_qid_arr: get pointer to stream masters QID array
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1290,6 +1291,7 @@ struct hl_asic_funcs {
 	void (*state_dump_init)(struct hl_device *hdev);
 	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
 	void (*set_pci_memory_regions)(struct hl_device *hdev);
+	u32* (*get_stream_master_qid_arr)(void);
 };
 
 
@@ -2283,16 +2285,16 @@ struct hl_mmu_funcs {
  * @completion: completion of any of the CS in the list
  * @lock: spinlock for the completion structure
  * @timestamp: timestamp for the multi-CS completion
+ * @stream_master_qid_map: bitmap of all stream masters on which the multi-CS
+ *                        is waiting
  * @used: 1 if in use, otherwise 0
- * @stream_map: bitmap of all HW/external queues streams on which the multi-CS
- *              is waiting
  */
 struct multi_cs_completion {
 	struct completion	completion;
 	spinlock_t		lock;
 	s64			timestamp;
+	u32			stream_master_qid_map;
 	u8			used;
-	u8			stream_map;
 };
 
 /**
@@ -2304,9 +2306,9 @@ struct multi_cs_completion {
  * @timestamp: timestamp of first completed CS
  * @wait_status: wait for CS status
  * @completion_bitmap: bitmap of completed CSs (1- completed, otherwise 0)
+ * @stream_master_qid_map: bitmap of all stream master QIDs on which the
+ *                         multi-CS is waiting
  * @arr_len: fence_arr and seq_arr array length
- * @stream_map: bitmap of all HW/external queues streams on which the multi-CS
- *              is waiting
  * @gone_cs: indication of gone CS (1- there was gone CS, otherwise 0)
  * @update_ts: update timestamp. 1- update the timestamp, otherwise 0.
  */
@@ -2318,8 +2320,8 @@ struct multi_cs_data {
 	s64		timestamp;
 	long		wait_status;
 	u32		completion_bitmap;
+	u32		stream_master_qid_map;
 	u8		arr_len;
-	u8		stream_map;
 	u8		gone_cs;
 	u8		update_ts;
 };
@@ -2541,6 +2543,7 @@ struct hl_device {
 
 	struct multi_cs_completion	multi_cs_completion[
 							MULTI_CS_MAX_USER_CTX];
+	u32				*stream_master_qid_arr;
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2592,6 +2595,7 @@ struct hl_device {
 	u8				skip_reset_on_timeout;
 	u8				device_cpu_is_halted;
 	u8				supports_wait_for_multi_cs;
+	u8				stream_master_qid_arr_size;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 6d3beccad91b..76b7de8f1406 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -721,7 +721,8 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 		/* update stream map of the first CS */
 		if (hdev->supports_wait_for_multi_cs)
-			staged_cs->fence->stream_map |= cs->fence->stream_map;
+			staged_cs->fence->stream_master_qid_map |=
+					cs->fence->stream_master_qid_map;
 	}
 
 	list_add_tail(&cs->mirror_node, &hdev->cs_mirror_list);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d18a1ab42897..2f6d019c79e1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -110,6 +110,17 @@
 
 #define MONITOR_SOB_STRING_SIZE		256
 
+static u32 gaudi_stream_master[GAUDI_STREAM_MASTER_ARR_SIZE] = {
+	GAUDI_QUEUE_ID_DMA_0_0,
+	GAUDI_QUEUE_ID_DMA_0_1,
+	GAUDI_QUEUE_ID_DMA_0_2,
+	GAUDI_QUEUE_ID_DMA_0_3,
+	GAUDI_QUEUE_ID_DMA_1_0,
+	GAUDI_QUEUE_ID_DMA_1_1,
+	GAUDI_QUEUE_ID_DMA_1_2,
+	GAUDI_QUEUE_ID_DMA_1_3
+};
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -1871,6 +1882,9 @@ static int gaudi_sw_init(struct hl_device *hdev)
 	hdev->supports_wait_for_multi_cs = true;
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
+	hdev->stream_master_qid_arr =
+				hdev->asic_funcs->get_stream_master_qid_arr();
+	hdev->stream_master_qid_arr_size = GAUDI_STREAM_MASTER_ARR_SIZE;
 
 	return 0;
 
@@ -9353,6 +9367,11 @@ static void gaudi_state_dump_init(struct hl_device *hdev)
 	sds->funcs = gaudi_state_dump_funcs;
 }
 
+static u32 *gaudi_get_stream_master_qid_arr(void)
+{
+	return gaudi_stream_master;
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -9441,7 +9460,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm,
 	.state_dump_init = gaudi_state_dump_init,
 	.get_sob_addr = gaudi_get_sob_addr,
-	.set_pci_memory_regions = gaudi_set_pci_memory_regions
+	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
+	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index eacc5eadda97..2f0928c0fa8f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -36,6 +36,8 @@
 #define NUMBER_OF_INTERRUPTS		(NUMBER_OF_CMPLT_QUEUES + \
 						NUMBER_OF_CPU_HW_QUEUES)
 
+#define GAUDI_STREAM_MASTER_ARR_SIZE	8
+
 #if (NUMBER_OF_INTERRUPTS > GAUDI_MSI_ENTRIES)
 #error "Number of MSI interrupts must be smaller or equal to GAUDI_MSI_ENTRIES"
 #endif
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d54c700c31cd..af3f84d8f710 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5589,6 +5589,11 @@ static u32 goya_get_sob_addr(struct hl_device *hdev, u32 sob_id)
 	return 0;
 }
 
+static u32 *goya_get_stream_master_qid_arr(void)
+{
+	return NULL;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5678,6 +5683,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.state_dump_init = goya_state_dump_init,
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
+	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
 };
 
 /*
-- 
2.17.1

