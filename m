Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE72237F64C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhEMLFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:05:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:45138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhEMLEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:04:11 -0400
IronPort-SDR: IjCsZwS2epQUW6kTPf/eihGcklpTv9TUu+a9NJoARAHiJ7RLnmah5qBgcwcH5ZfKZnPVZFxmKi
 susnMmYxzpqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048339"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:24 -0700
IronPort-SDR: W3YdXQYTL9dWIaId5MQZEFfah6m0AnXMa772jS1EmgPRl/QX5neaNV3z4QimDMKa7kkDWpKktQ
 BDLVV/jkZFOQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984205"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:21 -0700
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
Subject: [PATCH v3 11/14] intel_gna: add ioctl handler
Date:   Thu, 13 May 2021 13:00:37 +0200
Message-Id: <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Add ioctl handler into GNA driver.
The ioctl interface provides the ability to do the following:
 - Map and unmap memory buffers for GNA computation requests.
 - Retrieve capabilities of the underlying GNA IP.
 - Submit GNA computation requests.
 - Request notification of scoring completion.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/Kbuild   |   2 +-
 drivers/misc/intel/gna/device.c |  47 ++++++
 drivers/misc/intel/gna/device.h |   2 +
 drivers/misc/intel/gna/ioctl.c  | 257 ++++++++++++++++++++++++++++++++
 drivers/misc/intel/gna/ioctl.h  |  11 ++
 include/uapi/misc/intel/gna.h   |  53 +++++++
 6 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/ioctl.c
 create mode 100644 drivers/misc/intel/gna/ioctl.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 38ff97360ed8..745a192a7304 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := device.o hw.o mem.o pci.o request.o score.o
+intel_gna-y := device.o hw.o ioctl.o mem.o pci.o request.o score.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 75d8e1675485..0e31b8c6bb70 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -6,8 +6,11 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
+#include <uapi/misc/intel/gna.h>
+
 #include "device.h"
 #include "hw.h"
+#include "ioctl.h"
 #include "request.h"
 
 static int recovery_timeout = 60;
@@ -145,6 +148,50 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	return 0;
 }
 
