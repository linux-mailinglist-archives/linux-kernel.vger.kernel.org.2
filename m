Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3D937F4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhEMJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:04:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:47046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232443AbhEMJDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:03:33 -0400
IronPort-SDR: r0pjC+A1uLfhfNpNCpGAaZfWk0XiwA94+QqeadCnKG47SPzLx5mSx5HoHesyNXm/nYLfrnTKKp
 zcYtV2nYjIKA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032342"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032342"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:36 -0700
IronPort-SDR: wrcMVRT1+f3rytJwAiCnc1pVBAu/u+M1cKEt4ah/RYI3zojt0LXnSdwr0WuJ9oLa44jlAugQ00
 axtjOKJACIVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928619"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:33 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 15/15] misc: nnpi: Map host resources to device channel
Date:   Thu, 13 May 2021 11:57:25 +0300
Message-Id: <20210513085725.45528-16-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an IOCTL interface for mapping and unmapping host resources to a
channel, through the device's /dev/nnpi%d char device. The mapping gets a
uniqueue ID and the page list of the host resource is transferred to the
device. Later, commands to the device can reference the resource by the
channel ID and map ID.

There is a special interface to map host resources which serve as
host-to-card and card-to-host ring buffers. These ring buffers can be
referenced later by the ring-buffer direction and index, rather than by
a map ID.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/cmd_chan.c       | 103 ++++++++
 drivers/misc/intel-nnpi/cmd_chan.h       |  37 ++-
 drivers/misc/intel-nnpi/device.c         |  58 +++-
 drivers/misc/intel-nnpi/device_chardev.c | 441 +++++++++++++++++++++++++++++++
 include/uapi/misc/intel_nnpi.h           | 111 ++++++++
 5 files changed, 748 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/intel-nnpi/cmd_chan.c b/drivers/misc/intel-nnpi/cmd_chan.c
index 0ad281a..d98d02b 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.c
+++ b/drivers/misc/intel-nnpi/cmd_chan.c
@@ -383,6 +383,9 @@ struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
 	init_waitqueue_head(&cmd_chan->resp_waitq);
 	mutex_init(&cmd_chan->dev_mutex);
 
+	ida_init(&cmd_chan->hostres_map_ida);
+	hash_init(cmd_chan->hostres_hash);
+
 	/*
 	 * Add channel to the channel hash
 	 */
@@ -411,6 +414,11 @@ static void nnp_chan_release(struct kref *kref)
 	nnp_chan_disconnect(cmd_chan);
 
 	/*
+	 * cmd_chan->hostres_map_ida is empty at this point,
+	 * calling ida_destroy is not needed
+	 */
+
+	/*
 	 * If a chan file was created (through nnp_chan_create_file),
 	 * the host_file was already put when the file has released, otherwise
 	 * we put it here.
@@ -542,6 +550,9 @@ int nnp_chan_send_destroy(struct nnp_chan *chan)
 void nnp_chan_disconnect(struct nnp_chan *cmd_chan)
 {
 	struct nnp_device *nnpdev;
+	struct chan_hostres_map *hostres_map;
+	struct hlist_node *tmp;
+	int i;
 
 	mutex_lock(&cmd_chan->dev_mutex);
 	if (!cmd_chan->nnpdev) {
@@ -573,6 +584,32 @@ void nnp_chan_disconnect(struct nnp_chan *cmd_chan)
 	nnp_msched_queue_destroy(cmd_chan->cmdq);
 
 	ida_simple_remove(&nnpdev->cmd_chan_ida, cmd_chan->chan_id);
+
+	/*
+	 * Unmap ring buffers
+	 */
+	for (i = 0; i < NNP_IPC_MAX_CHANNEL_RB; i++) {
+		if (cmd_chan->h2c_rb_hostres_map[i]) {
+			nnp_hostres_unmap_device(cmd_chan->h2c_rb_hostres_map[i]);
+			cmd_chan->h2c_rb_hostres_map[i] = NULL;
+		}
+		if (cmd_chan->c2h_rb_hostres_map[i]) {
+			nnp_hostres_unmap_device(cmd_chan->c2h_rb_hostres_map[i]);
+			cmd_chan->c2h_rb_hostres_map[i] = NULL;
+		}
+	}
+
+	/*
+	 * Destroy all host resource maps
+	 */
+	mutex_lock(&cmd_chan->dev_mutex);
+	hash_for_each_safe(cmd_chan->hostres_hash, i, tmp, hostres_map, hash_node) {
+		hash_del(&hostres_map->hash_node);
+		ida_simple_remove(&cmd_chan->hostres_map_ida, hostres_map->id);
+		nnp_hostres_unmap_device(hostres_map->hostres_map);
+		kfree(hostres_map);
+	}
+	mutex_unlock(&cmd_chan->dev_mutex);
 }
 
 static int resize_respq(struct nnp_chan *cmd_chan)
@@ -685,3 +722,69 @@ int nnp_chan_add_response(struct nnp_chan *cmd_chan, u64 *hw_msg, u32 size)
 
 	return ret;
 }
