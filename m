Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698F937F4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhEMJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:03:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:47045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232468AbhEMJBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:01:10 -0400
IronPort-SDR: F3u1nTF5IBjtAHQcYTrEWtAcZGi13jsYqRo5LBLUqlH6JhsRGCGPDA26KhhUm29J/qhlH1hhxu
 SNvHnrSswr2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032316"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032316"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:26 -0700
IronPort-SDR: de2sSs8gVluuFqDzofGNoO0aqqVL4ETv7FcCyY1s7T/rFsMgmjuykEfJ80Q33i/XxQqi6wGBD7
 Dz86RU91FcDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928412"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:24 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 11/15] misc: nnpi: Create comm channel from app to device
Date:   Thu, 13 May 2021 11:57:21 +0300
Message-Id: <20210513085725.45528-12-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Establish bi-directional communication channels between user-mode
processes and NNP-I devices. Each command channel object ("channel")
holds a queue of messages from a single user-mode connection to a
single NNP-I device, as well as a ring-buffer to hold response messages
from this NNP-I device back to the user-mode process.

Messages to the NNP-I device are put by the channel into a command
queue. Response messages coming back from the device are being routed
to the intended channel's ring-buffer, where they are consumed by this
channel's user-mode connection. Routing of messages to and from the
device is done based on a channel's 10-bit unique id, which is included
in the messages.

The interface for consuming responses from the ring-buffer and writing
command messages into the msg_scheduler's command queue will be added
in a future patch. This patch only adds the channel creation code and
response message routing to the targeted channel.

When creating a "command channel", the user should give an open file
descriptor to the /dev/nnpi_host device. This file descriptor
associates the channel with a particular "nnp_user" object. The channel
can only reference host resources created by that "user".

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/Makefile                   |   2 +-
 drivers/misc/intel-nnpi/cmd_chan.c                 | 314 +++++++++++++++++++++
 drivers/misc/intel-nnpi/cmd_chan.h                 |  72 +++++
 drivers/misc/intel-nnpi/device.c                   | 113 +++++++-
 drivers/misc/intel-nnpi/device.h                   |  17 +-
 drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h |   3 +
 6 files changed, 516 insertions(+), 5 deletions(-)
 create mode 100644 drivers/misc/intel-nnpi/cmd_chan.c
 create mode 100644 drivers/misc/intel-nnpi/cmd_chan.h

diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
index e46c89f..b3bab2a 100644
--- a/drivers/misc/intel-nnpi/Makefile
+++ b/drivers/misc/intel-nnpi/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
 
 intel_nnpi-y := device.o msg_scheduler.o hostres.o host_chardev.o nnp_user.o \
-                bootimage.o
+                bootimage.o cmd_chan.o
 
 intel_nnpi_pcie-y := nnp_pcie.o
 
