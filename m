Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9643966F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhJYMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233174AbhJYMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7449660F22;
        Mon, 25 Oct 2021 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635165405;
        bh=Xb2pNGStuLoZpzx82QxYW/hg6RhG1kLQY8wP9T1CFB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjGU9ryqYzBlxUNMSap+wA9CEFW5aeOzdJPzNCCPOjEI+fc5oPHtfLwT9LrXDHqMO
         5omQQFuSK2rdpTL2IEjkTPlmIY8CEq1CKkw0Up8WJ7wAMIVOxtq9scH+ocpNWNIKDo
         04kvaOTCBWKDfGCcbJlhq0zAE/mvy+EucswcMnKeoyKphyIQUC2Z8Zqhn/lQJ0dQty
         BYCjTt5Y3ymvAKasKlLLL1SsQYq0+O1Edp5d501vKNwfaumH6s7RlUHTB8h0W5kSsC
         tE1x1SbA8bS18Ec2E9zq53z4rpx6Cyfv7m/CP0yjxS/o/oa3Uk08N+GSUtG72+tB9h
         SJRA2ajK5jUtw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 4/4] habanalabs: wrong VA size calculation
Date:   Mon, 25 Oct 2021 15:36:36 +0300
Message-Id: <20211025123636.2842618-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025123636.2842618-1-ogabbay@kernel.org>
References: <20211025123636.2842618-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

VA blocks are currently stored in an inconsistent way. Sometimes block
end is inclusive, sometimes exclusive. This leads to wrong size
calculations in certain cases, plus could lead to a segmentation fault
in case mapping process fails in the middle and we try to roll it back.
Need to make this consistent - start inclusive till end inclusive.

For example, the regions table may now look like this:
    0x0000 - 0x1fff : allocated
    0x2000 - 0x2fff : free
    0x3000 - 0x3fff : allocated

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   | 16 ++------------
 drivers/misc/habanalabs/common/memory.c       | 22 ++++++++++++-------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 8132a84698d5..41a12bcd26e5 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -57,7 +57,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		}
 
 		va_block->start = virt_addr;
-		va_block->end = virt_addr + page_size;
+		va_block->end = virt_addr + page_size - 1;
 		va_block->size = page_size;
 		list_add_tail(&va_block->node, &cb->va_block_list);
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a2002cbf794b..4f3c228c9b9d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2757,21 +2757,9 @@ static inline bool hl_mem_area_inside_range(u64 address, u64 size,
 static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 				u64 range_start_address, u64 range_end_address)
 {
-	u64 end_address = address + size;
+	u64 end_address = address + size - 1;
 
-	if ((address >= range_start_address) &&
-			(address < range_end_address))
-		return true;
-
-	if ((end_address >= range_start_address) &&
-			(end_address < range_end_address))
-		return true;
-
-	if ((address < range_start_address) &&
-			(end_address >= range_end_address))
-		return true;
-
-	return false;
+	return ((address <= range_end_address) && (range_start_address <= end_address));
 }
 
 int hl_device_open(struct inode *inode, struct file *filp);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 504973330e2e..97434149f5f8 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -475,7 +475,7 @@ static int add_va_block_locked(struct hl_device *hdev,
 		struct list_head *va_list, u64 start, u64 end)
 {
 	struct hl_vm_va_block *va_block, *res = NULL;
-	u64 size = end - start;
+	u64 size = end - start + 1;
 
 	print_va_list_locked(hdev, va_list);
 
@@ -642,7 +642,7 @@ static u64 get_va_block(struct hl_device *hdev,
 				continue;
 		}
 
-		valid_size = va_block->end - valid_start;
+		valid_size = va_block->end - valid_start + 1;
 		if (valid_size < size)
 			continue;
 
@@ -705,7 +705,7 @@ static u64 get_va_block(struct hl_device *hdev,
 
 	if (new_va_block->size > size) {
 		new_va_block->start += size;
-		new_va_block->size = new_va_block->end - new_va_block->start;
+		new_va_block->size = new_va_block->end - new_va_block->start + 1;
 	} else {
 		list_del(&new_va_block->node);
 		kfree(new_va_block);
@@ -2386,8 +2386,14 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
 			start += PAGE_SIZE;
 		}
 
-		if (end & (PAGE_SIZE - 1))
-			end &= PAGE_MASK;
+		/*
+		 * The end of the range is inclusive, hence we need to align it
+		 * to the end of the last full page in the range. For example if
+		 * end = 0x3ff5 with page size 0x1000, we need to align it to
+		 * 0x2fff. The remainig 0xff5 bytes do not form a full page.
+		 */
+		if ((end + 1) & (PAGE_SIZE - 1))
+			end = ((end + 1) & PAGE_MASK) - 1;
 	}
 
 	if (start >= end) {
@@ -2562,14 +2568,14 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 		return 0;
 
 	dram_range_start = prop->dmmu.start_addr;
-	dram_range_end = prop->dmmu.end_addr;
+	dram_range_end = prop->dmmu.end_addr - 1;
 	dram_page_size = prop->dram_page_size ?
 				prop->dram_page_size : prop->dmmu.page_size;
 	host_range_start = prop->pmmu.start_addr;
-	host_range_end = prop->pmmu.end_addr;
+	host_range_end = prop->pmmu.end_addr - 1;
 	host_page_size = prop->pmmu.page_size;
 	host_huge_range_start = prop->pmmu_huge.start_addr;
-	host_huge_range_end = prop->pmmu_huge.end_addr;
+	host_huge_range_end = prop->pmmu_huge.end_addr - 1;
 	host_huge_page_size = prop->pmmu_huge.page_size;
 
 	return vm_ctx_init_with_ranges(ctx, host_range_start, host_range_end,
-- 
2.25.1

