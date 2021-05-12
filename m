Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F3337B6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhELHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:12:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:29454 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhELHMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:12:39 -0400
IronPort-SDR: i6B37kI9dhYp8y1Iz8iAsPvaefIR9t1hqHsQMUvgjA/wq3lYb9QPGZLWlvmiqY8vdWa2ic+gtF
 gpr9d2zEs0oQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186770458"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="186770458"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 00:11:31 -0700
IronPort-SDR: Dblhl0LOhP4JMSiqozVQzbEF5Ir2NkYrXBI9Rv1XgHsP8QDpVg1NBOUyDGYrP0GP6KTTxvXtLT
 ttX4VmqMh9Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="541965895"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2021 00:11:28 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH 05/15] misc: nnpi: Manage host memory resources
Date:   Wed, 12 May 2021 10:10:36 +0300
Message-Id: <20210512071046.34941-6-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210512071046.34941-1-guy.zadicario@intel.com>
References: <20210512071046.34941-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide interface for creating a "host resource" - a memory object
which can be mapped to a dma address space of one or more NNP-I
devices. These host resource objects manage memory blocks from which
big chunks of data, such as inference tensors, the device's embedded OS
and telemtry data are DMA'ed to and from the NNP-I device.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-driver-intel_nnpi |   5 +
 drivers/misc/intel-nnpi/Makefile                  |   2 +-
 drivers/misc/intel-nnpi/hostres.c                 | 627 ++++++++++++++++++++++
 drivers/misc/intel-nnpi/hostres.h                 | 167 ++++++
 4 files changed, 800 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_nnpi
 create mode 100644 drivers/misc/intel-nnpi/hostres.c
 create mode 100644 drivers/misc/intel-nnpi/hostres.h

diff --git a/Documentation/ABI/testing/sysfs-driver-intel_nnpi b/Documentation/ABI/testing/sysfs-driver-intel_nnpi
new file mode 100644
index 0000000..b09880f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel_nnpi
@@ -0,0 +1,5 @@
+What:           /sys/class/nnpi_host/nnpi_host/total_hostres_size
+Date:           Mar 2021
+Kernelversion:  5.13
+Contact:        guy.zadicario@intel.com
+Description:    Total size in bytes of all allocated NNP-I host resources.
diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
index 43f09c0..3713d51 100644
--- a/drivers/misc/intel-nnpi/Makefile
+++ b/drivers/misc/intel-nnpi/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
 
-intel_nnpi-y := device.o msg_scheduler.o
+intel_nnpi-y := device.o msg_scheduler.o hostres.o
 
 intel_nnpi_pcie-y := nnp_pcie.o
 
