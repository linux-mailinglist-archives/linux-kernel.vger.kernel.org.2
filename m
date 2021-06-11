Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4428B3A474E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFKRDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:03:38 -0400
Received: from foss.arm.com ([217.140.110.172]:35826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhFKRDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 646D9D6E;
        Fri, 11 Jun 2021 10:01:19 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE5B3F719;
        Fri, 11 Jun 2021 10:01:15 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v4 15/16] [RFC][REWORK] firmware: arm_scmi: make virtio-scmi use delegated xfers
Date:   Fri, 11 Jun 2021 17:59:36 +0100
Message-Id: <20210611165937.701-16-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Draft changes to virtio-scmi to use new support for core delegated xfers
in an attempt to simplify the interactions between virtio-scmi transport
and the SCMI core transport layer.

TODO:
 - Polling is still not supported.
 - Probe/remove sequence still to be reviewed.
 - Concurrent or inverted reception of related responses and delayed
   responses is still not addressed.
   (it will be addressed in the SCMI core anyway most probably)

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |   5 +
 drivers/firmware/arm_scmi/msg.c    |  35 +++++
 drivers/firmware/arm_scmi/virtio.c | 212 +++++++++++++++--------------
 3 files changed, 152 insertions(+), 100 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c143a449d278..22e5532fc698 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -428,6 +428,11 @@ void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
 void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
 			    size_t max_len, struct scmi_xfer *xfer);
 
+void msg_fetch_raw_payload(struct scmi_msg_payld *msg, size_t msg_len,
+			   size_t max_len, struct scmi_xfer *xfer);
+void msg_fetch_raw_response(struct scmi_xfer *xfer);
+void msg_fetch_raw_notification(struct scmi_xfer *xfer);
+
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
index 8a2d3303d281..3ed3ad0961ae 100644
--- a/drivers/firmware/arm_scmi/msg.c
+++ b/drivers/firmware/arm_scmi/msg.c
@@ -74,6 +74,17 @@ u32 msg_read_header(struct scmi_msg_payld *msg)
 	return le32_to_cpu(msg->msg_header);
 }
 
+void msg_fetch_raw_payload(struct scmi_msg_payld *msg, size_t msg_len,
+			   size_t max_len, struct scmi_xfer *xfer)
+{
+	xfer->rx_raw_len = min_t(size_t, max_len,
+				 msg_len >= sizeof(*msg) ?
+				 msg_len - sizeof(*msg) : 0);
+
+	/* Take a copy to the rx buffer.. */
+	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx_raw_len);
+}
+
 /**
  * msg_fetch_response() - Fetch response SCMI payload from transport SDU.
  *
@@ -94,6 +105,25 @@ void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
 	memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
 }
 
+void msg_fetch_raw_response(struct scmi_xfer *xfer)
+{
+	__le32 *msg_payload = xfer->rx.buf;
+
+	if (xfer->rx_raw_len < sizeof(xfer->hdr.status)) {
+		xfer->rx.len = 0;
+		return;
+	}
+
+	xfer->hdr.status = le32_to_cpu(msg_payload[0]);
+	/*
+	 * rx.len has been already pre-calculated by fetch_raw
+	 * for the whole payload including status, so shrink it
+	 */
+	xfer->rx.len = xfer->rx_raw_len - sizeof(xfer->hdr.status);
+	/* Carveout status 4-byte field */
+	memmove(xfer->rx.buf, &msg_payload[1], xfer->rx.len);
+}
+
 /**
  * msg_fetch_notification() - Fetch notification payload from transport SDU.
  *
@@ -111,3 +141,8 @@ void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
 	/* Take a copy to the rx buffer.. */
 	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
 }
