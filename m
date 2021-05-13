Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA637F4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhEMJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:04:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:47045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhEMJDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:03:09 -0400
IronPort-SDR: zpmmEEv5hEI13iE73avYKTXBydAPVnPTzr2uXxjpp4SnblMNeuDi9trf2m0SDlp1ugh1iALjy7
 SsouWMeIIqTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032336"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032336"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:33 -0700
IronPort-SDR: MLVHCvjLgfnCNbm1pAox6Aawb6BPrDUInAqsq6rWJOnuKn6P+iAbfCvl5KD6x4CyXuIGI3mAsE
 lifgWdtLIRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928565"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:31 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 14/15] misc: nnpi: Create command channel from userspace
Date:   Thu, 13 May 2021 11:57:24 +0300
Message-Id: <20210513085725.45528-15-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a character device for each NNP-I device (/dev/nnpi%d) with
IOCTL interface. Using this character device, user-space can create a
command channel object, through which it can send and receive messages
to and from the device.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/Makefile         |   2 +-
 drivers/misc/intel-nnpi/cmd_chan.c       |  11 +
 drivers/misc/intel-nnpi/cmd_chan.h       |   1 +
 drivers/misc/intel-nnpi/device.c         |  50 ++++-
 drivers/misc/intel-nnpi/device.h         |  11 +
 drivers/misc/intel-nnpi/device_chardev.c | 348 +++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/device_chardev.h |  14 ++
 include/uapi/misc/intel_nnpi.h           |  43 ++++
 8 files changed, 478 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/intel-nnpi/device_chardev.c
 create mode 100644 drivers/misc/intel-nnpi/device_chardev.h

diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
index b3bab2a..a294cf0c 100644
--- a/drivers/misc/intel-nnpi/Makefile
+++ b/drivers/misc/intel-nnpi/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
 
 intel_nnpi-y := device.o msg_scheduler.o hostres.o host_chardev.o nnp_user.o \
-                bootimage.o cmd_chan.o
+                bootimage.o cmd_chan.o device_chardev.o
 
 intel_nnpi_pcie-y := nnp_pcie.o
 
diff --git a/drivers/misc/intel-nnpi/cmd_chan.c b/drivers/misc/intel-nnpi/cmd_chan.c
index 89ae604..0ad281a 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.c
+++ b/drivers/misc/intel-nnpi/cmd_chan.c
@@ -557,6 +557,17 @@ void nnp_chan_disconnect(struct nnp_chan *cmd_chan)
 	cmd_chan->state = NNP_CHAN_DESTROYED;
 	mutex_unlock(&cmd_chan->dev_mutex);
 
+	/*
+	 * If the channel is not in critical state,
+	 * put it in critical state and wake any user
+	 * which might wait for the device.
+	 */
+	if (!chan_drv_fatal(cmd_chan)) {
+		cmd_chan->card_critical_error_msg = FIELD_PREP(NNP_C2H_EVENT_REPORT_CODE_MASK,
+							       NNP_IPC_ERROR_CHANNEL_KILLED);
+		wake_up_all(&nnpdev->waitq);
+	}
+
 	wake_up_all(&cmd_chan->resp_waitq);
 	nnp_msched_queue_sync(cmd_chan->cmdq);
 	nnp_msched_queue_destroy(cmd_chan->cmdq);
diff --git a/drivers/misc/intel-nnpi/cmd_chan.h b/drivers/misc/intel-nnpi/cmd_chan.h
index d60abf4..3eb5c1c 100644
--- a/drivers/misc/intel-nnpi/cmd_chan.h
+++ b/drivers/misc/intel-nnpi/cmd_chan.h
@@ -80,6 +80,7 @@ struct nnp_chan {
 };
 
 #define chan_broken(chan) FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, (chan)->card_critical_error_msg)