+
+int nnp_chan_set_ringbuf(struct nnp_chan *chan, bool h2c, unsigned int id,
+			 struct nnpdev_mapping *hostres_map)
+{
+	if (id >= NNP_IPC_MAX_CHANNEL_RB)
+		return -EINVAL;
+
+	mutex_lock(&chan->dev_mutex);
+	if (h2c) {
+		if (chan->h2c_rb_hostres_map[id])
+			nnp_hostres_unmap_device(chan->h2c_rb_hostres_map[id]);
+		chan->h2c_rb_hostres_map[id] = hostres_map;
+	} else {
+		if (chan->c2h_rb_hostres_map[id])
+			nnp_hostres_unmap_device(chan->c2h_rb_hostres_map[id]);
+		chan->c2h_rb_hostres_map[id] = hostres_map;
+	}
+	mutex_unlock(&chan->dev_mutex);
+
+	return 0;
+}
+
+static struct chan_hostres_map *find_map(struct nnp_chan *chan, unsigned int map_id)
+{
+	struct chan_hostres_map *hostres_map;
+
+	lockdep_assert_held(&chan->dev_mutex);
+
+	hash_for_each_possible(chan->hostres_hash, hostres_map, hash_node,
+			       map_id)
+		if (hostres_map->id == map_id)
+			return hostres_map;
+
+	return NULL;
+}
+
+struct chan_hostres_map *nnp_chan_find_map(struct nnp_chan *chan, unsigned int map_id)
+{
+	struct chan_hostres_map *map;
+
+	mutex_lock(&chan->dev_mutex);
+	map = find_map(chan, map_id);
+	mutex_unlock(&chan->dev_mutex);
+
+	return map;
+}
+
+int nnp_chan_unmap_hostres(struct nnp_chan *chan, unsigned int map_id)
+{
+	struct chan_hostres_map *hostres_map;
+
+	mutex_lock(&chan->dev_mutex);
+	hostres_map = find_map(chan, map_id);
+	if (!hostres_map) {
+		mutex_unlock(&chan->dev_mutex);
+		return -ENXIO;
+	}
+	hash_del(&hostres_map->hash_node);
+	ida_simple_remove(&chan->hostres_map_ida, hostres_map->id);
+	nnp_hostres_unmap_device(hostres_map->hostres_map);
+	mutex_unlock(&chan->dev_mutex);
+
+	kfree(hostres_map);
+
+	return 0;
+}
diff --git a/drivers/misc/intel-nnpi/cmd_chan.h b/drivers/misc/intel-nnpi/cmd_chan.h
index 3eb5c1c..2913595 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.h
+++ b/drivers/misc/intel-nnpi/cmd_chan.h
@@ -19,10 +19,13 @@
  * enum nnp_chan_state - indicate special state of a command channel
  * @NNP_CHAN_NORMAL: channel is in normal state.
  * @NNP_CHAN_DESTROYED: channel should be treated as no-longer-exist on card.
