Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E915B3B9125
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhGALaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236271AbhGAL37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FD696145C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138848;
        bh=zGAcznME8Ix79lmkJpD0q9TIDe6890+y2ZCmyH2Zc64=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qveK6dOIVQ3yxlw5rpu83LAoMSZ7Pi9QviGdzxFWhu4+pRyq4h1erE4/OCiTDjyWF
         4PBg9bCzrtDamb0It76MHuTQl32CVWmR0fAapfAX8fjZGPgQ3RmxLndFKBe7NHHc2d
         kxFgtPnofrJypzL4ktgfVYF00t/gVRYjAtF5fTS1y1tmslm68T1sRhECNgOROuuZR3
         QUJ43porDKE3WLArDop4WFryxtJZwDsOqTW1jFIq+36nvmVq7Ruvo0Wj1pIoBDbjQb
         eCUJMU2prdHfrlWHxRBsk3mWFrYxMa27YbvcfW8FLTJiFYN3ofzEmk9HbW88n+6O4u
         fCEibq5XXMVpw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] habanalabs: allow disabling huge page use
Date:   Thu,  1 Jul 2021 14:27:17 +0300
Message-Id: <20210701112717.9540-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701112717.9540-1-ogabbay@kernel.org>
References: <20210701112717.9540-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we may need to disable optimization of using huge pages
in our memory management code. Add such a flag to the function that
creates the list of physical pages that would be programmed into the
device MMU.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 36 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 57e980d1a84b..a05d98db4857 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -819,6 +819,10 @@ static u32 get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
  * @ctx: pointer to the context structure.
  * @userptr: userptr to initialize from.
  * @pphys_pg_pack: result pointer.
+ * @force_regular_page: tell the function to ignore huge page optimization,
+ *                      even if possible. Needed for cases where the device VA
+ *                      is allocated before we know the composition of the
+ *                      physical pages
  *
  * This function does the following:
  * - Pin the physical pages related to the given virtual block.
@@ -827,17 +831,18 @@ static u32 get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
  */
 static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 				struct hl_userptr *userptr,
-				struct hl_vm_phys_pg_pack **pphys_pg_pack)
+				struct hl_vm_phys_pg_pack **pphys_pg_pack,
+				bool force_regular_page)
 {
+	u32 npages, page_size = PAGE_SIZE,
+		huge_page_size = ctx->hdev->asic_prop.pmmu_huge.page_size;
+	u32 pgs_in_huge_page = huge_page_size >> __ffs(page_size);
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
+	bool first = true, is_huge_page_opt;
+	u64 page_mask, total_npages;
 	struct scatterlist *sg;
 	dma_addr_t dma_addr;
-	u64 page_mask, total_npages;
-	u32 npages, page_size = PAGE_SIZE,
-		huge_page_size = ctx->hdev->asic_prop.pmmu_huge.page_size;
-	bool first = true, is_huge_page_opt = true;
 	int rc, i, j;
-	u32 pgs_in_huge_page = huge_page_size >> __ffs(page_size);
 
 	phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
 	if (!phys_pg_pack)
@@ -848,6 +853,8 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	phys_pg_pack->asid = ctx->asid;
 	atomic_set(&phys_pg_pack->mapping_cnt, 1);
 
+	is_huge_page_opt = (force_regular_page ? false : true);
+
 	/* Only if all dma_addrs are aligned to 2MB and their
 	 * sizes is at least 2MB, we can use huge page mapping.
 	 * We limit the 2MB optimization to this condition,
@@ -1089,7 +1096,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		}
 
 		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
-				&phys_pg_pack);
+				&phys_pg_pack, false);
 		if (rc) {
 			dev_err(hdev->dev,
 				"unable to init page pack for vaddr 0x%llx\n",
@@ -1264,17 +1271,19 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 				bool ctx_free)
 {
-	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
+	u64 vaddr = args->unmap.device_virt_addr;
 	struct hl_vm_hash_node *hnode = NULL;
+	struct asic_fixed_properties *prop;
+	struct hl_device *hdev = ctx->hdev;
 	struct hl_userptr *userptr = NULL;
 	struct hl_va_range *va_range;
-	u64 vaddr = args->unmap.device_virt_addr;
 	enum vm_type *vm_type;
 	bool is_userptr;
 	int rc = 0;
 
+	prop = &hdev->asic_prop;
+
 	/* protect from double entrance */
 	mutex_lock(&ctx->mem_hash_lock);
 	hash_for_each_possible(ctx->mem_hash, hnode, node, (unsigned long)vaddr)
@@ -1297,8 +1306,9 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	if (*vm_type == VM_TYPE_USERPTR) {
 		is_userptr = true;
 		userptr = hnode->ptr;
-		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
-							&phys_pg_pack);
+
+		rc = init_phys_pg_pack_from_userptr(ctx, userptr, &phys_pg_pack,
+							false);
 		if (rc) {
 			dev_err(hdev->dev,
 				"unable to init page pack for vaddr 0x%llx\n",
@@ -1382,7 +1392,7 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	kfree(hnode);
 
 	if (is_userptr) {
-		rc = free_phys_pg_pack(hdev, phys_pg_pack);
+		free_phys_pg_pack(hdev, phys_pg_pack);
 		dma_unmap_host_va(hdev, userptr);
 	}
 
-- 
2.25.1

