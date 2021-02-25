Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C56325365
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBYQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:21:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232137AbhBYQUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:20:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA0E64F1B;
        Thu, 25 Feb 2021 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614269988;
        bh=AIj53695oC0jQiEODYj0pyJ7GW1WPAgZK6SUsd37BMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIIxxksjCU4ulF3no3cs0/QZDXLFe4tIb5GU42bDkXH/lCs4PQgaa9PIFwoIUmTgL
         RtI/J9I/Ta68gubVqX0sMenihtDoON5LnaUiL1PxMy0tUq3qYTJ6hawO89DRBtBfb8
         VfehvMlunfgBD7ZZqej2P9nVdT7C0koDiqS2R88LZRTy6oWi1uiCbyKN2gMdD2/E33
         t7CQ46wiPkmojJ473x1UrDs2c0OVLUpf8J1eKC/HjBhiackN3awOcyYzkAmvdhr0/k
         uTrxhPh/D5C+k7+M/5v0qmuSKYsIg1fkcM5rn7+3oJwAQDV+HNUE8e11dojBkP2isO
         eYctVZ0fRQv/w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/4] habanalabs: replace GFP_ATOMIC with GFP_KERNEL
Date:   Thu, 25 Feb 2021 18:19:39 +0200
Message-Id: <20210225161939.20842-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225161939.20842-1-ogabbay@kernel.org>
References: <20210225161939.20842-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As there are incorrect assumptions in which some of the
initialization and data path flows cannot sleep, most allocations
are being done using GFP_ATOMIC.
We modify the code to use GFP_ATOMIC only when realy needed, as
sleepable flow should use GFP_KERNEL.
In addition add a fallback to allocate memory using GFP_KERNEL,
once ATOMIC allocation fails.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 12 +++++++---
 .../habanalabs/common/command_submission.c    | 22 ++++++++++++++++++-
 drivers/misc/habanalabs/common/device.c       |  2 +-
 drivers/misc/habanalabs/common/memory.c       | 10 +++------
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +-
 drivers/misc/habanalabs/goya/goya.c           |  2 +-
 6 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index d9adb9a5e4d8..719168c980a4 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -181,7 +181,7 @@ static void cb_release(struct kref *ref)
 static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 					int ctx_id, bool internal_cb)
 {
-	struct hl_cb *cb;
+	struct hl_cb *cb = NULL;
 	u32 cb_offset;
 	void *p;
 
@@ -193,9 +193,10 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 	 * the kernel's copy. Hence, we must never sleep in this code section
 	 * and must use GFP_ATOMIC for all memory allocations.
 	 */
-	if (ctx_id == HL_KERNEL_ASID_ID)
+	if (ctx_id == HL_KERNEL_ASID_ID && !hdev->disabled)
 		cb = kzalloc(sizeof(*cb), GFP_ATOMIC);
-	else
+
+	if (!cb)
 		cb = kzalloc(sizeof(*cb), GFP_KERNEL);
 
 	if (!cb)
@@ -214,6 +215,9 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 	} else if (ctx_id == HL_KERNEL_ASID_ID) {
 		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
 						&cb->bus_address, GFP_ATOMIC);
+		if (!p)
+			p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
+					cb_size, &cb->bus_address, GFP_KERNEL);
 	} else {
 		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
 						&cb->bus_address,
@@ -310,6 +314,8 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 
 	spin_lock(&mgr->cb_lock);
 	rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
+	if (rc < 0)
+		rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_KERNEL);
 	spin_unlock(&mgr->cb_lock);
 
 	if (rc < 0) {
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 98fdb98ff4e4..7d0d3e61a6e7 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -638,6 +638,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cntr = &hdev->aggregated_cs_counters;
 
 	cs = kzalloc(sizeof(*cs), GFP_ATOMIC);
+	if (!cs)
+		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+
 	if (!cs) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
@@ -657,6 +660,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	spin_lock_init(&cs->job_lock);
 
 	cs_cmpl = kmalloc(sizeof(*cs_cmpl), GFP_ATOMIC);
+	if (!cs_cmpl)
+		cs_cmpl = kmalloc(sizeof(*cs_cmpl), GFP_KERNEL);
+
 	if (!cs_cmpl) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
@@ -698,6 +704,10 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
 			sizeof(*cs->jobs_in_queue_cnt), GFP_ATOMIC);
