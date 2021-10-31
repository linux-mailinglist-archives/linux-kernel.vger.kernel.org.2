Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C224440FB9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhJaRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhJaRVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:21:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E93360F4C;
        Sun, 31 Oct 2021 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635700748;
        bh=OI5S8eZAMOyDhRIMfEoyXrGxLDTxYkieAmL3byCiItI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qd63yzLhjwO+r2MVKNeLjBSkpOLQULmGlN7aV6RYpw4KWA3Q9/sehmibQLzG5uB5m
         pahGiVVh6GqRGOD0I9QuJsC5/jE9PhJZuXujd4orhSXZAzBYnAJ4fyW7LBr3ALM7u2
         X9K9aH1IXFOovteCGr1reOn8ApbmUJdxN+lqKyjtgdMScOkYPv8wAsBPanaypyCmPK
         S0iGOQPslrujlwAiW+mBPpWWWKYuRbnmiNZ3bCpvZUnMjlirqsWFNXTxDHiYXzks6f
         GaZtCbHjTtmcK1ZyGVqttGdyUhvE8yi3xNJVhUldJ0pRg2+57oHfThYlh8d8pb9R3d
         D8RtSw1wXhPoQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/4] habanalabs: partly skip cache flush when in PMMU map flow
Date:   Sun, 31 Oct 2021 19:19:00 +0200
Message-Id: <20211031171902.220708-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031171902.220708-1-ogabbay@kernel.org>
References: <20211031171902.220708-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

The PCI MMU cache is two layered. The upper layer, memcache, uses cache
lines, the bottom layer doesn't.

Hence, after PMMU map operation we have to invalidate memcache, to avoid
the situation where the new entry is already in the cache due to its
cache line being fully in the cache.

However, we do not have to invalidate the lower cache, and here we can
optimize, since cache invalidation is time consuming.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c | 3 ++-
 drivers/misc/habanalabs/common/habanalabs.h     | 6 +++++-
 drivers/misc/habanalabs/common/memory.c         | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index fab499d252d4..71910f7809bd 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -80,7 +80,8 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		offset += va_block->size;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false,
+		MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV);
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 202c7f7948f5..aac73c8d2e1d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -356,10 +356,14 @@ enum vm_type {
  * enum mmu_op_flags - mmu operation relevant information.
  * @MMU_OP_USERPTR: operation on user memory (host resident).
  * @MMU_OP_PHYS_PACK: operation on DRAM (device resident).
+ * @MMU_OP_CLEAR_MEMCACHE: operation has to clear memcache.
+ * @MMU_OP_SKIP_LOW_CACHE_INV: operation is allowed to skip parts of cache invalidation.
  */
 enum mmu_op_flags {
 	MMU_OP_USERPTR = 0x1,
-	MMU_OP_PHYS_PACK = 0x2
+	MMU_OP_PHYS_PACK = 0x2,
+	MMU_OP_CLEAR_MEMCACHE = 0x4,
+	MMU_OP_SKIP_LOW_CACHE_INV = 0x8,
 };
 
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 40f2197388fe..cd3640617d02 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1202,7 +1202,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	}
 
 	rc = hdev->asic_funcs->mmu_invalidate_cache_range(hdev, false,
-		*vm_type, ctx->asid, ret_vaddr, phys_pg_pack->total_size);
+		*vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
+		ctx->asid, ret_vaddr, phys_pg_pack->total_size);
 
 	mutex_unlock(&ctx->mmu_lock);
 
-- 
2.25.1

