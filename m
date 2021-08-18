Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD43F0504
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhHRNlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237609AbhHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DE1661058;
        Wed, 18 Aug 2021 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293980;
        bh=POJ9PYwnf+W8Td4gUWBGaB5mhOS8pjPJwkY1FAFJDbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6XciPytfg4mp1uIdhFnpjGdoS4VHTxX+dTP+TGoyFFGXz/9mgRSFIMM/4fn9B0Re
         YzxbFojCTn0QKdMZHbFK/huHT/qFY9Sac2uNm6nRI86knD0IAEAqfvpn2qyd8E73NH
         PK44E2FYsH6DfaVEpWK1LnBaQRTgnRG/btdAxM6GUE4lumqn6fiIFJJAOOA1IpyBWZ
         YmBmCXFkAqJUXZbrknrK/fMfmylcEsTPGEGgpGDchAmQN55GxopI/BcAsE2AHEqiQi
         ikfPByaTehCO+3jGsAn1QYJ5hbkvtEjglQagIqmnEzGW+PmGGipsWvsSF1/FHNEVPH
         SbG8KS9Lq1MGg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 12/16] habanalabs: add userptr_lookup node in debugfs
Date:   Wed, 18 Aug 2021 16:39:18 +0300
Message-Id: <20210818133922.63637-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

