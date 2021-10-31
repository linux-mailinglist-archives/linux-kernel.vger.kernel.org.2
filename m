Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAADD440FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJaRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhJaRVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:21:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C54B260C40;
        Sun, 31 Oct 2021 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635700747;
        bh=9sYg4aDWb/w8z++cQ57cIVHanMnN9aD4ngZr04yN2Lw=;
        h=From:To:Cc:Subject:Date:From;
        b=pkgFh27eJvn16VaiGT+/BykGdJFAlx9JGV2q82cyTR+AuAeYO/+tUxthWdGdJFHD7
         oB38+TX/E4xTv0lYb4JHrC0JK2SrUZdP4wcZsDfUXuYa9i5ADJx7nbzAaAYJeze1Pt
         00HNILbJa6c4WTkbeR9Z1/3Dx/GdQLsvxBhwQZTpNKiwuhHu81WHwV0UcscM+P0kzw
         P0mc1A/GwLqI3cOzWYGWz8ix8YatJTs+kROGsbNf9+fHY36xIvd/c2iucT0/1AK+QP
         zQ8NBXW7Xk7Il/TcNiegxewYJdPn7NQZrLXcbKBQF/jir6xqwdlAHx/EF2/3Ky2Z9h
         8BainmFO42Nyw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 1/4] habanalabs: add enum mmu_op_flags
Date:   Sun, 31 Oct 2021 19:18:59 +0200
Message-Id: <20211031171902.220708-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

The enum vm_type was abused, used once as a value (indication
memory type for map) and once as a flag (for cache invalidation).
This makes it hard to add new and still keep it meaningful, hence it
is better to split into one enum for values and one for flags.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c |  6 +++---
 drivers/misc/habanalabs/common/habanalabs.h     | 11 +++++++++++
 drivers/misc/habanalabs/common/memory.c         |  4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c           |  4 ++--
 drivers/misc/habanalabs/goya/goya.c             |  2 +-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 41a12bcd26e5..fab499d252d4 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -80,7 +80,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		offset += va_block->size;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, VM_TYPE_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -97,7 +97,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		offset -= va_block->size;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -126,7 +126,7 @@ static void cb_unmap_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 					"Failed to unmap CB's va 0x%llx\n",
 					va_block->start);
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6dd7d9ee7a44..202c7f7948f5 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -352,6 +352,17 @@ enum vm_type {
 	VM_TYPE_PHYS_PACK = 0x2
 };
 
+/**
+ * enum mmu_op_flags - mmu operation relevant information.
+ * @MMU_OP_USERPTR: operation on user memory (host resident).
+ * @MMU_OP_PHYS_PACK: operation on DRAM (device resident).
+ */
+enum mmu_op_flags {
+	MMU_OP_USERPTR = 0x1,
+	MMU_OP_PHYS_PACK = 0x2
+};
+
+
 /**
  * enum hl_device_hw_state - H/W device state. use this to understand whether
  *                           to do reset before hw_init or not
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 1185f9aec989..40f2197388fe 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2639,8 +2639,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	mutex_lock(&ctx->mmu_lock);
 
 	/* invalidate the cache once after the unmapping loop */
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_PHYS_PACK);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_PHYS_PACK);
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 52fffd76f5cf..2e39514ee102 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8688,7 +8688,7 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 			hdev->internal_cb_pool_dma_addr,
 			HOST_SPACE_INTERNAL_CB_SZ);
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, VM_TYPE_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
 	mutex_unlock(&ctx->mmu_lock);
 
 	if (rc)
@@ -8723,7 +8723,7 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 			HOST_SPACE_INTERNAL_CB_SZ);
 	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
 			HOST_SPACE_INTERNAL_CB_SZ);
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 	mutex_unlock(&ctx->mmu_lock);
 
 	gen_pool_destroy(hdev->internal_cb_pool);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 59bb12fcc935..6ee6d5b915a1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2621,7 +2621,7 @@ int goya_mmu_init(struct hl_device *hdev)
 			(~STLB_STLB_FEATURE_EN_FOLLOWER_EN_MASK));
 
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
-					VM_TYPE_USERPTR | VM_TYPE_PHYS_PACK);
+					MMU_OP_USERPTR | MMU_OP_PHYS_PACK);
 
 	WREG32(mmMMU_MMU_ENABLE, 1);
 	WREG32(mmMMU_SPI_MASK, 0xF);
-- 
2.25.1

