Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9DB37F4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhEMJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:03:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:47046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhEMJB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:01:26 -0400
IronPort-SDR: P/mmqrJ9eb0o4cyuMoWyDP9mCJHkp32kehZ9V40+qiUR3EmOvuwwb6pKA37FmqHL0mpL5YSOqo
 nhyMxaL5Gybg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032319"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032319"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:28 -0700
IronPort-SDR: ml5V0Tbv54cX8g5UXcY/IDkmMBTK0BHML2WQybiKMhJbZ9jAdGEPy9k9r37wowbIhoHeXbSlg/
 66EfKt6fGi9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928465"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:26 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 12/15] misc: nnpi: Route device response messages
Date:   Thu, 13 May 2021 11:57:22 +0300
Message-Id: <20210513085725.45528-13-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Route both types of messages coming from the NNP-I card - event
report messages, which are handled by the driver, and command-response
messages, which should be routed to a specific command channel object
("channel").

Event report messages are device-level messages which are not
associated with a specific channel. They are typically initiated by the
NNP-I card, to indicate an error, status change, or any event which
is not a response to a message sent from a spcific channel. These event
report messages are handled by the driver.

In contrast, command-response messages are associated with a specific
channel, and are typically sent from the NNP-I card in response to a
message sent from a channel to the card. These command-response
messages are added to the intended channel ring-buffer for consumption
by this channel.

The list of messages, of both types, coming from the card, is defined
in ipc_include/ipc_c2h_events.h included in this patch.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/cmd_chan.h                 |   6 +
 drivers/misc/intel-nnpi/device.c                   | 104 +++++++++++
 drivers/misc/intel-nnpi/device.h                   |   2 +
 .../misc/intel-nnpi/ipc_include/ipc_c2h_events.h   | 198 +++++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/ipc_c2h_events.h

diff --git a/drivers/misc/intel-nnpi/cmd_chan.h b/drivers/misc/intel-nnpi/cmd_chan.h
index 8cb1a5e..2be88c6 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.h
+++ b/drivers/misc/intel-nnpi/cmd_chan.h
@@ -4,6 +4,7 @@
 #ifndef NNPDRV_CMD_CHAN_H
 #define NNPDRV_CMD_CHAN_H
 
+#include <linux/bitfield.h>
 #include <linux/circ_buf.h>
 #include <linux/hashtable.h>
 #include <linux/kref.h>
@@ -12,6 +13,7 @@
 #include <linux/spinlock.h>
 
 #include "device.h"
