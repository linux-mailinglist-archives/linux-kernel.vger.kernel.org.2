Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1851A37F635
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhEMLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:02:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:45138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhEMLCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:06 -0400
IronPort-SDR: KdLjzJwa8nwREAzitiQrmDxb+ZCaPoErXiXtji6mPzZwyHveOpQ/bqV6+b61q9VrED1MoWKF4Z
 6wfFAY80LPEQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048264"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048264"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:57 -0700
IronPort-SDR: KIjXQtXeyn3flKGYPppUrAGGaEMuQ57qN+Xb9dGLuZNhi5KIUxxpXbhLlbzUHTFCewVkyUJ4E4
 PdnOZtPah82w==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625983764"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:54 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v3 01/14] intel_gna: add driver module
Date:   Thu, 13 May 2021 13:00:27 +0200
Message-Id: <20210513110040.2268-2-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new PCI driver for Intel(R) Gaussian & Neural Accelerator
with basic support like module loading and unloading. The full
function of the driver will be added by further changes.

Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
---
 Documentation/misc-devices/index.rst          |  1 +
 Documentation/misc-devices/intel/gna.rst      | 48 ++++++++++++++++
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 MAINTAINERS                                   |  7 +++
 drivers/misc/Kconfig                          |  1 +
 drivers/misc/Makefile                         |  1 +
 drivers/misc/intel/gna/Kbuild                 |  5 ++
 drivers/misc/intel/gna/Kconfig                | 13 +++++
 drivers/misc/intel/gna/device.c               | 56 +++++++++++++++++++
 drivers/misc/intel/gna/device.h               | 30 ++++++++++
 drivers/misc/intel/gna/hw.h                   | 17 ++++++
 drivers/misc/intel/gna/pci.c                  | 48 ++++++++++++++++
 drivers/misc/intel/gna/pci.h                  | 12 ++++
 13 files changed, 240 insertions(+)
 create mode 100644 Documentation/misc-devices/intel/gna.rst
 create mode 100644 drivers/misc/intel/gna/Kbuild
 create mode 100644 drivers/misc/intel/gna/Kconfig
 create mode 100644 drivers/misc/intel/gna/device.c
 create mode 100644 drivers/misc/intel/gna/device.h
 create mode 100644 drivers/misc/intel/gna/hw.h
 create mode 100644 drivers/misc/intel/gna/pci.c
 create mode 100644 drivers/misc/intel/gna/pci.h

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 64420b3314fe..2069d5c81a81 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -21,6 +21,7 @@ fit into other categories.
    c2port
    ibmvmc
    ics932s401
+   intel/gna
    isl29003
    lis3lv02d
    max6875