diff --git a/drivers/misc/intel-nnpi/cmd_chan.c b/drivers/misc/intel-nnpi/cmd_chan.c
new file mode 100644
index 0000000..b5518e0
--- /dev/null
+++ b/drivers/misc/intel-nnpi/cmd_chan.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/dev_printk.h>
+#include <linux/file.h>
+#include <linux/minmax.h>
+#include <linux/slab.h>
+
+#include "cmd_chan.h"
+#include "host_chardev.h"
+#include "ipc_protocol.h"
+#include "nnp_user.h"
+
+#define RESPQ_INIT_BUF_SIZE    SZ_2K   /* must be power of 2 */
+#define RESPQ_MAX_BUF_SIZE     SZ_1M   /* must be power of 2 */
+
+static inline int respq_free_bytes(struct nnp_chan *chan)
+{
+	return CIRC_SPACE(chan->respq.head, chan->respq.tail, chan->respq_size);
+}
+
+static inline void respq_push(struct nnp_chan *chan, void *buf, int count)
+{
+	char *dst = chan->respq.buf + chan->respq.head;
+	int t = CIRC_SPACE_TO_END(chan->respq.head, chan->respq.tail,
+				  chan->respq_size);
+
+	if (t >= count) {
+		memcpy(dst, buf, count);
+	} else {
+		memcpy(dst, buf, t);
+		memcpy(chan->respq.buf, (u8 *)buf + t, count - t);
+	}
+	chan->respq.head = (chan->respq.head + count) & (chan->respq_size - 1);
+}
+
+static inline void respq_pop(struct nnp_chan *chan, void *buf, int count)
+{
+	char *src = chan->respq.buf + chan->respq.tail;
+	int t = CIRC_CNT_TO_END(chan->respq.head, chan->respq.tail,
+				chan->respq_size);
+
+	if (t >= count) {
+		memcpy(buf, src, count);
+	} else {
+		memcpy(buf, src, t);
+		memcpy((u8 *)buf + t, chan->respq.buf, count - t);
+	}
+	chan->respq.tail = (chan->respq.tail + count) & (chan->respq_size - 1);
+}
+
+/**
+ * nnpdev_chan_create() - creates a command channel object
+ * @nnpdev: the device
+ * @host_fd: opened file descriptor to "/dev/nnpi_host"
+ * @min_id: minimum range for allocating ipc channel id for that channel
+ * @max_id: maximum range for allocating ipc channel id for that channel
+ * @get_device_events: true if this channel needs to receive device-level
+ *                     responses (not originated to specific channel).
+ *
+ * This function create a "command channel" and assign it a unique id within
+ * the range [@min_id..@max_id]. channels in id range [0, 255] are assumed to be
+ * used for inference related operations and have slightly special semantics.
+ *
+ * Return: pointer to created channel or error.
+ */
+struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
+				    unsigned int min_id, unsigned int max_id,
+				    bool get_device_events)
+{
+	struct nnp_chan *cmd_chan;
+	int chan_id;
+	int ret;
+	unsigned int max_proto_id = BIT(NNP_IPC_CHANNEL_BITS) - 1;
+
+	if (min_id > max_proto_id)
+		return ERR_PTR(-EINVAL);
+	if (max_id > max_proto_id)
+		max_id = max_proto_id;
+	if (max_id < min_id)
+		return ERR_PTR(-EINVAL);
+
+	ret = ida_simple_get(&nnpdev->cmd_chan_ida, min_id, max_id + 1,
+			     GFP_KERNEL);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	chan_id = ret;
+
+	cmd_chan = kzalloc(sizeof(*cmd_chan), GFP_KERNEL);
+	if (!cmd_chan) {
+		ret = -ENOMEM;
+		goto err_ida;
+	}
+
+	cmd_chan->respq_buf = kmalloc(RESPQ_INIT_BUF_SIZE, GFP_KERNEL);
+	if (!cmd_chan->respq_buf) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+	cmd_chan->respq_size = RESPQ_INIT_BUF_SIZE;
+	cmd_chan->respq.buf = cmd_chan->respq_buf;
+	spin_lock_init(&cmd_chan->respq_lock);
+
+	cmd_chan->host_file = nnp_host_file_get(host_fd);
+	if (!cmd_chan->host_file) {
+		ret = -EINVAL;
+		goto err_respq;
+	}
+
+	cmd_chan->cmdq = nnp_msched_queue_create(nnpdev->cmdq_sched);
+	if (!cmd_chan->cmdq) {
+		ret = -ENOMEM;
+		goto err_file_get;
+	}
+
+	kref_init(&cmd_chan->ref);
+	cmd_chan->chan_id = chan_id;
+	cmd_chan->nnpdev = nnpdev;
+	cmd_chan->get_device_events = get_device_events;
+
+	cmd_chan->nnp_user = cmd_chan->host_file->private_data;
+	nnp_user_get(cmd_chan->nnp_user);
+
+	init_waitqueue_head(&cmd_chan->resp_waitq);
+	mutex_init(&cmd_chan->dev_mutex);
+
+	/*
+	 * Add channel to the channel hash
+	 */
+	spin_lock(&nnpdev->lock);
+	hash_add(nnpdev->cmd_chan_hash, &cmd_chan->hash_node, cmd_chan->chan_id);
+
+	spin_unlock(&nnpdev->lock);
+
+	return cmd_chan;
+
+err_file_get:
+	fput(cmd_chan->host_file);
+err_respq:
+	kfree(cmd_chan->respq_buf);
+err_alloc:
+	kfree(cmd_chan);
+err_ida:
+	ida_simple_remove(&nnpdev->cmd_chan_ida, chan_id);
+	return ERR_PTR(ret);
+}
+
+static void nnp_chan_release(struct kref *kref)
+{
+	struct nnp_chan *cmd_chan = container_of(kref, struct nnp_chan, ref);
+
+	nnp_chan_disconnect(cmd_chan);
+
+	nnp_user_put(cmd_chan->nnp_user);
+
+	kfree(cmd_chan->respq_buf);
+	kfree(cmd_chan);
+}
+
+void nnp_chan_get(struct nnp_chan *cmd_chan)
+{
+	kref_get(&cmd_chan->ref);
+}
+
+void nnp_chan_put(struct nnp_chan *cmd_chan)
+{
+	kref_put(&cmd_chan->ref, nnp_chan_release);
+}
+
+/**
+ * nnp_chan_disconnect() - disconnect the channel from the NNP-I device object
+ * @cmd_chan: the command channel object
+ *
+ * This function is called when the channel is released or the NNP-I device is
+ * being removed. It disconnect the channel from the nnp_device object.
+ * A disconnected channel can no longer become connected again and cannot
+ * be used to communicate with any device.
+ */
+void nnp_chan_disconnect(struct nnp_chan *cmd_chan)
+{
+	struct nnp_device *nnpdev;
+
+	mutex_lock(&cmd_chan->dev_mutex);
+	if (!cmd_chan->nnpdev) {
+		mutex_unlock(&cmd_chan->dev_mutex);
+		return;
+	}
+
+	nnpdev = cmd_chan->nnpdev;
+	cmd_chan->nnpdev = NULL;
+	spin_lock(&nnpdev->lock);
+	hash_del(&cmd_chan->hash_node);
+	spin_unlock(&nnpdev->lock);
+	mutex_unlock(&cmd_chan->dev_mutex);
+
+	nnp_msched_queue_sync(cmd_chan->cmdq);
+	nnp_msched_queue_destroy(cmd_chan->cmdq);
+
+	ida_simple_remove(&nnpdev->cmd_chan_ida, cmd_chan->chan_id);
+}
+
+static int resize_respq(struct nnp_chan *cmd_chan)
+{
+	unsigned int avail_size;
+	unsigned int new_size;
+	char         *new_buf;
+
+	new_size = min_t(unsigned int, cmd_chan->respq_size * 2, RESPQ_MAX_BUF_SIZE);
+
+	/* do not try to resize if already in maximum size */
+	if (new_size == cmd_chan->respq_size)
+		return -ENOMEM;
+
+	new_buf = kmalloc(new_size, GFP_KERNEL);
+	if (!new_buf)
+		return -ENOMEM;
+
+	/* copy data from old to new ring buffer */
+	spin_lock(&cmd_chan->respq_lock);
+	avail_size = CIRC_CNT(cmd_chan->respq.head, cmd_chan->respq.tail,
+			      cmd_chan->respq_size);
+	if (avail_size > 0)
+		respq_pop(cmd_chan, new_buf, avail_size);
+	kfree(cmd_chan->respq_buf);
+	cmd_chan->respq_buf = new_buf;
+	cmd_chan->respq_size = new_size;
+	cmd_chan->respq.buf = cmd_chan->respq_buf;
+	cmd_chan->respq.tail = 0;
+	cmd_chan->respq.head = avail_size;
+	spin_unlock(&cmd_chan->respq_lock);
+	dev_dbg(cmd_chan->nnpdev->dev, "channel respq resized to %d\n", new_size);
+
+	return 0;
+}
+
+/**
+ * try_add_response() - adds a response message to respq if enough space exist
+ * @cmd_chan: the command channel object
+ * @hw_msg: response message arrived from device
+ * @size: size in bytes of the response
+ *
+ * Return: zero on success, -ENOSPC if message does not fit
+ */
+static int try_add_response(struct nnp_chan *cmd_chan, u64 *hw_msg, u32 size)
+{
+	spin_lock(&cmd_chan->respq_lock);
+
+	/* Would the response fit in the buffer? */
+	if (respq_free_bytes(cmd_chan) < size + sizeof(size)) {
+		spin_unlock(&cmd_chan->respq_lock);
+		return -ENOSPC;
+	}
+
+	/* push the response message to the ring buffer */
+	respq_push(cmd_chan, &size, sizeof(size));
+	respq_push(cmd_chan, hw_msg, size);
+
+	spin_unlock(&cmd_chan->respq_lock);
+
+	wake_up_all(&cmd_chan->resp_waitq);
+
+	return 0;
+}
+
+/**
+ * nnp_chan_add_response() - adds a response message targeting this channel
+ * @cmd_chan: the command channel object
+ * @hw_msg: response message arrived from device
+ * @size: size in bytes of the response
+ *
+ * This function is being called when a response arrived from the NNP-I card
+ * which targets to a specific command channel object.
+ * The function puts the response message in a ring buffer and will later be
+ * consumed by user space through a call to read(2) on the channel' file
+ * descriptor.
+ *
+ * Return: error code or zero on success.
+ */
+int nnp_chan_add_response(struct nnp_chan *cmd_chan, u64 *hw_msg, u32 size)
+{
+	int ret;
+
+retry:
+	ret = try_add_response(cmd_chan, hw_msg, size);
+	if (ret == -ENOSPC) {
+		/*
+		 * This should *rarely* happen in normal system
+		 * operation since the ring-buffer is big enough.
+		 * We will get here only if the user application sleeps
+		 * for a *very* long time without draining the responses.
+		 * Try to resize the response buffer when it does
+		 * happen, but up to a maximum value.
+		 * If resize failed, we have no choice but to lose the
+		 * response. Only the application that uses that channel
+		 * will get affected.
+		 */
+		ret = resize_respq(cmd_chan);
+		if (!ret)
+			goto retry;
+	}
+
+	if (ret) {
+		if (!cmd_chan->resp_lost)
+			dev_err_ratelimited(cmd_chan->nnpdev->dev,
+					    "Response queue full for channel %d losing response!\n",
+					    cmd_chan->chan_id);
+		cmd_chan->resp_lost++;
+	}
+
+	return ret;
+}
diff --git a/drivers/misc/intel-nnpi/cmd_chan.h b/drivers/misc/intel-nnpi/cmd_chan.h
new file mode 100644
index 0000000..8cb1a5e
--- /dev/null
+++ b/drivers/misc/intel-nnpi/cmd_chan.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef NNPDRV_CMD_CHAN_H
+#define NNPDRV_CMD_CHAN_H
+
+#include <linux/circ_buf.h>
+#include <linux/hashtable.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+
+#include "device.h"
+
+/**
+ * struct nnp_chan - structure object for user<->device communication
+ * @ref: refcount for this object
+ * @nnpdev: the device this channel is connected to. May be NULL after device
+ *          disconnects (on device removal or reset).
+ * @chan_id: the ipc channel id for this channel
+ * @hash_node: node to include this object in list of channels
+ *             hash is in (cmd_chan_hash in nnp_device).
+ * @get_device_events: true if device-level events received from card should
+ *                     be sent over this channel to user.
+ * @cmdq: message queue added to msg_scheduler, for user commands to be sent
+ *        to the device.
+ * @host_file: reference to opened "/dev/nnpi_host" object which defines the
+ *             nnp_user object this channel connects to.
+ * @nnp_user: the nnp_user this channel belongs to.
+ *             the channel can reference host resources created by this
+ *             nnp_user object.
+ * @dev_mutex: protects @nnpdev
+ * @resp_waitq: waitqueue used for waiting for response messages be available.
+ * @respq: circular buffer object that receive response messages from device.
+ * @respq_lock: protects @respq
+ * @respq_buf: buffer space allocated for circular response buffer.
+ * @respq_size: current allocated size of circular response buffer.
+ * @resp_lost: number of response messages lost due to response buffer full.
+ */
+struct nnp_chan {
+	struct kref            ref;
+	struct nnp_device      *nnpdev;
+	u16                    chan_id;
+	struct hlist_node      hash_node;
+	bool                   get_device_events;
+
+	struct nnp_msched_queue    *cmdq;
+	struct file                *host_file;
+	struct nnp_user_info       *nnp_user;
+
+	struct mutex      dev_mutex;
+	wait_queue_head_t resp_waitq;
+
+	struct circ_buf   respq;
+	spinlock_t        respq_lock;
+	char              *respq_buf;
+	unsigned int      respq_size;
+	unsigned int      resp_lost;
+};
+
+struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
+				    unsigned int min_id, unsigned int max_id,
+				    bool get_device_events);
+
+void nnp_chan_get(struct nnp_chan *cmd_chan);
+void nnp_chan_put(struct nnp_chan *cmd_chan);
+void nnp_chan_disconnect(struct nnp_chan *cmd_chan);
+
+int nnp_chan_add_response(struct nnp_chan *cmd_chan, u64 *hw_msg, u32 size);
+
+#endif
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 7bcab563..3902876 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 
 #include "bootimage.h"
