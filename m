Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC71417D08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347708AbhIXVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:33:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:15189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347526AbhIXVdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:33:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="211414791"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="211414791"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="705367220"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2021 14:31:57 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id BFCFD580890;
        Fri, 24 Sep 2021 14:31:57 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon driver
Date:   Fri, 24 Sep 2021 14:31:57 -0700
Message-Id: <20210924213157.3584061-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924213157.3584061-1-david.e.box@linux.intel.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
activating additional silicon features. Features are enabled through a
license activation process.  The SDSi driver provides a per socket, ioctl
interface for applications to perform 3 main provisioning functions:

1. Provision an Authentication Key Certificate (AKC), a key written to
   internal NVRAM that is used to authenticate a capability specific
   activation payload.

2. Provision a Capability Activation Payload (CAP), a token authenticated
   using the AKC and applied to the CPU configuration to activate a new
   feature.

3. Read the SDSi State Certificate, containing the CPU configuration
   state.

The ioctl operations perform function specific mailbox commands that
forward the requests to SDSi hardware to perform authentication of the
payloads and enable the silicon configuration (to be made available after
power cycling).

The SDSi device itself is enumerated as a PCIe VSEC capability on the Intel
Out Of Band Management Services Module (OOBMSM) device. The SDSi device is
a cell of the intel_pmt MFD driver and as such has a build dependency on
CONFIG_MFD_INTEL_PMT.

Link: https://github.com/intel/intel-sdsi
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 MAINTAINERS                         |   6 +
 drivers/platform/x86/intel/Kconfig  |  12 +
 drivers/platform/x86/intel/Makefile |   2 +
 drivers/platform/x86/intel/sdsi.c   | 676 ++++++++++++++++++++++++++++
 include/uapi/linux/sdsi_if.h        |  47 ++
 5 files changed, 743 insertions(+)
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 include/uapi/linux/sdsi_if.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..657431e6c57d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9610,6 +9610,12 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_scu_ipc.h
 F:	drivers/platform/x86/intel_scu_*
 
+INTEL SDSI DRIVER
+M:	David E. Box <david.e.box@linux.intel.com>
+S:	Supported
+F:	drivers/platform/x86/intel/sdsi.c
+F:	include/uapi/linux/sdsi_if.h
+
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
 S:	Maintained
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 0b21468e1bd0..628c68182a55 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -131,6 +131,18 @@ config INTEL_RST
 	  firmware will copy the memory contents back to RAM and resume the OS
 	  as usual.
 
+config INTEL_SDSI
+	tristate "Intel Software Defined Silicon Driver"
+	depends on X86_64
+	depends on MFD_INTEL_PMT
+	help
+	  This driver enables access to the Intel Software Defined Silicon
+	  interface used to provision silicon features with an authentication
+	  certificate and capability activation payload.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_sdsi.
+
 config INTEL_SMARTCONNECT
 	tristate "Intel Smart Connect disabling driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 8b3a3f7bab49..9e9c21c83715 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -25,6 +25,8 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
