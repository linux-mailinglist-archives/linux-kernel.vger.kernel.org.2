Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DDE37F4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhEMJD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:03:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:47049 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhEMJCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:02:10 -0400
IronPort-SDR: 5tEQdt3N47bMFa039CRX4fMgG30pB1Bdnt8Itpr7nS38+DuLZC82bJ5PEesKOI/JOLnc9PWKIC
 VAu38puPeKEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032325"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032325"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:31 -0700
IronPort-SDR: zCwc8laL79cSOAdbvo2SLVQ+e2gdmehUpmjttUdvePx3PEu6MKU5qDOaLbOrTlcYrZPy3KQaEn
 nRNPZbM4SCeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928513"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:29 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 13/15] misc: nnpi: Expose command channel file interface
Date:   Thu, 13 May 2021 11:57:23 +0300
Message-Id: <20210513085725.45528-14-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose an anon file descriptor interface to a command channel object
which allows user-space to send commands to the device by writing to
that file as well as consume device response messages by reading the
file.

When the file is released (closed), a channel shut-down sequence
starts. First, a message is sent to the device notifying it that the
channel is closing. Once the response to this message is received from
the device, the command channel object is destroyed.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/cmd_chan.c | 362 +++++++++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/cmd_chan.h |  22 ++-
 drivers/misc/intel-nnpi/device.c   |  71 ++++++++
 3 files changed, 454 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/intel-nnpi/cmd_chan.c b/drivers/misc/intel-nnpi/cmd_chan.c
index b5518e0..89ae604 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.c
+++ b/drivers/misc/intel-nnpi/cmd_chan.c
@@ -4,13 +4,16 @@
 #define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
 
 #include <linux/anon_inodes.h>
+#include <linux/bitfield.h>
 #include <linux/dev_printk.h>
 #include <linux/file.h>
 #include <linux/minmax.h>
+#include <linux/poll.h>
 #include <linux/slab.h>
 
 #include "cmd_chan.h"
 #include "host_chardev.h"
+#include "ipc_c2h_events.h"
 #include "ipc_protocol.h"
 #include "nnp_user.h"
 
@@ -52,6 +55,258 @@ static inline void respq_pop(struct nnp_chan *chan, void *buf, int count)
 	chan->respq.tail = (chan->respq.tail + count) & (chan->respq_size - 1);
 }
 
