Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E563B3F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFYI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhFYI3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:29:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 547306142F;
        Fri, 25 Jun 2021 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624609632;
        bh=Kos9VnFUN507rQDs5MKz7+ZcHB/B2hvN/GIaET9yztc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXQuv8eveyCrQVMp25K/PTGX9Dq+Cgxgk8H7lngi/c2x0pJotNvQsrkN/+6Flpuci
         XRbKOrGVYiKcaOfkRlYXZdf4OBs2+2GucH/9tWJoqBtHKEC5QXwpztB5+WpDdxndfC
         HN4GOb33LCxoxEMBUPa0eyiHj3ym2pcB0Rzoas80qq7CResdnpCSK/MrnrconevZLp
         t+IFwD1+sU1lQpFd0NCayyDdsm0ZjkVGh6paJMuzQNiMo54R1/FPxTyW3T+Kk5B9cw
         gq55U6V8g6qVspJO9RMEpG8A11DENvHtQBynEeuSRYMVKfOXJXL37opcPkiHEblRXR
         3hYqRfMhQWRXQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/2] habanalabs: allow fail on inability to respect hint
Date:   Fri, 25 Jun 2021 11:27:06 +0300
Message-Id: <20210625082706.9884-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625082706.9884-1-ogabbay@kernel.org>
References: <20210625082706.9884-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

A new user flag is required to make memory map hint mandatory, in
contrast to the current situation where it is best effort.
This is due to the requirement to map certain data to specific
pre-determined device virtual address ranges.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 45 +++++++++++++++++++++++--
 include/uapi/misc/habanalabs.h          |  1 +
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index d9429b98313a..d54fdd04be5b 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -564,6 +564,7 @@ static inline bool is_hint_crossing_range(enum hl_va_range_type range_type,
  * @hint_addr: hint for requested address by the user.
  * @va_block_align: required alignment of the virtual block start address.
  * @range_type: va range type (host, dram)
+ * @flags: additional memory flags, currently only uses HL_MEM_FORCE_HINT
  *
  * This function does the following:
  * - Iterate on the virtual block list to find a suitable virtual block for the
@@ -574,7 +575,8 @@ static inline bool is_hint_crossing_range(enum hl_va_range_type range_type,
 static u64 get_va_block(struct hl_device *hdev,
 				struct hl_va_range *va_range,
 				u64 size, u64 hint_addr, u32 va_block_align,
-				enum hl_va_range_type range_type)
+				enum hl_va_range_type range_type,
+				u32 flags)
 {
 	struct hl_vm_va_block *va_block, *new_va_block = NULL;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -584,6 +586,7 @@ static u64 get_va_block(struct hl_device *hdev,
 	bool add_prev = false;
 	bool is_align_pow_2  = is_power_of_2(va_range->page_size);
 	bool is_hint_dram_addr = hl_is_dram_va(hdev, hint_addr);
+	bool force_hint = flags & HL_MEM_FORCE_HINT;
 
 	if (is_align_pow_2)
 		align_mask = ~((u64)va_block_align - 1);
@@ -603,6 +606,15 @@ static u64 get_va_block(struct hl_device *hdev,
 		(!is_align_pow_2 && is_hint_dram_addr &&
 			do_div(tmp_hint_addr, va_range->page_size))) {
 
+		if (force_hint) {
+			/* Hint must be repected, so here we just fail.
+			 */
+			dev_err(hdev->dev,
+				"Hint address 0x%llx is not page aligned - cannot be respected\n",
+				hint_addr);
+			return 0;
+		}
+
 		dev_dbg(hdev->dev,
 			"Hint address 0x%llx will be ignored because it is not aligned\n",
 			hint_addr);
@@ -660,6 +672,17 @@ static u64 get_va_block(struct hl_device *hdev,
 		goto out;
 	}
 
+	if (force_hint && reserved_valid_start != hint_addr) {
+		/* Hint address must be respected. If we are here - this means
+		 * we could not respect it.
+		 */
+		dev_err(hdev->dev,
+			"Hint address 0x%llx could not be respected\n",
+			hint_addr);
+		reserved_valid_start = 0;
+		goto out;
+	}
+
 	/*
 	 * Check if there is some leftover range due to reserving the new
 	 * va block, then return it to the main virtual addresses list.
@@ -712,7 +735,8 @@ u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 		enum hl_va_range_type type, u32 size, u32 alignment)
 {
 	return get_va_block(hdev, ctx->va_range[type], size, 0,
-			max(alignment, ctx->va_range[type]->page_size), type);
+			max(alignment, ctx->va_range[type]->page_size),
+			type, 0);
 }
 
 /**
@@ -1145,9 +1169,24 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto hnode_err;
 	}
 
+	if (hint_addr && phys_pg_pack->offset) {
+		if (args->flags & HL_MEM_FORCE_HINT) {
+			/* If hint must be repected, since we can't - just fail.
+			 */
+			dev_err(hdev->dev,
+				"Hint address 0x%llx cannot be respected because source memory is not aligned 0x%x\n",
+				hint_addr, phys_pg_pack->offset);
+			rc = -EINVAL;
+			goto va_block_err;
+		}
+		dev_dbg(hdev->dev,
+			"Hint address 0x%llx will be ignored because source memory is not aligned 0x%x\n",
+			hint_addr, phys_pg_pack->offset);
+	}
+
 	ret_vaddr = get_va_block(hdev, va_range, phys_pg_pack->total_size,
 					hint_addr, va_block_align,
-					va_range_type);
+					va_range_type, args->flags);
 	if (!ret_vaddr) {
 		dev_err(hdev->dev, "no available va block for handle %u\n",
 				handle);
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a47a731e4527..18765eb75b65 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -813,6 +813,7 @@ union hl_wait_cs_args {
 #define HL_MEM_CONTIGUOUS	0x1
 #define HL_MEM_SHARED		0x2
 #define HL_MEM_USERPTR		0x4
+#define HL_MEM_FORCE_HINT	0x8
 
 struct hl_mem_in {
 	union {
-- 
2.25.1