+ * @NNP_CHAN_RB_OP_IN_FLIGHT: a ring-buffer create or destroy command has been
+ *                            sent to device and response did not yet arrived.
  */
 enum nnp_chan_state {
 	NNP_CHAN_NORMAL = 0,
 	NNP_CHAN_DESTROYED,
+	NNP_CHAN_RB_OP_IN_FLIGHT,
 };
 
 /**
@@ -45,14 +48,20 @@ enum nnp_chan_state {
  * @nnp_user: the nnp_user this channel belongs to.
  *             the channel can reference host resources created by this
  *             nnp_user object.
- * @dev_mutex: protects @nnpdev and @state
+ * @dev_mutex: protects @nnpdev, @state, @hostres_hash and @hostres_map_ida
  * @state: the current state of this channel.
+ * @hostres_map_ida: generate ipc ids for hostres mapping
+ * @hostres_hash: hash table to store all host resource mapping, key is ipc id
  * @resp_waitq: waitqueue used for waiting for response messages be available.
  * @respq: circular buffer object that receive response messages from device.
  * @respq_lock: protects @respq
  * @respq_buf: buffer space allocated for circular response buffer.
  * @respq_size: current allocated size of circular response buffer.
  * @resp_lost: number of response messages lost due to response buffer full.
+ * @h2c_rb_hostres_map: host resource mapping used for each host-to-card ring buffer
+ *                  There may be up to 2 such ring buffers, both can be NULL.
+ * @c2h_rb_hostres_map: host resource mapping used for each card-to-host ring buffer
+ *                  There may be up to 2 such ring buffers, both can be NULL.
  */
 struct nnp_chan {
 	struct kref            ref;
@@ -72,11 +81,32 @@ struct nnp_chan {
 	wait_queue_head_t resp_waitq;
 	enum nnp_chan_state state;
 
+	struct ida        hostres_map_ida;
+	DECLARE_HASHTABLE(hostres_hash, 6);
+
 	struct circ_buf   respq;
 	spinlock_t        respq_lock;
 	char              *respq_buf;
 	unsigned int      respq_size;
 	unsigned int      resp_lost;
+
+	struct nnpdev_mapping *h2c_rb_hostres_map[NNP_IPC_MAX_CHANNEL_RB];
+	struct nnpdev_mapping *c2h_rb_hostres_map[NNP_IPC_MAX_CHANNEL_RB];
+};
+
+/**
+ * struct chan_hostres_map - holds host resource mapping to channel
+ *
+ * @id: ipc map id of the mapping
+ * @hash_node: node to include this mapping in @hostres_hash of nnpdrv_cmd_chan
+ * @hostres_map: the host resource mapping object
+ * @event_msg: device response to the map create request
+ */
+struct chan_hostres_map {
+	unsigned int           id;
+	struct hlist_node      hash_node;
+	struct nnpdev_mapping  *hostres_map;
+	u64                    event_msg;
 };
 
 #define chan_broken(chan) FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, (chan)->card_critical_error_msg)
@@ -96,4 +126,9 @@ struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
 
 int nnp_chan_add_response(struct nnp_chan *cmd_chan, u64 *hw_msg, u32 size);
 
+int nnp_chan_set_ringbuf(struct nnp_chan *chan, bool h2c, unsigned int id,
+			 struct nnpdev_mapping *hostres_map);
+
+struct chan_hostres_map *nnp_chan_find_map(struct nnp_chan *chan, unsigned int map_id);
+int nnp_chan_unmap_hostres(struct nnp_chan *chan, unsigned int map_id);
 #endif
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 17746d2..69ff555 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -276,6 +276,45 @@ static void handle_channel_create_response(struct nnp_device *nnpdev, u64 event_
 	wake_up_all(&nnpdev->waitq);
 }
 
+static void handle_channel_map_hostres(struct nnp_device *nnpdev, u64 event_msg)
+{
+	struct chan_hostres_map *hostres_map;
+	unsigned int chan_id, map_id;
+	struct nnp_chan *cmd_chan;
+
+	chan_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
+	cmd_chan = nnpdev_find_channel(nnpdev, chan_id);
+	if (!cmd_chan)
+		return;
+
+	map_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID2_MASK, event_msg);
+	hostres_map = nnp_chan_find_map(cmd_chan, map_id);
+	if (!hostres_map)
+		goto put_chan;
+
+	hostres_map->event_msg = event_msg;
+	wake_up_all(&nnpdev->waitq);
+
+put_chan:
+	nnp_chan_put(cmd_chan);
+}
+
+static void handle_channel_unmap_hostres(struct nnp_device *nnpdev, u64 event_msg)
+{
+	unsigned int chan_id, map_id;
+	struct nnp_chan *cmd_chan;
+
+	chan_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
+	cmd_chan = nnpdev_find_channel(nnpdev, chan_id);
+	if (!cmd_chan)
+		return;
+
+	map_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID2_MASK, event_msg);
+	nnp_chan_unmap_hostres(cmd_chan, map_id);
+
+	nnp_chan_put(cmd_chan);
+}
+
 static void handle_channel_destroy(struct nnp_device *nnpdev, u64 event_msg)
 {
 	struct nnp_chan *cmd_chan;
@@ -313,14 +352,20 @@ static void handle_channel_destroy(struct nnp_device *nnpdev, u64 event_msg)
 static void process_device_event(struct nnp_device *nnpdev, u64 event_msg)
 {
 	unsigned int event_code = FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, event_msg);
-	unsigned int obj_id, event_val;
+	unsigned int obj_id, event_val, obj_id_2;
 
 	if (!is_card_fatal_event(event_code)) {
 		switch (event_code) {
 		case NNP_IPC_CREATE_CHANNEL_SUCCESS:
 		case NNP_IPC_CREATE_CHANNEL_FAILED:
+		case NNP_IPC_CHANNEL_SET_RB_SUCCESS:
+		case NNP_IPC_CHANNEL_SET_RB_FAILED:
 			handle_channel_create_response(nnpdev, event_msg);
 			break;
+		case NNP_IPC_CHANNEL_MAP_HOSTRES_SUCCESS:
+		case NNP_IPC_CHANNEL_MAP_HOSTRES_FAILED:
+			handle_channel_map_hostres(nnpdev, event_msg);
+			break;
 		case NNP_IPC_DESTROY_CHANNEL_FAILED:
 			obj_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
 			event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, event_msg);
@@ -339,6 +384,17 @@ static void process_device_event(struct nnp_device *nnpdev, u64 event_msg)
 		case NNP_IPC_CHANNEL_DESTROYED:
 			handle_channel_destroy(nnpdev, event_msg);
 			break;
+		case NNP_IPC_CHANNEL_UNMAP_HOSTRES_FAILED:
+			obj_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
+			obj_id_2 = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID2_MASK, event_msg);
+			event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, event_msg);
+			dev_dbg(nnpdev->dev,
+				"Channel hostres unmap failed on device channel %d map %d val %d\n",
+				obj_id, obj_id_2, event_val);
+			fallthrough;
+		case NNP_IPC_CHANNEL_UNMAP_HOSTRES_SUCCESS:
+			handle_channel_unmap_hostres(nnpdev, event_msg);
+			break;
 		default:
 			dev_err(nnpdev->dev,
 				"Unknown event received - %u\n", event_code);
