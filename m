Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9693480CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhCXSjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:17741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237685AbhCXSir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:47 -0400
IronPort-SDR: WtJ1VFIB5SsAfNsTtxMzQoI3eETsPCvp2a8C5wFCNqw6FO2uIX4TaBxXe3bewoSsVpEQWiDlrA
 YPNsT7Gam+Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859563"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859563"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:46 -0700
IronPort-SDR: Hi9YUzqnFlhB2xN4K4R0AC5UbqI8n4M+3Uk6atRrf+hEw/uLao7vRWJRNHcE5vQG6X/pQT4Ia6
 OhRc4zKiPD/Q==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203910"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:44 -0700
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
Subject: [PATCH v2 11/13] intel_gna: add ioctl handler
Date:   Wed, 24 Mar 2021 19:36:08 +0100
Message-Id: <20210324183610.4574-12-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/intel/gna/Kbuild       |   2 +-
 drivers/misc/intel/gna/gna_device.c |  44 +++++
 drivers/misc/intel/gna/gna_device.h |   3 +
 drivers/misc/intel/gna/gna_ioctl.c  | 249 ++++++++++++++++++++++++++++
 drivers/misc/intel/gna/gna_ioctl.h  |  11 ++
 5 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel/gna/gna_ioctl.c
 create mode 100644 drivers/misc/intel/gna/gna_ioctl.h

diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
index 9dac467839c9..879cc76204c3 100644
--- a/drivers/misc/intel/gna/Kbuild
+++ b/drivers/misc/intel/gna/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-intel_gna-y := gna_device.o gna_driver.o gna_mem.o gna_request.o gna_score.o gna_hw.o
+intel_gna-y := gna_device.o gna_driver.o gna_mem.o gna_ioctl.o gna_request.o gna_score.o gna_hw.o
 
 obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index 67917106a262..d8e1d4b8a9eb 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -5,8 +5,12 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <uapi/misc/intel/gna.h>
+
 #include "gna_device.h"
 #include "gna_driver.h"
+#include "gna_hw.h"
+#include "gna_ioctl.h"
 #include "gna_request.h"
 
 #define GNA_DEV_HWID_CNL	0x5A11
@@ -262,3 +266,43 @@ void gna_remove(struct pci_dev *pcidev)
 
 	pci_free_irq_vectors(pcidev);
 }
