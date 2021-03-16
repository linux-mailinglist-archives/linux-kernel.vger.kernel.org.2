Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC333D45D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCPMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:54:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhCPMuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CEC168F;
        Tue, 16 Mar 2021 05:50:37 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6F63F792;
        Tue, 16 Mar 2021 05:50:35 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 35/38] firmware: arm_scmi: make notify_priv really private
Date:   Tue, 16 Mar 2021 12:49:00 +0000
Message-Id: <20210316124903.35011-36-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notification private data is currently accessible via handle->notify_priv;
this data was indeed meant to be private to the notification core support
and not to be accessible by SCMI drivers: make it private hiding it inside
instance descriptor struct scmi_info and accessible only via dedicated
helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
---
 drivers/firmware/arm_scmi/common.h |  4 +++
 drivers/firmware/arm_scmi/driver.c | 21 ++++++++++++++
 drivers/firmware/arm_scmi/notify.c | 45 ++++++++++--------------------
 include/linux/scmi_protocol.h      |  3 --
 4 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c4a1262fb18d..c093f332cdcd 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -343,4 +343,8 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 
+void scmi_notification_instance_data_set(const struct scmi_handle *handle,
+					 void *priv);
+void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
+
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 27213bf768c0..563a64131035 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -113,6 +113,7 @@ struct scmi_protocol_instance {
  * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
+ * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
  */
@@ -129,6 +130,7 @@ struct scmi_info {
 	/* Ensure mutual exclusive access to protocols instance array */
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
+	void *notify_priv;
 	struct list_head node;
 	int users;
 };
@@ -170,6 +172,25 @@ static inline void scmi_dump_header_dbg(struct device *dev,
 		hdr->id, hdr->seq, hdr->protocol_id);
 }
 
+void scmi_notification_instance_data_set(const struct scmi_handle *handle,
+					 void *priv)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	info->notify_priv = priv;
+	/* Ensure updated protocol private date are visible */
+	smp_wmb();
+}
+
+void *scmi_notification_instance_data_get(const struct scmi_handle *handle)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	/* Ensure protocols_private_data has been updated */
+	smp_rmb();
+	return info->notify_priv;
+}
+
 /**
  * scmi_xfer_get() - Allocate one message
  *
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 023c93deb14b..9ca019dd0aeb 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -582,11 +582,9 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
 	struct scmi_event_header eh;
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_notification_instance_data_get(handle);
+	if (!ni)
 		return 0;
-	ni = handle->notify_priv;
 
 	r_evt = SCMI_GET_REVT(ni, proto_id, evt_id);
 	if (!r_evt)
@@ -762,11 +760,9 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	    (!ee->num_sources && !ee->ops->get_num_sources))
 		return -EINVAL;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_notification_instance_data_get(handle);
+	if (!ni)
 		return -ENOMEM;
-	ni = handle->notify_priv;
 
 	/* num_sources cannot be <= 0 */
 	if (ee->num_sources) {
@@ -846,12 +842,10 @@ void scmi_deregister_protocol_events(const struct scmi_handle *handle,
 	struct scmi_notify_instance *ni;
 	struct scmi_registered_events_desc *pd;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_notification_instance_data_get(handle);
+	if (!ni)
 		return;
 
-	ni = handle->notify_priv;
 	pd = ni->registered_protocols[proto_id];
 	if (!pd)
 		return;
@@ -1354,11 +1348,9 @@ static int scmi_register_notifier(const struct scmi_handle *handle,
 	struct scmi_event_handler *hndl;
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_notification_instance_data_get(handle);
+	if (!ni)
 		return -ENODEV;
-	ni = handle->notify_priv;
 
 	evt_key = MAKE_HASH_KEY(proto_id, evt_id,
 				src_id ? *src_id : SRC_ID_MASK);
@@ -1402,11 +1394,9 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
 	struct scmi_event_handler *hndl;
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_notification_instance_data_get(handle);
+	if (!ni)
 		return -ENODEV;
-	ni = handle->notify_priv;
 
 	evt_key = MAKE_HASH_KEY(proto_id, evt_id,
 				src_id ? *src_id : SRC_ID_MASK);
@@ -1681,8 +1671,8 @@ int scmi_notification_init(struct scmi_handle *handle)
 
 	INIT_WORK(&ni->init_work, scmi_protocols_late_init);
 
+	scmi_notification_instance_data_set(handle, ni);
 	handle->notify_ops = &notify_ops;
-	handle->notify_priv = ni;
 	/* Ensure handle is up to date */
 	smp_wmb();
 
@@ -1694,7 +1684,7 @@ int scmi_notification_init(struct scmi_handle *handle)
 
 err:
 	dev_warn(handle->dev, "Initialization Failed.\n");
-	devres_release_group(handle->dev, NULL);
+	devres_release_group(handle->dev, gid);
 	return -ENOMEM;
 }
 
@@ -1706,15 +1696,10 @@ void scmi_notification_exit(struct scmi_handle *handle)
 {
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_notification_instance_data_get(handle);
+	if (!ni)
 		return;
-	ni = handle->notify_priv;
-
-	handle->notify_priv = NULL;
-	/* Ensure handle is up to date */
-	smp_wmb();
+	scmi_notification_instance_data_set(handle, NULL);
 
 	/* Destroy while letting pending work complete */
 	destroy_workqueue(ni->notify_wq);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 284dda52006e..114890bd7af0 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -609,8 +609,6 @@ struct scmi_notify_ops {
  *		       operations and a dedicated protocol handler
  * @devm_protocol_put: devres managed method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
- * @notify_priv: pointer to private data structure specific to notifications
- *	(for internal use only)
  */
 struct scmi_handle {
 	struct device *dev;
@@ -622,7 +620,6 @@ struct scmi_handle {
 	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
 
 	const struct scmi_notify_ops *notify_ops;
-	void *notify_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.17.1