+static u32 gna_device_type_by_hwid(u32 hwid)
+{
+	switch (hwid) {
+	case GNA_DEV_HWID_CNL:
+		return GNA_DEV_TYPE_0_9;
+	case GNA_DEV_HWID_GLK:
+	case GNA_DEV_HWID_EHL:
+	case GNA_DEV_HWID_ICL:
+		return GNA_DEV_TYPE_1_0;
+	case GNA_DEV_HWID_JSL:
+	case GNA_DEV_HWID_TGL:
+	case GNA_DEV_HWID_RKL:
+		return GNA_DEV_TYPE_2_0;
+	case GNA_DEV_HWID_ADL:
+	case GNA_DEV_HWID_RPL:
+		return GNA_DEV_TYPE_3_0;
+	default:
+		return 0;
+	}
+}
+
+int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param)
+{
+	switch (param->in.id) {
+	case GNA_PARAM_DEVICE_ID:
+		param->out.value = gna_priv->info.hwid;
+		break;
+	case GNA_PARAM_RECOVERY_TIMEOUT:
+		param->out.value = jiffies_to_msecs(gna_priv->recovery_timeout_jiffies) / 1000;
+		break;
+	case GNA_PARAM_INPUT_BUFFER_S:
+		param->out.value = gna_priv->hw_info.in_buf_s;
+		break;
+	case GNA_PARAM_DEVICE_TYPE:
+		param->out.value = gna_device_type_by_hwid(gna_priv->info.hwid);
+		break;
+	default:
+		dev_err(gna_dev(gna_priv), "unknown parameter id %llu\n", param->in.id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA) Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index d3c86d649b5c..75784882f57c 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -17,6 +17,7 @@
 #define GNA_DV_NAME	"intel_gna"
 
 struct workqueue_struct;
+union gna_parameter;
 struct device;
 struct file;
 
@@ -71,6 +72,7 @@ struct gna_private {
 };
 
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase, int irq);
+int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param);
 
 static inline u32 gna_reg_read(struct gna_private *gna_priv, u32 reg)
 {
diff --git a/drivers/misc/intel/gna/ioctl.c b/drivers/misc/intel/gna/ioctl.c
new file mode 100644
index 000000000000..4a90135b3cc6
--- /dev/null
+++ b/drivers/misc/intel/gna/ioctl.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/jiffies.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "device.h"
+#include "ioctl.h"
+#include "mem.h"
+#include "request.h"
+#include "score.h"
+
+static int gna_ioctl_score(struct gna_file_private *file_priv, void __user *argptr)
+{
+	union gna_compute score_args;
+	struct gna_private *gna_priv;
+	u64 request_id;
+	int ret;
+
+	gna_priv = file_priv->gna_priv;
+
+	if (copy_from_user(&score_args, argptr, sizeof(score_args))) {
+		dev_err(gna_dev(gna_priv), "could not copy score ioctl config from user\n");
+		return -EFAULT;
+	}
+
+	ret = gna_validate_score_config(&score_args.in.config, file_priv);
+	if (ret) {
+		dev_err(gna_dev(gna_priv), "request not valid\n");
+		return ret;
+	}
+
+	ret = gna_enqueue_request(&score_args.in.config, file_priv, &request_id);
+	if (ret) {
+		dev_err(gna_dev(gna_priv), "could not enqueue score request %d\n", ret);
+		return ret;
+	}
+
+	score_args.out.request_id = request_id;
+	if (copy_to_user(argptr, &score_args, sizeof(score_args))) {
+		dev_err(gna_dev(gna_priv), "could not copy score ioctl status to user\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int gna_ioctl_wait(struct file *f, void __user *argptr)
+{
+	struct gna_file_private *file_priv;
+	struct gna_request *score_request;
+	struct gna_private *gna_priv;
+	union gna_wait wait_data;
+	u64 request_id;
+	u32 timeout;
+	int ret;
+
+	file_priv = (struct gna_file_private *)f->private_data;
+	gna_priv = file_priv->gna_priv;
+
+	ret = 0;
+
+	if (copy_from_user(&wait_data, argptr, sizeof(wait_data))) {
+		dev_err(gna_dev(gna_priv), "could not copy wait ioctl data from user\n");
+		return -EFAULT;
+	}
+
+	request_id = wait_data.in.request_id;
+	timeout = wait_data.in.timeout;
+
+	score_request = gna_find_request_by_id(request_id, gna_priv);
+
+	if (!score_request) {
+		dev_err(gna_dev(gna_priv), "could not find request with id: %llu\n", request_id);
+		return -EINVAL;
+	}
+
+	if (score_request->fd != f) {
+		kref_put(&score_request->refcount, gna_request_release);
+		return -EINVAL;
+	}
+
+	dev_dbg(gna_dev(gna_priv), "waiting for request %llu for timeout %u\n", request_id, timeout);
+
+	ret = wait_event_interruptible_timeout(score_request->waitq, score_request->state == DONE,
+					       msecs_to_jiffies(timeout));
+	if (ret == 0 || ret == -ERESTARTSYS) {
+		dev_err(gna_dev(gna_priv), "request timed out, id: %llu\n", request_id);
+		kref_put(&score_request->refcount, gna_request_release);
+		return -EBUSY;
+	}
+
+	dev_dbg(gna_dev(gna_priv), "request wait completed with %d req id %llu\n", ret, request_id);
+
+	wait_data.out.hw_perf = score_request->hw_perf;
+	wait_data.out.drv_perf = score_request->drv_perf;
+	wait_data.out.hw_status = score_request->hw_status;
+
+	ret = score_request->status;
+
+	dev_dbg(gna_dev(gna_priv), "request status %d, hw status: %#x\n",
+		score_request->status, score_request->hw_status);
+	kref_put(&score_request->refcount, gna_request_release);
+
+	gna_delete_request_by_id(request_id, gna_priv);
+
+	if (copy_to_user(argptr, &wait_data, sizeof(wait_data))) {
+		dev_err(gna_dev(gna_priv), "could not copy wait ioctl status to user\n");
+		ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+static int gna_ioctl_map(struct gna_file_private *file_priv, void __user *argptr)
+{
+	struct gna_private *gna_priv;
+	union gna_memory_map gna_mem;
+	int ret;
+
+	gna_priv = file_priv->gna_priv;
+
+	if (copy_from_user(&gna_mem, argptr, sizeof(gna_mem))) {
+		dev_err(gna_dev(gna_priv), "could not copy userptr ioctl data from user\n");
+		return -EFAULT;
+	}
+
+	ret = gna_map_memory(file_priv, &gna_mem);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argptr, &gna_mem, sizeof(gna_mem))) {
+		dev_err(gna_dev(gna_priv), "could not copy userptr ioctl status to user\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int gna_ioctl_free(struct gna_file_private *file_priv, unsigned long arg)
+{
+	struct gna_memory_object *iter_mo, *temp_mo;
+	struct gna_memory_object *mo;
+	struct gna_private *gna_priv;
+
+	u64 memory_id = arg;
+
+	gna_priv = file_priv->gna_priv;
+
+	mutex_lock(&gna_priv->memidr_lock);
+	mo = idr_find(&gna_priv->memory_idr, memory_id);
+	mutex_unlock(&gna_priv->memidr_lock);
+
+	if (!mo) {
+		dev_warn(gna_dev(gna_priv), "memory object not found\n");
+		return -EINVAL;
+	}
+
+	queue_work(gna_priv->request_wq, &mo->work);
+	if (wait_event_interruptible(mo->waitq, true)) {
+		dev_dbg(gna_dev(gna_priv), "wait interrupted\n");
+		return -ETIME;
+	}
+
+	mutex_lock(&file_priv->memlist_lock);
+	list_for_each_entry_safe(iter_mo, temp_mo, &file_priv->memory_list, file_mem_list) {
+		if (iter_mo->memory_id == memory_id) {
+			list_del(&iter_mo->file_mem_list);
+			break;
+		}
+	}
+	mutex_unlock(&file_priv->memlist_lock);
+
+	gna_memory_free(gna_priv, mo);
+
+	return 0;
+}
+
+static int gna_ioctl_getparam(struct gna_private *gna_priv, void __user *argptr)
+{
+	union gna_parameter param;
+	int ret;
+
+	if (copy_from_user(&param, argptr, sizeof(param))) {
+		dev_err(gna_dev(gna_priv), "could not copy getparam ioctl data from user\n");
+		return -EFAULT;
+	}
+
+	ret = gna_getparam(gna_priv, &param);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argptr, &param, sizeof(param))) {
+		dev_err(gna_dev(gna_priv), "could not copy getparam ioctl status to user\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+long gna_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+	void __user *argptr;
+	int ret = 0;
+
+	argptr = (void __user *)arg;
+
+	file_priv = (struct gna_file_private *)f->private_data;
+	// TODO following is always false?
+	if (!file_priv)
+		return -ENODEV;
+
+	gna_priv = file_priv->gna_priv;
+	if (!gna_priv)
+		return -ENODEV;
+
+	switch (cmd) {
+	case GNA_GET_PARAMETER:
+		ret = gna_ioctl_getparam(gna_priv, argptr);
+		break;
+
+	case GNA_MAP_MEMORY:
+		ret = gna_ioctl_map(file_priv, argptr);
+		break;
+
+	case GNA_UNMAP_MEMORY:
+		ret = gna_ioctl_free(file_priv, arg);
+		break;
+
+	case GNA_COMPUTE:
+		ret = gna_ioctl_score(file_priv, argptr);
+		break;
+
+	case GNA_WAIT:
+		ret = gna_ioctl_wait(f, argptr);
+		break;
+
+	default:
+		dev_warn(gna_dev(gna_priv), "wrong ioctl %#x\n", cmd);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/misc/intel/gna/ioctl.h b/drivers/misc/intel/gna/ioctl.h
new file mode 100644
index 000000000000..c10dba7afa18
--- /dev/null
+++ b/drivers/misc/intel/gna/ioctl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_IOCTL_H__
+#define __GNA_IOCTL_H__
+
+struct file;
+
+long gna_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
+
+#endif // __GNA_IOCTL_H__
diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
index b531beb35bd9..0b55deb7a0ea 100644
--- a/include/uapi/misc/intel/gna.h
+++ b/include/uapi/misc/intel/gna.h
@@ -8,12 +8,19 @@
 extern "C" {
 #endif
 
+#include <linux/const.h>
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
 /* Operation modes */
 #define GNA_MODE_GMM	0
 #define GNA_MODE_XNN	1
 
+#define GNA_PARAM_DEVICE_ID		1
+#define GNA_PARAM_RECOVERY_TIMEOUT	2
+#define GNA_PARAM_DEVICE_TYPE		3
+#define GNA_PARAM_INPUT_BUFFER_S	4
+
 #define GNA_STS_SCORE_COMPLETED		_BITUL(0)
 #define GNA_STS_STATISTICS_VALID	_BITUL(3)
 #define GNA_STS_PCI_MMU_ERR		_BITUL(4)
@@ -30,6 +37,11 @@ extern "C" {
 	 GNA_STS_PARAM_OOR		|\
 	 GNA_STS_VA_OOR)
 
+#define GNA_DEV_TYPE_0_9	0x09
+#define GNA_DEV_TYPE_1_0	0x10
+#define GNA_DEV_TYPE_2_0	0x20
+#define GNA_DEV_TYPE_3_0	0x30
+
 /*
  * Structure describes part of memory to be overwritten before starting GNA
  */
@@ -81,6 +93,16 @@ struct gna_compute_cfg {
 	__u8 pad[5];
 };
 
+union gna_parameter {
+	struct {
+		__u64 id;
+	} in;
+
+	struct {
+		__u64 value;
+	} out;
+};
+
 union gna_memory_map {
 	struct {
 		__u64 address;
@@ -93,6 +115,37 @@ union gna_memory_map {
 	} out;
 };
 
+union gna_compute {
+	struct {
+		struct gna_compute_cfg config;
+	} in;
+
+	struct {
+		__u64 request_id;
+	} out;
+};
+
+union gna_wait {
+	struct {
+		__u64 request_id;
+		__u32 timeout;
+		__u32 pad;
+	} in;
+
+	struct {
+		__u32 hw_status;
+		__u32 pad;
+		struct gna_drv_perf drv_perf;
+		struct gna_hw_perf hw_perf;
+	} out;
+};
+
+#define GNA_GET_PARAMETER	_IOWR('C', 0x01, union gna_parameter)
+#define GNA_MAP_MEMORY		_IOWR('C', 0x02, union gna_memory_map)
+#define GNA_UNMAP_MEMORY	_IOWR('C', 0x03, __u64)
+#define GNA_COMPUTE		_IOWR('C', 0x04, union gna_compute)
+#define GNA_WAIT		_IOWR('C', 0x05, union gna_wait)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.28.0

