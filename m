Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1A44CEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhKKBQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:16:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:54337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhKKBQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:16:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293652771"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="293652771"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:53 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602428006"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.236.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:51 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 1/5] firmware: Create firmware upload framework
Date:   Wed, 10 Nov 2021 17:13:41 -0800
Message-Id: <20211111011345.25049-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111011345.25049-1-russell.h.weight@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Firmware Upload class driver provides a common API for uploading
firmware files to devices. The lower level device driver and/or the
target device are responsible for authenticating the data.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../driver-api/firmware/firmware-upload.rst   |  17 +++
 Documentation/driver-api/firmware/index.rst   |   1 +
 MAINTAINERS                                   |   8 ++
 drivers/firmware/Kconfig                      |   8 ++
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/firmware-upload.c            | 125 ++++++++++++++++++
 include/linux/firmware/firmware-upload.h      |  35 +++++
 7 files changed, 195 insertions(+)
 create mode 100644 Documentation/driver-api/firmware/firmware-upload.rst
 create mode 100644 drivers/firmware/firmware-upload.c
 create mode 100644 include/linux/firmware/firmware-upload.h

diff --git a/Documentation/driver-api/firmware/firmware-upload.rst b/Documentation/driver-api/firmware/firmware-upload.rst
new file mode 100644
index 000000000000..9f38f18be97a
--- /dev/null
+++ b/Documentation/driver-api/firmware/firmware-upload.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Firmware Upload Framework
+=========================
+
+Some devices load firmware from on-board FLASH when the card initializes.
+These cards do not require the request_firmware framework to load the
+firmware when the card boots, but they to require a utility to allow
+users to update the FLASH contents.
+
+The Firmware Upload framework provides a common API for user-space tools
+to manage firmware uploads to devices. Device drivers that instantiate the
+Firmware Upload class driver will interact with the target device to
+transfer and authenticate the firmware data. Uploads are performed in the
+context of a kernel worker thread in order to facilitate progress
+indicators during lengthy uploads.
diff --git a/Documentation/driver-api/firmware/index.rst b/Documentation/driver-api/firmware/index.rst
index 57415d657173..90c5db512d74 100644
--- a/Documentation/driver-api/firmware/index.rst
+++ b/Documentation/driver-api/firmware/index.rst
@@ -8,6 +8,7 @@ Linux Firmware API
    core
    efi/index
    request_firmware
+   firmware-upload
    other_interfaces
 
 .. only::  subproject and html
diff --git a/MAINTAINERS b/MAINTAINERS
index 8dfd5f4ae5e6..19b3d3ccc406 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7415,6 +7415,14 @@ F:	Documentation/firmware_class/
 F:	drivers/base/firmware_loader/
 F:	include/linux/firmware.h
 
+FIRMWARE UPLOADER
+M:	Russ Weight <russell.h.weight@intel.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/driver-api/firmware/firmware-upload.rst
+F:	drivers/firmware/firmware-upload.c
+F:	include/linux/firmware/firmware-upload.h
+
 FLASH ADAPTER DRIVER (IBM Flash Adapter 900GB Full Height PCI Flash Card)
 M:	Joshua Morris <josh.h.morris@us.ibm.com>
 M:	Philip Kelleher <pjk1939@linux.ibm.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 75cb91055c17..2a330371a76d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -293,6 +293,14 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+config FIRMWARE_UPLOAD
+	tristate "Firmware Upload Framework"
+	help
+	  The Firmware Upload class driver presents a common user API
+	  for uploading a firmware file to a device. It is the
+	  responsibility of the lower-level device driver and/or device to
+	  authenticate and disposition the firmware data.
+
 source "drivers/firmware/arm_ffa/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/cirrus/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4e58cb474a68..5dd2a3bf7fa7 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
+obj-$(CONFIG_FIRMWARE_UPLOAD)	+= firmware-upload.o
 
 obj-y				+= arm_ffa/
 obj-y				+= arm_scmi/
