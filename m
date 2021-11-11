Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F063044CEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhKKBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:16:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:54337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhKKBQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:16:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293652779"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="293652779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602428027"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.236.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:54 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 4/5] firmware: upload: Add status ioctl
Date:   Wed, 10 Nov 2021 17:13:44 -0800
Message-Id: <20211111011345.25049-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111011345.25049-1-russell.h.weight@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Firmware Upload framework to include a FW_UPLOAD_STATUS IOCTL
that can be used to monitor the progress of an ongoing firmware upload.
The status returned includes how much data remains to be transferred, the
progress of the firmware upload, and error information in the case of a
failure.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../driver-api/firmware/firmware-upload.rst   |  6 ++
 drivers/firmware/firmware-upload.c            | 56 +++++++++++++++----
 include/linux/firmware/firmware-upload.h      |  1 +
 include/uapi/linux/firmware-upload.h          | 17 ++++++
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/firmware/firmware-upload.rst b/Documentation/driver-api/firmware/firmware-upload.rst
index 0165c18a62be..bf079d648b5c 100644
--- a/Documentation/driver-api/firmware/firmware-upload.rst
+++ b/Documentation/driver-api/firmware/firmware-upload.rst
@@ -38,3 +38,9 @@ to a kernel worker thread. This is an exclusive operation; an attempt to
 start concurrent firmware uploads for the same device will fail with EBUSY.
 An eventfd file descriptor parameter is also passed to this IOCTL. It will
 be signalled at the completion of the firmware upload.
+
+FW_UPLOAD_STATUS:
+
+Collect status for an on-going firmware upload. The status returned includes
+how much data remains to be transferred, the progress of the upload, and
+error information in the case of a failure.
diff --git a/drivers/firmware/firmware-upload.c b/drivers/firmware/firmware-upload.c
index f8ddacc72b1d..507cd0f3740e 100644
--- a/drivers/firmware/firmware-upload.c
+++ b/drivers/firmware/firmware-upload.c
@@ -22,6 +22,21 @@ static dev_t fw_upload_devt;
 
 #define to_fw_upload(d) container_of(d, struct fw_upload, dev)
 
+static void fw_upload_update_progress(struct fw_upload *fwl, u32 new_progress)
+{
+	mutex_lock(&fwl->lock);
+	fwl->progress = new_progress;
+	mutex_unlock(&fwl->lock);
+}
+
+static void fw_upload_set_error(struct fw_upload *fwl, u32 err_code)
+{
+	mutex_lock(&fwl->lock);
+	fwl->err_progress = fwl->progress;
+	fwl->err_code = err_code;
+	mutex_unlock(&fwl->lock);
+}
+
 static void fw_upload_prog_complete(struct fw_upload *fwl)
 {
 	mutex_lock(&fwl->lock);
@@ -38,24 +53,24 @@ static void fw_upload_do_load(struct work_struct *work)
 	fwl = container_of(work, struct fw_upload, work);
 
 	if (fwl->driver_unload) {
-		fwl->err_code = FW_UPLOAD_ERR_CANCELED;
+		fw_upload_set_error(fwl, FW_UPLOAD_ERR_CANCELED);
 		goto idle_exit;
 	}
 
 	get_device(&fwl->dev);
 	if (!try_module_get(fwl->dev.parent->driver->owner)) {
-		fwl->err_code = FW_UPLOAD_ERR_BUSY;
+		fw_upload_set_error(fwl, FW_UPLOAD_ERR_BUSY);
 		goto putdev_exit;
 	}
 
-	fwl->progress = FW_UPLOAD_PROG_PREPARING;
+	fw_upload_update_progress(fwl, FW_UPLOAD_PROG_PREPARING);
 	ret = fwl->ops->prepare(fwl, fwl->data, fwl->remaining_size);
 	if (ret) {
-		fwl->err_code = ret;
+		fw_upload_set_error(fwl, ret);
 		goto modput_exit;
 	}
 
-	fwl->progress = FW_UPLOAD_PROG_WRITING;
+	fw_upload_update_progress(fwl, FW_UPLOAD_PROG_WRITING);
 	while (fwl->remaining_size) {
 		ret = fwl->ops->write(fwl, fwl->data, offset,
 					fwl->remaining_size);
@@ -65,7 +80,7 @@ static void fw_upload_do_load(struct work_struct *work)
 					 "write-op wrote zero data\n");
 				ret = -FW_UPLOAD_ERR_RW_ERROR;
 			}
