Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA437F49C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEMJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:01:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:47045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhEMI75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:59:57 -0400
IronPort-SDR: yM9t/LdVBddVQrPnZ1OnilQ5/gQnpG+aXUwYIzjiRoXWJ5ZIud4B6ksR+5ujaOLZm2WHuuY00G
 mIGz1jgMwoAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032294"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032294"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:19 -0700
IronPort-SDR: OH8h5tzp6AB6dlj4f/ENiiFcQVO9UD6MzTw3h0VJ0bYPlaDjJqYPblk+QCnNCySwhE1xQHQn9T
 qctW/+3mR70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928313"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:17 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 08/15] misc: nnpi: Boot NNP-I device
Date:   Thu, 13 May 2021 11:57:18 +0300
Message-Id: <20210513085725.45528-9-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot the NNP-I device after the card is powered-on or reset. When the
NNP-I card comes up, it's flashed BIOS starts running.
Since the persistent storage on the device is rather small, it needs to
get its OS boot image from the host driver. So once the card's BIOS is
running, the host driver loads and provides a boot image to the card BIOS,
which uses it to run the Embedded Linux image and SW stack on the card.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/Makefile    |   3 +-
 drivers/misc/intel-nnpi/bootimage.c | 246 ++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/bootimage.h |  43 ++++++
 drivers/misc/intel-nnpi/device.c    | 291 ++++++++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/device.h    |  77 ++++++++++
 drivers/misc/intel-nnpi/nnp_pcie.c  |  16 ++
 6 files changed, 675 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel-nnpi/bootimage.c
 create mode 100644 drivers/misc/intel-nnpi/bootimage.h

diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
index da2863b..e46c89f 100644
--- a/drivers/misc/intel-nnpi/Makefile
+++ b/drivers/misc/intel-nnpi/Makefile
@@ -5,7 +5,8 @@
 
 obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
 
-intel_nnpi-y := device.o msg_scheduler.o hostres.o host_chardev.o nnp_user.o
+intel_nnpi-y := device.o msg_scheduler.o hostres.o host_chardev.o nnp_user.o \
+                bootimage.o
 
 intel_nnpi_pcie-y := nnp_pcie.o
 
