Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054B23819DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhEOQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233562AbhEOQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17724613C1;
        Sat, 15 May 2021 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096286;
        bh=H1AgTz2YnH3gIIgZk4X3+RA/p3Ky686V+Mf7pf1b42Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+lZrN4Dkl7BRxlM6/L7nlM2GTgjvM3n/95VeJjEFechHnvksBhLcepoBbcMEsqJz
         c2bHN7z6vovFK1IKPr26H+dqTK7N2J2CW3b9J5ESXtkdhx0Z3hnI5HuTlZAX4qRjZk
         BsQYt8cqRrPOzi7tJ0VJr6TIpn3klHOcd//nUrOi7iFYccY1r9sL66oUMUVosriZsS
         JJCmj+n/v0wpflWhDxeZy5x2xNEMKfEvn9hmVRFtf0hUGkaVA8UmmfgVsUC+g/2E+o
         yPWJ2mBdELG7k9GbOI63D/0qPkiDu3uon1aFBj1R/Nci1DOuHA2IH2RMfHrtFau3FJ
         vzIj1VrdeE7hg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 2/5] habanalabs/gaudi: send hard reset cause to preboot
Date:   Sat, 15 May 2021 19:31:13 +0300
Message-Id: <20210515163116.14181-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515163116.14181-1-ogabbay@kernel.org>
References: <20210515163116.14181-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

LKD should provide hard reset cause to preboot prior to
loading any FW components (in case needed).
Current implementation is based on the new FW 'COMMS' protocol
In cased 'COMMS' is disabled - reset cause won't be sent.
Currently, only 2 reset causes are shared: HEARTBEAT & TDR.

Sending the reset cause will provide the missing watchdog
info that the firmware needs to provide to the BMC.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |   2 +-
 drivers/misc/habanalabs/common/device.c       |  18 ++-
 drivers/misc/habanalabs/common/firmware_if.c  | 127 +++++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |   7 +
 .../misc/habanalabs/common/habanalabs_drv.c   |   2 +
 .../habanalabs/include/common/hl_boot_if.h    |  60 ++++++++-
 6 files changed, 208 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index af3c497defb1..ecd96fbe3150 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -614,7 +614,7 @@ static void cs_timedout(struct work_struct *work)
 	cs_put(cs);
 
 	if (hdev->reset_on_lockup)
-		hl_device_reset(hdev, 0);
+		hl_device_reset(hdev, HL_RESET_TDR);
 	else
 		hdev->needs_reset = true;
 }
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 00e92b678828..bc58a91bf50a 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -900,6 +900,19 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		if (rc)
 			return 0;
 
+		/*
+		 * 'reset cause' is being updated here, because getting here
+		 * means that it's the 1st time and the last time we're here
+		 * ('in_reset' makes sure of it). This makes sure that
+		 * 'reset_cause' will continue holding its 1st recorded reason!
+		 */
+		if (flags & HL_RESET_HEARTBEAT)
+			hdev->curr_reset_cause = HL_RESET_CAUSE_HEARTBEAT;
+		else if (flags & HL_RESET_TDR)
+			hdev->curr_reset_cause = HL_RESET_CAUSE_TDR;
+		else
+			hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+
 		/*
 		 * if reset is due to heartbeat, device CPU is no responsive in
 		 * which case no point sending PCI disable message to it
@@ -943,9 +956,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hdev->process_kill_trial_cnt = 0;
 
 		/*
-		 * Because the reset function can't run from interrupt or
-		 * from heartbeat work, we need to call the reset function
-		 * from a dedicated work
+		 * Because the reset function can't run from heartbeat work,
+		 * we need to call the reset function from a dedicated work.
 		 */
 		queue_delayed_work(hdev->device_reset_work.wq,
 			&hdev->device_reset_work.reset_work, 0);
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8922d4a43919..2d5a849a377e 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -103,6 +103,41 @@ static int hl_fw_copy_fw_to_device(struct hl_device *hdev,
 	return 0;
 }
 
