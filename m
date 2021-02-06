Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E36311DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBFOpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:45:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:38616 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhBFOop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:44:45 -0500
IronPort-SDR: 9ZBtsQPp8HsFMa6HVkBBU93SiM129uX7GPLGJv2fWNXiQPrBjFf3roSJCFCwiu2d3W214tXwGn
 8KQY/4/BcKtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200566042"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="200566042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:45 -0800
IronPort-SDR: f6quneN4AubWxeXLNPZSEOpJL88t7twH+OXGV3t16yZKLKT57MzJH4lk/N94AmfguP3K4Edrnm
 MOC6lP2Fj8Ew==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="394360225"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:43 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 5/6] mei: implement client dma setup.
Date:   Sat,  6 Feb 2021 16:43:24 +0200
Message-Id: <20210206144325.25682-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206144325.25682-1-tomas.winkler@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Implement HBM message protocol to setup and tear down
DMA buffer on behalf of an client. On top there DMA
buffer allocation and its life time management.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c    | 286 +++++++++++++++++++++++++++++++++++
 drivers/misc/mei/client.h    |   8 +
 drivers/misc/mei/hbm.c       | 124 +++++++++++++++
 drivers/misc/mei/hbm.h       |   4 +-
 drivers/misc/mei/interrupt.c |  10 ++
 drivers/misc/mei/mei_dev.h   |  15 ++
 6 files changed, 446 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index d3f060dce4a6..4378a9b25848 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/mei.h>
 
@@ -2114,6 +2115,8 @@ void mei_cl_complete(struct mei_cl *cl, struct mei_cl_cb *cb)
 	case MEI_FOP_DISCONNECT:
 	case MEI_FOP_NOTIFY_STOP:
 	case MEI_FOP_NOTIFY_START:
+	case MEI_FOP_DMA_MAP:
+	case MEI_FOP_DMA_UNMAP:
 		if (waitqueue_active(&cl->wait))
 			wake_up(&cl->wait);
 
@@ -2140,3 +2143,286 @@ void mei_cl_all_disconnect(struct mei_device *dev)
 	list_for_each_entry(cl, &dev->file_list, link)
 		mei_cl_set_disconnected(cl);
 }