+#include "cmd_chan.h"
 #include "device.h"
 #include "host_chardev.h"
 #include "msg_scheduler.h"
@@ -61,6 +62,9 @@ static void process_query_version_reply(struct work_struct *work)
 	u32 protocol_version;
 	u32 card_boot_state;
 	u32 val;
+	u64 chan_resp_op_size;
+	u64 chan_cmd_op_size;
+	int i;
 
 	query_version_work =
 		container_of(work, struct query_version_work, work);
@@ -70,6 +74,15 @@ static void process_query_version_reply(struct work_struct *work)
 	card_boot_state = FIELD_GET(NNP_CARD_BOOT_STATE_MASK,
 				    nnpdev->card_doorbell_val);
 
+	chan_resp_op_size = query_version_work->chan_resp_op_size;
+	chan_cmd_op_size = query_version_work->chan_cmd_op_size;
+	for (i = 0; i < NNP_IPC_NUM_USER_OPS; i++) {
+		nnpdev->ipc_chan_resp_op_size[i] = chan_resp_op_size & 0x3;
+		chan_resp_op_size >>= 2;
+		nnpdev->ipc_chan_cmd_op_size[i] = chan_cmd_op_size & 0x3;
+		chan_cmd_op_size >>= 2;
+	}
+
 	nnpdev->protocol_version =
 		query_version_work->protocol_version;
 	nnpdev->chan_protocol_version =