+#include "ipc_c2h_events.h"
 
 /**
  * struct nnp_chan - structure object for user<->device communication
@@ -21,6 +23,7 @@
  * @chan_id: the ipc channel id for this channel
  * @hash_node: node to include this object in list of channels
  *             hash is in (cmd_chan_hash in nnp_device).
+ * @card_critical_error_msg: last critical event report received from device
  * @get_device_events: true if device-level events received from card should
  *                     be sent over this channel to user.
  * @cmdq: message queue added to msg_scheduler, for user commands to be sent
@@ -43,6 +46,7 @@ struct nnp_chan {
 	struct nnp_device      *nnpdev;
 	u16                    chan_id;
 	struct hlist_node      hash_node;
+	u64                    card_critical_error_msg;
 	bool                   get_device_events;
 
 	struct nnp_msched_queue    *cmdq;
@@ -59,6 +63,8 @@ struct nnp_chan {
 	unsigned int      resp_lost;
 };
 
+#define chan_broken(chan) FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, (chan)->card_critical_error_msg)
+
 struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
 				    unsigned int min_id, unsigned int max_id,
 				    bool get_device_events);
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 3902876..1064edc 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -14,6 +14,7 @@
 #include "cmd_chan.h"
 #include "device.h"
 #include "host_chardev.h"
+#include "ipc_c2h_events.h"
 #include "msg_scheduler.h"
 #include "nnp_boot_defs.h"
 
@@ -212,11 +213,113 @@ static void disconnect_all_channels(struct nnp_device *nnpdev)
 	spin_unlock(&nnpdev->lock);
 }
 
+static void nnpdev_submit_device_event_to_channels(struct nnp_device *nnpdev,
+						   u64 event_msg)
+{
+	struct nnp_chan *cmd_chan;
+	int i;
+	unsigned int event_code;
+	bool should_wake = false;
+	bool is_card_fatal;
+
+	event_code = FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, event_msg);
+	is_card_fatal = is_card_fatal_event(event_code);
+
+	spin_lock(&nnpdev->lock);
+	hash_for_each(nnpdev->cmd_chan_hash, i, cmd_chan, hash_node) {
+		/*
+		 * Update channel's card critical error,
+		 * but do not override it if a more sever "fatal_drv" error
+		 * event is already set.
+		 */
+		if (is_card_fatal &&
+		    !is_card_fatal_drv_event(chan_broken(cmd_chan))) {
+			cmd_chan->card_critical_error_msg = event_msg;
+			should_wake = true;
+		}
+
+		/* Send the event message to the channel (if needed) */
+		if (is_card_fatal || cmd_chan->get_device_events)
+			nnp_chan_add_response(cmd_chan, &event_msg, sizeof(event_msg));
+	}
+	spin_unlock(&nnpdev->lock);
+
+	if (should_wake)
+		wake_up_all(&nnpdev->waitq);
+}
+
+/*
+ * this function handle device-level event report message.
+ * which is usually affect the entire device and not a single channel
+ */
+static void process_device_event(struct nnp_device *nnpdev, u64 event_msg)
+{
+	/* submit the event to all channels requested to get device events */
+	nnpdev_submit_device_event_to_channels(nnpdev, event_msg);
+}
+
+struct event_report_work {
+	struct work_struct work;
+	struct nnp_device  *nnpdev;
+	u64                event_msg;
+};
+
+static void device_event_report_handler(struct work_struct *work)
+{
+	struct event_report_work *req =
+		container_of(work, struct event_report_work, work);
+
+	process_device_event(req->nnpdev, req->event_msg);
+
+	kfree(req);
+}
+
+static int handle_event_report(struct nnp_device *nnpdev, const u64 *msgbuf,
+			       int avail_qwords)
+{
+	int msg_qwords = 1; /* EVENT_REPORT response len is 1 qword */
+	struct event_report_work *req;
+	u64 event_msg;
+
+	if (avail_qwords < msg_qwords)
+		return 0;
+
+	event_msg = msgbuf[0];
+	if (FIELD_GET(NNP_C2H_EVENT_REPORT_CHAN_VALID_MASK, event_msg)) {
+		struct nnp_chan *cmd_chan;
+		unsigned int chan_id;
+
+		chan_id = FIELD_GET(NNP_C2H_EVENT_REPORT_CHAN_ID_MASK, event_msg);
+		cmd_chan = nnpdev_find_channel(nnpdev, chan_id);
+		if (cmd_chan) {
+			nnp_chan_add_response(cmd_chan, &event_msg, sizeof(event_msg));
+			nnp_chan_put(cmd_chan);
+		} else {
+			dev_dbg(nnpdev->dev,
+				"Got Event Report for non existing channel id %d\n",
+				chan_id);
+		}
+		return msg_qwords;
+	}
+
+	req = kzalloc(sizeof(*req), GFP_NOWAIT);
+	if (!req)
+		return msg_qwords;
+
+	req->event_msg = event_msg;
+	req->nnpdev = nnpdev;
+	INIT_WORK(&req->work, device_event_report_handler);
+	queue_work(nnpdev->wq, &req->work);
+
+	return msg_qwords;
+}
+
 typedef int (*response_handler)(struct nnp_device *nnpdev, const u64 *msgbuf,
 				int avail_qwords);
 
 static response_handler resp_handlers[NNP_IPC_C2H_OPCODE_LAST + 1] = {
 	[NNP_IPC_C2H_OP_QUERY_VERSION_REPLY3] = handle_query_version_reply3,
+	[NNP_IPC_C2H_OP_EVENT_REPORT] = handle_event_report,
 	[NNP_IPC_C2H_OP_BIOS_PROTOCOL] = handle_bios_protocol
 };
 
@@ -593,6 +696,7 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 
 	ida_init(&nnpdev->cmd_chan_ida);
 	hash_init(nnpdev->cmd_chan_hash);
