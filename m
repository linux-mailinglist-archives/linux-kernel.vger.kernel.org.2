Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0752C3480CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbhCXSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:17741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237688AbhCXSit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:49 -0400
IronPort-SDR: 3l4/A0+VK9rM3faRy+UpMDHd2vqFObDpaU1hKvzvDfdD1vUCFGLqj4uCTbjplx6r3jkTaXb56V
 1mCb20Z/2MGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859574"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859574"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:49 -0700
IronPort-SDR: Q+rQeojWdhXrGevTENulCfg57HmrxuIxkAgzrA/g9MsI4BbPTis/tkSnIgjlEWE41oi8JlKRbR
 nbvPxpgSWG+Q==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203919"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:46 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: [PATCH v2 12/13] intel_gna: add a 'misc' device
Date:   Wed, 24 Mar 2021 19:36:09 +0100
Message-Id: <20210324183610.4574-13-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new 'misc' device is the node for applications in user space to
interact with the driver.

Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
---
 drivers/misc/intel/gna/gna_device.c  | 69 ++++++++++++++++++++++++++--
 drivers/misc/intel/gna/gna_device.h  |  6 +++
 drivers/misc/intel/gna/gna_driver.c  |  2 +
 drivers/misc/intel/gna/gna_driver.h  |  2 +
 drivers/misc/intel/gna/gna_hw.c      | 28 +++++------
 drivers/misc/intel/gna/gna_ioctl.c   | 36 +++++++--------
 drivers/misc/intel/gna/gna_mem.c     | 32 ++++++-------
 drivers/misc/intel/gna/gna_request.c | 32 ++++++-------
 drivers/misc/intel/gna/gna_score.c   | 28 +++++------
 9 files changed, 154 insertions(+), 81 deletions(-)

diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index d8e1d4b8a9eb..3f7f4c07d1a1 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -91,9 +91,57 @@ const struct pci_device_id gna_pci_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, gna_pci_ids);
 
+static int gna_open(struct inode *inode, struct file *f)
+{
+	return -EPERM;
+}
+
+static const struct file_operations gna_file_ops = {
+	.owner		=	THIS_MODULE,
+	.open		=	gna_open,
+};
+
+static void gna_dev_release(struct gna_private *gna_priv)
+{
+	misc_deregister(&gna_priv->misc);
+	kfree(gna_priv->misc.name);
+	gna_priv->misc.name = NULL;
+}
+
+static int gna_dev_create(struct gna_private *gna_priv, char *gna_name)
+{
+	struct pci_dev *pcidev;
+	int ret;
+
+	pcidev = gna_priv->pdev;
+
+	gna_priv->misc.minor = MISC_DYNAMIC_MINOR;
+	gna_priv->misc.name = kasprintf(GFP_KERNEL, "%s", gna_name);
+	gna_priv->misc.fops = &gna_file_ops;
+	gna_priv->misc.parent = &pcidev->dev;
+	gna_priv->misc.mode = 0666;
+
+	dev_dbg(&pcidev->dev, "registering device: %s\n",
+		gna_priv->misc.name);
+
+	ret = misc_register(&gna_priv->misc);
+	if (ret) {
+		dev_err(&pcidev->dev, "misc_register %s failed: %d\n",
+			gna_name, ret);
+		misc_deregister(&gna_priv->misc);
+		kfree(gna_priv->misc.name);
+		gna_priv->misc.name = NULL;
+	}
+
+	return ret;
+}
+
+
 static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
+	// strlen(GNA_DV_NAME) + max minor number.
+	char gna_name[sizeof(GNA_DV_NAME) + sizeof("255") + 1];
 	u32 bld_reg;
 	int ret;
 
@@ -104,6 +152,8 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	gna_priv->info = *(struct gna_drv_info *)pci_id->driver_data;
 	gna_priv->drv_priv = &gna_drv_priv;
 
+	gna_priv->index = atomic_inc_return(&gna_priv->drv_priv->dev_last_idx);
+
 	bld_reg = gna_reg_read(gna_priv->bar0_base, GNA_MMIO_IBUFFS);
 	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 
@@ -134,15 +184,26 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 
 	init_waitqueue_head(&gna_priv->dev_busy_waitq);
 
-	gna_priv->request_wq = create_singlethread_workqueue(GNA_DV_NAME);
+	snprintf(gna_name, sizeof(gna_name), "%s%d", GNA_DV_NAME, gna_priv->index);
+
+	gna_priv->request_wq = create_singlethread_workqueue(gna_name);
 	if (!gna_priv->request_wq) {
-		dev_err(&pcidev->dev, "could not create %s workqueue\n", GNA_DV_NAME);
+		dev_err(&pcidev->dev, "could not create %s workqueue\n", gna_name);
 		ret = -EFAULT;
 		goto err_pci_drvdata_unset;
 	}
 
+	ret = gna_dev_create(gna_priv, gna_name);
+	if (ret) {
+		dev_err(&pcidev->dev, "could not create %s device\n", GNA_DV_NAME);
+		goto err_del_wq;
+	}
+
 	return 0;
 
