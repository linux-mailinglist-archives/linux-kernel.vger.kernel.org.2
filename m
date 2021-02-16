Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0415031CD97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhBPQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:10:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:31319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhBPQJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:09:51 -0500
IronPort-SDR: fVxawjLMr4Mc/fZO/VQQFYSI22C4R6zYPhaf05ztRx2uV5qiuVvW1cuCJwhx7tgzY1It7RZnsD
 PFi9wKjSD4gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118413"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118413"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:56 -0800
IronPort-SDR: cLqlrOvYgZAnVgKq8pxk8/VzBuHdC8bc7ddmaftfXnLMf1gBifdIV3QWH1lYMDtG9dcgc6D4Da
 aFAKFQwnUWIg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336629"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:53 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 01/12] gna: add driver module
Date:   Tue, 16 Feb 2021 17:05:14 +0100
Message-Id: <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Add a new PCI driver for Intel(R) Gaussian & Neural Accelerator
with basic support like module loading and unloading. The full
function of the driver will be added by further changes.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 Documentation/misc-devices/gna.rst            |  48 ++++++
 Documentation/misc-devices/index.rst          |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/gna/Kbuild                       |   5 +
 drivers/misc/gna/Kconfig                      |  13 ++
 drivers/misc/gna/gna_device.c                 | 100 +++++++++++
 drivers/misc/gna/gna_device.h                 |  50 ++++++
 drivers/misc/gna/gna_driver.c                 |  65 ++++++++
 drivers/misc/gna/gna_driver.h                 |  41 +++++
 include/uapi/misc/gna.h                       | 155 ++++++++++++++++++
 13 files changed, 488 insertions(+)
 create mode 100644 Documentation/misc-devices/gna.rst
 create mode 100644 drivers/misc/gna/Kbuild
 create mode 100644 drivers/misc/gna/Kconfig
 create mode 100644 drivers/misc/gna/gna_device.c
 create mode 100644 drivers/misc/gna/gna_device.h
 create mode 100644 drivers/misc/gna/gna_driver.c
 create mode 100644 drivers/misc/gna/gna_driver.h
 create mode 100644 include/uapi/misc/gna.h

diff --git a/Documentation/misc-devices/gna.rst b/Documentation/misc-devices/gna.rst
new file mode 100644
index 000000000000..ed3d5a89271d
--- /dev/null
+++ b/Documentation/misc-devices/gna.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=====================================================
+Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA)
+=====================================================
+
+Acronyms
+--------
+GNA	- Gaussian & Neural Accelerator
+GMM	- Gaussian Mixer Model
+CNN	- Convolutional Neural Network
+RNN	- Recurrent Neural Networks
+DNN	- Deep Neural Networks
+
+Introduction
+------------
+The Intel(R) GNA is an Internal PCI fixed device available on several Intel platforms/SoCs.
+Feature set depends on the Intel Chipset SKU.
+
+Intel(R) GNA provides hardware accelerated computation for GMMs and Neural Networks.
+It supports several layer types: affine, recurrent, and convolutional among others.
+Hardware also provides helper layer types for copying and transposing matrices.
+
+Linux Driver
+------------
+Intel(R) GNA driver is a pci driver as Intel(R) GNA is a PCI device.
+The driver also registers a character device to expose file operations via dev node.
+
+The driver probes/removes PCI device, implements file operations, handles runtime
+power management, and interacts with hardware through MMIO registers.
+
+Multiple processes can independently file many requests to the driver. These requests are
+processed in a FIFO manner. The hardware can process one request at a time by using a FIFO
+queue.
+
+IOCTL
+-----
+Intel(R) GNA driver controls the device through IOCTL interfaces.
+Following IOCTL commands are supported:
+  GNA_IOCTL_PARAM_GET gets driver and device capabilities.
+
+  GNA_IOCTL_MEMORY_MAP lock user pages and GNA MMU setups for DMA transfer.
+
+  GNA_IOCTL_MEMORY_UNMAP unlocks user pages and releases GNA MMU structures.
+
+  GNA_IOCTL_COMPUTE submits a request to the device queue.
+
+  GNA_IOCTL_WAIT blocks and waits on the submitted request.
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 64420b3314fe..8cc01280e555 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -19,6 +19,7 @@ fit into other categories.
    bh1770glc
    eeprom
    c2port