diff --git a/drivers/misc/intel-nnpi/hostres.c b/drivers/misc/intel-nnpi/hostres.c
new file mode 100644
index 0000000..e0d71c0
--- /dev/null
+++ b/drivers/misc/intel-nnpi/hostres.c
@@ -0,0 +1,627 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/pagemap.h>
+#include <linux/pfn.h>
+#include <linux/printk.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "hostres.h"
+#include "ipc_protocol.h"
+
+/**
+ * struct host_resource - structure for host memory resource object
+ * @ref: kref for that host resource object
+ * @size: size of the memory resource, in bytes
+ * @devices: list of devices this resource is mapped to (list of nnpdev_mapping)
+ * @lock: protects @devices
+ * @dir: DMA direction mask possible for this resource, when mapped to device.
+ * @pinned_mm: mm object used to pin the user allocated resource memory. NULL
+ *             if the resource was not allocated by user-space.
+ * @vptr: virtual pointer to the resource memory if allocated by
+ *        nnp_hostres_alloc(). NULL otherwise.
+ * @start_offset: holds the offset within the first pinned page where resource
+ *                memory starts (relevant only when @pinned_mm is not NULL).
+ * @pages: array of resource memory pages.
+ * @n_pages: size of pages array.
+ */
+struct host_resource {
+	struct kref       ref;
+	size_t            size;
+	struct list_head  devices;
+	spinlock_t        lock;
+	enum dma_data_direction dir;
+
+	struct mm_struct  *pinned_mm;
+	void              *vptr;
+	unsigned int      start_offset;
+
+	struct page       **pages;
+	unsigned int      n_pages;
+};
+
+/**
+ * struct nnpdev_mapping - mapping information of host resource to one device
+ * @ref: kref for that mapping object
+ * @res: pointer to the host resource
+ * @dev: the device the resource is mapped to
+ * @sgt: scatter table of host resource pages in memory
+ * @dma_chain_sgt: sg_table of dma_chain blocks (see description below).
+ * @dma_chain_order: order used to allocate scatterlist of @dma_chain_sgt.
+ * @node: list head to attach this object to a list of mappings
+ *
+ * This structure holds mapping information of one host resource to one
+ * NNP-I device. @sgt is the sg_table describes the DMA addresses of the
+ * resource chunks.
+ *
+ * When mapping a host memory resource for NNP-I device access, we need to send
+ * the DMA page table of the resource to the device. The device uses this page
+ * table when programming its DMA engine to read/write the host resource.
+ *
+ * The format of that page table is a chain of continuous DMA buffers, each
+ * starts with a 24 bytes header (&struct dma_chain_header) followed by 8 bytes
+ * entries, each describe a continuous block of the resource
+ * (&struct nnp_dma_chain_entry).
+ *
+ * The header of the chain has a pointer to the next buffer in the chain for
+ * the case where multiple DMA blocks are required to describe the
+ * entire resource. The address of the first block in the chain is sent to
+ * the device, which then fetches the entire chain when the resource is
+ * mapped. @dma_chain_sgt is an sg_table of memory mapped to the device and
+ * initialized with the resource page table in the above described format.
+ */
+struct nnpdev_mapping {
+	struct kref                 ref;
+	struct host_resource        *res;
+	struct device               *dev;
+	struct sg_table             *sgt;
+	struct sg_table             dma_chain_sgt;
+	unsigned int                dma_chain_order;
+	struct list_head            node;
+};
+
+/*
+ * Since host resources are pinned for their entire lifetime, it
+ * is useful to monitor the total size of NNP-I host resources
+ * allocated in the system.
+ */
+static size_t total_hostres_size;
+static DEFINE_MUTEX(total_size_mutex);
+
+/* Destroys host resource, when all references to it are released */
+static void release_hostres(struct kref *kref)
+{
+	struct host_resource *r = container_of(kref, struct host_resource, ref);
+
+	if (r->pinned_mm) {
+		unpin_user_pages(r->pages, r->n_pages);
+		account_locked_vm(r->pinned_mm, r->n_pages, false);
+		mmdrop(r->pinned_mm);
+	} else {
+		vfree(r->vptr);
+	}
+
+	kvfree(r->pages);
+	mutex_lock(&total_size_mutex);
+	total_hostres_size -= r->size;
+	mutex_unlock(&total_size_mutex);
+	kfree(r);
+}
+
+void nnp_hostres_get(struct host_resource *res)
+{
+	kref_get(&res->ref);
+};
+
+void nnp_hostres_put(struct host_resource *res)
+{
+	kref_put(&res->ref, release_hostres);
+}
+
+/* Really destroys mapping to device, when refcount is zero */
+static void release_mapping(struct kref *kref)
+{
+	struct nnpdev_mapping *m = container_of(kref, struct nnpdev_mapping, ref);
+
+	spin_lock(&m->res->lock);
+	list_del(&m->node);
+	spin_unlock(&m->res->lock);
+
+	dma_unmap_sgtable(m->dev, &m->dma_chain_sgt, DMA_TO_DEVICE, 0);
+	sgl_free_order(m->dma_chain_sgt.sgl, m->dma_chain_order);
+
+	dma_unmap_sg(m->dev, m->sgt->sgl, m->sgt->orig_nents, m->res->dir);
+	sg_free_table(m->sgt);
+	kfree(m->sgt);
+
+	nnp_hostres_put(m->res);
+
+	kfree(m);
+}
+
+static struct host_resource *alloc_hostres(size_t size, enum dma_data_direction dir)
+{
+	struct host_resource *r;
+
+	r = kzalloc(sizeof(*r), GFP_KERNEL);
+	if (!r)
+		return r;
+
+	kref_init(&r->ref);
+	spin_lock_init(&r->lock);
+	r->dir = dir;
+	r->size = size;
+	INIT_LIST_HEAD(&r->devices);
+
+	return r;
+}
+
+struct host_resource *nnp_hostres_alloc(size_t size, enum dma_data_direction dir)
+{
+	struct host_resource *r;
+	unsigned int i;
+	char *p;
+
+	if (size == 0 || dir == DMA_NONE)
+		return ERR_PTR(-EINVAL);
+
+	r = alloc_hostres(size, dir);
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	r->n_pages = PFN_UP(size);
+	r->vptr = vmalloc(r->n_pages * PAGE_SIZE);
+	if (!r->vptr)
+		goto free_res;
+
+	r->pages = kvmalloc_array(r->n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!r->pages)
+		goto free_vptr;
+
+	for (i = 0, p = r->vptr; i < r->n_pages; i++, p += PAGE_SIZE) {
+		r->pages[i] = vmalloc_to_page(p);
+		if (!r->pages[i])
+			goto free_pages;
+	}
+
+	mutex_lock(&total_size_mutex);
+	total_hostres_size += size;
+	mutex_unlock(&total_size_mutex);
+
+	return r;
+
+free_pages:
+	kvfree(r->pages);
+free_vptr:
+	vfree(r->vptr);
+free_res:
+	kfree(r);
+	return ERR_PTR(-ENOMEM);
+}
+
+struct host_resource *nnp_hostres_from_usermem(void __user *user_ptr, size_t size,
+					       enum dma_data_direction dir)
+{
+	/*
+	 * user_ptr is not being accessed, it is only used as parameter to
+	 * pin_user_pages(), so it is OK to remove the __user annotation.
+	 */
+	uintptr_t user_addr = (__force uintptr_t)user_ptr;
+	struct host_resource *r;
+	int err;
+	int gup_flags = 0;
+	int n, pinned;
+
+	if (size == 0 || dir == DMA_NONE)
+		return ERR_PTR(-EINVAL);
+
+	/* Restrict for 4 byte alignment */
+	if (user_addr & 0x3)
+		return ERR_PTR(-EINVAL);
+
+	if (!access_ok(user_ptr, size))
+		return ERR_PTR(-EFAULT);
+
+	r = alloc_hostres(size, dir);
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	r->start_offset = offset_in_page(user_addr);
+	user_addr &= PAGE_MASK;
+
+	r->n_pages = PFN_UP(size + r->start_offset);
+	r->pages = kvmalloc_array(r->n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!r->pages) {
+		err = -ENOMEM;
+		goto free_res;
+	}
+
+	err = account_locked_vm(current->mm, r->n_pages, true);
+	if (err)
+		goto free_pages;
+
+	if (nnp_hostres_is_input(r))
+		gup_flags = FOLL_WRITE;
+
+	/*
+	 * The host resource is being re-used for multiple DMA
+	 * transfers for streaming data into the device.
+	 * In most situations will live long term.
+	 */
+	gup_flags |= FOLL_LONGTERM;
+
+	for (pinned = 0; pinned < r->n_pages; pinned += n) {
+		n = pin_user_pages(user_addr + pinned * PAGE_SIZE,
+				   r->n_pages - pinned, gup_flags,
+				   &r->pages[pinned], NULL);
+		if (n < 0) {
+			err = -ENOMEM;
+			goto unaccount;
+		}
+	}
+
+	r->pinned_mm = current->mm;
+	mmgrab(r->pinned_mm);
+
+	mutex_lock(&total_size_mutex);
+	total_hostres_size += size;
+	mutex_unlock(&total_size_mutex);
+
+	return r;
+
+unaccount:
+	account_locked_vm(current->mm, r->n_pages, false);
+	unpin_user_pages(r->pages, pinned);
+free_pages:
+	kvfree(r->pages);
+free_res:
+	kfree(r);
+	return ERR_PTR(err);
+}
+
+/* Finds mapping by device and increase its refcount. NULL if not found */
+static struct nnpdev_mapping *get_mapping_for_dev(struct host_resource *res,
+						  struct device *dev)
+{
+	struct nnpdev_mapping *m;
+
+	spin_lock(&res->lock);
+
+	list_for_each_entry(m, &res->devices, node) {
+		if (m->dev == dev) {
+			kref_get(&m->ref);
+			goto out;
+		}
+	}
+
+	m = NULL;
+out:
+	spin_unlock(&res->lock);
+	return m;
+}
+
+static bool entry_valid(struct scatterlist *sgl, u64 ipc_entry)
+{
+	unsigned long long dma_pfn;
+	unsigned long n_pages;
+
+	dma_pfn = FIELD_GET(DMA_CHAIN_ENTRY_PFN_MASK, ipc_entry);
+	if (NNP_IPC_DMA_PFN_TO_ADDR(dma_pfn) != sg_dma_address(sgl))
+		return false;
+
+	n_pages = FIELD_GET(DMA_CHAIN_ENTRY_NPAGES_MASK, ipc_entry);
+	if (n_pages != DIV_ROUND_UP(sg_dma_len(sgl), NNP_PAGE_SIZE))
+		return false;
+
+	return true;
+}
+
+/**
+ * build_ipc_dma_chain_array() - builds page list of the resource for IPC usage
+ * @m: pointer to device mapping info struct
+ * @use_one_entry: if true will generate all page table in one continuous
+ *                 DMA chunk. otherwise a chain of blocks will be used
+ *                 each of one page size.
+ * @start_offset: offset in first mapped page where resource memory starts,
+ *
+ * This function allocates scatterlist, map it to device and populate it with
+ * page table of the device mapped resource in format suitable to be used
+ * in the IPC protocol for sending the resource page table to the card.
+ * The format of the page table is described in the documentation of &struct
+ * nnpdev_mapping.
+ *
+ * Return: 0 on success, error value otherwise
+ */
+static int build_ipc_dma_chain_array(struct nnpdev_mapping *m, bool use_one_entry,
+				     unsigned int start_offset)
+{
+	unsigned int i, k = 0;
+	u64 *p = NULL;
+	u64 e;
+	unsigned long long dma_addr, dma_pfn, size;
+	struct nnp_dma_chain_header *h;
+	struct scatterlist *sg, *map_sg;
+	struct scatterlist *chain_sg;
+	unsigned long n_pages;
+	unsigned int chain_size;
+	unsigned int chain_order;
+	unsigned int chain_nents;
+	unsigned int nents_per_entry;
+	unsigned int start_off = start_offset;
+	int rc;
+
+	if (use_one_entry) {
+		/*
+		 * Allocate enough pages in one chunk that will fit
+		 * the header and nnp_dma_chain_entry for all the sg_table
+		 * entries.
+		 */
+		nents_per_entry = m->sgt->nents;
+		chain_size = sizeof(struct nnp_dma_chain_header) +
+			     m->sgt->nents * DMA_CHAIN_ENTRY_SIZE;
+		chain_order = get_order(chain_size);
+	} else {
+		/*
+		 * Calc number of one page DMA buffers needed to hold the
+		 * entire page table.
+		 * NENTS_PER_PAGE is how much DMA chain entries fits
+		 * in a single page following the chain header, must be at
+		 * positive.
+		 */
+		nents_per_entry = NENTS_PER_PAGE;
+		chain_size = DIV_ROUND_UP(m->sgt->nents, nents_per_entry) *
+			     NNP_PAGE_SIZE;
+		chain_order = 0;
+	}
+
+	chain_sg = sgl_alloc_order(chain_size, chain_order, false, GFP_KERNEL,
+				   &chain_nents);
+	if (!chain_sg)
+		return -ENOMEM;
+
+	m->dma_chain_sgt.sgl = chain_sg;
+	m->dma_chain_sgt.nents = chain_nents;
+	m->dma_chain_sgt.orig_nents = chain_nents;
+	m->dma_chain_order = chain_order;
+	rc = dma_map_sgtable(m->dev, &m->dma_chain_sgt, DMA_TO_DEVICE, 0);
+	if (rc)
+		goto free_chain_sg;
+
+	/* Initialize chain entry blocks */
+	map_sg = m->sgt->sgl;
+	for_each_sg(chain_sg, sg, chain_nents, i) {
+		/*
+		 * Check that the allocated DMA address fits in IPC protocol.
+		 * In the protocol, DMA addresses are sent as 4K page numbers
+		 * and must fit in 45 bits.
+		 * Meaning, if the DMA address is larger than 57 bits it will
+		 * not fit.
+		 */
+		if (sg_dma_address(sg) > NNP_IPC_DMA_MAX_ADDR)
+			goto unmap_chain_sg;
+
+		/* h: points to the header of current block */
+		h = sg_virt(sg);
+
+		/* p: points to current chunk entry in block */
+		p = (u64 *)(h + 1);
+
+		size = 0;
+		for (k = 0; k < nents_per_entry && map_sg; ++k) {
+			/*
+			 * Build entry with DMA address as page number and
+			 * size in pages
+			 */
+			dma_addr = sg_dma_address(map_sg);
+			dma_pfn = NNP_IPC_DMA_ADDR_TO_PFN(dma_addr);
+			n_pages = DIV_ROUND_UP(sg_dma_len(map_sg), NNP_PAGE_SIZE);
+
+			e = FIELD_PREP(DMA_CHAIN_ENTRY_PFN_MASK, dma_pfn);
+			e |= FIELD_PREP(DMA_CHAIN_ENTRY_NPAGES_MASK, n_pages);
+
+			/*
+			 * Check that packed entry matches the DMA chunk.
+			 * (Will fail if either dma_pfn or n_pages fields overflows)
+			 */
+			if (!entry_valid(map_sg, e))
+				goto unmap_chain_sg;
+
+			/* Fill entry value (should be 64-bit little-endian) */
+			p[k] = cpu_to_le64(e);
+
+			size += sg_dma_len(map_sg);
+
+			map_sg = sg_next(map_sg);
+		}
+
+		/* Initialize block header and link to next block */
+		h->total_nents = cpu_to_le32(m->sgt->nents);
+		h->start_offset = cpu_to_le32(start_off);
+		h->size = cpu_to_le64(size);
+		if (sg_next(sg))
+			h->dma_next = cpu_to_le64(sg_dma_address(sg_next(sg)));
+		else
+			h->dma_next = 0;
+		start_off = 0;
+	}
+
+	return 0;
+
+unmap_chain_sg:
+	dma_unmap_sgtable(m->dev, &m->dma_chain_sgt, DMA_TO_DEVICE, 0);
+free_chain_sg:
+	sgl_free_order(chain_sg, chain_order);
+	memset(&m->dma_chain_sgt, 0, sizeof(m->dma_chain_sgt));
+	return -ENOMEM;
+}
+
+struct nnpdev_mapping *nnp_hostres_map_device(struct host_resource *res,
+					      struct nnp_device *nnpdev,
+					      bool use_one_entry,
+					      dma_addr_t *page_list,
+					      u32 *total_chunks)
+{
+	int ret;
+	struct nnpdev_mapping *m;
+	struct scatterlist *sge;
+
+	if (!res || !nnpdev || !page_list)
+		return ERR_PTR(-EINVAL);
+
+	/* Check if already mapped for the device */
+	m = get_mapping_for_dev(res, nnpdev->dev);
+	if (m)
+		goto done;
+
+	nnp_hostres_get(res);
+
+	m = kmalloc(sizeof(*m), GFP_KERNEL);
+	if (!m) {
+		ret = -ENOMEM;
+		goto put_resource;
+	}
+
+	kref_init(&m->ref);
+
+	m->dev = nnpdev->dev;
+	m->res = res;
+
+	m->sgt = kmalloc(sizeof(*m->sgt), GFP_KERNEL);
+	if (!m->sgt) {
+		ret = -ENOMEM;
+		goto free_mapping;
+	}
+
+	sge = __sg_alloc_table_from_pages(m->sgt, res->pages, res->n_pages, 0,
+					  res->size + res->start_offset,
+					  NNP_MAX_CHUNK_SIZE, NULL, 0, GFP_KERNEL);
+	if (IS_ERR(sge)) {
+		ret = PTR_ERR(sge);
+		goto free_sgt_struct;
+	}
+
+	ret = dma_map_sg(m->dev, m->sgt->sgl, m->sgt->orig_nents, res->dir);
+	if (ret <= 0) {
+		/* dma_map_sg returns 0 on error with no error value */
+		ret = -ENOMEM;
+		goto free_sgt;
+	}
+
+	m->sgt->nents = ret;
+
+	ret = build_ipc_dma_chain_array(m, use_one_entry, res->start_offset);
+	if (ret < 0)
+		goto unmap;
+
+	spin_lock(&res->lock);
+	list_add(&m->node, &res->devices);
+	spin_unlock(&res->lock);
+
+done:
+	*page_list = sg_dma_address(m->dma_chain_sgt.sgl);
+	if (total_chunks)
+		*total_chunks = m->sgt->nents;
+
+	return m;
+
+unmap:
+	dma_unmap_sg(m->dev, m->sgt->sgl, m->sgt->orig_nents, res->dir);
+free_sgt:
+	sg_free_table(m->sgt);
+free_sgt_struct:
+	kfree(m->sgt);
+free_mapping:
+	kfree(m);
+put_resource:
+	nnp_hostres_put(res);
+	return ERR_PTR(ret);
+}
+
+void nnp_hostres_unmap_device(struct nnpdev_mapping *mapping)
+{
+	kref_put(&mapping->ref, release_mapping);
+}
+
+int nnp_hostres_user_lock(struct host_resource *res)
+{
+	struct nnpdev_mapping *m;
+
+	spin_lock(&res->lock);
+	list_for_each_entry(m, &res->devices, node)
+		dma_sync_sg_for_cpu(m->dev, m->sgt->sgl, m->sgt->orig_nents, res->dir);
+	spin_unlock(&res->lock);
+
+	return 0;
+}
+
+int nnp_hostres_user_unlock(struct host_resource *res)
+{
+	struct nnpdev_mapping *m;
+
+	spin_lock(&res->lock);
+	list_for_each_entry(m, &res->devices, node)
+		dma_sync_sg_for_device(m->dev, m->sgt->sgl, m->sgt->orig_nents,
+				       res->dir);
+	spin_unlock(&res->lock);
+
+	return 0;
+}
+
+bool nnp_hostres_is_input(struct host_resource *res)
+{
+	return res->dir == DMA_TO_DEVICE || res->dir == DMA_BIDIRECTIONAL;
+}
+
+bool nnp_hostres_is_output(struct host_resource *res)
+{
+	return res->dir == DMA_FROM_DEVICE || res->dir == DMA_BIDIRECTIONAL;
+}
+
+size_t nnp_hostres_size(struct host_resource *res)
+{
+	return res->size;
+}
+
+void *nnp_hostres_vptr(struct host_resource *res)
+{
+	return res->vptr;
+}
+
+static ssize_t total_hostres_size_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&total_size_mutex);
+	ret = sysfs_emit(buf, "%zu\n", total_hostres_size);
+	mutex_unlock(&total_size_mutex);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(total_hostres_size);
+
+static struct attribute *nnp_host_attrs[] = {
+	&dev_attr_total_hostres_size.attr,
+	NULL
+};
+
+static struct attribute_group nnp_host_attrs_grp = {
+	.attrs = nnp_host_attrs,
+};
+
+int nnp_hostres_init_sysfs(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &nnp_host_attrs_grp);
+}
+
+void nnp_hostres_fini_sysfs(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &nnp_host_attrs_grp);
+}
diff --git a/drivers/misc/intel-nnpi/hostres.h b/drivers/misc/intel-nnpi/hostres.h
new file mode 100644
index 0000000..6397c73
--- /dev/null
+++ b/drivers/misc/intel-nnpi/hostres.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNPDRV_HOSTRES_H
+#define _NNPDRV_HOSTRES_H
+
+#include <linux/dma-mapping.h>
+#include "device.h"
+
+/**
+ * nnp_hostres_alloc() - allocate memory and create host resource
+ * @size: Size of the host resource to be created
+ * @dir:  Resource direction (read or write or both)
+ *
+ * This function allocates memory pages and provides host resource handle.
+ * The memory is mapped to kernel virtual address.
+ * The resource can be Input(read by device), Output(write by device) and both.
+ *
+ * The return handle can be used as argument to one of the other nnpi_hostres*
+ * functions for:
+ *    - mapping/unmapping the resource for NNP-I device.
+ *    - pointer to the allocated memory can be retrieved by nnp_hostres_vptr()
+ *
+ * The handle should be released when no longer needed by a call to
+ * nnp_hostres_put.
+ *
+ * Return: pointer to created resource or error value
+ */
+struct host_resource *nnp_hostres_alloc(size_t size, enum dma_data_direction dir);
+
+/**
+ * nnp_hostres_from_usermem() - Creates host resource from user-space memory
+ * @user_ptr: user virtual memory to pin
+ * @size: size of user buffer to pin
+ * @dir: Resource direction (read or write or both)
+ *
+ * This function pins the provided user memory and create a host resource
+ * handle managing this memory.
+ * The provided handle can be used the same as the handle created by
+ * nnp_hostres_alloc.
+ * The resource can be Input(read by device), Output(write by device) and both.
+ *
+ * The handle should be released when no longer needed by a call to
+ * nnp_hostres_put.
+ *
+ * Return: pointer to created resource or error value
+ */
+struct host_resource *nnp_hostres_from_usermem(void __user *user_ptr, size_t size,
+					       enum dma_data_direction dir);
+
+/**
+ * nnp_hostres_map_device() - Maps the host resource to NNP-I device
+ * @res: handle to host resource
+ * @nnpdev: handle to nnp device struct
+ * @use_one_entry: when true will produce ipc dma chain page table descriptor
+ *                 of the mapping in a single concurrent dma block.
+ *                 otherwise a chain of multiple blocks might be generated.
+ * @page_list: returns the dma address of the ipc dma chain page table
+ *             descriptor.
+ * @total_chunks: returns the total number of elements in the mapping's
+ *                sg_table. Can be NULL if this info is not required.
+ *
+ * This function maps the host resource to be accessible from device
+ * and returns the dma page list of DMA addresses packed in format
+ * suitable to be used in IPC protocol to be sent to the card.
+ *
+ * The resource can be mapped to multiple devices.
+ *
+ * Return: pointer to the mapping object or error on failure.
+ */
+struct nnpdev_mapping *nnp_hostres_map_device(struct host_resource *res,
+					      struct nnp_device *nnpdev,
+					      bool use_one_entry,
+					      dma_addr_t *page_list,
+					      u32 *total_chunks);
+
+/**
+ * nnp_hostres_unmap_device() - Unmaps the host resource from NNP-I device
+ * @mapping: mapping pointer, returned from nnp_hostres_map_device
+ *
+ * This function unmaps previously mapped host resource from device.
+ */
+void nnp_hostres_unmap_device(struct nnpdev_mapping *mapping);
+
+/**
+ * nnp_hostres_user_lock() - Lock the host resource to access from userspace
+ * @res: handle to host resource
+ *
+ * This function should be called before user-space application is accessing
+ * the host resource content (either for read or write). The function
+ * invalidates  or flashes the cpu caches when necessary.
+ * The function does *not* impose any synchronization between application and
+ * device accesses to the resource memory. Such synchronization is handled
+ * in user-space.
+ *
+ * Return: error on failure.
+ */
+int nnp_hostres_user_lock(struct host_resource *res);
+
+/**
+ * nnp_hostres_user_unlock() - Unlocks the host resource from userspace access
+ * @res: handle to host resource
+ *
+ * This function should be called after user-space application is finished
+ * accessing the host resource content (either for read or write). The function
+ * invalidates  or flashes the cpu caches when necessary.
+ *
+ * Return: error on failure.
+ */
+int nnp_hostres_user_unlock(struct host_resource *res);
+
+/**
+ * nnp_hostres_get() - Increases refcount of the hostres
+ * @res: handle to host resource
+ *
+ * This function increases refcount of the host resource.
+ */
+void nnp_hostres_get(struct host_resource *res);
+
+/**
+ * nnp_hostres_put() - Decreases refcount of the hostres
+ * @res: handle to host resource
+ *
+ * This function decreases refcount of the host resource and destroys it
+ * when it reaches 0.
+ */
+void nnp_hostres_put(struct host_resource *res);
+
+/**
+ * nnp_hostres_is_input() - Returns if the host resource is input resource
+ * @res: handle to host resource
+ *
+ * This function returns true if the host resource can be read by device.
+ * The "input" terminology is used here since such resources are usually
+ * used as inputs to device inference network.
+ *
+ * Return: true if the reasource is readable.
+ */
+bool nnp_hostres_is_input(struct host_resource *res);
+
+/**
+ * nnp_hostres_is_output() - Returns if the host resource is output resource
+ * @res: handle to host resource
+ *
+ * This function returns true if the host resource can be modified by device.
+ * The term "output" is used here since usually such resources are used for
+ * outputs of device inference network.
+ *
+ * Return: true if the reasource is writable.
+ */
+bool nnp_hostres_is_output(struct host_resource *res);
+
+size_t nnp_hostres_size(struct host_resource *res);
+
+/**
+ * nnp_hostres_vptr() - returns the virtual pointer to the resource buffer
+ * @res: handle to host resource
+ *
+ * Return: pointer to resource data or NULL if was not allocated by
+ * nnp_hostres_alloc()
+ */
+void *nnp_hostres_vptr(struct host_resource *res);
+
+int nnp_hostres_init_sysfs(struct device *dev);
+void nnp_hostres_fini_sysfs(struct device *dev);
+
+#endif
-- 
1.8.3.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

