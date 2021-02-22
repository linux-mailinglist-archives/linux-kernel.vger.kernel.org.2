Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17773221EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBVWGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhBVWF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:05:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41FF664E05;
        Mon, 22 Feb 2021 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031515;
        bh=m84unYEJzlQcZ6rcPW7ivXSDy7codFkPQXLpwRT9iNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHSilZ2s4ypI31N5U2+Gr4NffLn2Bl2OdCtorpR62jjUSz7raN4J6wX0OIFxhbFWC
         IrABcTmTHbFsx7aq0DrmtW/A1q9MOsoHP/dsk9dVkISCZS2jQqDh0uaPUWIInhCK4G
         ajo4yQdFQNHSGhcm/UciemI0knMjqciFbw83c4Q8HyyVdb5Q5rFjvxZGuY8wMhkX6a
         3iW4T4H59jj4FYXPI+hb8abqLANnML5wUOJLjLLHo9gOBkRMNbQDfaTUZbC94DjF0i
         7wBUkm4Jy6ke9CH7dBaAsxR/ixekkhQK/k2EtluGheTE0ZaB6HBi1hYMqRtOxes9bB
         nEQbD8PbjfMsw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/2] habanalabs: Disable file operations after device is removed
Date:   Tue, 23 Feb 2021 00:05:08 +0200
Message-Id: <20210222220508.4659-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220508.4659-1-ogabbay@kernel.org>
References: <20210222220508.4659-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

A device can be removed from the PCI subsystem while a process holds the
file descriptor opened.
In such a case, the driver attempts to kill the process, but as it is
still possible that the process will be alive after this step, the
device removal will complete, and we will end up with a process object
that points to a device object which was already released.

To prevent the usage of this released device object, disable the
following file operations for this process object, and avoid the cleanup
steps when the file descriptor is eventually closed.
The latter is just a best effort, as memory leak will occur.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 40 ++++++++++++++++---
 .../misc/habanalabs/common/habanalabs_ioctl.c | 12 ++++++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9ecd805f0e88..334009e83823 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -93,12 +93,19 @@ void hl_hpriv_put(struct hl_fpriv *hpriv)
 static int hl_device_release(struct inode *inode, struct file *filp)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
+	struct hl_device *hdev = hpriv->hdev;
+
+	filp->private_data = NULL;
+
+	if (!hdev) {
+		pr_crit("Closing FD after device was removed. Memory leak will occur and it is advised to reboot.\n");
+		put_pid(hpriv->taskpid);
+		return 0;
+	}
 
 	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 
-	filp->private_data = NULL;
-
 	hl_hpriv_put(hpriv);
 
 	return 0;
@@ -107,16 +114,19 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
-	struct hl_device *hdev;
+	struct hl_device *hdev = hpriv->hdev;
 
 	filp->private_data = NULL;
 
-	hdev = hpriv->hdev;
+	if (!hdev) {
+		pr_err("Closing FD after device was removed\n");
+		goto out;
+	}
 
 	mutex_lock(&hdev->fpriv_list_lock);
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
-
+out:
 	put_pid(hpriv->taskpid);
 
 	kfree(hpriv);
@@ -136,8 +146,14 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
+	struct hl_device *hdev = hpriv->hdev;
 	unsigned long vm_pgoff;
 
+	if (!hdev) {
+		pr_err_ratelimited("Trying to mmap after device was removed! Please close FD\n");
+		return -ENODEV;
+	}
+
 	vm_pgoff = vma->vm_pgoff;
 	vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
 
@@ -885,6 +901,16 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 	return -EBUSY;
 }
 
+static void device_disable_open_processes(struct hl_device *hdev)
+{
+	struct hl_fpriv *hpriv;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node)
+		hpriv->hdev = NULL;
+	mutex_unlock(&hdev->fpriv_list_lock);
+}
+
 /*
  * hl_device_reset - reset the device
  *
@@ -1558,8 +1584,10 @@ void hl_device_fini(struct hl_device *hdev)
 		HL_PENDING_RESET_LONG_SEC);
 
 	rc = device_kill_open_processes(hdev, HL_PENDING_RESET_LONG_SEC);
-	if (rc)
+	if (rc) {
 		dev_crit(hdev->dev, "Failed to kill all open processes\n");
+		device_disable_open_processes(hdev);
+	}
 
 	hl_cb_pool_fini(hdev);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 03af61cecd37..083a30969c5f 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -5,6 +5,8 @@
  * All Rights Reserved.
  */
 
+#define pr_fmt(fmt)	"habanalabs: " fmt
+
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
 
@@ -682,6 +684,11 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	const struct hl_ioctl_desc *ioctl = NULL;
 	unsigned int nr = _IOC_NR(cmd);
 
+	if (!hdev) {
+		pr_err_ratelimited("Sending ioctl after device was removed! Please close FD\n");
+		return -ENODEV;
+	}
+
 	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
 		ioctl = &hl_ioctls[nr];
 	} else {
@@ -700,6 +707,11 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
 	const struct hl_ioctl_desc *ioctl = NULL;
 	unsigned int nr = _IOC_NR(cmd);
 
+	if (!hdev) {
+		pr_err_ratelimited("Sending ioctl after device was removed! Please close FD\n");
+		return -ENODEV;
+	}
+
 	if (nr == _IOC_NR(HL_IOCTL_INFO)) {
 		ioctl = &hl_ioctls_control[nr];
 	} else {
-- 
2.25.1