+
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
+		return GNA_DEV_TYPE_2_0;
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
+		param->out.value = jiffies_to_msecs(gna_priv->drv_priv->recovery_timeout_jiffies) / 1000;
+		break;
+	case GNA_PARAM_INPUT_BUFFER_S:
+		param->out.value = gna_priv->hw_info.in_buf_s;
+		break;
+	case GNA_PARAM_DEVICE_TYPE:
+		param->out.value = gna_device_type_by_hwid(gna_priv->info.hwid);
+		break;
+	default:
+		dev_err(&gna_priv->pdev->dev, "unknown parameter id %llu\n", param->in.id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index 7ba25f6f8492..aa7fadcf93b1 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -15,6 +15,7 @@
 
 struct gna_driver_private;
 struct workqueue_struct;
+union gna_parameter;
 struct device;
 
 struct gna_drv_info {
@@ -77,4 +78,6 @@ int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
 
 void gna_remove(struct pci_dev *dev);
 
+int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param);
+
 #endif /* __GNA_DEVICE_H__ */
diff --git a/drivers/misc/intel/gna/gna_ioctl.c b/drivers/misc/intel/gna/gna_ioctl.c
new file mode 100644
index 000000000000..79ce3aeb27cf
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_ioctl.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/uaccess.h>
+
+#include <uapi/misc/intel/gna.h>
+
+#include "gna_driver.h"
+#include "gna_device.h"
+#include "gna_ioctl.h"
+#include "gna_mem.h"
+#include "gna_request.h"
+#include "gna_score.h"
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
+		dev_err(&gna_priv->pdev->dev, "could not copy score ioctl config from user\n");
+		return -EFAULT;
+	}
+
+	ret = gna_validate_score_config(&score_args.in.config, file_priv);
+	if (ret) {
+		dev_err(&gna_priv->pdev->dev, "request not valid\n");
+		return ret;
+	}
+
+	ret = gna_enqueue_request(&score_args.in.config, file_priv, &request_id);
+	if (ret) {
+		dev_err(&gna_priv->pdev->dev, "could not enqueue score request %d\n", ret);
+		return ret;
+	}
+
+	score_args.out.request_id = request_id;
+	if (copy_to_user(argptr, &score_args, sizeof(score_args))) {
+		dev_err(&gna_priv->pdev->dev, "could not copy score ioctl status to user\n");
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
+		dev_err(&gna_priv->pdev->dev, "could not copy wait ioctl data from user\n");
+		return -EFAULT;
+	}
+
+	request_id = wait_data.in.request_id;
+	timeout = wait_data.in.timeout;
+
+	score_request = gna_find_request_by_id(request_id, gna_priv);
+
+	if (!score_request) {
+		dev_err(&gna_priv->pdev->dev, "could not find request with id: %llu\n", request_id);
+		return -EINVAL;
+	}
+
+	if (score_request->fd != f) {
+		kref_put(&score_request->refcount, gna_request_release);
+		return -EINVAL;
+	}
+
+	dev_dbg(&gna_priv->pdev->dev, "waiting for request %llu for timeout %u\n", request_id, timeout);
+
+	ret = wait_event_interruptible_timeout(score_request->waitq, score_request->state == DONE,
+					       msecs_to_jiffies(timeout));
+	if (ret == 0 || ret == -ERESTARTSYS) {
+		dev_err(&gna_priv->pdev->dev, "request timed out, id: %llu\n", request_id);
+		kref_put(&score_request->refcount, gna_request_release);
+		return -EBUSY;
+	}
+
+	dev_dbg(&gna_priv->pdev->dev, "request wait completed with %d req id %llu\n", ret, request_id);
+
+	wait_data.out.hw_perf = score_request->hw_perf;
+	wait_data.out.drv_perf = score_request->drv_perf;
+	wait_data.out.hw_status = score_request->hw_status;
+
+	ret = score_request->status;
+
+	dev_dbg(&gna_priv->pdev->dev, "request status %d, hw status: %#x\n",
+		score_request->status, score_request->hw_status);
+	kref_put(&score_request->refcount, gna_request_release);
+
+	gna_delete_request_by_id(request_id, gna_priv);
+
+	if (copy_to_user(argptr, &wait_data, sizeof(wait_data))) {
+		dev_err(&gna_priv->pdev->dev, "could not copy wait ioctl status to user\n");
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
+		dev_err(&gna_priv->pdev->dev, "could not copy userptr ioctl data from user\n");
+		return -EFAULT;
+	}
+
+	ret = gna_map_memory(file_priv, &gna_mem);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argptr, &gna_mem, sizeof(gna_mem))) {
+		dev_err(&gna_priv->pdev->dev, "could not copy userptr ioctl status to user\n");
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
+		dev_warn(&gna_priv->pdev->dev, "memory object not found\n");
+		return -EINVAL;
+	}
+
+	queue_work(gna_priv->request_wq, &mo->work);
+	if (wait_event_interruptible(mo->waitq, true)) {
+		dev_dbg(&gna_priv->pdev->dev, "wait interrupted\n");
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
+		dev_err(&gna_priv->pdev->dev, "could not copy getparam ioctl data from user\n");
+		return -EFAULT;
+	}
+
+	ret = gna_getparam(gna_priv, &param);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argptr, &param, sizeof(param))) {
+		dev_err(&gna_priv->pdev->dev, "could not copy getparam ioctl status to user\n");
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
+		dev_warn(&gna_priv->pdev->dev, "wrong ioctl %#x\n", cmd);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/misc/intel/gna/gna_ioctl.h b/drivers/misc/intel/gna/gna_ioctl.h
new file mode 100644
index 000000000000..562f7f835f5f
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_ioctl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_IOCTL_H__
+#define __GNA_IOCTL_H__
+
+#include <linux/fs.h>
+
+long gna_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
+
+#endif // __GNA_IOCTL_H__
-- 
2.28.0

