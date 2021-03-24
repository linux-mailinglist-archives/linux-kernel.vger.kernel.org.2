Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B673480C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhCXSjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:17741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237669AbhCXSii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:38 -0400
IronPort-SDR: Wbvjx5R0ymgRc2FfLBE1OIBtqoFqxhcotbCqBzay6HUyXYMeUm8e3hClwBmKexCvFOtJk7LknL
 MlGl/BIy/Lsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859528"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859528"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:38 -0700
IronPort-SDR: pazEDFo0UTsJlT1vO/CdLm6zh7QPZbFujMapjVGs0mlxfK0wCJH5K7rdo8PQOFtuQSyftWzV1S
 J9unV1iKC1Qw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203842"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:35 -0700
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
Subject: [PATCH v2 08/13] intel_gna: implement scoring
Date:   Wed, 24 Mar 2021 19:36:05 +0100
Message-Id: <20210324183610.4574-9-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Add a new component for scoring logic such as configuring and kicking
off the hardware.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/Kbuild       |   2 +-
 drivers/misc/intel/gna/gna_device.c |   3 +
 drivers/misc/intel/gna/gna_device.h |   5 +
 drivers/misc/intel/gna/gna_score.c  | 298 ++++++++++++++++++++++++++++
 drivers/misc/intel/gna/gna_score.h  |  18 ++
 5 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/gna_score.c
 create mode 100644 drivers/misc/intel/gna/gna_score.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 5dbbd3f0a543..9dac467839c9 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := gna_device.o gna_driver.o gna_mem.o gna_request.o gna_hw.o
+intel_gna-y := gna_device.o gna_driver.o gna_mem.o gna_request.o gna_score.o gna_hw.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index 14ce24fd18ff..e1a1f3142684 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -119,6 +119,9 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	idr_init(&gna_priv->memory_idr);
 	mutex_init(&gna_priv->memidr_lock);
 