It is useful to have the ability to see which user address was pinned
to which physical address during the initial mapping. We already have
all that info stored, but no means to search this data (which may be
quite large).

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  8 +++
 drivers/misc/habanalabs/common/debugfs.c      | 72 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   | 19 +++++
 drivers/misc/habanalabs/common/memory.c       | 21 +-----
 4 files changed, 101 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index e29156511388..284e2dfa61cd 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -241,6 +241,14 @@ Description:    Displays a list with information about the currently user
                 pointers (user virtual addresses) that are pinned and mapped
                 to DMA addresses
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/userptr_lookup
+Date:           Aug 2021
+KernelVersion:  5.15
+Contact:        ogabbay@kernel.org
+Description:    Allows to search for specific user pointers (user virtual
+                addresses) that are pinned and mapped to DMA addresses, and see
+                their resolution to the specific dma address.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/vm
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 6a7df57883d9..a57387803864 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -320,6 +320,77 @@ static int vm_show(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int userptr_lookup_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct scatterlist *sg;
+	struct hl_userptr *userptr;
+	bool first = true;
+	u64 total_npages, npages, sg_start, sg_end;
+	dma_addr_t dma_addr;
+	int i;
+
+	spin_lock(&dev_entry->userptr_spinlock);
+
+	list_for_each_entry(userptr, &dev_entry->userptr_list, debugfs_list) {
+		if (dev_entry->userptr_lookup >= userptr->addr &&
+		dev_entry->userptr_lookup < userptr->addr + userptr->size) {
+			total_npages = 0;
+			for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents,
+					i) {
+				npages = hl_get_sg_info(sg, &dma_addr);
+				sg_start = userptr->addr +
+					total_npages * PAGE_SIZE;
+				sg_end = userptr->addr +
+					(total_npages + npages) * PAGE_SIZE;
+
+				if (dev_entry->userptr_lookup >= sg_start &&
+				    dev_entry->userptr_lookup < sg_end) {
+					dma_addr += (dev_entry->userptr_lookup -
+							sg_start);
+					if (first) {
+						first = false;
+						seq_puts(s, "\n");
+						seq_puts(s, " user virtual address         dma address       pid        region start     region size\n");
+						seq_puts(s, "---------------------------------------------------------------------------------------\n");
+					}
+					seq_printf(s, " 0x%-18llx  0x%-16llx  %-8u  0x%-16llx %-12llu\n",
+						dev_entry->userptr_lookup,
+						dma_addr, userptr->pid,
+						userptr->addr, userptr->size);
+				}
+				total_npages += npages;
+			}
+		}
+	}
+
+	spin_unlock(&dev_entry->userptr_spinlock);
+
+	if (!first)
+		seq_puts(s, "\n");
+
+	return 0;
+}
+
+static ssize_t userptr_lookup_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *f_pos)
+{
+	struct seq_file *s = file->private_data;
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	ssize_t rc;
+	u64 value;
+
+	rc = kstrtoull_from_user(buf, count, 16, &value);
+	if (rc)
+		return rc;
+
+	dev_entry->userptr_lookup = value;
+
+	return count;
+}
+
 static int mmu_show(struct seq_file *s, void *data)
 {
 	struct hl_debugfs_entry *entry = s->private;
@@ -1175,6 +1246,7 @@ static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_submission_jobs", command_submission_jobs_show, NULL},
 	{"userptr", userptr_show, NULL},
 	{"vm", vm_show, NULL},
+	{"userptr_lookup", userptr_lookup_show, userptr_lookup_write},
 	{"mmu", mmu_show, mmu_asid_va_write},
 	{"engines", engines_show, NULL}
 };
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 74c2a587d907..465fd909a7b7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1836,6 +1836,7 @@ struct hl_debugfs_entry {
  * @state_dump_sem: protects state_dump.
  * @addr: next address to read/write from/to in read/write32.
  * @mmu_addr: next virtual address to translate to physical address in mmu_show.
+ * @userptr_lookup: the target user ptr to look up for on demand.
  * @mmu_asid: ASID to use while translating in mmu_show.
  * @state_dump_head: index of the latest state dump
  * @i2c_bus: generic u8 debugfs file for bus value to use in i2c_data_read.
@@ -1863,6 +1864,7 @@ struct hl_dbg_device_entry {
 	struct rw_semaphore		state_dump_sem;
 	u64				addr;
 	u64				mmu_addr;
+	u64				userptr_lookup;
 	u32				mmu_asid;
 	u32				state_dump_head;
 	u8				i2c_bus;
@@ -2669,6 +2671,23 @@ struct hl_ioctl_desc {
  * Kernel module functions that can be accessed by entire module
  */
 
+/**
+ * hl_get_sg_info() - get number of pages and the DMA address from SG list.
+ * @sg: the SG list.
+ * @dma_addr: pointer to DMA address to return.
+ *
+ * Calculate the number of consecutive pages described by the SG list. Take the
+ * offset of the address in the first page, add to it the length and round it up
+ * to the number of needed pages.
+ */
+static inline u32 hl_get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
+{
+	*dma_addr = sg_dma_address(sg);
+
+	return ((((*dma_addr) & (PAGE_SIZE - 1)) + sg_dma_len(sg)) +
+			(PAGE_SIZE - 1)) >> PAGE_SHIFT;
+}
+
 /**
  * hl_mem_area_inside_range() - Checks whether address+size are inside a range.
  * @address: The start address of the area we want to validate.
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 2f990d185cfd..72954abf20fe 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -805,23 +805,6 @@ int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 	return rc;
 }
 
-/**
- * get_sg_info() - get number of pages and the DMA address from SG list.
- * @sg: the SG list.
- * @dma_addr: pointer to DMA address to return.
- *
- * Calculate the number of consecutive pages described by the SG list. Take the
- * offset of the address in the first page, add to it the length and round it up
- * to the number of needed pages.
- */
-static u32 get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
-{
-	*dma_addr = sg_dma_address(sg);
-
-	return ((((*dma_addr) & (PAGE_SIZE - 1)) + sg_dma_len(sg)) +
-			(PAGE_SIZE - 1)) >> PAGE_SHIFT;
-}
-
 /**
  * init_phys_pg_pack_from_userptr() - initialize physical page pack from host
  *                                    memory
@@ -872,7 +855,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	 */
 	total_npages = 0;
 	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
-		npages = get_sg_info(sg, &dma_addr);
+		npages = hl_get_sg_info(sg, &dma_addr);
 
 		total_npages += npages;
 
@@ -901,7 +884,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 
 	j = 0;
 	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
-		npages = get_sg_info(sg, &dma_addr);
+		npages = hl_get_sg_info(sg, &dma_addr);
 
 		/* align down to physical page size and save the offset */
 		if (first) {
-- 
2.17.1

