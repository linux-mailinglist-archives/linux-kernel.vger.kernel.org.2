Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E913D31CDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhBPQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:11:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:31319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhBPQLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:11:13 -0500
IronPort-SDR: XGjyaVy65DjfrX6Qp/Rg+ehOgGJ5M+LQ2cRdt8OS0QDPYwIw3RLdZ4qZnFLcx7hz/sWha/+Qm4
 k2GkshZiaT9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118537"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:04 -0800
IronPort-SDR: penHCsjnGoDBwhB0oo5BCmWYCvxWpCyDk5/UvvQraVOLJ4TaJLu/mrgfprhQXMLz9zMdtBOB2V
 RlOeVC+cKfVQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336657"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:01 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 04/12] gna: add memory handling
Date:   Tue, 16 Feb 2021 17:05:17 +0100
Message-Id: <20210216160525.5028-5-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/gna/Kbuild       |   2 +-
 drivers/misc/gna/gna_device.c |   6 +
 drivers/misc/gna/gna_device.h |  11 +-
 drivers/misc/gna/gna_mem.c    | 469 ++++++++++++++++++++++++++++++++++
 drivers/misc/gna/gna_mem.h    | 107 ++++++++
 5 files changed, 593 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/gna/gna_mem.c
 create mode 100644 drivers/misc/gna/gna_mem.h

diff --git a/drivers/misc/gna/Kbuild b/drivers/misc/gna/Kbuild
index 8620d88588e5..860b14c0e8d0 100644
--- a/drivers/misc/gna/Kbuild
+++ b/drivers/misc/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-gna-y := gna_device.o gna_driver.o gna_hw.o
+gna-y := gna_device.o gna_driver.o gna_mem.o gna_hw.o
 
 obj-$(CONFIG_INTEL_GNA) += gna.o
diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index 869507594f9e..f962c7e1e5e9 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -23,12 +23,18 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	bld_reg = gna_reg_read(gna_priv->bar0.mem_addr, GNA_MMIO_IBUFFS);
 	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 
+	mutex_init(&gna_priv->mmu_lock);
+
+	idr_init(&gna_priv->memory_idr);
+	mutex_init(&gna_priv->memidr_lock);
+
 	return 0;
 }
 
 /* Reverse gna_dev_init() */
 static void gna_dev_deinit(struct gna_private *gna_priv)
 {
+	idr_destroy(&gna_priv->memory_idr);
 	pci_set_drvdata(gna_priv->pdev, NULL);
 }
 
diff --git a/drivers/misc/gna/gna_device.h b/drivers/misc/gna/gna_device.h
index add8088ffa28..ee234e474d43 100644
--- a/drivers/misc/gna/gna_device.h
+++ b/drivers/misc/gna/gna_device.h
@@ -10,7 +10,7 @@
 
 #include <uapi/misc/gna.h>
 