diff --git a/drivers/misc/intel-nnpi/device_chardev.c b/drivers/misc/intel-nnpi/device_chardev.c
index e4bb168..623352d 100644
--- a/drivers/misc/intel-nnpi/device_chardev.c
+++ b/drivers/misc/intel-nnpi/device_chardev.c
@@ -7,6 +7,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kref.h>
+#include <linux/dma-map-ops.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
@@ -15,6 +16,7 @@
 
 #include "cmd_chan.h"
 #include "device_chardev.h"
+#include "nnp_user.h"
 #include "ipc_c2h_events.h"
 
 static dev_t       devnum;
@@ -236,6 +238,431 @@ static long create_channel(struct device_client *cinfo, void __user *arg,
 	return ret;
 }
 
+/**
+ * send_rb_op() - sends CHANNEL_RB_OP command and wait for reply
+ * @chan: the command channel
+ * @rb_op_cmd: the command to send
+ * @o_errno: returns zero or error code from device
+ *
+ * The function sends a "ring buffer operation" command to the device
+ * to either create or destroy a ring buffer object.
+ * This is a synchronous operation, the function will wait until a response
+ * from the device has arrived.
+ * If some other synchronous ring buffer operation is already in progress on
+ * the same channel, the function will fail.
+ *
+ * Return:
+ * * -EBUSY: Ring-buffer create/destroy operation is already in-flight.
+ * * -EPIPE: The channel is in critical error state or sending the command
+ *           has failed.
+ * * 0: The command has sent successfully, the operation status is updated
+ *      in o_errno, if o_errno is zero, then the create/destoy operation has
+ *      succeeded, otherwise it indicates an error code received from
+ *      device.
+ */
+static int send_rb_op(struct nnp_chan *chan, u64 rb_op_cmd, __u32 *o_errno)
+{
+	struct nnp_device *nnpdev = chan->nnpdev;
+	unsigned int event_code, event_val;
+	int ret = -EPIPE;
+
+	*o_errno = 0;
+
+	mutex_lock(&chan->dev_mutex);
+	if (chan->state == NNP_CHAN_RB_OP_IN_FLIGHT) {
+		mutex_unlock(&chan->dev_mutex);
+		return -EBUSY;
+	} else if (chan->state == NNP_CHAN_DESTROYED) {
+		mutex_unlock(&chan->dev_mutex);
+		*o_errno = NNPER_DEVICE_ERROR;
+		return 0;
+	}
+	chan->state = NNP_CHAN_RB_OP_IN_FLIGHT;
+	mutex_unlock(&chan->dev_mutex);
+
+	chan->event_msg = 0;
+
+	/* send the command to card */
+	if (!chan_drv_fatal(chan))
+		ret = nnp_msched_queue_msg(nnpdev->cmdq, rb_op_cmd);
+
+	if (ret < 0)
+		goto done;
+
+	/* wait until card respond or card critical error is detected */
+	wait_event(nnpdev->waitq, chan->event_msg || chan_drv_fatal(chan));
+	if (!chan->event_msg) {
+		*o_errno = NNPER_DEVICE_ERROR;
+		ret = 0;
+		goto done;
+	}
+
+	event_code = FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, chan->event_msg);
+	if (event_code == NNP_IPC_CHANNEL_SET_RB_FAILED) {
+		event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, chan->event_msg);
+		*o_errno = event_val_to_nnp_error(event_val);
+		ret = 0;
+	}
+
+done:
+	mutex_lock(&chan->dev_mutex);
+	if (chan->state == NNP_CHAN_RB_OP_IN_FLIGHT)
+		chan->state = NNP_CHAN_NORMAL;
+	mutex_unlock(&chan->dev_mutex);
+	return ret;
+}
+
+static long create_channel_data_ringbuf(struct device_client *cinfo,
+					void __user *arg, unsigned int size)
+{
+	struct nnp_device *nnpdev = cinfo->nnpdev;
+	struct ioctl_nnpi_create_channel_data_ringbuf req;
+	struct user_hostres *hostres_entry = NULL;
+	struct nnp_user_info *nnp_user = NULL;
+	struct nnpdev_mapping *hostres_map;
+	unsigned int io_size = sizeof(req);
+	struct host_resource *hostres;
+	struct nnp_chan *chan = NULL;
+	unsigned long dma_pfn;
+	dma_addr_t page_list;
+	u64 rb_op_cmd;
+	int ret = 0;
+
+	/* only single size structure is currently supported */
+	if (size != io_size)
+		return -EINVAL;
+
+	if (copy_from_user(&req, arg, io_size))
+		return -EFAULT;
+
+	if (req.i_id > NNP_IPC_MAX_CHANNEL_RB - 1)
+		return -EINVAL;
+
+	/* o_errno must be cleared on entry */
+	if (req.o_errno)
+		return -EINVAL;
+
+	chan = nnpdev_find_channel(nnpdev, req.i_channel_id);
+	if (!chan) {
+		req.o_errno = NNPER_NO_SUCH_CHANNEL;
+		goto done;
+	}
+
+	nnp_user = chan->nnp_user;
+	mutex_lock(&nnp_user->mutex);
+	hostres_entry = idr_find(&nnp_user->idr, req.i_hostres_handle);
+	if (!hostres_entry) {
+		req.o_errno = NNPER_NO_SUCH_RESOURCE;
+		goto unlock_user;
+	}
+
+	hostres = hostres_entry->hostres;
+
+	/* check the resource fit the direction */
+	if ((req.i_h2c && !nnp_hostres_is_input(hostres)) ||
+	    (!req.i_h2c && !nnp_hostres_is_output(hostres))) {
+		req.o_errno = NNPER_INCOMPATIBLE_RESOURCES;
+		goto unlock_user;
+	}
+
+	hostres_map = nnp_hostres_map_device(hostres, nnpdev, false, &page_list, NULL);
+	if (IS_ERR(hostres_map)) {
+		ret = -EFAULT;
+		goto unlock_user;
+	}
+
+	/*
+	 * Its OK to release the mutex here and let other
+	 * thread destroy the hostres handle as we already
+	 * mapped it (which ref counted)
+	 */
+	mutex_unlock(&nnp_user->mutex);
+
+	dma_pfn = NNP_IPC_DMA_ADDR_TO_PFN(page_list);
+	rb_op_cmd = FIELD_PREP(NNP_H2C_OP_MASK, NNP_IPC_H2C_OP_CHANNEL_RB_OP);
+	rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_CHAN_ID_MASK, chan->chan_id);
+	rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_ID_MASK, req.i_id);
+	rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_HOST_PFN_MASK, dma_pfn);
+	if (req.i_h2c)
+		rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_H2C_MASK, 1);
+
+	ret = send_rb_op(chan, rb_op_cmd, &req.o_errno);
+	if (!ret && !req.o_errno)
+		ret = nnp_chan_set_ringbuf(chan, req.i_h2c, req.i_id, hostres_map);
+
+	if (ret || req.o_errno)
+		nnp_hostres_unmap_device(hostres_map);
+
+	goto put_chan;
+
+unlock_user:
+	mutex_unlock(&nnp_user->mutex);
+put_chan:
+	nnp_chan_put(chan);
+done:
+	if (!ret && copy_to_user(arg, &req, io_size))
+		return -EFAULT;
+
+	return ret;
+}
+
+static long destroy_channel_data_ringbuf(struct device_client *cinfo,
+					 void __user *arg, unsigned int size)
+{
+	struct ioctl_nnpi_destroy_channel_data_ringbuf req;
+	struct nnp_device *nnpdev = cinfo->nnpdev;
+	unsigned int io_size = sizeof(req);
+	struct nnp_chan *chan;
+	u64 rb_op_cmd;
+	int ret = 0;
+
+	/* only single size structure is currently supported */
+	if (size != io_size)
+		return -EINVAL;
+
+	if (copy_from_user(&req, arg, io_size))
+		return -EFAULT;
+
+	/* we have one bit in ipc protocol for ringbuf id for each direction */
+	if (req.i_id > 1)
+		return -EINVAL;
+
+	/* o_errno must be cleared on entry */
+	if (req.o_errno)
+		return -EINVAL;
+
+	chan = nnpdev_find_channel(nnpdev, req.i_channel_id);
+	if (!chan) {
+		req.o_errno = NNPER_NO_SUCH_CHANNEL;
+		goto done;
+	}
+
+	rb_op_cmd = FIELD_PREP(NNP_H2C_OP_MASK, NNP_IPC_H2C_OP_CHANNEL_RB_OP);
+	rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_CHAN_ID_MASK, chan->chan_id);
+	rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_ID_MASK, req.i_id);
+	rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_DESTROY_MASK, 1);
+	if (req.i_h2c)
+		rb_op_cmd |= FIELD_PREP(NNP_H2C_CHANNEL_RB_OP_H2C_MASK, 1);
+
+	ret = send_rb_op(chan, rb_op_cmd, &req.o_errno);
+	if (ret || req.o_errno)
+		goto put_chan;
+
+	ret = nnp_chan_set_ringbuf(chan, req.i_h2c, req.i_id, NULL);
+
+put_chan:
+	nnp_chan_put(chan);
+done:
+	if (!ret && copy_to_user(arg, &req, io_size))
+		return -EFAULT;
+
+	return ret;
+}
+
+static int send_map_hostres_req(struct nnp_device *nnpdev, struct nnp_chan *chan,
+				struct chan_hostres_map *hostres_map, dma_addr_t page_list)
+{
+	unsigned int event_code, event_val;
+	unsigned long dma_pfn;
+	u64 cmd[2];
+
+	dma_pfn = NNP_IPC_DMA_ADDR_TO_PFN(page_list);
+	cmd[0] = FIELD_PREP(NNP_H2C_OP_MASK, NNP_IPC_H2C_OP_CHANNEL_HOSTRES_OP);
+	cmd[0] |= FIELD_PREP(NNP_H2C_CHANNEL_HOSTRES_QW0_CHAN_ID_MASK,
+			     chan->chan_id);
+	cmd[0] |= FIELD_PREP(NNP_H2C_CHANNEL_HOSTRES_QW0_ID_MASK, hostres_map->id);
+	cmd[1] = FIELD_PREP(NNP_H2C_CHANNEL_HOSTRES_QW1_HOST_PFN_MASK, dma_pfn);
+
+	/* do not send the map command if the device in a fatal error state */
+	if (chan_drv_fatal(chan))
+		return NNPER_DEVICE_ERROR;
+
+	/* send the hostres map command to card */
+	if (nnp_msched_queue_msg(chan->cmdq, cmd) < 0)
+		return NNPER_DEVICE_ERROR;
+
+	/* wait until card respond or card critical error is detected */
+	wait_event(nnpdev->waitq, hostres_map->event_msg || chan_drv_fatal(chan));
+
+	if (!hostres_map->event_msg)
+		return NNPER_DEVICE_ERROR;
+
+	event_code = FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, hostres_map->event_msg);
+	if (event_code == NNP_IPC_CHANNEL_MAP_HOSTRES_FAILED) {
+		event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, hostres_map->event_msg);
+		return event_val_to_nnp_error(event_val);
+	}
+
+	return 0;
+}
+
+static int do_map_hostres(struct nnp_device *nnpdev, struct nnp_chan   *chan,
+			  unsigned long     hostres_handle)
+{
+	struct chan_hostres_map *hostres_map = NULL;
+	struct user_hostres *hostres_entry = NULL;
+	struct nnp_user_info *nnp_user;
+	struct host_resource *hostres;
+	dma_addr_t page_list;
+	int map_id;
+	int err;
+
+	nnp_user = chan->nnp_user;
+	mutex_lock(&nnp_user->mutex);
+	hostres_entry = idr_find(&nnp_user->idr, hostres_handle);
+	if (!hostres_entry) {
+		err = -NNPER_NO_SUCH_RESOURCE;
+		goto unlock_user;
+	}
+	hostres = hostres_entry->hostres;
+
+	hostres_map = kzalloc(sizeof(*hostres_map), GFP_KERNEL);
+	if (!hostres_map) {
+		err = -ENOMEM;
+		goto unlock_user;
+	}
+
+	mutex_lock(&chan->dev_mutex);
+	map_id = ida_simple_get(&chan->hostres_map_ida, 0, U16_MAX, GFP_KERNEL);
+	if (map_id < 0) {
+		err = -ENOMEM;
+		goto err_map;
+	}
+
+	hostres_map->hostres_map = nnp_hostres_map_device(hostres, nnpdev,
+							  false, &page_list, NULL);
+	if (IS_ERR(hostres_map->hostres_map)) {
+		err = -EFAULT;
+		goto err_ida;
+	}
+
+	hostres_map->event_msg = 0;
+	hostres_map->id = map_id;
+
+	hash_add(chan->hostres_hash, &hostres_map->hash_node, hostres_map->id);
+	mutex_unlock(&chan->dev_mutex);
+	mutex_unlock(&nnp_user->mutex);
+
+	err = send_map_hostres_req(nnpdev, chan, hostres_map, page_list);
+	if (err) {
+		nnp_chan_unmap_hostres(chan, hostres_map->id);
+		return err;
+	}
+
+	return map_id;
+
+err_ida:
+	ida_simple_remove(&chan->hostres_map_ida, map_id);
+err_map:
+	mutex_unlock(&chan->dev_mutex);
+	kfree(hostres_map);
+unlock_user:
+	mutex_unlock(&nnp_user->mutex);
+	return err;
+}
+
+static long map_hostres(struct device_client *cinfo, void __user *arg,
+			unsigned int size)
+{
+	struct nnp_device *nnpdev = cinfo->nnpdev;
+	struct ioctl_nnpi_channel_map_hostres req;
+	unsigned int io_size = sizeof(req);
+	const struct dma_map_ops *ops;
+	struct nnp_chan *chan = NULL;
+	int ret;
+
+	/* only single size structure is currently supported */
+	if (size != io_size)
+		return -EINVAL;
+
+	if (copy_from_user(&req, arg, io_size))
+		return -EFAULT;
+
+	chan = nnpdev_find_channel(nnpdev, req.i_channel_id);
+	if (!chan) {
+		req.o_errno = NNPER_NO_SUCH_CHANNEL;
+		goto done;
+	}
+
+	ret = do_map_hostres(nnpdev, chan, req.i_hostres_handle);
+	if (ret < 0) {
+		req.o_errno = -ret;
+		goto put_chan;
+	}
+
+	req.o_errno = 0;
+	req.o_map_id = ret;
+
+	ops = get_dma_ops(nnpdev->dev);
+	if (ops)
+		req.o_sync_needed = ops->sync_sg_for_cpu ? 1 : 0;
+	else
+		req.o_sync_needed =
+			!dev_is_dma_coherent(nnpdev->dev);
+
+	goto put_chan;
+
+put_chan:
+	nnp_chan_put(chan);
+done:
+	if (copy_to_user(arg, &req, io_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long unmap_hostres(struct device_client *cinfo, void __user *arg,
+			  unsigned int size)
+{
+	struct ioctl_nnpi_channel_unmap_hostres req;
+	struct nnp_device *nnpdev = cinfo->nnpdev;
+	struct chan_hostres_map *hostres_map;
+	unsigned int io_size = sizeof(req);
+	struct nnp_chan *chan = NULL;
+	u64 cmd[2];
+	long ret = 0;
+
+	/* only single size structure is currently supported */
+	if (size != io_size)
+		return -EINVAL;
+
+	if (copy_from_user(&req, arg, io_size))
+		return -EFAULT;
+
+	/* o_errno must be cleared on entry */
+	if (req.o_errno)
+		return -EINVAL;
+
+	chan = nnpdev_find_channel(nnpdev, req.i_channel_id);
+	if (!chan) {
+		req.o_errno = NNPER_NO_SUCH_CHANNEL;
+		goto done;
+	}
+
+	hostres_map = nnp_chan_find_map(chan, req.i_map_id);
+	if (!hostres_map) {
+		req.o_errno = NNPER_NO_SUCH_HOSTRES_MAP;
+		goto put_chan;
+	}
+
+	cmd[0] = FIELD_PREP(NNP_H2C_OP_MASK, NNP_IPC_H2C_OP_CHANNEL_HOSTRES_OP);
+	cmd[0] |= FIELD_PREP(NNP_H2C_CHANNEL_HOSTRES_QW0_CHAN_ID_MASK,
+			     chan->chan_id);
+	cmd[0] |= FIELD_PREP(NNP_H2C_CHANNEL_HOSTRES_QW0_ID_MASK, req.i_map_id);
+	cmd[0] |= FIELD_PREP(NNP_H2C_CHANNEL_HOSTRES_QW0_UNMAP_MASK, 1);
+	cmd[1] = 0;
+
+	ret = nnp_msched_queue_msg(chan->cmdq, cmd);
+
+put_chan:
+	nnp_chan_put(chan);
+done:
+	if (!ret && copy_to_user(arg, &req, io_size))
+		return -EFAULT;
+
+	return ret;
+}
+
 static long nnp_device_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct device_client *client = f->private_data;
@@ -261,6 +688,20 @@ static long nnp_device_ioctl(struct file *f, unsigned int cmd, unsigned long arg
 	case _IOC_NR(IOCTL_NNPI_DEVICE_CREATE_CHANNEL):
 		ret = create_channel(client, (void __user *)arg, size);
 		break;
+	case _IOC_NR(IOCTL_NNPI_DEVICE_CREATE_CHANNEL_RB):
+		ret = create_channel_data_ringbuf(client, (void __user *)arg,
+						  size);
+		break;
+	case _IOC_NR(IOCTL_NNPI_DEVICE_DESTROY_CHANNEL_RB):
+		ret = destroy_channel_data_ringbuf(client, (void __user *)arg,
+						   size);
+		break;
+	case _IOC_NR(IOCTL_NNPI_DEVICE_CHANNEL_MAP_HOSTRES):
+		ret = map_hostres(client, (void __user *)arg, size);
+		break;
+	case _IOC_NR(IOCTL_NNPI_DEVICE_CHANNEL_UNMAP_HOSTRES):
+		ret = unmap_hostres(client, (void __user *)arg, size);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/misc/intel_nnpi.h b/include/uapi/misc/intel_nnpi.h
index 620a5d4..8d53af6 100644
--- a/include/uapi/misc/intel_nnpi.h
+++ b/include/uapi/misc/intel_nnpi.h
@@ -150,6 +150,43 @@ struct nnpdrv_ioctl_destroy_hostres {
 	_IOWR('D', 0, struct ioctl_nnpi_create_channel)
 
 /**
+ * IOCTL_NNPI_DEVICE_CREATE_CHANNEL_RB:
+ *
+ * A request to create a data ring buffer for a command channel object.
+ * This is used to transfer data together with command to the device.
+ * A device command may include a data size fields which indicate how much data
+ * has pushed into that ring-buffer object.
+ */
+#define IOCTL_NNPI_DEVICE_CREATE_CHANNEL_RB   \
+	_IOWR('D', 1, struct ioctl_nnpi_create_channel_data_ringbuf)
+
+/**
+ * IOCTL_NNPI_DEVICE_DESTROY_CHANNEL_RB:
+ *
+ * A request to destoy a data ring buffer allocated for a command channel.
+ */
+#define IOCTL_NNPI_DEVICE_DESTROY_CHANNEL_RB  \
+	_IOWR('D', 2, struct ioctl_nnpi_destroy_channel_data_ringbuf)
+
+/**
+ * IOCTL_NNPI_DEVICE_CHANNEL_MAP_HOSTRES:
+ *
+ * A request to map a host resource to a command channel object.
+ * Device commands can include "map id" of this mapping for referencing
+ * a host resource.
+ */
+#define IOCTL_NNPI_DEVICE_CHANNEL_MAP_HOSTRES \
+	_IOWR('D', 3, struct ioctl_nnpi_channel_map_hostres)
+
+/**
+ * IOCTL_NNPI_DEVICE_CHANNEL_UNMAP_HOSTRES:
+ *
+ * A request to unmap a host resource previously mapped to a command channel.
+ */
+#define IOCTL_NNPI_DEVICE_CHANNEL_UNMAP_HOSTRES \
+	_IOWR('D', 4, struct ioctl_nnpi_channel_unmap_hostres)
+
+/**
  * struct ioctl_nnpi_create_channel - IOCTL_NNPI_DEVICE_CREATE_CHANNEL payload
  * @i_host_fd: opened file descriptor to /dev/nnpi_host
  * @i_min_id: minimum range for channel id allocation
@@ -177,6 +214,80 @@ struct ioctl_nnpi_create_channel {
 	__u16    o_channel_id;
 };
 
+/**
+ * struct ioctl_nnpi_create_channel_data_ringbuf
+ * @i_hostres_handle: handle of a host resource which will be used to hold
+ *         the ring-buffer content.
+ * @i_channel_id: command channel id.
+ * @i_id: id of the ring buffer object (can be 0 or 1).
+ * @i_h2c: non-zero if this ring-buffer is for command submission use,
+ *         otherwise it is for responses.
+ * @o_errno: On input, must be set to 0.
+ *           On output, 0 on success, one of the NNPERR_* error codes on error.
+ *
+ * this is the payload for IOCTL_NNPI_DEVICE_CREATE_CHANNEL_RB ioctl
+ */
+struct ioctl_nnpi_create_channel_data_ringbuf {
+	__s32 i_hostres_handle;
+	__u32 i_channel_id;
+	__u32 i_id;
+	__u32 i_h2c;
+	__u32 o_errno;
+};
+
+/**
+ * struct ioctl_nnpi_destroy_channel_data_ringbuf
+ * @i_channel_id: command channel id.
+ * @i_id: id of the ring buffer object (can be 0 or 1).
+ * @i_h2c: true if this ring-buffer is for command submission use,
+ *         otherwise it is for responses.
+ * @o_errno: On input, must be set to 0.
+ *           On output, 0 on success, one of the NNPERR_* error codes on error.
+ *
+ * this is the payload for IOCTL_NNPI_DEVICE_DESTROY_CHANNEL_RB ioctl
+ */
+struct ioctl_nnpi_destroy_channel_data_ringbuf {
+	__u32 i_channel_id;
+	__u32 i_id;
+	__u32 i_h2c;
+	__u32 o_errno;
+};
+
+/**
+ * struct ioctl_nnpi_channel_map_hostres
+ * @i_hostres_handle: handle of a host resource to be mapped
+ * @i_channel_id: command channel id.
+ * @o_map_id: returns unique id of the mapping
+ * @o_sync_needed: returns non-zero if LOCK/UNLOCK_HOST_RESOURCE ioctls
+ *            needs to be used before/after accessing the resource from cpu.
+ * @o_errno: On input, must be set to 0.
+ *           On output, 0 on success, one of the NNPERR_* error codes on error.
+ *
+ * this is the payload for IOCTL_NNPI_DEVICE_CHANNEL_MAP_HOSTRES ioctl
+ */
+struct ioctl_nnpi_channel_map_hostres {
+	__s32 i_hostres_handle;
+	__u32 i_channel_id;
+	__u32 o_map_id;
+	__u32 o_sync_needed;
+	__u32 o_errno;
+};
+
+/**
+ * ioctl_nnpi_channel_unmap_hostres
+ * @i_channel_id: command channel id.
+ * @i_map_id: mapping id
+ * @o_errno: On input, must be set to 0.
+ *           On output, 0 on success, one of the NNPERR_* error codes on error.
+ *
+ * This is the payload for IOCTL_NNPI_DEVICE_CHANNEL_UNMAP_HOSTRES ioctl
+ */
+struct ioctl_nnpi_channel_unmap_hostres {
+	__u32 i_channel_id;
+	__u32 i_map_id;
+	__u32 o_errno;
+};
+
 /****************************************************************
  * Error code values - errors returned in o_errno fields of
  * above structures.
-- 
1.8.3.1