diff --git a/drivers/firmware/firmware-upload.c b/drivers/firmware/firmware-upload.c
new file mode 100644
index 000000000000..bc26df8b6b52
--- /dev/null
+++ b/drivers/firmware/firmware-upload.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Firmware Upload Framework
+ *
+ * Copyright (C) 2019-2021 Intel Corporation, Inc.
+ */
+
+#include <linux/firmware/firmware-upload.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#define FW_UPLOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
+static DEFINE_XARRAY_ALLOC(fw_upload_xa);
+
+static struct class *fw_upload_class;
+
+#define to_fw_upload(d) container_of(d, struct fw_upload, dev)
+
+/**
+ * fw_upload_register - create and register a Firmware Upload Device
+ *
+ * @parent: Firmware Upload device from pdev
+ * @ops:    Pointer to a structure of firmware upload callback functions
+ * @priv:   Firmware Upload private data
+ *
+ * Returns a struct fw_upload pointer on success, or ERR_PTR() on
+ * error. The caller of this function is responsible for calling
+ * fw_upload_unregister().
+ */
+struct fw_upload *
+fw_upload_register(struct device *parent, const struct fw_upload_ops *ops,
+		   void *priv)
+{
+	struct fw_upload *fwl;
+	int ret;
+
+	fwl = kzalloc(sizeof(*fwl), GFP_KERNEL);
+	if (!fwl)
+		return ERR_PTR(-ENOMEM);
+
+	ret = xa_alloc(&fw_upload_xa, &fwl->dev.id, fwl, FW_UPLOAD_XA_LIMIT,
+		       GFP_KERNEL);
+	if (ret)
+		goto error_kfree;
+
+	mutex_init(&fwl->lock);
+
+	fwl->priv = priv;
+	fwl->ops = ops;
+
+	fwl->dev.class = fw_upload_class;
+	fwl->dev.parent = parent;
+
+	ret = dev_set_name(&fwl->dev, "fw_upload%d", fwl->dev.id);
+	if (ret) {
+		dev_err(parent, "Failed to set device name: fw_upload%d\n",
+			fwl->dev.id);
+		goto error_device;
+	}
+
+	ret = device_register(&fwl->dev);
+	if (ret) {
+		put_device(&fwl->dev);
+		return ERR_PTR(ret);
+	}
+
+	return fwl;
+
+error_device:
+	xa_erase(&fw_upload_xa, fwl->dev.id);
+
+error_kfree:
+	kfree(fwl);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fw_upload_register);
+
+/**
+ * fw_upload_unregister - unregister a Firmware Upload device
+ *
+ * @fwl: pointer to struct fw_upload
+ *
+ * This function is intended for use in the parent driver's remove()
+ * function.
+ */
+void fw_upload_unregister(struct fw_upload *fwl)
+{
+	device_unregister(&fwl->dev);
+}
+EXPORT_SYMBOL_GPL(fw_upload_unregister);
+
+static void fw_upload_dev_release(struct device *dev)
+{
+	struct fw_upload *fwl = to_fw_upload(dev);
+
+	xa_erase(&fw_upload_xa, fwl->dev.id);
+	kfree(fwl);
+}
+
+static int __init fw_upload_class_init(void)
+{
+	pr_info("Firmware Upload Framework\n");
+
+	fw_upload_class = class_create(THIS_MODULE, "fw_upload");
+	if (IS_ERR(fw_upload_class))
+		return PTR_ERR(fw_upload_class);
+
+	fw_upload_class->dev_release = fw_upload_dev_release;
+
+	return 0;
+}
+
+static void __exit fw_upload_class_exit(void)
+{
+	class_destroy(fw_upload_class);
+	WARN_ON(!xa_empty(&fw_upload_xa));
+}
+
+MODULE_DESCRIPTION("Firmware Upload Framework");
+MODULE_LICENSE("GPL v2");
+
+subsys_initcall(fw_upload_class_init);
+module_exit(fw_upload_class_exit)
diff --git a/include/linux/firmware/firmware-upload.h b/include/linux/firmware/firmware-upload.h
new file mode 100644
index 000000000000..767e0bdded7b
--- /dev/null
+++ b/include/linux/firmware/firmware-upload.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for Firmware Upload Framework
+ *
+ * Copyright (C) 2019-2021 Intel Corporation, Inc.
+ */
+#ifndef _LINUX_FIRMWARE_UPLOAD_H
+#define _LINUX_FIRMWARE_UPLOAD_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct fw_upload;
+
+/**
+ * struct fw_upload_ops - device specific operations
+ */
+struct fw_upload_ops {
+};
+
+struct fw_upload {
+	struct device dev;
+	const struct fw_upload_ops *ops;
+	struct mutex lock;		/* protect data structure contents */
+	void *priv;
+};
+
+struct fw_upload *
+fw_upload_register(struct device *dev, const struct fw_upload_ops *ops,
+		   void *priv);
+
+void fw_upload_unregister(struct fw_upload *fwl);
+
+#endif
-- 
2.25.1