+/**
+ * hl_fw_copy_msg_to_device() - copy message to device
+ *
+ * @hdev: pointer to hl_device structure.
+ * @msg: message
+ * @dst: IO memory mapped address space to copy firmware to
+ * @src_offset: offset in src message to copy from
+ * @size: amount of bytes to copy (0 to copy the whole binary)
+ *
+ * actual copy of message data to device.
+ */
+static int hl_fw_copy_msg_to_device(struct hl_device *hdev,
+		struct lkd_msg_comms *msg, void __iomem *dst,
+		u32 src_offset, u32 size)
+{
+	void *msg_data;
+
+	/* size 0 indicates to copy the whole file */
+	if (!size)
+		size = sizeof(struct lkd_msg_comms);
+
+	if (src_offset + size > sizeof(struct lkd_msg_comms)) {
+		dev_err(hdev->dev,
+			"size to copy(%u) and offset(%u) are invalid\n",
+			size, src_offset);
+		return -EINVAL;
+	}
+
+	msg_data = (void *) msg;
+
+	memcpy_toio(dst, msg_data + src_offset, size);
+
+	return 0;
+}
+
 /**
  * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
  *
@@ -1698,6 +1733,36 @@ static int hl_fw_dynamic_copy_image(struct hl_device *hdev,
 	return rc;
 }
 
+/**
+ * hl_fw_dynamic_copy_msg - copy msg to memory allocated by the FW
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @msg: message
+ * @fw_loader: managing structure for loading device's FW
+ */
+static int hl_fw_dynamic_copy_msg(struct hl_device *hdev,
+		struct lkd_msg_comms *msg, struct fw_load_mgr *fw_loader)
+{
+	struct lkd_fw_comms_desc *fw_desc;
+	struct pci_mem_region *region;
+	void __iomem *dest;
+	u64 addr;
+	int rc;
+
+	fw_desc = &fw_loader->dynamic_loader.comm_desc;
+	addr = le64_to_cpu(fw_desc->img_addr);
+
+	/* find memory region to which to copy the image */
+	region = fw_loader->dynamic_loader.image_region;
+
+	dest = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
+					(addr - region->region_base);
+
+	rc = hl_fw_copy_msg_to_device(hdev, msg, dest, 0, 0);
+
+	return rc;
+}
+
 /**
  * hl_fw_boot_fit_update_state - update internal data structures after boot-fit
  *                               is loaded
@@ -1771,7 +1836,6 @@ static int hl_fw_dynamic_load_image(struct hl_device *hdev,
 	} else {
 		cur_fwc = FW_COMP_BOOT_FIT;
 		fw_name = fw_loader->linux_img.image_name;
-
 	}
 
 	/* request FW in order to communicate to FW the size to be allocated */
@@ -1927,6 +1991,57 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 }
 
