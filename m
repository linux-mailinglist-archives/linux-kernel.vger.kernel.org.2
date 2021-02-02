Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3923330CEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhBBWRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:17:50 -0500
Received: from foss.arm.com ([217.140.110.172]:58240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhBBWR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:17:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF51143D;
        Tue,  2 Feb 2021 14:16:41 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8203F694;
        Tue,  2 Feb 2021 14:16:38 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v6 04/37] firmware: arm_scmi: add devm_acquire_protocol helper
Date:   Tue,  2 Feb 2021 22:15:22 +0000
Message-Id: <20210202221555.41167-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202221555.41167-1-cristian.marussi@arm.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a method to get hold of a protocol, causing it to be initialized and
its resource accounting updated, without getting access to its operations
and handle.

Some protocols, like SCMI SystemPower, do not expose any protocol ops to
the Kernel OSPM agent but still need to be at least initialized: this
helper avoids the need to invoke a full devm_get_protocol() only to get
the protocol initialized while throwing away unused the protocol ops and
handle.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 70 +++++++++++++++++++++++-------
 include/linux/scmi_protocol.h      | 14 ++++--
 2 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 583c00a1355b..ca911a7eb511 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -745,6 +745,30 @@ static void scmi_devm_release_protocol(struct device *dev, void *res)
 	scmi_release_protocol(dres->handle, dres->protocol_id);
 }
 
+static struct scmi_protocol_instance __must_check *
+__scmi_devres_get_protocol_instance(struct scmi_device *sdev, u8 protocol_id)
+{
+	struct scmi_protocol_devres *dres;
+	struct scmi_protocol_instance *pi;
+
+	dres = devres_alloc(scmi_devm_release_protocol,
+			    sizeof(*dres), GFP_KERNEL);
+	if (!dres)
+		return ERR_PTR(-ENOMEM);
+
+	pi = scmi_get_protocol_instance(sdev->handle, protocol_id);
+	if (IS_ERR(pi)) {
+		devres_free(dres);
+		return pi;
+	}
+
+	dres->handle = sdev->handle;
+	dres->protocol_id = protocol_id;
+	devres_add(&sdev->dev, dres);
+
+	return pi;
+}
+
 /**
  * scmi_devm_get_protocol  - Devres managed get protocol operations and handle
  * @sdev: A reference to an scmi_device whose embedded struct device is to
@@ -768,32 +792,47 @@ scmi_devm_get_protocol(struct scmi_device *sdev, u8 protocol_id,
 		       struct scmi_protocol_handle **ph)
 {
 	struct scmi_protocol_instance *pi;
-	struct scmi_protocol_devres *dres;
-	struct scmi_handle *handle = sdev->handle;
 
 	if (!ph)
 		return ERR_PTR(-EINVAL);
 
-	dres = devres_alloc(scmi_devm_release_protocol,
-			    sizeof(*dres), GFP_KERNEL);
-	if (!dres)
-		return ERR_PTR(-ENOMEM);
-
-	pi = scmi_get_protocol_instance(handle, protocol_id);
-	if (IS_ERR(pi)) {
-		devres_free(dres);
+	pi = __scmi_devres_get_protocol_instance(sdev, protocol_id);
+	if (IS_ERR(pi))
 		return pi;
-	}
-
-	dres->handle = handle;
-	dres->protocol_id = protocol_id;
-	devres_add(&sdev->dev, dres);
 
 	*ph = &pi->ph;
 
 	return pi->proto->ops;
 }
 
+/**
+ * scmi_devm_acquire_protocol  - Devres managed helper to get hold of a protocol
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @protocol_id: The protocol being requested.
+ *
+ * Get hold of a protocol accounting for its usage, possibly triggering its
+ * initialization but without getting access to its protocol specific operations
+ * and handle.
+ *
+ * Being a devres based managed method, protocol hold will be automatically
+ * released, and possibly de-initialized on last user, once the SCMI driver
+ * owning the scmi_device is unbound from it.
+ *
+ * Return: 0 on SUCCESS
+ */
+static int __must_check scmi_devm_acquire_protocol(struct scmi_device *sdev,
+						   u8 protocol_id)
+{
+	struct scmi_protocol_instance *pi;
+
+	pi = __scmi_devres_get_protocol_instance(sdev, protocol_id);
+	if (IS_ERR(pi))
+		return PTR_ERR(pi);
+
+	return 0;
+}
+
 static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
 {
 	struct scmi_protocol_devres *dres = res;
@@ -1076,6 +1115,7 @@ static int scmi_probe(struct platform_device *pdev)
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
+	handle->devm_acquire_protocol = scmi_devm_acquire_protocol;
 	handle->devm_get_protocol = scmi_devm_get_protocol;
 	handle->devm_put_protocol = scmi_devm_put_protocol;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index bbcb2d999068..b3ca2969c29a 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -595,9 +595,15 @@ struct scmi_notify_ops {
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
  * @voltage_ops: pointer to set of voltage protocol operations
- * @devm_get_protocol: devres managed method to acquire a protocol and get specific
- *		       operations and a dedicated protocol handler
- * @devm_put_protocol: devres managed method to release a protocol
+ * @devm_acquire_protocol: devres managed method to get hold of a protocol,
+ *			   causing its initialization and related resource
+ *			   accounting
+ * @devm_get_protocol: devres managed method to acquire a protocol, causing
+ *		       its initialization and resource accounting, while getting
+ *		       protocol specific operations and a dedicated protocol
+ *		       handler
+ * @devm_put_protocol: devres managed method to release a protocol acquired
+ *		       with devm_acquire/get_protocol
  * @notify_ops: pointer to set of notifications related operations
  * @perf_priv: pointer to private data structure specific to performance
  *	protocol(for internal use only)
@@ -624,6 +630,8 @@ struct scmi_handle {
 	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_voltage_ops *voltage_ops;
 
+	int __must_check (*devm_acquire_protocol)(struct scmi_device *sdev,
+						  u8 proto);
 	const void __must_check *
 		(*devm_get_protocol)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
-- 
2.17.1