+	init_waitqueue_head(&nnpdev->waitq);
 
 	nnpdev->cmdq_sched = nnp_msched_create(nnpdev);
 	if (!nnpdev->cmdq_sched) {
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index 9b6383e..c37f1da 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -79,6 +79,7 @@ struct query_version_work {
  * @response_num_msgs: number of qwords available in @response_buf
  * @cmd_chan_ida: allocate channel ids to be used in ipc protocol.
  * @cmd_chan_hash: maps command channel id to its struct pointer.
+ * @waitq: used to wait for device response messages
  * @bios_system_info_dma_addr: dma page allocated for bios system info.
  * @bios_system_info: virtual pointer to bios system info page
  * @bios_version_str: the device's started bios version string
@@ -113,6 +114,7 @@ struct nnp_device {
 
 	struct ida cmd_chan_ida;
 	DECLARE_HASHTABLE(cmd_chan_hash, 6);
+	wait_queue_head_t waitq;
 
 	dma_addr_t                  bios_system_info_dma_addr;
 	struct nnp_c2h_system_info  *bios_system_info;
diff --git a/drivers/misc/intel-nnpi/ipc_include/ipc_c2h_events.h b/drivers/misc/intel-nnpi/ipc_include/ipc_c2h_events.h
new file mode 100644
index 0000000..5ca1b8e
--- /dev/null
+++ b/drivers/misc/intel-nnpi/ipc_include/ipc_c2h_events.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNP_IPC_C2H_EVENTS_H
+#define _NNP_IPC_C2H_EVENTS_H
+
+/**
+ * The following describes the possible values for a c2h_event_report message
+ * sent from card to host to report on some error or other events.
+ *
+ * The c2h_event_report message has the following fields available to describe
+ * the event:
+ *    event_code  - 7 bits value describing the type of event
+ *    event_val   - 8 bits value - interpretation depends on event_code
+ *    chan_id     - the protocol id of the channel in which the event was
+ *                 occurred.
+ *    obj_id      - 16 bits, interpretation depends on event_code, usually used
+ *                 to hold an inference object protocol ID.
+ *    obj_id_2    - 16 bits, in case obj_id is not enough to describe the object
+ * In this file we define the possible values for the above fields and document
+ * each field meaning for each possible event_code.
+ */
+
+/**
+ * Event codes ranges
+ *
+ * error codes are grouped into the following ranges:
+ *     0 -   3   ==> non error events generated by daemon/runtime
+ *     4 -  47   ==> non error events generated by card kernel driver
+ *    48 -  51   ==> non-critical error events generated by daemon/runtime
+ *    52 -  95   ==> non-critical error events generatd by kernel driver
+ *    96 - 103   ==> context-critical error events generated by daemon/runtime
+ *   104 - 111   ==> context-critical error events generated by kernel driver
+ *   112 - 119   ==> card-critical error events generated by daemon/runtime
+ *   120 - 127   ==> card-critical error events generated by kernel driver
+ *
+ * context-critical error event is one that puts the infer context in an
+ * un-recoverable error state.
+ * card-critical error event is one that make the card not useful for inference
+ * request until it is reset.
+ */
+#define EVENT_NON_ERR_START             0
+#define EVENT_NON_ERR_DRV_START         4
+#define EVENT_ERR_START                48
+#define EVENT_ERR_DRV_START            52
+#define EVENT_CONTEXT_FATAL_START      96
+#define EVENT_CONTEXT_FATAL_DRV_START 104
+#define EVENT_CARD_FATAL_START        112
+#define EVENT_CARD_FATAL_DRV_START    120
+
+#define is_context_fatal_event(e)  ({ \
+	int e_ = (e); \
+	(e_ >= EVENT_CONTEXT_FATAL_START && e_ < EVENT_CARD_FATAL_START); \
+})
+
+#define is_card_fatal_event(e)     ((e) >= EVENT_CARD_FATAL_START)
+#define is_card_fatal_drv_event(e)     ((e) >= EVENT_CARD_FATAL_DRV_START)
+
+#define NNP_IPC_RUNTIME_DONE   (EVENT_NON_ERR_START + 1)
+/*            MAX offset for EVENT_NON_ERR_START is 3 */
+
+/* non-error event codes */
+#define NNP_IPC_CREATE_CONTEXT_SUCCESS   (EVENT_NON_ERR_DRV_START + 0)
+#define NNP_IPC_CREATE_DEVRES_SUCCESS    (EVENT_NON_ERR_DRV_START + 1)
+#define NNP_IPC_CREATE_COPY_SUCCESS      (EVENT_NON_ERR_DRV_START + 2)
+#define NNP_IPC_EXECUTE_COPY_SUCCESS     (EVENT_NON_ERR_DRV_START + 3)
+#define NNP_IPC_DEVRES_DESTROYED         (EVENT_NON_ERR_DRV_START + 4)
+#define NNP_IPC_COPY_DESTROYED           (EVENT_NON_ERR_DRV_START + 5)
+#define NNP_IPC_CONTEXT_DESTROYED        (EVENT_NON_ERR_DRV_START + 6)
+#define NNP_IPC_CREATE_DEVNET_SUCCESS    (EVENT_NON_ERR_DRV_START + 7)
+#define NNP_IPC_DEVNET_DESTROYED         (EVENT_NON_ERR_DRV_START + 8)
+#define NNP_IPC_CREATE_INFREQ_SUCCESS    (EVENT_NON_ERR_DRV_START + 9)
+#define NNP_IPC_INFREQ_DESTROYED         (EVENT_NON_ERR_DRV_START + 10)
+#define NNP_IPC_RECOVER_CONTEXT_SUCCESS  (EVENT_NON_ERR_DRV_START + 11)
+#define NNP_IPC_THERMAL_TRIP_EVENT       (EVENT_NON_ERR_DRV_START + 12)
+#define NNP_IPC_DEVNET_ADD_RES_SUCCESS   (EVENT_NON_ERR_DRV_START + 13)
+#define NNP_IPC_DEVICE_STATE_CHANGED     (EVENT_NON_ERR_DRV_START + 14)
+#define NNP_IPC_DEVNET_RESOURCES_RESERVATION_SUCCESS \
+	(EVENT_NON_ERR_DRV_START + 15)
+#define NNP_IPC_DEVNET_RESOURCES_RELEASE_SUCCESS  (EVENT_NON_ERR_DRV_START + 16)
+#define NNP_IPC_CREATE_CHANNEL_SUCCESS   (EVENT_NON_ERR_DRV_START + 17)
+#define NNP_IPC_CHANNEL_DESTROYED        (EVENT_NON_ERR_DRV_START + 18)
+#define NNP_IPC_CHANNEL_SET_RB_SUCCESS   (EVENT_NON_ERR_DRV_START + 19)
+#define NNP_IPC_CHANNEL_MAP_HOSTRES_SUCCESS   (EVENT_NON_ERR_DRV_START + 20)
+#define NNP_IPC_CHANNEL_UNMAP_HOSTRES_SUCCESS (EVENT_NON_ERR_DRV_START + 21)
+#define NNP_IPC_ABORT_REQUEST            (EVENT_NON_ERR_DRV_START + 22)
+#define NNP_IPC_GET_FIFO                 (EVENT_NON_ERR_DRV_START + 23)
+#define NNP_IPC_CREATE_CMD_SUCCESS       (EVENT_NON_ERR_DRV_START + 24)
+#define NNP_IPC_CMD_DESTROYED            (EVENT_NON_ERR_DRV_START + 25)
+#define NNP_IPC_EXECUTE_CMD_COMPLETE     (EVENT_NON_ERR_DRV_START + 26)
+#define NNP_IPC_DEVNET_SET_PROPERTY_SUCCESS  (EVENT_NON_ERR_DRV_START + 27)
+#define NNP_IPC_EXECUTE_CPYLST_SUCCESS   (EVENT_NON_ERR_DRV_START + 28)
+#define NNP_IPC_GET_CR_FIFO_REPLY        (EVENT_NON_ERR_DRV_START + 29)
+#define NNP_IPC_P2P_PEERS_CONNECTED      (EVENT_NON_ERR_DRV_START + 30)
+#define NNP_IPC_P2P_PEER_DEV_UPDATED     (EVENT_NON_ERR_DRV_START + 31)
+#define NNP_IPC_EXECUTE_COPY_SUBRES_SUCCESS  (EVENT_NON_ERR_DRV_START + 32)
+/*                   MAX offset for EVENT_NON_ERR_DRV_START is 43 */
+
+/* non-critical error event codes */
+#define NNP_IPC_CREATE_CONTEXT_FAILED    (EVENT_ERR_DRV_START + 0)
+#define NNP_IPC_CREATE_DEVRES_FAILED     (EVENT_ERR_DRV_START + 1)
+#define NNP_IPC_CREATE_COPY_FAILED       (EVENT_ERR_DRV_START + 2)
+#define NNP_IPC_DESTROY_CONTEXT_FAILED   (EVENT_ERR_DRV_START + 3)
+#define NNP_IPC_DESTROY_DEVRES_FAILED    (EVENT_ERR_DRV_START + 4)
+#define NNP_IPC_DESTROY_COPY_FAILED      (EVENT_ERR_DRV_START + 5)
+#define NNP_IPC_CREATE_SYNC_FAILED       (EVENT_ERR_DRV_START + 6)
+#define NNP_IPC_ERROR_SUB_RESOURCE_LOAD_FAILED      (EVENT_ERR_DRV_START + 7)
+#define NNP_IPC_CREATE_DEVNET_FAILED     (EVENT_ERR_DRV_START + 8)
+#define NNP_IPC_DESTROY_DEVNET_FAILED    (EVENT_ERR_DRV_START + 9)
+#define NNP_IPC_CREATE_INFREQ_FAILED     (EVENT_ERR_DRV_START + 10)
+#define NNP_IPC_DESTROY_INFREQ_FAILED    (EVENT_ERR_DRV_START + 11)
+#define NNP_IPC_RECOVER_CONTEXT_FAILED   (EVENT_ERR_DRV_START + 12)
+#define NNP_IPC_ERROR_MCE_CORRECTABLE    (EVENT_ERR_DRV_START + 13)
+#define NNP_IPC_ERROR_MCE_UNCORRECTABLE  (EVENT_ERR_DRV_START + 14)
+#define NNP_IPC_DEVNET_ADD_RES_FAILED    (EVENT_ERR_DRV_START + 15)
+#define NNP_IPC_DEVNET_RESOURCES_RESERVATION_FAILED (EVENT_ERR_DRV_START + 16)
+#define NNP_IPC_DEVNET_RESOURCES_RELEASE_FAILED     (EVENT_ERR_DRV_START + 17)
+#define NNP_IPC_CREATE_CHANNEL_FAILED    (EVENT_ERR_DRV_START + 18)
+#define NNP_IPC_DESTROY_CHANNEL_FAILED   (EVENT_ERR_DRV_START + 19)
+#define NNP_IPC_CHANNEL_SET_RB_FAILED    (EVENT_ERR_DRV_START + 20)
+#define NNP_IPC_CREATE_CMD_FAILED        (EVENT_ERR_DRV_START + 21)
+#define NNP_IPC_DESTROY_CMD_FAILED       (EVENT_ERR_DRV_START + 22)
+#define NNP_IPC_CHANNEL_MAP_HOSTRES_FAILED   (EVENT_ERR_DRV_START + 23)
+#define NNP_IPC_CHANNEL_UNMAP_HOSTRES_FAILED (EVENT_ERR_DRV_START + 24)
+#define NNP_IPC_DEVNET_SET_PROPERTY_FAILED  (EVENT_ERR_DRV_START + 25)
+#define NNP_IPC_ERROR_DRAM_ECC_CORRECTABLE (EVENT_ERR_DRV_START + 26)
+#define NNP_IPC_EXECUTE_COPY_FAILED        (EVENT_ERR_DRV_START + 27)
+#define NNP_IPC_SCHEDULE_INFREQ_FAILED     (EVENT_ERR_DRV_START + 28)
+#define NNP_IPC_EXECUTE_CPYLST_FAILED      (EVENT_ERR_DRV_START + 29)
+#define NNP_IPC_EXECUTE_COPY_SUBRES_FAILED  (EVENT_ERR_DRV_START + 30)
+#define NNP_IPC_EC_FAILED_TO_RELEASE_CREDIT  (EVENT_ERR_DRV_START + 31)
+#define NNP_IPC_DMA_HANG_DETECTED            (EVENT_ERR_DRV_START + 32)
+/*                   MAX offset for EVENT_ERR_DRV_START is 43 */
+
+/* context critical error event codes */
+#define NNP_IPC_ERROR_RUNTIME_LAUNCH     (EVENT_CONTEXT_FATAL_START + 0)
+#define NNP_IPC_ERROR_RUNTIME_DIED       (EVENT_CONTEXT_FATAL_START + 1)
+/*                   MAX offset for EVENT_CONTEXT_FATAL_START is 7 */
+
+#define NNP_IPC_CONTEXT_EXEC_ERROR          (EVENT_CONTEXT_FATAL_DRV_START + 0)
+#define NNP_IPC_CTX_DRAM_ECC_UNCORRECTABLE  (EVENT_CONTEXT_FATAL_DRV_START + 1)
+/*                   MAX offset for EVENT_CONTEXT_FATAL_DRV_START is 7 */
+
+/* card critical error event codes */
+#define NNP_IPC_ERROR_OS_CRASHED          (EVENT_CARD_FATAL_START + 0)
+#define NNP_IPC_ERROR_DRAM_ECC_UNCORRECTABLE_FATAL  (EVENT_CARD_FATAL_START + 1)
+#define NNP_IPC_ERROR_FATAL_ICE_ERROR     (EVENT_CARD_FATAL_START + 2)
+/*                   MAX offset for EVENT_CARD_FATAL_START is 7 */
+
+/* card critical and driver fatal*/
+#define NNP_IPC_ERROR_PCI_ERROR           (EVENT_CARD_FATAL_DRV_START + 0)
+#define NNP_IPC_ERROR_MCE_UNCORRECTABLE_FATAL  (EVENT_CARD_FATAL_DRV_START + 1)
+#define NNP_IPC_ERROR_CARD_RESET          (EVENT_CARD_FATAL_DRV_START + 2)
+#define NNP_IPC_ERROR_CHANNEL_KILLED      (EVENT_CARD_FATAL_DRV_START + 3)
+#define NNP_IPC_ERROR_PROTOCOL_ERROR      (EVENT_CARD_FATAL_DRV_START + 4)
+#define NNP_IPC_FATAL_DMA_HANG_DETECTED   (EVENT_CARD_FATAL_DRV_START + 5)
+/*                   MAX offset for EVENT_CARD_FATAL_DRV_START is 7 */
+
+enum event_val {
+	NNP_IPC_NO_ERROR		= 0,
+	NNP_IPC_NO_SUCH_CONTEXT		= 1,
+	NNP_IPC_NO_SUCH_DEVRES		= 2,
+	NNP_IPC_NO_SUCH_COPY		= 3,
+	NNP_IPC_NO_SUCH_NET		= 4,
+	NNP_IPC_NO_SUCH_INFREQ		= 5,
+	NNP_IPC_ALREADY_EXIST		= 6,
+	NNP_IPC_NO_DAEMON		= 7,
+	NNP_IPC_NO_MEMORY		= 8,
+	NNP_IPC_RUNTIME_FAILED		= 9,
+	NNP_IPC_RUNTIME_LAUNCH_FAILED	= 10,
+	NNP_IPC_DMA_ERROR		= 11,
+	NNP_IPC_RUNTIME_NOT_SUPPORTED	= 12,
+	NNP_IPC_RUNTIME_INVALID_EXECUTABLE_NETWORK_BINARY = 13,
+	NNP_IPC_RUNTIME_INFER_MISSING_RESOURCE        = 14,
+	NNP_IPC_RUNTIME_INFER_EXEC_ERROR              = 15,
+	NNP_IPC_RUNTIME_INFER_SCHEDULE_ERROR          = 16,
+	NNP_IPC_CONTEXT_BROKEN                        = 17,
+	NNP_IPC_DEVNET_RESERVE_INSUFFICIENT_RESOURCES = 18,
+	NNP_IPC_TIMEOUT_EXCEEDED        = 19,
+	NNP_IPC_ECC_ALLOC_FAILED        = 20,
+	NNP_IPC_NO_SUCH_CHANNEL         = 21,
+	NNP_IPC_NO_SUCH_CMD             = 22,
+	NNP_IPC_NO_SUCH_HOSTRES         = 23,
+	NNP_IPC_DEVNET_EDIT_BUSY        = 24,
+	NNP_IPC_DEVNET_EDIT_ERROR       = 25,
+	NNP_IPC_NOT_SUPPORTED           = 26,
+	NNP_IPC_ICEDRV_INFER_EXEC_ERROR = 27,
+	NNP_IPC_ICEDRV_INFER_EXEC_ERROR_NEED_RESET = 28,
+	NNP_IPC_ICEDRV_INFER_EXEC_ERROR_NEED_CARD_RESET = 29,
+	NNP_IPC_NO_EXEC_ERRORS          = 30,
+	NNP_IPC_IO_ERROR                = 31,
+	NNP_IPC_INPUT_IS_DIRTY          = 32,
+
+	/* Non failure events */
+	NNP_IPC_CMDLIST_FINISHED       = 128,
+};
+
+#endif
-- 
1.8.3.1

