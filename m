Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F644CEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhKKBQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:16:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:54337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhKKBQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:16:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293652782"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="293652782"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602428032"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.236.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:55 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 5/5] firmware: upload: Enable cancel of firmware upload
Date:   Wed, 10 Nov 2021 17:13:45 -0800
Message-Id: <20211111011345.25049-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111011345.25049-1-russell.h.weight@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Firmware Upload framework to include a cancel IOCTL that can be
used to request that a firmware upload be cancelled. The IOCTL may return
ENODEV if there is no update in progress.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../driver-api/firmware/firmware-upload.rst   |  8 +++++++
 drivers/firmware/firmware-upload.c            | 24 +++++++++++++++++--
 include/linux/firmware/firmware-upload.h      |  4 ++++
 include/uapi/linux/firmware-upload.h          |  2 ++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/firmware/firmware-upload.rst b/Documentation/driver-api/firmware/firmware-upload.rst
index bf079d648b5c..1a0a487fd4d6 100644
--- a/Documentation/driver-api/firmware/firmware-upload.rst
+++ b/Documentation/driver-api/firmware/firmware-upload.rst
@@ -44,3 +44,11 @@ FW_UPLOAD_STATUS:
 Collect status for an on-going firmware upload. The status returned includes
 how much data remains to be transferred, the progress of the upload, and
 error information in the case of a failure.
+
+FW_UPLOAD_CANCEL:
+
+Request that an on-going firmware upload be cancelled. This IOCTL will
+return ENODEV if there is no upload in progress. Depending on the
+implementation of the lower-level driver, the cancellation may take affect
+immediately or it could block until a critical operation such as a FLASH
+is safely completed.
diff --git a/drivers/firmware/firmware-upload.c b/drivers/firmware/firmware-upload.c
index 507cd0f3740e..7677121ba49e 100644
--- a/drivers/firmware/firmware-upload.c
+++ b/drivers/firmware/firmware-upload.c
@@ -181,11 +181,20 @@ static int fw_upload_ioctl_status(struct fw_upload *fwl, unsigned long arg)
 	return 0;
 }
 
+static int fw_upload_ioctl_cancel(struct fw_upload *fwl, unsigned long arg)
+{
+	if (fwl->progress == FW_UPLOAD_PROG_IDLE)
+		return -ENODEV;
+
+	fwl->ops->cancel(fwl);
+	return 0;
+}
+
 static long fw_upload_ioctl(struct file *filp, unsigned int cmd,
 			    unsigned long arg)
 {
 	struct fw_upload *fwl = filp->private_data;
-	int ret = -ENOTTY;
+	int ret = 0;
 
 	mutex_lock(&fwl->lock);
 
@@ -196,6 +205,12 @@ static long fw_upload_ioctl(struct file *filp, unsigned int cmd,
 	case FW_UPLOAD_STATUS:
 		ret = fw_upload_ioctl_status(fwl, arg);
 		break;
+	case FW_UPLOAD_CANCEL:
+		ret = fw_upload_ioctl_cancel(fwl, arg);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
 	}
 
 	mutex_unlock(&fwl->lock);
@@ -226,6 +241,8 @@ static int fw_upload_release(struct inode *inode, struct file *filp)
 		goto close_exit;
 	}
 
+	fwl->ops->cancel(fwl);
+
 	mutex_unlock(&fwl->lock);
 	flush_work(&fwl->work);
 
@@ -260,7 +277,8 @@ fw_upload_register(struct device *parent, const struct fw_upload_ops *ops,
 	struct fw_upload *fwl;
 	int ret;
 
-	if (!ops || !ops->prepare || !ops->write || !ops->poll_complete) {
+	if (!ops || !ops->cancel || !ops->prepare ||
+	    !ops->write || !ops->poll_complete) {
 		dev_err(parent, "Attempt to register without all required ops\n");
 		return ERR_PTR(-ENOMEM);
 	}
@@ -339,6 +357,8 @@ void fw_upload_unregister(struct fw_upload *fwl)
 		goto unregister;
 	}
 
+	fwl->ops->cancel(fwl);
+
 	mutex_unlock(&fwl->lock);
 	flush_work(&fwl->work);
 
diff --git a/include/linux/firmware/firmware-upload.h b/include/linux/firmware/firmware-upload.h
index 63c6c65e7489..6f3971b8e117 100644
--- a/include/linux/firmware/firmware-upload.h
+++ b/include/linux/firmware/firmware-upload.h
@@ -26,6 +26,9 @@ struct fw_upload;
  *			    written.
  * @poll_complete:	    Required: Check for the completion of the
  *			    HW authentication/programming process.
+ * @cancel:		    Required: Request cancellation of update. This op
+ *			    is called from the context of a different kernel
+ *			    thread, so race conditions need to be considered.
  * @cleanup:		    Optional: Complements the prepare()
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
@@ -36,6 +39,7 @@ struct fw_upload_ops {
 	s32 (*write)(struct fw_upload *fwl, const u8 *data,
 		     u32 offset, u32 size);
 	u32 (*poll_complete)(struct fw_upload *fwl);
+	void (*cancel)(struct fw_upload *fwl);
 	void (*cleanup)(struct fw_upload *fwl);
 };
 
diff --git a/include/uapi/linux/firmware-upload.h b/include/uapi/linux/firmware-upload.h
index b8d96ee3f646..3bf985d27256 100644
--- a/include/uapi/linux/firmware-upload.h
+++ b/include/uapi/linux/firmware-upload.h
@@ -68,4 +68,6 @@ struct fw_upload_status {
 
 #define FW_UPLOAD_STATUS	_IOR(FW_UPLOAD_MAGIC, 1, struct fw_upload_status)
 
+#define FW_UPLOAD_CANCEL	_IO(FW_UPLOAD_MAGIC, 2)
+
 #endif /* _UAPI_LINUX_FW_UPLOAD_H */
-- 
2.25.1