+err_del_wq:
+	destroy_workqueue(gna_priv->request_wq);
+
 err_pci_drvdata_unset:
 	pci_set_drvdata(pcidev, NULL);
 
@@ -151,6 +212,8 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 
 static void gna_dev_deinit(struct gna_private *gna_priv)
 {
+	gna_dev_release(gna_priv);
+
 	flush_workqueue(gna_priv->request_wq);
 	destroy_workqueue(gna_priv->request_wq);
 
@@ -300,7 +363,7 @@ int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param)
 		param->out.value = gna_device_type_by_hwid(gna_priv->info.hwid);
 		break;
 	default:
-		dev_err(&gna_priv->pdev->dev, "unknown parameter id %llu\n", param->in.id);
+		dev_err(gna_priv->misc.this_device, "unknown parameter id %llu\n", param->in.id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index aa7fadcf93b1..72692f5f3582 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -4,6 +4,7 @@
 #ifndef __GNA_DEVICE_H__
 #define __GNA_DEVICE_H__
 
+#include <linux/miscdevice.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -44,6 +45,11 @@ struct gna_private {
 	/* pdev->dev */
 	struct device *parent;
 
+	int index;
+
+	/* gna misc-device */
+	struct miscdevice misc;
+
 	int irq;
 	/* hardware status set by interrupt handler */
 	u32 hw_status;
diff --git a/drivers/misc/intel/gna/gna_driver.c b/drivers/misc/intel/gna/gna_driver.c
index a8f69a970f7a..79b735f3e492 100644
--- a/drivers/misc/intel/gna/gna_driver.c
+++ b/drivers/misc/intel/gna/gna_driver.c
@@ -23,6 +23,8 @@ static struct pci_driver gna_driver = {
 
 static int __init gna_drv_init(void)
 {
+	atomic_set(&gna_drv_priv.dev_last_idx, -1);
+
 	gna_drv_priv.recovery_timeout_jiffies = msecs_to_jiffies(recovery_timeout * 1000);
 
 	return pci_register_driver(&gna_driver);
diff --git a/drivers/misc/intel/gna/gna_driver.h b/drivers/misc/intel/gna/gna_driver.h
index 69087317d668..48a443d69f61 100644
--- a/drivers/misc/intel/gna/gna_driver.h
+++ b/drivers/misc/intel/gna/gna_driver.h
@@ -5,6 +5,7 @@
 #define __GNA_DRIVER_H__
 
 #include <linux/mutex.h>
+#include <linux/types.h>
 #include <linux/list.h>
 
 #define GNA_DV_NAME	"intel_gna"
@@ -13,6 +14,7 @@ struct gna_private;
 struct file;
 
 struct gna_driver_private {
+	atomic_t dev_last_idx;
 	int recovery_timeout_jiffies;
 };
 
diff --git a/drivers/misc/intel/gna/gna_hw.c b/drivers/misc/intel/gna/gna_hw.c
index 7d2f4ef00136..1f3f747aa88e 100644
--- a/drivers/misc/intel/gna/gna_hw.c
+++ b/drivers/misc/intel/gna/gna_hw.c
@@ -14,13 +14,13 @@ int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status)
 	int status;
 
 	if (hw_status & GNA_ERROR) {
-		dev_dbg(&gna_priv->pdev->dev, "GNA completed with errors: %#x\n", hw_status);
+		dev_dbg(gna_priv->misc.this_device, "GNA completed with errors: %#x\n", hw_status);
 		status = -EIO;
 	} else if (hw_status & GNA_STS_SCORE_COMPLETED) {
 		status = 0;
-		dev_dbg(&gna_priv->pdev->dev, "GNA completed successfully: %#x\n", hw_status);
+		dev_dbg(gna_priv->misc.this_device, "GNA completed successfully: %#x\n", hw_status);
 	} else {
-		dev_err(&gna_priv->pdev->dev, "GNA not completed, status: %#x\n", hw_status);
+		dev_err(gna_priv->misc.this_device, "GNA not completed, status: %#x\n", hw_status);
 		status = -ENODATA;
 	}
 
@@ -30,22 +30,22 @@ int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status)
 void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status)
 {
 	if (hw_status & GNA_STS_PARAM_OOR)
-		dev_dbg(&gna_priv->pdev->dev, "GNA error: Param Out Range Error\n");
+		dev_dbg(gna_priv->misc.this_device, "GNA error: Param Out Range Error\n");
 
 	if (hw_status & GNA_STS_VA_OOR)
-		dev_dbg(&gna_priv->pdev->dev, "GNA error: VA Out of Range Error\n");
+		dev_dbg(gna_priv->misc.this_device, "GNA error: VA Out of Range Error\n");
 
 	if (hw_status & GNA_STS_PCI_MMU_ERR)
-		dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI MMU Error\n");
+		dev_dbg(gna_priv->misc.this_device, "GNA error: PCI MMU Error\n");
 
 	if (hw_status & GNA_STS_PCI_DMA_ERR)
-		dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI MMU Error\n");
+		dev_dbg(gna_priv->misc.this_device, "GNA error: PCI MMU Error\n");
 
 	if (hw_status & GNA_STS_PCI_UNEXCOMPL_ERR)
-		dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI Unexpected Completion Error\n");
+		dev_dbg(gna_priv->misc.this_device, "GNA error: PCI Unexpected Completion Error\n");
 
 	if (hw_status & GNA_STS_SATURATE)
-		dev_dbg(&gna_priv->pdev->dev, "GNA error: Saturation Reached !\n");
+		dev_dbg(gna_priv->misc.this_device, "GNA error: Saturation Reached !\n");
 }
 
 bool gna_hw_perf_enabled(struct gna_private *gna_priv)
