Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC93A4749
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFKRDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:03:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhFKRDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AF51396;
        Fri, 11 Jun 2021 10:01:08 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C27D3F719;
        Fri, 11 Jun 2021 10:01:04 -0700 (PDT)
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
Subject: [PATCH v4 12/16] firmware: arm_scmi: Add message passing abstractions for transports
Date:   Fri, 11 Jun 2021 17:59:33 +0100
Message-Id: <20210611165937.701-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hilber <peter.hilber@opensynergy.com>

Add abstractions for future transports using message passing, such as
virtio. Derive the abstractions from the shared memory abstractions.

Abstract the transport SDU through the opaque struct scmi_msg_payld.
Also enable the transport to determine all other required information
about the transport SDU.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/Kconfig           |   8 +-
 drivers/firmware/arm_scmi/Makefile |   1 +
 drivers/firmware/arm_scmi/common.h |  15 ++++
 drivers/firmware/arm_scmi/msg.c    | 113 +++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/msg.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 358f895847b5..e74d25065d07 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on ARM_SCMI_HAVE_SHMEM
+	depends on ARM_SCMI_HAVE_SHMEM || ARM_SCMI_HAVE_MSG
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are
@@ -33,6 +33,12 @@ config ARM_SCMI_HAVE_SHMEM
 	  This declares whether a shared memory based transport for SCMI is
 	  available.
 
+config ARM_SCMI_HAVE_MSG
+	bool
+	help
+	  This declares whether a message passing based transport for SCMI is
+	  available.
+
 config ARM_SCMI_POWER_DOMAIN
 	tristate "SCMI power domain driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 5a2d4c32e0ae..f6b4acb8abdb 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,6 +4,7 @@ scmi-driver-y = driver.o notify.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
+scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b783ae058c8a..fa4075336580 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -410,6 +410,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 
+/* declarations for message passing transports */
+struct scmi_msg_payld;
+
+/** Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
+#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
+
+size_t msg_response_size(struct scmi_xfer *xfer);
+size_t msg_command_size(struct scmi_xfer *xfer);
+void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
+u32 msg_read_header(struct scmi_msg_payld *msg);
+void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
+			struct scmi_xfer *xfer);
+void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
+			    size_t max_len, struct scmi_xfer *xfer);
+
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
new file mode 100644
index 000000000000..8a2d3303d281
--- /dev/null
+++ b/drivers/firmware/arm_scmi/msg.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * For transports using message passing.
+ *
+ * Derived from shm.c.
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ * Copyright (C) 2020 OpenSynergy GmbH
+ */
+
+#include <linux/io.h>
+#include <linux/processor.h>
+#include <linux/types.h>
+
+#include "common.h"
+
+/*
+ * struct scmi_msg_payld - Transport SDU layout
+ *
+ * The SCMI specification requires all parameters, message headers, return
+ * arguments or any protocol data to be expressed in little endian format only.
+ */
+struct scmi_msg_payld {
+	__le32 msg_header;
+	__le32 msg_payload[];
+};
+
+/**
+ * msg_command_size() - Actual size of transport SDU for command.
+ *
+ * @xfer: message which core has prepared for sending
+ *
+ * Return: transport SDU size.
+ */
+size_t msg_command_size(struct scmi_xfer *xfer)
+{
+	return sizeof(struct scmi_msg_payld) + xfer->tx.len;
+}
+
+/**
+ * msg_response_size() - Maximum size of transport SDU for response.
+ *
+ * @xfer: message which core has prepared for sending
+ *
+ * Return: transport SDU size.
+ */
+size_t msg_response_size(struct scmi_xfer *xfer)
+{
+	return sizeof(struct scmi_msg_payld) + sizeof(__le32) + xfer->rx.len;
+}
+
+/**
+ * msg_tx_prepare() - Set up transport SDU for command.
+ *
+ * @msg: transport SDU for command
+ * @xfer: message which is being sent
+ */
+void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
+{
+	msg->msg_header = cpu_to_le32(pack_scmi_header(&xfer->hdr));
+	if (xfer->tx.buf)
+		memcpy(msg->msg_payload, xfer->tx.buf, xfer->tx.len);
+}
+
+/**
+ * msg_read_header() - Read SCMI header from transport SDU.
+ *
+ * @msg: transport SDU
+ *
+ * Return: SCMI header
+ */
+u32 msg_read_header(struct scmi_msg_payld *msg)
+{
+	return le32_to_cpu(msg->msg_header);
+}
+
+/**
+ * msg_fetch_response() - Fetch response SCMI payload from transport SDU.
+ *
+ * @msg: transport SDU with response
+ * @len: transport SDU size
+ * @xfer: message being responded to
+ */
+void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
+			struct scmi_xfer *xfer)
+{
+	size_t prefix_len = sizeof(*msg) + sizeof(msg->msg_payload[0]);
+
+	xfer->hdr.status = le32_to_cpu(msg->msg_payload[0]);
+	xfer->rx.len = min_t(size_t, xfer->rx.len,
+			     len >= prefix_len ? len - prefix_len : 0);
+
+	/* Take a copy to the rx buffer.. */
+	memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
+}
+
+/**
+ * msg_fetch_notification() - Fetch notification payload from transport SDU.
+ *
+ * @msg: transport SDU with notification
+ * @len: transport SDU size
+ * @max_len: maximum SCMI payload size to fetch
+ * @xfer: notification message
+ */
+void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
+			    size_t max_len, struct scmi_xfer *xfer)
+{
+	xfer->rx.len = min_t(size_t, max_len,
+			     len >= sizeof(*msg) ? len - sizeof(*msg) : 0);
+
+	/* Take a copy to the rx buffer.. */
+	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
+}
-- 
2.17.1