+
+void msg_fetch_raw_notification(struct scmi_xfer *xfer)
+{
+	xfer->rx.len = xfer->rx_raw_len;
+}
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 20972adf6dc7..4412bc590ca7 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -37,23 +37,24 @@
 /**
  * struct scmi_vio_channel - Transport channel information
  *
- * @lock: Protects access to all members except ready.
- * @ready_lock: Protects access to ready. If required, it must be taken before
- *              lock.
  * @vqueue: Associated virtqueue
  * @cinfo: SCMI Tx or Rx channel
  * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
  * @is_rx: Whether channel is an Rx channel
  * @ready: Whether transport user is ready to hear about channel
+ * @lock: Protects access to all members except ready.
+ * @ready_lock: Protects access to ready. If required, it must be taken before
+ *              lock.
  */
 struct scmi_vio_channel {
-	spinlock_t lock;
-	spinlock_t ready_lock;
 	struct virtqueue *vqueue;
 	struct scmi_chan_info *cinfo;
 	struct list_head free_list;
-	u8 is_rx;
-	u8 ready;
+	bool is_rx;
+	bool ready;
+	unsigned int max_msg;
+	spinlock_t lock;
+	spinlock_t ready_lock;
 };
 
 /**
@@ -100,6 +101,73 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
 	return rc;
 }
 
+static void scmi_finalize_message(struct scmi_vio_channel *vioch,
+				  struct scmi_vio_msg *msg)
+{
+	unsigned long flags;
+
+	if (vioch->is_rx) {
+		scmi_vio_feed_vq_rx(vioch, msg);
+	} else {
+		spin_lock_irqsave(&vioch->lock, flags);
+		list_add(&msg->list, &vioch->free_list);
+		spin_unlock_irqrestore(&vioch->lock, flags);
+	}
+}
+
+static void scmi_process_vqueue_input(struct scmi_vio_channel *vioch,
+				      struct scmi_vio_msg *msg)
+{
+	u32 msg_hdr;
+	int ret;
+	struct scmi_xfer *xfer = NULL;
+
+	msg_hdr = msg_read_header(msg->input);
+	/*
+	 * Acquire from the core transport layer a currently valid xfer
+	 * descriptor associated to the received msg_hdr: this could be a
+	 * previously allocated xfer for responses and delayed responses to
+	 * in-flight commands, or a freshly allocated new xfer for a just
+	 * received notification.
+	 *
+	 * In case of responses and delayed_responses the acquired xfer, at
+	 * the time scmi_transfer_acquire() succcessfully returns is guaranteed
+	 * to be still associated with a valid (not timed-out nor stale)
+	 * descriptor and proper refcounting is kept in the core along this xfer
+	 * so that should the core time out the xfer concurrently to this receive
+	 * path the xfer will be properly deallocated only once the last user is
+	 * done with it. (and this code path will terminate normally even though
+	 * all the processing related to the timed out xfer will be discarded).
+	 */
+	ret = scmi_transfer_acquire(vioch->cinfo, &msg_hdr, &xfer);
+	if (ret) {
+		dev_err(vioch->cinfo->dev,
+			"Cannot find matching xfer for hdr:0x%X\n", msg_hdr);
+		scmi_finalize_message(vioch, msg);
+		return;
+	}
+
+	dev_dbg(vioch->cinfo->dev,
+		"VQUEUE[%d] - INPUT MSG_RX_LEN:%d - HDR:0x%X  TYPE:%d  XFER_ID:%d  XFER:%px\n",
+		vioch->vqueue->index, msg->rx_len, msg_hdr, xfer->hdr.type,
+		xfer->hdr.seq, xfer);
+
+	msg_fetch_raw_payload(msg->input, msg->rx_len,
+			      scmi_virtio_desc.max_msg_size, xfer);
+
+	/* Drop processed virtio message anyway */
+	scmi_finalize_message(vioch, msg);
+
+	if (vioch->is_rx || !xfer->hdr.poll_completion)
+		scmi_rx_callback(vioch->cinfo, msg_hdr);
+	else
+		dev_warn(vioch->cinfo->dev,
+			 "Polling mode NOT supported. Dropped hdr:0X%X\n",
+			 msg_hdr);
+
+	scmi_transfer_release(vioch->cinfo, xfer);
+}
+
 static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 {
 	unsigned long ready_flags;
@@ -138,15 +206,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 
 		if (msg) {
 			msg->rx_len = length;
-
-			/*
-			 * Hold the ready_lock during the callback to avoid
-			 * races when the arm-scmi driver is unbinding while
-			 * the virtio device is not quiesced yet.
-			 */
-			scmi_rx_callback(vioch->cinfo,
-					 msg_read_header(msg->input), msg);
+			scmi_process_vqueue_input(vioch, msg);
 		}
+
 		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
 	}
 
