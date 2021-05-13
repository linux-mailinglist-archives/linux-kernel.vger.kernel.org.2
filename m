Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCE37F49E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhEMJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:02:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:47049 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232380AbhEMJAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:00:10 -0400
IronPort-SDR: oc0SsHIG+Tk+w58Ig+GCEMQTMeMvbhqlOwFUkbnyUDo2QtR9EsQ0SBNvQAzx9SYdur8Zyxnoud
 3NbOFWOjPcVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032309"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032309"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:24 -0700
IronPort-SDR: 9LLzaNnRkwOEvJuWPQGf0Ep7ynT4Dpy1K8FmhxUE1hdEA5lJim+9eXTtkmZF9dnZ3dfnwJUR+b
 qncYtvaC1P3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928361"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:21 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 10/15] misc: nnpi: Query and verify device protocol
Date:   Thu, 13 May 2021 11:57:20 +0300
Message-Id: <20210513085725.45528-11-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the card booted SW stack is compatible with the driver
running on the host. The IPC protocol between the driver and cards's
SW stack may change from time to time when releasing new versions of
the card boot image.
When the card boots and signals to the host that it is booted and
ready (through doorbell change interrupt), the driver sends
it a "query version" command. In response, the device sends back a
"query version reply" response with information of the IPC protocol
version which it supports. Only when the version check passes, the
device is considered booted and ready for operation.

If the version check fails, the device is put in error state. In order
to recover from this error condition, a device reset is required
(probably preceded by installation of a new, compatile boot image).

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/device.c | 145 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/device.h |  17 +++++
 2 files changed, 162 insertions(+)

diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 2e6ab82..7bcab563 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -24,6 +24,119 @@ bool nnpdev_no_devices(void)
 }
 
 /**
+ * process_query_version_reply() - process a "query_version_reply" response
+ * @work: work struct of the calling work
+ *
+ * This function processes a "query_version_reply" response message from
+ * the card which is sent as reply to query_version command submitted
+ * earlier.
+ * The function checks that the IPC protocol version that is supported by the
+ * device matches the one supported by the driver. If there is no match the
+ * device state is put in error.
+ * There are two IPC protocol versions which are checked:
+ * 'protocol_version': is IPC protocol version of command and response messages
+ *         That are built (for commands) and processed by this kernel mode
+ *         driver. The protocol is defined in ipc_include/ipc_protocol.h
+ *         A mismatch is possible in cases that the device has booted with
+ *         a wrong/older version of the card boot image.
+ * 'chan_protocol_version': is IPC protocol of command and responses which are
+ *         supported by the device but are built and processed in user-space.
+ *         The structure of the commands and responses are mostly opaque to
+ *         the kernel mode driver. This separation allows to update the
+ *         device boot image and user-space library to support new sets
+ *         of commands without changing the kernel driver.
+ *         The restriction for such commands and responses is that the lowest
+ *         16-bits of the command/response are defined to include the
+ *         command/response opcode and the channel id.
+ *         The kernel driver should also know for each possible command and
+ *         response opcode the size of the message. This info is received
+ *         from the device within this "query_version_reply" response
+ *         encoded in the chan_resp_op_size and chan_cmd_op_size fields
+ *         of the response.
+ */
+static void process_query_version_reply(struct work_struct *work)
+{
+	struct query_version_work *query_version_work;
+	struct nnp_device *nnpdev;
+	u32 protocol_version;
+	u32 card_boot_state;
+	u32 val;
+
+	query_version_work =
+		container_of(work, struct query_version_work, work);
+	nnpdev = container_of(query_version_work, struct nnp_device,
+			      query_version_work);
+	protocol_version = NNP_IPC_PROTOCOL_VERSION;
+	card_boot_state = FIELD_GET(NNP_CARD_BOOT_STATE_MASK,
+				    nnpdev->card_doorbell_val);
+
+	nnpdev->protocol_version =
+		query_version_work->protocol_version;
+	nnpdev->chan_protocol_version =
+		query_version_work->chan_protocol_version;
+
+	/*
+	 * NOTE: The card firmware and host driver protocol version must
+	 * exactly match in the major and minor version components.
+	 * There is no backwards compatibility on the protocol!
+	 * When a device is put in a protocol version error state, the
+	 * user must install a matching device firmware and reset the device
+	 * in order to allow the device to function.
+	 */
+	if (NNP_VERSION_MAJOR(query_version_work->protocol_version) !=
+	    NNP_VERSION_MAJOR(protocol_version) ||
+	    NNP_VERSION_MINOR(query_version_work->protocol_version) !=
+	    NNP_VERSION_MINOR(protocol_version) ||
+	    query_version_work->chan_resp_op_size == 0) {
+		nnpdev_set_boot_state(nnpdev, NNP_DEVICE_FAILED_VERSION);
+		/* set host driver state in doorbell register */
+		val = FIELD_PREP(NNP_HOST_DRV_STATE_MASK,
+				 NNP_HOST_DRV_STATE_VERSION_ERROR);
+		nnpdev->ops->set_host_doorbell_value(nnpdev, val);
+	} else if (card_boot_state == NNP_CARD_BOOT_STATE_DRV_READY) {
+		nnpdev_set_boot_state(nnpdev, NNP_DEVICE_CARD_DRIVER_READY);
+	} else if (card_boot_state == NNP_CARD_BOOT_STATE_CARD_READY) {
+		/* Card driver finished initialization */
+		nnpdev_set_boot_state(nnpdev,
+				      NNP_DEVICE_CARD_DRIVER_READY |
+				      NNP_DEVICE_CARD_READY |
+				      NNP_DEVICE_CARD_ENABLED);
+	}
+
+	query_version_work->running = false;
+}
+
+static int handle_query_version_reply3(struct nnp_device *nnpdev,
+				       const u64 *msgbuf, int avail_qwords)
+{
+	int msg_qwords = 3; /* QUERY_VERSION_REPLY3 response len is 3 qwords */
+
+	if (avail_qwords < msg_qwords)
+		return 0;
+
+	/*
+	 * This should not happen, but if it does, just ignore the message
+	 * There is no fear in race condition on "running" flag as only
+	 * single version reply message should be processed after each
+	 * device reset.
+	 */
+	if (nnpdev->query_version_work.running)
+		return msg_qwords;
+
+	nnpdev->query_version_work.running = true;
+	nnpdev->query_version_work.protocol_version =
+		FIELD_GET(NNP_C2H_VERSION_REPLY_QW0_PROT_VER_MASK, msgbuf[0]);
+	nnpdev->query_version_work.chan_protocol_version =
+		FIELD_GET(NNP_C2H_VERSION_REPLY_QW0_CHAN_VER_MASK, msgbuf[0]);
+	nnpdev->query_version_work.chan_resp_op_size = msgbuf[1];
+	nnpdev->query_version_work.chan_cmd_op_size = msgbuf[2];
+
+	queue_work(nnpdev->wq, &nnpdev->query_version_work.work);
+
+	return msg_qwords;
+}
+
+/**
  * handle_bios_protocol() - process response coming from card's BIOS.
  * @nnpdev: The nnp device
  * @msgbuf: pointer to response message content
@@ -58,6 +171,7 @@ typedef int (*response_handler)(struct nnp_device *nnpdev, const u64 *msgbuf,
 				int avail_qwords);
 
 static response_handler resp_handlers[NNP_IPC_C2H_OPCODE_LAST + 1] = {
+	[NNP_IPC_C2H_OP_QUERY_VERSION_REPLY3] = handle_query_version_reply3,
 	[NNP_IPC_C2H_OP_BIOS_PROTOCOL] = handle_bios_protocol
 };
 
@@ -329,6 +443,18 @@ void nnpdev_set_boot_state(struct nnp_device *nnpdev, u32 mask)
 				"Unexpected error while loading boot image. rc=%d\n",
 				ret);
 	}
+
+	/* Handle transition to active state */
+	if (((state & NNP_DEVICE_CARD_DRIVER_READY) ||
+	     (state & NNP_DEVICE_CARD_READY)) &&
+	    !(prev_state & NNP_DEVICE_CARD_DRIVER_READY) &&
+	    !(prev_state & NNP_DEVICE_CARD_READY)) {
+		u32 val;
+
+		/* set host driver state to "Driver ready" */
+		val = FIELD_PREP(NNP_HOST_DRV_STATE_MASK, NNP_HOST_DRV_STATE_READY);
+		nnpdev->ops->set_host_doorbell_value(nnpdev, val);
+	}
 }
 
 /**
@@ -364,6 +490,7 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 	 */
 	nnpdev->dev = dev;
 	nnpdev->ops = ops;