@@ -77,7 +77,7 @@ void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,
 
 	gna_reg_write(addr, GNA_MMIO_CTRL, ctrl);
 
-	dev_dbg(&gna_priv->pdev->dev, "scoring started...\n");
+	dev_dbg(gna_priv->misc.this_device, "scoring started...\n");
 }
 
 static void gna_clear_saturation(struct gna_private *gna_priv)
@@ -87,8 +87,8 @@ static void gna_clear_saturation(struct gna_private *gna_priv)
 
 	val = gna_reg_read(addr, GNA_MMIO_STS);
 	if (val & GNA_STS_SATURATE) {
-		dev_dbg(&gna_priv->pdev->dev, "saturation reached\n");
-		dev_dbg(&gna_priv->pdev->dev, "status: %#x\n", val);
+		dev_dbg(gna_priv->misc.this_device, "saturation reached\n");
+		dev_dbg(gna_priv->misc.this_device, "status: %#x\n", val);
 
 		val = val & GNA_STS_SATURATE;
 		gna_reg_write(addr, GNA_MMIO_STS, val);
@@ -107,7 +107,7 @@ void gna_abort_hw(struct gna_private *gna_priv)
 	gna_clear_saturation(gna_priv);
 
 	val = gna_reg_read(addr, GNA_MMIO_STS);
-	dev_dbg(&gna_priv->pdev->dev, "status before abort: %#x\n", val);
+	dev_dbg(gna_priv->misc.this_device, "status before abort: %#x\n", val);
 
 	val = gna_reg_read(addr, GNA_MMIO_CTRL);
 	val |= GNA_CTRL_ABORT_CLR_ACCEL;
@@ -121,5 +121,5 @@ void gna_abort_hw(struct gna_private *gna_priv)
 	} while (--i);
 
 	if (i == 0)
-		dev_err(&gna_priv->pdev->dev, "abort did not complete\n");
+		dev_err(gna_priv->misc.this_device, "abort did not complete\n");
 }
diff --git a/drivers/misc/intel/gna/gna_ioctl.c b/drivers/misc/intel/gna/gna_ioctl.c
index 79ce3aeb27cf..03d85850dcf1 100644
--- a/drivers/misc/intel/gna/gna_ioctl.c
+++ b/drivers/misc/intel/gna/gna_ioctl.c
@@ -22,25 +22,25 @@ static int gna_ioctl_score(struct gna_file_private *file_priv, void __user *argp
 	gna_priv = file_priv->gna_priv;
 
 	if (copy_from_user(&score_args, argptr, sizeof(score_args))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy score ioctl config from user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy score ioctl config from user\n");
 		return -EFAULT;
 	}
 
 	ret = gna_validate_score_config(&score_args.in.config, file_priv);
 	if (ret) {
-		dev_err(&gna_priv->pdev->dev, "request not valid\n");
+		dev_err(gna_priv->misc.this_device, "request not valid\n");
 		return ret;
 	}
 
 	ret = gna_enqueue_request(&score_args.in.config, file_priv, &request_id);
 	if (ret) {
-		dev_err(&gna_priv->pdev->dev, "could not enqueue score request %d\n", ret);
+		dev_err(gna_priv->misc.this_device, "could not enqueue score request %d\n", ret);
 		return ret;
 	}
 
 	score_args.out.request_id = request_id;
 	if (copy_to_user(argptr, &score_args, sizeof(score_args))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy score ioctl status to user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy score ioctl status to user\n");
 		return -EFAULT;
 	}
 
@@ -63,7 +63,7 @@ static int gna_ioctl_wait(struct file *f, void __user *argptr)
 	ret = 0;
 
 	if (copy_from_user(&wait_data, argptr, sizeof(wait_data))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy wait ioctl data from user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy wait ioctl data from user\n");
 		return -EFAULT;
 	}
 
@@ -73,7 +73,7 @@ static int gna_ioctl_wait(struct file *f, void __user *argptr)
 	score_request = gna_find_request_by_id(request_id, gna_priv);
 
 	if (!score_request) {
-		dev_err(&gna_priv->pdev->dev, "could not find request with id: %llu\n", request_id);
+		dev_err(gna_priv->misc.this_device, "could not find request with id: %llu\n", request_id);
 		return -EINVAL;
 	}
 
@@ -82,17 +82,17 @@ static int gna_ioctl_wait(struct file *f, void __user *argptr)
 		return -EINVAL;
 	}
 
