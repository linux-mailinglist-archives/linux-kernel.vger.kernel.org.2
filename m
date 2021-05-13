Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8931E37F48E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhEMI7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:59:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:47035 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhEMI7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:59:14 -0400
IronPort-SDR: SBz0AXJbRwK3X6sCk2OBpvchJCjLvF+RPstKWdatZC0yy0/CZ4DQSus6+8KmkDTsJbg9j8dFUm
 MQyjkQq11gwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032236"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032236"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:04 -0700
IronPort-SDR: +wIndIbMMHUVVZV94DZdu31zGOn9Yodit9UcP9Jku0T1Wj+1634OrlLSDNifDyRhXNO14ro7gj
 hWTXOuzcAtqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928243"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:02 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 02/15] misc: nnpi: Initialize NNP-I framework and PCIe modules
Date:   Thu, 13 May 2021 11:57:12 +0300
Message-Id: <20210513085725.45528-3-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the NNP-I framework module and expose PCIe device driver.

The NNP-I driver is divided into two modules, the framework module
and the PCIe driver module.

The PCIe driver probes the device and provides, to the framework module,
functions for sending and receiving raw commands and responses to/from
the device. It does not have semantic understanding of these commands
and responses, and transfers them as abstract binary data.

The framework module unpacks command and response messages, and uses the
PCIe driver module to send and receive them. It uses the PCIe driver module
as an abstract communication layer, and is unaware of the PCIe HW used to
communicate with the NNP-I card.

Using TCP/IP jargon, the PCIe driver module is the "transport" layer
and the main framework module is the "application" layer.
This logical seperation was done in order to ease maintenance and
validation, and make adding support for other "transport" layers easier.

The header files under the ipc_include directory provide HW register
definitions and protocol structures used to communicate with the NNP-I
device. These header files are used also by the NNP-I card's SW stack.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 MAINTAINERS                                        |   5 +
 drivers/misc/Kconfig                               |   1 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/intel-nnpi/Kconfig                    |  18 ++
 drivers/misc/intel-nnpi/Makefile                   |  12 +
 drivers/misc/intel-nnpi/device.c                   |  84 +++++
 drivers/misc/intel-nnpi/device.h                   |  39 +++
 .../misc/intel-nnpi/ipc_include/nnp_boot_defs.h    |  71 ++++
 drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h     |  91 ++++++
 drivers/misc/intel-nnpi/nnp_pcie.c                 | 358 +++++++++++++++++++++
 10 files changed, 680 insertions(+)
 create mode 100644 drivers/misc/intel-nnpi/Kconfig
 create mode 100644 drivers/misc/intel-nnpi/Makefile
 create mode 100644 drivers/misc/intel-nnpi/device.c
 create mode 100644 drivers/misc/intel-nnpi/device.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/nnp_boot_defs.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h
 create mode 100644 drivers/misc/intel-nnpi/nnp_pcie.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c..ff0c3d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9316,6 +9316,11 @@ S:	Supported
 W:	https://01.org/linux-acpi
 F:	drivers/platform/x86/intel_menlow.c
 
+INTEL NNP-I PCI DRIVER
+M:	Guy Zadicario <guy.zadicario@intel.com>
+S:	Supported
+F:	drivers/misc/intel-nnpi/
+
 INTEL P-Unit IPC DRIVER
 M:	Zha Qipeng <qipeng.zha@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f4fb5c5..4c67fac 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -462,6 +462,7 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
