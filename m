Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890C13480A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhCXSij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:38:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:17716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237619AbhCXSiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:18 -0400
IronPort-SDR: urlWMJNfQcO+WJFUQn0ijL5SVs7K5PLjp5e1JJ/rLD2fnKzxoc7cvCJmJ+0oP0qYTvP/NlNLNx
 jWmYbeHoX8SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859463"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859463"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:17 -0700
IronPort-SDR: IFi6LC/+9dLUhu1HQ3C6GJUKfzTT+amTFT5VoAfphvZjIJpjgQ5RS3pLgKzhRt6UEBvRl/eYuO
 lXUE4ScHk2pw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203735"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:14 -0700
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
Subject: [PATCH v2 01/13] intel_gna: add driver module
Date:   Wed, 24 Mar 2021 19:35:58 +0100
Message-Id: <20210324183610.4574-2-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
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
 Documentation/misc-devices/index.rst          |   1 +
 Documentation/misc-devices/intel/gna.rst      |  48 ++++++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/intel/gna/Kbuild                 |   5 +
 drivers/misc/intel/gna/Kconfig                |  13 ++
 drivers/misc/intel/gna/gna_device.c           |  74 +++++++++
 drivers/misc/intel/gna/gna_device.h           |  36 ++++
 drivers/misc/intel/gna/gna_driver.c           |  39 +++++
 drivers/misc/intel/gna/gna_driver.h           |  15 ++
 include/uapi/misc/intel/gna.h                 | 155 ++++++++++++++++++
 13 files changed, 396 insertions(+)
 create mode 100644 Documentation/misc-devices/intel/gna.rst
 create mode 100644 drivers/misc/intel/gna/Kbuild
 create mode 100644 drivers/misc/intel/gna/Kconfig
 create mode 100644 drivers/misc/intel/gna/gna_device.c
 create mode 100644 drivers/misc/intel/gna/gna_device.h
 create mode 100644 drivers/misc/intel/gna/gna_driver.c
 create mode 100644 drivers/misc/intel/gna/gna_driver.h
 create mode 100644 include/uapi/misc/intel/gna.h

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 64420b3314fe..1b187ee121b0 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -19,6 +19,7 @@ fit into other categories.
    bh1770glc
    eeprom
    c2port
+   intel/gna
    ibmvmc
    ics932s401
    isl29003
diff --git a/Documentation/misc-devices/intel/gna.rst b/Documentation/misc-devices/intel/gna.rst
new file mode 100644
index 000000000000..9baeec5ceb5c
--- /dev/null
+++ b/Documentation/misc-devices/intel/gna.rst
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
+The Intel(R) GNA is an internal PCI fixed device available on several Intel platforms/SoCs.
+Feature set depends on the Intel chipset SKU.
+
+Intel(R) GNA provides hardware accelerated computation for GMMs and Neural Networks.
+It supports several layer types: affine, recurrent, and convolutional among others.
+Hardware also provides helper layer types for copying and transposing matrices.
+
+Linux Driver
+------------
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
+
+GNA_IOCTL_PARAM_GET gets driver and device capabilities.
+
+GNA_IOCTL_MEMORY_MAP locks user pages and GNA MMU setups for DMA transfer.
+
+GNA_IOCTL_MEMORY_UNMAP unlocks user pages and releases GNA MMU structures.
+
+GNA_IOCTL_COMPUTE submits a request to the device queue.
+
+GNA_IOCTL_WAIT blocks and waits on the submitted request.
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a4c75a28c839..9ec2b32f656a 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -115,6 +115,7 @@ Code  Seq#    Include File                                           Comments
 'B'   C0-FF  advanced bbus                                           <mailto:maassen@uni-freiburg.de>
 'C'   all    linux/soundcard.h                                       conflict!
 'C'   01-2F  linux/capi.h                                            conflict!
+'C'   01-5F  uapi/misc/intel/gna.h                                   conflict!
 'C'   F0-FF  drivers/net/wan/cosa.h                                  conflict!
 'D'   all    arch/s390/include/asm/dasd.h
 'D'   40-5F  drivers/scsi/dpt/dtpi_ioctl.h
diff --git a/MAINTAINERS b/MAINTAINERS
index bfc1b86e3e73..da926aa4523c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8928,6 +8928,13 @@ S:	Maintained
 F:	Documentation/fb/intelfb.rst
 F:	drivers/video/fbdev/intelfb/
 