-	dev_dbg(&gna_priv->pdev->dev, "waiting for request %llu for timeout %u\n", request_id, timeout);
+	dev_dbg(gna_priv->misc.this_device, "waiting for request %llu for timeout %u\n", request_id, timeout);
 
 	ret = wait_event_interruptible_timeout(score_request->waitq, score_request->state == DONE,
 					       msecs_to_jiffies(timeout));
 	if (ret == 0 || ret == -ERESTARTSYS) {
-		dev_err(&gna_priv->pdev->dev, "request timed out, id: %llu\n", request_id);
+		dev_err(gna_priv->misc.this_device, "request timed out, id: %llu\n", request_id);
 		kref_put(&score_request->refcount, gna_request_release);
 		return -EBUSY;
 	}
 
-	dev_dbg(&gna_priv->pdev->dev, "request wait completed with %d req id %llu\n", ret, request_id);
+	dev_dbg(gna_priv->misc.this_device, "request wait completed with %d req id %llu\n", ret, request_id);
 
 	wait_data.out.hw_perf = score_request->hw_perf;
 	wait_data.out.drv_perf = score_request->drv_perf;
@@ -100,14 +100,14 @@ static int gna_ioctl_wait(struct file *f, void __user *argptr)
 
 	ret = score_request->status;
 