+static inline void respq_unpop(struct nnp_chan *chan, int count)
+{
+	chan->respq.tail = (chan->respq.tail - count) & (chan->respq_size - 1);
+}
+
+enum respq_state {
+	RESPQ_EMPTY = 0,
+	RESPQ_MSG_AVAIL,
+	RESPQ_DISCONNECTED
+};
+
+/**
+ * respq_state() - check if a response message is available to be popped
+ * @chan: the cmd_chan object
+ *
+ * Checks if new response message is available or channel has been destroyed.
+ *
+ * Return:
+ *  * RESPQ_EMPTY        - response queue is empty
+ *  * RESPQ_MSG_AVAIL    - a response message is available in the queue
+ *  * RESPQ_DISCONNECTED - the channel in a destroyed state
+ */
+static enum respq_state respq_state(struct nnp_chan *chan)
+{
+	bool ret;
+
+	mutex_lock(&chan->dev_mutex);
+	if (chan->state == NNP_CHAN_DESTROYED) {
+		mutex_unlock(&chan->dev_mutex);
+		return RESPQ_DISCONNECTED;
+	}
+
+	spin_lock(&chan->respq_lock);
+	/*
+	 * response messages are pushed into the respq ring-buffer by pushing
+	 * the size of the message (as u32) followed by message content.
+	 * So an entire message is available only if more than sizeof(u32)
+	 * bytes are available (there is no message with zero size).
+	 */
+	if (CIRC_CNT(chan->respq.head, chan->respq.tail, chan->respq_size) >
+	    sizeof(u32))
+		ret = RESPQ_MSG_AVAIL;
+	else
+		ret = RESPQ_EMPTY;
+	spin_unlock(&chan->respq_lock);
+
+	mutex_unlock(&chan->dev_mutex);
+
+	return ret;
+}
+
+static inline int is_cmd_chan_file(struct file *f);
+
+static int cmd_chan_file_release(struct inode *inode, struct file *f)
+{
+	struct nnp_chan *chan = f->private_data;
+	struct file *host_file;
+
+	if (!is_cmd_chan_file(f))
+		return -EINVAL;
+
+	nnp_chan_send_destroy(chan);
+
+	host_file = chan->host_file;
+	nnp_chan_put(chan);
+	fput(host_file);
+
+	return 0;
+}
+
+/**
+ * cmd_chan_file_read() - reads a single response message arrived from device
+ * @f: cmd_chan file descriptor
+ * @buf: buffer to receive the message
+ * @size: size of buf, must be at least 16 qwords (16 * sizeof(u64))
+ * @off: ignored.
+ *
+ * This function will block and wait until interrupted or a response
+ * message from device is available.
+ * When message(s) are available, it reads a single message, copy it to
+ * @buf and returns the message size.
+ * The given @buf and @size must be large enough to receive the largest
+ * possible response which is 16 qwords, otherwise -EINVAL is returned.
+ * The function returns the size of the received message, a return value
+ * of zero means that corrupted message has been detected and no more reads
+ * can be made from this channel.
+ *
+ * Return: if positive, the size in bytes of the read message.
+ *         zero, if a corrupted message has been detected.
+ *         error code otherwise
+ */
+static ssize_t cmd_chan_file_read(struct file *f, char __user *buf, size_t size,
+				  loff_t *off)
+{
+	struct nnp_chan *chan = f->private_data;
+	u64 msg[NNP_DEVICE_RESPONSE_FIFO_LEN];
+	enum respq_state state;
+	u32 msg_size;
+	int ret;
+
+	if (!is_cmd_chan_file(f))
+		return -EINVAL;
+
+	if (size < sizeof(msg))
+		return -EINVAL;
+
+	/*
+	 * wait for response message to be available, interrupted or channel
+	 * has been destroyed on us.
+	 */
+	ret = wait_event_interruptible(chan->resp_waitq,
+				       (state = respq_state(chan)) != RESPQ_EMPTY);
+	if (ret < 0)
+		return ret;
+
+	if (state == RESPQ_DISCONNECTED)
+		return -EPIPE;
+
+	spin_lock(&chan->respq_lock);
+	respq_pop(chan, &msg_size, sizeof(msg_size));
+	/*
+	 * Check msg_size does not overrun msg size.
+	 * This will never happen unless the response ring buffer got
+	 * corrupted in some way.
+	 * We detect it here for safety and return zero
+	 */
+	if (msg_size > sizeof(msg)) {
+		/*
+		 * unpop the bad size to let subsequent read attempts
+		 * to fail as well.
+		 */
+		respq_unpop(chan, sizeof(msg_size));
+		spin_unlock(&chan->respq_lock);
+		return 0;
+	}
+	respq_pop(chan, msg, msg_size);
+	spin_unlock(&chan->respq_lock);
+
+	if (copy_to_user(buf, msg, msg_size))
+		return -EFAULT;
+
+	return (ssize_t)msg_size;
+}
+
+/**
+ * cmd_chan_file_write() - schedule a command message to be sent to the device.
+ * @f: a cmd_chan file descriptor
+ * @buf: the command message content
+ * @size: size in bytes of the message, must be multiple of 8 and not larger
+ *        than 3 qwords.
+ * @off: ignored
+ *
+ * This function reads a command message from buffer and puts it in the
+ * channel's message queue to schedule it to be delivered to the device.
+ * The function returns when the message is copied to the message scheduler
+ * queue without waiting for it to be sent out.
+ * A valid command message size must be qword aligned and not larger than
+ * the maximum size the message scheduler support, which is 3 qwords.
+ *
+ * The function also validate the command content and fail if the chan_id
+ * field of the command header does not belong to the same channel of this
+ * file descriptor, or the command opcode is out of range, or the command
+ * size does not fit the size of this opcode.
+ *
+ * Return: the size of the message written or error code.
+ */
+static ssize_t cmd_chan_file_write(struct file *f, const char __user *buf,
+				   size_t size, loff_t *off)
+{
+	struct nnp_chan *chan = f->private_data;
+	u64 msg[MSG_SCHED_MAX_MSG_SIZE];
+	unsigned int chan_id, opcode;
+	unsigned int op;
+	int rc = 0;
+
+	if (!is_cmd_chan_file(f))
+		return -EINVAL;
+
+	/*
+	 * size must be positive, multiple of 8 bytes and
+	 * cannot exceed maximum message size
+	 */
+	if (!size || size > sizeof(msg) || (size &  0x7) != 0)
+		return -EINVAL;
+
+	if (copy_from_user(msg, buf, size))
+		return -EFAULT;
+
+	/*
+	 * Check chan_id, opcode and message size are valid
+	 */
+	opcode = FIELD_GET(NNP_H2C_CHAN_MSG_OP_MASK, msg[0]);
+	chan_id = FIELD_GET(NNP_H2C_CHAN_MSG_CHAN_ID_MASK, msg[0]);
+	if (chan_id != chan->chan_id)
+		return -EINVAL;
+	if (opcode < NNP_IPC_MIN_USER_OP)
+		return -EINVAL;
+	op = opcode - NNP_IPC_MIN_USER_OP;
+
+	mutex_lock(&chan->dev_mutex);
+	if (!chan->nnpdev) {
+		/* The device was removed */
+		mutex_unlock(&chan->dev_mutex);
+		return -EPIPE;
+	}
+	if (size != chan->nnpdev->ipc_chan_cmd_op_size[op] * 8) {
+		mutex_unlock(&chan->dev_mutex);
+		return -EINVAL;
+	}
+
+	if (!is_card_fatal_drv_event(chan_broken(chan)))
+		rc  = nnp_msched_queue_add_msg(chan->cmdq, msg, size / 8);
+	mutex_unlock(&chan->dev_mutex);
+
+	if (rc < 0)
+		return rc;
+
+	return size;
+}
+
+static unsigned int cmd_chan_file_poll(struct file *f, struct poll_table_struct *pt)
+{
+	struct nnp_chan *chan = f->private_data;
+	unsigned int mask = POLLOUT | POLLWRNORM;
+	enum respq_state state;
+
+	if (!is_cmd_chan_file(f))
+		return 0;
+
+	poll_wait(f, &chan->resp_waitq, pt);
+	state = respq_state(chan);
+	if (state != RESPQ_EMPTY)
+		mask |= POLLIN | POLLRDNORM;
+	if (state == RESPQ_DISCONNECTED)
+		mask |= POLLHUP;
+
+	return mask;
+}
+
+static const struct file_operations nnp_chan_fops = {
+	.owner = THIS_MODULE,
+	.release = cmd_chan_file_release,
+	.read = cmd_chan_file_read,
+	.write = cmd_chan_file_write,
+	.poll = cmd_chan_file_poll,
+};
+
+static inline int is_cmd_chan_file(struct file *f)
+{
+	return f->f_op == &nnp_chan_fops;
+}
+
 /**
  * nnpdev_chan_create() - creates a command channel object
  * @nnpdev: the device
@@ -119,6 +374,7 @@ struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
 	kref_init(&cmd_chan->ref);
 	cmd_chan->chan_id = chan_id;
 	cmd_chan->nnpdev = nnpdev;
+	cmd_chan->fd = -1;
 	cmd_chan->get_device_events = get_device_events;
 
 	cmd_chan->nnp_user = cmd_chan->host_file->private_data;
@@ -154,6 +410,17 @@ static void nnp_chan_release(struct kref *kref)
 
 	nnp_chan_disconnect(cmd_chan);
 
+	/*
+	 * If a chan file was created (through nnp_chan_create_file),
+	 * the host_file was already put when the file has released, otherwise
+	 * we put it here.
+	 * This is because we want to release host_file once the channel file
+	 * has been closed even though the channel object may continue to exist
+	 * until the card will send a respond that it was destroyed.
+	 */
+	if (cmd_chan->fd < 0)
+		fput(cmd_chan->host_file);
+
 	nnp_user_put(cmd_chan->nnp_user);
 
 	kfree(cmd_chan->respq_buf);