+
+static struct mei_cl *mei_cl_dma_map_find(struct mei_device *dev, u8 buffer_id)
+{
+	struct mei_cl *cl;
+
+	list_for_each_entry(cl, &dev->file_list, link)
+		if (cl->dma.buffer_id == buffer_id)
+			return cl;
+	return NULL;
+}
+
+/**
+ * mei_cl_irq_dma_map - send client dma map request in irq_thread context
+ *
+ * @cl: client
+ * @cb: callback block.
+ * @cmpl_list: complete list.
+ *
+ * Return: 0 on such and error otherwise.
+ */
+int mei_cl_irq_dma_map(struct mei_cl *cl, struct mei_cl_cb *cb,
+		       struct list_head *cmpl_list)
+{
+	struct mei_device *dev = cl->dev;
+	u32 msg_slots;
+	int slots;
+	int ret;
+
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_client_dma_map_request));
+	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
+
+	if ((u32)slots < msg_slots)
+		return -EMSGSIZE;
+
+	ret = mei_hbm_cl_dma_map_req(dev, cl);
+	if (ret) {
+		cl->status = ret;
+		list_move_tail(&cb->list, cmpl_list);
+		return ret;
+	}
+
+	list_move_tail(&cb->list, &dev->ctrl_rd_list);
+	return 0;
+}
+
+/**
+ * mei_cl_irq_dma_unmap - send client dma unmap request in irq_thread context
+ *
+ * @cl: client
+ * @cb: callback block.
+ * @cmpl_list: complete list.
+ *
+ * Return: 0 on such and error otherwise.
+ */
+int mei_cl_irq_dma_unmap(struct mei_cl *cl, struct mei_cl_cb *cb,
+			 struct list_head *cmpl_list)
+{
+	struct mei_device *dev = cl->dev;
+	u32 msg_slots;
+	int slots;
+	int ret;
+
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_client_dma_unmap_request));
+	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
+
+	if ((u32)slots < msg_slots)
+		return -EMSGSIZE;
+
+	ret = mei_hbm_cl_dma_unmap_req(dev, cl);
+	if (ret) {
+		cl->status = ret;
+		list_move_tail(&cb->list, cmpl_list);
+		return ret;
+	}
+
+	list_move_tail(&cb->list, &dev->ctrl_rd_list);
+	return 0;
+}
+
+static int mei_cl_dma_alloc(struct mei_cl *cl, u8 buf_id, size_t size)
+{
+	cl->dma.vaddr = dmam_alloc_coherent(cl->dev->dev, size,
+					    &cl->dma.daddr, GFP_KERNEL);
+	if (!cl->dma.vaddr)
+		return -ENOMEM;
+
+	cl->dma.buffer_id = buf_id;
+	cl->dma.size = size;
+
+	return 0;
+}
+
+static void mei_cl_dma_free(struct mei_cl *cl)
+{
+	cl->dma.buffer_id = 0;
+	dmam_free_coherent(cl->dev->dev,
+			   cl->dma.size, cl->dma.vaddr, cl->dma.daddr);
+	cl->dma.size = 0;
+	cl->dma.vaddr = NULL;
+	cl->dma.daddr = 0;
+}
+
+/**
+ * mei_cl_alloc_and_map - send client dma map request
+ *
+ * @cl: host client
+ * @fp: pointer to file structure
+ * @buffer_id: id of the mapped buffer
+ * @size: size of the buffer
+ *
+ * Locking: called under "dev->device_lock" lock
+ *
+ * Return:
+ * * -ENODEV
+ * * -EINVAL
+ * * -EOPNOTSUPP
+ * * -EPROTO
+ * * -ENOMEM;
+ */
+int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
+			     u8 buffer_id, size_t size)
+{
+	struct mei_device *dev;
+	struct mei_cl_cb *cb;
+	int rets;
+
+	if (WARN_ON(!cl || !cl->dev))
+		return -ENODEV;
+
+	dev = cl->dev;
+
+	if (!dev->hbm_f_cd_supported) {
+		cl_dbg(dev, cl, "client dma is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (buffer_id == 0)
+		return -EINVAL;
+
+	if (!mei_cl_is_connected(cl))
+		return -ENODEV;
+
+	if (cl->dma_mapped)
+		return -EPROTO;
+
+	if (mei_cl_dma_map_find(dev, buffer_id)) {
+		cl_dbg(dev, cl, "client dma with id %d is already allocated\n",
+		       cl->dma.buffer_id);
+		return -EPROTO;
+	}
+
+	rets = pm_runtime_get(dev->dev);
+	if (rets < 0 && rets != -EINPROGRESS) {
+		pm_runtime_put_noidle(dev->dev);
+		cl_err(dev, cl, "rpm: get failed %d\n", rets);
+		return rets;
+	}
+
+	rets = mei_cl_dma_alloc(cl, buffer_id, size);
+	if (rets) {
+		pm_runtime_put_noidle(dev->dev);
+		return rets;
+	}
+
+	cb = mei_cl_enqueue_ctrl_wr_cb(cl, 0, MEI_FOP_DMA_MAP, fp);
+	if (!cb) {
+		rets = -ENOMEM;
+		goto out;
+	}
+
+	if (mei_hbuf_acquire(dev)) {
+		if (mei_hbm_cl_dma_map_req(dev, cl)) {
+			rets = -ENODEV;
+			goto out;
+		}
+		list_move_tail(&cb->list, &dev->ctrl_rd_list);
+	}
+
+	mutex_unlock(&dev->device_lock);
+	wait_event_timeout(cl->wait,
+			   cl->dma_mapped ||
+			   cl->status ||
+			   !mei_cl_is_connected(cl),
+			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+	mutex_lock(&dev->device_lock);
+
+	if (!cl->dma_mapped && !cl->status)
+		cl->status = -EFAULT;
+
+	rets = cl->status;
+
+out:
+	if (rets)
+		mei_cl_dma_free(cl);
+
+	cl_dbg(dev, cl, "rpm: autosuspend\n");
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	mei_io_cb_free(cb);
+	return rets;
+}
+
+/**
+ * mei_cl_unmap_and_free - send client dma unmap request
+ *
+ * @cl: host client
+ * @fp: pointer to file structure
+ *
+ * Locking: called under "dev->device_lock" lock
+ *
+ * Return: 0 on such and error otherwise.
+ */
+int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
+{
+	struct mei_device *dev;
+	struct mei_cl_cb *cb;
+	int rets;
+
+	if (WARN_ON(!cl || !cl->dev))
+		return -ENODEV;
+
+	dev = cl->dev;
+
+	if (!dev->hbm_f_cd_supported) {
+		cl_dbg(dev, cl, "client dma is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!mei_cl_is_connected(cl))
+		return -ENODEV;
+
+	if (!cl->dma_mapped)
+		return -EPROTO;
+
+	rets = pm_runtime_get(dev->dev);
+	if (rets < 0 && rets != -EINPROGRESS) {
+		pm_runtime_put_noidle(dev->dev);
+		cl_err(dev, cl, "rpm: get failed %d\n", rets);
+		return rets;
+	}
+
+	cb = mei_cl_enqueue_ctrl_wr_cb(cl, 0, MEI_FOP_DMA_UNMAP, fp);
+	if (!cb) {
+		rets = -ENOMEM;
+		goto out;
+	}
+
+	if (mei_hbuf_acquire(dev)) {
+		if (mei_hbm_cl_dma_unmap_req(dev, cl)) {
+			rets = -ENODEV;
+			goto out;
+		}
+		list_move_tail(&cb->list, &dev->ctrl_rd_list);
+	}
+
+	mutex_unlock(&dev->device_lock);
+	wait_event_timeout(cl->wait,
+			   !cl->dma_mapped ||
+			   cl->status ||
+			   !mei_cl_is_connected(cl),
+			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+	mutex_lock(&dev->device_lock);
+
+	if (cl->dma_mapped && !cl->status)
+		cl->status = -EFAULT;
+
+	rets = cl->status;
+
+	if (!rets)
+		mei_cl_dma_free(cl);
+out:
+	cl_dbg(dev, cl, "rpm: autosuspend\n");
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	mei_io_cb_free(cb);
+	return rets;
+}
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 9e08a9843bba..b12cdcde9436 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -265,6 +265,14 @@ void mei_cl_notify(struct mei_cl *cl);
 
 void mei_cl_all_disconnect(struct mei_device *dev);
 
+int mei_cl_irq_dma_map(struct mei_cl *cl, struct mei_cl_cb *cb,
+		       struct list_head *cmpl_list);
+int mei_cl_irq_dma_unmap(struct mei_cl *cl, struct mei_cl_cb *cb,
+			 struct list_head *cmpl_list);
+int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
+			     u8 buffer_id, size_t size);
+int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp);
+
 #define MEI_CL_FMT "cl:host=%02d me=%02d "
 #define MEI_CL_PRM(cl) (cl)->host_client_id, mei_cl_me_id(cl)
 
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 6e748da7e55d..d0277c7fed10 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -594,6 +594,117 @@ static void mei_hbm_cl_notify(struct mei_device *dev,
 		mei_cl_notify(cl);
 }
 
+/**
+ * mei_hbm_cl_dma_map_req - send client dma map request
+ *
+ * @dev: the device structure
+ * @cl: mei host client
+ *
+ * Return: 0 on success and -EIO on write failure
+ */
+int mei_hbm_cl_dma_map_req(struct mei_device *dev, struct mei_cl *cl)
+{
+	struct mei_msg_hdr mei_hdr;
+	struct hbm_client_dma_map_request req;
+	int ret;
+
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
+
+	memset(&req, 0, sizeof(req));
+
+	req.hbm_cmd = MEI_HBM_CLIENT_DMA_MAP_REQ_CMD;
+	req.client_buffer_id = cl->dma.buffer_id;
+	req.address_lsb = lower_32_bits(cl->dma.daddr);
+	req.address_msb = upper_32_bits(cl->dma.daddr);
+	req.size = cl->dma.size;
+
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
+	if (ret)
+		dev_err(dev->dev, "dma map request failed: ret = %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * mei_hbm_cl_dma_unmap_req - send client dma unmap request
+ *
+ * @dev: the device structure
+ * @cl: mei host client
+ *
+ * Return: 0 on success and -EIO on write failure
+ */
+int mei_hbm_cl_dma_unmap_req(struct mei_device *dev, struct mei_cl *cl)
+{
+	struct mei_msg_hdr mei_hdr;
+	struct hbm_client_dma_unmap_request req;
+	int ret;
+
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
+
+	memset(&req, 0, sizeof(req));
+
+	req.hbm_cmd = MEI_HBM_CLIENT_DMA_UNMAP_REQ_CMD;
+	req.client_buffer_id = cl->dma.buffer_id;
+
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
+	if (ret)
+		dev_err(dev->dev, "dma unmap request failed: ret = %d\n", ret);
+
+	return ret;
+}
+
+static void mei_hbm_cl_dma_map_res(struct mei_device *dev,
+				   struct hbm_client_dma_response *res)
+{
+	struct mei_cl *cl;
+	struct mei_cl_cb *cb, *next;
+
+	cl = NULL;
+	list_for_each_entry_safe(cb, next, &dev->ctrl_rd_list, list) {
+		if (cb->fop_type != MEI_FOP_DMA_MAP)
+			continue;
+		if (!cb->cl->dma.buffer_id || cb->cl->dma_mapped)
+			continue;
+
+		cl = cb->cl;
+		break;
+	}
+	if (!cl)
+		return;
+
+	dev_dbg(dev->dev, "cl dma map result = %d\n", res->status);
+	cl->status = res->status;
+	if (!cl->status)
+		cl->dma_mapped = 1;
+	wake_up(&cl->wait);
+}
+
+static void mei_hbm_cl_dma_unmap_res(struct mei_device *dev,
+				     struct hbm_client_dma_response *res)
+{
+	struct mei_cl *cl;
+	struct mei_cl_cb *cb, *next;
+
+	cl = NULL;
+	list_for_each_entry_safe(cb, next, &dev->ctrl_rd_list, list) {
+		if (cb->fop_type != MEI_FOP_DMA_UNMAP)
+			continue;
+		if (!cb->cl->dma.buffer_id || !cb->cl->dma_mapped)
+			continue;
+
+		cl = cb->cl;
+		break;
+	}
+	if (!cl)
+		return;
+
+	dev_dbg(dev->dev, "cl dma unmap result = %d\n", res->status);
+	cl->status = res->status;
+	if (!cl->status)
+		cl->dma_mapped = 0;
+	wake_up(&cl->wait);
+}
+
 /**
  * mei_hbm_prop_req - request property for a single client
  *
@@ -1133,6 +1244,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 	struct mei_hbm_cl_cmd *cl_cmd;
 	struct hbm_client_connect_request *disconnect_req;
 	struct hbm_flow_control *fctrl;
+	struct hbm_client_dma_response *client_dma_res;
 
 	/* read the message to our buffer */
 	BUG_ON(hdr->length >= sizeof(dev->rd_msg_buf));
@@ -1459,6 +1571,18 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		mei_hbm_cl_notify(dev, cl_cmd);
 		break;
 
+	case MEI_HBM_CLIENT_DMA_MAP_RES_CMD:
+		dev_dbg(dev->dev, "hbm: client dma map response: message received.\n");
+		client_dma_res = (struct hbm_client_dma_response *)mei_msg;
+		mei_hbm_cl_dma_map_res(dev, client_dma_res);
+		break;
+
+	case MEI_HBM_CLIENT_DMA_UNMAP_RES_CMD:
+		dev_dbg(dev->dev, "hbm: client dma unmap response: message received.\n");
+		client_dma_res = (struct hbm_client_dma_response *)mei_msg;
+		mei_hbm_cl_dma_unmap_res(dev, client_dma_res);
+		break;
+
 	default:
 		WARN(1, "hbm: wrong command %d\n", mei_msg->hbm_cmd);
 		return -EPROTO;
diff --git a/drivers/misc/mei/hbm.h b/drivers/misc/mei/hbm.h
index 4d95e38e4ddf..cd5b08ca34b6 100644
--- a/drivers/misc/mei/hbm.h
+++ b/drivers/misc/mei/hbm.h
@@ -10,6 +10,7 @@
 struct mei_device;
 struct mei_msg_hdr;
 struct mei_cl;
+struct mei_dma_data;
 
 /**
  * enum mei_hbm_state - host bus message protocol state
@@ -51,6 +52,7 @@ int mei_hbm_pg(struct mei_device *dev, u8 pg_cmd);
 void mei_hbm_pg_resume(struct mei_device *dev);
 int mei_hbm_cl_notify_req(struct mei_device *dev,
 			  struct mei_cl *cl, u8 request);
-
+int mei_hbm_cl_dma_map_req(struct mei_device *dev, struct mei_cl *cl);
+int mei_hbm_cl_dma_unmap_req(struct mei_device *dev, struct mei_cl *cl);
 #endif /* _MEI_HBM_H_ */
 
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 2161c1234ad7..a98f6b895af7 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -547,6 +547,16 @@ int mei_irq_write_handler(struct mei_device *dev, struct list_head *cmpl_list)
 			if (ret)
 				return ret;
 			break;
+		case MEI_FOP_DMA_MAP:
+			ret = mei_cl_irq_dma_map(cl, cb, cmpl_list);
+			if (ret)
+				return ret;
+			break;
+		case MEI_FOP_DMA_UNMAP:
+			ret = mei_cl_irq_dma_unmap(cl, cb, cmpl_list);
+			if (ret)
+				return ret;
+			break;
 		default:
 			BUG();
 		}
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 8ebd32cb2075..b7b6ef344e80 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -79,6 +79,8 @@ enum mei_file_transaction_states {
  * @MEI_FOP_DISCONNECT_RSP: disconnect response
  * @MEI_FOP_NOTIFY_START:   start notification
  * @MEI_FOP_NOTIFY_STOP:    stop notification
+ * @MEI_FOP_DMA_MAP:   request client dma map
+ * @MEI_FOP_DMA_UNMAP: request client dma unmap
  */
 enum mei_cb_file_ops {
 	MEI_FOP_READ = 0,
@@ -88,6 +90,8 @@ enum mei_cb_file_ops {
 	MEI_FOP_DISCONNECT_RSP,
 	MEI_FOP_NOTIFY_START,
 	MEI_FOP_NOTIFY_STOP,
+	MEI_FOP_DMA_MAP,
+	MEI_FOP_DMA_UNMAP,
 };
 
 /**
@@ -113,6 +117,13 @@ struct mei_msg_data {
 	unsigned char *data;
 };
 
+struct mei_dma_data {
+	u8 buffer_id;
+	void *vaddr;
+	dma_addr_t daddr;
+	size_t size;
+};
+
 /**
  * struct mei_dma_dscr - dma address descriptor
  *
@@ -236,6 +247,8 @@ struct mei_cl_vtag {
  * @rd_pending: pending read credits
  * @rd_completed_lock: protects rd_completed queue
  * @rd_completed: completed read
+ * @dma: dma settings
+ * @dma_mapped: dma buffer is currently mapped.
  *
  * @cldev: device on the mei client bus
  */
@@ -263,6 +276,8 @@ struct mei_cl {
 	struct list_head rd_pending;
 	spinlock_t rd_completed_lock; /* protects rd_completed queue */
 	struct list_head rd_completed;
+	struct mei_dma_data dma;
+	u8 dma_mapped;
 
 	struct mei_cl_device *cldev;
 };
-- 
2.26.2