@@ -167,6 +180,38 @@ static int handle_bios_protocol(struct nnp_device *nnpdev, const u64 *msgbuf,
 	return msg_qwords;
 }
 
+struct nnp_chan *nnpdev_find_channel(struct nnp_device *nnpdev, u16 chan_id)
+{
+	struct nnp_chan *cmd_chan;
+
+	spin_lock(&nnpdev->lock);
+	hash_for_each_possible(nnpdev->cmd_chan_hash, cmd_chan, hash_node, chan_id)
+		if (cmd_chan->chan_id == chan_id) {
+			nnp_chan_get(cmd_chan);
+			spin_unlock(&nnpdev->lock);
+			return cmd_chan;
+		}
+	spin_unlock(&nnpdev->lock);
+
+	return NULL;
+}
+
+static void disconnect_all_channels(struct nnp_device *nnpdev)
+{
+	struct nnp_chan *cmd_chan;
+	int i;
+
+restart:
+	spin_lock(&nnpdev->lock);
+	hash_for_each(nnpdev->cmd_chan_hash, i, cmd_chan, hash_node) {
+		spin_unlock(&nnpdev->lock);
+		nnp_chan_disconnect(cmd_chan);
+		nnp_chan_put(cmd_chan);
+		goto restart;
+	}
+	spin_unlock(&nnpdev->lock);
+}
+
 typedef int (*response_handler)(struct nnp_device *nnpdev, const u64 *msgbuf,
 				int avail_qwords);
 