+	mutex_init(&gna_priv->flist_lock);
+	INIT_LIST_HEAD(&gna_priv->file_list);
+
 	atomic_set(&gna_priv->request_count, 0);
 
 	mutex_init(&gna_priv->reqlist_lock);
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index b54d0ea9b9ef..878a972ab5b3 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -33,6 +33,11 @@ struct gna_hw_info {
 struct gna_private {
 	struct gna_driver_private *drv_priv;
 
+	/* list of opened files */
+	struct list_head file_list;
+	/* protects file_list */
+	struct mutex flist_lock;
+
 	struct pci_dev *pdev;
 	/* pdev->dev */
 	struct device *parent;
diff --git a/drivers/misc/intel/gna/gna_score.c b/drivers/misc/intel/gna/gna_score.c
new file mode 100644
index 000000000000..794039d2da43
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_score.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+#include "gna_request.h"
+#include "gna_score.h"
+
+int gna_validate_score_config(struct gna_compute_cfg *compute_cfg,
+			      struct gna_file_private *file_priv)
+{
+	struct gna_private *gna_priv;
+	size_t buffers_size;
+
+	gna_priv = file_priv->gna_priv;
+
+	if (compute_cfg->gna_mode > GNA_MODE_XNN) {
+		dev_err(&gna_priv->pdev->dev, "invalid mode\n");
+		return -EINVAL;
+	}
+
+	if (compute_cfg->layer_count > gna_priv->info.max_layer_count) {
+		dev_err(&gna_priv->pdev->dev, "max layer count exceeded\n");
+		return -EINVAL;
+	}
+
+	if (compute_cfg->buffer_count == 0) {
+		dev_err(&gna_priv->pdev->dev, "no buffers\n");
+		return -EINVAL;
+	}
+
+	buffers_size = sizeof(struct gna_buffer) * compute_cfg->buffer_count;
+	if (!access_ok(u64_to_user_ptr(compute_cfg->buffers_ptr), buffers_size)) {
+		dev_err(&gna_priv->pdev->dev, "invalid buffers pointer\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gna_do_patch_memory(struct gna_private *gna_priv, struct gna_memory_object *mo,
+			       struct gna_memory_patch *patch, void *vaddr)
+{
+	size_t size;
+	void *dest;
+	u64 value;
+
+	value = patch->value;
+	size = patch->size;
+	dest = (u8 *)vaddr + patch->offset;
+	dev_dbg(&gna_priv->pdev->dev, "patch offset: %llu, size: %zu, value: %llu\n",
+		patch->offset, size, value);
+
+	switch (size) {
+	case 0:
+		return -EFAULT;
+	case sizeof(u8):
+		*((u8 *)dest) = (u8)value;
+		break;
+	case sizeof(u16):
+		*((u16 *)dest) = (u16)value;
+		break;
+	case sizeof(u32):
+		*((u32 *)dest) = (u32)value;
+		break;
+	case sizeof(u64):
+		*((u64 *)dest) = (u64)value;
+		break;
+	default:
+		// should never happen
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gna_mem_patch_memory(struct gna_private *gna_priv, struct gna_buffer *buffer)
+{
+	struct gna_memory_patch *patch;
+	struct gna_memory_object *mo;
+	void *vaddr;
+	int ret = 0;
+	u32 i;
+
+	dev_dbg(&gna_priv->pdev->dev, "memory_id: %llu, patch_count, %llu\n",
+		buffer->memory_id, buffer->patch_count);
+
+	mutex_lock(&gna_priv->memidr_lock);
+	mo = idr_find(&gna_priv->memory_idr, buffer->memory_id);
+	mutex_unlock(&gna_priv->memidr_lock);
+	if (!mo)
+		return -EINVAL;
+
+	mutex_lock(&mo->page_lock);
+	ret = mo->ops->get_pages(mo, buffer->offset, buffer->size);
+	mutex_unlock(&mo->page_lock);
+	if (ret)
+		return ret;
+
+	if (buffer->patch_count) {
+		vaddr = vm_map_ram(mo->pages, mo->num_pinned, 0);
+		if (!vaddr)
+			return -ENOMEM;
+
+		patch = (struct gna_memory_patch *)(uintptr_t)buffer->patches_ptr;
+		for (i = 0; i < buffer->patch_count; i++, patch++) {
+			ret = gna_do_patch_memory(gna_priv, mo, patch, vaddr + buffer->offset);
+			if (ret)
+				break;
+		}
+
+		kvfree((void *)(uintptr_t)buffer->patches_ptr);
+		buffer->patches_ptr = 0;
+		vm_unmap_ram(vaddr, mo->num_pages);
+
+		if (ret)
+			return ret;
+	}
+
+	gna_mmu_add(gna_priv, mo);
+
+	return ret;
+}
+
+static struct gna_buffer *gna_find_buffer(struct gna_buffer *buffer_list, u32 buffer_count,
+					  u32 mmu_offset, u32 *memory_offset)
+{
+	struct gna_buffer *buffer;
+	u32 page_offset;
+	u32 memory_size;
+	u32 offset;
+	u32 i;
+
+	offset = 0;
+	for (i = 0; i < buffer_count; i++) {
+		buffer = buffer_list + i;
+		page_offset = buffer->offset & ~PAGE_MASK;
+		memory_size = round_up(page_offset + buffer->size, PAGE_SIZE);
+		if (mmu_offset < offset + memory_size) {
+			*memory_offset = offset;
+			return buffer;
+		}
+		offset += memory_size;
+	}
+
+	return NULL;
+}
+
+static int gna_copy_gmm_config(struct gna_private *gna_priv,
+			       struct gna_buffer *buffer_list,
+			       u32 buffer_count, u32 mmu_offset)
+{
+	struct gna_hw_descriptor *hwdesc;
+	struct gna_memory_object *mo;
+	struct gna_mmu_object *mmu;
+	struct gna_buffer *buffer;
+	u32 memory_offset;
+	u32 skip_offset;
+	u8 *gmm_desc;
+	void *vaddr;
+
+	mmu = &gna_priv->mmu;
+	hwdesc = mmu->hwdesc;
+
+	buffer = gna_find_buffer(buffer_list, buffer_count, mmu_offset, &memory_offset);
+	if (!buffer) {
+		dev_dbg(&gna_priv->pdev->dev, "buffer not found\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&gna_priv->memidr_lock);
+	mo = idr_find(&gna_priv->memory_idr, buffer->memory_id);
+	mutex_unlock(&gna_priv->memidr_lock);
+	if (!mo) {
+		dev_dbg(&gna_priv->pdev->dev, "memory object not found\n");
+		return -EFAULT;
+	}
+
+	vaddr = vm_map_ram(mo->pages, mo->num_pinned, 0);
+	if (!vaddr) {
+		dev_dbg(&gna_priv->pdev->dev, "mapping failed\n");
+		return -EFAULT;
+	}
+
+	skip_offset = round_down(buffer->offset, PAGE_SIZE);
+	gmm_desc = (u8 *)vaddr + skip_offset + (mmu_offset - memory_offset);
+	memcpy(&hwdesc->xnn_config, gmm_desc, sizeof(struct gna_xnn_descriptor));
+	vm_unmap_ram(vaddr, mo->num_pages);
+
+	return 0;
+}
+
+int gna_score(struct gna_request *score_request)
+{
+	struct gna_xnn_descriptor *xnn_config;
+	struct gna_compute_cfg *compute_cfg;
+	struct gna_private *gna_priv;
+	struct gna_memory_object *mo;
+	struct gna_mmu_object *mmu;
+	struct gna_buffer *buffer;
+	bool mo_valid = true;
+	void __iomem *addr;
+	u64 buffer_count;
+	u32 desc_base;
+	int ret;
+	u64 i;
+
+	ret = 0;
+
+	gna_priv = score_request->gna_priv;
+
+	mmu = &gna_priv->mmu;
+	xnn_config = &mmu->hwdesc->xnn_config;
+	compute_cfg = &score_request->compute_cfg;
+
+	buffer = score_request->buffer_list;
+	buffer_count = score_request->buffer_count;
+	dev_dbg(&gna_priv->pdev->dev, "buffer count: %llu\n", buffer_count);
+	for (i = 0; i < buffer_count; i++, buffer++) {
+		dev_dbg(&gna_priv->pdev->dev, "patch count: %llu\n", buffer->patch_count);
+		ret = gna_mem_patch_memory(gna_priv, buffer);
+		if (ret)
+			goto err_put_pages;
+	}
+
+	switch (compute_cfg->gna_mode) {
+	case GNA_MODE_XNN:
+		dev_dbg(&gna_priv->pdev->dev, "xNN mode, labase: %d, lacount: %d\n",
+			compute_cfg->layer_base, compute_cfg->layer_count);
+		xnn_config->labase = compute_cfg->layer_base;
+		xnn_config->lacount = compute_cfg->layer_count;
+		break;
+	case GNA_MODE_GMM:
+		dev_dbg(&gna_priv->pdev->dev, "GMM mode, offset: %d\n", compute_cfg->layer_base);
+		ret = gna_copy_gmm_config(gna_priv, score_request->buffer_list,
+					  buffer_count, compute_cfg->layer_base);
+		if (ret)
+			goto err_put_pages_decr;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_put_pages_decr;
+	}
+
+	addr = gna_priv->bar0_base;
+	desc_base = (u32)(mmu->hwdesc_dma >> PAGE_SHIFT);
+	gna_reg_write(addr, GNA_MMIO_DESBASE, desc_base);
+
+	gna_start_scoring(gna_priv, addr, compute_cfg);
+
+	return 0;
+
+err_put_pages_decr:
+	i--;
+	buffer--;
+err_put_pages:
+	do {
+		mutex_lock(&gna_priv->memidr_lock);
+		mo = idr_find(&gna_priv->memory_idr, buffer->memory_id);
+		mutex_unlock(&gna_priv->memidr_lock);
+		if (mo) {
+			mutex_lock(&mo->page_lock);
+			mo->ops->put_pages(mo);
+			mutex_unlock(&mo->page_lock);
+		} else {
+			mo_valid = false;
+			dev_warn(&gna_priv->pdev->dev, "memory object not found %llu\n",
+				 buffer->memory_id);
+		}
+		buffer--;
+	} while (i--);
+
+	if (mo_valid) {
+		i = score_request->buffer_count;
+		while (i--)
+			kvfree((void *)(uintptr_t)score_request->buffer_list[i].patches_ptr);
+		kvfree(score_request->buffer_list);
+	}
+	score_request->buffer_list = NULL;
+	score_request->buffer_count = 0;
+
+	return ret;
+}
diff --git a/drivers/misc/intel/gna/gna_score.h b/drivers/misc/intel/gna/gna_score.h
new file mode 100644
index 000000000000..056cf02586f9
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_score.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_SCORE_H__
+#define __GNA_SCORE_H__
+
+#include <uapi/misc/intel/gna.h>
+
+struct gna_private;
+struct gna_file_private;
+struct gna_request;
+
+int gna_validate_score_config(struct gna_compute_cfg *compute_cfg,
+			struct gna_file_private *file_priv);
+
+int gna_score(struct gna_request *score_request);
+
+#endif // __GNA_SCORE_H__
-- 
2.28.0

