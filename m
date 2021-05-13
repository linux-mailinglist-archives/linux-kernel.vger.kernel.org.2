Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B430A37F644
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhEMLEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:04:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:45141 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhEMLC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:28 -0400
IronPort-SDR: b+VxtAKi3NWZTLRMiw4/oGLFOeAoj+621UFBLnOiAPvy57jVUYeO2VfoX7s1MzJU9mnx6PvfrN
 9EtDW1Ipyy8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048308"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048308"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:13 -0700
IronPort-SDR: jPkj0IcD3ck8UmkIdru39vkC8gFTZFg7lSVW8NVoBO3VUxd6kpGrTjyNrXCBp0Ai+6IdPdiXOT
 a/SxFsBmIMnw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984075"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:10 -0700
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
        Anisha Dattatraya Kulkarni 
        <anisha.dattatraya.kulkarni@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v3 07/14] intel_gna: add request component
Date:   Thu, 13 May 2021 13:00:33 +0200
Message-Id: <20210513110040.2268-8-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

The scoring work submitted to the GNA driver is implemented as a
list of requests that will be processed by the hardware.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Signed-off-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/Kbuild    |   2 +-
 drivers/misc/intel/gna/device.c  |   7 +-
 drivers/misc/intel/gna/device.h  |   6 +
 drivers/misc/intel/gna/mem.c     |   3 +
 drivers/misc/intel/gna/request.c | 350 +++++++++++++++++++++++++++++++
 drivers/misc/intel/gna/request.h |  65 ++++++
 include/uapi/misc/intel/gna.h    |  37 ++++
 7 files changed, 468 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/intel/gna/request.c
 create mode 100644 drivers/misc/intel/gna/request.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 64e8f10fd891..81d8da8f24aa 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := device.o hw.o mem.o pci.o
+intel_gna-y := device.o hw.o mem.o pci.o request.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 50cac8139dcc..375342c3c140 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright(c) 2017-2021 Intel Corporation
 
-#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 
 #include "device.h"
 #include "hw.h"
+#include "request.h"
 
 static int recovery_timeout = 60;
 
@@ -82,6 +82,11 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 
 	mutex_init(&gna_priv->memidr_lock);
 
+	atomic_set(&gna_priv->request_count, 0);
+
+	mutex_init(&gna_priv->reqlist_lock);
+	INIT_LIST_HEAD(&gna_priv->request_list);
+
 	return 0;
 }
 
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index f74c773867aa..6345295ea589 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -4,6 +4,7 @@
 #ifndef __GNA_DEVICE_H__
 #define __GNA_DEVICE_H__
 