+#define chan_drv_fatal(chan) (is_card_fatal_drv_event(chan_broken(chan)))
 
 struct nnp_chan *nnpdev_chan_create(struct nnp_device *nnpdev, int host_fd,
 				    unsigned int min_id, unsigned int max_id,
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index ece19c0..17746d2 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -13,6 +13,7 @@
 #include "bootimage.h"
 #include "cmd_chan.h"
 #include "device.h"
+#include "device_chardev.h"
 #include "host_chardev.h"
 #include "ipc_c2h_events.h"
 #include "msg_scheduler.h"
@@ -259,6 +260,22 @@ static void nnpdev_submit_device_event_to_channels(struct nnp_device *nnpdev,
 		disconnect_all_channels(nnpdev);
 }
 
+static void handle_channel_create_response(struct nnp_device *nnpdev, u64 event_msg)
+{
+	struct nnp_chan *cmd_chan;
+	unsigned int chan_id;
+
+	chan_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
+
+	cmd_chan = nnpdev_find_channel(nnpdev, chan_id);
+	if (!cmd_chan)
+		return;
+
+	cmd_chan->event_msg = event_msg;
+	nnp_chan_put(cmd_chan);
+	wake_up_all(&nnpdev->waitq);
+}
+
 static void handle_channel_destroy(struct nnp_device *nnpdev, u64 event_msg)
 {
 	struct nnp_chan *cmd_chan;
@@ -300,6 +317,10 @@ static void process_device_event(struct nnp_device *nnpdev, u64 event_msg)
 
 	if (!is_card_fatal_event(event_code)) {
 		switch (event_code) {
+		case NNP_IPC_CREATE_CHANNEL_SUCCESS:
+		case NNP_IPC_CREATE_CHANNEL_FAILED:
+			handle_channel_create_response(nnpdev, event_msg);
+			break;
 		case NNP_IPC_DESTROY_CHANNEL_FAILED:
 			obj_id = FIELD_GET(NNP_C2H_EVENT_REPORT_OBJ_ID_MASK, event_msg);
 			event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, event_msg);
@@ -796,6 +817,11 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 		goto err_wq;
 	}
 
+	/* Create the character device interface to this device */
+	ret = nnpdev_cdev_create(nnpdev);
+	if (ret)
+		goto err_sys_info;
+
 	/* set host driver state to "Not ready" */
 	nnpdev->ops->set_host_doorbell_value(nnpdev, 0);
 
@@ -805,6 +831,9 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 
 	return 0;
 
+err_sys_info:
+	dma_free_coherent(nnpdev->dev, NNP_PAGE_SIZE, nnpdev->bios_system_info,
+			  nnpdev->bios_system_info_dma_addr);
 err_wq:
 	destroy_workqueue(nnpdev->wq);
 err_cmdq:
@@ -946,6 +975,10 @@ void nnpdev_destroy(struct nnp_device *nnpdev)
 	destroy_workqueue(nnpdev->wq);
 
 	disconnect_all_channels(nnpdev);
+
+	/* destroy character device */
+	nnpdev_cdev_destroy(nnpdev);
+
 	dma_free_coherent(nnpdev->dev, NNP_PAGE_SIZE, nnpdev->bios_system_info,
 			  nnpdev->bios_system_info_dma_addr);
 
@@ -960,13 +993,28 @@ void nnpdev_destroy(struct nnp_device *nnpdev)
 
 static int __init nnp_init(void)
 {
-	return nnp_init_host_interface();
+	int ret;
+
+	ret = nnp_init_host_interface();
+	if (ret)
+		return ret;
+
+	ret = nnpdev_cdev_class_init();
+	if (ret)
+		goto err_class;
+
+	return 0;
+
+err_class:
+	nnp_release_host_interface();
+	return ret;
 }
 subsys_initcall(nnp_init);
 
 static void __exit nnp_cleanup(void)
 {
 	nnp_release_host_interface();
+	nnpdev_cdev_class_cleanup();
 	/* dev_ida is already empty here - no point calling ida_destroy */
 }
 module_exit(nnp_cleanup);
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index c37f1da..e7e66d6 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -4,8 +4,10 @@
 #ifndef _NNPDRV_DEVICE_H
 #define _NNPDRV_DEVICE_H
 
+#include <linux/cdev.h>
 #include <linux/hashtable.h>
 #include <linux/idr.h>
+#include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
@@ -53,6 +55,9 @@
 #define NNP_DEVICE_RESPONSE_FIFO_LEN    16
 #define NNP_DEVICE_RESPONSE_BUFFER_LEN  (NNP_DEVICE_RESPONSE_FIFO_LEN * 2)
 
+#define NNP_MAX_CHANNEL_ID             1023  /* has 10 bits in ipc protocol */
+#define NNP_MAX_INF_CONTEXT_CHANNEL_ID 255   /* [0, 255] are reserved for inference contexts */
+
 struct query_version_work {
 	struct work_struct work;
 	u64 chan_resp_op_size;
@@ -92,6 +97,9 @@ struct query_version_work {
  * @boot_image: boot image object used to boot the card
  * @query_version_work: work struct used to schedule processing of version
  *                      reply response message arrived from card.
+ * @cdev: cdev object of NNP-I device char dev.
+ * @chardev: character device for this device
+ * @cdev_clients: list of opened struct file to the chardev of this device.
  * @ipc_chan_resp_op_size: holds response size for each possible channel
  *                         response.
  * @ipc_chan_cmd_op_size: holds command size for each possible channel command.
@@ -130,6 +138,9 @@ struct nnp_device {
 
 	struct query_version_work query_version_work;
 
+	struct cdev      cdev;
+	struct device    *chardev;
+	struct list_head cdev_clients;
 	u8   ipc_chan_resp_op_size[NNP_IPC_NUM_USER_OPS];
 	u8   ipc_chan_cmd_op_size[NNP_IPC_NUM_USER_OPS];
 };
diff --git a/drivers/misc/intel-nnpi/device_chardev.c b/drivers/misc/intel-nnpi/device_chardev.c
new file mode 100644
index 0000000..e4bb168
--- /dev/null
+++ b/drivers/misc/intel-nnpi/device_chardev.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
+
+#include <linux/bitfield.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
+#include <uapi/misc/intel_nnpi.h>
+
+#include "cmd_chan.h"
+#include "device_chardev.h"
+#include "ipc_c2h_events.h"
+
+static dev_t       devnum;
+static struct class *class;
+
+/**
+ * struct device_client - structure for opened device char device file
+ * @node: list node to include this struct in a list of clients
+ *        (nnpdev->cdev_clients).
+ * @nnpdev: the NNP-I device associated with the opened chardev
+ * @mutex: protects @nnpdev
+ *
+ * NOTE: @nnpdev may become NULL if the underlying NNP-I device has removed.
+ *       Any ioctl request on the char device in this state will fail with
+ *       -ENODEV
+ */
+struct device_client {
+	struct list_head  node;
+	struct nnp_device *nnpdev;
+	struct mutex      mutex;
+};
+
+/* protects nnpdev->cdev_clients list (for all nnp devices) */
+static DEFINE_MUTEX(clients_mutex);
+
+#define NNPDRV_DEVICE_DEV_NAME "nnpi"
+
+static inline bool is_nnp_device_file(struct file *f);
+
+static int nnp_device_open(struct inode *inode, struct file *f)
+{
+	struct device_client *client;
+	struct nnp_device *nnpdev;
+
+	if (!is_nnp_device_file(f))
+		return -EINVAL;
+
+	if (!inode->i_cdev)
+		return -EINVAL;
+
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	nnpdev = container_of(inode->i_cdev, struct nnp_device, cdev);
+	client->nnpdev = nnpdev;
+	mutex_init(&client->mutex);
+	f->private_data = client;
+
+	mutex_lock(&clients_mutex);
+	list_add_tail(&client->node, &nnpdev->cdev_clients);
+	mutex_unlock(&clients_mutex);
+
+	return 0;
+}
+
+static void disconnect_client_locked(struct device_client *client)
+{
+	lockdep_assert_held(&clients_mutex);
+
+	mutex_lock(&client->mutex);
+	if (!client->nnpdev) {
+		mutex_unlock(&client->mutex);
+		return;
+	}
+	client->nnpdev = NULL;
+	list_del(&client->node);
+	mutex_unlock(&client->mutex);
+}
+
+static int nnp_device_release(struct inode *inode, struct file *f)
+{
+	struct device_client *client = f->private_data;
+
+	if (!is_nnp_device_file(f))
+		return -EINVAL;
+
+	mutex_lock(&clients_mutex);
+	disconnect_client_locked(client);
+	mutex_unlock(&clients_mutex);
+	kfree(client);
+	f->private_data = NULL;
+
+	return 0;
+}
+
+static int event_val_to_nnp_error(enum event_val event_val)
+{
+	switch (event_val) {
+	case NNP_IPC_NO_ERROR:
+		return 0;
+	case NNP_IPC_NO_MEMORY:
+		return -ENOMEM;
+	default:
+		return -EFAULT;
+	}
+}
+
+static int send_create_chan_req(struct nnp_device *nnpdev, struct nnp_chan *chan)
+{
+	unsigned int event_code, event_val;
+	u64 cmd;
+	int ret;
+
+	cmd = FIELD_PREP(NNP_H2C_OP_MASK, NNP_IPC_H2C_OP_CHANNEL_OP);
+	cmd |= FIELD_PREP(NNP_H2C_CHANNEL_OP_CHAN_ID_MASK, chan->chan_id);
+	cmd |= FIELD_PREP(NNP_H2C_CHANNEL_OP_UID_MASK, 0);
+	cmd |= FIELD_PREP(NNP_H2C_CHANNEL_OP_PRIV_MASK, 1);
+
+	ret = nnp_msched_queue_msg(nnpdev->cmdq, cmd);
+	if (ret < 0)
+		return NNPER_DEVICE_ERROR;
+
+	/*
+	 * wait until card has respond to the create request or fatal
+	 * card error has been detected.
+	 */
+	wait_event(nnpdev->waitq, chan->event_msg || chan_drv_fatal(chan));
+	if (!chan->event_msg)
+		return NNPER_DEVICE_ERROR;
+
+	event_code = FIELD_GET(NNP_C2H_EVENT_REPORT_CODE_MASK, chan->event_msg);
+	event_val = FIELD_GET(NNP_C2H_EVENT_REPORT_VAL_MASK, chan->event_msg);
+	if (event_code == NNP_IPC_CREATE_CHANNEL_FAILED)
+		return event_val_to_nnp_error(event_val);
+
+	return 0;
+}
+
+static long create_channel(struct device_client *cinfo, void __user *arg,
+			   unsigned int size)
+{
+	struct nnp_device *nnpdev = cinfo->nnpdev;
+	struct ioctl_nnpi_create_channel req;
+	unsigned int io_size = sizeof(req);
+	struct nnp_chan *chan;
+	long ret = 0;
+	u32 error_mask;
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
+	if (req.i_max_id < req.i_min_id ||
+	    req.i_max_id > NNP_MAX_CHANNEL_ID)
+		return -EINVAL;
+
+	/*
+	 * Do not allow create command channel if device is in
+	 * error state.
+	 * However allow new non infer context channels in case
+	 * of fatal ICE error in order to allow retrieve debug
+	 * information.
+	 */
+	error_mask = NNP_DEVICE_ERROR_MASK;
+	if (req.i_max_id > NNP_MAX_INF_CONTEXT_CHANNEL_ID)
+		error_mask &= ~(NNP_DEVICE_FATAL_ICE_ERROR);
+
+	if ((nnpdev->state & error_mask) ||
+	    !(nnpdev->state & NNP_DEVICE_CARD_DRIVER_READY) ||
+	    (req.i_max_id <= NNP_MAX_INF_CONTEXT_CHANNEL_ID &&
+	     (nnpdev->state & NNP_DEVICE_ACTIVE_MASK) !=
+	     NNP_DEVICE_ACTIVE_MASK)) {
+		req.o_errno = NNPER_DEVICE_NOT_READY;
+		goto done;
+	}
+
+	/* Validate channel protocol version */
+	if (NNP_VERSION_MAJOR(req.i_protocol_version) !=
+	    NNP_VERSION_MAJOR(nnpdev->chan_protocol_version) ||
+	    NNP_VERSION_MINOR(req.i_protocol_version) !=
+	    NNP_VERSION_MINOR(nnpdev->chan_protocol_version)) {
+		req.o_errno = NNPER_VERSIONS_MISMATCH;
+		goto done;
+	}
+
+	/* create the channel object */
+	chan = nnpdev_chan_create(nnpdev, req.i_host_fd, req.i_min_id, req.i_max_id,
+				  req.i_get_device_events);
+	if (IS_ERR(chan)) {
+		ret = PTR_ERR(chan);
+		goto done;
+	}
+
+	/* create the channel on card */
+	req.o_errno = send_create_chan_req(nnpdev, chan);
+	if (req.o_errno)
+		goto err_destroy;
+
+	req.o_channel_id = chan->chan_id;
+
+	/* Attach file descriptor to the channel object */
+	req.o_fd = nnp_chan_create_file(chan);
+
+	/* remove channel object if failed */
+	if (req.o_fd < 0) {
+		/* the channel already created on card - send a destroy request */
+		nnp_chan_send_destroy(chan);
+		ret = req.o_fd;
+	}
+
+	goto done;
+
+err_destroy:
+	/* the channel was not created on card - destroy it now */
+	if (!nnp_chan_set_destroyed(chan))
+		nnp_chan_put(chan);
+done:
+	if (!ret && copy_to_user(arg, &req, io_size))
+		return -EFAULT;
+
+	return ret;
+}
+
+static long nnp_device_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct device_client *client = f->private_data;
+	unsigned int ioc_nr, size;
+	long ret;
+
+	if (!is_nnp_device_file(f))
+		return -ENOTTY;
+
+	if (_IOC_TYPE(cmd) != 'D')
+		return -EINVAL;
+
+	mutex_lock(&client->mutex);
+	if (!client->nnpdev) {
+		mutex_unlock(&client->mutex);
+		return -ENODEV;
+	}
+
+	ioc_nr = _IOC_NR(cmd);
+	size = _IOC_SIZE(cmd);
+
+	switch (ioc_nr) {
+	case _IOC_NR(IOCTL_NNPI_DEVICE_CREATE_CHANNEL):
+		ret = create_channel(client, (void __user *)arg, size);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&client->mutex);
+
+	return ret;
+}
+
+static const struct file_operations nnp_device_fops = {
+	.owner = THIS_MODULE,
+	.open = nnp_device_open,
+	.release = nnp_device_release,
+	.unlocked_ioctl = nnp_device_ioctl,
+	.compat_ioctl = nnp_device_ioctl,
+};
+
+static inline bool is_nnp_device_file(struct file *f)
+{
+	return f->f_op == &nnp_device_fops;
+}
+
+int nnpdev_cdev_create(struct nnp_device *nnpdev)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&nnpdev->cdev_clients);
+
+	cdev_init(&nnpdev->cdev, &nnp_device_fops);
+	nnpdev->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&nnpdev->cdev, MKDEV(MAJOR(devnum), nnpdev->id), 1);
+	if (ret)
+		return ret;
+
+	nnpdev->chardev = device_create(class, NULL, MKDEV(MAJOR(devnum), nnpdev->id),
+					nnpdev, NNPI_DEVICE_DEV_FMT, nnpdev->id);
+	if (IS_ERR(nnpdev->chardev)) {
+		cdev_del(&nnpdev->cdev);
+		return PTR_ERR(nnpdev->chardev);
+	}
+
+	return 0;
+}
+
+void nnpdev_cdev_destroy(struct nnp_device *nnpdev)
+{
+	struct device_client *client, *tmp;
+
+	device_destroy(class, MKDEV(MAJOR(devnum), nnpdev->id));
+
+	/* disconnect all chardev clients from the device */
+	mutex_lock(&clients_mutex);
+	list_for_each_entry_safe(client, tmp, &nnpdev->cdev_clients, node)
+		disconnect_client_locked(client);
+	mutex_unlock(&clients_mutex);
+
+	cdev_del(&nnpdev->cdev);
+}
+
+int nnpdev_cdev_class_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&devnum, 0, NNP_MAX_DEVS,
+				  NNPDRV_DEVICE_DEV_NAME);
+	if (ret < 0)
+		return ret;
+
+	class = class_create(THIS_MODULE, NNPDRV_DEVICE_DEV_NAME);
+	if (IS_ERR(class)) {
+		ret = PTR_ERR(class);
+		unregister_chrdev_region(devnum, NNP_MAX_DEVS);
+		return ret;
+	}
+
+	return 0;
+}
+
+void nnpdev_cdev_class_cleanup(void)
+{
+	class_destroy(class);
+	unregister_chrdev_region(devnum, NNP_MAX_DEVS);
+}
+
diff --git a/drivers/misc/intel-nnpi/device_chardev.h b/drivers/misc/intel-nnpi/device_chardev.h
new file mode 100644
index 0000000..0db919d
--- /dev/null
+++ b/drivers/misc/intel-nnpi/device_chardev.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNPDRV_DEVICE_CHARDEV_H
+#define _NNPDRV_DEVICE_CHARDEV_H
+
+#include "device.h"
+
+int nnpdev_cdev_create(struct nnp_device *nnpdev);
+void nnpdev_cdev_destroy(struct nnp_device *nnpdev);
+int nnpdev_cdev_class_init(void);
+void nnpdev_cdev_class_cleanup(void);
+
+#endif
diff --git a/include/uapi/misc/intel_nnpi.h b/include/uapi/misc/intel_nnpi.h
index 5114aea..620a5d4 100644
--- a/include/uapi/misc/intel_nnpi.h
+++ b/include/uapi/misc/intel_nnpi.h
@@ -134,6 +134,49 @@ struct nnpdrv_ioctl_destroy_hostres {
 	__u32 o_errno;
 };
 
