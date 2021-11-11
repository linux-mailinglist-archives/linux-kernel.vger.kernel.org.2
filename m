Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5F44CEB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhKKBQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:16:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:54337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhKKBQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:16:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293652777"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="293652777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602428018"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.236.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:53 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 3/5] firmware: upload: Signal eventfd when complete
Date:   Wed, 10 Nov 2021 17:13:43 -0800
Message-Id: <20211111011345.25049-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111011345.25049-1-russell.h.weight@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amend the FW_UPLOAD_WRITE IOCTL implementation to include an eventfd file
descriptor as a parameter. The eventfd will be signalled when the firmware
upload completes.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../driver-api/firmware/firmware-upload.rst   |  2 ++
 drivers/firmware/firmware-upload.c            | 22 +++++++++++++++++--
 include/linux/firmware/firmware-upload.h      |  2 ++
 include/uapi/linux/firmware-upload.h          |  3 ++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/firmware/firmware-upload.rst b/Documentation/driver-api/firmware/firmware-upload.rst
index 8a7c50087028..0165c18a62be 100644
--- a/Documentation/driver-api/firmware/firmware-upload.rst
+++ b/Documentation/driver-api/firmware/firmware-upload.rst
@@ -36,3 +36,5 @@ The FW_UPLOAD_WRITE IOCTL passes in the address of a data buffer and starts
 the firmware upload. This IOCTL returns immediately after assigning the work
 to a kernel worker thread. This is an exclusive operation; an attempt to
 start concurrent firmware uploads for the same device will fail with EBUSY.
+An eventfd file descriptor parameter is also passed to this IOCTL. It will
+be signalled at the completion of the firmware upload.
diff --git a/drivers/firmware/firmware-upload.c b/drivers/firmware/firmware-upload.c
index e930611262fb..f8ddacc72b1d 100644
--- a/drivers/firmware/firmware-upload.c
+++ b/drivers/firmware/firmware-upload.c
@@ -26,6 +26,7 @@ static void fw_upload_prog_complete(struct fw_upload *fwl)
 {
 	mutex_lock(&fwl->lock);
 	fwl->progress = FW_UPLOAD_PROG_IDLE;
+	eventfd_signal(fwl->finished, 1);
 	mutex_unlock(&fwl->lock);
 }
 
@@ -96,12 +97,15 @@ static void fw_upload_do_load(struct work_struct *work)
 	vfree(fwl->data);
 	fwl->data = NULL;
 	fw_upload_prog_complete(fwl);
+	eventfd_ctx_put(fwl->finished);
+	fwl->finished = NULL;
 }
 
 static int fw_upload_ioctl_write(struct fw_upload *fwl, unsigned long arg)
 {
 	struct fw_upload_write wb;
 	unsigned long minsz;
+	int ret;
 	u8 *buf;
 
 	if (fwl->driver_unload || fwl->progress != FW_UPLOAD_PROG_IDLE)
@@ -114,13 +118,23 @@ static int fw_upload_ioctl_write(struct fw_upload *fwl, unsigned long arg)
 	if (wb.flags)
 		return -EINVAL;
 
+	if (wb.evtfd < 0)
+		return -EINVAL;
+
 	buf = vzalloc(wb.size);
 	if (!buf)
 		return -ENOMEM;
 
 	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
-		vfree(buf);
-		return -EFAULT;
+		ret = -EFAULT;
+		goto exit_free;
+	}
+
+	fwl->finished = eventfd_ctx_fdget(wb.evtfd);
+	if (IS_ERR(fwl->finished)) {
+		ret = PTR_ERR(fwl->finished);
+		fwl->finished = NULL;
+		goto exit_free;
 	}
 
 	fwl->data = buf;
@@ -130,6 +144,10 @@ static int fw_upload_ioctl_write(struct fw_upload *fwl, unsigned long arg)
 	queue_work(system_long_wq, &fwl->work);
 
 	return 0;
+
+exit_free:
+	vfree(buf);
+	return ret;
 }
 
 static long fw_upload_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/firmware/firmware-upload.h b/include/linux/firmware/firmware-upload.h
index f80d5ba0c3f1..c96473fb1e6c 100644
--- a/include/linux/firmware/firmware-upload.h
+++ b/include/linux/firmware/firmware-upload.h
@@ -9,6 +9,7 @@
 
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/eventfd.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <uapi/linux/firmware-upload.h>
@@ -50,6 +51,7 @@ struct fw_upload {
 	u32 progress;
 	u32 err_code;			/* upload error code */
 	bool driver_unload;
+	struct eventfd_ctx *finished;
 	void *priv;
 };
 
diff --git a/include/uapi/linux/firmware-upload.h b/include/uapi/linux/firmware-upload.h
index 034550071911..5ac9079e1bf7 100644
--- a/include/uapi/linux/firmware-upload.h
+++ b/include/uapi/linux/firmware-upload.h
@@ -37,7 +37,7 @@
  *				struct fw_upload_write)
  *
  * Upload a data buffer to the target device. The user must provide the
- * data buffer and size.
+ * data buffer, size, and an eventfd file descriptor.
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -45,6 +45,7 @@ struct fw_upload_write {
 	/* Input */
 	__u32 flags;		/* Zero for now */
 	__u32 size;		/* Data size (in bytes) to be written */
+	__s32 evtfd;		/* File descriptor for completion signal */
 	__u64 buf;		/* User space address of source data */
 };
 
-- 
2.25.1

