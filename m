Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44238C887
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhEUNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbhEUNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:42:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:41:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so6834108wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LTjcOxskARSOaZRb8ECEuyRgDRFo2qSGdcjAWiakTg=;
        b=jlH0dmMtYUYIsBATSxxzRGbMexVO4xc55qZw+dhi74BXDRTuNZpcm+nvtnMxTwXY3q
         O8yNq5FbKlV3od/FnWlUpMVVE6dp80BCFoAuaQjO21dhJDeJdiXvO+4R/RaaROUu39+n
         X7eXds3vTH8Sk9SpR1LJ9QNj43zeWI+txFF4dIz7u+deRDYknG1HyqqItIPNwPwPh4CF
         QSD7nMPAwrvWeecF7jZtX4kjeG6XcUZjbAjl5qx2CKBC5G3l8v9ETKj7u+Vd/jsFbeCo
         pJk7J1QZBTC+2bKLvO807BEiioWVgB4Bm+gY1jdAy8NDapVWYtz+3v3JHs01a/CHIFbr
         9Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LTjcOxskARSOaZRb8ECEuyRgDRFo2qSGdcjAWiakTg=;
        b=cqOTWPR8jGLH385jDpHAOgEDrIZT5GLgoxj/7yX7TBxL1GDGtnDgXLpebYqhK3uiW+
         aCw6iFaY7J6m4x6qj0H2ENL5L5xib0dlhbnAzE1qMQkySCZyCwSQ/qyQBVuCzmO+lfVY
         /cbmzynlnSv2rCkOzNKol2gCUoWvwutIkuPQODYn1xKRzdGEiz+3w8JbZNA37NOfG8Ms
         cUXnyXfQA/NDCbuI3378Vg3+eKMA0Hs+zKDYkt/x7h1hJHs2rEpghSEna7AUi/xXA3it
         AiDWV+fm50Ydz1lCQdm9jWIlRq7FqmTSIzYT8RGMZtAouMa46jQEHHZBuX8RGlBgHprp
         hwSA==
X-Gm-Message-State: AOAM532XqCQNyaz8QJxll0hlIDv28vUg3xVbs1ChMSA6gxbbfTtoElS2
        3p9SuG2wywr1JecCPOrMMg1nEeEx9Dfwh2VF
X-Google-Smtp-Source: ABdhPJxd25GM+Dg/bP+Uqg5OvUnWKseempPmpbtVXmiGaQSByrBdMxs4YTgYoiEZPpqQzKW8TXKY3A==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr9397055wml.131.1621604463085;
        Fri, 21 May 2021 06:41:03 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800205e07f10870202e.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:205e:7f1:870:202e])
        by smtp.gmail.com with ESMTPSA id v3sm2161372wrr.19.2021.05.21.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:41:02 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 4/4] firmware: arm_scmi: add optee transport
Date:   Fri, 21 May 2021 15:40:54 +0200
Message-Id: <20210521134055.24271-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521134055.24271-1-etienne.carriere@linaro.org>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new transport channel to the SCMI firmware interface driver for
SCMI message exchange based on OP-TEE transport channel that leverage
OP-TEE secure threaded context for processing of SCMI messages.

The current proposal uses a statically defined physical memory area
to be used as shared memory SCMI endpoints. The location is extracted
from the FDT upon property "shmem".

Entry in OP-TEE threaded context is realized by invoking a service
PTA (Pseudo TA) in OP-TEE OS. Each invocation carries a agent
numerical identifier for which a message is pending in the shared
memory. The OP-TEE service provides means to get the agent identifier
value for a given shared memory location.

OPTEE transport driver depends on CONFIG_OPTEE and probes from SCMI
compatible identifier "linaro,scmi-optee".

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v1
---
 drivers/firmware/Kconfig                  |   2 +-
 drivers/firmware/arm_scmi/Makefile        |   1 +
 drivers/firmware/arm_scmi/common.h        |   3 +
 drivers/firmware/arm_scmi/driver.c        |   3 +
 drivers/firmware/arm_scmi/optee_service.c | 529 ++++++++++++++++++++++
 5 files changed, 537 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/optee_service.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index a9c613c32282..7413e89e5628 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