diff --git a/drivers/misc/intel-nnpi/bootimage.c b/drivers/misc/intel-nnpi/bootimage.c
new file mode 100644
index 0000000..38b5156
--- /dev/null
+++ b/drivers/misc/intel-nnpi/bootimage.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/printk.h>
+
+#include "bootimage.h"
+#include "device.h"
+#include "hostres.h"
+#include "ipc_protocol.h"
+#include "nnp_boot_defs.h"
+
+#define MAX_IMAGE_NAME_LEN   (NAME_MAX + 1)
+
+void nnpdev_boot_image_init(struct image_info *boot_image)
+{
+	boot_image->state = IMAGE_NONE;
+	boot_image->hostres = NULL;
+	mutex_init(&boot_image->mutex);
+}
+
+static int load_firmware(struct image_info *image_info)
+{
+	const struct firmware *fw;
+	struct nnp_device *nnpdev = container_of(image_info, struct nnp_device,
+						 boot_image);
+	struct device *dev = nnpdev->dev;
+	struct kstat stat;
+	struct path path;
+	static const char *fname = "/lib/firmware/" NNP_FIRMWARE_NAME;
+	void *vptr;
+	int ret;
+
+	lockdep_assert_held(&image_info->mutex);
+
+	/*
+	 * find image file size
+	 *
+	 * NOTE: we look for the file under a constant path "/lib/firmware"
+	 * since it works and accepted on all platforms that NNP-I device
+	 * can be installed.
+	 * A better solution would be to look at the same paths that the
+	 * firmware API will search however the firmware API does not
+	 * export any function to do the search and there is no point
+	 * duplicating it here.
+	 */
+	ret = kern_path(fname, LOOKUP_FOLLOW, &path);
+	if (ret) {
+		pr_err("Could not find image under /lib/firmware\n");
+		return ret;
+	}
+
+	ret = vfs_getattr(&path, &stat, STATX_SIZE, 0);
+	path_put(&path);
+	if (ret) {
+		pr_err("Failed to get file size for %s error=%d\n", fname, ret);
+		return ret;
+	}
+
+	/* create host resource to hold the boot image content */
+	image_info->hostres = nnp_hostres_alloc(stat.size, DMA_TO_DEVICE);
+	if (IS_ERR(image_info->hostres))
+		return PTR_ERR(image_info->hostres);
+
+	vptr = nnp_hostres_vptr(image_info->hostres);
+
+	/*
+	 * load the image into the host resource.
+	 * We load directly to pre-allocated host resource memory
+	 * in order to prevent caching of the boot image inside
+	 * firmware API
+	 */
+	ret = request_firmware_into_buf(&fw, NNP_FIRMWARE_NAME, dev, vptr,
+					stat.size);
+	if (ret) {
+		pr_err("failed to load firmware %s ret=%d\n", fname, ret);
+		nnp_hostres_put(image_info->hostres);
+		image_info->hostres = NULL;
+		return ret;
+	}
+
+	release_firmware(fw);
+	image_info->state = IMAGE_AVAILABLE;
+
+	return 0;
+}
+
+static void load_image_handler(struct work_struct *work)
+{
+	struct image_info *image_info = container_of(work, struct image_info,
+						     work);
+	struct nnp_device *nnpdev = container_of(image_info, struct nnp_device,
+						 boot_image);
+	dma_addr_t page_list_addr;
+	unsigned int total_chunks;
+	unsigned int image_size;
+	u64 cmd[3];
+	u32 val;
+	int ret;
+
+	mutex_lock(&image_info->mutex);
+
+	/* do not load if image load request has canceled */
+	if (image_info->state != IMAGE_REQUESTED) {
+		mutex_unlock(&image_info->mutex);
+		return;
+	}
+
+	/* load boot image from disk */
+	ret = load_firmware(image_info);
+	if (ret) {
+		image_info->state = IMAGE_LOAD_FAILED;
+		goto fail;
+	}
+
+	/* map image to the device */
+	image_info->hostres_map = nnp_hostres_map_device(image_info->hostres,
+							 nnpdev, true,
+							 &page_list_addr,
+							 &total_chunks);
+	if (IS_ERR(image_info->hostres_map)) {
+		nnp_hostres_put(image_info->hostres);
+		image_info->hostres = NULL;
+		image_info->state = IMAGE_NONE;
+		goto fail;
+	}
+
+	mutex_unlock(&image_info->mutex);
+
+	image_size = (unsigned int)nnp_hostres_size(image_info->hostres);
+
+	/* image successfully mapped - send it to the device to boot */
+	dev_dbg(nnpdev->dev,
+		"Mapped boot image num_chunks=%u total_size=%u\n", total_chunks,
+		image_size);
+
+	/* write image address directly to the command Q */
+	cmd[0] = FIELD_PREP(NNP_H2C_BOOT_IMAGE_READY_QW0_OP_MASK,
+			    NNP_IPC_H2C_OP_BIOS_PROTOCOL);
+	cmd[0] |= FIELD_PREP(NNP_H2C_BOOT_IMAGE_READY_QW0_TYPE_MASK,
+			     NNP_IPC_H2C_TYPE_BOOT_IMAGE_READY);
+	cmd[0] |= FIELD_PREP(NNP_H2C_BOOT_IMAGE_READY_QW0_SIZE_MASK,
+			     2 * sizeof(u64));
+
+	cmd[1] = (u64)page_list_addr + sizeof(struct nnp_dma_chain_header);
+
+	cmd[2] = FIELD_PREP(NNP_H2C_BOOT_IMAGE_READY_QW2_DESC_SIZE_MASK,
+			    total_chunks * sizeof(struct nnp_dma_chain_entry));
+	cmd[2] |= FIELD_PREP(NNP_H2C_BOOT_IMAGE_READY_QW2_IMAGE_SIZE_MASK,
+			     image_size);
+
+	nnpdev->ops->cmdq_write_mesg(nnpdev, cmd, 3);
+	return;
+
+fail:
+	/* notify card that boot image cannot be loaded */
+	val = FIELD_PREP(NNP_HOST_ERROR_MASK,
+			 NNP_HOST_ERROR_CANNOT_LOAD_IMAGE);
+	nnpdev->ops->set_host_doorbell_value(nnpdev, val);
+	mutex_unlock(&image_info->mutex);
+}
+
+/**
+ * nnpdev_load_boot_image() - load boot image and send it to device
+ * @nnpdev: the device requested the image
+ *
+ * This function starts the flow of loading a boot image and map it to the
+ * requesting device. It will launch a work to load the boot image.
+ * It is an error to call this function if boot image load for the same
+ * device is already in progress.
+ *
+ * Return:
+ * * 0       - boot image was successfully loaded, mapped and sent to the device.
+ * * -EINVAL - image load is already in progress
+ */
+int nnpdev_load_boot_image(struct nnp_device *nnpdev)
+{
+	struct image_info *image_info = &nnpdev->boot_image;
+
+	/* check if the image is already loaded or in progress */
+	mutex_lock(&image_info->mutex);
+	if (image_info->state != IMAGE_NONE) {
+		mutex_unlock(&image_info->mutex);
+		return -EINVAL;
+	}
+
+	/* initialize image load request */
+	image_info->state = IMAGE_REQUESTED;
+	mutex_unlock(&image_info->mutex);
+	INIT_WORK(&image_info->work, load_image_handler);
+
+	/* schedule work to load the image */
+	schedule_work(&image_info->work);
+
+	return 0;
+}
+
+/**
+ * nnpdev_unload_boot_image() - unmaps boot image for device
+ * @nnpdev: the device
+ *
+ * This function is called when the device no longer need the boot image
+ * in memory. either because it was already copied to the device or when
+ * the device is removed during the image load request is in progress.
+ * The function unmaps the device from the host resource.
+ *
+ * Return: error code or zero.
+ */
+int nnpdev_unload_boot_image(struct nnp_device *nnpdev)
+{
+	struct image_info *image_info = &nnpdev->boot_image;
+	int ret = 0;
+
+	mutex_lock(&image_info->mutex);
+	switch (image_info->state) {
+	case IMAGE_NONE:
+		ret = -EINVAL;
+		goto done;
+	case IMAGE_REQUESTED:
+		image_info->state = IMAGE_NONE;
+		mutex_unlock(&image_info->mutex);
+		cancel_work_sync(&image_info->work);
+		return 0;
+	case IMAGE_LOAD_FAILED:
+	case IMAGE_AVAILABLE:
+		break;
+	}
+
+	if (image_info->hostres) {
+		nnp_hostres_unmap_device(image_info->hostres_map);
+		nnp_hostres_put(image_info->hostres);
+		image_info->hostres = NULL;
+	}
+
+	image_info->state = IMAGE_NONE;
+
+done:
+	mutex_unlock(&image_info->mutex);
+	return ret;
+}
diff --git a/drivers/misc/intel-nnpi/bootimage.h b/drivers/misc/intel-nnpi/bootimage.h
new file mode 100644
index 0000000..c5efe46
--- /dev/null
+++ b/drivers/misc/intel-nnpi/bootimage.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNPDRV_BOOTIMAGE_H
+#define _NNPDRV_BOOTIMAGE_H
+
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+
+struct nnp_device;
+
+enum image_state {
+	IMAGE_NONE = 0,
+	IMAGE_REQUESTED,
+	IMAGE_LOAD_FAILED,
+	IMAGE_AVAILABLE
+};
+
+/**
+ * struct image_info - describes a boot image object
+ * @work: handle for placing the image load in a workqueue
+ * @state: state indicating whether it is loaded or load failed
+ * @mutex: protects accesses to @state and @hostres
+ * @load_fail_err: zero or error code if @state is IMAGE_LOAD_FAILED.
+ * @hostres: host resource object allocated for the image content
+ * @hostres_map: mapping object of host resource to device
+ *
+ * This structure describe a request to load boot image from disk,
+ * there is one such structure for each device.
+ */
+struct image_info {
+	struct work_struct           work;
+	enum image_state             state;
+	struct mutex                 mutex;
+	struct host_resource         *hostres;
+	struct nnpdev_mapping        *hostres_map;
+};
+
+void nnpdev_boot_image_init(struct image_info *boot_image);
+int nnpdev_load_boot_image(struct nnp_device *nnpdev);
+int nnpdev_unload_boot_image(struct nnp_device *nnpdev);
+
+#endif /* _NNPDRV_BOOTIMAGE_H */
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index a3c6a1d..f4fc975 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -3,13 +3,18 @@
 
 #define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/printk.h>
 
