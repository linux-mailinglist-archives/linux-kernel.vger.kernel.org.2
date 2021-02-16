Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EEB31CDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBPQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:13:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:31319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhBPQMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:12:41 -0500
IronPort-SDR: kJJY2VucOxeUosOfQSx/i1Qon8LFQDfjIOoqVokwazbkp6sKsvysbKc60rFwH91IH8WXMK9Mf+
 RzrdvH+hWCcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118634"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:11 -0800
IronPort-SDR: hZ5/jHLBiu7EUKbsdWfzoGQ1eJhGlLnGgSyI9ALivVfBLROkGUmCskse3xb9ZRtM/ALO4fvUyJ
 JKpC5l2z1gsg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336705"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:09 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Anisha Dattatraya Kulkarni 
        <anisha.dattatraya.kulkarni@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 07/12] gna: add request component
Date:   Tue, 16 Feb 2021 17:05:20 +0100
Message-Id: <20210216160525.5028-8-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

The scoring work submitted to the GNA driver is implemented as a
list of requests that will be processed by the hardware.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Co-developed-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Signed-off-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/gna/Kbuild        |   2 +-
 drivers/misc/gna/gna_device.c  |   5 +
 drivers/misc/gna/gna_device.h  |   5 +
 drivers/misc/gna/gna_mem.c     |   3 +
 drivers/misc/gna/gna_request.c | 347 +++++++++++++++++++++++++++++++++
 drivers/misc/gna/gna_request.h |  61 ++++++
 6 files changed, 422 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/gna/gna_request.c
 create mode 100644 drivers/misc/gna/gna_request.h

diff --git a/drivers/misc/gna/Kbuild b/drivers/misc/gna/Kbuild
index 860b14c0e8d0..f47775759a6e 100644
--- a/drivers/misc/gna/Kbuild
+++ b/drivers/misc/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-gna-y := gna_device.o gna_driver.o gna_mem.o gna_hw.o
+gna-y := gna_device.o gna_driver.o gna_mem.o gna_request.o gna_hw.o
 
 obj-$(CONFIG_INTEL_GNA) += gna.o
diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index 7031a5d7c16c..cd8ee86bbc58 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -7,6 +7,7 @@
 #include "gna_device.h"
 #include "gna_driver.h"
 #include "gna_hw.h"
+#include "gna_request.h"
 
 #define GNA_DEV_HWID_CNL	0x5A11
 #define GNA_DEV_HWID_EHL	0x4511
@@ -111,8 +112,12 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 
 	mutex_init(&gna_priv->mmu_lock);
 
+	atomic_set(&gna_priv->request_count, 0);
+
 	idr_init(&gna_priv->memory_idr);
 	mutex_init(&gna_priv->memidr_lock);
+	mutex_init(&gna_priv->reqlist_lock);
+	INIT_LIST_HEAD(&gna_priv->request_list);
 
 	return 0;
 }
diff --git a/drivers/misc/gna/gna_device.h b/drivers/misc/gna/gna_device.h
index 22c47f2c03ec..445c81c698fb 100644
--- a/drivers/misc/gna/gna_device.h
+++ b/drivers/misc/gna/gna_device.h
@@ -50,6 +50,11 @@ struct gna_private {
 	/* lock protecting mmu structure */
 	struct mutex mmu_lock;
 
+	/* requests */
+	struct list_head request_list;
+	struct mutex reqlist_lock;	/* protects request_list */
+	atomic_t request_count;
+
 	/* memory objects */
 	struct idr memory_idr;
 	/* lock protecting memory_idr */
diff --git a/drivers/misc/gna/gna_mem.c b/drivers/misc/gna/gna_mem.c
index a2ac3c31b4fb..09c4f401c3fa 100644
--- a/drivers/misc/gna/gna_mem.c
+++ b/drivers/misc/gna/gna_mem.c
@@ -19,6 +19,7 @@
 #include "gna_device.h"
 #include "gna_driver.h"
 #include "gna_mem.h"
+#include "gna_request.h"
 
 static void gna_mmu_init(struct gna_private *gna_priv)
 {
@@ -391,6 +392,8 @@ static void gna_memory_release(struct work_struct *work)
 
 	mo = container_of(work, struct gna_memory_object, work);
 
+	gna_delete_memory_requests(mo->memory_id, mo->gna_priv);
+
 	mo->user_ptr = NULL;
 
 	wake_up_interruptible(&mo->waitq);
diff --git a/drivers/misc/gna/gna_request.c b/drivers/misc/gna/gna_request.c
new file mode 100644
index 000000000000..a7a55fe68eed
--- /dev/null
+++ b/drivers/misc/gna/gna_request.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+#include "gna_request.h"
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
+	dev_dbg(&gna_priv->dev, "layer_base %d layer_count %d\n",
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
+			dev_err(&gna_priv->dev, "invalid patch size: %llu\n", patches[idx].size);
+			return -EINVAL;
+		}
+
+		if (!gna_validate_ranges(buffer_size, patches[idx].offset, patches[idx].size)) {
+			dev_err(&gna_priv->dev,
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
+		dev_err(&gna_priv->dev, "copy %llu patches from user failed\n", patch_count);
+		ret = -EFAULT;
+		goto err_fill_patches;
+	}
+
+	ret = gna_validate_patches(gna_priv, buffer->size, patches, patch_count);
+	if (ret) {
+		dev_err(&gna_priv->dev, "patches failed validation\n");
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
+	/* get memory buffer list */
+	buffer_count = compute_cfg->buffer_count;
+	buffer_list = kvmalloc_array(buffer_count, sizeof(struct gna_buffer), GFP_KERNEL);
+	if (!buffer_list)
+		return -ENOMEM;
+
+	if (copy_from_user(buffer_list, u64_to_user_ptr(compute_cfg->buffers_ptr),
+			sizeof(*buffer_list) * buffer_count)) {
+		dev_err(&gna_priv->dev, "copying %llu buffers failed\n", buffer_count);
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
+				dev_err(&gna_priv->dev, "doubled memory id in score config. id:%llu\n", memory_id);
+				ret = -EINVAL;
+				goto err_zero_patch_ptr;
+			}
+		}
+
+		buffers_total_size +=
+			gna_buffer_get_size(buffer->offset, buffer->size);
+		if (buffers_total_size > gna_priv->info.max_hw_mem) {
+			dev_err(&gna_priv->dev, "buffers' total size too big\n");
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+
+		mutex_lock(&gna_priv->memidr_lock);
+		mo = idr_find(&gna_priv->memory_idr, memory_id);
+		if (!mo) {
+			mutex_unlock(&gna_priv->memidr_lock);
+			dev_err(&gna_priv->dev, "memory object %llu not found\n", memory_id);
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+		mutex_unlock(&gna_priv->memidr_lock);
+
+		if (mo->fd != score_request->fd) {
+			dev_err(&gna_priv->dev,
+				"memory object from another file. %p != %p\n",
+				mo->fd, score_request->fd);
+			ret = -EINVAL;
+			goto err_zero_patch_ptr;
+		}
+
+		if (!gna_validate_ranges(mo->memory_size, buffer->offset, buffer->size)) {
+			dev_err(&gna_priv->dev,
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
diff --git a/drivers/misc/gna/gna_request.h b/drivers/misc/gna/gna_request.h
new file mode 100644
index 000000000000..c15a2c1803da
--- /dev/null
+++ b/drivers/misc/gna/gna_request.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_REQUEST_H__
+#define __GNA_REQUEST_H__
+
+#include <linux/kref.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include <uapi/misc/gna.h>
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
-- 
2.28.0

