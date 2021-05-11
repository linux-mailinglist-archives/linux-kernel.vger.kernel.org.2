Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E51379B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhEKA34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:29:56 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:2477 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhEKA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:44 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id C2CE4A1A34;
        Tue, 11 May 2021 02:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=P6aDOohx/CnL
        NSOtZzTr/KKqECyrpqq0nGc8kYRUUw8=; b=lfOULUUkRdEbM33ODp84rarqB3eL
        oRp6r512RnPzAuj6sib4ZfsuUKhBSbNM4O9gevs1DpvGU6G1ZmpbjchQRlYTdSjl
        UJtVwKI9VQgGKGQecHOO2fQ/1xgc4X6iAT2iCDTgppVYbATBFkiJDdaiJXf7enbd
        kXTPMkLqm82/ZJqxi7yx+nMu11n7tEc26mltk9gQqnUDkfhU8S5Q21i0SOu6poek
        DJ7ewQhsH9Q5WEmPmbtkkSvd35Z3nvAdkHbetfj90mLhO0bT1w7iolmmePpirYuc
        iqkBKchUsC6UM5jQzuvNZFRuaQkxPQLOwT3ikbXIqJUB3JlJFPmhlWgw2A==
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
Subject: [RFC PATCH v3 09/12] firmware: arm_scmi: Add message passing abstractions for transports
Date:   Tue, 11 May 2021 02:20:37 +0200
Message-ID: <20210511002040.802226-10-peter.hilber@opensynergy.com>
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
index 80ff49dadf35..e8377b12e4d0 100644
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
index 51ee08bdcb0c..4cb6571c7aaf 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -369,6 +369,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
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
2.25.1