+#include "bootimage.h"
 #include "device.h"
 #include "host_chardev.h"
 #include "msg_scheduler.h"
+#include "nnp_boot_defs.h"
 
 static DEFINE_IDA(dev_ida);
 
@@ -18,6 +23,178 @@ bool nnpdev_no_devices(void)
 	return ida_is_empty(&dev_ida);
 }
 
+static void send_sysinfo_request_to_bios(struct nnp_device *nnpdev)
+{
+	u64 cmd[3];
+
+	cmd[0] = FIELD_PREP(NNP_H2C_BIOS_SYS_INFO_REQ_QW0_OP_MASK,
+			    NNP_IPC_H2C_OP_BIOS_PROTOCOL);
+	cmd[0] |= FIELD_PREP(NNP_H2C_BIOS_SYS_INFO_REQ_QW0_TYPE_MASK,
+			     NNP_IPC_H2C_TYPE_SYSTEM_INFO_REQ);
+	cmd[0] |= FIELD_PREP(NNP_H2C_BIOS_SYS_INFO_REQ_QW0_SIZE_MASK,
+			     2 * sizeof(u64));
+
+	cmd[1] = (u64)nnpdev->bios_system_info_dma_addr;
+
+	cmd[2] = FIELD_PREP(NNP_H2C_BIOS_SYS_INFO_REQ_QW2_SIZE_MASK,
+			    NNP_PAGE_SIZE);
+
+	nnpdev->ops->cmdq_flush(nnpdev);
+
+	nnpdev->ops->cmdq_write_mesg(nnpdev, cmd, 3);
+}
+
+/**
+ * build_bios_version_string() - builds printable string of bios version string
+ * @nnpdev: pointer to device structure
+ *
+ * Initializes nnpdev->bios_version_str with printable string of bios version
+ * from bios_system_info page.
+ */
+static void build_bios_version_string(struct nnp_device *nnpdev)
+{
+	unsigned int i;
+	__le16 *v;
+
+	if (!nnpdev->bios_system_info)
+		return;
+
+	/*
+	 * The bios version string in the bios's system info page
+	 * holds __le16 for each character in the version string.
+	 * (see struct nnp_c2h_bios_version)
+	 * Here we convert it to string of chars by taking only the
+	 * LSB from each 16-bit character
+	 */
+	v = (__le16 *)&nnpdev->bios_system_info->bios_ver;
+
+	/* check that bios version string is corrected null terminated */
+	if (nnpdev->bios_system_info->bios_ver.null_terminator != 0)
+		return;
+
+	for (i = 0; i < NNP_BIOS_VERSION_LEN - 1 && v[i] != 0; ++i)
+		nnpdev->bios_version_str[i] = v[i];
+
+	nnpdev->bios_version_str[i] = '\0';
+}
+
+static int unload_boot_image(struct nnp_device *nnpdev)
+{
+	nnpdev->boot_image_loaded = false;
+	return nnpdev_unload_boot_image(nnpdev);
+}
+
+/**
+ * nnpdev_set_boot_state() - sets new device state.
+ * @nnpdev: pointer to device structure
+ * @mask: mask of device state bits defined in device.h
+ *
+ * This function sets new device status and handles the state machine of
+ * device boot flow.
+ * It is being called when various device notifications are received or
+ * some error conditions are detected.
+ *
+ * The following flow describes the communication flow with the NNP-I card's
+ * BIOS during the device boot flow, this function gets called when device
+ * state changes when progressing in this flow:
+ * 1) The device report its boot state through the "card doorbell" register,
+ *    that signals an interrupt to the host and the "pci" layer in the driver
+ *    calls the nnpdev_card_doorbell_value_changed function.
+ * 2) When the device signals that it is "Ready to boot", the host driver
+ *    sends it through the "command queue" an address of page in host memory.
+ * 3) The card BIOS fills the page of memory with card system info and change
+ *    the doorbell value to "sysinfo ready"
+ * 4) The host driver then initiate the boot image loading.
+ * 5) When boot image is ready in memory, the host driver send a
+ *    "Boot image ready" message and the card BIOS starts booting and changes
+ *    the doorbell value to indicate success or failure.
+ * 6) When receiving indication about success/failure the host driver signals
+ *    that the device no longer needs the boot image in memory.
+ *    When all devices no longer need the image it will be removed.
+ */
+void nnpdev_set_boot_state(struct nnp_device *nnpdev, u32 mask)
+{
+	u32 state, prev_state;
+	bool becomes_ready = false;
+	int ret;
+
+	/*
+	 * Save previous state and modify current state
+	 * with the changed state mask
+	 */
+	spin_lock(&nnpdev->lock);
+	prev_state = nnpdev->state;
+	if ((mask & NNP_DEVICE_CARD_BOOT_STATE_MASK) != 0) {
+		/*
+		 * When boot state changes previous boot states are reset.
+		 * also, device error conditions is cleared.
+		 */
+		nnpdev->state &= ~(NNP_DEVICE_CARD_BOOT_STATE_MASK);
+		nnpdev->state &= ~(NNP_DEVICE_ERROR_MASK);
+	}
+	nnpdev->state |= mask;
+	state = nnpdev->state;
+	spin_unlock(&nnpdev->lock);
+
+	dev_dbg(nnpdev->dev,
+		"device state change 0x%x --> 0x%x\n", prev_state, state);
+
+	/* Unload boot image if boot started or failed */
+	if (nnpdev->boot_image_loaded &&
+	    (((state & NNP_DEVICE_BOOT_STARTED) &&
+	      !(prev_state & NNP_DEVICE_BOOT_STARTED)) ||
+	     (state & NNP_DEVICE_BOOT_FAILED))) {
+		ret = unload_boot_image(nnpdev);
+		/* This should never fail */
+		if (ret)
+			dev_dbg(nnpdev->dev,
+				"Unexpected error while unloading boot image. rc=%d\n",
+				ret);
+	}
+
+	/* if in error state - no need to check rest of the states */
+	if (state & NNP_DEVICE_ERROR_MASK)
+		return;
+
+	if ((state & NNP_DEVICE_BOOT_BIOS_READY) &&
+	    !(prev_state & NNP_DEVICE_BOOT_BIOS_READY)) {
+		becomes_ready = true;
+		nnpdev->is_recovery_bios = false;
+	}
+
+	if ((state & NNP_DEVICE_BOOT_RECOVERY_BIOS_READY) &&
+	    !(prev_state & NNP_DEVICE_BOOT_RECOVERY_BIOS_READY)) {
+		becomes_ready = true;
+		nnpdev->is_recovery_bios = true;
+	}
+
+	if (becomes_ready ||
+	    mask == NNP_DEVICE_BOOT_BIOS_READY ||
+	    mask == NNP_DEVICE_BOOT_RECOVERY_BIOS_READY) {
+		if (!becomes_ready)
+			dev_dbg(nnpdev->dev, "Re-sending sysinfo page to bios!!\n");
+
+		/* Send request to fill system_info buffer */
+		send_sysinfo_request_to_bios(nnpdev);
+		return;
+	}
+
+	/* Handle boot image request */
+	if ((state & NNP_DEVICE_BOOT_SYSINFO_READY) &&
+	    !(prev_state & NNP_DEVICE_BOOT_SYSINFO_READY) &&
+	    !nnpdev->boot_image_loaded) {
+		build_bios_version_string(nnpdev);
+		nnpdev->bios_system_info_valid = true;
+		nnpdev->boot_image_loaded = true;
+		ret = nnpdev_load_boot_image(nnpdev);
+
+		if (ret)
+			dev_err(nnpdev->dev,
+				"Unexpected error while loading boot image. rc=%d\n",
+				ret);
+	}
+}
+
 /**
  * nnpdev_init() - initialize NNP-I device structure.
  * @nnpdev: device to be initialized
@@ -64,8 +241,33 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 		goto err_msg_sched;
 	}
 
+	nnpdev->wq = create_singlethread_workqueue("nnpdev_wq");
+	if (!nnpdev->wq) {
+		ret = -ENOMEM;
+		goto err_cmdq;
+	}
+
+	/* setup memory for bios system info */
+	nnpdev->bios_system_info =
+		dma_alloc_coherent(nnpdev->dev, NNP_PAGE_SIZE,
+				   &nnpdev->bios_system_info_dma_addr, GFP_KERNEL);
+	if (!nnpdev->bios_system_info) {
+		ret = -ENOMEM;
+		goto err_wq;
+	}
+
+	/* set host driver state to "Not ready" */
+	nnpdev->ops->set_host_doorbell_value(nnpdev, 0);
+
+	spin_lock_init(&nnpdev->lock);
+	nnpdev_boot_image_init(&nnpdev->boot_image);
+
 	return 0;
 