@@ -175,6 +220,50 @@ typedef int (*response_handler)(struct nnp_device *nnpdev, const u64 *msgbuf,
 	[NNP_IPC_C2H_OP_BIOS_PROTOCOL] = handle_bios_protocol
 };
 
+static int dispatch_chan_message(struct nnp_device *nnpdev, u64 *hw_msg,
+				 unsigned int size)
+{
+	int op_code = FIELD_GET(NNP_C2H_CHAN_MSG_OP_MASK, hw_msg[0]);
+	int chan_id = FIELD_GET(NNP_C2H_CHAN_MSG_CHAN_ID_MASK, hw_msg[0]);
+	struct nnp_chan *chan;
+	int msg_size;
+
+	if (op_code < NNP_IPC_MIN_USER_OP ||
+	    op_code > NNP_IPC_MAX_USER_OP) {
+		/* Should not happen! */
+		dev_err(nnpdev->dev,
+			"chan response opcode out-of-range received %d (0x%llx)\n",
+			op_code, *hw_msg);
+		return -EINVAL;
+	}
+
+	msg_size = nnpdev->ipc_chan_resp_op_size[op_code - NNP_IPC_MIN_USER_OP];
+	if (msg_size == 0) {
+		/* Should not happen! */
+		dev_err(nnpdev->dev,
+			"Unknown response chan opcode received %d (0x%llx)\n",
+			op_code, *hw_msg);
+		return -EINVAL;
+	}
+
+	/* Check for partial message */
+	if (size < msg_size)
+		return -ENOSPC;
+
+	chan = nnpdev_find_channel(nnpdev, chan_id);
+	if (!chan) {
+		dev_err(nnpdev->dev,
+			"Got response for invalid channel chan_id=%d 0x%llx\n",
+			chan_id, *hw_msg);
+		return msg_size;
+	}
+
+	nnp_chan_add_response(chan, hw_msg, msg_size * 8);
+	nnp_chan_put(chan);
+
+	return msg_size;
+}
+
 /**
  * nnpdev_process_messages() - process response messages from nnpi device
  * @nnpdev: The nnp device
@@ -234,10 +323,18 @@ void nnpdev_process_messages(struct nnp_device *nnpdev, u64 *hw_msg,
 		int op_code = FIELD_GET(NNP_C2H_OP_MASK, msg[j]);
 		response_handler handler;
 
-		/* opcodes above OP_BIOS_PROTOCOL are not yet supported */
+		/* opcodes above OP_BIOS_PROTOCOL are routed to a channel */
 		if (op_code > NNP_IPC_C2H_OP_BIOS_PROTOCOL) {
-			fatal_protocol_error = true;
-			break;
+			msg_size = dispatch_chan_message(nnpdev, &msg[j],
+							 nof_msg - j);
+			if (msg_size < 0) {
+				if (msg_size != -ENOSPC)
+					fatal_protocol_error = true;
+				break;
+			}
+
+			j += msg_size;
+			continue;
 		}
 
 		/* dispatch the message request */