+	if (!cs->jobs_in_queue_cnt)
+		cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
+				sizeof(*cs->jobs_in_queue_cnt), GFP_KERNEL);
+
 	if (!cs->jobs_in_queue_cnt) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&cntr->out_of_mem_drop_cnt);
@@ -927,6 +937,9 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 	struct hl_cs_job *job;
 
 	job = kzalloc(sizeof(*job), GFP_ATOMIC);
+	if (!job)
+		job = kzalloc(sizeof(*job), GFP_KERNEL);
+
 	if (!job)
 		return NULL;
 
@@ -1029,6 +1042,9 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 
 	*cs_chunk_array = kmalloc_array(num_chunks, sizeof(**cs_chunk_array),
 					GFP_ATOMIC);
+	if (!*cs_chunk_array)
+		*cs_chunk_array = kmalloc_array(num_chunks,
+					sizeof(**cs_chunk_array), GFP_KERNEL);
 	if (!*cs_chunk_array) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&hdev->aggregated_cs_counters.out_of_mem_drop_cnt);
@@ -1483,6 +1499,10 @@ static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 	signal_seq_arr = kmalloc_array(signal_seq_arr_len,
 					sizeof(*signal_seq_arr),
 					GFP_ATOMIC);
+	if (!signal_seq_arr)
+		signal_seq_arr = kmalloc_array(signal_seq_arr_len,
+					sizeof(*signal_seq_arr),
+					GFP_KERNEL);
 	if (!signal_seq_arr) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 		atomic64_inc(&hdev->aggregated_cs_counters.out_of_mem_drop_cnt);
@@ -1931,7 +1951,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	hl_ctx_get(hdev, ctx);
 
-	pend = kmalloc(sizeof(*pend), GFP_ATOMIC);
+	pend = kmalloc(sizeof(*pend), GFP_KERNEL);
 	if (!pend) {
 		hl_ctx_put(ctx);
 		return -ENOMEM;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b4321144379c..2cbe9d04c229 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -327,7 +327,7 @@ static int device_early_init(struct hl_device *hdev)
 	if (hdev->asic_prop.completion_queues_count) {
 		hdev->cq_wq = kcalloc(hdev->asic_prop.completion_queues_count,
 				sizeof(*hdev->cq_wq),
-				GFP_ATOMIC);
+				GFP_KERNEL);
 		if (!hdev->cq_wq) {
 			rc = -ENOMEM;
 			goto asid_fini;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index c2679896aa50..1b69573369cf 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -145,7 +145,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	spin_lock(&vm->idr_lock);
 	handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
-				GFP_ATOMIC);
+				GFP_KERNEL);
 	spin_unlock(&vm->idr_lock);
 
 	if (handle < 0) {
@@ -1596,7 +1596,7 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	rc = sg_alloc_table_from_pages(userptr->sgt,
 				       userptr->pages,
-				       npages, offset, size, GFP_ATOMIC);
+				       npages, offset, size, GFP_KERNEL);
 	if (rc < 0) {
 		dev_err(hdev->dev, "failed to create SG table from pages\n");
 		goto put_pages;
@@ -1646,11 +1646,7 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 		return -EINVAL;
 	}
 
-	/*
-	 * This function can be called also from data path, hence use atomic
-	 * always as it is not a big allocation.
-	 */
-	userptr->sgt = kzalloc(sizeof(*userptr->sgt), GFP_ATOMIC);
+	userptr->sgt = kzalloc(sizeof(*userptr->sgt), GFP_KERNEL);
 	if (!userptr->sgt)
 		return -ENOMEM;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4f39737b4808..eee9387c8a26 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4873,7 +4873,7 @@ static int gaudi_pin_memory_before_cs(struct hl_device *hdev,
 			parser->job_userptr_list, &userptr))
 		goto already_pinned;
 
-	userptr = kzalloc(sizeof(*userptr), GFP_ATOMIC);
+	userptr = kzalloc(sizeof(*userptr), GFP_KERNEL);
 	if (!userptr)
 		return -ENOMEM;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 20abed6ef7e6..1eaf9c06227c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3221,7 +3221,7 @@ static int goya_pin_memory_before_cs(struct hl_device *hdev,
 			parser->job_userptr_list, &userptr))
 		goto already_pinned;
 
-	userptr = kzalloc(sizeof(*userptr), GFP_ATOMIC);
+	userptr = kzalloc(sizeof(*userptr), GFP_KERNEL);
 	if (!userptr)
 		return -ENOMEM;
 
-- 
2.25.1

