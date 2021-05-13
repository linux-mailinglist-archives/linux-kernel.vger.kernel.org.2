Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBB37F645
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhEMLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:04:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:45138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233005AbhEMLCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:45 -0400
IronPort-SDR: gsgjK1e+Alj0hiVeqIOnhJ9G0RP3ZxJox2DpQmBJJkHXWD4EDQigf0iPRr1/E6ljh2dbkBZZ3f
 7i3oNh823nuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048318"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:15 -0700
IronPort-SDR: WDqL5pUq6oEQTnbtMHQdbvwmFOPdhRIUPvy5Gyb0dFIb8pJRacW5Cc8W0j7xpZyZ1Akdq18xpV
 CHbmkAv1GTcw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984102"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:13 -0700
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
Subject: [PATCH v3 08/14] intel_gna: implement scoring
Date:   Thu, 13 May 2021 13:00:34 +0200
Message-Id: <20210513110040.2268-9-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/intel/gna/Kbuild   |   2 +-
 drivers/misc/intel/gna/device.c |   3 +
 drivers/misc/intel/gna/device.h |   5 +
 drivers/misc/intel/gna/score.c  | 291 ++++++++++++++++++++++++++++++++
 drivers/misc/intel/gna/score.h  |  17 ++
 include/uapi/misc/intel/gna.h   |   4 +
 6 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/score.c
 create mode 100644 drivers/misc/intel/gna/score.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 81d8da8f24aa..38ff97360ed8 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := device.o hw.o mem.o pci.o request.o
+intel_gna-y := device.o hw.o mem.o pci.o request.o score.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 375342c3c140..c8a127cc3039 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -82,6 +82,9 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 
 	mutex_init(&gna_priv->memidr_lock);
 
+	mutex_init(&gna_priv->flist_lock);
+	INIT_LIST_HEAD(&gna_priv->file_list);
+
 	atomic_set(&gna_priv->request_count, 0);
 
 	mutex_init(&gna_priv->reqlist_lock);
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index 6345295ea589..e879ac045928 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -30,6 +30,11 @@ struct gna_file_private {
 };
 
 struct gna_private {
+	/* list of opened files */
+	struct list_head file_list;
+	/* protects file_list */
+	struct mutex flist_lock;
+
 	int index;
 
 	int recovery_timeout_jiffies;
diff --git a/drivers/misc/intel/gna/score.c b/drivers/misc/intel/gna/score.c
new file mode 100644
index 000000000000..a3be0d62393a
--- /dev/null
+++ b/drivers/misc/intel/gna/score.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "device.h"
+#include "mem.h"
+#include "request.h"
+#include "score.h"
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
+		dev_err(gna_dev(gna_priv), "invalid mode\n");
+		return -EINVAL;
+	}
+
+	if (compute_cfg->layer_count > gna_priv->info.max_layer_count) {
+		dev_err(gna_dev(gna_priv), "max layer count exceeded\n");
+		return -EINVAL;
+	}
+
+	if (compute_cfg->buffer_count == 0) {
+		dev_err(gna_dev(gna_priv), "no buffers\n");
+		return -EINVAL;
+	}
+
+	buffers_size = sizeof(struct gna_buffer) * compute_cfg->buffer_count;
+	if (!access_ok(u64_to_user_ptr(compute_cfg->buffers_ptr), buffers_size)) {
+		dev_err(gna_dev(gna_priv), "invalid buffers pointer\n");
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
+	dev_dbg(gna_dev(gna_priv), "patch offset: %llu, size: %zu, value: %llu\n",
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
+	dev_dbg(gna_dev(gna_priv), "memory_id: %llu, patch_count, %llu\n",
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
+		dev_dbg(gna_dev(gna_priv), "buffer not found\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&gna_priv->memidr_lock);
+	mo = idr_find(&gna_priv->memory_idr, buffer->memory_id);
+	mutex_unlock(&gna_priv->memidr_lock);
+	if (!mo) {
+		dev_dbg(gna_dev(gna_priv), "memory object not found\n");
+		return -EFAULT;
+	}
+
+	vaddr = vm_map_ram(mo->pages, mo->num_pinned, 0);
+	if (!vaddr) {
+		dev_dbg(gna_dev(gna_priv), "mapping failed\n");
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
+	dev_dbg(gna_dev(gna_priv), "buffer count: %llu\n", buffer_count);
+	for (i = 0; i < buffer_count; i++, buffer++) {
+		dev_dbg(gna_dev(gna_priv), "patch count: %llu\n", buffer->patch_count);
+		ret = gna_mem_patch_memory(gna_priv, buffer);
+		if (ret)
+			goto err_put_pages;
+	}
+
+	switch (compute_cfg->gna_mode) {
+	case GNA_MODE_XNN:
+		dev_dbg(gna_dev(gna_priv), "xNN mode, labase: %d, lacount: %d\n",
+			compute_cfg->layer_base, compute_cfg->layer_count);
+		xnn_config->labase = compute_cfg->layer_base;
+		xnn_config->lacount = compute_cfg->layer_count;
+		break;
+	case GNA_MODE_GMM:
+		dev_dbg(gna_dev(gna_priv), "GMM mode, offset: %d\n", compute_cfg->layer_base);
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
+	desc_base = (u32)(mmu->hwdesc_dma >> PAGE_SHIFT);
+	gna_reg_write(gna_priv, GNA_MMIO_DESBASE, desc_base);
+
+	gna_start_scoring(gna_priv, compute_cfg);
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
+			dev_warn(gna_dev(gna_priv), "memory object not found %llu\n",
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
diff --git a/drivers/misc/intel/gna/score.h b/drivers/misc/intel/gna/score.h
new file mode 100644
index 000000000000..28aeab33e452
--- /dev/null
+++ b/drivers/misc/intel/gna/score.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_SCORE_H__
+#define __GNA_SCORE_H__
+
+struct gna_file_private;
+struct gna_compute_cfg;
+struct gna_private;
+struct gna_request;
+
+int gna_validate_score_config(struct gna_compute_cfg *compute_cfg,
+			struct gna_file_private *file_priv);
+
+int gna_score(struct gna_request *score_request);
+
+#endif // __GNA_SCORE_H__
diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
index 473ce569d146..b531beb35bd9 100644
--- a/include/uapi/misc/intel/gna.h
+++ b/include/uapi/misc/intel/gna.h
@@ -10,6 +10,10 @@ extern "C" {
 
 #include <linux/types.h>
 
+/* Operation modes */
+#define GNA_MODE_GMM	0
+#define GNA_MODE_XNN	1
+
 #define GNA_STS_SCORE_COMPLETED		_BITUL(0)
 #define GNA_STS_STATISTICS_VALID	_BITUL(3)
 #define GNA_STS_PCI_MMU_ERR		_BITUL(4)
-- 
2.28.0