@@ -163,27 +225,11 @@ static vq_callback_t *scmi_vio_complete_callbacks[] = {
 	scmi_vio_complete_cb
 };
 
-static unsigned int virtio_get_max_msg(bool tx,
-				       struct scmi_chan_info *base_cinfo)
+static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
 {
 	struct scmi_vio_channel *vioch = base_cinfo->transport_info;
-	unsigned int ret;
 
-	ret = virtqueue_get_vring_size(vioch->vqueue);
-
-	/* Tx messages need multiple descriptors. */
-	if (tx)
-		ret /= DESCRIPTORS_PER_TX_MSG;
-
-	if (ret > MSG_TOKEN_MAX) {
-		dev_info_once(
-			base_cinfo->dev,
-			"Only %ld messages can be pending simultaneously, while the %s virtqueue could hold %d\n",
-			MSG_TOKEN_MAX, tx ? "tx" : "rx", ret);
-		ret = MSG_TOKEN_MAX;
-	}
-
-	return ret;
+	return vioch->max_msg;
 }
 
 static int scmi_vio_match_any_dev(struct device *dev, const void *data)
@@ -195,13 +241,14 @@ static struct virtio_driver virtio_scmi_driver; /* Forward declaration */
 
 static int virtio_link_supplier(struct device *dev)
 {
-	struct device *vdev = driver_find_device(
-		&virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
+	struct device *vdev;
+
+	vdev = driver_find_device(&virtio_scmi_driver.driver,
+				  NULL, NULL, scmi_vio_match_any_dev);
 
 	if (!vdev) {
-		dev_notice_once(
-			dev,
-			"Deferring probe after not finding a bound scmi-virtio device\n");
+		dev_notice_once(dev,
+				"Deferring probe after not finding a bound scmi-virtio device\n");
 		return -EPROBE_DEFER;
 	}
 
@@ -245,12 +292,8 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct virtio_device *vdev;
 	struct scmi_vio_channel *vioch;
 	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
-	int max_msg;
 	int i;
 
-	if (!virtio_chan_available(dev, index))
-		return -ENODEV;
-
 	vdev = scmi_get_transport_info(dev);
 	vioch = &((struct scmi_vio_channel *)vdev->priv)[index];
 
@@ -259,9 +302,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	vioch->cinfo = cinfo;
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
-	max_msg = virtio_get_max_msg(tx, cinfo);
-
-	for (i = 0; i < max_msg; i++) {
+	for (i = 0; i < vioch->max_msg; i++) {
 		struct scmi_vio_msg *msg;
 
 		msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
@@ -322,13 +363,6 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 	int rc;
 	struct scmi_vio_msg *msg;
 
-	/*
-	 * TODO: For now, we don't support polling. But it should not be
-	 * difficult to add support.
-	 */
-	if (xfer->hdr.poll_completion)
-		return -EINVAL;
-
 	spin_lock_irqsave(&vioch->lock, flags);
 
 	if (list_empty(&vioch->free_list)) {
@@ -351,6 +385,11 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 			     "%s() failed to add to virtqueue (%d)\n", __func__,
 			     rc);
 	} else {
+		dev_dbg(vioch->cinfo->dev,
+			"VQUEUE[%d] - REQUEST - PROTO:0x%X  ID:0x%X  XFER_ID:%d  XFER:%px  RX_LEN:%zd\n",
+		 vioch->vqueue->index, xfer->hdr.protocol_id,
+		 xfer->hdr.id, xfer->hdr.seq, xfer, xfer->rx.len);
+
 		virtqueue_kick(vioch->vqueue);
 	}
 
@@ -360,36 +399,15 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 }
 
 static void virtio_fetch_response(struct scmi_chan_info *cinfo,
-				  struct scmi_xfer *xfer, void *msg_handle)
+				  struct scmi_xfer *xfer)
 {
-	struct scmi_vio_msg *msg = msg_handle;
-	struct scmi_vio_channel *vioch = cinfo->transport_info;
-
-	if (!msg) {
-		dev_dbg_once(&vioch->vqueue->vdev->dev,
-			     "Ignoring %s() call with NULL msg_handle\n",
-			     __func__);
-		return;
-	}
-
-	msg_fetch_response(msg->input, msg->rx_len, xfer);
+	msg_fetch_raw_response(xfer);
 }
 
 static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
-				      size_t max_len, struct scmi_xfer *xfer,
-				      void *msg_handle)
+				      size_t max_len, struct scmi_xfer *xfer)
 {
-	struct scmi_vio_msg *msg = msg_handle;
-	struct scmi_vio_channel *vioch = cinfo->transport_info;
-
-	if (!msg) {
-		dev_dbg_once(&vioch->vqueue->vdev->dev,
-			     "Ignoring %s() call with NULL msg_handle\n",
-			     __func__);
-		return;
-	}
-
-	msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
+	msg_fetch_raw_notification(xfer);
 }
 
 static void dummy_clear_channel(struct scmi_chan_info *cinfo)