+   gna
    ibmvmc
    ics932s401
    isl29003
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a4c75a28c839..9fad36a43f4a 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -115,6 +115,7 @@ Code  Seq#    Include File                                           Comments
 'B'   C0-FF  advanced bbus                                           <mailto:maassen@uni-freiburg.de>
 'C'   all    linux/soundcard.h                                       conflict!
 'C'   01-2F  linux/capi.h                                            conflict!
+'C'   01-5F  uapi/misc/gna.h                                         conflict!
 'C'   F0-FF  drivers/net/wan/cosa.h                                  conflict!
 'D'   all    arch/s390/include/asm/dasd.h
 'D'   40-5F  drivers/scsi/dpt/dtpi_ioctl.h
diff --git a/MAINTAINERS b/MAINTAINERS
index cc1e6a5ee6e6..c117b872564b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8933,6 +8933,13 @@ S:	Maintained
 F:	Documentation/fb/intelfb.rst
 F:	drivers/video/fbdev/intelfb/
 
+INTEL GNA PCI DRIVER
+M:	Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
+S:	Maintained
+F:	Documentation/misc-devices/gna.rst
+F:	drivers/misc/gna/*
+F:	include/uapi/misc/gna.h
+
 INTEL GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0d8099..892cdf0ec935 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -481,4 +481,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/gna/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e73330..e756f760692d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_INTEL_GNA)	        += gna/
diff --git a/drivers/misc/gna/Kbuild b/drivers/misc/gna/Kbuild
new file mode 100644
index 000000000000..863956d5761a
--- /dev/null
+++ b/drivers/misc/gna/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+gna-y := gna_device.o gna_driver.o
+
+obj-$(CONFIG_INTEL_GNA) += gna.o
diff --git a/drivers/misc/gna/Kconfig b/drivers/misc/gna/Kconfig
new file mode 100644
index 000000000000..9940f539d8af
--- /dev/null
+++ b/drivers/misc/gna/Kconfig
@@ -0,0 +1,13 @@
+#
+# Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA)
+#
+
+config INTEL_GNA
+	tristate "Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA)"
+	depends on X86_64 && PCI
+	help
+	  This option enables the Intel(R) Gaussian & Neural Accelerator
+	  (Intel(R) GNA) driver.
+	  User space interface is defined in include/uapi/misc/gna.h, while
+	  information about functionality is in
+	  Documentation/misc-devices/gna.rst
diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
new file mode 100644
index 000000000000..a6ef7e790e9e
--- /dev/null
+++ b/drivers/misc/gna/gna_device.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+
+static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
+			const struct pci_device_id *pci_id)
+{
+	pci_set_drvdata(pcidev, gna_priv);
+
+	gna_priv->parent = &pcidev->dev;
+	gna_priv->pdev = pcidev;
+	gna_priv->info = *(struct gna_drv_info *)pci_id->driver_data;
+	gna_priv->drv_priv = &gna_drv_priv;
+
+	return 0;
+}
+
+/* Reverse gna_dev_init() */
+static void gna_dev_deinit(struct gna_private *gna_priv)
+{
+	pci_set_drvdata(gna_priv->pdev, NULL);
+}
+
+int gna_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
+{
+	struct gna_private *gna_priv;
+	int ret;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "pci device can't be enabled\n");
+		goto end;
+	}
+
+	ret = pci_request_regions(pcidev, GNA_DRV_NAME);
+	if (ret)
+		goto end;
+
+	ret = pci_set_dma_mask(pcidev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pcidev->dev, "pci_set_dma_mask returned error %d\n", ret);
+		goto err_release_regions;
+	}
+
+	pci_set_master(pcidev);
+
+	/* init gna device */
+	gna_priv = devm_kzalloc(&pcidev->dev, sizeof(*gna_priv), GFP_KERNEL);
+	if (!gna_priv) {
+		ret = -ENOMEM;
+		goto err_clear_master;
+	}
+
+	/* Map BAR0 */
+	gna_priv->bar0.iostart = pci_resource_start(pcidev, 0);
+	gna_priv->bar0.iosize = pci_resource_len(pcidev, 0);
+	gna_priv->bar0.mem_addr = pcim_iomap(pcidev, 0, 0);
+	if (!gna_priv->bar0.mem_addr) {
+		dev_err(&pcidev->dev, "could not map BAR 0\n");
+		ret = -EINVAL;
+		goto err_clear_master;
+	}
+
+	dev_dbg(&pcidev->dev, "bar0 io start: 0x%llx\n", (unsigned long long)gna_priv->bar0.iostart);
+	dev_dbg(&pcidev->dev, "bar0 io size: %llu\n", (unsigned long long)gna_priv->bar0.iosize);
+	dev_dbg(&pcidev->dev, "bar0 memory address: %p\n", gna_priv->bar0.mem_addr);
+
+	ret = gna_dev_init(gna_priv, pcidev, pci_id);
+	if (ret) {
+		dev_err(&pcidev->dev, "could not initialize gna private structure\n");
+		goto err_clear_master;
+	}
+
+	return 0;
+
+err_clear_master:
+	pci_clear_master(pcidev);
+err_release_regions:
+	pci_release_regions(pcidev);
+end:
+	dev_err(&pcidev->dev, "gna probe failed with %d\n", ret);
+	return ret;
+}
+
+void gna_remove(struct pci_dev *pcidev)
+{
+	struct gna_private *gna_priv;
+
+	gna_priv = pci_get_drvdata(pcidev);
+
+	gna_dev_deinit(gna_priv);
+
+	pci_clear_master(pcidev);
+	pci_release_regions(pcidev);
+}
diff --git a/drivers/misc/gna/gna_device.h b/drivers/misc/gna/gna_device.h
new file mode 100644
index 000000000000..736bc5af5081
--- /dev/null
+++ b/drivers/misc/gna/gna_device.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_DEVICE_H__
+#define __GNA_DEVICE_H__
+
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <uapi/misc/gna.h>
+
+struct gna_drv_info {
+	u32 hwid;
+	u32 num_pagetables;
+	u32 num_page_entries;
+	u32 max_layer_count;
+	u64 max_hw_mem;
+};
+
+struct gna_pci_bar {
+	resource_size_t iostart;
+	resource_size_t iosize;
+	void __iomem *mem_addr;
+};
+
+struct gna_hw_info {
+	u8 in_buf_s;
+};
+
+struct gna_private {
+	struct gna_driver_private *drv_priv;
+
+	/* device objects */
+	struct pci_dev *pdev;
+	struct device *parent; /* pdev->dev */
+	struct device dev;
+	struct cdev cdev;
+
+	/* device related resources */
+	struct gna_pci_bar bar0;
+	struct gna_drv_info info;
+	struct gna_hw_info hw_info;
+};
+
+int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
+
+void gna_remove(struct pci_dev *dev);
+
+#endif /* __GNA_DEVICE_H__ */
diff --git a/drivers/misc/gna/gna_driver.c b/drivers/misc/gna/gna_driver.c
new file mode 100644
index 000000000000..81f0f003f377
--- /dev/null
+++ b/drivers/misc/gna/gna_driver.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#define pr_fmt(fmt) KBUILD_MODNAME " " fmt
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+
+struct gna_driver_private gna_drv_priv;
+
+struct class *gna_class;
+
+static struct pci_driver gna_driver = {
+	.name = GNA_DRV_NAME,
+	.probe = gna_probe,
+	.remove = gna_remove,
+};
+
+static char *gna_devnode(struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0666;
+
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+}
+
+static int __init gna_drv_init(void)
+{
+	int ret;
+
+	mutex_init(&gna_drv_priv.lock);
+
+	gna_class = class_create(THIS_MODULE, "gna");
+	if (IS_ERR(gna_class)) {
+		pr_err("class device create failed\n");
+		return PTR_ERR(gna_class);
+	}
+	gna_class->devnode = gna_devnode;
+
+	ret = pci_register_driver(&gna_driver);
+	if (ret) {
+		pr_err("pci register driver failed\n");
+		class_destroy(gna_class);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit gna_drv_exit(void)
+{
+	pci_unregister_driver(&gna_driver);
+	class_destroy(gna_class);
+}
+
+module_init(gna_drv_init);
+module_exit(gna_drv_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA) Driver");
+MODULE_VERSION(GNA_DRV_VER);
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/gna/gna_driver.h b/drivers/misc/gna/gna_driver.h
new file mode 100644
index 000000000000..4cf144bef8d4
--- /dev/null
+++ b/drivers/misc/gna/gna_driver.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_DRIVER_H__
+#define __GNA_DRIVER_H__
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define GNA_DRV_NAME	"gna"
+#define GNA_DRV_VER	"1.2.0"
+
+#define GNA_MAX_DEVICES		16
+
+struct gna_driver_private {
+	/* device major/minor number facilities */
+	DECLARE_BITMAP(dev_map, GNA_MAX_DEVICES);
+	dev_t devt;
+	int minor;
+
+	struct mutex lock;	/* protects this structure */
+};
+
+struct gna_file_private {
+	struct file *fd;
+	struct gna_private *gna_priv;
+
+	struct list_head memory_list;
+	struct mutex memlist_lock;	/* protects memory_list */
+
+	struct list_head flist;
+};
+
+extern struct gna_driver_private gna_drv_priv;
+
+extern struct class *gna_class;
+
+extern int recovery_timeout;
+
+#endif /* __GNA_DRIVER_H__ */
diff --git a/include/uapi/misc/gna.h b/include/uapi/misc/gna.h
new file mode 100644
index 000000000000..cd292a85eec6
--- /dev/null
+++ b/include/uapi/misc/gna.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef _UAPI_GNA_H_
+#define _UAPI_GNA_H_
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#ifndef __user
+#define __user
+#endif
+
+/* Operation modes */
+#define GNA_MODE_GMM	0
+#define GNA_MODE_XNN	1
+
+#define GNA_PARAM_DEVICE_ID		1
+#define GNA_PARAM_RECOVERY_TIMEOUT	2
+#define GNA_PARAM_DEVICE_TYPE		3
+#define GNA_PARAM_INPUT_BUFFER_S	4
+
+#define GNA_STS_SCORE_COMPLETED		(1 << 0)
+#define GNA_STS_STATISTICS_VALID	(1 << 3)
+#define GNA_STS_PCI_MMU_ERR		(1 << 4)
+#define GNA_STS_PCI_DMA_ERR		(1 << 5)
+#define GNA_STS_PCI_UNEXCOMPL_ERR	(1 << 6)
+#define GNA_STS_VA_OOR			(1 << 7)
+#define GNA_STS_PARAM_OOR		(1 << 8)
+#define GNA_STS_OUTBUF_FULL		(1 << 16)
+#define GNA_STS_SATURATE		(1 << 17)
+
+#define GNA_ERROR (GNA_STS_PCI_DMA_ERR			| \
+			GNA_STS_PCI_MMU_ERR		| \
+			GNA_STS_PCI_UNEXCOMPL_ERR	| \
+			GNA_STS_PARAM_OOR		| \
+			GNA_STS_VA_OOR)
+
+#define GNA_DEV_TYPE_0_9	0x09
+#define GNA_DEV_TYPE_1_0	0x10
+#define GNA_DEV_TYPE_2_0	0x20
+
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
+struct gna_compute_cfg {
+	__u32 layer_base;
+	__u32 layer_count;
+
+	/* List of GNA memory buffers */
+	__u64 buffers_ptr;
+	__u64 buffer_count;
+
+	__u8 active_list_on;
+	__u8 gna_mode;
+	__u8 hw_perf_encoding;
+	__u8 pad[5];
+};
+
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
+union gna_memory_map {
+	struct {
+		__u64 address;
+		__u32 size;
+		__u32 pad;
+	} in;
+
+	struct {
+		__u64 memory_id;
+	} out;
+};
+
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
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _UAPI_GNA_H_ */
-- 
2.28.0