@@ -492,6 +589,11 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 	nnpdev->ops = ops;
 	nnpdev->protocol_version = 0;
 
+	nnpdev->protocol_version = 0;
+
+	ida_init(&nnpdev->cmd_chan_ida);
+	hash_init(nnpdev->cmd_chan_hash);
+
 	nnpdev->cmdq_sched = nnp_msched_create(nnpdev);
 	if (!nnpdev->cmdq_sched) {
 		ret = -ENOMEM;
@@ -668,10 +770,15 @@ void nnpdev_destroy(struct nnp_device *nnpdev)
 
 	destroy_workqueue(nnpdev->wq);
 
+	disconnect_all_channels(nnpdev);
 	dma_free_coherent(nnpdev->dev, NNP_PAGE_SIZE, nnpdev->bios_system_info,
 			  nnpdev->bios_system_info_dma_addr);
 
 	nnp_msched_destroy(nnpdev->cmdq_sched);
+	/*
+	 * nnpdev->cmd_chan_ida is empty after disconnect_all_channels,
+	 * ida_destroy is not needed
+	 */
 	ida_simple_remove(&dev_ida, nnpdev->id);
 }
 EXPORT_SYMBOL(nnpdev_destroy);
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index 63bc54d..9b6383e 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -4,6 +4,8 @@
 #ifndef _NNPDRV_DEVICE_H
 #define _NNPDRV_DEVICE_H
 
