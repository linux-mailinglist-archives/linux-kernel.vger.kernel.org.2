Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4733A3BC218
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGERNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:13:31 -0400
Received: from foss.arm.com ([217.140.110.172]:51194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhGERN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:13:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8448F1042;
        Mon,  5 Jul 2021 10:10:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1CB3F694;
        Mon,  5 Jul 2021 10:10:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH v2 5/8] firmware: arm_scmi: Add is_transport_atomic() handle method
Date:   Mon,  5 Jul 2021 18:10:19 +0100
Message-Id: <20210705171022.25861-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705171022.25861-1-cristian.marussi@arm.com>
References: <20210705171022.25861-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a method to check if the underlying transport configured for an SCMI
instance is configured to support atomic transaction of SCMI commands.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 16 ++++++++++++++++
 include/linux/scmi_protocol.h      |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 43aff6b26571..22173f747fdb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1558,6 +1558,21 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
 	WARN_ON(ret);
 }
 
+/**
+ * scmi_is_transport_atomic  - Method to check if underlying transport for an
+ * SCMI instance is configured as atomic.
+ *
+ * @handle: A reference to the SCMI platform instance.
+ *
+ * Return: True if transport is configured as atomic
+ */
+static bool scmi_is_transport_atomic(const struct scmi_handle *handle)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return info->desc->atomic_capable;
+}
+
 static inline
 struct scmi_handle *scmi_handle_get_from_info_unlocked(struct scmi_info *info)
 {
@@ -2074,6 +2089,7 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->version = &info->version;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
+	handle->is_transport_atomic = scmi_is_transport_atomic;
 
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 79d0a1237e6c..b28eb7c104e7 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -608,6 +608,13 @@ struct scmi_notify_ops {
  * @devm_protocol_get: devres managed method to acquire a protocol and get specific
  *		       operations and a dedicated protocol handler
  * @devm_protocol_put: devres managed method to release a protocol
+ * @is_transport_atomic: method to check if the underlying transport for this
+ *			 instance handle is configured to support atomic
+ *			 transactions for commands.
+ *			 Some users of the SCMI stack in the upper layers could
+ *			 be interested to know if they can assume SCMI
+ *			 command transactions associated to this handle will
+ *			 never sleep and act accordingly.
  * @notify_ops: pointer to set of notifications related operations
  */
 struct scmi_handle {
@@ -618,6 +625,7 @@ struct scmi_handle {
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
 	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
+	bool (*is_transport_atomic)(const struct scmi_handle *handle);
 
 	const struct scmi_notify_ops *notify_ops;
 };
-- 
2.17.1

