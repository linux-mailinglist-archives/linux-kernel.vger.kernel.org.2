Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1A37F49D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhEMJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:01:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:47046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232350AbhEMJAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:00:01 -0400
IronPort-SDR: NtVD1r0lnXaeZYmxxI2E0z814BwNQRK+AdJzy3TrA83PfUSrewqmZDBP+L5MMZal+oYXzPwZ62
 hZQbsMZRSAVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032303"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032303"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:21 -0700
IronPort-SDR: zOY6XWauyODN3NP3OjnarDMpuOBewG3kEgfqgFKFWh3brduuYiAg3x51yTWoGal8EiRN/IQQ8D
 MurEcXlDzsAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928322"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:19 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 09/15] misc: nnpi: Process device response messages
Date:   Thu, 13 May 2021 11:57:19 +0300
Message-Id: <20210513085725.45528-10-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nnpdev_process_messages function handles all messages coming
from a NNP-I device. Based on an opcode field attached to each message,
it calls the correct response processing handler. The function is
called from the NNP-I device driver, from a threaded interrupt handler, when
responses arrive in the HW response queue.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/device.c   | 136 +++++++++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/device.h   |  10 +++
 drivers/misc/intel-nnpi/nnp_pcie.c |   3 +
 3 files changed, 149 insertions(+)

diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index f4fc975..2e6ab82 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -23,6 +23,142 @@ bool nnpdev_no_devices(void)
 	return ida_is_empty(&dev_ida);
 }
 