+/*
+ * ioctls for /dev/nnpi%d device
+ */
+#define NNPI_DEVICE_DEV_FMT "nnpi%u"
+
+/**
+ * IOCTL_NNPI_DEVICE_CREATE_CHANNEL:
+ *
+ * A request to create a new communication "channel" with an NNP-I device.
+ * This channel can be used to send command and receive responses from the
+ * device.
+ */
+#define IOCTL_NNPI_DEVICE_CREATE_CHANNEL      \
+	_IOWR('D', 0, struct ioctl_nnpi_create_channel)
+
+/**
+ * struct ioctl_nnpi_create_channel - IOCTL_NNPI_DEVICE_CREATE_CHANNEL payload
+ * @i_host_fd: opened file descriptor to /dev/nnpi_host
+ * @i_min_id: minimum range for channel id allocation
+ * @i_max_id: maximum range for channel id allocation
+ * @i_get_device_events: if true, device-level event responses will be
+ *            delivered to be read from the channel.
+ * @i_protocol_version: The NNP_IPC_CHAN_PROTOCOL_VERSION the user-space has
+ *                      compiled with.
+ * @o_fd: returns file-descriptor through which commands/responses can be
+ *        write/read.
+ * @o_errno: On input, must be set to 0.
+ *           On output, 0 on success, one of the NNPERR_* error codes on error.
+ * @o_channel_id: returns the unique id of the channel
+ *
+ * Argument structure for IOCTL_NNPI_DEVICE_CREATE_CHANNEL ioctl.
+ */
+struct ioctl_nnpi_create_channel {
+	__s32    i_host_fd;
+	__u32    i_min_id;
+	__u32    i_max_id;
+	__s32    i_get_device_events;
+	__u32    i_protocol_version;
+	__s32    o_fd;
+	__u32    o_errno;
+	__u16    o_channel_id;
+};
+
 /****************************************************************
  * Error code values - errors returned in o_errno fields of
  * above structures.
-- 
1.8.3.1