diff --git a/Documentation/misc-devices/intel/gna.rst b/Documentation/misc-devices/intel/gna.rst
new file mode 100644
index 000000000000..6bd4a663b9bb
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
+The driver probes/removes a PCI device, implements file operations, handles runtime
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
index 599bd4493944..6c8ff126e49d 100644
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
index 9450e052f1b1..b279dac57192 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8972,6 +8972,13 @@ S:	Maintained
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
index f532c59bb59b..3675d2786b4f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -461,4 +461,5 @@ source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/intel/gna/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b6f15a3c70..3acf0367333d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_INTEL_GNA)	        += intel/gna/
diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
new file mode 100644
index 000000000000..02d758132d32
--- /dev/null
+++ b/drivers/misc/intel/gna/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+intel_gna-y := device.o pci.o
+
+obj-$(CONFIG_INTEL_GNA) += intel_gna.o
diff --git a/drivers/misc/intel/gna/Kconfig b/drivers/misc/intel/gna/Kconfig
new file mode 100644
index 000000000000..ed8bd4788525
--- /dev/null
+++ b/drivers/misc/intel/gna/Kconfig
@@ -0,0 +1,13 @@
+#
+# Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA)
+#
+
+config INTEL_GNA
+	tristate "Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA)"
+	depends on X86 && PCI
+	help
+	  This option enables the Intel(R) Gaussian & Neural Accelerator
+	  (Intel(R) GNA) driver: intel_gna.
+	  User space interface is defined in include/uapi/misc/intel/gna.h, while
+	  information about functionality is in
+	  Documentation/misc-devices/intel/gna.rst
diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
new file mode 100644
index 000000000000..8722935d26bf
--- /dev/null
+++ b/drivers/misc/intel/gna/device.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+
+#include "device.h"
+#include "hw.h"
+
+static int recovery_timeout = 60;
+
+#ifdef CONFIG_DEBUG_INTEL_GNA
+module_param(recovery_timeout, int, 0644);
+MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
+#endif
+
+int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase)
+{
+	static atomic_t dev_last_idx = ATOMIC_INIT(-1);
+	struct gna_private *gna_priv;
+	const char *dev_misc_name;
+	int ret;
+
+	gna_priv = devm_kzalloc(parent, sizeof(*gna_priv), GFP_KERNEL);
+	if (!gna_priv)
+		return -ENOMEM;
+
+	gna_priv->index = atomic_inc_return(&dev_last_idx);
+	gna_priv->recovery_timeout_jiffies = msecs_to_jiffies(recovery_timeout * 1000);
+	gna_priv->iobase = iobase;
+	gna_priv->info = *dev_info;
+	gna_priv->parent = parent;
+
+	dev_misc_name = devm_kasprintf(parent, GFP_KERNEL, "%s%d", GNA_DV_NAME, gna_priv->index);
+	if (!dev_misc_name)
+		return -ENOMEM;
+
+	gna_priv->name = dev_misc_name;
+
+	if (!(sizeof(dma_addr_t) > 4) ||
+		dma_set_mask(parent, DMA_BIT_MASK(64))) {
+		ret = dma_set_mask(parent, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(parent, "dma_set_mask error: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA) Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
new file mode 100644
index 000000000000..e12bac64fbf4
--- /dev/null
+++ b/drivers/misc/intel/gna/device.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_DEVICE_H__
+#define __GNA_DEVICE_H__
+
+#include <linux/types.h>
+
+#include "hw.h"
+
+#define GNA_DV_NAME	"intel_gna"
+
+struct device;
+
+struct gna_private {
+	int index;
+
+	int recovery_timeout_jiffies;
+
+	const char *name;
+	struct device *parent;
+
+	/* device related resources */
+	void __iomem *iobase;
+	struct gna_dev_info info;
+};
+
+int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase);
+
+#endif /* __GNA_DEVICE_H__ */
diff --git a/drivers/misc/intel/gna/hw.h b/drivers/misc/intel/gna/hw.h
new file mode 100644
index 000000000000..8ef8dc182b92
--- /dev/null
+++ b/drivers/misc/intel/gna/hw.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_HW_H__
+#define __GNA_HW_H__
+
+#include <linux/mm_types.h>
+
+struct gna_dev_info {
+	u32 hwid;
+	u32 num_pagetables;
+	u32 num_page_entries;
+	u32 max_layer_count;
+	u64 max_hw_mem;
+};
+
+#endif // __GNA_HW_H__
diff --git a/drivers/misc/intel/gna/pci.c b/drivers/misc/intel/gna/pci.c
new file mode 100644
index 000000000000..ade9076db097
--- /dev/null
+++ b/drivers/misc/intel/gna/pci.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2017-2021 Intel Corporation
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "device.h"
+#include "pci.h"
+
+int gna_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
+{
+	struct gna_dev_info *dev_info;
+	void __iomem *iobase;
+	int ret;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "pci device can't be enabled\n");
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(pcidev, BIT(0), pci_name(pcidev));
+	if (ret) {
+		dev_err(&pcidev->dev, "cannot iomap regions\n");
+		return ret;
+	}
+
+	iobase = pcim_iomap_table(pcidev)[0];
+
+	pci_set_master(pcidev);
+
+	dev_info = (struct gna_dev_info *)pci_id->driver_data;
+
+	ret = gna_probe(&pcidev->dev, dev_info, iobase);
+	if (ret) {
+		dev_err(&pcidev->dev, "could not initialize device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct pci_driver gna_pci_driver = {
+	.name = GNA_DV_NAME,
+	.probe = gna_pci_probe,
+};
+
+module_pci_driver(gna_pci_driver);
diff --git a/drivers/misc/intel/gna/pci.h b/drivers/misc/intel/gna/pci.h
new file mode 100644
index 000000000000..a8ea77d34f26
--- /dev/null
+++ b/drivers/misc/intel/gna/pci.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2017-2021 Intel Corporation */
+
+#ifndef __GNA_PCI_H__
+#define __GNA_PCI_H__
+
+struct pci_device_id;
+struct pci_dev;
+
+int gna_pci_probe(struct pci_dev *dev, const struct pci_device_id *id);
+
+#endif /* __GNA_PCI_H__ */
-- 
2.28.0