+source "drivers/misc/intel-nnpi/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e92a56d..592ac64 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_BCM_VK)		+= bcm-vk/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
+obj-$(CONFIG_INTEL_NNPI)        += intel-nnpi/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
diff --git a/drivers/misc/intel-nnpi/Kconfig b/drivers/misc/intel-nnpi/Kconfig
new file mode 100644
index 0000000..8534554
--- /dev/null
+++ b/drivers/misc/intel-nnpi/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+#
+# Copyright (C) 2019-2021 Intel Corporation
+#
+#
+
+config INTEL_NNPI
+	tristate "Intel(R) PCIe NNP-I (AI accelerator for inference) device driver"
+	depends on PCI
+	select DMA_SHARED_BUFFER
+	help
+	  Device driver for Intel NNP-I PCIe accelerator card for AI inference.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here. Two modules will
+	  be generated: intel_nnpi and intel_nnpi_pcie.
diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
new file mode 100644
index 0000000..84b7528
--- /dev/null
+++ b/drivers/misc/intel-nnpi/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2021 Intel Corporation
+#
+
+obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
+
+intel_nnpi-y := device.o
+
+intel_nnpi_pcie-y := nnp_pcie.o
+
+ccflags-y += -I$(srctree)/$(src)/ipc_include
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
new file mode 100644
index 0000000..3d80e95
--- /dev/null
+++ b/drivers/misc/intel-nnpi/device.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+
+#include "device.h"
+
+static DEFINE_IDA(dev_ida);
+
+/**
+ * nnpdev_init() - initialize NNP-I device structure.
+ * @nnpdev: device to be initialized
+ * @dev: device structure representing the card device
+ * @ops: NNP-I device driver operations
+ *
+ * This function is called by the device driver module when a new NNP-I device
+ * is created. The function initialize NNP-I framework's device structure.
+ * The device driver must call nnpdev_destroy before the underlying device is
+ * removed and before the driver module get unloaded.
+ * The device driver must also make sure that when nnpdev_destroy is called the
+ * device is quiesced. Meaning, the physical device does no longer throw events
+ * and no operations on the nnpdev will be requested.
+ *
+ * Return: zero on success, error value otherwise.
+ */
+int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
+		const struct nnp_device_ops *ops)
+{
+	int ret;
+
+	ret = ida_simple_get(&dev_ida, 0, NNP_MAX_DEVS, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	nnpdev->id = ret;
+	/*
+	 * It is fine to keep pointers to the underlying device and driver
+	 * ops since driver must call nnpdev_destroy before the device is
+	 * removed or module gets unloaded.
+	 */
+	nnpdev->dev = dev;
+	nnpdev->ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL(nnpdev_init);
+
+/**
+ * nnpdev_card_doorbell_value_changed() - card doorbell changed notification
+ * @nnpdev: The nnp device
+ * @doorbell_val: The new value of the doorbell register
+ *
+ * This function is called from the NNP-I device driver when the card's doorbell
+ * register is changed.
+ */
+void nnpdev_card_doorbell_value_changed(struct nnp_device *nnpdev,
+					u32 doorbell_val)
+{
+	dev_dbg(nnpdev->dev, "Got card doorbell value 0x%x\n", doorbell_val);
+}
+EXPORT_SYMBOL(nnpdev_card_doorbell_value_changed);
+
+/**
+ * nnpdev_destroy() - destroy nnp device object
+ * @nnpdev: The nnp device to be destroyed.
+ *
+ * This function must be called by the device driver module when NNP-I device
+ * is removed or the device driver get unloaded.
+ */
+void nnpdev_destroy(struct nnp_device *nnpdev)
+{
+	dev_dbg(nnpdev->dev, "Destroying NNP-I device\n");
+
+	ida_simple_remove(&dev_ida, nnpdev->id);
+}
+EXPORT_SYMBOL(nnpdev_destroy);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel(R) NNPI Framework");
+MODULE_AUTHOR("Intel Corporation");
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
new file mode 100644
index 0000000..4ff7aa9
--- /dev/null
+++ b/drivers/misc/intel-nnpi/device.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNPDRV_DEVICE_H
+#define _NNPDRV_DEVICE_H
+
+#define NNP_MAX_DEVS		256
+
+/**
+ * struct nnp_device - structure for NNP-I device info
+ * @ops: device operations implemented by the underlying device driver
+ * @dev: pointer to struct device representing the NNP-I card.
+ * @id: NNP-I device number
+ */
+struct nnp_device {
+	const struct nnp_device_ops *ops;
+	struct device               *dev;
+	int                         id;
+};
+
+/**
+ * struct nnp_device_ops - operations implemented by underlying device driver
+ * @cmdq_flush: empties the device command queue, discarding all queued
+ *              commands.
+ */
+struct nnp_device_ops {
+	int (*cmdq_flush)(struct nnp_device *hw_dev);
+};
+
+/*
+ * Functions exported by the device framework module which are
+ * called by the lower layer NNP-I device driver module
+ */
+int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
+		const struct nnp_device_ops *ops);
+void nnpdev_destroy(struct nnp_device *nnpdev);
+void nnpdev_card_doorbell_value_changed(struct nnp_device *nnpdev,
+					u32 doorbell_val);
+#endif
diff --git a/drivers/misc/intel-nnpi/ipc_include/nnp_boot_defs.h b/drivers/misc/intel-nnpi/ipc_include/nnp_boot_defs.h
new file mode 100644
index 0000000..c26dc38
--- /dev/null
+++ b/drivers/misc/intel-nnpi/ipc_include/nnp_boot_defs.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNP_BOOT_DEFS_H
+#define _NNP_BOOT_DEFS_H
+
+#include <linux/bits.h>
+
+/*
+ * Value fields of card->host doorbell status register HOST_PCI_DOORBELL_VALUE
+ */
+#define NNP_CARD_BOOT_STATE_MASK            GENMASK(7, 0)
+#define NNP_CARD_BIOS_UPDATE_COUNTER_MASK   GENMASK(11, 8)
+#define NNP_CARD_ERROR_MASK                 GENMASK(15, 12)
+#define NNP_CARD_KEEP_ALIVE_MASK            GENMASK(23, 20)
+
+/* Possible values for card boot state */
+/* BIOS has not yet initialized */
+#define NNP_CARD_BOOT_STATE_NOT_READY       0
+/* BIOS initilaized and waiting for os boot image over PCIe */
+#define NNP_CARD_BOOT_STATE_BIOS_READY      1
+/* recovery BIOS initilaized and waiting for capsule update over PCIe */
+#define NNP_CARD_BOOT_STATE_RECOVERY_BIOS_READY 2
+/* BIOS copied boot image successfully, os boot has started */
+#define NNP_CARD_BOOT_STATE_BOOT_STARTED    3
+/* card has booted and card driver has loaded */
+#define NNP_CARD_BOOT_STATE_DRV_READY       4
+/* card driver finished initialization and user space daemon has started */
+#define NNP_CARD_BOOT_STATE_CARD_READY      8
+/* BIOS copied data into the system info structure */
+#define NNP_CARD_BOOT_STATE_BIOS_SYSINFO_READY 10
+/* BIOS capsule update has started flashing the BIOS image */
+#define NNP_CARD_BOOT_STATE_BIOS_FLASH_STARTED 32
+
+/* Possible card error values */
+#define NNP_CARD_ERROR_HOST_ERROR           1
+#define NNP_CARD_ERROR_BOOT_PARAMS          2
+#define NNP_CARD_ERROR_IMAGE_COPY           3
+#define NNP_CARD_ERROR_CORRUPTED_IMAGE      4
+#define NNP_CARD_ERROR_NOT_CAPSULE          8
+#define NNP_CARD_ERROR_CAPSULE_FAILED       9
+/*
+ * Value fields of host->card doorbell status register PCI_HOST_DOORBELL_VALUE
+ */
+#define NNP_HOST_BOOT_STATE_MASK              GENMASK(3, 0)
+#define NNP_HOST_ERROR_MASK                   GENMASK(7, 4)
+#define NNP_HOST_DRV_STATE_MASK               GENMASK(11, 8)
+#define NNP_HOST_DRV_REQUEST_SELF_RESET_MASK  BIT(16)
+#define NNP_HOST_KEEP_ALIVE_MASK              GENMASK(23, 20)
+#define NNP_HOSY_P2P_POKE_MASK                GENMASK(31, 24)
+
+/* Possible values for host boot state */
+/* boot/capsule image is not loaded yet to memory */
+#define NNP_HOST_BOOT_STATE_NOT_READY               0
+/* host driver is up and ready */
+#define NNP_HOST_BOOT_STATE_DRV_READY               (BIT(3) | BIT(0))
+/* debug os image is loaded and ready in memory */
+#define NNP_HOST_BOOT_STATE_DEBUG_OS_IMAGE_READY    (BIT(3) | BIT(1))
+
+/* Possible values for host error */
+#define NNP_HOST_ERROR_CANNOT_LOAD_IMAGE     1
+
+/* Possible values for host driver state */
+/* driver did not detected the device yet */
+#define NNP_HOST_DRV_STATE_NOT_READY         0
+/* driver initialized and ready */
+#define NNP_HOST_DRV_STATE_READY             1
+/* host/card protocol version mismatch */
+#define NNP_HOST_DRV_STATE_VERSION_ERROR     2
+
+#endif // of _NNP_BOOT_DEFS_H
diff --git a/drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h b/drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h
new file mode 100644
index 0000000..fd9ba2a
--- /dev/null
+++ b/drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNP_ELBI_H
+#define _NNP_ELBI_H
+
+#include <linux/bits.h>
+
+#define ELBI_BASE                             0  /* offset of ELBI registers */
+#define ELBI_LINE_BDF                         (ELBI_BASE + 0x004)
+
+/*
+ * COMMAND FIFO registers
+ */
+#define ELBI_COMMAND_WRITE_WO_MSI_LOW         (ELBI_BASE + 0x050)
+#define ELBI_COMMAND_WRITE_WO_MSI_HIGH        (ELBI_BASE + 0x054)
+#define ELBI_COMMAND_WRITE_W_MSI_LOW          (ELBI_BASE + 0x058)
+#define ELBI_COMMAND_WRITE_W_MSI_HIGH         (ELBI_BASE + 0x05C)
+
+#define ELBI_COMMAND_FIFO_0_LOW		 (ELBI_BASE + 0x080)
+#define ELBI_COMMAND_FIFO_LOW(i)         (ELBI_COMMAND_FIFO_0_LOW + (i) * 8 + 0)
+#define ELBI_COMMAND_FIFO_HIGH(i)        (ELBI_COMMAND_FIFO_0_LOW + (i) * 8 + 4)
+#define ELBI_COMMAND_FIFO_DEPTH          16
+
+#define ELBI_COMMAND_IOSF_CONTROL        (ELBI_BASE + 0x044)
+#define CMDQ_READ_PTR_MASK               GENMASK(3, 0)
+#define CMDQ_WRITE_PTR_MASK              GENMASK(12, 8)
+
+#define ELBI_COMMAND_PCI_CONTROL                          (ELBI_BASE + 0x048)
+#define ELBI_COMMAND_PCI_CONTROL_ALMOST_EMPTY_TH_MASK     GENMASK(3, 0)
+#define ELBI_COMMAND_PCI_CONTROL_FLUSH_MASK               BIT(8)
+
+/*
+ * RESPONSE FIFO registers
+ */
+#define ELBI_RESPONSE_FIFO_0_LOW        (ELBI_BASE + 0x100)
+#define ELBI_RESPONSE_FIFO_LOW(i)       (ELBI_RESPONSE_FIFO_0_LOW + (i) * 8 + 0)
+#define ELBI_RESPONSE_FIFO_HIGH(i)      (ELBI_RESPONSE_FIFO_0_LOW + (i) * 8 + 4)
+#define ELBI_RESPONSE_FIFO_DEPTH        16
+
+#define ELBI_RESPONSE_PCI_CONTROL       (ELBI_BASE + 0x060)
+#define RESPQ_READ_PTR_MASK             GENMASK(3, 0)
+#define RESPQ_WRITE_PTR_MASK            GENMASK(12, 8)
+
+/*
+ * Host side interrupt status & mask register
+ */
+#define ELBI_PCI_STATUS                       (ELBI_BASE + 0x008)
+#define ELBI_PCI_MSI_MASK                     (ELBI_BASE + 0x00C)
+#define ELBI_PCI_STATUS_CMDQ_EMPTY                    BIT(0)
+#define ELBI_PCI_STATUS_CMDQ_ALMOST_EMPTY             BIT(1)
+#define ELBI_PCI_STATUS_CMDQ_READ_UPDATE              BIT(2)
+#define ELBI_PCI_STATUS_CMDQ_FLUSH                    BIT(3)
+#define ELBI_PCI_STATUS_CMDQ_WRITE_ERROR              BIT(4)
+#define ELBI_PCI_STATUS_RESPQ_FULL                    BIT(5)
+#define ELBI_PCI_STATUS_RESPQ_ALMOST_FULL             BIT(6)
+#define ELBI_PCI_STATUS_RESPQ_NEW_RESPONSE            BIT(7)
+#define ELBI_PCI_STATUS_RESPQ_FLUSH                   BIT(8)
+#define ELBI_PCI_STATUS_RESPQ_READ_ERROR              BIT(9)
+#define ELBI_PCI_STATUS_RESPQ_READ_POINTER_ERROR      BIT(10)
+#define ELBI_PCI_STATUS_DOORBELL                      BIT(11)
+#define ELBI_PCI_STATUS_DOORBELL_READ                 BIT(12)
+#define ELBI_PCI_STATUS_FLR_REQUEST                   BIT(13)
+#define ELBI_PCI_STATUS_LOCAL_D3                      BIT(14)
+#define ELBI_PCI_STATUS_LOCAL_FLR                     BIT(15)
+
+/* DOORBELL registers */
+#define ELBI_PCI_HOST_DOORBELL_VALUE                  (ELBI_BASE + 0x034)
+#define ELBI_HOST_PCI_DOORBELL_VALUE                  (ELBI_BASE + 0x038)
+#define CARD_DOORBELL_REG                             ELBI_HOST_PCI_DOORBELL_VALUE
+#define HOST_DOORBELL_REG                             ELBI_PCI_HOST_DOORBELL_VALUE
+
+/* CPU_STATUS registers */
+/* CPU_STATUS_0 - Updated by BIOS with postcode */
+#define ELBI_CPU_STATUS_0                             (ELBI_BASE + 0x1B8)
+/* CPU_STATUS_1 - Updated by BIOS with BIOS flash progress */
+#define ELBI_CPU_STATUS_1                             (ELBI_BASE + 0x1BC)
+/* CPU_STATUS_2 - Updated by card driver - bitfields below */
+#define ELBI_CPU_STATUS_2                             (ELBI_BASE + 0x1C0)
+/* CPU_STATUS_3 - not used */
+#define ELBI_CPU_STATUS_3                             (ELBI_BASE + 0x1C4)
+
+/* Bitfields updated in ELBI_CPU_STATUS_2 indicating card driver states */
+#define ELBI_CPU_STATUS_2_FLR_MODE_MASK               GENMASK(1, 0)
+
+/* values for FLR_MODE */
+#define FLR_MODE_WARN_RESET  0
+#define FLR_MODE_COLD_RESET  1
+#define FLR_MODE_IGNORE      3
+
+#endif
diff --git a/drivers/misc/intel-nnpi/nnp_pcie.c b/drivers/misc/intel-nnpi/nnp_pcie.c
new file mode 100644
index 0000000..88280d1
--- /dev/null
+++ b/drivers/misc/intel-nnpi/nnp_pcie.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
+
+#include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include "device.h"
+#include "nnp_elbi.h"
+#include "nnp_boot_defs.h"
+
+/*
+ * SpringHill PCI card identity settings
+ */
+#define NNP_PCI_DEVICE_ID		0x45c6
+
+/**
+ * struct nnp_pci - structure for NNP-I PCIe device info.
+ * @nnpdev: the NNP-I framework's structure for this NNP-I card device
+ * @pdev: pointer to the pcie device struct
+ * @mmio_va: device's BAR0 mapped virtual address
+ * @mem_bar_va: device's BAR2 mapped virtual address, this is the
+ *              "inbound memory region". This device memory region is
+ *              described in ipc_include/nnp_inbound_mem.h
+ * @lock: protects accesses to cmd_read_update_count members.
+ * @response_buf: buffer to hold response messages pulled of the device's
+ *                response queue.
+ * @card_status_wait: waitq that get signaled when device PCI status has changed
+ *                    or device has updated its read pointer of the command
+ *                    queue.
+ * @card_doorbell_val: card's doorbell register value, updated when doorbell
+ *                     interrupt is received.
+ * @card_status: Last device interrupt status register, updated in interrupt
+ *               handler.
+ * @cmd_read_update_count: number of times the device has updated its read
+ *                         pointer to the device command queue.
+ */
+struct nnp_pci {
+	struct nnp_device nnpdev;
+	struct pci_dev    *pdev;
+
+	void __iomem      *mmio_va;
+	void __iomem      *mem_bar_va;
+
+	spinlock_t      lock;
+	u64             response_buf[ELBI_RESPONSE_FIFO_DEPTH];
+	wait_queue_head_t card_status_wait;
+	u32             card_doorbell_val;
+
+	u32             card_status;
+	u32             cmd_read_update_count;
+};
+
+#define NNP_DRIVER_NAME  "nnp_pcie"
+
+/* interrupt mask bits we enable and handle at interrupt level */
+static u32 card_status_int_mask = ELBI_PCI_STATUS_CMDQ_READ_UPDATE |
+				  ELBI_PCI_STATUS_RESPQ_NEW_RESPONSE |
+				  ELBI_PCI_STATUS_DOORBELL;
+
+static inline void nnp_mmio_write(struct nnp_pci *nnp_pci, u32 off, u32 val)
+{
+	iowrite32(val, nnp_pci->mmio_va + off);
+}
+
+static inline u32 nnp_mmio_read(struct nnp_pci *nnp_pci, u32 off)
+{
+	return ioread32(nnp_pci->mmio_va + off);
+}
+
+static inline void nnp_mmio_write_8b(struct nnp_pci *nnp_pci, u32 off, u64 val)
+{
+	lo_hi_writeq(val, nnp_pci->mmio_va + off);
+}
+
+static inline u64 nnp_mmio_read_8b(struct nnp_pci *nnp_pci, u32 off)
+{
+	return lo_hi_readq(nnp_pci->mmio_va + off);
+}
+
+static void nnp_process_commands(struct nnp_pci *nnp_pci)
+{
+	u32 response_pci_control;
+	u32 read_pointer;
+	u32 write_pointer;
+	u32 avail_slots;
+	int i;
+
+	response_pci_control = nnp_mmio_read(nnp_pci, ELBI_RESPONSE_PCI_CONTROL);
+	read_pointer = FIELD_GET(RESPQ_READ_PTR_MASK, response_pci_control);
+	write_pointer = FIELD_GET(RESPQ_WRITE_PTR_MASK, response_pci_control);
+	if (read_pointer > write_pointer) {
+		/* This should never happen on proper device hardware */
+		dev_err(&nnp_pci->pdev->dev, "Mismatched read and write pointers\n");
+		/*
+		 * For now just ignore it. Implement handling for such fatal
+		 * device errors on a later patch
+		 */
+		return;
+	}
+
+	/* Commands to read */
+	avail_slots = write_pointer - read_pointer;
+
+	if (!avail_slots)
+		return;
+
+	for (i = 0; i < avail_slots; i++) {
+		read_pointer = (read_pointer + 1) % ELBI_RESPONSE_FIFO_DEPTH;
+
+		nnp_pci->response_buf[i] =
+			nnp_mmio_read_8b(nnp_pci,
+					 ELBI_RESPONSE_FIFO_LOW(read_pointer));
+	}
+
+	/*
+	 * HW restriction - we cannot update the read pointer with the same
+	 * value it currently have. This will be the case if we need to advance
+	 * it by FIFO_DEPTH locations. In this case we will update it in two
+	 * steps, first advance by 1, then to the proper value.
+	 */
+	if (avail_slots == ELBI_COMMAND_FIFO_DEPTH) {
+		u32 next_read_pointer =
+			(read_pointer + 1) % ELBI_RESPONSE_FIFO_DEPTH;
+
+		response_pci_control &= ~RESPQ_READ_PTR_MASK;
+		response_pci_control |= FIELD_PREP(RESPQ_READ_PTR_MASK,
+						   next_read_pointer);
+		nnp_mmio_write(nnp_pci, ELBI_RESPONSE_PCI_CONTROL,
+			       response_pci_control);
+	}
+
+	response_pci_control &= ~RESPQ_READ_PTR_MASK;
+	response_pci_control |= FIELD_PREP(RESPQ_READ_PTR_MASK, read_pointer);
+	nnp_mmio_write(nnp_pci, ELBI_RESPONSE_PCI_CONTROL,
+		       response_pci_control);
+}
+
+static void mask_all_interrupts(struct nnp_pci *nnp_pci)
+{
+	nnp_mmio_write(nnp_pci, ELBI_PCI_MSI_MASK, GENMASK(31, 0));
+}
+
+static void unmask_interrupts(struct nnp_pci *nnp_pci)
+{
+	nnp_mmio_write(nnp_pci, ELBI_PCI_MSI_MASK, ~card_status_int_mask);
+}
+
+static void notify_card_doorbell_value(struct nnp_pci *nnp_pci)
+{
+	nnp_pci->card_doorbell_val = nnp_mmio_read(nnp_pci, CARD_DOORBELL_REG);
+	nnpdev_card_doorbell_value_changed(&nnp_pci->nnpdev,
+					   nnp_pci->card_doorbell_val);
+}
+
+static irqreturn_t threaded_interrupt_handler(int irq, void *data)
+{
+	struct nnp_pci *nnp_pci = data;
+	bool should_wake = false;
+
+	mask_all_interrupts(nnp_pci);
+
+	nnp_pci->card_status = nnp_mmio_read(nnp_pci, ELBI_PCI_STATUS);
+
+	nnp_mmio_write(nnp_pci, ELBI_PCI_STATUS,
+		       nnp_pci->card_status & card_status_int_mask);
+
+	if (nnp_pci->card_status & ELBI_PCI_STATUS_CMDQ_READ_UPDATE) {
+		spin_lock(&nnp_pci->lock);
+		should_wake = true;
+		nnp_pci->cmd_read_update_count++;
+		spin_unlock(&nnp_pci->lock);
+	}
+
+	if (nnp_pci->card_status &
+	    ELBI_PCI_STATUS_DOORBELL)
+		notify_card_doorbell_value(nnp_pci);
+
+	if (nnp_pci->card_status & ELBI_PCI_STATUS_RESPQ_NEW_RESPONSE)
+		nnp_process_commands(nnp_pci);
+
+	unmask_interrupts(nnp_pci);
+
+	if (should_wake)
+		wake_up_all(&nnp_pci->card_status_wait);
+
+	return IRQ_HANDLED;
+}
+
+static int nnp_setup_interrupts(struct nnp_pci *nnp_pci, struct pci_dev *pdev)
+{
+	int rc;
+	int irq;
+
+	mask_all_interrupts(nnp_pci);
+
+	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	if (rc < 1)
+		return rc;
+
+	irq = pci_irq_vector(pdev, 0);
+
+	rc = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+				       threaded_interrupt_handler, IRQF_ONESHOT,
+				       "nnpi-msi", nnp_pci);
+	if (rc)
+		goto err_irq_req_fail;
+
+	return 0;
+
+err_irq_req_fail:
+	pci_free_irq_vectors(pdev);
+	return rc;
+}
+
+static void nnp_free_interrupts(struct nnp_pci *nnp_pci, struct pci_dev *pdev)
+{
+	mask_all_interrupts(nnp_pci);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 0), nnp_pci);
+	pci_free_irq_vectors(pdev);
+}
+
+static int nnp_cmdq_flush(struct nnp_device *nnpdev)
+{
+	struct nnp_pci *nnp_pci = container_of(nnpdev, struct nnp_pci, nnpdev);
+
+	nnp_mmio_write(nnp_pci, ELBI_COMMAND_PCI_CONTROL,
+		       ELBI_COMMAND_PCI_CONTROL_FLUSH_MASK);
+
+	return 0;
+}
+
+static struct nnp_device_ops nnp_device_ops = {
+	.cmdq_flush = nnp_cmdq_flush,
+};
+
+static void set_host_boot_state(struct nnp_pci *nnp_pci, int boot_state)
+{
+	u32 doorbell_val = 0;
+
+	if (boot_state != NNP_HOST_BOOT_STATE_NOT_READY) {
+		doorbell_val = nnp_mmio_read(nnp_pci, HOST_DOORBELL_REG);
+		doorbell_val &= ~NNP_HOST_BOOT_STATE_MASK;
+		doorbell_val |= FIELD_PREP(NNP_HOST_BOOT_STATE_MASK, boot_state);
+	}
+
+	nnp_mmio_write(nnp_pci, HOST_DOORBELL_REG, doorbell_val);
+}
+
+static int nnp_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct nnp_pci *nnp_pci;
+	u32 status;
+	int rc;
+
+	nnp_pci = devm_kzalloc(dev, sizeof(*nnp_pci), GFP_KERNEL);
+	if (!nnp_pci)
+		return -ENOMEM;
+
+	nnp_pci->pdev = pdev;
+	pci_set_drvdata(pdev, nnp_pci);
+
+	init_waitqueue_head(&nnp_pci->card_status_wait);
+	spin_lock_init(&nnp_pci->lock);
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return dev_err_probe(dev, rc, "enable_device\n");
+
+	pci_set_master(pdev);
+
+	rc = pcim_iomap_regions(pdev, BIT(0) | BIT(2), NNP_DRIVER_NAME);
+	if (rc)
+		return dev_err_probe(dev, rc, "iomap_regions\n");
+
+	nnp_pci->mmio_va = pcim_iomap_table(pdev)[0];
+	nnp_pci->mem_bar_va = pcim_iomap_table(pdev)[2];
+
+	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		return dev_err_probe(dev, rc, "dma_set_mask\n");
+
+	rc = nnp_setup_interrupts(nnp_pci, pdev);
+	if (rc)
+		return dev_err_probe(dev, rc, "nnp_setup_interrupts\n");
+
+	/*
+	 * done setting up the new pci device,
+	 * add it to the NNP-I framework.
+	 */
+	rc = nnpdev_init(&nnp_pci->nnpdev, dev, &nnp_device_ops);
+	if (rc)
+		return dev_err_probe(dev, rc, "nnpdev_init\n");
+
+	/* notify bios that host driver is up */
+	nnp_cmdq_flush(&nnp_pci->nnpdev);
+	set_host_boot_state(nnp_pci, NNP_HOST_BOOT_STATE_DRV_READY);
+
+	/* Update NNP-I framework with current value of card doorbell value */
+	notify_card_doorbell_value(nnp_pci);
+	status = nnp_mmio_read(nnp_pci, ELBI_PCI_STATUS);
+	if (status & ELBI_PCI_STATUS_DOORBELL)
+		nnp_mmio_write(nnp_pci, ELBI_PCI_STATUS, ELBI_PCI_STATUS_DOORBELL);
+
+	/* process any existing command in the response queue */
+	nnp_process_commands(nnp_pci);
+
+	/* Enable desired interrupts */
+	unmask_interrupts(nnp_pci);
+
+	return 0;
+}
+
+static void nnp_remove(struct pci_dev *pdev)
+{
+	struct nnp_pci *nnp_pci = pci_get_drvdata(pdev);
+
+	/* stop service new interrupts */
+	nnp_free_interrupts(nnp_pci, nnp_pci->pdev);
+
+	/*
+	 * Inform card that host driver is down.
+	 * This will also clear any state on the card so that
+	 * if card is inserted again, it will be in a good, clear
+	 * state.
+	 */
+	set_host_boot_state(nnp_pci, NNP_HOST_BOOT_STATE_NOT_READY);
+
+	nnpdev_destroy(&nnp_pci->nnpdev);
+}
+
+static const struct pci_device_id nnp_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, NNP_PCI_DEVICE_ID) },
+	{ }
+};
+
+static struct pci_driver nnp_driver = {
+	.name = NNP_DRIVER_NAME,
+	.id_table = nnp_pci_tbl,
+	.probe = nnp_probe,
+	.remove = nnp_remove,
+};
+
+module_pci_driver(nnp_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel(R) NNP-I PCIe driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DEVICE_TABLE(pci, nnp_pci_tbl);
-- 
1.8.3.1