-#include "gna_hw.h"
+#include "gna_mem.h"
 
 struct gna_drv_info {
 	u32 hwid;
@@ -45,6 +45,15 @@ struct gna_private {
 	struct gna_pci_bar bar0;
 	struct gna_drv_info info;
 	struct gna_hw_info hw_info;
+
+	struct gna_mmu_object mmu;
+	/* lock protecting mmu structure */
+	struct mutex mmu_lock;
+
+	/* memory objects */
+	struct idr memory_idr;
+	/* lock protecting memory_idr */
+	struct mutex memidr_lock;
 };
 
 int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
diff --git a/drivers/misc/gna/gna_mem.c b/drivers/misc/gna/gna_mem.c
new file mode 100644
index 000000000000..a2ac3c31b4fb
--- /dev/null
+++ b/drivers/misc/gna/gna_mem.c
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#define pr_fmt(fmt) KBUILD_MODNAME " " fmt
+
+#include <linux/device.h>
+#include <linux/mm.h>
+#include <linux/mmap_lock.h>
+#include <linux/pagemap.h>
+#include <linux/pci.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+
+#include <uapi/misc/gna.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+#include "gna_mem.h"
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
+	struct gna_mmu_object *mmu;
+	int desc_size;
+	int i;
+
+	if (gna_priv->info.num_pagetables > GNA_PGDIRN_LEN) {
+		dev_err(&gna_priv->dev, "too large number of pagetables requested\n");
+		return -EINVAL;
+	}
+
+	mmu = &gna_priv->mmu;
+
+	desc_size = round_up(gna_priv->info.desc_info.desc_size, PAGE_SIZE);
+
+	mmu->hwdesc = dma_alloc_coherent(&gna_priv->pdev->dev, desc_size, &mmu->hwdesc_dma,
+					 GFP_KERNEL);
+	if (!mmu->hwdesc)
+		goto end;
+
+	mmu->num_pagetables = gna_priv->info.num_pagetables;
+
+	mmu->pagetables_dma = kmalloc_array(mmu->num_pagetables, sizeof(*mmu->pagetables_dma),
+					    GFP_KERNEL);
+	if (!mmu->pagetables_dma)
+		goto err_free_descriptor;
+
+	mmu->pagetables = kmalloc_array(mmu->num_pagetables, sizeof(*mmu->pagetables), GFP_KERNEL);
+
+	if (!mmu->pagetables)
+		goto err_free_pagetables_dma;
+
+	for (i = 0; i < mmu->num_pagetables; i++) {
+		mmu->pagetables[i] = dma_alloc_coherent(&gna_priv->pdev->dev, PAGE_SIZE,
+							&mmu->pagetables_dma[i], GFP_KERNEL);
+		if (!mmu->pagetables[i])
+			goto err_free_mmu;
+	}
+
+	gna_mmu_init(gna_priv);
+
+	return 0;
+
+err_free_mmu:
+	while (i--) {
+		pci_free_consistent(gna_priv->pdev, PAGE_SIZE, mmu->pagetables[i],
+				    mmu->pagetables_dma[i]);
+		mmu->pagetables[i] = NULL;
+		mmu->pagetables_dma[i] = 0;
+	}
+
+	kfree(mmu->pagetables);
+	mmu->pagetables = NULL;
+	mmu->num_pagetables = 0;
+
+err_free_pagetables_dma:
+	kfree(mmu->pagetables_dma);
+	mmu->pagetables_dma = NULL;
+
+err_free_descriptor:
+	pci_free_consistent(gna_priv->pdev, desc_size, mmu->hwdesc, mmu->hwdesc_dma);
+	mmu->hwdesc = NULL;
+	mmu->hwdesc_dma = 0;
+
+end:
+	return -ENOMEM;
+}
+
+void gna_mmu_free(struct gna_private *gna_priv)
+{
+	struct gna_mmu_object *mmu;
+	int desc_size;
+	int i;
+
+	mmu = &gna_priv->mmu;
+	mutex_lock(&gna_priv->mmu_lock);
+
+	for (i = 0; i < mmu->num_pagetables; i++) {
+		pci_free_consistent(gna_priv->pdev, PAGE_SIZE, mmu->pagetables[i],
+				    mmu->pagetables_dma[i]);
+		mmu->pagetables[i] = NULL;
+		mmu->pagetables_dma[i] = 0;
+	}
+
+	kfree(mmu->pagetables);
+	mmu->pagetables = NULL;
+
+	kfree(mmu->pagetables_dma);
+	mmu->pagetables_dma = NULL;
+
+	desc_size = round_up(gna_priv->info.desc_info.desc_size, PAGE_SIZE);
+	pci_free_consistent(gna_priv->pdev, desc_size, mmu->hwdesc, mmu->hwdesc_dma);
+	mmu->hwdesc = NULL;
+	mmu->hwdesc_dma = 0;
+
+	mutex_unlock(&gna_priv->mmu_lock);
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
+		dev_warn(&gna_priv->dev, "empty scatter list in memory object\n");
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
+	dev_dbg(&gna_priv->dev, "vamaxaddr set to %u\n", mmu->hwdesc->mmu.vamaxaddr);
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
+		dev_warn(&gna_priv->dev, "pages are already pinned\n");
+		return -EFAULT;
+	}
+
+	/* using vmalloc because num_pages can be large */
+	skip_size = round_down(offset, PAGE_SIZE);
+	effective_address = mo->user_address + skip_size;
+	dev_dbg(&gna_priv->dev, "user address %llx\n", mo->user_address);
+	dev_dbg(&gna_priv->dev, "effective user address %llx\n", effective_address);
+
+	effective_size = gna_buffer_get_size(offset, size);
+
+	num_pages = effective_size >> PAGE_SHIFT;
+	dev_dbg(&gna_priv->dev, "allocating %d pages\n", num_pages);
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
+		dev_err(&gna_priv->dev, "function get_user_pages_remote() failed\n");
+		goto err_free_pages;
+	}
+	if (num_pinned < num_pages) {
+		ret = -EFAULT;
+		dev_err(&gna_priv->dev,
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
+		dev_err(&gna_priv->dev, "could not alloc scatter list\n");
+		goto err_free_sgt;
+	}
+
+	if (IS_ERR(sgt->sgl)) {
+		dev_err(&gna_priv->dev, "sgl allocation failed\n");
+		ret = PTR_ERR(sgt->sgl);
+		goto err_free_sgt;
+	}
+
+	ents = pci_map_sg(gna_priv->pdev, sgt->sgl, sgt->nents, PCI_DMA_BIDIRECTIONAL);
+	if (ents <= 0) {
+		dev_err(&gna_priv->dev, "could not map scatter gather list\n");
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
+		dev_warn(&gna_priv->dev, "memory object has no pages %llu\n", mo->memory_id);
+		return;
+	}
+
+	sgt = mo->sgt;
+
+	pci_unmap_sg(gna_priv->pdev, sgt->sgl, sgt->nents, PCI_DMA_BIDIRECTIONAL);
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
+int gna_priv_userptr(struct gna_file_private *file_priv, union gna_memory_map *gna_mem)
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
+		dev_err(&gna_priv->dev, "user pointer not page aligned\n");
+		return -EINVAL;
+	}
+
+	if (!gna_mem->in.size) {
+		dev_err(&gna_priv->dev, "invalid user memory size\n");
+		return -EINVAL;
+	}
+
+	if (!access_ok(u64_to_user_ptr(gna_mem->in.address), gna_mem->in.size)) {
+		dev_err(&gna_priv->dev, "invalid user pointer\n");
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
+		dev_err(&gna_priv->dev, "idr allocation for memory failed\n");
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
diff --git a/drivers/misc/gna/gna_mem.h b/drivers/misc/gna/gna_mem.h
new file mode 100644
index 000000000000..218f8c0f51a3
--- /dev/null
+++ b/drivers/misc/gna/gna_mem.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_MEM_H__
+#define __GNA_MEM_H__
+
+#include <linux/mmu_notifier.h>
+
+#include "gna_hw.h"
+
+union gna_memory_map;
+
+struct gna_file_private;
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
+struct gna_mmu_notifier {
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+	struct gna_memory_object *mo;
+	struct mmu_notifier mn;
+	struct mm_struct *mm;
+};
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
+	struct list_head mem_list;
+
+	struct list_head file_mem_list;
+
+	struct work_struct work;
+
+	struct wait_queue_head waitq;
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
+int gna_priv_userptr(struct gna_file_private *file_priv, union gna_memory_map *gna_mem);
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
-- 
2.28.0