-	dev_dbg(&gna_priv->pdev->dev, "request status %d, hw status: %#x\n",
+	dev_dbg(gna_priv->misc.this_device, "request status %d, hw status: %#x\n",
 		score_request->status, score_request->hw_status);
 	kref_put(&score_request->refcount, gna_request_release);
 
 	gna_delete_request_by_id(request_id, gna_priv);
 
 	if (copy_to_user(argptr, &wait_data, sizeof(wait_data))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy wait ioctl status to user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy wait ioctl status to user\n");
 		ret = -EFAULT;
 	}
 
@@ -123,7 +123,7 @@ static int gna_ioctl_map(struct gna_file_private *file_priv, void __user *argptr
 	gna_priv = file_priv->gna_priv;
 
 	if (copy_from_user(&gna_mem, argptr, sizeof(gna_mem))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy userptr ioctl data from user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy userptr ioctl data from user\n");
 		return -EFAULT;
 	}
 
@@ -132,7 +132,7 @@ static int gna_ioctl_map(struct gna_file_private *file_priv, void __user *argptr
 		return ret;
 
 	if (copy_to_user(argptr, &gna_mem, sizeof(gna_mem))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy userptr ioctl status to user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy userptr ioctl status to user\n");
 		return -EFAULT;
 	}
 
@@ -154,13 +154,13 @@ static int gna_ioctl_free(struct gna_file_private *file_priv, unsigned long arg)
 	mutex_unlock(&gna_priv->memidr_lock);
 
 	if (!mo) {
-		dev_warn(&gna_priv->pdev->dev, "memory object not found\n");
+		dev_warn(gna_priv->misc.this_device, "memory object not found\n");
 		return -EINVAL;
 	}
 
 	queue_work(gna_priv->request_wq, &mo->work);
 	if (wait_event_interruptible(mo->waitq, true)) {
-		dev_dbg(&gna_priv->pdev->dev, "wait interrupted\n");
+		dev_dbg(gna_priv->misc.this_device, "wait interrupted\n");
 		return -ETIME;
 	}
 
@@ -184,7 +184,7 @@ static int gna_ioctl_getparam(struct gna_private *gna_priv, void __user *argptr)
 	int ret;
 
 	if (copy_from_user(&param, argptr, sizeof(param))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy getparam ioctl data from user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy getparam ioctl data from user\n");
 		return -EFAULT;
 	}
 
@@ -193,7 +193,7 @@ static int gna_ioctl_getparam(struct gna_private *gna_priv, void __user *argptr)
 		return ret;
 
 	if (copy_to_user(argptr, &param, sizeof(param))) {
-		dev_err(&gna_priv->pdev->dev, "could not copy getparam ioctl status to user\n");
+		dev_err(gna_priv->misc.this_device, "could not copy getparam ioctl status to user\n");
 		return -EFAULT;
 	}
 
@@ -240,7 +240,7 @@ long gna_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		break;
 
 	default:
-		dev_warn(&gna_priv->pdev->dev, "wrong ioctl %#x\n", cmd);
+		dev_warn(gna_priv->misc.this_device, "wrong ioctl %#x\n", cmd);
 		ret = -EINVAL;
 		break;
 	}
diff --git a/drivers/misc/intel/gna/gna_mem.c b/drivers/misc/intel/gna/gna_mem.c
index ce1691d68edb..d81dc8f7f2df 100644
--- a/drivers/misc/intel/gna/gna_mem.c
+++ b/drivers/misc/intel/gna/gna_mem.c
@@ -159,7 +159,7 @@ void gna_mmu_add(struct gna_private *gna_priv, struct gna_memory_object *mo)
 	j = mmu->filled_pages;
 	sgl = mo->sgt->sgl;
 	if (!sgl) {
-		dev_warn(&gna_priv->pdev->dev, "empty scatter list in memory object\n");
+		dev_warn(gna_priv->misc.this_device, "empty scatter list in memory object\n");
 		goto warn_empty_sgl;
 	}
 	sg_page = sg_dma_address(sgl);
@@ -201,7 +201,7 @@ void gna_mmu_add(struct gna_private *gna_priv, struct gna_memory_object *mo)
 	mmu->hwdesc->mmu.vamaxaddr =
 		(mmu->filled_pts * PAGE_SIZE * GNA_PGDIR_ENTRIES) +
 		(mmu->filled_pages * PAGE_SIZE) - 1;
-	dev_dbg(&gna_priv->pdev->dev, "vamaxaddr set to %u\n", mmu->hwdesc->mmu.vamaxaddr);
+	dev_dbg(gna_priv->misc.this_device, "vamaxaddr set to %u\n", mmu->hwdesc->mmu.vamaxaddr);
 
 warn_empty_sgl:
 	mutex_unlock(&gna_priv->mmu_lock);
@@ -255,20 +255,20 @@ static int gna_get_pages(struct gna_memory_object *mo, u64 offset, u64 size)
 	gna_priv = mo->gna_priv;
 
 	if (mo->pages) {
-		dev_warn(&gna_priv->pdev->dev, "pages are already pinned\n");
+		dev_warn(gna_priv->misc.this_device, "pages are already pinned\n");
 		return -EFAULT;
 	}
 
 	/* using vmalloc because num_pages can be large */
 	skip_size = round_down(offset, PAGE_SIZE);
 	effective_address = mo->user_address + skip_size;
-	dev_dbg(&gna_priv->pdev->dev, "user address %llx\n", mo->user_address);
-	dev_dbg(&gna_priv->pdev->dev, "effective user address %llx\n", effective_address);
+	dev_dbg(gna_priv->misc.this_device, "user address %llx\n", mo->user_address);
+	dev_dbg(gna_priv->misc.this_device, "effective user address %llx\n", effective_address);
 
 	effective_size = gna_buffer_get_size(offset, size);
 
 	num_pages = effective_size >> PAGE_SHIFT;
-	dev_dbg(&gna_priv->pdev->dev, "allocating %d pages\n", num_pages);
+	dev_dbg(gna_priv->misc.this_device, "allocating %d pages\n", num_pages);
 	pages = kvmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages) {
 		ret = -ENOMEM;
@@ -289,12 +289,12 @@ static int gna_get_pages(struct gna_memory_object *mo, u64 offset, u64 size)
 
 	if (num_pinned <= 0) {
 		ret = num_pinned;
-		dev_err(&gna_priv->pdev->dev, "function get_user_pages_remote() failed\n");
+		dev_err(gna_priv->misc.this_device, "function get_user_pages_remote() failed\n");
 		goto err_free_pages;
 	}
 	if (num_pinned < num_pages) {
 		ret = -EFAULT;
-		dev_err(&gna_priv->pdev->dev,
+		dev_err(gna_priv->misc.this_device,
 			"get_user_pages_remote() pinned fewer pages number than requested\n");
 		goto err_free_pages;
 	}
@@ -307,19 +307,19 @@ static int gna_get_pages(struct gna_memory_object *mo, u64 offset, u64 size)
 
 	ret = sg_alloc_table_from_pages(sgt, pages, num_pinned, 0, mo->memory_size, GFP_KERNEL);
 	if (ret) {
-		dev_err(&gna_priv->pdev->dev, "could not alloc scatter list\n");
+		dev_err(gna_priv->misc.this_device, "could not alloc scatter list\n");
 		goto err_free_sgt;
 	}
 
 	if (IS_ERR(sgt->sgl)) {
-		dev_err(&gna_priv->pdev->dev, "sgl allocation failed\n");
+		dev_err(gna_priv->misc.this_device, "sgl allocation failed\n");
 		ret = PTR_ERR(sgt->sgl);
 		goto err_free_sgt;
 	}
 
 	ents = pci_map_sg(gna_priv->pdev, sgt->sgl, sgt->nents, PCI_DMA_BIDIRECTIONAL);
 	if (ents <= 0) {
-		dev_err(&gna_priv->pdev->dev, "could not map scatter gather list\n");
+		dev_err(gna_priv->misc.this_device, "could not map scatter gather list\n");
 		ret = -EIO;
 		goto err_free_sgl;
 	}
@@ -358,7 +358,7 @@ static void gna_put_pages(struct gna_memory_object *mo)
 	gna_priv = mo->gna_priv;
 
 	if (!mo->pages) {
-		dev_warn(&gna_priv->pdev->dev, "memory object has no pages %llu\n", mo->memory_id);
+		dev_warn(gna_priv->misc.this_device, "memory object has no pages %llu\n", mo->memory_id);
 		return;
 	}
 
@@ -417,17 +417,17 @@ int gna_map_memory(struct gna_file_private *file_priv, union gna_memory_map *gna
 	gna_priv = file_priv->gna_priv;
 
 	if (gna_mem->in.address & ~PAGE_MASK) {
-		dev_err(&gna_priv->pdev->dev, "user pointer not page aligned\n");
+		dev_err(gna_priv->misc.this_device, "user pointer not page aligned\n");
 		return -EINVAL;
 	}
 
 	if (!gna_mem->in.size) {
-		dev_err(&gna_priv->pdev->dev, "invalid user memory size\n");
+		dev_err(gna_priv->misc.this_device, "invalid user memory size\n");
 		return -EINVAL;
 	}
 
 	if (!access_ok(u64_to_user_ptr(gna_mem->in.address), gna_mem->in.size)) {
-		dev_err(&gna_priv->pdev->dev, "invalid user pointer\n");
+		dev_err(gna_priv->misc.this_device, "invalid user pointer\n");
 		return -EINVAL;
 	}
 
@@ -452,7 +452,7 @@ int gna_map_memory(struct gna_file_private *file_priv, union gna_memory_map *gna
 	mutex_unlock(&gna_priv->memidr_lock);
 
 	if (memory_id < 0) {
-		dev_err(&gna_priv->pdev->dev, "idr allocation for memory failed\n");
+		dev_err(gna_priv->misc.this_device, "idr allocation for memory failed\n");
 		ret = -EFAULT;
 		goto err_free_mo;
 	}
diff --git a/drivers/misc/intel/gna/gna_request.c b/drivers/misc/intel/gna/gna_request.c
index ba9bac358270..f913a54bb1c3 100644
--- a/drivers/misc/intel/gna/gna_request.c
+++ b/drivers/misc/intel/gna/gna_request.c
@@ -39,7 +39,7 @@ static void gna_request_update_status(struct gna_request *score_request)
 			score_request->hw_perf.total = total_cycles;
 			score_request->hw_perf.stall = stall_cycles;
 		} else
-			dev_warn(&gna_priv->pdev->dev, "GNA statistics missing\n");
+			dev_warn(gna_priv->misc.this_device, "GNA statistics missing\n");
 	}
 	if (unlikely(hw_status & GNA_ERROR))
 		gna_print_error_status(gna_priv, hw_status);
@@ -57,7 +57,7 @@ static void gna_request_process(struct work_struct *work)
 
 	score_request = container_of(work, struct gna_request, work);
 	gna_priv = score_request->gna_priv;
-	dev_dbg(&gna_priv->pdev->dev, "processing request %llu\n", score_request->request_id);
+	dev_dbg(gna_priv->misc.this_device, "processing request %llu\n", score_request->request_id);
 
 	score_request->state = ACTIVE;
 
@@ -85,7 +85,7 @@ static void gna_request_process(struct work_struct *work)
 			!gna_priv->dev_busy, hw_timeout);
 
 	if (!hw_timeout)
-		dev_warn(&gna_priv->pdev->dev, "hardware timeout occurred\n");
+		dev_warn(gna_priv->misc.this_device, "hardware timeout occurred\n");
 
 	gna_priv->hw_status = gna_reg_read(gna_priv->bar0_base, GNA_MMIO_STS);
 
@@ -102,7 +102,7 @@ static void gna_request_process(struct work_struct *work)
 			mo->ops->put_pages(mo);
 			mutex_unlock(&mo->page_lock);
 		} else {
-			dev_warn(&gna_priv->pdev->dev, "mo not found %llu\n", buffer->memory_id);
+			dev_warn(gna_priv->misc.this_device, "mo not found %llu\n", buffer->memory_id);
 		}
 	}
 