+INTEL GNA PCI DRIVER
+M:	Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
+S:	Maintained
+F:	Documentation/misc-devices/intel/gna.rst
+F:	drivers/misc/intel/gna/*
+F:	include/uapi/misc/intel/gna.h
+
 INTEL GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0d8099..ce3dc5b9f821 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -481,4 +481,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/intel/gna/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e73330..5fca2e730d96 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_INTEL_GNA)	        += intel/gna/
diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
new file mode 100644
index 000000000000..5d3becc71683
--- /dev/null
+++ b/drivers/misc/intel/gna/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+intel_gna-y := gna_device.o gna_driver.o
+
+obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/Kconfig b/drivers/misc/intel/gna/Kconfig
new file mode 100644
index 000000000000..c3b768a40684
--- /dev/null
+++ b/drivers/misc/intel/gna/Kconfig
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
+	  (Intel(R) GNA) driver: intel_gna.
+	  User space interface is defined in include/uapi/misc/intel/gna.h, while
+	  information about functionality is in
+	  Documentation/misc-devices/intel/gna.rst
diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
new file mode 100644
index 000000000000..431113297879
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+
+#define GNA_BAR0		0
+
+static void gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
+			const struct pci_device_id *pci_id)
+{
+	pci_set_drvdata(pcidev, gna_priv);
+
+	gna_priv->parent = &pcidev->dev;
+	gna_priv->pdev = pcidev;
+	gna_priv->info = *(struct gna_drv_info *)pci_id->driver_data;
+	gna_priv->drv_priv = &gna_drv_priv;
+}
+
+int gna_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
+{
+	struct gna_private *gna_priv;
+	void __iomem *const *iomap;
+	unsigned long phys_len;
+	phys_addr_t phys;
+	int ret;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "pci device can't be enabled\n");
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(pcidev, 1 << GNA_BAR0, GNA_DV_NAME);
+	if (ret) {
+		dev_err(&pcidev->dev, "cannot iomap regions\n");
+		return ret;
+	}
+
+	phys = pci_resource_start(pcidev, GNA_BAR0);
+	phys_len = pci_resource_len(pcidev, GNA_BAR0);
+
+	dev_info(&pcidev->dev, "physical base address %pap, %lu bytes\n",
+		&phys, phys_len);
+
+	iomap = pcim_iomap_table(pcidev);
+	if (!iomap) {
+		dev_err(&pcidev->dev, "failed to iomap table\n");
+		return -ENODEV;
+	}
+
+	gna_priv = devm_kzalloc(&pcidev->dev, sizeof(*gna_priv), GFP_KERNEL);
+	if (!gna_priv)
+		return -ENOMEM;
+
+	gna_priv->bar0_base = iomap[GNA_BAR0];
+
+	dev_dbg(&pcidev->dev, "bar0 memory address: %p\n", gna_priv->bar0_base);
+
+	ret = dma_set_mask(&pcidev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pcidev->dev, "pci_set_dma_mask returned error %d\n", ret);
+		return ret;
+	}
+
+	pci_set_master(pcidev);
+
+	gna_dev_init(gna_priv, pcidev, pci_id);
+
+	return 0;
+}
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
new file mode 100644
index 000000000000..d0b47f75f47f
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_DEVICE_H__
+#define __GNA_DEVICE_H__
+
+#include <linux/types.h>
+
+struct gna_driver_private;
+struct pci_device_id;
+struct pci_dev;
+struct device;
+
+struct gna_drv_info {
+	u32 hwid;
+	u32 num_pagetables;
+	u32 num_page_entries;
+	u32 max_layer_count;
+	u64 max_hw_mem;
+};
+
+struct gna_private {
+	struct gna_driver_private *drv_priv;
+
+	struct pci_dev *pdev;
+	/* pdev->dev */
+	struct device *parent;
+
+	/* device related resources */
+	void __iomem *bar0_base;
+	struct gna_drv_info info;
+};
+
+int gna_probe(struct pci_dev *dev, const struct pci_device_id *id);
+
+#endif /* __GNA_DEVICE_H__ */
diff --git a/drivers/misc/intel/gna/gna_driver.c b/drivers/misc/intel/gna/gna_driver.c
new file mode 100644
index 000000000000..f4922a388be7
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_driver.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "gna_device.h"
+#include "gna_driver.h"
+
+static int recovery_timeout = 60;
+module_param(recovery_timeout, int, 0644);
+MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
+
+struct gna_driver_private gna_drv_priv;
+
+static struct pci_driver gna_driver = {
+	.name = GNA_DV_NAME,
+	.probe = gna_probe,
+};
+
+static int __init gna_drv_init(void)
+{
+	gna_drv_priv.recovery_timeout_jiffies = msecs_to_jiffies(recovery_timeout * 1000);
+
+	return pci_register_driver(&gna_driver);
+}
+
+static void __exit gna_drv_exit(void)
+{
+	pci_unregister_driver(&gna_driver);
+}
+
+module_init(gna_drv_init);
+module_exit(gna_drv_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA) Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/intel/gna/gna_driver.h b/drivers/misc/intel/gna/gna_driver.h
new file mode 100644
index 000000000000..ed507ea10866
--- /dev/null
+++ b/drivers/misc/intel/gna/gna_driver.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_DRIVER_H__
+#define __GNA_DRIVER_H__
+
+#define GNA_DV_NAME	"intel_gna"
+
+struct gna_driver_private {
+	int recovery_timeout_jiffies;
+};
+
+extern struct gna_driver_private gna_drv_priv;
+
+#endif /* __GNA_DRIVER_H__ */
diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
new file mode 100644
index 000000000000..a7e435b74a0a
--- /dev/null
+++ b/include/uapi/misc/intel/gna.h
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
+#include <linux/const.h>
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
+#define GNA_STS_SCORE_COMPLETED		_BITUL(0)
+#define GNA_STS_STATISTICS_VALID	_BITUL(3)
+#define GNA_STS_PCI_MMU_ERR		_BITUL(4)
+#define GNA_STS_PCI_DMA_ERR		_BITUL(5)
+#define GNA_STS_PCI_UNEXCOMPL_ERR	_BITUL(6)
+#define GNA_STS_VA_OOR			_BITUL(7)
+#define GNA_STS_PARAM_OOR		_BITUL(8)
+#define GNA_STS_SATURATE		_BITUL(17)
+
+#define GNA_ERROR      (GNA_STS_PCI_DMA_ERR		| \
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