@@ -402,28 +420,6 @@ static bool dummy_poll_done(struct scmi_chan_info *cinfo,
 	return false;
 }
 
-static void virtio_drop_message(struct scmi_chan_info *cinfo, void *msg_handle)
-{
-	unsigned long flags;
-	struct scmi_vio_channel *vioch = cinfo->transport_info;
-	struct scmi_vio_msg *msg = msg_handle;
-
-	if (!msg) {
-		dev_dbg_once(&vioch->vqueue->vdev->dev,
-			     "Ignoring %s() call with NULL msg_handle\n",
-			     __func__);
-		return;
-	}
-
-	if (vioch->is_rx) {
-		scmi_vio_feed_vq_rx(vioch, msg);
-	} else {
-		spin_lock_irqsave(&vioch->lock, flags);
-		list_add(&msg->list, &vioch->free_list);
-		spin_unlock_irqrestore(&vioch->lock, flags);
-	}
-}
-
 static const struct scmi_transport_ops scmi_virtio_ops = {
 	.link_supplier = virtio_link_supplier,
 	.chan_available = virtio_chan_available,
@@ -435,7 +431,6 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
 	.fetch_notification = virtio_fetch_notification,
 	.clear_channel = dummy_clear_channel,
 	.poll_done = dummy_poll_done,
-	.drop_message = virtio_drop_message,
 };
 
 static int scmi_vio_probe(struct virtio_device *vdev)
@@ -467,10 +462,26 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
 
 	for (i = 0; i < vq_cnt; i++) {
+		unsigned int sz;
+
 		spin_lock_init(&channels[i].lock);
 		spin_lock_init(&channels[i].ready_lock);
 		INIT_LIST_HEAD(&channels[i].free_list);
 		channels[i].vqueue = vqs[i];
+
+		sz = virtqueue_get_vring_size(channels[i].vqueue);
+		/* Tx messages need multiple descriptors. */
+		if (!channels[i].is_rx)
+			sz /= DESCRIPTORS_PER_TX_MSG;
+
+		if (sz > MSG_TOKEN_MAX) {
+			dev_info_once(dev,
+				      "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
+				      channels[i].is_rx ? "rx" : "tx",
+				      sz, MSG_TOKEN_MAX);
+			sz = MSG_TOKEN_MAX;
+		}
+		channels[i].max_msg = sz;
 	}
 
 	vdev->priv = channels;
@@ -520,4 +531,5 @@ const struct scmi_desc scmi_virtio_desc = {
 	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
 	.max_msg = 0, /* overridden by virtio_get_max_msg() */
 	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+	.support_xfers_delegation = true,
 };
-- 
2.17.1