@@ -115,7 +115,7 @@ static void gna_request_process(struct work_struct *work)
 
 end:
 	score_request->drv_perf.completion = ktime_get_ns();
-	dev_dbg(&gna_priv->pdev->dev, "request %llu done, waking processes\n",
+	dev_dbg(gna_priv->misc.this_device, "request %llu done, waking processes\n",
 		score_request->request_id);
 	score_request->state = DONE;
 	wake_up_interruptible_all(&score_request->waitq);
@@ -136,7 +136,7 @@ static struct gna_request *gna_request_create(struct gna_file_private *file_priv
 		return NULL;
 	kref_init(&score_request->refcount);
 
-	dev_dbg(&gna_priv->pdev->dev, "layer_base %d layer_count %d\n",
+	dev_dbg(gna_priv->misc.this_device, "layer_base %d layer_count %d\n",
 		compute_cfg->layer_base, compute_cfg->layer_count);
 
 	score_request->request_id = atomic_inc_return(&gna_priv->request_count);
@@ -166,12 +166,12 @@ static int gna_validate_patches(struct gna_private *gna_priv, __u64 buffer_size,
 
 	for (idx = 0; idx < count; ++idx) {
 		if (patches[idx].size > 8) {
-			dev_err(&gna_priv->pdev->dev, "invalid patch size: %llu\n", patches[idx].size);
+			dev_err(gna_priv->misc.this_device, "invalid patch size: %llu\n", patches[idx].size);
 			return -EINVAL;
 		}
 
 		if (!gna_validate_ranges(buffer_size, patches[idx].offset, patches[idx].size)) {
-			dev_err(&gna_priv->pdev->dev,
+			dev_err(gna_priv->misc.this_device,
 				"patch out of bounds. buffer size: %llu, patch offset/size:%llu/%llu\n",
 				buffer_size, patches[idx].offset, patches[idx].size);
 			return -EINVAL;
@@ -204,14 +204,14 @@ static int gna_buffer_fill_patches(struct gna_buffer *buffer, struct gna_private
 
 	if (copy_from_user(patches, u64_to_user_ptr(patches_user),
 				sizeof(struct gna_memory_patch) * patch_count)) {
-		dev_err(&gna_priv->pdev->dev, "copy %llu patches from user failed\n", patch_count);
+		dev_err(gna_priv->misc.this_device, "copy %llu patches from user failed\n", patch_count);
 		ret = -EFAULT;
 		goto err_fill_patches;
 	}
 
 	ret = gna_validate_patches(gna_priv, buffer->size, patches, patch_count);
 	if (ret) {
-		dev_err(&gna_priv->pdev->dev, "patches failed validation\n");
+		dev_err(gna_priv->misc.this_device, "patches failed validation\n");
 		goto err_fill_patches;
 	}
 
@@ -246,7 +246,7 @@ static int gna_request_fill_buffers(struct gna_request *score_request,
 
 	if (copy_from_user(buffer_list, u64_to_user_ptr(compute_cfg->buffers_ptr),
 			sizeof(*buffer_list) * buffer_count)) {
-		dev_err(&gna_priv->pdev->dev, "copying %llu buffers failed\n", buffer_count);
+		dev_err(gna_priv->misc.this_device, "copying %llu buffers failed\n", buffer_count);
 		ret = -EFAULT;
 		goto err_free_buffers;
 	}
@@ -257,7 +257,7 @@ static int gna_request_fill_buffers(struct gna_request *score_request,
 
 		for (j = 0; j < i; j++) {
 			if (buffer_list[j].memory_id == memory_id) {
-				dev_err(&gna_priv->pdev->dev,
+				dev_err(gna_priv->misc.this_device,
 					"doubled memory id in score config. id:%llu\n", memory_id);
 				ret = -EINVAL;
 				goto err_zero_patch_ptr;
@@ -267,7 +267,7 @@ static int gna_request_fill_buffers(struct gna_request *score_request,
 		buffers_total_size +=
 			gna_buffer_get_size(buffer->offset, buffer->size);
 		if (buffers_total_size > gna_priv->info.max_hw_mem) {
-			dev_err(&gna_priv->pdev->dev, "buffers' total size too big\n");
+			dev_err(gna_priv->misc.this_device, "buffers' total size too big\n");
 			ret = -EINVAL;
 			goto err_zero_patch_ptr;
 		}
@@ -276,14 +276,14 @@ static int gna_request_fill_buffers(struct gna_request *score_request,
 		mo = idr_find(&gna_priv->memory_idr, memory_id);
 		if (!mo) {
 			mutex_unlock(&gna_priv->memidr_lock);
-			dev_err(&gna_priv->pdev->dev, "memory object %llu not found\n", memory_id);
+			dev_err(gna_priv->misc.this_device, "memory object %llu not found\n", memory_id);
 			ret = -EINVAL;
 			goto err_zero_patch_ptr;
 		}
 		mutex_unlock(&gna_priv->memidr_lock);
 
 		if (mo->fd != score_request->fd) {
-			dev_err(&gna_priv->pdev->dev,
+			dev_err(gna_priv->misc.this_device,
 				"memory object from another file. %p != %p\n",
 				mo->fd, score_request->fd);
 			ret = -EINVAL;
@@ -291,7 +291,7 @@ static int gna_request_fill_buffers(struct gna_request *score_request,
 		}
 
 		if (!gna_validate_ranges(mo->memory_size, buffer->offset, buffer->size)) {
-			dev_err(&gna_priv->pdev->dev,
+			dev_err(gna_priv->misc.this_device,
 				"buffer out of bounds. mo size: %llu, buffer offset/size:%llu/%llu\n",
 				mo->memory_size, buffer->offset, buffer->size);
 			ret = -EINVAL;
diff --git a/drivers/misc/intel/gna/gna_score.c b/drivers/misc/intel/gna/gna_score.c
index 794039d2da43..70ad867e215e 100644
--- a/drivers/misc/intel/gna/gna_score.c
+++ b/drivers/misc/intel/gna/gna_score.c
@@ -30,23 +30,23 @@ int gna_validate_score_config(struct gna_compute_cfg *compute_cfg,
 	gna_priv = file_priv->gna_priv;
 
 	if (compute_cfg->gna_mode > GNA_MODE_XNN) {
-		dev_err(&gna_priv->pdev->dev, "invalid mode\n");
+		dev_err(gna_priv->misc.this_device, "invalid mode\n");
 		return -EINVAL;
 	}
 
 	if (compute_cfg->layer_count > gna_priv->info.max_layer_count) {
-		dev_err(&gna_priv->pdev->dev, "max layer count exceeded\n");
+		dev_err(gna_priv->misc.this_device, "max layer count exceeded\n");
 		return -EINVAL;
 	}
 
 	if (compute_cfg->buffer_count == 0) {
-		dev_err(&gna_priv->pdev->dev, "no buffers\n");
+		dev_err(gna_priv->misc.this_device, "no buffers\n");
 		return -EINVAL;
 	}
 
 	buffers_size = sizeof(struct gna_buffer) * compute_cfg->buffer_count;
 	if (!access_ok(u64_to_user_ptr(compute_cfg->buffers_ptr), buffers_size)) {
-		dev_err(&gna_priv->pdev->dev, "invalid buffers pointer\n");
+		dev_err(gna_priv->misc.this_device, "invalid buffers pointer\n");
 		return -EINVAL;
 	}
 
@@ -63,7 +63,7 @@ static int gna_do_patch_memory(struct gna_private *gna_priv, struct gna_memory_o
 	value = patch->value;
 	size = patch->size;
 	dest = (u8 *)vaddr + patch->offset;
-	dev_dbg(&gna_priv->pdev->dev, "patch offset: %llu, size: %zu, value: %llu\n",
+	dev_dbg(gna_priv->misc.this_device, "patch offset: %llu, size: %zu, value: %llu\n",
 		patch->offset, size, value);
 
 	switch (size) {
@@ -97,7 +97,7 @@ static int gna_mem_patch_memory(struct gna_private *gna_priv, struct gna_buffer
 	int ret = 0;
 	u32 i;
 
-	dev_dbg(&gna_priv->pdev->dev, "memory_id: %llu, patch_count, %llu\n",
+	dev_dbg(gna_priv->misc.this_device, "memory_id: %llu, patch_count, %llu\n",
 		buffer->memory_id, buffer->patch_count);
 
 	mutex_lock(&gna_priv->memidr_lock);
@@ -179,7 +179,7 @@ static int gna_copy_gmm_config(struct gna_private *gna_priv,
 
 	buffer = gna_find_buffer(buffer_list, buffer_count, mmu_offset, &memory_offset);
 	if (!buffer) {
-		dev_dbg(&gna_priv->pdev->dev, "buffer not found\n");
+		dev_dbg(gna_priv->misc.this_device, "buffer not found\n");
 		return -EINVAL;
 	}
 
@@ -187,13 +187,13 @@ static int gna_copy_gmm_config(struct gna_private *gna_priv,
 	mo = idr_find(&gna_priv->memory_idr, buffer->memory_id);
 	mutex_unlock(&gna_priv->memidr_lock);
 	if (!mo) {
-		dev_dbg(&gna_priv->pdev->dev, "memory object not found\n");
+		dev_dbg(gna_priv->misc.this_device, "memory object not found\n");
 		return -EFAULT;
 	}
 
 	vaddr = vm_map_ram(mo->pages, mo->num_pinned, 0);
 	if (!vaddr) {
-		dev_dbg(&gna_priv->pdev->dev, "mapping failed\n");
+		dev_dbg(gna_priv->misc.this_device, "mapping failed\n");
 		return -EFAULT;
 	}
 
@@ -230,9 +230,9 @@ int gna_score(struct gna_request *score_request)
 
 	buffer = score_request->buffer_list;
 	buffer_count = score_request->buffer_count;
-	dev_dbg(&gna_priv->pdev->dev, "buffer count: %llu\n", buffer_count);
+	dev_dbg(gna_priv->misc.this_device, "buffer count: %llu\n", buffer_count);
 	for (i = 0; i < buffer_count; i++, buffer++) {
-		dev_dbg(&gna_priv->pdev->dev, "patch count: %llu\n", buffer->patch_count);
+		dev_dbg(gna_priv->misc.this_device, "patch count: %llu\n", buffer->patch_count);
 		ret = gna_mem_patch_memory(gna_priv, buffer);
 		if (ret)
 			goto err_put_pages;
@@ -240,13 +240,13 @@ int gna_score(struct gna_request *score_request)
 
 	switch (compute_cfg->gna_mode) {
 	case GNA_MODE_XNN:
-		dev_dbg(&gna_priv->pdev->dev, "xNN mode, labase: %d, lacount: %d\n",
+		dev_dbg(gna_priv->misc.this_device, "xNN mode, labase: %d, lacount: %d\n",
 			compute_cfg->layer_base, compute_cfg->layer_count);
 		xnn_config->labase = compute_cfg->layer_base;
 		xnn_config->lacount = compute_cfg->layer_count;
 		break;
 	case GNA_MODE_GMM:
-		dev_dbg(&gna_priv->pdev->dev, "GMM mode, offset: %d\n", compute_cfg->layer_base);
+		dev_dbg(gna_priv->misc.this_device, "GMM mode, offset: %d\n", compute_cfg->layer_base);
 		ret = gna_copy_gmm_config(gna_priv, score_request->buffer_list,
 					  buffer_count, compute_cfg->layer_base);
 		if (ret)
@@ -279,7 +279,7 @@ int gna_score(struct gna_request *score_request)
 			mutex_unlock(&mo->page_lock);
 		} else {
 			mo_valid = false;
-			dev_warn(&gna_priv->pdev->dev, "memory object not found %llu\n",
+			dev_warn(gna_priv->misc.this_device, "memory object not found %llu\n",
 				 buffer->memory_id);
 		}
 		buffer--;
-- 
2.28.0

