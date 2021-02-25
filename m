Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD4325361
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhBYQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhBYQUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:20:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17B5664ED3;
        Thu, 25 Feb 2021 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614269984;
        bh=8pUy9btHp98WJPos6UZOl296CQG5BhWSBIjY2gbD/+M=;
        h=From:To:Cc:Subject:Date:From;
        b=EVEkSdMz5WVDcrCAJmUmlfiHkObCdg/4MOcJ1m2BKub9cOuX8nwSpxn+8bq+mUFqb
         R2Nowq1OTPT2lj9vrWC/ep1FlmgtL5dyiMV+xOCD+7ZKGbLc+QLxQCtjEzHUwGOi8R
         E63yVi/7GayfXGw9z/j1js7GQHDAOuMLEbgNVFOuBReaxVaPKKYPHQQURFfXovowPd
         4XlGxEbh/PfCA34oaF2zKA2DfyOOb037YamD1fxuUlEywL+BORbZLuJNz/oSe8PWGe
         rB1I9cH7pyaQRrGLmuf2zo03NoUZYPIDSbBZs5XEga+pUzONN4qoftw2gUpnHNlA7J
         /4xshCTvWLYNg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sagiv Ozeri <sozeri@habana.ai>
Subject: [PATCH 1/4] habanalabs: support HW blocks vm show
Date:   Thu, 25 Feb 2021 18:19:36 +0200
Message-Id: <20210225161939.20842-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagiv Ozeri <sozeri@habana.ai>

Improve "vm" debugfs node to print also the virtual addresses which are
currently mapped to HW blocks in the device.

Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  2 +-
 drivers/misc/habanalabs/common/context.c      | 14 +++-
 drivers/misc/habanalabs/common/debugfs.c      | 16 +++++
 drivers/misc/habanalabs/common/habanalabs.h   | 24 +++++++
 drivers/misc/habanalabs/common/memory.c       | 65 +++++++++++++++++--
 5 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index d447a611c41b..f9e233cbdc37 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -174,7 +174,7 @@ Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
 Description:    Displays a list with information about all the active virtual
-                address mappings per ASID
+                address mappings per ASID and all user mappings of HW blocks
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
 Date:           Mar 2020
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index cda871afb8f4..62d705889ca8 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -20,6 +20,11 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 	 */
 	hl_pending_cb_list_flush(ctx);
 
+	/* Release all allocated HW block mapped list entries and destroy
+	 * the mutex.
+	 */
+	hl_hw_block_mem_fini(ctx);
+
 	/*
 	 * If we arrived here, there are no jobs waiting for this context
 	 * on its queues so we can safely remove it.
@@ -160,13 +165,15 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	if (!ctx->cs_pending)
 		return -ENOMEM;
 
+	hl_hw_block_mem_init(ctx);
+
 	if (is_kernel_ctx) {
 		ctx->asid = HL_KERNEL_ASID_ID; /* Kernel driver gets ASID 0 */
 		rc = hl_vm_ctx_init(ctx);
 		if (rc) {
 			dev_err(hdev->dev, "Failed to init mem ctx module\n");
 			rc = -ENOMEM;
-			goto err_free_cs_pending;
+			goto err_hw_block_mem_fini;
 		}
 
 		rc = hdev->asic_funcs->ctx_init(ctx);
@@ -179,7 +186,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 		if (!ctx->asid) {
 			dev_err(hdev->dev, "No free ASID, failed to create context\n");
 			rc = -ENOMEM;
-			goto err_free_cs_pending;
+			goto err_hw_block_mem_fini;
 		}
 
 		rc = hl_vm_ctx_init(ctx);
@@ -214,7 +221,8 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 err_asid_free:
 	if (ctx->asid != HL_KERNEL_ASID_ID)
 		hl_asid_free(hdev, ctx->asid);
-err_free_cs_pending:
+err_hw_block_mem_fini:
+	hl_hw_block_mem_fini(ctx);
 	kfree(ctx->cs_pending);
 
 	return rc;
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index df847a6d19f4..d4a49d6d1753 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -229,6 +229,7 @@ static int vm_show(struct seq_file *s, void *data)
 {
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_vm_hw_block_list_node *lnode;
 	struct hl_ctx *ctx;
 	struct hl_vm *vm;
 	struct hl_vm_hash_node *hnode;
@@ -272,6 +273,21 @@ static int vm_show(struct seq_file *s, void *data)
 		}
 		mutex_unlock(&ctx->mem_hash_lock);
 