+#include <linux/hashtable.h>
+#include <linux/idr.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
@@ -70,11 +72,13 @@ struct query_version_work {
  * @cmdq: input queue to @cmdq_sched used to schedule driver internal commands
  *        to be sent to the device.
  * @wq: singlethread workqueue for processing device's response messages.
- * @lock: protects accesses to @state
+ * @lock: protects accesses to @state and @cmd_chan_hash
  * @is_recovery_bios: true if device has booted from the recovery bios flash
  * @boot_image_loaded: true if boot image load has started
  * @response_buf: buffer of device response messages arrived from "pci" layer.
  * @response_num_msgs: number of qwords available in @response_buf
+ * @cmd_chan_ida: allocate channel ids to be used in ipc protocol.
+ * @cmd_chan_hash: maps command channel id to its struct pointer.
  * @bios_system_info_dma_addr: dma page allocated for bios system info.
  * @bios_system_info: virtual pointer to bios system info page
  * @bios_version_str: the device's started bios version string
@@ -87,6 +91,9 @@ struct query_version_work {
  * @boot_image: boot image object used to boot the card
  * @query_version_work: work struct used to schedule processing of version
  *                      reply response message arrived from card.
+ * @ipc_chan_resp_op_size: holds response size for each possible channel
+ *                         response.
+ * @ipc_chan_cmd_op_size: holds command size for each possible channel command.
  */
 struct nnp_device {
 	const struct nnp_device_ops *ops;
@@ -104,6 +111,9 @@ struct nnp_device {
 	u64            response_buf[NNP_DEVICE_RESPONSE_BUFFER_LEN];
 	unsigned int   response_num_msgs;
 
+	struct ida cmd_chan_ida;
+	DECLARE_HASHTABLE(cmd_chan_hash, 6);
+
 	dma_addr_t                  bios_system_info_dma_addr;
 	struct nnp_c2h_system_info  *bios_system_info;
 	char                        bios_version_str[NNP_BIOS_VERSION_LEN];
@@ -117,6 +127,9 @@ struct nnp_device {
 	struct image_info boot_image;
 
 	struct query_version_work query_version_work;
+
+	u8   ipc_chan_resp_op_size[NNP_IPC_NUM_USER_OPS];
+	u8   ipc_chan_cmd_op_size[NNP_IPC_NUM_USER_OPS];
 };
 
 /**
@@ -151,4 +164,6 @@ void nnpdev_process_messages(struct nnp_device *nnpdev, u64 *hw_msg,
  */
 void nnpdev_set_boot_state(struct nnp_device *nnpdev, u32 mask);
 
+struct nnp_chan *nnpdev_find_channel(struct nnp_device *nnpdev, u16 chan_id);
+
 #endif
diff --git a/drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h b/drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h
index 59b4a79..037c362 100644
--- a/drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h
+++ b/drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h
@@ -11,6 +11,9 @@
 
 #define IPC_OP_MAX          BIT(6)
 #define NNP_IPC_OPCODE_MASK GENMASK(5, 0)
+#define NNP_IPC_MIN_USER_OP  32
+#define NNP_IPC_MAX_USER_OP  63
+#define NNP_IPC_NUM_USER_OPS (NNP_IPC_MAX_USER_OP - NNP_IPC_MIN_USER_OP + 1)
 
 #define NNP_MSG_SIZE(msg) (sizeof(msg) / sizeof(__le64))
 
-- 
1.8.3.1