-			fwl->err_code = -ret;
+			fw_upload_set_error(fwl, -ret);
 			goto done;
 		}
 
@@ -73,10 +88,10 @@ static void fw_upload_do_load(struct work_struct *work)
 		offset += ret;
 	}
 
-	fwl->progress = FW_UPLOAD_PROG_PROGRAMMING;
+	fw_upload_update_progress(fwl, FW_UPLOAD_PROG_PROGRAMMING);
 	ret = fwl->ops->poll_complete(fwl);
 	if (ret)
-		fwl->err_code = ret;
+		fw_upload_set_error(fwl, ret);
 
 done:
 	if (fwl->ops->cleanup)
@@ -150,20 +165,41 @@ static int fw_upload_ioctl_write(struct fw_upload *fwl, unsigned long arg)
 	return ret;
 }
 
+static int fw_upload_ioctl_status(struct fw_upload *fwl, unsigned long arg)
+{
+	struct fw_upload_status status;
+
+	memset(&status, 0, sizeof(status));
+	status.progress = fwl->progress;
+	status.remaining_size = fwl->remaining_size;
+	status.err_progress = fwl->err_progress;
+	status.err_code = fwl->err_code;
+
+	if (copy_to_user((void __user *)arg, &status, sizeof(status)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long fw_upload_ioctl(struct file *filp, unsigned int cmd,
 			    unsigned long arg)
 {
 	struct fw_upload *fwl = filp->private_data;
 	int ret = -ENOTTY;
 
+	mutex_lock(&fwl->lock);
+
 	switch (cmd) {
 	case FW_UPLOAD_WRITE:
-		mutex_lock(&fwl->lock);
 		ret = fw_upload_ioctl_write(fwl, arg);
-		mutex_unlock(&fwl->lock);
+		break;
+	case FW_UPLOAD_STATUS:
+		ret = fw_upload_ioctl_status(fwl, arg);
 		break;
 	}
 
+	mutex_unlock(&fwl->lock);
+
 	return ret;
 }
 
diff --git a/include/linux/firmware/firmware-upload.h b/include/linux/firmware/firmware-upload.h
index c96473fb1e6c..63c6c65e7489 100644
--- a/include/linux/firmware/firmware-upload.h
+++ b/include/linux/firmware/firmware-upload.h
@@ -49,6 +49,7 @@ struct fw_upload {
 	const u8 *data;			/* pointer to update data */
 	u32 remaining_size;		/* size remaining to transfer */
 	u32 progress;
+	u32 err_progress;		/* progress at time of error */
 	u32 err_code;			/* upload error code */
 	bool driver_unload;
 	struct eventfd_ctx *finished;
diff --git a/include/uapi/linux/firmware-upload.h b/include/uapi/linux/firmware-upload.h
index 5ac9079e1bf7..b8d96ee3f646 100644
--- a/include/uapi/linux/firmware-upload.h
+++ b/include/uapi/linux/firmware-upload.h
@@ -51,4 +51,21 @@ struct fw_upload_write {
 
 #define FW_UPLOAD_WRITE	_IOW(FW_UPLOAD_MAGIC, 0, struct fw_upload_write)
 
+/**
+ * FW_UPLOAD_STATUS - _IOR(FW_UPLOAD_MAGIC, 1, struct fw_upload_status)
+ *
+ * Request status information for an ongoing update.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct fw_upload_status {
+	/* Output */
+	__u32 remaining_size;	/* size remaining to transfer */
+	__u32 progress;		/* current progress of firmware upload */
+	__u32 err_progress;	/* progress at time of error */
+	__u32 err_code;		/* error code */
+};
+
+#define FW_UPLOAD_STATUS	_IOR(FW_UPLOAD_MAGIC, 1, struct fw_upload_status)
+
 #endif /* _UAPI_LINUX_FW_UPLOAD_H */
-- 
2.25.1