+intel_sdsi-y				:= sdsi.o
+obj-$(CONFIG_INTEL_SDSI)		+= intel_sdsi.o
 
 # Intel PMIC / PMC / P-Unit drivers
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
new file mode 100644
index 000000000000..c043667debe0
--- /dev/null
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -0,0 +1,676 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Software Defined Silicon driver
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: "David E. Box" <david.e.box@linux.intel.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/sdsi_if.h>
+
+#define SDSI_DEV_NAME			"intel_extnd_cap_65"
+#define SDSI_DEV_NODE_NAME		"intel_sdsi"
+
+#define ACCESS_TYPE_BARID		2
+#define ACCESS_TYPE_LOCAL		3
+
+#define SDSI_MIN_SIZE_DWORDS		276
+#define SDSI_SIZE_CONTROL		8
+#define SDSI_SIZE_MAILBOX		1024
+#define SDSI_SIZE_REGS			72
+#define SDSI_SIZE_CMD			sizeof(u64)
+
+/*
+ * Write messages are currently up to the size of the mailbox
+ * while read messages are up to 4 times the size of the
+ * mailbox, sent in packets
+ */
+#define SDSI_SIZE_WRITE_MSG		SDSI_SIZE_MAILBOX
+#define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
+
+#define SDSI_ENABLED_FEATURES_OFFSET	16
+#define SDSI_ENABLED			BIT(3)
+#define SDSI_SOCKET_ID_OFFSET		64
+#define SDSI_SOCKET_ID			GENMASK(3, 0)
+
+#define SDSI_MBOX_CMD_SUCCESS		0x40
+#define SDSI_MBOX_CMD_TIMEOUT		0x80
+
+#define MBOX_TIMEOUT_US			2000
+#define MBOX_TIMEOUT_ACQUIRE_US		1000
+#define MBOX_POLLING_PERIOD_US		100
+#define MBOX_MAX_PACKETS		4
+
+#define MBOX_OWNER_NONE			0x00
+#define MBOX_OWNER_INBAND		0x01
+
+#define CTRL_RUN_BUSY			BIT(0)
+#define CTRL_READ_WRITE			BIT(1)
+#define CTRL_SOM			BIT(2)
+#define CTRL_EOM			BIT(3)
+#define CTRL_OWNER			GENMASK(5, 4)
+#define CTRL_COMPLETE			BIT(6)
+#define CTRL_READY			BIT(7)
+#define CTRL_STATUS			GENMASK(15, 8)
+#define CTRL_PACKET_SIZE		GENMASK(31, 16)
+#define CTRL_MSG_SIZE			GENMASK(63, 48)
+
+#define DISC_TABLE_SIZE			12
+#define DT_ACCESS_TYPE			GENMASK(3, 0)
+#define DT_SIZE				GENMASK(19, 12)
+#define DT_TBIR				GENMASK(2, 0)
+#define DT_OFFSET(v)			((v) & GENMASK(31, 3))
+
+enum sdsi_command {
+	SDSI_CMD_PROVISION_AKC		= 0x04,
+	SDSI_CMD_PROVISION_CAP		= 0x08,
+	SDSI_CMD_READ_STATE		= 0x10,
+};
+
+struct sdsi_mbox_info {
+	u64	*payload;
+	u64	*buffer;
+	int	size;
+	bool	is_write;
+};
+
+struct disc_table {
+	u32	access_info;
+	u32	guid;
+	u32	offset;
+};
+
+struct sdsi_priv {
+	struct disc_table	disc_table;
+	struct mutex		mb_lock;
+	struct mutex		akc_lock;
+	struct miscdevice	miscdev;
+	struct kref		kref;
+	struct bin_attribute	registers_bin_attr;
+	struct file		*akc_owner;
+	struct platform_device	*pdev;
+	void __iomem		*control_addr;
+	void __iomem		*mbox_addr;
+	void __iomem		*regs_addr;
+	int			socket_id;
+	bool			sdsi_enabled;
+	bool			dev_present;
+};
+
+static __always_inline void
+sdsi_qword_memcpy_toio(u64 __iomem *to, const u64 *from, size_t count_bytes)
+{
+	size_t count = count_bytes / sizeof(*to);
+	int i;
+
+	for (i = 0; i < count; i++)
+		writeq(from[i], &to[i]);
+}
+
+static __always_inline void
+sdsi_qword_memcpy_fromio(u64 *to, const u64 __iomem *from, size_t count_bytes)
+{
+	size_t count = count_bytes / sizeof(*to);
+	int i;
+
+	for (i = 0; i < count; i++)
+		to[i] = readq(&from[i]);
+}
+
+static inline struct sdsi_priv *to_sdsi_priv(struct miscdevice *miscdev)
+{
+	return container_of(miscdev, struct sdsi_priv, miscdev);
+}
+
+static inline void sdsi_complete_transaction(struct sdsi_priv *priv)
+{
+	u64 control = FIELD_PREP(CTRL_COMPLETE, 1);
+
+	lockdep_assert_held(&priv->mb_lock);
+	writeq(control, priv->control_addr);
+}
+
+static int sdsi_status_to_errno(u32 status)
+{
+	switch (status) {
+	case SDSI_MBOX_CMD_SUCCESS:
+		return 0;
+	case SDSI_MBOX_CMD_TIMEOUT:
+		return -ETIMEDOUT;
+	default:
+		return -EIO;
+	}
+}
+
+static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, int *data_size)
+{
+	u32 total, loop, eom, status, message_size;
+	struct platform_device *pdev = priv->pdev;
+	u64 control;
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Format and send the read command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
+	total = 0;
+	loop = 0;
+	do {
+		int offset = SDSI_SIZE_MAILBOX * loop;
+		void __iomem *addr = priv->mbox_addr + offset;
+		u64 *buf = info->buffer + (offset / SDSI_SIZE_CMD);
+		u32 packet_size;
+
+		/* Poll on ready bit */
+		ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
+					 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
+		if (ret)
+			break;
+
+		eom = FIELD_GET(CTRL_EOM, control);
+		status = FIELD_GET(CTRL_STATUS, control);
+		packet_size = FIELD_GET(CTRL_PACKET_SIZE, control);
+		message_size = FIELD_GET(CTRL_MSG_SIZE, control);
+
+		ret = sdsi_status_to_errno(status);
+		if (ret)
+			break;
+
+		/* Only the last packet can be less than the mailbox size. */
+		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
+			dev_err(&pdev->dev, "Invalid packet size\n");
+			ret = -EPROTO;
+			break;
+		}
+
+		if (packet_size > SDSI_SIZE_MAILBOX) {
+			dev_err(&pdev->dev, "Packet size to large\n");
+			ret = -EPROTO;
+			break;
+		}
+
+		sdsi_qword_memcpy_fromio(buf, addr, round_up(packet_size, SDSI_SIZE_CMD));
+
+		total += packet_size;
+
+		sdsi_complete_transaction(priv);
+	} while (!eom && ++loop < MBOX_MAX_PACKETS);
+
+	if (ret) {
+		sdsi_complete_transaction(priv);
+		return ret;
+	}
+
+	if (!eom) {
+		dev_err(&pdev->dev, "Exceeded read attempts\n");
+		return -EPROTO;
+	}
+
+	/* Message size check is only valid for multi-packet transfers */
+	if (loop && total != message_size)
+		dev_warn(&pdev->dev, "Read count %d differs from expected count %d\n",
+			 total, message_size);
+
+	*data_size = total;
+
+	return 0;
+}
+
+static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+{
+	u64 control;
+	u32 status;
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Write rest of the payload */
+	sdsi_qword_memcpy_toio(priv->mbox_addr + SDSI_SIZE_CMD, info->payload + 1,
+			       info->size - SDSI_SIZE_CMD);
+
+	/* Format and send the write command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_READ_WRITE, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	/* Poll on run_busy bit */
+	ret = readq_poll_timeout(priv->control_addr, control, !(control & CTRL_RUN_BUSY),
+				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
+
+	if (ret)
+		goto release_mbox;
+
+	status = FIELD_GET(CTRL_STATUS, control);
+	ret = sdsi_status_to_errno(status);
+
+release_mbox:
+	sdsi_complete_transaction(priv);
+
+	return ret;
+}
+
+static int sdsi_mbox_cmd(struct sdsi_priv *priv, struct sdsi_mbox_info *info, int *data_size)
+{
+	u64 control;
+	int ret = 0;
+	u32 owner;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Check mailbox is available */
+	control = readq(priv->control_addr);
+	owner = FIELD_GET(CTRL_OWNER, control);
+	if (owner != MBOX_OWNER_NONE)
+		return -EBUSY;
+
+	/* Write first qword of payload */
+	writeq(info->payload[0], priv->mbox_addr);
+
+	/* Check for ownership */
+	ret = readq_poll_timeout(priv->control_addr, control,
+				 FIELD_GET(CTRL_OWNER, control) & MBOX_OWNER_INBAND,
+				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_ACQUIRE_US);
+	if (ret)
+		return ret;
+
+	if (info->is_write)
+		ret = sdsi_mbox_cmd_write(priv, info);
+	else
+		ret = sdsi_mbox_cmd_read(priv, info, data_size);
+
+	return ret;
+}
+
+static long sdsi_if_provision(struct sdsi_priv *priv, void __user *argp, enum sdsi_command cmd)
+{
+	struct sdsi_mbox_info info;
+	u32 __user *datap = argp;
+	u32 data_size;
+	int ret;
+
+	if (get_user(data_size, datap))
+		return -EFAULT;
+
+	if (data_size > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
+		return -EOVERFLOW;
+
+	/* Qword aligned message + command qword */
+	info.size = round_up(data_size, SDSI_SIZE_CMD) + SDSI_SIZE_CMD;
+	info.is_write = true;
+
+	info.payload = kzalloc(info.size, GFP_KERNEL);
+	if (!info.payload)
+		return -ENOMEM;
+
+	/* Copy message to payload buffer */
+	if (copy_from_user(info.payload, argp + sizeof(data_size), data_size)) {
+		ret = -EFAULT;
+		goto free_payload;
+	}
+
+	/* Command is last qword of payload buffer */
+	info.payload[(info.size - SDSI_SIZE_CMD) / SDSI_SIZE_CMD] = cmd;
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		goto free_payload;
+	ret = sdsi_mbox_cmd(priv, &info, NULL);
+	mutex_unlock(&priv->mb_lock);
+
+free_payload:
+	kfree(info.payload);
+
+	return (ret < 0) ? ret : 0;
+}
+
+static long sdsi_if_read_cert_state(struct sdsi_priv *priv, void __user *argp)
+{
+	u64 command = SDSI_CMD_READ_STATE;
+	struct sdsi_mbox_info info;
+	u32 __user *datap = argp;
+	u32 data_size;
+	int ret;
+
+	/* Buffer for return data */
+	info.buffer = kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
+	if (!info.buffer)
+		return -ENOMEM;
+
+	info.payload = &command;
+	info.size = sizeof(command);
+	info.is_write = false;
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		goto free_buffer;
+	ret = sdsi_mbox_cmd(priv, &info, &data_size);
+	mutex_unlock(&priv->mb_lock);
+	if (ret < 0)
+		goto free_buffer;
+
+	/* First field is the size of the data */
+	if (put_user(data_size, datap)) {
+		ret = -EFAULT;
+		goto free_buffer;
+	}
+
+	/* Copy the data */
+	if (copy_to_user(argp + sizeof(data_size), info.buffer, data_size)) {
+		ret = -EFAULT;
+		goto free_buffer;
+	}
+
+free_buffer:
+	kfree(info.buffer);
+
+	return (ret < 0) ? ret : 0;
+}
+
+static long sdsi_device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct miscdevice *miscdev = file->private_data;
+	struct sdsi_priv *priv = to_sdsi_priv(miscdev);
+	void __user *argp = (void __user *)arg;
+	long ret = -EINVAL;
+
+	if (!priv->dev_present)
+		return -ENODEV;
+
+	if (!priv->sdsi_enabled)
+		return -EPERM;
+
+	if (cmd == SDSI_IF_READ_STATE)
+		return sdsi_if_read_cert_state(priv, argp);
+
+	mutex_lock(&priv->akc_lock);
+	switch (cmd) {
+	case SDSI_IF_PROVISION_AKC:
+		/*
+		 * While writing an authentication certificate disallow other openers
+		 * from using AKC or CAP.
+		 */
+		if (!priv->akc_owner)
+			priv->akc_owner = file;
+
+		if (priv->akc_owner != file) {
+			ret = -EUSERS;
+			goto unlock_akc;
+		}
+
+		ret = sdsi_if_provision(priv, argp, SDSI_CMD_PROVISION_AKC);
+		break;
+
+	case SDSI_IF_PROVISION_CAP:
+		if (priv->akc_owner && priv->akc_owner != file) {
+			ret = -EUSERS;
+			goto unlock_akc;
+		}
+
+		ret = sdsi_if_provision(priv, argp, SDSI_CMD_PROVISION_CAP);
+		break;
+
+	default:
+		break;
+	}
+
+unlock_akc:
+	mutex_unlock(&priv->akc_lock);
+
+	return ret;
+}
+
+static ssize_t sdsi_read_registers(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf, loff_t off,
+				   size_t count)
+{
+	struct sdsi_priv *priv = attr->private;
+	void __iomem *addr = priv->regs_addr;
+
+	if (!priv->dev_present)
+		return -ENODEV;
+
+	memcpy_fromio(buf, addr + off, count);
+
+	return count;
+}
+
+static int sdsi_add_bin_attrs(struct platform_device *pdev)
+{
+	struct sdsi_priv *priv = platform_get_drvdata(pdev);
+
+	priv->registers_bin_attr.private = priv;
+	priv->registers_bin_attr.attr.name = "registers";
+	priv->registers_bin_attr.attr.mode = 0400;
+	priv->registers_bin_attr.read = sdsi_read_registers;
+	priv->registers_bin_attr.size = SDSI_SIZE_REGS;
+
+	return sysfs_create_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
+}
+
+static ssize_t guid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%x\n", priv->disc_table.guid);
+}
+static DEVICE_ATTR_RO(guid);
+
+static struct attribute *sdsi_attrs[] = {
+	&dev_attr_guid.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(sdsi);
+
+static void sdsi_priv_release(struct kref *kref)
+{
+	struct sdsi_priv *priv = container_of(kref, struct sdsi_priv, kref);
+
+	mutex_destroy(&priv->akc_lock);
+	mutex_destroy(&priv->mb_lock);
+	kfree(priv->miscdev.name);
+	kfree(priv);
+}
+
+static int sdsi_device_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+	struct sdsi_priv *priv = to_sdsi_priv(miscdev);
+
+	kref_get(&priv->kref);
+
+	return 0;
+}
+
+static int sdsi_device_release(struct inode *inode, struct file *file)
+{
+
+	struct miscdevice *miscdev = file->private_data;
+	struct sdsi_priv *priv = to_sdsi_priv(miscdev);
+
+	if (priv->akc_owner == file)
+		priv->akc_owner = NULL;
+
+	kref_put(&priv->kref, sdsi_priv_release);
+
+	return 0;
+}
+
+static const struct file_operations sdsi_char_device_ops = {
+	.owner = THIS_MODULE,
+	.open = sdsi_device_open,
+	.unlocked_ioctl = sdsi_device_ioctl,
+	.release = sdsi_device_release,
+};
+
+static int sdsi_create_misc_device(struct platform_device *pdev)
+{
+	struct sdsi_priv *priv = platform_get_drvdata(pdev);
+
+	priv->miscdev.name = kasprintf(GFP_KERNEL, "isdsi-%d", priv->socket_id);
+	if (!priv->miscdev.name)
+		return -ENOMEM;
+
+	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+	priv->miscdev.fops = &sdsi_char_device_ops;
+	priv->miscdev.parent = &pdev->dev;
+
+	return misc_register(&priv->miscdev);
+}
+
+static int sdsi_map_sdsi_registers(struct platform_device *pdev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct sdsi_priv *priv = platform_get_drvdata(pdev);
+	u32 access_type = FIELD_GET(DT_ACCESS_TYPE, priv->disc_table.access_info);
+	u32 size = FIELD_GET(DT_SIZE, priv->disc_table.access_info);
+	u32 tbir = FIELD_GET(DT_TBIR, priv->disc_table.offset);
+	u32 offset = DT_OFFSET(priv->disc_table.offset);
+	struct resource res = {0}, *disc_res;
+
+	/* Starting location of SDSi MMIO region based on access type */
+	switch (access_type) {
+	case ACCESS_TYPE_LOCAL:
+		if (tbir) {
+			dev_err(&pdev->dev,
+				"Unsupported BAR index %d for access type %d\n",
+				tbir, access_type);
+			return -EINVAL;
+		}
+
+		disc_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!disc_res)
+			return -ENODEV;
+
+		/*
+		 * For access_type LOCAL, the base address is as follows:
+		 * base address = end of discovery region + base offset + 1
+		 */
+		res.start = disc_res->end + offset + 1;
+		break;
+
+	case ACCESS_TYPE_BARID:
+		res.start = pci_resource_start(pci_dev, tbir) + offset;
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Unrecognized access_type %d\n", access_type);
+		return -EINVAL;
+	}
+
+	res.end = res.start + size * sizeof(u32) - 1;
+	res.flags = IORESOURCE_MEM;
+
+	priv->control_addr = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(priv->control_addr))
+		return PTR_ERR(priv->control_addr);
+
+	priv->mbox_addr = priv->control_addr + SDSI_SIZE_CONTROL;
+	priv->regs_addr = priv->mbox_addr + SDSI_SIZE_MAILBOX;
+
+	priv->socket_id = readl(priv->regs_addr + SDSI_SOCKET_ID_OFFSET) &
+				SDSI_SOCKET_ID;
+
+	priv->sdsi_enabled = !!(readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET) &
+				SDSI_ENABLED);
+	return 0;
+}
+
+static int sdsi_probe(struct platform_device *pdev)
+{
+	void __iomem *disc_addr;
+	struct sdsi_priv *priv;
+	int ret;
+
+	disc_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(disc_addr))
+		return PTR_ERR(disc_addr);
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	kref_init(&priv->kref);
+
+	platform_set_drvdata(pdev, priv);
+	priv->pdev = pdev;
+	mutex_init(&priv->mb_lock);
+	mutex_init(&priv->akc_lock);
+
+	memcpy_fromio(&priv->disc_table, disc_addr, DISC_TABLE_SIZE);
+
+	ret = sdsi_map_sdsi_registers(pdev);
+	if (ret)
+		goto put_kref;
+
+	ret = sdsi_create_misc_device(pdev);
+	if (ret)
+		goto put_kref;
+
+	ret = sdsi_add_bin_attrs(pdev);
+	if (ret)
+		goto deregister_misc;
+
+	priv->dev_present = true;
+
+	return 0;
+
+deregister_misc:
+	misc_deregister(&priv->miscdev);
+put_kref:
+	kref_put(&priv->kref, sdsi_priv_release);
+
+	return ret;
+}
+
+static int sdsi_remove(struct platform_device *pdev)
+{
+	struct sdsi_priv *priv = platform_get_drvdata(pdev);
+
+	priv->dev_present = false;
+	sysfs_remove_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
+	misc_deregister(&priv->miscdev);
+	kref_put(&priv->kref, sdsi_priv_release);
+
+	return 0;
+}
+
+static struct platform_driver sdsi_driver = {
+	.driver = {
+		.name		= SDSI_DEV_NAME,
+		.dev_groups	= sdsi_groups,
+	},
+	.probe  = sdsi_probe,
+	.remove = sdsi_remove,
+};
+module_platform_driver(sdsi_driver);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Software Defined Silicon driver");
+MODULE_ALIAS("platform:" SDSI_DEV_NAME);
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/sdsi_if.h b/include/uapi/linux/sdsi_if.h
new file mode 100644
index 000000000000..468e548fbdab
--- /dev/null
+++ b/include/uapi/linux/sdsi_if.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Intel Software Defined Silicon: OS to hardware Interface
+ * Copyright (c) 2021, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: "David E. Box" <david.e.box@linux.intel.com>
+ */
+
+#ifndef __SDSI_IF_H
+#define __SDSI_IF_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct sdsi_if_sdsi_state - Read current SDSi State Certificate
+ * @size:	size of the certificate
+ * @data:	SDSi State Certificate
+ *
+ * Used to return output of ioctl SDSI_IF_READ_STATE. This command is used to
+ * read the current CPU configuration state
+ */
+struct sdsi_if_sdsi_state {
+	__u32	size;
+	__u8	data[4096];
+};
+
+/**
+ * struct sdsi_if_provision_payload - Provision a certificate or activation payload
+ * @size:	size of the certificate of activation payload
+ * @data:	certificate or activation payload
+ *
+ * Used with ioctl command SDSI_IF_IOW_PROVISION_AKC and
+ * SDSI_IF_IOW_PROVISION_CAP to provision a CPU with an Authentication
+ * Key Certificate or Capability Activation Payload respectively.
+ */
+struct sdsi_if_provision_payload {
+	__u32	size;
+	__u8	data[4096];
+};
+
+#define SDSI_IF_MAGIC		0xDF
+#define SDSI_IF_READ_STATE	_IOR(SDSI_IF_MAGIC, 0, struct sdsi_if_sdsi_state *)
+#define SDSI_IF_PROVISION_AKC	_IOW(SDSI_IF_MAGIC, 1, struct sdsi_if_provision_payload *)
+#define SDSI_IF_PROVISION_CAP	_IOW(SDSI_IF_MAGIC, 2, struct sdsi_if_provision_payload *)
+#endif
-- 
2.25.1

