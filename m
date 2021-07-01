Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6E3B9120
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhGAL3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236222AbhGAL3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D14346145C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138843;
        bh=HabeZmIE4m0ATKcbQ+Lg7jP+knp8ne3/jn1XMoIiToM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CTl2UsG863Qx5Oy6WrMPo8qeaTaOcp2ZKk6+BYcAe1GpJp+/c5RwETK19QFTLbhxu
         Cq4OESU9RyijhitPPN7KFnwZ+zakjL5vXVJgVoia1E4U4cy1ToGvK+JeqfO0UObAut
         BK9LaT1/CJ1GdbVqhWlsPWzEgwT7ti6GN/A56X//iIiiZkntTOz0uM2l83pj0xJfO4
         YdCRCxmR1TUXH7QwIygdKKgViW5QKhRUyZixGXoaayTp+ne+nCF3lo6ZoAQ5w6yR/n
         9iGCseEVzxto1+5lRqNaKbwHEh+i58KxFcEUgR5i2iPeSwVPfUuzv8IkqtC6gwg6wQ
         sIPzm8n+xNHEA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] habanalabs: rename enum vm_type_t to vm_type
Date:   Thu,  1 Jul 2021 14:27:12 +0300
Message-Id: <20210701112717.9540-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701112717.9540-1-ogabbay@kernel.org>
References: <20210701112717.9540-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use typedefs so the enum name shouldn't end with _t

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    |  4 ++--
 drivers/misc/habanalabs/common/habanalabs.h |  8 ++++----
 drivers/misc/habanalabs/common/memory.c     | 14 ++++++--------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 703d79fb6f3f..fd44c3b66d3b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -235,7 +235,7 @@ static int vm_show(struct seq_file *s, void *data)
 	struct hl_vm_hash_node *hnode;
 	struct hl_userptr *userptr;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
-	enum vm_type_t *vm_type;
+	enum vm_type *vm_type;
 	bool once = true;
 	u64 j;
 	int i;
@@ -492,7 +492,7 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 	struct hl_ctx *ctx = hdev->compute_ctx;
 	struct hl_vm_hash_node *hnode;
 	struct hl_userptr *userptr;
-	enum vm_type_t *vm_type;
+	enum vm_type *vm_type;
 	bool valid = false;
 	u64 end_address;
 	u32 range_size;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0edc72e678c9..31fda9e41fe7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -317,11 +317,11 @@ struct hw_queue_properties {
 };
 
 /**
- * enum vm_type_t - virtual memory mapping request information.
+ * enum vm_type - virtual memory mapping request information.
  * @VM_TYPE_USERPTR: mapping of user memory to device virtual address.
  * @VM_TYPE_PHYS_PACK: mapping of DRAM memory to device virtual address.
  */
-enum vm_type_t {
+enum vm_type {
 	VM_TYPE_USERPTR = 0x1,
 	VM_TYPE_PHYS_PACK = 0x2
 };
@@ -1421,7 +1421,7 @@ struct hl_ctx_mgr {
  * @dma_mapped: true if the SG was mapped to DMA addresses, false otherwise.
  */
 struct hl_userptr {
-	enum vm_type_t		vm_type; /* must be first */
+	enum vm_type		vm_type; /* must be first */
 	struct list_head	job_node;
 	struct page		**pages;
 	unsigned int		npages;
@@ -1635,7 +1635,7 @@ struct hl_vm_hw_block_list_node {
  * @created_from_userptr: is product of host virtual address.
  */
 struct hl_vm_phys_pg_pack {
-	enum vm_type_t		vm_type; /* must be first */
+	enum vm_type		vm_type; /* must be first */
 	u64			*pages;
 	u64			npages;
 	u64			total_size;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index d54fdd04be5b..57e980d1a84b 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -607,8 +607,7 @@ static u64 get_va_block(struct hl_device *hdev,
 			do_div(tmp_hint_addr, va_range->page_size))) {
 
 		if (force_hint) {
-			/* Hint must be repected, so here we just fail.
-			 */
+			/* Hint must be respected, so here we just fail */
 			dev_err(hdev->dev,
 				"Hint address 0x%llx is not page aligned - cannot be respected\n",
 				hint_addr);
@@ -1067,7 +1066,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	struct hl_userptr *userptr = NULL;
 	struct hl_vm_hash_node *hnode;
 	struct hl_va_range *va_range;
-	enum vm_type_t *vm_type;
+	enum vm_type *vm_type;
 	u64 ret_vaddr, hint_addr;
 	u32 handle = 0, va_block_align;
 	int rc;
@@ -1098,7 +1097,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 			goto init_page_pack_err;
 		}
 
-		vm_type = (enum vm_type_t *) userptr;
+		vm_type = (enum vm_type *) userptr;
 		hint_addr = args->map_host.hint_addr;
 		handle = phys_pg_pack->handle;
 
@@ -1140,7 +1139,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 		spin_unlock(&vm->idr_lock);
 
-		vm_type = (enum vm_type_t *) phys_pg_pack;
+		vm_type = (enum vm_type *) phys_pg_pack;
 
 		hint_addr = args->map_device.hint_addr;
 
@@ -1171,8 +1170,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	if (hint_addr && phys_pg_pack->offset) {
 		if (args->flags & HL_MEM_FORCE_HINT) {
-			/* If hint must be repected, since we can't - just fail.
-			 */
+			/* Fail if hint must be respected but it can't be */
 			dev_err(hdev->dev,
 				"Hint address 0x%llx cannot be respected because source memory is not aligned 0x%x\n",
 				hint_addr, phys_pg_pack->offset);
@@ -1273,7 +1271,7 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	struct hl_userptr *userptr = NULL;
 	struct hl_va_range *va_range;
 	u64 vaddr = args->unmap.device_virt_addr;
-	enum vm_type_t *vm_type;
+	enum vm_type *vm_type;
 	bool is_userptr;
 	int rc = 0;
 
-- 
2.25.1

