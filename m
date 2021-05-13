Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F054F37F63C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhEMLDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:03:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:45138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232939AbhEMLCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:20 -0400
IronPort-SDR: LrulQsSTULcXiOhkp5ofL7kaTGHwUw2RBwwxSe1QPoloXzeLraxu25m1vMtKJwzmL9Ti3JLZJX
 noQB1/1REbJA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048287"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048287"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:05 -0700
IronPort-SDR: 8rEMhSXtzUGCqu8eWUpGYI12sRkkVdI4x/AbcxK3+APc0pPbGoNEbfieRCTIigGoBK2o8pRsMS
 iOq6BkPI07dQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625983908"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:02 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v3 04/14] intel_gna: add memory handling
Date:   Thu, 13 May 2021 13:00:30 +0200
Message-Id: <20210513110040.2268-5-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Patch adds memory handling - mapping, DMA, pinning.
The GNA driver maps and unmaps the physical pages for 64-byte aligned
buffer allocated by user space program. The pages of mapped memory
are being locked only during actual computation.

Patch adds configuration of the DMA scatter gather list for physical pages
and generation of page table and page directory to be programmed in the GNA HW
at the time of scoring initiation.

GNA’s MMU is being configured based on specific request memory usage.
As the MMU can address up to 256MB a single scoring request is limited
to this amount of memory being used.

GNA Library can allocate any number of memory regions for GNA usage.
Its number and total capacity are limited by the OSs’ resources.
Due to GNA MMU restrictions, even when using multiple memory regions,
the sum of all the memory regions used within a single inference
request must be less than 256MB.

At least a single GNA memory region is needed to be allocated
(and can be shared by multiple models). At the other extreme,
each GNA tensor (e.g., weights/biases/inputs/outputs) could use
its own, separate GNA memory region.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/Kbuild   |   2 +-
 drivers/misc/intel/gna/device.c |  18 ++
 drivers/misc/intel/gna/device.h |  28 +++
 drivers/misc/intel/gna/mem.c    | 418 ++++++++++++++++++++++++++++++++
 drivers/misc/intel/gna/mem.h    | 115 +++++++++
 include/uapi/misc/intel/gna.h   |  12 +
 6 files changed, 592 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/mem.c
 create mode 100644 drivers/misc/intel/gna/mem.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 69e20c8c22bd..64e8f10fd891 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := device.o hw.o pci.o
+intel_gna-y := device.o hw.o mem.o pci.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 45b4b6df64ef..ed7d3c0223df 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -16,6 +16,13 @@ module_param(recovery_timeout, int, 0644);
 MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
 #endif
 
+static void gna_devm_idr_destroy(void *data)
+{
+	struct idr *idr = data;
+
+	idr_destroy(idr);
+}
+
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase)
 {
 	static atomic_t dev_last_idx = ATOMIC_INIT(-1);
@@ -52,6 +59,17 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	bld_reg = gna_reg_read(gna_priv, GNA_MMIO_IBUFFS);
 	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 
+	mutex_init(&gna_priv->mmu_lock);
+
+	idr_init(&gna_priv->memory_idr);
+	ret = devm_add_action(parent, gna_devm_idr_destroy, &gna_priv->memory_idr);
+	if (ret) {
+		dev_err(parent, "could not add devm action for idr\n");
+		return ret;
+	}
+
+	mutex_init(&gna_priv->memidr_lock);
+
 	return 0;
 }
 
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index 057dec0e1983..f74c773867aa 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -4,14 +4,29 @@
 #ifndef __GNA_DEVICE_H__
 #define __GNA_DEVICE_H__
 
+#include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 #include "hw.h"
+#include "mem.h"
 
 #define GNA_DV_NAME	"intel_gna"
 
 struct device;
+struct file;
+
+struct gna_file_private {
+	struct file *fd;
+	struct gna_private *gna_priv;
+
+	struct list_head memory_list;
+	struct mutex memlist_lock;
+
+	struct list_head flist;
+};
 
 struct gna_private {
 	int index;
@@ -25,6 +40,14 @@ struct gna_private {
 	void __iomem *iobase;
 	struct gna_dev_info info;
 	struct gna_hw_info hw_info;
+
+	struct gna_mmu_object mmu;
+	struct mutex mmu_lock;
+
+	/* memory objects' store */
+	struct idr memory_idr;
+	/* lock protecting memory_idr */
+	struct mutex memidr_lock;
 };
 
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase);
@@ -39,6 +62,11 @@ static inline void gna_reg_write(struct gna_private *gna_priv, u32 reg, u32 val)
 	writel(val, gna_priv->iobase + reg);
 }
 