+err_wq:
+	destroy_workqueue(nnpdev->wq);
+err_cmdq:
+	nnp_msched_queue_destroy(nnpdev->cmdq);
 err_msg_sched:
 	nnp_msched_destroy(nnpdev->cmdq_sched);
 err_ida:
@@ -74,6 +276,71 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 }
 EXPORT_SYMBOL(nnpdev_init);
 
+struct doorbell_work {
+	struct work_struct work;
+	struct nnp_device  *nnpdev;
+	u32                val;
+};
+
+static void doorbell_changed_handler(struct work_struct *work)
+{
+	struct doorbell_work *req = container_of(work, struct doorbell_work,
+						 work);
+	u32 boot_state, state = 0;
+	u32 error_state;
+	u32 doorbell_val = req->val;
+	struct nnp_device *nnpdev = req->nnpdev;
+
+	nnpdev->card_doorbell_val = doorbell_val;
+
+	error_state = FIELD_GET(NNP_CARD_ERROR_MASK, doorbell_val);
+	boot_state = FIELD_GET(NNP_CARD_BOOT_STATE_MASK, doorbell_val);
+
+	if (error_state) {
+		state = NNP_DEVICE_BOOT_FAILED;
+
+		switch (error_state) {
+		case NNP_CARD_ERROR_NOT_CAPSULE:
+			state |= NNP_DEVICE_CAPSULE_EXPECTED;
+			break;
+		case NNP_CARD_ERROR_CORRUPTED_IMAGE:
+			state |= NNP_DEVICE_CORRUPTED_BOOT_IMAGE;
+			break;
+		case NNP_CARD_ERROR_CAPSULE_FAILED:
+			state |= NNP_DEVICE_CAPSULE_FAILED;
+			break;
+		default:
+			break;
+		}
+	} else if (boot_state != nnpdev->curr_boot_state) {
+		nnpdev->curr_boot_state = boot_state;
+		switch (boot_state) {
+		case NNP_CARD_BOOT_STATE_BIOS_READY:
+			state = NNP_DEVICE_BOOT_BIOS_READY;
+			break;
+		case NNP_CARD_BOOT_STATE_RECOVERY_BIOS_READY:
+			state = NNP_DEVICE_BOOT_RECOVERY_BIOS_READY;
+			break;
+		case NNP_CARD_BOOT_STATE_BIOS_SYSINFO_READY:
+			state = NNP_DEVICE_BOOT_SYSINFO_READY;
+			break;
+		case NNP_CARD_BOOT_STATE_BOOT_STARTED:
+			state = NNP_DEVICE_BOOT_STARTED;
+			break;
+		case NNP_CARD_BOOT_STATE_BIOS_FLASH_STARTED:
+			state = NNP_DEVICE_BIOS_UPDATE_STARTED;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (state)
+		nnpdev_set_boot_state(nnpdev, state);
+
+	kfree(req);
+}
+
 /**
  * nnpdev_card_doorbell_value_changed() - card doorbell changed notification
  * @nnpdev: The nnp device
@@ -85,7 +352,18 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 void nnpdev_card_doorbell_value_changed(struct nnp_device *nnpdev,
 					u32 doorbell_val)
 {
+	struct doorbell_work *req;
+
 	dev_dbg(nnpdev->dev, "Got card doorbell value 0x%x\n", doorbell_val);
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return;
+
+	req->nnpdev = nnpdev;
+	req->val = doorbell_val;
+	INIT_WORK(&req->work, doorbell_changed_handler);
+	queue_work(nnpdev->wq, &req->work);
 }
 EXPORT_SYMBOL(nnpdev_card_doorbell_value_changed);
 
@@ -100,6 +378,18 @@ void nnpdev_destroy(struct nnp_device *nnpdev)
 {
 	dev_dbg(nnpdev->dev, "Destroying NNP-I device\n");
 
+	/*
+	 * If device is removed while boot image load is in-flight,
+	 * stop the image load and flag it is not needed.
+	 */
+	if (nnpdev->boot_image_loaded)
+		unload_boot_image(nnpdev);
+
+	destroy_workqueue(nnpdev->wq);
+
+	dma_free_coherent(nnpdev->dev, NNP_PAGE_SIZE, nnpdev->bios_system_info,
+			  nnpdev->bios_system_info_dma_addr);
+
 	nnp_msched_destroy(nnpdev->cmdq_sched);
 	ida_simple_remove(&dev_ida, nnpdev->id);
 }
@@ -121,3 +411,4 @@ static void __exit nnp_cleanup(void)
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Intel(R) NNPI Framework");
 MODULE_AUTHOR("Intel Corporation");
+MODULE_FIRMWARE(NNP_FIRMWARE_NAME);
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index 562bbc4..3745f5c 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -4,8 +4,50 @@
 #ifndef _NNPDRV_DEVICE_H
 #define _NNPDRV_DEVICE_H
 
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "bootimage.h"
+#include "ipc_protocol.h"
+#include "msg_scheduler.h"
+
 #define NNP_MAX_DEVS		256
 
+#define NNP_FIRMWARE_NAME "intel/nnpi/disk.img"
+
+/* device state bits */
+#define NNP_DEVICE_BOOT_BIOS_READY        BIT(1)
+#define NNP_DEVICE_BOOT_RECOVERY_BIOS_READY BIT(2)
+#define NNP_DEVICE_BOOT_SYSINFO_READY     BIT(3)
+#define NNP_DEVICE_BOOT_STARTED           BIT(4)
+#define NNP_DEVICE_BIOS_UPDATE_READY      BIT(5)
+#define NNP_DEVICE_BIOS_UPDATE_STARTED    BIT(6)
+#define NNP_DEVICE_BIOS_UPDATE_DONE       BIT(7)
+#define NNP_DEVICE_CARD_DRIVER_READY      BIT(8)
+#define NNP_DEVICE_CARD_READY             BIT(9)
+#define NNP_DEVICE_CARD_ENABLED           BIT(10)
+
+#define NNP_DEVICE_CARD_BOOT_STATE_MASK   GENMASK(9, 1)
+
+#define NNP_DEVICE_ACTIVE_MASK       (NNP_DEVICE_CARD_READY | \
+				      NNP_DEVICE_CARD_ENABLED)
+
+#define NNP_DEVICE_FAILED_VERSION    BIT(16)
+#define NNP_DEVICE_BOOT_FAILED       BIT(17)
+#define NNP_DEVICE_HOST_DRIVER_ERROR BIT(18)
+#define NNP_DEVICE_KERNEL_CRASH	     BIT(20)
+#define NNP_DEVICE_PCI_ERROR         BIT(21)
+#define NNP_DEVICE_CARD_IN_RESET     BIT(22)
+#define NNP_DEVICE_FATAL_MCE_ERROR   BIT(23)
+#define NNP_DEVICE_FATAL_DRAM_ECC_ERROR   BIT(24)
+#define NNP_DEVICE_FATAL_ICE_ERROR   BIT(25)
+#define NNP_DEVICE_HANG              BIT(26)
+#define NNP_DEVICE_PROTOCOL_ERROR    BIT(27)
+#define NNP_DEVICE_CAPSULE_EXPECTED  BIT(28)
+#define NNP_DEVICE_CAPSULE_FAILED    BIT(29)
+#define NNP_DEVICE_CORRUPTED_BOOT_IMAGE BIT(30)
+#define NNP_DEVICE_ERROR_MASK        GENMASK(31, 16)
+
 /**
  * struct nnp_device - structure for NNP-I device info
  * @ops: device operations implemented by the underlying device driver
@@ -15,6 +57,18 @@
  *              submissions to the device's command queue.
  * @cmdq: input queue to @cmdq_sched used to schedule driver internal commands
  *        to be sent to the device.
+ * @wq: singlethread workqueue for processing device's response messages.
+ * @lock: protects accesses to @state
+ * @is_recovery_bios: true if device has booted from the recovery bios flash
+ * @boot_image_loaded: true if boot image load has started
+ * @bios_system_info_dma_addr: dma page allocated for bios system info.
+ * @bios_system_info: virtual pointer to bios system info page
+ * @bios_version_str: the device's started bios version string
+ * @bios_system_info_valid: true if @bios_system_info has been filled and valid
+ * @state: current device boot state mask (see device state bits above)
+ * @curr_boot_state: last boot state field received from device doorbell reg
+ * @card_doorbell_val: last received device doorbell register value.
+ * @boot_image: boot image object used to boot the card
  */
 struct nnp_device {
 	const struct nnp_device_ops *ops;
@@ -23,6 +77,21 @@ struct nnp_device {
 
 	struct nnp_msched       *cmdq_sched;
 	struct nnp_msched_queue *cmdq;
+
+	struct workqueue_struct *wq;
+	spinlock_t     lock;
+	bool           is_recovery_bios;
+	bool           boot_image_loaded;
+
+	dma_addr_t                  bios_system_info_dma_addr;
+	struct nnp_c2h_system_info  *bios_system_info;
+	char                        bios_version_str[NNP_BIOS_VERSION_LEN];
+	bool                        bios_system_info_valid;
+
+	u32            state;
+	u32            curr_boot_state;
+	u32            card_doorbell_val;
+	struct image_info boot_image;
 };
 
 /**
@@ -30,10 +99,12 @@ struct nnp_device {
  * @cmdq_flush: empties the device command queue, discarding all queued
  *              commands.
  * @cmdq_write_mesg: inserts a command message to the card's command queue.
+ * @set_host_doorbell_value: change the host doorbell value on device.
  */
 struct nnp_device_ops {
 	int (*cmdq_flush)(struct nnp_device *hw_dev);
 	int (*cmdq_write_mesg)(struct nnp_device *nnpdev, u64 *msg, u32 size);
+	int (*set_host_doorbell_value)(struct nnp_device *nnpdev, u32 value);
 };
 
 bool nnpdev_no_devices(void);
@@ -47,4 +118,10 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 void nnpdev_destroy(struct nnp_device *nnpdev);
 void nnpdev_card_doorbell_value_changed(struct nnp_device *nnpdev,
 					u32 doorbell_val);
+
+/*
+ * Framework internal functions (not exported)
+ */
+void nnpdev_set_boot_state(struct nnp_device *nnpdev, u32 mask);
+
 #endif
diff --git a/drivers/misc/intel-nnpi/nnp_pcie.c b/drivers/misc/intel-nnpi/nnp_pcie.c
index 7aa9074..3840a53 100644
--- a/drivers/misc/intel-nnpi/nnp_pcie.c
+++ b/drivers/misc/intel-nnpi/nnp_pcie.c
@@ -375,9 +375,25 @@ static int nnp_cmdq_flush(struct nnp_device *nnpdev)
 	return 0;
 }
 
+static int nnp_set_host_doorbell_value(struct nnp_device *nnpdev, u32 value)
+{
+	struct nnp_pci *nnp_pci = container_of(nnpdev, struct nnp_pci, nnpdev);
+
+	/*
+	 * The SELF_RESET bit is set only by the h/w layer,
+	 * do not allow higher layer to set it
+	 */
+	value &= ~NNP_HOST_DRV_REQUEST_SELF_RESET_MASK;
+
+	nnp_mmio_write(nnp_pci, ELBI_PCI_HOST_DOORBELL_VALUE, value);
+
+	return 0;
+}
+
 static struct nnp_device_ops nnp_device_ops = {
 	.cmdq_flush = nnp_cmdq_flush,
 	.cmdq_write_mesg = nnp_cmdq_write_mesg,
+	.set_host_doorbell_value = nnp_set_host_doorbell_value,
 };
 
 static void set_host_boot_state(struct nnp_pci *nnp_pci, int boot_state)
-- 
1.8.3.1