+/**
+ * hl_fw_dynamic_report_reset_cause - send a COMMS message with the cause
+ *                                    of the newly triggered hard reset
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @reset_cause: enumerated cause for the recent hard reset
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_report_reset_cause(struct hl_device *hdev,
+		struct fw_load_mgr *fw_loader,
+		enum comms_reset_cause reset_cause)
+{
+	struct lkd_msg_comms msg;
+	int rc;
+
+	memset(&msg, 0, sizeof(msg));
+
+	/* create message to be sent */
+	msg.header.type = HL_COMMS_RESET_CAUSE_TYPE;
+	msg.header.size = cpu_to_le16(sizeof(struct comms_msg_header));
+	msg.header.magic = cpu_to_le32(HL_COMMS_MSG_MAGIC);
+
+	msg.reset_cause = reset_cause;
+
+	rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader,
+			sizeof(struct lkd_msg_comms));
+	if (rc)
+		return rc;
+
+	/* copy message to space allocated by FW */
+	rc = hl_fw_dynamic_copy_msg(hdev, &msg, fw_loader);
+	if (rc)
+		return rc;
+
+	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_DATA_RDY,
+						0, true,
+						fw_loader->cpu_timeout);
+	if (rc)
+		return rc;
+
+	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_EXEC,
+						0, true,
+						fw_loader->cpu_timeout);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /**
  * hl_fw_dynamic_init_cpu - initialize the device CPU using dynamic protocol
  *
@@ -1962,6 +2077,16 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	if (rc)
 		goto protocol_err;
 
+	if (hdev->curr_reset_cause) {
+		rc = hl_fw_dynamic_report_reset_cause(hdev, fw_loader,
+				hdev->curr_reset_cause);
+		if (rc)
+			goto protocol_err;
+
+		/* Clear current reset cause */
+		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+	}
+
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
 		/* update the preboot state */
 		hl_fw_preboot_update_state(hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 7e13a198a946..a046180254c8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -115,10 +115,14 @@ enum hl_mmu_page_table_location {
  *
  * - HL_RESET_HEARTBEAT
  *       Set if reset is due to heartbeat
+ *
+ * - HL_RESET_TDR
+ *       Set if reset is due to TDR
  */
 #define HL_RESET_HARD			(1 << 0)
 #define HL_RESET_FROM_RESET_THREAD	(1 << 1)
 #define HL_RESET_HEARTBEAT		(1 << 2)
+#define HL_RESET_TDR			(1 << 3)
 
 #define HL_MAX_SOBS_PER_MONITOR	8
 
@@ -2163,6 +2167,8 @@ struct hl_mmu_funcs {
  * @device_fini_pending: true if device_fini was called and might be
  *                       waiting for the reset thread to finish
  * @supports_staged_submission: true if staged submissions are supported
+ * @curr_reset_cause: saves an enumerated reset cause when a hard reset is
+ *                    triggered, and cleared after it is shared with preboot.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2273,6 +2279,7 @@ struct hl_device {
 	u8				process_kill_trial_cnt;
 	u8				device_fini_pending;
 	u8				supports_staged_submission;
+	u8				curr_reset_cause;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 64d1530db985..dc92401e7a3f 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -330,6 +330,8 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	set_driver_behavior_per_device(hdev);
 
+	hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+
 	if (timeout_locked)
 		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
 	else
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 9baa56acf473..e9d86673109c 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -302,19 +302,43 @@ struct cpu_dyn_regs {
 	__le32 reserved1[32];		/* reserve for future use */
 };
 
+/* TODO: remove the desc magic after the code is updated to use message */
 /* HCDM - Habana Communications Descriptor Magic */
 #define HL_COMMS_DESC_MAGIC	0x4843444D
 #define HL_COMMS_DESC_VER	1
 
+/* HCMv - Habana Communications Message + header version */
+#define HL_COMMS_MSG_MAGIC_VER(ver)	(0x48434D00 | ((ver) & 0xff))
+#define HL_COMMS_MSG_MAGIC_V0		HL_COMMS_DESC_MAGIC
+#define HL_COMMS_MSG_MAGIC_V1		HL_COMMS_MSG_MAGIC_VER(1)
+
+#define HL_COMMS_MSG_MAGIC		HL_COMMS_MSG_MAGIC_V1
+
+enum comms_msg_type {
+	HL_COMMS_DESC_TYPE = 0,
+	HL_COMMS_RESET_CAUSE_TYPE = 1,
+};
+
+/* TODO: remove this struct after the code is updated to use comms_msg_header */
 /* this is the comms descriptor header - meta data */
 struct comms_desc_header {
 	__le32 magic;		/* magic for validation */
 	__le32 crc32;		/* CRC32 of the descriptor w/o header */
 	__le16 size;		/* size of the descriptor w/o header */
-	__u8 version;	/* descriptor version */
+	__u8 version;		/* descriptor version */
 	__u8 reserved[5];	/* pad to 64 bit */
 };
 
+/* this is the comms message header - meta data */
+struct comms_msg_header {
+	__le32 magic;		/* magic for validation */
+	__le32 crc32;		/* CRC32 of the message w/o header */
+	__le16 size;		/* size of the message w/o header */
+	__u8 version;		/* message payload version */
+	__u8 type;		/* message type */
+	__u8 reserved[4];	/* pad to 64 bit */
+};
+
 /* this is the main FW descriptor - consider ABI when changing */
 struct lkd_fw_comms_desc {
 	struct comms_desc_header header;
@@ -323,7 +347,37 @@ struct lkd_fw_comms_desc {
 	char cur_fw_ver[VERSION_MAX_LEN];
 	/* can be used for 1 more version w/o ABI change */
 	char reserved0[VERSION_MAX_LEN];
-	__le64 img_addr;	/* address for next FW component load */
+	/* address for next FW component load */
+	__le64 img_addr;
+};
+
+enum comms_reset_cause {
+	HL_RESET_CAUSE_UNKNOWN = 0,
+	HL_RESET_CAUSE_HEARTBEAT = 1,
+	HL_RESET_CAUSE_TDR = 2,
+};
+
+#define RESET_CAUSE_PADDING	7
+
+/* this is the comms message descriptor */
+struct lkd_msg_comms {
+	struct comms_msg_header header;
+	/* union for future expantions of new messages */
+	union {
+		struct {
+			struct cpu_dyn_regs cpu_dyn_regs;
+			char fuse_ver[VERSION_MAX_LEN];
+			char cur_fw_ver[VERSION_MAX_LEN];
+			/* can be used for 1 more version w/o ABI change */
+			char reserved0[VERSION_MAX_LEN];
+			/* address for next FW component load */
+			__le64 img_addr;
+		};
+		struct {
+			__u8 reset_cause;
+			__u8 reserved[RESET_CAUSE_PADDING]; /* 64 bit pad */
+		};
+	};
 };
 
 /*
@@ -395,7 +449,7 @@ enum comms_cmd {
 struct comms_command {
 	union {		/* bit fields are only for FW use */
 		struct {
-			u32 size :25;		/* 32MB max. */
+			u32 size :25;			/* 32MB max. */
 			u32 reserved :2;
 			enum comms_cmd cmd :5;		/* 32 commands */
 		};
-- 
2.25.1

