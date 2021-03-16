Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898C333D437
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhCPMu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:50:29 -0400
Received: from foss.arm.com ([217.140.110.172]:37678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232977AbhCPMt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A963B11FB;
        Tue, 16 Mar 2021 05:49:26 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3C8F3F792;
        Tue, 16 Mar 2021 05:49:24 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 05/38] firmware: arm_scmi: introduce new devres notification ops
Date:   Tue, 16 Mar 2021 12:48:30 +0000
Message-Id: <20210316124903.35011-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose to the SCMI drivers a new alternative devres managed notifications
API based on protocol handles.

All drivers still keep using the old API, no functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- constify src_id parameter
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
---
 drivers/firmware/arm_scmi/notify.c | 129 ++++++++++++++++++++++++++++-
 include/linux/scmi_protocol.h      |  22 ++++-
 2 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 09015f1f9942..9dd729ac9fe2 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1317,7 +1317,7 @@ static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
  * Return: 0 on Success
  */
 static int scmi_register_notifier(const struct scmi_handle *handle,
-				  u8 proto_id, u8 evt_id, u32 *src_id,
+				  u8 proto_id, u8 evt_id, const u32 *src_id,
 				  struct notifier_block *nb)
 {
 	int ret = 0;
@@ -1366,7 +1366,7 @@ static int scmi_register_notifier(const struct scmi_handle *handle,
  * Return: 0 on Success
  */
 static int scmi_unregister_notifier(const struct scmi_handle *handle,
-				    u8 proto_id, u8 evt_id, u32 *src_id,
+				    u8 proto_id, u8 evt_id, const u32 *src_id,
 				    struct notifier_block *nb)
 {
 	u32 evt_key;
@@ -1408,6 +1408,129 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
 	return 0;
 }
 
+struct scmi_notifier_devres {
+	const struct scmi_handle *handle;
+	u8 proto_id;
+	u8 evt_id;
+	u32 __src_id;
+	u32 *src_id;
+	struct notifier_block *nb;
+};
+
+static void scmi_devm_release_notifier(struct device *dev, void *res)
+{
+	struct scmi_notifier_devres *dres = res;
+
+	scmi_unregister_notifier(dres->handle, dres->proto_id, dres->evt_id,
+				 dres->src_id, dres->nb);
+}
+
+/**
+ * scmi_devm_notifier_register()  - Managed registration of a notifier_block
+ * for an event
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @proto_id: Protocol ID
+ * @evt_id: Event ID
+ * @src_id: Source ID, when NULL register for events coming form ALL possible
+ *	    sources
+ * @nb: A standard notifier block to register for the specified event
+ *
+ * Generic devres managed helper to register a notifier_block against a
+ * protocol event.
+ */
+static int scmi_devm_notifier_register(struct scmi_device *sdev,
+				       u8 proto_id, u8 evt_id,
+				       const u32 *src_id,
+				       struct notifier_block *nb)
+{
+	int ret;
+	struct scmi_notifier_devres *dres;
+
+	dres = devres_alloc(scmi_devm_release_notifier,
+			    sizeof(*dres), GFP_KERNEL);
+	if (!dres)
+		return -ENOMEM;
+
+	ret = scmi_register_notifier(sdev->handle, proto_id,
+				     evt_id, src_id, nb);
+	if (ret) {
+		devres_free(dres);
+		return ret;
+	}
+
+	dres->handle = sdev->handle;
+	dres->proto_id = proto_id;
+	dres->evt_id = evt_id;
+	dres->nb = nb;
+	if (src_id) {
+		dres->__src_id = *src_id;
+		dres->src_id = &dres->__src_id;
+	} else {
+		dres->src_id = NULL;
+	}
+	devres_add(&sdev->dev, dres);
+
+	return ret;
+}
+
+static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
+{
+	struct scmi_notifier_devres *dres = res;
+	struct scmi_notifier_devres *xres = data;
+
+	if (WARN_ON(!dres || !xres))
+		return 0;
+
+	return dres->proto_id == xres->proto_id &&
+		dres->evt_id == xres->evt_id &&
+		dres->nb == xres->nb &&
+		((!dres->src_id && !xres->src_id) ||
+		  (dres->src_id && xres->src_id &&
+		   dres->__src_id == xres->__src_id));
+}
+
+/**
+ * scmi_devm_notifier_unregister()  - Managed un-registration of a
+ * notifier_block for an event
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @proto_id: Protocol ID
+ * @evt_id: Event ID
+ * @src_id: Source ID, when NULL register for events coming form ALL possible
+ *	    sources
+ * @nb: A standard notifier block to register for the specified event
+ *
+ * Generic devres managed helper to explicitly un-register a notifier_block
+ * against a protocol event, which was previously registered using the above
+ * @scmi_devm_notifier_register.
+ */
+static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
+					 u8 proto_id, u8 evt_id,
+					 const u32 *src_id,
+					 struct notifier_block *nb)
+{
+	int ret;
+	struct scmi_notifier_devres dres;
+
+	dres.handle = sdev->handle;
+	dres.proto_id = proto_id;
+	dres.evt_id = evt_id;
+	if (src_id) {
+		dres.__src_id = *src_id;
+		dres.src_id = &dres.__src_id;
+	} else {
+		dres.src_id = NULL;
+	}
+
+	ret = devres_release(&sdev->dev, scmi_devm_release_notifier,
+			     scmi_devm_notifier_match, &dres);
+
+	WARN_ON(ret);
+
+	return ret;
+}
+
 /**
  * scmi_protocols_late_init()  - Worker for late initialization
  * @work: The work item to use associated to the proper SCMI instance
@@ -1465,6 +1588,8 @@ static void scmi_protocols_late_init(struct work_struct *work)
  * directly from an scmi_driver to register its own notifiers.
  */
 static const struct scmi_notify_ops notify_ops = {
+	.devm_event_notifier_register = scmi_devm_notifier_register,
+	.devm_event_notifier_unregister = scmi_devm_notifier_unregister,
 	.register_event_notifier = scmi_register_notifier,
 	.unregister_event_notifier = scmi_unregister_notifier,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a9becd356fe8..2b66b243e841 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -544,6 +544,10 @@ struct scmi_voltage_ops {
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
+ * @devm_event_notifier_register: Managed registration of a notifier_block for
+ *				  the requested event
+ * @devm_event_notifier_unregister: Managed unregistration of a notifier_block
+ *				    for the requested event
  * @register_event_notifier: Register a notifier_block for the requested event
  * @unregister_event_notifier: Unregister a notifier_block for the requested
  *			       event
@@ -553,7 +557,9 @@ struct scmi_voltage_ops {
  * tuple: (proto_id, evt_id, src_id) using the provided register/unregister
  * interface where:
  *
- * @handle: The handle identifying the platform instance to use
+ * @sdev: The scmi_device to use when calling the devres managed ops devm_
+ * @handle: The handle identifying the platform instance to use, when not
+ *	    calling the managed ops devm_
  * @proto_id: The protocol ID as in SCMI Specification
  * @evt_id: The message ID of the desired event as in SCMI Specification
  * @src_id: A pointer to the desired source ID if different sources are
@@ -576,11 +582,21 @@ struct scmi_voltage_ops {
  * @report: A custom struct describing the specific event delivered
  */
 struct scmi_notify_ops {
+	int (*devm_event_notifier_register)(struct scmi_device *sdev,
+					    u8 proto_id, u8 evt_id,
+					    const u32 *src_id,
+					    struct notifier_block *nb);
+	int (*devm_event_notifier_unregister)(struct scmi_device *sdev,
+					      u8 proto_id, u8 evt_id,
+					      const u32 *src_id,
+					      struct notifier_block *nb);
 	int (*register_event_notifier)(const struct scmi_handle *handle,
-				       u8 proto_id, u8 evt_id, u32 *src_id,
+				       u8 proto_id, u8 evt_id,
+				       const u32 *src_id,
 				       struct notifier_block *nb);
 	int (*unregister_event_notifier)(const struct scmi_handle *handle,
-					 u8 proto_id, u8 evt_id, u32 *src_id,
+					 u8 proto_id, u8 evt_id,
+					 const u32 *src_id,
 					 struct notifier_block *nb);
 };
 
-- 
2.17.1