+/**
+ * handle_bios_protocol() - process response coming from card's BIOS.
+ * @nnpdev: The nnp device
+ * @msgbuf: pointer to response message content
+ * @avail_qwords: number of 64-bit units available in @msgbuf
+ *
+ * IPC protocol with card's BIOS may have different response sizes.
+ * @avail_qwords is the number of 64-bit units available in @msgbuf buffer.
+ * If the actual response size is larger then available data in the buffer,
+ * the function returns 0 to indicate that this is a partial response. Otherwise
+ * the actual response size is returned (in units of qwords).
+ *
+ * Return: 0 if @msgbuf contains a partial response otherwise the number of
+ * qwords of the response in @msgbuf.
+ */
+static int handle_bios_protocol(struct nnp_device *nnpdev, const u64 *msgbuf,
+				int avail_qwords)
+{
+	int msg_size, msg_qwords;
+
+	msg_size = FIELD_GET(NNP_C2H_BIOS_PROTOCOL_TYPE_MASK, msgbuf[0]);
+
+	/* The +1 is because size field does not include header */
+	msg_qwords = DIV_ROUND_UP(msg_size, 8) + 1;
+
+	if (msg_qwords > avail_qwords)
+		return 0;
+
+	return msg_qwords;
+}
+
+typedef int (*response_handler)(struct nnp_device *nnpdev, const u64 *msgbuf,
+				int avail_qwords);
+
+static response_handler resp_handlers[NNP_IPC_C2H_OPCODE_LAST + 1] = {
+	[NNP_IPC_C2H_OP_BIOS_PROTOCOL] = handle_bios_protocol
+};
+
+/**
+ * nnpdev_process_messages() - process response messages from nnpi device
+ * @nnpdev: The nnp device
+ * @hw_msg: pointer to response message content
+ * @hw_nof_msg: number of 64-bit units available in hw_msg buffer.
+ *
+ * This function is called from the PCIe device driver when response messages
+ * are arrived in the HWQ. It is called in sequence, should not be re-entrant.
+ * The function may not block !
+ */
+void nnpdev_process_messages(struct nnp_device *nnpdev, u64 *hw_msg,
+			     unsigned int hw_nof_msg)
+{
+	int j = 0;
+	int msg_size;
+	u64 *msg;
+	unsigned int nof_msg;
+	bool fatal_protocol_error = false;
+
+	/* ignore any response if protocol error detected */
+	if ((nnpdev->state & NNP_DEVICE_PROTOCOL_ERROR) != 0)
+		return;
+
+	/*
+	 * If we have pending messages from previous round
+	 * copy the new messages to the pending list and process
+	 * the pending list.
+	 * otherwise process the messages received from HW directly
+	 */
+	msg = hw_msg;
+	nof_msg = hw_nof_msg;
+	if (nnpdev->response_num_msgs > 0) {
+		/*
+		 * Check to prevent response buffer overrun.
+		 * This should never happen since the buffer is twice
+		 * the size of the HW response queue. This check is
+		 * for safety and debug purposes.
+		 */
+		if (hw_nof_msg + nnpdev->response_num_msgs >=
+		    NNP_DEVICE_RESPONSE_BUFFER_LEN) {
+			dev_dbg(nnpdev->dev,
+				"device response buffer would overrun: %d + %d !!\n",
+				nnpdev->response_num_msgs, hw_nof_msg);
+			return;
+		}
+
+		memcpy(&nnpdev->response_buf[nnpdev->response_num_msgs], hw_msg,
+		       hw_nof_msg * sizeof(u64));
+		msg = nnpdev->response_buf;
+		nof_msg = nnpdev->response_num_msgs + hw_nof_msg;
+	}
+
+	/*
+	 * loop for each message
+	 */
+	do {
+		int op_code = FIELD_GET(NNP_C2H_OP_MASK, msg[j]);
+		response_handler handler;
+
+		/* opcodes above OP_BIOS_PROTOCOL are not yet supported */
+		if (op_code > NNP_IPC_C2H_OP_BIOS_PROTOCOL) {
+			fatal_protocol_error = true;
+			break;
+		}
+
+		/* dispatch the message request */
+		handler = resp_handlers[op_code];
+		if (!handler) {
+			/* Should not happen! */
+			dev_dbg(nnpdev->dev,
+				"Unknown response opcode received %d (0x%llx)\n",
+				op_code, msg[j]);
+			fatal_protocol_error = true;
+			break;
+		}
+
+		msg_size = (*handler)(nnpdev, &msg[j], (nof_msg - j));
+
+		j += msg_size;
+	} while (j < nof_msg || !msg_size);
+
+	if (fatal_protocol_error)
+		nnpdev->state |= NNP_DEVICE_PROTOCOL_ERROR;
+
+	/*
+	 * If unprocessed messages left, copy it to the pending messages buffer
+	 * for the next time this function will be called.
+	 */
+	if (j < nof_msg) {
+		memcpy(&nnpdev->response_buf[0], &msg[j],
+		       (nof_msg - j) * sizeof(u64));
+		nnpdev->response_num_msgs = nof_msg - j;
+	} else {
+		nnpdev->response_num_msgs = 0;
+	}
+}
+EXPORT_SYMBOL(nnpdev_process_messages);
+
 static void send_sysinfo_request_to_bios(struct nnp_device *nnpdev)
 {
 	u64 cmd[3];
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index 3745f5c..b83f67a 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -48,6 +48,9 @@
 #define NNP_DEVICE_CORRUPTED_BOOT_IMAGE BIT(30)
 #define NNP_DEVICE_ERROR_MASK        GENMASK(31, 16)
 
+#define NNP_DEVICE_RESPONSE_FIFO_LEN    16
+#define NNP_DEVICE_RESPONSE_BUFFER_LEN  (NNP_DEVICE_RESPONSE_FIFO_LEN * 2)
+
 /**
  * struct nnp_device - structure for NNP-I device info
  * @ops: device operations implemented by the underlying device driver
@@ -61,6 +64,8 @@
  * @lock: protects accesses to @state
  * @is_recovery_bios: true if device has booted from the recovery bios flash
  * @boot_image_loaded: true if boot image load has started
+ * @response_buf: buffer of device response messages arrived from "pci" layer.
+ * @response_num_msgs: number of qwords available in @response_buf
  * @bios_system_info_dma_addr: dma page allocated for bios system info.
  * @bios_system_info: virtual pointer to bios system info page
  * @bios_version_str: the device's started bios version string
@@ -83,6 +88,9 @@ struct nnp_device {
 	bool           is_recovery_bios;
 	bool           boot_image_loaded;
 
+	u64            response_buf[NNP_DEVICE_RESPONSE_BUFFER_LEN];
+	unsigned int   response_num_msgs;
+
 	dma_addr_t                  bios_system_info_dma_addr;
 	struct nnp_c2h_system_info  *bios_system_info;
 	char                        bios_version_str[NNP_BIOS_VERSION_LEN];
@@ -118,6 +126,8 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 void nnpdev_destroy(struct nnp_device *nnpdev);
 void nnpdev_card_doorbell_value_changed(struct nnp_device *nnpdev,
 					u32 doorbell_val);
+void nnpdev_process_messages(struct nnp_device *nnpdev, u64 *hw_msg,
+			     unsigned int hw_nof_msg);
 
 /*
  * Framework internal functions (not exported)
diff --git a/drivers/misc/intel-nnpi/nnp_pcie.c b/drivers/misc/intel-nnpi/nnp_pcie.c
index 3840a53..4c9b4c6 100644
--- a/drivers/misc/intel-nnpi/nnp_pcie.c
+++ b/drivers/misc/intel-nnpi/nnp_pcie.c
@@ -150,6 +150,9 @@ static void nnp_process_commands(struct nnp_pci *nnp_pci)
 	response_pci_control |= FIELD_PREP(RESPQ_READ_PTR_MASK, read_pointer);
 	nnp_mmio_write(nnp_pci, ELBI_RESPONSE_PCI_CONTROL,
 		       response_pci_control);
+
+	nnpdev_process_messages(&nnp_pci->nnpdev, nnp_pci->response_buf,
+				avail_slots);
 }
 
 static void mask_all_interrupts(struct nnp_pci *nnp_pci)
-- 
1.8.3.1

