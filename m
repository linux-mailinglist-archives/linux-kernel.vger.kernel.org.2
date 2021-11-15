Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60F450324
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhKOLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237742AbhKOLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:08:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D29863219;
        Mon, 15 Nov 2021 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636974334;
        bh=kTepk4WeHlccmJsXfRh07L/NNqnItYmqPpLHfv584zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qg8M+JGhzlI5erXPv0RAwHh/p9uj4o3VuhlAIUsvnsn8iSTiB/VlTXvJIrjneCVr+
         ijOGtpu4SzYQGMKAhQqBd5ggzs6zwOkHXcPFhM5WDq2VXVDuhRyIr+FZwxmaMrhXed
         jMG9sULxEvZdHbWJuapYQ24+0I+j8w+EvCMBN03EndINHLHooP6qQs7Sw4oDw6kyy8
         4FMy6IOdCZnj4RgRuuF331p2uN7a7Y0UxBSqC7reEKakbq+XJIBZpiHy2p3HzAvoLT
         oxbw/qhHrH3IGPQJtHnWSlF+uSawUJZW/EYPQXNcVa8CTSbtRjeUbOB86VoFzlS7EH
         UmywAO09AQPCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 7/7] habanalabs: fix possible deadlock in cache invl failure
Date:   Mon, 15 Nov 2021 13:05:21 +0200
Message-Id: <20211115110521.783103-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115110521.783103-1-ogabbay@kernel.org>
References: <20211115110521.783103-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently there is a deadlock in driver in scenarios where MMU
cache invalidation fails. The issue is basically device reset
being performed without releasing the MMU mutex.
The solution is to skip device reset as it is not necessary.
In addition we introduce a slight code refactor that prints the
invalidation error from a single location.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  9 +++----
 drivers/misc/habanalabs/common/habanalabs.h   |  3 +++
 drivers/misc/habanalabs/common/memory.c       | 25 ++++++-------------
 drivers/misc/habanalabs/common/mmu/mmu.c      | 25 +++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  6 -----
 drivers/misc/habanalabs/goya/goya.c           |  6 -----
 6 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 71910f7809bd..c591f0487272 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -80,14 +80,13 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		offset += va_block->size;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false,
-		MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV);
+	rc = hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV);
 
 	mutex_unlock(&ctx->mmu_lock);
 
 	cb->is_mmu_mapped = true;
 
-	return 0;
+	return rc;
 
 err_va_umap:
 	list_for_each_entry(va_block, &cb->va_block_list, node) {
@@ -98,7 +97,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		offset -= va_block->size;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
+	rc = hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -127,7 +126,7 @@ static void cb_unmap_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 					"Failed to unmap CB's va 0x%llx\n",
 					va_block->start);
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
+	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 612a9f461b38..406ca50f192a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2993,6 +2993,9 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 int hl_mmu_map_contiguous(struct hl_ctx *ctx, u64 virt_addr,
 					u64 phys_addr, u32 size);
 int hl_mmu_unmap_contiguous(struct hl_ctx *ctx, u64 virt_addr, u32 size);
+int hl_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags);
+int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
+					u32 flags, u32 asid, u64 va, u64 size);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 int hl_mmu_if_set_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 530f8b4fadd2..315594e96dcd 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1201,18 +1201,13 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto map_err;
 	}
 
-	rc = hdev->asic_funcs->mmu_invalidate_cache_range(hdev, false,
-		*vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
-		ctx->asid, ret_vaddr, phys_pg_pack->total_size);
+	rc = hl_mmu_invalidate_cache_range(hdev, false, *vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
+				ctx->asid, ret_vaddr, phys_pg_pack->total_size);
 
 	mutex_unlock(&ctx->mmu_lock);
 
-	if (rc) {
-		dev_err(hdev->dev,
-			"mapping handle %u failed due to MMU cache invalidation\n",
-			handle);
+	if (rc)
 		goto map_err;
-	}
 
 	ret_vaddr += phys_pg_pack->offset;
 
@@ -1350,9 +1345,8 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	 * at the loop end rather than for each iteration
 	 */
 	if (!ctx_free)
-		rc = hdev->asic_funcs->mmu_invalidate_cache_range(hdev, true,
-				*vm_type, ctx->asid, vaddr,
-				phys_pg_pack->total_size);
+		rc = hl_mmu_invalidate_cache_range(hdev, true, *vm_type, ctx->asid, vaddr,
+							phys_pg_pack->total_size);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -1365,11 +1359,6 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	if (!ctx_free) {
 		int tmp_rc;
 
-		if (rc)
-			dev_err(hdev->dev,
-				"unmapping vaddr 0x%llx failed due to MMU cache invalidation\n",
-				vaddr);
-
 		tmp_rc = add_va_block(hdev, va_range, vaddr,
 					vaddr + phys_pg_pack->total_size - 1);
 		if (tmp_rc) {
@@ -2640,8 +2629,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	mutex_lock(&ctx->mmu_lock);
 
 	/* invalidate the cache once after the unmapping loop */
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_PHYS_PACK);
+	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
+	hl_mmu_invalidate_cache(hdev, true, MMU_OP_PHYS_PACK);
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index aa96917f62e5..9153a1f55175 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -637,3 +637,28 @@ u64 hl_mmu_descramble_addr(struct hl_device *hdev, u64 addr)
 {
 	return addr;
 }
+
+int hl_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags)
+{
+	int rc;
+
+	rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, is_hard, flags);
+	if (rc)
+		dev_err_ratelimited(hdev->dev, "MMU cache invalidation failed\n");
+
+	return rc;
+}
+
+int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
+					u32 flags, u32 asid, u64 va, u64 size)
+{
+	int rc;
+
+	rc = hdev->asic_funcs->mmu_invalidate_cache_range(hdev, is_hard, flags,
+								asid, va, size);
+	if (rc)
+		dev_err_ratelimited(hdev->dev, "MMU cache range invalidation failed\n");
+
+	return rc;
+}
+
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 465540d064b6..b101a46076b8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8366,12 +8366,6 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 
 	WREG32(mmSTLB_INV_SET, 0);
 
-	if (rc) {
-		dev_err_ratelimited(hdev->dev,
-					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, HL_DRV_RESET_HARD);
-	}
-
 	return rc;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 2347de2f426a..5e6998d21adb 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5258,12 +5258,6 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 		1000,
 		timeout_usec);
 
-	if (rc) {
-		dev_err_ratelimited(hdev->dev,
-					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, HL_DRV_RESET_HARD);
-	}
-
 	return rc;
 }
 
-- 
2.25.1

