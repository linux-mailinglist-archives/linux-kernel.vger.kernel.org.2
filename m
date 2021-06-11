Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8CB3A4747
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFKRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:03:01 -0400
Received: from foss.arm.com ([217.140.110.172]:35706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhFKRC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:02:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F951477;
        Fri, 11 Jun 2021 10:01:00 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B263F719;
        Fri, 11 Jun 2021 10:00:57 -0700 (PDT)
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
Subject: [PATCH v4 10/16] firmware: arm_scmi: Add per-device transport private info
Date:   Fri, 11 Jun 2021 17:59:31 +0100
Message-Id: <20210611165937.701-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hilber <peter.hilber@opensynergy.com>

The scmi-virtio transport will link a supplier device to the arm-scmi
device in the link_supplier() op. The transport should then save a
pointer to the linked device.

To enable this, add a transport private info to the scmi_info. (The
scmi_info is already reachable through the arm-scmi device driver_data.)

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  2 ++
 drivers/firmware/arm_scmi/driver.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index a31194b3000a..7219970fc5eb 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -389,6 +389,8 @@ extern const struct scmi_desc scmi_mailbox_desc;
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
+int scmi_set_transport_info(struct device *dev, void *transport_info);
+void *scmi_get_transport_info(struct device *dev);
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 69fa97250d98..bb2de15554a9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -138,6 +138,7 @@ struct scmi_protocol_instance {
  * @active_protocols: IDR storing device_nodes for protocols actually defined
  *		      in the DT and confirmed as implemented by fw.
  * @notify_priv: Pointer to private data structure specific to notifications.
+ * @transport_info: Transport private info
  * @node: List head
  * @users: Number of users of this instance
  */
@@ -156,6 +157,7 @@ struct scmi_info {
 	u8 *protocols_imp;
 	struct idr active_protocols;
 	void *notify_priv;
+	void *transport_info;
 	struct list_head node;
 	int users;
 };
@@ -679,6 +681,39 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 }
 
+/**
+ * scmi_set_transport_info() - Set transport private info
+ *
+ * @dev: SCMI instance device
+ * @transport_info: transport private info
+ *
+ * Return: 0 on success, otherwise error.
+ */
+int scmi_set_transport_info(struct device *dev, void *transport_info)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	if (!info)
+		return -EBADR;
+
+	info->transport_info = transport_info;
+	return 0;
+}
+
+/**
+ * scmi_get_transport_info() - Get transport private info
+ *
+ * @dev: SCMI instance device
+ *
+ * Return: transport private info on success, otherwise NULL.
+ */
+void *scmi_get_transport_info(struct device *dev)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return info ? info->transport_info : NULL;
+}
+
 /**
  * xfer_put() - Release a transmit message
  *
-- 
2.17.1