+static inline struct device *gna_parent(struct gna_private *gna_priv)
+{
+	return gna_priv->parent;
+}
+
 static inline struct device *gna_dev(struct gna_private *gna_priv)
 {
 	return gna_priv->parent;
diff --git a/drivers/misc/intel/gna/mem.c b/drivers/misc/intel/gna/mem.c
new file mode 100644
index 000000000000..bdc2771a0d18
--- /dev/null
+++ b/drivers/misc/intel/gna/mem.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/pagemap.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "hw.h"
+#include "device.h"
+#include "mem.h"
+
+static void gna_mmu_init(struct gna_private *gna_priv)
+{
+	struct gna_mmu_object *mmu;
+	dma_addr_t pagetable_dma;
+	u32 *pgdirn;
+	int i;
+
+	mmu = &gna_priv->mmu;
+
+	pgdirn = mmu->hwdesc->mmu.pagedir_n;
+
+	for (i = 0; i < mmu->num_pagetables; i++) {
+		pagetable_dma = mmu->pagetables_dma[i];
+		pgdirn[i] = pagetable_dma >> PAGE_SHIFT;
+	}
+
+	for (; i < GNA_PGDIRN_LEN; i++)
+		pgdirn[i] = GNA_PGDIR_INVALID;
+}
+
+/* descriptor and page tables allocation */
+int gna_mmu_alloc(struct gna_private *gna_priv)
+{
+	struct device *parent = gna_parent(gna_priv);
+	struct gna_mmu_object *mmu;
+	int desc_size;
+	int i;
+
+	if (gna_priv->info.num_pagetables > GNA_PGDIRN_LEN) {
+		dev_err(gna_dev(gna_priv), "too large number of pagetables requested\n");
+		return -EINVAL;
+	}
+
+	mmu = &gna_priv->mmu;
+
+	desc_size = round_up(gna_priv->info.desc_info.desc_size, PAGE_SIZE);
+
+	mmu->hwdesc = dmam_alloc_coherent(parent, desc_size, &mmu->hwdesc_dma,
+					GFP_KERNEL);
+	if (!mmu->hwdesc)
+		return -ENOMEM;
+
+	mmu->num_pagetables = gna_priv->info.num_pagetables;
+
+	mmu->pagetables_dma = devm_kmalloc_array(parent, mmu->num_pagetables, sizeof(*mmu->pagetables_dma),
+						GFP_KERNEL);
+	if (!mmu->pagetables_dma)
+		return -ENOMEM;
+
+	mmu->pagetables = devm_kmalloc_array(parent, mmu->num_pagetables, sizeof(*mmu->pagetables), GFP_KERNEL);
+
+	if (!mmu->pagetables)
+		return -ENOMEM;
+
+	for (i = 0; i < mmu->num_pagetables; i++) {
+		mmu->pagetables[i] = dmam_alloc_coherent(parent, PAGE_SIZE,
+							&mmu->pagetables_dma[i], GFP_KERNEL);
+		if (!mmu->pagetables[i])
+			return -ENOMEM;
+	}
+
+	gna_mmu_init(gna_priv);
+
+	return 0;
+}
+
+void gna_mmu_add(struct gna_private *gna_priv, struct gna_memory_object *mo)
+{
+	struct gna_mmu_object *mmu;
+	struct scatterlist *sgl;
+	dma_addr_t sg_page;
+	int sg_page_len;
+	u32 *pagetable;
+	u32 mmu_page;
+	int sg_pages;
+	int i;
+	int j;
+
+	mmu = &gna_priv->mmu;
+	mutex_lock(&gna_priv->mmu_lock);
+
+	j = mmu->filled_pages;
+	sgl = mo->sgt->sgl;
+	if (!sgl) {
+		dev_warn(gna_dev(gna_priv), "empty scatter list in memory object\n");
+		goto warn_empty_sgl;
+	}
+	sg_page = sg_dma_address(sgl);
+	sg_page_len = round_up(sg_dma_len(sgl), PAGE_SIZE) >> PAGE_SHIFT;
+	sg_pages = 0;
+
+	for (i = mmu->filled_pts; i < mmu->num_pagetables; i++) {
+		if (!sgl)
+			break;
+
+		pagetable = mmu->pagetables[i];
+
+		for (j = mmu->filled_pages; j < GNA_PT_LENGTH; j++) {
+			mmu_page = sg_page >> PAGE_SHIFT;
+			pagetable[j] = mmu_page;
+
+			mmu->filled_pages++;
+			sg_page += PAGE_SIZE;
+			sg_pages++;
+			if (sg_pages == sg_page_len) {
+				sgl = sg_next(sgl);
+				if (!sgl)
+					break;
+
+				sg_page = sg_dma_address(sgl);
+				sg_page_len =
+					round_up(sg_dma_len(sgl), PAGE_SIZE)
+						>> PAGE_SHIFT;
+				sg_pages = 0;
+			}
+		}
+
+		if (j == GNA_PT_LENGTH) {
+			mmu->filled_pages = 0;
+			mmu->filled_pts++;
+		}
+	}
+
+	mmu->hwdesc->mmu.vamaxaddr =
+		(mmu->filled_pts * PAGE_SIZE * GNA_PGDIR_ENTRIES) +
+		(mmu->filled_pages * PAGE_SIZE) - 1;
+	dev_dbg(gna_dev(gna_priv), "vamaxaddr set to %u\n", mmu->hwdesc->mmu.vamaxaddr);
+
+warn_empty_sgl:
+	mutex_unlock(&gna_priv->mmu_lock);
+}
+
+void gna_mmu_clear(struct gna_private *gna_priv)
+{
+	struct gna_mmu_object *mmu;
+	int i;
+
+	mmu = &gna_priv->mmu;
+	mutex_lock(&gna_priv->mmu_lock);
+
+	for (i = 0; i < mmu->filled_pts; i++)
+		memset(mmu->pagetables[i], 0, PAGE_SIZE);
+
+	if (mmu->filled_pages > 0)
+		memset(mmu->pagetables[mmu->filled_pts], 0, mmu->filled_pages * GNA_PT_ENTRY_SIZE);
+
+	mmu->filled_pts = 0;
+	mmu->filled_pages = 0;
+	mmu->hwdesc->mmu.vamaxaddr = 0;
+
+	mutex_unlock(&gna_priv->mmu_lock);
+}
+
+int gna_buffer_get_size(u64 offset, u64 size)
+{
+	u64 page_offset;
+
+	page_offset = offset & ~PAGE_MASK;
+	return round_up(page_offset + size, PAGE_SIZE);
+}
+
+/* must be called with gna_memory_object page_lock held */
+static int gna_get_pages(struct gna_memory_object *mo, u64 offset, u64 size)
+{
+	struct gna_private *gna_priv;
+	u64 effective_address;
+	struct mm_struct *mm;
+	struct sg_table *sgt;
+	struct page **pages;
+	int effective_size;
+	int num_pinned;
+	int num_pages;
+	int skip_size;
+	int ents;
+	int ret;
+
+	ret = 0;
+	gna_priv = mo->gna_priv;
+
+	if (mo->pages) {
+		dev_warn(gna_dev(gna_priv), "pages are already pinned\n");
+		return -EFAULT;
+	}
+
+	/* using vmalloc because num_pages can be large */
+	skip_size = round_down(offset, PAGE_SIZE);
+	effective_address = mo->user_address + skip_size;
+	dev_dbg(gna_dev(gna_priv), "user address %llx\n", mo->user_address);
+	dev_dbg(gna_dev(gna_priv), "effective user address %llx\n", effective_address);
+
+	effective_size = gna_buffer_get_size(offset, size);
+
+	num_pages = effective_size >> PAGE_SHIFT;
+	dev_dbg(gna_dev(gna_priv), "allocating %d pages\n", num_pages);
+	pages = kvmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	get_task_struct(mo->task);
+	mm = get_task_mm(mo->task);
+	if (!mm) {
+		ret = -ENOENT;
+		goto err_put_task;
+	}
+	mmap_read_lock(mm);
+	num_pinned = get_user_pages_remote(mm, effective_address, num_pages,
+					   FOLL_WRITE, pages, NULL, NULL);
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	if (num_pinned <= 0) {
+		ret = num_pinned;
+		dev_err(gna_dev(gna_priv), "function get_user_pages_remote() failed\n");
+		goto err_free_pages;
+	}
+	if (num_pinned < num_pages) {
+		ret = -EFAULT;
+		dev_err(gna_dev(gna_priv),
+			"get_user_pages_remote() pinned fewer pages number than requested\n");
+		goto err_free_pages;
+	}
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt) {
+		ret = -ENOMEM;
+		goto err_put_pages;
+	}
+
+	ret = sg_alloc_table_from_pages(sgt, pages, num_pinned, 0, mo->memory_size, GFP_KERNEL);
+	if (ret) {
+		dev_err(gna_dev(gna_priv), "could not alloc scatter list\n");
+		goto err_free_sgt;
+	}
+
+	if (IS_ERR(sgt->sgl)) {
+		dev_err(gna_dev(gna_priv), "sgl allocation failed\n");
+		ret = PTR_ERR(sgt->sgl);
+		goto err_free_sgt;
+	}
+
+	ents = dma_map_sg(gna_parent(gna_priv), sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+	if (ents <= 0) {
+		dev_err(gna_dev(gna_priv), "could not map scatter gather list\n");
+		ret = -EIO;
+		goto err_free_sgl;
+	}
+
+	mo->sgt = sgt;
+	mo->pages = pages;
+	mo->num_pinned = num_pinned;
+
+	return 0;
+
+err_free_sgl:
+	sg_free_table(sgt);
+
+err_free_sgt:
+	kfree(sgt);
+
+err_put_pages:
+	release_pages(pages, num_pinned);
+
+err_free_pages:
+	kvfree(pages);
+
+err_put_task:
+	put_task_struct(mo->task);
+
+err_exit:
+	return ret;
+}
+
+/* must be called with gna_memory_object page_lock held */
+static void gna_put_pages(struct gna_memory_object *mo)
+{
+	struct gna_private *gna_priv;
+	struct sg_table *sgt;
+
+	gna_priv = mo->gna_priv;
+
+	if (!mo->pages) {
+		dev_warn(gna_dev(gna_priv), "memory object has no pages %llu\n", mo->memory_id);
+		return;
+	}
+
+	sgt = mo->sgt;
+
+	dma_unmap_sg(gna_parent(gna_priv), sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+	sg_free_table(sgt);
+	kfree(sgt);
+	mo->sgt = NULL;
+
+	release_pages(mo->pages, mo->num_pinned);
+	kvfree(mo->pages);
+	mo->pages = NULL;
+	mo->num_pinned = 0;
+
+	put_task_struct(mo->task);
+}
+
+void gna_memory_free(struct gna_private *gna_priv, struct gna_memory_object *mo)
+{
+	mutex_lock(&gna_priv->memidr_lock);
+	idr_remove(&gna_priv->memory_idr, mo->memory_id);
+	mutex_unlock(&gna_priv->memidr_lock);
+
+	cancel_work_sync(&mo->work);
+	kfree(mo);
+}
+
+static void gna_memory_release(struct work_struct *work)
+{
+	struct gna_memory_object *mo;
+
+	mo = container_of(work, struct gna_memory_object, work);
+
+	mo->user_ptr = NULL;
+
+	wake_up_interruptible(&mo->waitq);
+}
+
+static const struct gna_memory_operations memory_ops = {
+	.get_pages = gna_get_pages,
+	.put_pages = gna_put_pages,
+};
+
+int gna_map_memory(struct gna_file_private *file_priv, union gna_memory_map *gna_mem)
+{
+	struct gna_memory_object *mo;
+	struct gna_private *gna_priv;
+	int memory_id;
+	int ret;
+
+	ret = 0;
+
+	gna_priv = file_priv->gna_priv;
+
+	if (gna_mem->in.address & ~PAGE_MASK) {
+		dev_err(gna_dev(gna_priv), "user pointer not page aligned\n");
+		return -EINVAL;
+	}
+
+	if (!gna_mem->in.size) {
+		dev_err(gna_dev(gna_priv), "invalid user memory size\n");
+		return -EINVAL;
+	}
+
+	if (!access_ok(u64_to_user_ptr(gna_mem->in.address), gna_mem->in.size)) {
+		dev_err(gna_dev(gna_priv), "invalid user pointer\n");
+		return -EINVAL;
+	}
+
+	mo = kzalloc(sizeof(*mo), GFP_KERNEL);
+	if (!mo)
+		return -ENOMEM;
+
+	mo->fd = file_priv->fd;
+	mo->gna_priv = gna_priv;
+	mo->ops = &memory_ops;
+	mo->user_address = gna_mem->in.address;
+	mo->memory_size = gna_mem->in.size;
+	mo->user_ptr = u64_to_user_ptr(gna_mem->in.address);
+	mo->num_pages = round_up(gna_mem->in.size, PAGE_SIZE) >> PAGE_SHIFT;
+	mo->task = current;
+	INIT_WORK(&mo->work, gna_memory_release);
+	init_waitqueue_head(&mo->waitq);
+	mutex_init(&mo->page_lock);
+
+	mutex_lock(&gna_priv->memidr_lock);
+	memory_id = idr_alloc(&gna_priv->memory_idr, mo, 1, 0, GFP_KERNEL);
+	mutex_unlock(&gna_priv->memidr_lock);
+
+	if (memory_id < 0) {
+		dev_err(gna_dev(gna_priv), "idr allocation for memory failed\n");
+		ret = -EFAULT;
+		goto err_free_mo;
+	}
+
+	mo->memory_id = (u64)memory_id;
+
+	mutex_lock(&file_priv->memlist_lock);
+	list_add_tail(&mo->file_mem_list, &file_priv->memory_list);
+	mutex_unlock(&file_priv->memlist_lock);
+
+	gna_mem->out.memory_id = mo->memory_id;
+
+	return 0;
+
+err_free_mo:
+	kfree(mo);
+	return ret;
+}
diff --git a/drivers/misc/intel/gna/mem.h b/drivers/misc/intel/gna/mem.h
new file mode 100644
index 000000000000..b198b35cbb68
--- /dev/null
+++ b/drivers/misc/intel/gna/mem.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_MEM_H__
+#define __GNA_MEM_H__
+
+#include <linux/mmu_notifier.h>
+#include <linux/workqueue.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+
+#include "hw.h"
+
+struct gna_file_private;
+union gna_memory_map;
+struct gna_private;
+struct task_struct;
+struct mm_struct;
+struct file;
+
+struct gna_xnn_descriptor {
+	u32 labase;
+	u16 lacount;
+	u16 _rsvd;
+};
+
+struct gna_mmu {
+	u32 vamaxaddr;
+	u8 __res_204[12];
+	u32 pagedir_n[GNA_PGDIRN_LEN];
+};
+
+struct gna_hw_descriptor {
+	u8 __res_0000[256];
+	struct gna_xnn_descriptor xnn_config;
+	u8 __unused[248];
+	struct gna_mmu mmu;
+};
+
+struct gna_mmu_object {
+	struct gna_hw_descriptor *hwdesc;
+
+	dma_addr_t hwdesc_dma;
+
+	u32 **pagetables;
+	dma_addr_t *pagetables_dma;
+
+	u32 num_pagetables;
+
+	u32 filled_pts;
+	u32 filled_pages;
+};
+
+struct gna_memory_operations;
+
+struct gna_memory_object {
+	u64 memory_id;
+
+	const struct gna_memory_operations *ops;
+
+	struct gna_private *gna_priv;
+	struct file *fd;
+
+	void __user *user_ptr;
+	u64 user_address;
+	u64 memory_size;
+
+	struct page **pages;
+	struct sg_table *sgt;
+	int num_pages;
+	int num_pinned;
+	struct mutex page_lock;	/* protects get/put pages operations */
+
+	struct task_struct *task;
+
+	struct list_head file_mem_list;
+
+	struct work_struct work;
+
+	struct wait_queue_head waitq;
+};
+
+struct gna_mmu_notifier {
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+	struct gna_memory_object *mo;
+	struct mmu_notifier mn;
+	struct mm_struct *mm;
+};
+
+struct gna_memory_operations {
+	/* pins pages */
+	int (*get_pages)(struct gna_memory_object *mo, u64 offset, u64 size);
+
+	/* puts previously pinned pages */
+	void (*put_pages)(struct gna_memory_object *mo);
+};
+
+int gna_buffer_get_size(u64 offset, u64 size);
+
+int gna_map_memory(struct gna_file_private *file_priv, union gna_memory_map *gna_mem);
+
+int gna_mmu_alloc(struct gna_private *gna_priv);
+
+void gna_mmu_free(struct gna_private *gna_priv);
+
+void gna_mmu_add(struct gna_private *gna_priv, struct gna_memory_object *object);
+
+void gna_mmu_clear(struct gna_private *gna_priv);
+
+void gna_memory_free(struct gna_private *gna_priv, struct gna_memory_object *mo);
+
+#endif // __GNA_MEM_H__
diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
index 16a44efd0f76..a4b6a1e2010c 100644
--- a/include/uapi/misc/intel/gna.h
+++ b/include/uapi/misc/intel/gna.h
@@ -40,6 +40,18 @@ struct gna_compute_cfg {
 	__u8 pad[5];
 };
 
+union gna_memory_map {
+	struct {
+		__u64 address;
+		__u32 size;
+		__u32 pad;
+	} in;
+
+	struct {
+		__u64 memory_id;
+	} out;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.28.0