+		if (ctx->asid != HL_KERNEL_ASID_ID &&
+		    !list_empty(&ctx->hw_block_mem_list)) {
+			seq_puts(s, "\nhw_block mappings:\n\n");
+			seq_puts(s, "    virtual address    size    HW block id\n");
+			seq_puts(s, "-------------------------------------------\n");
+			mutex_lock(&ctx->hw_block_list_lock);
+			list_for_each_entry(lnode, &ctx->hw_block_mem_list,
+					    node) {
+				seq_printf(s,
+					"    0x%-14lx   %-6u      %-9u\n",
+					lnode->vaddr, lnode->size, lnode->id);
+			}
+			mutex_unlock(&ctx->hw_block_list_lock);
+		}
+
 		vm = &ctx->hdev->vm;
 		spin_lock(&vm->idr_lock);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 56c5fb16b409..9129582e9339 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1103,9 +1103,11 @@ struct hl_pending_cb {
  * @mem_hash_lock: protects the mem_hash.
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
  *            MMU hash or walking the PGT requires talking this lock.
+ * @hw_block_list_lock: protects the HW block memory list.
  * @debugfs_list: node in debugfs list of contexts.
  * pending_cb_list: list of pending command buffers waiting to be sent upon
  *                  next user command submission context.
+ * @hw_block_mem_list: list of HW block virtual mapped addresses.
  * @cs_counters: context command submission counters.
  * @cb_va_pool: device VA pool for command buffers which are mapped to the
  *              device's MMU.
@@ -1142,8 +1144,10 @@ struct hl_ctx {
 	struct hl_va_range		*va_range[HL_VA_RANGE_TYPE_MAX];
 	struct mutex			mem_hash_lock;
 	struct mutex			mmu_lock;
+	struct mutex			hw_block_list_lock;
 	struct list_head		debugfs_list;
 	struct list_head		pending_cb_list;
+	struct list_head		hw_block_mem_list;
 	struct hl_cs_counters_atomic	cs_counters;
 	struct gen_pool			*cb_va_pool;
 	u64				cs_sequence;
@@ -1362,6 +1366,23 @@ struct hl_vm_hash_node {
 	void			*ptr;
 };
 
+/**
+ * struct hl_vm_hw_block_list_node - list element from user virtual address to
+ *				HW block id.
+ * @node: node to hang on the list in context object.
+ * @ctx: the context this node belongs to.
+ * @vaddr: virtual address of the HW block.
+ * @size: size of the block.
+ * @id: HW block id (handle).
+ */
+struct hl_vm_hw_block_list_node {
+	struct list_head	node;
+	struct hl_ctx		*ctx;
+	unsigned long		vaddr;
+	u32			size;
+	u32			id;
+};
+
 /**
  * struct hl_vm_phys_pg_pack - physical page pack.
  * @vm_type: describes the type of the virtual area descriptor.
@@ -2280,6 +2301,9 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx);
 int hl_vm_init(struct hl_device *hdev);
 void hl_vm_fini(struct hl_device *hdev);
 
+void hl_hw_block_mem_init(struct hl_ctx *ctx);
+void hl_hw_block_mem_fini(struct hl_ctx *ctx);
+
 u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 		enum hl_va_range_type type, u32 size, u32 alignment);
 int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 1f5910517b0e..c2679896aa50 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1305,9 +1305,15 @@ static int map_block(struct hl_device *hdev, u64 address, u64 *handle,
 
 static void hw_block_vm_close(struct vm_area_struct *vma)
 {
-	struct hl_ctx *ctx = (struct hl_ctx *) vma->vm_private_data;
+	struct hl_vm_hw_block_list_node *lnode =
+		(struct hl_vm_hw_block_list_node *) vma->vm_private_data;
+	struct hl_ctx *ctx = lnode->ctx;
 
+	mutex_lock(&ctx->hw_block_list_lock);
+	list_del(&lnode->node);
+	mutex_unlock(&ctx->hw_block_list_lock);
 	hl_ctx_put(ctx);
+	kfree(lnode);
 	vma->vm_private_data = NULL;
 }
 
@@ -1325,7 +1331,9 @@ static const struct vm_operations_struct hw_block_vm_ops = {
  */
 int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 {
+	struct hl_vm_hw_block_list_node *lnode;
 	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ctx *ctx = hpriv->ctx;
 	u32 block_id, block_size;
 	int rc;
 
@@ -1351,17 +1359,31 @@ int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
+	lnode = kzalloc(sizeof(*lnode), GFP_KERNEL);
+	if (!lnode)
+		return -ENOMEM;
+
 	vma->vm_ops = &hw_block_vm_ops;
-	vma->vm_private_data = hpriv->ctx;
+	vma->vm_private_data = lnode;
 
-	hl_ctx_get(hdev, hpriv->ctx);
+	hl_ctx_get(hdev, ctx);
 
 	rc = hdev->asic_funcs->hw_block_mmap(hdev, vma, block_id, block_size);
 	if (rc) {
-		hl_ctx_put(hpriv->ctx);
+		hl_ctx_put(ctx);
+		kfree(lnode);
 		return rc;
 	}
 
+	lnode->ctx = ctx;
+	lnode->vaddr = vma->vm_start;
+	lnode->size = block_size;
+	lnode->id = block_id;
+
+	mutex_lock(&ctx->hw_block_list_lock);
+	list_add_tail(&lnode->node, &ctx->hw_block_mem_list);
+	mutex_unlock(&ctx->hw_block_list_lock);
+
 	vma->vm_pgoff = block_id;
 
 	return 0;
@@ -2122,3 +2144,38 @@ void hl_vm_fini(struct hl_device *hdev)
 
 	vm->init_done = false;
 }
+
+/**
+ * hl_hw_block_mem_init() - HW block memory initialization.
+ * @ctx: pointer to the habanalabs context structure.
+ *
+ * This function initializes the HW block virtual mapped addresses list and
+ * it's lock.
+ */
+void hl_hw_block_mem_init(struct hl_ctx *ctx)
+{
+	mutex_init(&ctx->hw_block_list_lock);
+	INIT_LIST_HEAD(&ctx->hw_block_mem_list);
+}
+
+/**
+ * hl_hw_block_mem_fini() - HW block memory teardown.
+ * @ctx: pointer to the habanalabs context structure.
+ *
+ * This function clears the HW block virtual mapped addresses list and destroys
+ * it's lock.
+ */
+void hl_hw_block_mem_fini(struct hl_ctx *ctx)
+{
+	struct hl_vm_hw_block_list_node *lnode, *tmp;
+
+	if (!list_empty(&ctx->hw_block_mem_list))
+		dev_crit(ctx->hdev->dev, "HW block mem list isn't empty\n");
+
+	list_for_each_entry_safe(lnode, tmp, &ctx->hw_block_mem_list, node) {
+		list_del(&lnode->node);
+		kfree(lnode);
+	}
+
+	mutex_destroy(&ctx->hw_block_list_lock);
+}
-- 
2.25.1

