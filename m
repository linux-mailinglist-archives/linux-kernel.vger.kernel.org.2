Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832C5358823
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhDHPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhDHPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D996861130;
        Thu,  8 Apr 2021 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895362;
        bh=VYcTbRtGrcDtJWZyp2vGPluiV+ef8MdQ6Dpi+2s/Mhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxTQ+mqjoB1d2P+vDkADDhBAdhQfIm/ETieZkhYcOavm4ZDT1Ok/pC9O9oh+O9ZSU
         2Jt83yH9wZQ+TkmdZ6wQQGxGWG5TrRCd6+aZnN8Sp1tSiwKhxJgQNf0myl2dB3BBDx
         17l2tsyBtCeSilnoZIDuuOMXEwzzUJLsz0ru+DxR1OIqnFyJ7RwjpkJjH9AF6oBeLQ
         /mcOHdjQFAFTj4ca6rj4Ef38uZdlwbYGr/Wss/y3hSzsbJvV1GEIkEkgEysKBlQ5Bx
         b9vUk1wMT2Bvt3TdoXGLOHV5/TCuKEUFa7USmhFZQI2jXFLB/7lzbkBt/ZjTNtRwui
         hd4Op0zb2MyHw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 3/7] habanalabs: move dram scrub to free sequence
Date:   Thu,  8 Apr 2021 18:22:30 +0300
Message-Id: <20210408152234.15383-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408152234.15383-1-ogabbay@kernel.org>
References: <20210408152234.15383-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

DRAM scrubbing can take time hence it adds to latency during allocation.
To minimize latency during initialization, scrubbing is moved to release
call.
In case scrubbing fails it means the device is in a bad state,
hence HARD reset is initiated.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 87 ++++++++++++++-----------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 6530fddbbc21..2938cbbafbbc 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -81,16 +81,6 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 				num_pgs, total_size);
 			return -ENOMEM;
 		}
-
-		if (hdev->memory_scrub) {
-			rc = hdev->asic_funcs->scrub_device_mem(hdev, paddr,
-					total_size);
-			if (rc) {
-				dev_err(hdev->dev,
-					"Failed to scrub contiguous device memory\n");
-				goto pages_pack_err;
-			}
-		}
 	}
 
 	phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
@@ -128,17 +118,6 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 				goto page_err;
 			}
 
-			if (hdev->memory_scrub) {
-				rc = hdev->asic_funcs->scrub_device_mem(hdev,
-						phys_pg_pack->pages[i],
-						page_size);
-				if (rc) {
-					dev_err(hdev->dev,
-						"Failed to scrub device memory\n");
-					goto page_err;
-				}
-			}
-
 			num_curr_pgs++;
 		}
 	}
@@ -280,37 +259,67 @@ static void dram_pg_pool_do_release(struct kref *ref)
  * @phys_pg_pack: physical page pack to free.
  *
  * This function does the following:
- * - For DRAM memory only, iterate over the pack and free each physical block
- *   structure by returning it to the general pool.
+ * - For DRAM memory only
+ *   - iterate over the pack, scrub and free each physical block structure by
+ *     returning it to the general pool.
+ *     In case of error during scrubbing, initiate hard reset.
+ *     Once hard reset is triggered, scrubbing is bypassed while freeing the
+ *     memory continues.
  * - Free the hl_vm_phys_pg_pack structure.
  */
-static void free_phys_pg_pack(struct hl_device *hdev,
+static int free_phys_pg_pack(struct hl_device *hdev,
 				struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_vm *vm = &hdev->vm;
 	u64 i;
+	int rc = 0;
+
+	if (phys_pg_pack->created_from_userptr)
+		goto end;
 
-	if (!phys_pg_pack->created_from_userptr) {
-		if (phys_pg_pack->contiguous) {
-			gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[0],
+	if (phys_pg_pack->contiguous) {
+		if (hdev->memory_scrub && !hdev->disabled) {
+			rc = hdev->asic_funcs->scrub_device_mem(hdev,
+					phys_pg_pack->pages[0],
 					phys_pg_pack->total_size);
+			if (rc)
+				dev_err(hdev->dev,
+					"Failed to scrub contiguous device memory\n");
+		}
 
-			for (i = 0; i < phys_pg_pack->npages ; i++)
-				kref_put(&vm->dram_pg_pool_refcount,
-					dram_pg_pool_do_release);
-		} else {
-			for (i = 0 ; i < phys_pg_pack->npages ; i++) {
-				gen_pool_free(vm->dram_pg_pool,
+		gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[0],
+			phys_pg_pack->total_size);
+
+		for (i = 0; i < phys_pg_pack->npages ; i++)
+			kref_put(&vm->dram_pg_pool_refcount,
+				dram_pg_pool_do_release);
+	} else {
+		for (i = 0 ; i < phys_pg_pack->npages ; i++) {
+			if (hdev->memory_scrub && !hdev->disabled && rc == 0) {
+				rc = hdev->asic_funcs->scrub_device_mem(
+						hdev,
 						phys_pg_pack->pages[i],
 						phys_pg_pack->page_size);
-				kref_put(&vm->dram_pg_pool_refcount,
-					dram_pg_pool_do_release);
+				if (rc)
+					dev_err(hdev->dev,
+						"Failed to scrub device memory\n");
 			}
+			gen_pool_free(vm->dram_pg_pool,
+				phys_pg_pack->pages[i],
+				phys_pg_pack->page_size);
+			kref_put(&vm->dram_pg_pool_refcount,
+				dram_pg_pool_do_release);
 		}
 	}
 
+	if (rc && !hdev->disabled)
+		hl_device_reset(hdev, HL_RESET_HARD);
+
+end:
 	kvfree(phys_pg_pack->pages);
 	kfree(phys_pg_pack);
+
+	return rc;
 }
 
 /**
@@ -349,7 +358,7 @@ static int free_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args)
 		atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
 		atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
 
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		return free_phys_pg_pack(hdev, phys_pg_pack);
 	} else {
 		spin_unlock(&vm->idr_lock);
 		dev_err(hdev->dev,
@@ -1131,9 +1140,9 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	*device_addr = ret_vaddr;
 
 	if (is_userptr)
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		rc = free_phys_pg_pack(hdev, phys_pg_pack);
 
-	return 0;
+	return rc;
 
 map_err:
 	if (add_va_block(hdev, va_range, ret_vaddr,
@@ -1286,7 +1295,7 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	kfree(hnode);
 
 	if (is_userptr) {
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		rc = free_phys_pg_pack(hdev, phys_pg_pack);
 		dma_unmap_host_va(hdev, userptr);
 	}
 
-- 
2.25.1