+	nnpdev->protocol_version = 0;
 
 	nnpdev->cmdq_sched = nnp_msched_create(nnpdev);
 	if (!nnpdev->cmdq_sched) {
@@ -397,6 +524,7 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 
 	spin_lock_init(&nnpdev->lock);
 	nnpdev_boot_image_init(&nnpdev->boot_image);
+	INIT_WORK(&nnpdev->query_version_work.work, process_query_version_reply);
 
 	return 0;
 
@@ -426,6 +554,7 @@ static void doorbell_changed_handler(struct work_struct *work)
 	u32 error_state;
 	u32 doorbell_val = req->val;
 	struct nnp_device *nnpdev = req->nnpdev;
+	u64 query_cmd;
 
 	nnpdev->card_doorbell_val = doorbell_val;
 
@@ -466,6 +595,22 @@ static void doorbell_changed_handler(struct work_struct *work)
 		case NNP_CARD_BOOT_STATE_BIOS_FLASH_STARTED:
 			state = NNP_DEVICE_BIOS_UPDATE_STARTED;
 			break;
+		case NNP_CARD_BOOT_STATE_DRV_READY:
+		case NNP_CARD_BOOT_STATE_CARD_READY:
+			/* card is up - send "query_version" command */
+			query_cmd = FIELD_PREP(NNP_H2C_OP_MASK,
+					       NNP_IPC_H2C_OP_QUERY_VERSION);
+			if (nnp_msched_queue_msg(nnpdev->cmdq, query_cmd) ||
+			    nnp_msched_queue_sync(nnpdev->cmdq))
+				dev_err(nnpdev->dev, "Query version msg error\n");
+			break;
+
+		case NNP_CARD_BOOT_STATE_NOT_READY:
+			/* card is down reset the device boot and error state */
+			spin_lock(&nnpdev->lock);
+			nnpdev->state = 0;
+			spin_unlock(&nnpdev->lock);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index b83f67a..63bc54d 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -51,6 +51,15 @@
 #define NNP_DEVICE_RESPONSE_FIFO_LEN    16
 #define NNP_DEVICE_RESPONSE_BUFFER_LEN  (NNP_DEVICE_RESPONSE_FIFO_LEN * 2)
 
+struct query_version_work {
+	struct work_struct work;
+	u64 chan_resp_op_size;
+	u64 chan_cmd_op_size;
+	u16 protocol_version;
+	u16 chan_protocol_version;
+	bool running;
+};
+
 /**
  * struct nnp_device - structure for NNP-I device info
  * @ops: device operations implemented by the underlying device driver
@@ -71,9 +80,13 @@
  * @bios_version_str: the device's started bios version string
  * @bios_system_info_valid: true if @bios_system_info has been filled and valid
  * @state: current device boot state mask (see device state bits above)
+ * @protocol_version: version of host->card IPC protocol
+ * @chan_protocol_version: version of user-space->card IPC protocol
  * @curr_boot_state: last boot state field received from device doorbell reg
  * @card_doorbell_val: last received device doorbell register value.
  * @boot_image: boot image object used to boot the card
+ * @query_version_work: work struct used to schedule processing of version
+ *                      reply response message arrived from card.
  */
 struct nnp_device {
 	const struct nnp_device_ops *ops;
@@ -98,8 +111,12 @@ struct nnp_device {
 
 	u32            state;
 	u32            curr_boot_state;
+	unsigned short protocol_version;
+	unsigned short chan_protocol_version;
 	u32            card_doorbell_val;
 	struct image_info boot_image;
+
+	struct query_version_work query_version_work;
 };
 
 /**
-- 
1.8.3.1

