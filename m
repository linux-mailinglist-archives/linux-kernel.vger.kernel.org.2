Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61E5379B87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhEKAaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:10 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:8128 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhEKA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 7D13CA1A2E;
        Tue, 11 May 2021 02:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=6+VlSkKWGdjk
        DM6nZTn7Ha5NxKkKwBbIL6DCLdewkbA=; b=CGnQklXHC54GKgHiTz1MnYznchZN
        K0SvNZczQ/nM6pQopfMiFXgQ1Y5Bz0F1Piarn8SQ6qSXSHWJmqATT06yIQSNRLC3
        Mlc8FLjDLl4uToDbeqbSQ3fIF/2RE8zT93ferkKSKP3awqndteNHn+UFhwjhoTJX
        73x+yhxH6cgqmgusSRcdlaJL+SdKItlvIMmT54dtJedOH/zwenv8eZnjAESqXSlL
        FVsCR4Kh4hF8OtbqXUYIVm0+PCrYcyZx0ka8A7wxFGNsYVadRiObSsYAPJEzc3aV
        81lzp8hXK0xYmnRCEDkg6ktg0+mcbIJIbnv+jUPn0y5CEyhCq/aBmVlLig==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH v3 05/12] firmware: arm_scmi: Add per-device transport private info
Date:   Tue, 11 May 2021 02:20:33 +0200
Message-ID: <20210511002040.802226-6-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d60e3c26821d..61b22cdeaeeb 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -346,6 +346,8 @@ extern const struct scmi_desc scmi_mailbox_desc;
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
+int scmi_set_transport_info(struct device *dev, void *transport_info);
+void *scmi_get_transport_info(struct device *dev);
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index df526ff37c6d..581b6c9b3781 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -127,6 +127,7 @@ struct scmi_protocol_instance {
  * @active_protocols: IDR storing device_nodes for protocols actually defined
  *		      in the DT and confirmed as implemented by fw.
  * @notify_priv: Pointer to private data structure specific to notifications.
+ * @transport_info: Transport private info
  * @node: List head
  * @users: Number of users of this instance
  */
@@ -145,6 +146,7 @@ struct scmi_info {
 	u8 *protocols_imp;
 	struct idr active_protocols;
 	void *notify_priv;
+	void *transport_info;
 	struct list_head node;
 	int users;
 };
@@ -382,6 +384,39 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
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
2.25.1