+	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY || OPTEE
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6a2ef63306d6..0e09d302a82e 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,6 +4,7 @@ scmi-driver-y = driver.o notify.o
 scmi-transport-y = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
+scmi-transport-$(CONFIG_OPTEE) += optee_service.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 8685619d38f9..a4db1a1a98e2 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -334,6 +334,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 extern const struct scmi_desc scmi_smc_desc;
 #endif
+#ifdef CONFIG_OPTEE
+extern const struct scmi_desc scmi_optee_desc;
+#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 66eb3f0e5daf..501a9ec28791 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1570,6 +1570,9 @@ static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
+#endif
+#ifdef CONFIG_OPTEE
+	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
 #endif
 	{ /* Sentinel */ },
 };
diff --git a/drivers/firmware/arm_scmi/optee_service.c b/drivers/firmware/arm_scmi/optee_service.c
new file mode 100644
index 000000000000..de3432a4c179
--- /dev/null
+++ b/drivers/firmware/arm_scmi/optee_service.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2021 Linaro Limited
+ */
+
+#include <uapi/linux/tee.h>
+#include <linux/freezer.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+
+#include "common.h"
+
+#define DRIVER_NAME "optee-scmi-agent"
+
+/*
+ * PTA_SCMI_CMD_CAPABILITIES - Get channel capabilities
+ *
+ * [out]    value[0].a: Capability bit mask (PTA_SCMI_CAPS_*)
+ * [out]    value[0].b: Extended capabilities or 0
+ */
+#define PTA_SCMI_CMD_CAPABILITIES	0
+
+/*
+ * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL - Process SCMI message in SMT buffer
+ *
+ * [in]     value[0].a: Channel handle
+ *
+ * Shared memory used for SCMI message/response exhange is expected
+ * already identified and bound to channel handle in both SCMI agent
+ * and SCMI server (OP-TEE) parts.
+ * The memory uses SMT header to carry SCMI meta-data (protocol ID and
+ * protocol message ID).
+ */
+#define PTA_SCMI_CMD_PROCESS_SMT_CHANNEL	1
+
+/*
+ * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE - Process SMT/SCMI message
+ *
+ * [in]     value[0].a: Channel handle
+ * [in/out] memref[1]: Message/response buffer (SMT and SCMI payload)
+ *
+ * Shared memory used for SCMI message/response is a SMT buffer
+ * referenced by param[1]. It shall be 128 bytes large to fit response
+ * payload whatever message playload size.
+ * The memory uses SMT header to carry SCMI meta-data (protocol ID and
+ * protocol message ID).
+ */
+#define PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE	2
+
+/*
+ * PTA_SCMI_CMD_GET_CHANNEL_HANDLE - Get handle for an SCMI channel
+ *
+ * Get a handle for the SCMI channel. This handle value is to be passed
+ * as argument to some commands as PTA_SCMI_CMD_PROCESS_*.
+ *
+ * [in]     value[0].a: Channel identifier or 0 if no assigned ID
+ * [in]     value[0].b: Requested capabilities mask (PTA_SCMI_CAPS_*)
+ * [out]    value[0].a: Returned channel handle
+ */
+#define PTA_SCMI_CMD_GET_CHANNEL_HANDLE		3
+
+/*
+ * Channel capabilities
+ */
+
+/* Channel supports shared memory using the SMT header protocol */
+#define PTA_SCMI_CAPS_SMT_HEADER			BIT(0)
+
+struct optee_scmi_channel {
+	/* Channel handle retrieved from OP-TEE */
+	u32 channel_hdl;
+	/* Channel entry protection */
+	struct mutex mu;
+	/* Channel private data */
+	u32 tee_session;
+	struct optee_scmi_agent *agent;
+	struct scmi_chan_info *cinfo;
+	struct scmi_shared_mem __iomem *shmem;
+	/* Channel capabilities */
+	u32 caps;
+	/* Reference in agent's channel list */
+	struct list_head link;
+};
+
+/**
+ * struct optee_scmi_agent - OP-TEE transport private data
+ */
+struct optee_scmi_agent {
+	/* TEE context the agent operates with */
+	struct device *dev;
+	struct tee_context *tee_ctx;
+	/* Supported channel capabilities (PTA_SCMI_CAPS_*) */
+	u32 caps;
+	/* List all created channels */
+	struct list_head channel_list;
+};
+
+/* There is only 1 SCMI PTA to connect to */
+static struct optee_scmi_agent *agent_private;
+
+static struct list_head optee_agent_list = LIST_HEAD_INIT(optee_agent_list);
+static DEFINE_MUTEX(list_mutex);
+
+static int open_session(struct optee_scmi_agent *agent, u32 *tee_session)
+{
+	struct device *dev = agent->dev;
+	struct tee_client_device *scmi_pta = to_tee_client_device(dev);
+	struct tee_ioctl_open_session_arg sess_arg;
+	int ret;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	/* Open a session toward SCMI PTA with REE_KERNEL identity */
+	memcpy(sess_arg.uuid, scmi_pta->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret = tee_client_open_session(agent->tee_ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret != 0)) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n",
+			sess_arg.ret);
+		return -EINVAL;
+	}
+
+	*tee_session = sess_arg.session;
+
+	return 0;
+}
+
+static void close_session(struct optee_scmi_agent *agent, u32 tee_session)
+{
+	tee_client_close_session(agent->tee_ctx, tee_session);
+}
+
+static int get_capabilities(struct optee_scmi_agent *agent)
+{
+	int ret;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[1];
+	u32 tee_session;
+
+	ret = open_session(agent, &tee_session);
+	if (ret)
+		return ret;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	inv_arg.func = PTA_SCMI_CMD_CAPABILITIES;
+	inv_arg.session = tee_session;
+	inv_arg.num_params = 1;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(agent->tee_ctx, &inv_arg, param);
+
+	close_session(agent, tee_session);
+
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(agent->dev, "Can't get capabilities: %d / %#x\n",
+			ret, inv_arg.ret);
+
+		return -EOPNOTSUPP;
+	}
+
+	agent->caps = param[0].u.value.a;
+
+	if (!(agent->caps & PTA_SCMI_CAPS_SMT_HEADER)) {
+		dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\n");
+
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int get_channel(struct optee_scmi_channel *channel)
+{
+	struct device *dev = channel->agent->dev;
+	int ret;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[1];
+	unsigned int caps;
+
+	caps = PTA_SCMI_CAPS_SMT_HEADER;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	inv_arg.func = PTA_SCMI_CMD_GET_CHANNEL_HANDLE;
+	inv_arg.session = channel->tee_session;
+	inv_arg.num_params = 1;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
+	param[0].u.value.a = 0;
+	param[0].u.value.b = caps;
+
+	ret = tee_client_invoke_func(channel->agent->tee_ctx, &inv_arg, param);
+
+	if (ret || inv_arg.ret) {
+		dev_err(dev, "Can't get channel with caps %#x: ret=%d, tee-res=%#x\n",
+			caps, ret, inv_arg.ret);
+
+		return -EOPNOTSUPP;
+	}
+
+	/* Only channel handler is used, can discard old channel ID value */
+	channel->channel_hdl = param[0].u.value.a;
+	channel->caps = caps;
+
+	return 0;
+}
+
+/* Invocation of the PTA through a regular command invoke */
+static int invoke_process_smt_channel(struct optee_scmi_channel *channel)
+{
+	int ret;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[1];
+
+	if (!(channel->caps & PTA_SCMI_CAPS_SMT_HEADER))
+		return -EINVAL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	inv_arg.func = PTA_SCMI_CMD_PROCESS_SMT_CHANNEL;
+	inv_arg.session = channel->tee_session;
+	inv_arg.num_params = 1;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = channel->channel_hdl;
+
+	ret = tee_client_invoke_func(channel->agent->tee_ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret) {
+		dev_err(channel->agent->dev, "Failed on channel handle %u: 0x%x\n",
+			channel->channel_hdl, inv_arg.ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool optee_chan_available(struct device *dev, int idx)
+{
+	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
+
+	if (!np)
+		return false;
+
+	of_node_put(np);
+
+	return true;
+}
+
+static int optee_chan_setup_shmem(struct scmi_chan_info *cinfo, bool tx,
+				  struct optee_scmi_channel *channel)
+{
+	struct device *cdev = cinfo->dev;
+	struct device_node *np;
+	resource_size_t size;
+	struct resource res;
+	int ret;
+
+	np = of_parse_phandle(cdev->of_node, "shmem", 0);
+	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+	if (ret) {
+		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
+		return ret;
+	}
+
+	size = resource_size(&res);
+
+	channel->shmem = devm_ioremap(cdev, res.start, size);
+	if (!channel->shmem) {
+		dev_err(cdev, "failed to ioremap SCMI Tx shared memory\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	return 0;
+}
+
+static void optee_clear_channel(struct scmi_chan_info *cinfo)
+{
+	struct optee_scmi_channel *channel = cinfo->transport_info;
+
+	shmem_clear_channel(channel->shmem);
+}
+
+static int optee_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
+			    bool tx)
+{
+	struct device *cdev = cinfo->dev;
+	struct optee_scmi_channel *channel;
+	int ret, idx = tx ? 0 : 1;
+
+	/* Shall wait for OP-TEE driver to be up and ready */
+	if (!agent_private || !agent_private->tee_ctx)
+		return -EPROBE_DEFER;
+
+	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+
+	ret = optee_chan_setup_shmem(cinfo, tx, channel);
+	if (ret)
+		return ret;
+
+	cinfo->transport_info = channel;
+	channel->cinfo = cinfo;
+	channel->agent = agent_private;
+
+	ret = open_session(channel->agent, &channel->tee_session);
+	if (ret)
+		return ret;
+
+	ret = get_channel(channel);
+	if (ret)
+		goto err;
+
+	mutex_init(&channel->mu);
+
+	mutex_lock(&list_mutex);
+	list_add(&channel->link, &channel->agent->channel_list);
+	mutex_unlock(&list_mutex);
+
+	return 0;
+
+err:
+	close_session(channel->agent, channel->tee_session);
+	channel->tee_session = 0;
+
+	return ret;
+}
+
+static int optee_chan_free(int id, void *p, void *data)
+{
+	struct scmi_chan_info *cinfo = p;
+	struct optee_scmi_channel *channel = cinfo->transport_info;
+
+	mutex_lock(&list_mutex);
+	list_del(&channel->link);
+	mutex_unlock(&list_mutex);
+
+	cinfo->transport_info = NULL;
+	channel->cinfo = NULL;
+
+	scmi_free_channel(cinfo, data, id);
+
+	return 0;
+}
+
+static struct scmi_shared_mem *get_channel_shm(struct optee_scmi_channel *chan,
+					       struct scmi_xfer *xfer)
+{
+	if (!chan)
+		return NULL;
+
+	return chan->shmem;
+}
+
+static int optee_send_message(struct scmi_chan_info *cinfo,
+			      struct scmi_xfer *xfer)
+{
+	struct optee_scmi_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem;
+	int ret = 0;
+
+	if (!channel && !channel->agent && !channel->agent->tee_ctx)
+		return -ENODEV;
+
+	shmem = get_channel_shm(channel, xfer);
+
+	mutex_lock(&channel->mu);
+	shmem_tx_prepare(shmem, xfer);
+
+	ret = invoke_process_smt_channel(channel);
+
+	scmi_rx_callback(cinfo, shmem_read_header(shmem));
+	mutex_unlock(&channel->mu);
+
+	return ret;
+}
+
+static void optee_fetch_response(struct scmi_chan_info *cinfo,
+				 struct scmi_xfer *xfer)
+{
+	struct optee_scmi_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+
+	shmem_fetch_response(shmem, xfer);
+}
+
+static bool optee_poll_done(struct scmi_chan_info *cinfo,
+			    struct scmi_xfer *xfer)
+{
+	struct optee_scmi_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+
+	return shmem_poll_done(shmem, xfer);
+}
+
+static struct scmi_transport_ops scmi_optee_ops = {
+	.chan_available = optee_chan_available,
+	.chan_setup = optee_chan_setup,
+	.chan_free = optee_chan_free,
+	.send_message = optee_send_message,
+	.fetch_response = optee_fetch_response,
+	.clear_channel = optee_clear_channel,
+	.poll_done = optee_poll_done,
+};
+
+const struct scmi_desc scmi_optee_desc = {
+	.ops = &scmi_optee_ops,
+	.max_rx_timeout_ms = 30, /* We may increase this if required */
+	.max_msg = 8,
+	.max_msg_size = 128,
+};
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static int optee_scmi_probe(struct device *dev)
+{
+	struct optee_scmi_agent *agent;
+	struct tee_context *tee_ctx;
+	int ret;
+
+	tee_ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(tee_ctx))
+		return -ENODEV;
+
+	agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
+	if (!agent) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	agent->dev = dev;
+	agent->tee_ctx = tee_ctx;
+
+	ret = get_capabilities(agent);
+	if (ret)
+		goto err;
+
+	/* We currently support only 1 OP-TEE device */
+	if (WARN_ON(agent_private)) {
+		ret = -EINVAL;
+		goto err;
+	}
+	agent_private = agent;
+
+	INIT_LIST_HEAD(&agent->channel_list);
+
+	dev_dbg(dev, "OP-TEE SCMI channel probed\n");
+
+	return 0;
+
+err:
+	tee_client_close_context(tee_ctx);
+	return ret;
+}
+
+static int optee_scmi_remove(struct device *dev)
+{
+	struct optee_scmi_channel *channel;
+	struct list_head *elt, *n;
+
+	mutex_lock(&list_mutex);
+	list_for_each_safe(elt, n, &agent_private->channel_list) {
+		channel = list_entry(elt, struct optee_scmi_channel, link);
+		list_del(&channel->link);
+	}
+	mutex_unlock(&list_mutex);
+
+	tee_client_close_context(agent_private->tee_ctx);
+
+	agent_private = NULL;
+
+	return 0;
+}
+
+static const struct tee_client_device_id optee_scmi_id_table[] = {
+	{
+		UUID_INIT(0xa8cfe406, 0xd4f5, 0x4a2e,
+			  0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(tee, optee_scmi_id_table);
+
+static struct tee_client_driver optee_scmi_driver = {
+	.id_table	= optee_scmi_id_table,
+	.driver		= {
+		.name = DRIVER_NAME,
+		.bus = &tee_bus_type,
+		.probe = optee_scmi_probe,
+		.remove = optee_scmi_remove,
+	},
+};
+
+static int __init optee_scmi_init(void)
+{
+	return driver_register(&optee_scmi_driver.driver);
+}
+
+static void __exit optee_scmi_exit(void)
+{
+	driver_unregister(&optee_scmi_driver.driver);
+}
+
+module_init(optee_scmi_init);
+module_exit(optee_scmi_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Etienne Carriere <etienne.carriere@linaro.org>");
+MODULE_DESCRIPTION("OP-TEE SCMI transport driver");
-- 
2.17.1