@@ -170,6 +437,99 @@ void nnp_chan_put(struct nnp_chan *cmd_chan)
 	kref_put(&cmd_chan->ref, nnp_chan_release);
 }
 
+int nnp_chan_create_file(struct nnp_chan *cmd_chan)
+{
+	/*
+	 * get refcount to the channel that will drop when
+	 * the file is released.
+	 */
+	nnp_chan_get(cmd_chan);
+
+	cmd_chan->fd = anon_inode_getfd("nnpi_chan", &nnp_chan_fops, cmd_chan,
+					O_RDWR | O_CLOEXEC);
+	if (cmd_chan->fd < 0)
+		nnp_chan_put(cmd_chan);
+
+	return cmd_chan->fd;
+}
+
+/**
+ * nnp_chan_set_destroyed() - atomically mark the channel "destroyed"
+ * @chan: the cmd_chan
+ *
+ * This function sets the command channel state to "destroyed" and returns
+ * the previous destroyed state.
+ * This function should be called once the channel has been destructed on the
+ * device and a "channel destroyed" response message arrived.
+ *
+ * Return: true if the channel was already marked destroyed.
+ */
+bool nnp_chan_set_destroyed(struct nnp_chan *chan)
+{
+	bool ret;
+
+	mutex_lock(&chan->dev_mutex);
+	ret = (chan->state == NNP_CHAN_DESTROYED);
+	chan->state = NNP_CHAN_DESTROYED;
+	mutex_unlock(&chan->dev_mutex);
+
+	wake_up_all(&chan->resp_waitq);
+
+	return ret;
+}
+
+/**
+ * nnp_chan_send_destroy() - sends a "destroy channel" command to device
+ * @chan: the cmd_chan to destroy.
+ *
+ * This function sends a command to the device to destroy a command channel,
+ * The channel object remains to exist, it will be dropped only when the device
+ * send back a "channel destroyed" response message.
+ * In case the device is in critical error state, we treat it as not
+ * functional, and the function will immediately drop the channel object without
+ * sending any command and will return with success.
+ *
+ * Return: 0 on success, error value otherwise.
+ */
+int nnp_chan_send_destroy(struct nnp_chan *chan)
+{
+	u64 cmd;
+	int ret = 0;
+	bool do_put = false;
+
+	mutex_lock(&chan->dev_mutex);
+	if (chan->state == NNP_CHAN_DESTROYED || !chan->nnpdev)
+		goto done;
+
+	cmd = FIELD_PREP(NNP_H2C_OP_MASK, NNP_IPC_H2C_OP_CHANNEL_OP);
+	cmd |= FIELD_PREP(NNP_H2C_CHANNEL_OP_CHAN_ID_MASK, chan->chan_id);
+	cmd |= FIELD_PREP(NNP_H2C_CHANNEL_OP_DESTROY_MASK, 1);
+
+	chan->event_msg = 0;
+
+	/*
+	 * If card is in critical state (or was during the channel lifetime)
+	 * we destroy the channel.
+	 * otherwise, we send a destroy command to card and will destroy when
+	 * the destroy reply arrives.
+	 */
+	if (is_card_fatal_drv_event(chan_broken(chan))) {
+		chan->state = NNP_CHAN_DESTROYED;
+		do_put = true;
+		goto done;
+	}
+
+	ret = nnp_msched_queue_msg(chan->cmdq, cmd);
+
+done:
+	mutex_unlock(&chan->dev_mutex);
+	if (do_put) {
+		wake_up_all(&chan->resp_waitq);
+		nnp_chan_put(chan);
+	}
+	return ret;
+}
+
 /**
  * nnp_chan_disconnect() - disconnect the channel from the NNP-I device object
  * @cmd_chan: the command channel object
@@ -194,8 +554,10 @@ void nnp_chan_disconnect(struct nnp_chan *cmd_chan)
 	spin_lock(&nnpdev->lock);
 	hash_del(&cmd_chan->hash_node);
 	spin_unlock(&nnpdev->lock);
+	cmd_chan->state = NNP_CHAN_DESTROYED;
 	mutex_unlock(&cmd_chan->dev_mutex);
 
+	wake_up_all(&cmd_chan->resp_waitq);
 	nnp_msched_queue_sync(cmd_chan->cmdq);
 	nnp_msched_queue_destroy(cmd_chan->cmdq);
 
diff --git a/drivers/misc/intel-nnpi/cmd_chan.h b/drivers/misc/intel-nnpi/cmd_chan.h
index 2be88c6..d60abf4 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.h
+++ b/drivers/misc/intel-nnpi/cmd_chan.h
@@ -16,6 +16,16 @@
 #include "ipc_c2h_events.h"
 
 /**
+ * enum nnp_chan_state - indicate special state of a command channel
+ * @NNP_CHAN_NORMAL: channel is in normal state.
+ * @NNP_CHAN_DESTROYED: channel should be treated as no-longer-exist on card.
+ */
+enum nnp_chan_state {
+	NNP_CHAN_NORMAL = 0,
+	NNP_CHAN_DESTROYED,
+};
+
+/**
  * struct nnp_chan - structure object for user<->device communication
  * @ref: refcount for this object
  * @nnpdev: the device this channel is connected to. May be NULL after device
@@ -23,9 +33,11 @@
  * @chan_id: the ipc channel id for this channel
  * @hash_node: node to include this object in list of channels
  *             hash is in (cmd_chan_hash in nnp_device).
+ * @event_msg: ipc event response received from device during create channel
  * @card_critical_error_msg: last critical event report received from device
  * @get_device_events: true if device-level events received from card should
  *                     be sent over this channel to user.
+ * @fd: file descriptor created for the channel (implements read/write)
  * @cmdq: message queue added to msg_scheduler, for user commands to be sent
  *        to the device.
  * @host_file: reference to opened "/dev/nnpi_host" object which defines the
@@ -33,7 +45,8 @@
  * @nnp_user: the nnp_user this channel belongs to.
  *             the channel can reference host resources created by this
  *             nnp_user object.
- * @dev_mutex: protects @nnpdev
+ * @dev_mutex: protects @nnpdev and @state
+ * @state: the current state of this channel.
  * @resp_waitq: waitqueue used for waiting for response messages be available.
  * @respq: circular buffer object that receive response messages from device.
  * @respq_lock: protects @respq
@@ -46,15 +59,18 @@ struct nnp_chan {
 	struct nnp_device      *nnpdev;
 	u16                    chan_id;
 	struct hlist_node      hash_node;
+	u64                    event_msg;
 	u64                    card_critical_error_msg;
 	bool                   get_device_events;
 
+	int fd;
 	struct nnp_msched_queue    *cmdq;
 	struct file                *host_file;
 	struct nnp_user_info       *nnp_user;
 
 	struct mutex      dev_mutex;
 	wait_queue_head_t resp_waitq;
+	enum nnp_chan_state state;
 
 	struct circ_buf   respq;
 	spinlock_t        respq_lock;
@@ -73,6 +89,10 @@ struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
 void nnp_chan_put(struct nnp_chan *cmd_chan);
 void nnp_chan_disconnect(struct nnp_chan *cmd_chan);
 
+int nnp_chan_create_file(struct nnp_chan *cmd_chan);
+int nnp_chan_send_destroy(struct nnp_chan *chan);
+bool nnp_chan_set_destroyed(struct nnp_chan *chan);
+
 int nnp_chan_add_response(struct nnp_chan *cmd_chan, u64 *hw_msg, u32 size);
 
 #endif
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 1064edc..ece19c0 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -246,6 +246,47 @@ static void nnpdev_submit_device_event_to_channels(struct nnp_device *nnpdev,
 
 	if (should_wake)
 		wake_up_all(&nnpdev->waitq);
+
+	/*
+	 * On card fatal event, we consider the device dead and there is
+	 * no point communicating with it. The user will destroy the channel
+	 * and initiate a device reset to fix this.
+	 * We disconnect all channels and set each as "destroyed" since the
+	 * NNP_IPC_CHANNEL_DESTROYED response, which normally do that, will
+	 * never arrive.
+	 */
+	if (is_card_fatal_drv_event(event_code))
+		disconnect_all_channels(nnpdev);
+}
+
+static void handle_channel_destroy(struct nnp_device *nnpdev, u64 event_msg)
+{
+	struct nnp_chan *cmd_chan;
+	unsigned int chan_id;
+
+	chan_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
+	cmd_chan = nnpdev_find_channel(nnpdev, chan_id);
+	if (!cmd_chan) {
+		dev_err(nnpdev->dev,
+			"Got channel destroyed reply for not existing channel %d\n",
+			chan_id);
+		return;
+	}
+
+	/*
+	 * Channel is destroyed on device. Put the main ref of cmd_chan if it
+	 * did not already done.
+	 * There is one possible case that the channel will be already marked
+	 * as destroyed when we get here. This is when we got some card fatal
+	 * event, which caused us to flag the channel as destroyed, but later
+	 * the "destroy channel" response has arrived from the device
+	 * (unexpected).
+	 */
+	if (!nnp_chan_set_destroyed(cmd_chan))
+		nnp_chan_put(cmd_chan);
+
+	/* put against the get from find_channel */
+	nnp_chan_put(cmd_chan);
 }
 
 /*
@@ -254,6 +295,36 @@ static void nnpdev_submit_device_event_to_channels(struct nnp_device *nnpdev,
  */
 static void process_device_event(struct nnp_device *nnpdev, u64 event_msg)
 {
+	unsigned int event_code = FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, event_msg);
+	unsigned int obj_id, event_val;
+
+	if (!is_card_fatal_event(event_code)) {
+		switch (event_code) {
+		case NNP_IPC_DESTROY_CHANNEL_FAILED:
+			obj_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
+			event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, event_msg);
+			dev_err(nnpdev->dev,
+				"Channel destroyed failed channel %d val %d\n",
+				obj_id, event_val);
+			/*
+			 * We should not enter this case never as the card will
+			 * send this response only when the driver requested to
+			 * destroy a not-exist channel, which means a driver
+			 * bug.
+			 * To handle the case we continue and destroy the channel
+			 * on the host side.
+			 */
+			fallthrough;
+		case NNP_IPC_CHANNEL_DESTROYED:
+			handle_channel_destroy(nnpdev, event_msg);
+			break;
+		default:
+			dev_err(nnpdev->dev,
+				"Unknown event received - %u\n", event_code);
+			return;
+		}
+	}
+
 	/* submit the event to all channels requested to get device events */
 	nnpdev_submit_device_event_to_channels(nnpdev, event_msg);
 }
-- 
1.8.3.1