+#include <linux/atomic.h>
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/list.h>
@@ -44,6 +45,11 @@ struct gna_private {
 	struct gna_mmu_object mmu;
 	struct mutex mmu_lock;
 
+	struct list_head request_list;
+	/* protects request_list */
+	struct mutex reqlist_lock;
+	atomic_t request_count;
+
 	/* memory objects' store */
 	struct idr memory_idr;
 	/* lock protecting memory_idr */
diff --git a/drivers/misc/intel/gna/mem.c b/drivers/misc/intel/gna/mem.c
index bdc2771a0d18..de8c58d0f80a 100644
--- a/drivers/misc/intel/gna/mem.c
+++ b/drivers/misc/intel/gna/mem.c
@@ -21,6 +21,7 @@
 #include "hw.h"
 #include "device.h"
 #include "mem.h"
+#include "request.h"
 
 static void gna_mmu_init(struct gna_private *gna_priv)
 {
@@ -340,6 +341,8 @@ static void gna_memory_release(struct work_struct *work)
 
 	mo = container_of(work, struct gna_memory_object, work);
 
+	gna_delete_memory_requests(mo->memory_id, mo->gna_priv);
+
 	mo->user_ptr = NULL;
 
 	wake_up_interruptible(&mo->waitq);
diff --git a/drivers/misc/intel/gna/request.c b/drivers/misc/intel/gna/request.c
new file mode 100644
index 000000000000..d9e7bc5d2d3a
--- /dev/null
+++ b/drivers/misc/intel/gna/request.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+
+#include "device.h"
+#include "mem.h"
+#include "request.h"
+
+static struct gna_request *gna_request_create(struct gna_file_private *file_priv,
+				       struct gna_compute_cfg *compute_cfg)
+{
+	struct gna_request *score_request;
+	struct gna_private *gna_priv;
+
+	gna_priv = file_priv->gna_priv;
+	if (IS_ERR(gna_priv))
+		return NULL;
+
+	score_request = kzalloc(sizeof(*score_request), GFP_KERNEL);
+	if (!score_request)
+		return NULL;
+	kref_init(&score_request->refcount);
+
+	dev_dbg(gna_dev(gna_priv), "layer_base %d layer_count %d\n",
+		compute_cfg->layer_base, compute_cfg->layer_count);
+
+	score_request->request_id = atomic_inc_return(&gna_priv->request_count);
+	score_request->compute_cfg = *compute_cfg;
+	score_request->fd = file_priv->fd;
+	score_request->gna_priv = gna_priv;
+	score_request->state = NEW;
+	init_waitqueue_head(&score_request->waitq);
+
+	return score_request;
+}
+
+/*
+ * returns true if [inner_offset, inner_size) is embraced by [0, outer_size). False otherwise.
+ */
+static bool gna_validate_ranges(u64 outer_size, u64 inner_offset, u64 inner_size)
+{
+	return inner_offset < outer_size &&
+		inner_size <= (outer_size - inner_offset);
+}
+
+static int gna_validate_patches(struct gna_private *gna_priv, __u64 buffer_size,
+				struct gna_memory_patch *patches, u64 count)
+{
+	u64 idx;
+
+	for (idx = 0; idx < count; ++idx) {
+		if (patches[idx].size > 8) {
+			dev_err(gna_dev(gna_priv), "invalid patch size: %llu\n", patches[idx].size);
+			return -EINVAL;
+		}
+
+		if (!gna_validate_ranges(buffer_size, patches[idx].offset, patches[idx].size)) {
+			dev_err(gna_dev(gna_priv),
+				"patch out of bounds. buffer size: %llu, patch offset/size:%llu/%llu\n",
+				buffer_size, patches[idx].offset, patches[idx].size);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int gna_buffer_fill_patches(struct gna_buffer *buffer, struct gna_private *gna_priv)
+{
+	__u64 patches_user = buffer->patches_ptr;
+	struct gna_memory_patch *patches;
+	/* At this point, the buffer points to a memory region in kernel space where the copied
+	 * patches_ptr also lives, but the value of it is still an address from user space. This
+	 * function will set patches_ptr to either an address in kernel space or null before it
+	 * exits.
+	 */
+	u64 patch_count;
+	int ret;
+
+	buffer->patches_ptr = 0;
+	patch_count = buffer->patch_count;
+	if (!patch_count)
+		return 0;
+
+	patches = kvmalloc_array(patch_count, sizeof(struct gna_memory_patch), GFP_KERNEL);
+	if (!patches)
+		return -ENOMEM;
+
+	if (copy_from_user(patches, u64_to_user_ptr(patches_user),
+				sizeof(struct gna_memory_patch) * patch_count)) {
+		dev_err(gna_dev(gna_priv), "copy %llu patches from user failed\n", patch_count);
+		ret = -EFAULT;
+		goto err_fill_patches;
+	}
+
+	ret = gna_validate_patches(gna_priv, buffer->size, patches, patch_count);
+	if (ret) {
+		dev_err(gna_dev(gna_priv), "patches failed validation\n");
+		goto err_fill_patches;
+	}
+
+	buffer->patches_ptr = (uintptr_t)patches;
+
+	return 0;
+
+err_fill_patches:
+	kvfree(patches);
+	return ret;
+}
+
+static int gna_request_fill_buffers(struct gna_request *score_request,
+				    struct gna_compute_cfg *compute_cfg)
+{
+	struct gna_buffer *buffer_list;
+	struct gna_memory_object *mo;
+	struct gna_private *gna_priv;
+	u64 buffers_total_size = 0;
+	struct gna_buffer *buffer;
+	u64 buffer_count;
+	u64 memory_id;
+	u64 i, j;
+	int ret;
+
+	gna_priv = score_request->gna_priv;
+
+	buffer_count = compute_cfg->buffer_count;
+	buffer_list = kvmalloc_array(buffer_count, sizeof(struct gna_buffer), GFP_KERNEL);
+	if (!buffer_list)
+		return -ENOMEM;
+
+	if (copy_from_user(buffer_list, u64_to_user_ptr(compute_cfg->buffers_ptr),
+			sizeof(*buffer_list) * buffer_count)) {
+		dev_err(gna_dev(gna_priv), "copying %llu buffers failed\n", buffer_count);
+		ret = -EFAULT;
+		goto err_free_buffers;
+	}
+
+	for (i = 0; i < buffer_count; i++) {
+		buffer = &buffer_list[i];
+		memory_id = buffer->memory_id;
+
+		for (j = 0; j < i; j++) {
+			if (buffer_list[j].memory_id == memory_id) {
+				dev_err(gna_dev(gna_priv),
+					"doubled memory id in score config. id:%llu\n", memory_id);
+				ret = -EINVAL;
+				goto err_zero_patch_ptr;
+			}
+		}
+
+		buffers_total_size +=
+			gna_buffer_get_size(buffer->offset, buffer->size);
+		if (buffers_total_size > gna_priv->info.max_hw_mem) {
+			dev_err(gna_dev(gna_priv), "buffers' total size too big\n");
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+
+		mutex_lock(&gna_priv->memidr_lock);
+		mo = idr_find(&gna_priv->memory_idr, memory_id);
+		if (!mo) {
+			mutex_unlock(&gna_priv->memidr_lock);
+			dev_err(gna_dev(gna_priv), "memory object %llu not found\n", memory_id);
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+		mutex_unlock(&gna_priv->memidr_lock);
+
+		if (mo->fd != score_request->fd) {
+			dev_err(gna_dev(gna_priv),
+				"memory object from another file. %p != %p\n",
+				mo->fd, score_request->fd);
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+
+		if (!gna_validate_ranges(mo->memory_size, buffer->offset, buffer->size)) {
+			dev_err(gna_dev(gna_priv),
+				"buffer out of bounds. mo size: %llu, buffer offset/size:%llu/%llu\n",
+				mo->memory_size, buffer->offset, buffer->size);
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+
+		ret = gna_buffer_fill_patches(buffer, gna_priv);
+		if (ret)
+			goto err_free_patches;
+	}
+
+	score_request->buffer_list = buffer_list;
+	score_request->buffer_count = buffer_count;
+
+	return 0;
+
+err_zero_patch_ptr:
+	/* patches_ptr may still hold an address in userspace.
+	 * Don't pass it to kvfree().
+	 */
+	buffer->patches_ptr = 0;
+
+err_free_patches:
+	/* patches_ptr of each processed buffer should be either
+	 * null or pointing to an allocated memory block in the
+	 * kernel at this point.
+	 */
+	for (j = 0; j <= i; j++)
+		kvfree((void *)(uintptr_t)buffer_list[j].patches_ptr);
+
+err_free_buffers:
+	kvfree(buffer_list);
+	return ret;
+}
+
+int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
+			struct gna_file_private *file_priv, u64 *request_id)
+{
+	struct gna_request *score_request;
+	struct gna_private *gna_priv;
+	int ret;
+
+	if (!file_priv)
+		return -EINVAL;
+
+	gna_priv = file_priv->gna_priv;
+
+	score_request = gna_request_create(file_priv, compute_cfg);
+	if (!score_request)
+		return -ENOMEM;
+
+	ret = gna_request_fill_buffers(score_request, compute_cfg);
+	if (ret) {
+		kref_put(&score_request->refcount, gna_request_release);
+		return ret;
+	}
+
+	kref_get(&score_request->refcount);
+	mutex_lock(&gna_priv->reqlist_lock);
+	list_add_tail(&score_request->node, &gna_priv->request_list);
+	mutex_unlock(&gna_priv->reqlist_lock);
+
+	kref_put(&score_request->refcount, gna_request_release);
+
+	*request_id = score_request->request_id;
+
+	return 0;
+}
+
+void gna_request_release(struct kref *ref)
+{
+	struct gna_request *score_request =
+		container_of(ref, struct gna_request, refcount);
+	kfree(score_request);
+}
+
+struct gna_request *gna_find_request_by_id(u64 req_id, struct gna_private *gna_priv)
+{
+	struct gna_request *req, *found_req;
+	struct list_head *reqs_list;
+
+	mutex_lock(&gna_priv->reqlist_lock);
+
+	reqs_list = &gna_priv->request_list;
+	found_req = NULL;
+	if (!list_empty(reqs_list)) {
+		list_for_each_entry(req, reqs_list, node) {
+			if (req_id == req->request_id) {
+				found_req = req;
+				kref_get(&found_req->refcount);
+				break;
+			}
+		}
+	}
+
+	mutex_unlock(&gna_priv->reqlist_lock);
+
+	return found_req;
+}
+
+void gna_delete_request_by_id(u64 req_id, struct gna_private *gna_priv)
+{
+	struct gna_request *req, *temp_req;
+	struct list_head *reqs_list;
+
+	mutex_lock(&gna_priv->reqlist_lock);
+
+	reqs_list = &gna_priv->request_list;
+	if (!list_empty(reqs_list)) {
+		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
+			if (req->request_id == req_id) {
+				list_del(&req->node);
+				kref_put(&req->refcount, gna_request_release);
+				break;
+			}
+		}
+	}
+
+	mutex_unlock(&gna_priv->reqlist_lock);
+}
+
+void gna_delete_file_requests(struct file *fd, struct gna_private *gna_priv)
+{
+	struct gna_request *req, *temp_req;
+	struct list_head *reqs_list;
+
+	mutex_lock(&gna_priv->reqlist_lock);
+
+	reqs_list = &gna_priv->request_list;
+	if (!list_empty(reqs_list)) {
+		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
+			if (req->fd == fd) {
+				list_del(&req->node);
+				kref_put(&req->refcount, gna_request_release);
+				break;
+			}
+		}
+	}
+
+	mutex_unlock(&gna_priv->reqlist_lock);
+}
+
+void gna_delete_memory_requests(u64 memory_id, struct gna_private *gna_priv)
+{
+	struct gna_request *req, *temp_req;
+	struct list_head *reqs_list;
+	int i;
+
+	mutex_lock(&gna_priv->reqlist_lock);
+
+	reqs_list = &gna_priv->request_list;
+	if (!list_empty(reqs_list)) {
+		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
+			for (i = 0; i < req->buffer_count; ++i) {
+				if (req->buffer_list[i].memory_id == memory_id) {
+					list_del(&req->node);
+					kref_put(&req->refcount, gna_request_release);
+					break;
+				}
+			}
+		}
+	}
+
+	mutex_unlock(&gna_priv->reqlist_lock);
+}
diff --git a/drivers/misc/intel/gna/request.h b/drivers/misc/intel/gna/request.h
new file mode 100644
index 000000000000..f34e974ad25c
--- /dev/null
+++ b/drivers/misc/intel/gna/request.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_REQUEST_H__
+#define __GNA_REQUEST_H__
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <uapi/misc/intel/gna.h>
+
+struct gna_private;
+struct file;
+
+enum gna_request_state {
+	NEW,
+	ACTIVE,
+	DONE,
+};
+
+struct gna_file_private;
+
+struct gna_request {
+	u64 request_id;
+
+	struct kref refcount;
+
+	struct gna_private *gna_priv;
+	struct file *fd;
+
+	u32 hw_status;
+
+	enum gna_request_state state;
+
+	int status;
+
+	struct gna_hw_perf hw_perf;
+	struct gna_drv_perf drv_perf;
+
+	struct list_head node;
+
+	struct gna_compute_cfg compute_cfg;
+
+	struct gna_buffer *buffer_list;
+	u64 buffer_count;
+
+	struct wait_queue_head waitq;
+};
+
+int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
+			struct gna_file_private *file_priv, u64 *request_id);
+
+void gna_request_release(struct kref *ref);
+
+struct gna_request *gna_find_request_by_id(u64 req_id, struct gna_private *gna_priv);
+
+void gna_delete_request_by_id(u64 req_id, struct gna_private *gna_priv);
+
+void gna_delete_file_requests(struct file *fd, struct gna_private *gna_priv);
+
+void gna_delete_memory_requests(u64 memory_id, struct gna_private *gna_priv);
+
+#endif // __GNA_REQUEST_H__
diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
index a4b6a1e2010c..473ce569d146 100644
--- a/include/uapi/misc/intel/gna.h
+++ b/include/uapi/misc/intel/gna.h
@@ -26,6 +26,43 @@ extern "C" {
 	 GNA_STS_PARAM_OOR		|\
 	 GNA_STS_VA_OOR)
 
+/*
+ * Structure describes part of memory to be overwritten before starting GNA
+ */
+struct gna_memory_patch {
+	/* offset from targeted memory */
+	__u64 offset;
+
+	__u64 size;
+	__u64 value;
+};
+
+struct gna_buffer {
+	__u64 memory_id;
+
+	__u64 offset;
+	__u64 size;
+
+	__u64 patch_count;
+	__u64 patches_ptr;
+};
+
+/*
+ * Driver performance timestamps in nanoseconds.
+ * Values regard system boot time, but do not count during suspend.
+ */
+struct gna_drv_perf {
+	__u64 pre_processing;	/* driver starts pre-processing */
+	__u64 processing;	/* hw starts processing */
+	__u64 hw_completed;	/* hw finishes processing */
+	__u64 completion;	/* driver finishes post-processing */
+};
+
+struct gna_hw_perf {
+	__u64 total;
+	__u64 stall;
+};
+
 struct gna_compute_cfg {
 	__u32 layer_base;
 	__u32 layer_count;
-- 
2.28.0

