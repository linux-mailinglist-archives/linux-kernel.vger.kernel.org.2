Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7C33D433
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhCPMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:50:14 -0400
Received: from foss.arm.com ([217.140.110.172]:37642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhCPMtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6FD5113E;
        Tue, 16 Mar 2021 05:49:21 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6D293F792;
        Tue, 16 Mar 2021 05:49:19 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 03/38] firmware: arm_scmi: introduce devres get/put protocols operations
Date:   Tue, 16 Mar 2021 12:48:28 +0000
Message-Id: <20210316124903.35011-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose to the SCMI drivers a new devres managed common protocols API based
on generic get/put methods and protocol handles.

All drivers still keep using the old API, no functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
v4 --> v5
- renamed devm methods to devm_get/put_protocol
---
 drivers/firmware/arm_scmi/driver.c | 92 ++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      | 11 ++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b6f1a2866248..5a960a7fd973 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/io.h>
@@ -755,6 +756,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 	return false;
 }
 
+struct scmi_protocol_devres {
+	struct scmi_handle *handle;
+	u8 protocol_id;
+};
+
+static void scmi_devm_release_protocol(struct device *dev, void *res)
+{
+	struct scmi_protocol_devres *dres = res;
+
+	scmi_protocol_release(dres->handle, dres->protocol_id);
+}
+
+/**
+ * scmi_devm_protocol_get  - Devres managed get protocol operations and handle
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @protocol_id: The protocol being requested.
+ * @ph: A pointer reference used to pass back the associated protocol handle.
+ *
+ * Get hold of a protocol accounting for its usage, eventually triggering its
+ * initialization, and returning the protocol specific operations and related
+ * protocol handle which will be used as first argument in most of the
+ * protocols operations methods.
+ * Being a devres based managed method, protocol hold will be automatically
+ * released, and possibly de-initialized on last user, once the SCMI driver
+ * owning the scmi_device is unbound from it.
+ *
+ * Return: A reference to the requested protocol operations or error.
+ *	   Must be checked for errors by caller.
+ */
+static const void __must_check *
+scmi_devm_protocol_get(struct scmi_device *sdev, u8 protocol_id,
+		       struct scmi_protocol_handle **ph)
+{
+	struct scmi_protocol_instance *pi;
+	struct scmi_protocol_devres *dres;
+	struct scmi_handle *handle = sdev->handle;
+
+	if (!ph)
+		return ERR_PTR(-EINVAL);
+
+	dres = devres_alloc(scmi_devm_release_protocol,
+			    sizeof(*dres), GFP_KERNEL);
+	if (!dres)
+		return ERR_PTR(-ENOMEM);
+
+	pi = scmi_get_protocol_instance(handle, protocol_id);
+	if (IS_ERR(pi)) {
+		devres_free(dres);
+		return pi;
+	}
+
+	dres->handle = handle;
+	dres->protocol_id = protocol_id;
+	devres_add(&sdev->dev, dres);
+
+	*ph = &pi->ph;
+
+	return pi->proto->ops;
+}
+
+static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
+{
+	struct scmi_protocol_devres *dres = res;
+
+	if (WARN_ON(!dres || !data))
+		return 0;
+
+	return dres->protocol_id == *((u8 *)data);
+}
+
+/**
+ * scmi_devm_protocol_put  - Devres managed put protocol operations and handle
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @protocol_id: The protocol being requested.
+ *
+ * Explicitly release a protocol hold previously obtained calling the above
+ * @scmi_devm_protocol_get.
+ */
+static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
+{
+	int ret;
+
+	ret = devres_release(&sdev->dev, scmi_devm_release_protocol,
+			     scmi_devm_protocol_match, &protocol_id);
+	WARN_ON(ret);
+}
+
 /**
  * scmi_handle_get() - Get the SCMI handle for a device
  *
@@ -1009,6 +1099,8 @@ static int scmi_probe(struct platform_device *pdev)
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
+	handle->devm_protocol_get = scmi_devm_protocol_get;
+	handle->devm_protocol_put = scmi_devm_protocol_put;
 
 	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ea301c579c6f..a9becd356fe8 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -57,6 +57,8 @@ struct scmi_clock_info {
 };
 
 struct scmi_handle;
+struct scmi_device;
+struct scmi_protocol_handle;
 
 /**
  * struct scmi_clk_ops - represents the various operations provided
@@ -593,6 +595,9 @@ struct scmi_notify_ops {
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
  * @voltage_ops: pointer to set of voltage protocol operations
+ * @devm_protocol_get: devres managed method to acquire a protocol and get specific
+ *		       operations and a dedicated protocol handler
+ * @devm_protocol_put: devres managed method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
  * @perf_priv: pointer to private data structure specific to performance
  *	protocol(for internal use only)
@@ -618,6 +623,12 @@ struct scmi_handle {
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_voltage_ops *voltage_ops;
+
+	const void __must_check *
+		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
+				     struct scmi_protocol_handle **ph);
+	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
+
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
 	void *perf_priv;
-- 
2.17.1

