Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29F435227
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJTSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhJTSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:00:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2851C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:57:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g25so150485wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fJX0ti3dI4tpISf4vmFcIwIRvivEVcLjUPflsSs7ga0=;
        b=gypZ/mF3+WzyMiGQ4fFO7Yj6RYlDeUKnaTAhpPUUYEPh9WFGe0OwZLA/eWmeRdJdCQ
         CFEde0VPsC+TN0m9ttt++A5ikQuuV7pi6O+GB9ItkmMjt9dDzZ/eq8SXrUFiKXmEM4Qu
         b6D01yRCHeC5FTQPt/GiJn5U9gC+p3VDfbF8/uAxNaG9v7kZZHZOW6ipDi3+AGQNTGHS
         ybnAvXvYqZhJaPaE9WPO/V9aZ/5bltM5HOGRKtZMJSQDWujaneg677uSwJjyFoYl13Zf
         CormbiRA3E3wUCfkLaXub4BQ8rEIy2dh9VButODzM2hNXErU0GufKzGlaogSxdidhE37
         2aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fJX0ti3dI4tpISf4vmFcIwIRvivEVcLjUPflsSs7ga0=;
        b=2eRE/eKlDGC3WZkCrXpUfz39GB9Ry/9X8EdpCf7JNjlGpNwSRiYu9I8AeM4bDZo21/
         VXqxDKJ1hbO1x7ZehcCpq7ojN9CdzEktmm32tmuGN3Ju0eNBVlaBVginQeFgt9Oll7He
         qeBfI//EsW1Nv6K8uVluQDTFkD9CHMlSF5KmoUj1EQYRPpoLB/CORU41dvx58iZ+pFHS
         zGSgCo1kFxSd6gi72QWSwp7/BhwRk/IuKuURvxY6fy6U0S+5AGc2L9Nurha+hGmgYkIJ
         XpDpDtjak6/Ex4xAphVraMdpaJa1vYHdttdwHiz/+GF37KQVym6Id6E3WtA3IyFPIX6X
         ceFw==
X-Gm-Message-State: AOAM530HcRh9KfJ4FUIguDzH6wAfcQxyPeHFOyDbyX+NfvG7kLx4cAZp
        /xqntbfMZN/sn5rX7YvDvpBtPAlA2wnw3g==
X-Google-Smtp-Source: ABdhPJxhuKOJ+tG4dArarcnsHYLx04a/V4hhcnwQ3S1WfympJGKsvxJBAU9FX/yV2Q0JkOPgP0c3ZQ==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr863808wru.290.1634752675732;
        Wed, 20 Oct 2021 10:57:55 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800f8bd7b81c8669456.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:f8bd:7b81:c866:9456])
        by smtp.gmail.com with ESMTPSA id s3sm2609227wrm.40.2021.10.20.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:57:55 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v4 2/2] firmware: arm_scmi: Add optee transport
Date:   Wed, 20 Oct 2021 19:57:47 +0200
Message-Id: <20211020175747.28449-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211020175747.28449-1-etienne.carriere@linaro.org>
References: <20211020175747.28449-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new transport channel to the SCMI firmware interface driver for
SCMI message exchange based on optee transport channel. The optee
transport is realized by connecting and invoking OP-TEE SCMI service
interface PTA.

Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
enabled when optee driver (CFG_OPTEE) is enabled. Effective optee
transport is setup upon OP-TEE SCMI service discovery at optee
device initialization. For this SCMI UUID is registered to the optee
bus for probing. This is done at device_init initcall level, after
optee bus initialization that is done at subsys_init level, as the scmi
driver initialization.

The optee transport can use a statically defined shared memory in
which case SCMI device tree node defines it using an "arm,scmi-shmem"
compatible phandle through property shmem. Alternatively, optee transport
allocates the shared memory buffer from the optee driver when no shmem
property is defined.

The protocol used to exchange SCMI message over that shared memory is
negotiated between optee transport driver and the OP-TEE service through
capabilities exchange.

OP-TEE SCMI service is integrated in OP-TEE since its release tag 3.13.0.
The service interface is published in [1].

Link: [1] https://github.com/OP-TEE/optee_os/blob/3.13.0/lib/libutee/include/pta_scmi_client.h
Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v3:
 - Fix use of configuration switches when CONFIG_OPTEE and
   CONFIG_ARM_SCMI_PROTOCOL are enabled/modules/disabled.
   Mimics scmi virtio integration.
 - Implement link_supplier operator for the scmi_optee transport
   to possibly defer probing when optee bus has not yet enumerated
   the SCMI OP-TEE service. The function ensures scmi_optee registers
   to optee bus enumeration when probe is deferred.
 - Add memory barriers to protect global optee service reference
   when it's updated at transport initialization and removal.
 - Replace enum pta_scmi_caps with macro definitions as enumerated
   types do not really match bit flags definitions. The capabilities
   data is now of type u32.
 - Use scmi_optee_ prefix for scmi transport operator handles
   and few other resources.
 - Fix typo: s/optee_smci_pta_cmd/optee_scmi_pta_cmd/
 - Remove useless DRIVER_NAME.
 - Minor reordering in struct optee_channel.
 - Removed some useless empty lines.

Changes since v2:
- Rebase on for-next/scmi, based on Linux v5.15-rc1.
- Implement support for dynamic and static shared memory.
- Factorize some functions and simplify transport exit sequence.
- Rename driver source file from optee_service.c to optee.c.

No change since v1
---
 drivers/firmware/arm_scmi/Kconfig  |  12 +
 drivers/firmware/arm_scmi/Makefile |   1 +
 drivers/firmware/arm_scmi/common.h |   3 +
 drivers/firmware/arm_scmi/driver.c |   3 +
 drivers/firmware/arm_scmi/optee.c  | 585 +++++++++++++++++++++++++++++
 5 files changed, 604 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/optee.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 3d7081e84853..30746350349c 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -77,6 +77,18 @@ config ARM_SCMI_TRANSPORT_VIRTIO
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on VirtIO, answer Y.
 
+config ARM_SCMI_TRANSPORT_OPTEE
+	bool "SCMI transport based on OP-TEE service"
+	depends on OPTEE=y || OPTEE=ARM_SCMI_PROTOCOL
+	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
+	default y
+	help
+	  This enables the OP-TEE service based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on OP-TEE SCMI service, answer Y.
+
 endif #ARM_SCMI_PROTOCOL
 
 config ARM_SCMI_POWER_DOMAIN
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 1dcf123d64ab..ef66ec8ca917 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -6,6 +6,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
+scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index dea1bfbe1052..6438b5248c24 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -421,6 +421,9 @@ extern const struct scmi_desc scmi_smc_desc;
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 extern const struct scmi_desc scmi_virtio_desc;
 #endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
+extern const struct scmi_desc scmi_optee_desc;
+#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b406b3f78f46..e3f87e0c4936 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1999,6 +1999,9 @@ static const struct of_device_id scmi_of_match[] = {
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
+#endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
+	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
 #endif
 	{ /* Sentinel */ },
 };
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
new file mode 100644
index 000000000000..ce7f7088ebae
--- /dev/null
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2021 Linaro Ltd.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+#include <uapi/linux/tee.h>
+
+#include "common.h"
+
+#define SCMI_OPTEE_MAX_MSG_SIZE		128
+
+enum scmi_optee_pta_cmd {
+	/*
+	 * PTA_SCMI_CMD_CAPABILITIES - Get channel capabilities
+	 *
+	 * [out]    value[0].a: Capability bit mask (enum pta_scmi_caps)
+	 * [out]    value[0].b: Extended capabilities or 0
+	 */
+	PTA_SCMI_CMD_CAPABILITIES = 0,
+
+	/*
+	 * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL - Process SCMI message in SMT buffer
+	 *
+	 * [in]     value[0].a: Channel handle
+	 *
+	 * Shared memory used for SCMI message/response exhange is expected
+	 * already identified and bound to channel handle in both SCMI agent
+	 * and SCMI server (OP-TEE) parts.
+	 * The memory uses SMT header to carry SCMI meta-data (protocol ID and
+	 * protocol message ID).
+	 */
+	PTA_SCMI_CMD_PROCESS_SMT_CHANNEL = 1,
+
+	/*
+	 * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE - Process SMT/SCMI message
+	 *
+	 * [in]     value[0].a: Channel handle
+	 * [in/out] memref[1]: Message/response buffer (SMT and SCMI payload)
+	 *
+	 * Shared memory used for SCMI message/response is a SMT buffer
+	 * referenced by param[1]. It shall be 128 bytes large to fit response
+	 * payload whatever message playload size.
+	 * The memory uses SMT header to carry SCMI meta-data (protocol ID and
+	 * protocol message ID).
+	 */
+	PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE = 2,
+
+	/*
+	 * PTA_SCMI_CMD_GET_CHANNEL - Get channel handle
+	 *
+	 * SCMI shm information are 0 if agent expects to use OP-TEE regular SHM
+	 *
+	 * [in]     value[0].a: Channel identifier
+	 * [out]    value[0].a: Returned channel handle
+	 * [in]     value[0].b: Requested capabilities mask (enum pta_scmi_caps)
+	 */
+	PTA_SCMI_CMD_GET_CHANNEL = 3,
+};
+
+/*
+ * OP-TEE SCMI service capabilities bit flags (32bit)
+ *
+ * PTA_SCMI_CAPS_SMT_HEADER
+ * When set, OP-TEE supports command using SMT header protocol (SCMI shmem) in
+ * shared memory buffers to carry SCMI protocol synchronisation information.
+ */
+#define PTA_SCMI_CAPS_NONE		0
+#define PTA_SCMI_CAPS_SMT_HEADER	BIT(0)
+
+/**
+ * struct scmi_optee_channel - Description of an OP-TEE SCMI channel
+ *
+ * @channel_id: OP-TEE channel ID used for this transport
+ * @tee_session: TEE session identifier
+ * @caps: OP-TEE SCMI channel capabilities
+ * @mu: Mutex protection on channel access
+ * @cinfo: SCMI channel information
+ * @shmem: Virtual base address of the shared memory
+ * @tee_shm: Reference to TEE shared memory or NULL if using static shmem
+ * @link: Reference in agent's channel list
+ */
+struct scmi_optee_channel {
+	u32 channel_id;
+	u32 tee_session;
+	u32 caps;
+	struct mutex mu;
+	struct scmi_chan_info *cinfo;
+	struct scmi_shared_mem __iomem *shmem;
+	struct tee_shm *tee_shm;
+	struct list_head link;
+};
+
+/**
+ * struct scmi_optee_agent - OP-TEE transport private data
+ *
+ * @dev: Device used for communication with TEE
+ * @tee_ctx: TEE context used for communication
+ * @caps: Supported channel capabilities
+ * @mu: Mutex for protection of @channel_list
+ * @channel_list: List of all created channels for the agent
+ */
+struct scmi_optee_agent {
+	struct device *dev;
+	struct tee_context *tee_ctx;
+	u32 caps;
+	struct mutex mu;
+	struct list_head channel_list;
+};
+
+/* There can be only 1 SCMI service in OP-TEE we connect to */
+static struct scmi_optee_agent *scmi_optee_private;
+
+/* Forward reference to scmi_optee transport initialization */
+static int scmi_optee_init(void);
+
+/* Open a session toward SCMI OP-TEE service with REE_KERNEL identity */
+static int open_session(struct scmi_optee_agent *agent, u32 *tee_session)
+{
+	struct device *dev = agent->dev;
+	struct tee_client_device *scmi_pta = to_tee_client_device(dev);
+	struct tee_ioctl_open_session_arg arg = { };
+	int ret;
+
+	memcpy(arg.uuid, scmi_pta->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret = tee_client_open_session(agent->tee_ctx, &arg, NULL);
+	if (ret < 0 || arg.ret) {
+		dev_err(dev, "Can't open tee session: %d / %#x\n", ret, arg.ret);
+		return -EOPNOTSUPP;
+	}
+
+	*tee_session = arg.session;
+
+	return 0;
+}
+
+static void close_session(struct scmi_optee_agent *agent, u32 tee_session)
+{
+	tee_client_close_session(agent->tee_ctx, tee_session);
+}
+
+static int get_capabilities(struct scmi_optee_agent *agent)
+{
+	struct tee_ioctl_invoke_arg arg = { };
+	struct tee_param param[1] = { };
+	u32 caps;
+	u32 tee_session;
+	int ret;
+
+	ret = open_session(agent, &tee_session);
+	if (ret)
+		return ret;
+
+	arg.func = PTA_SCMI_CMD_CAPABILITIES;
+	arg.session = tee_session;
+	arg.num_params = 1;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(agent->tee_ctx, &arg, param);
+
+	close_session(agent, tee_session);
+
+	if (ret < 0 || arg.ret) {
+		dev_err(agent->dev, "Can't get capabilities: %d / %#x\n", ret, arg.ret);
+		return -EOPNOTSUPP;
+	}
+
+	caps = param[0].u.value.a;
+
+	if (!(caps & PTA_SCMI_CAPS_SMT_HEADER)) {
+		dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\n");
+		return -EOPNOTSUPP;
+	}
+
+	agent->caps = caps;
+
+	return 0;
+}
+
+static int get_channel(struct scmi_optee_channel *channel)
+{
+	struct device *dev = scmi_optee_private->dev;
+	struct tee_ioctl_invoke_arg arg = { };
+	struct tee_param param[1] = { };
+	unsigned int caps = PTA_SCMI_CAPS_SMT_HEADER;
+	int ret;
+
+	arg.func = PTA_SCMI_CMD_GET_CHANNEL;
+	arg.session = channel->tee_session;
+	arg.num_params = 1;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
+	param[0].u.value.a = channel->channel_id;
+	param[0].u.value.b = caps;
+
+	ret = tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg, param);
+
+	if (ret || arg.ret) {
+		dev_err(dev, "Can't get channel with caps %#x: %d / %#x\n", caps, ret, arg.ret);
+		return -EOPNOTSUPP;
+	}
+
+	/* From now on use channel identifer provided by OP-TEE SCMI service */
+	channel->channel_id = param[0].u.value.a;
+	channel->caps = caps;
+
+	return 0;
+}
+
+static int invoke_process_smt_channel(struct scmi_optee_channel *channel)
+{
+	struct tee_ioctl_invoke_arg arg = { };
+	struct tee_param param[2] = { };
+	int ret;
+
+	arg.session = channel->tee_session;
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = channel->channel_id;
+
+	if (channel->tee_shm) {
+		param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+		param[1].u.memref.shm = channel->tee_shm;
+		param[1].u.memref.size = SCMI_OPTEE_MAX_MSG_SIZE;
+		arg.num_params = 2;
+		arg.func = PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE;
+	} else {
+		arg.num_params = 1;
+		arg.func = PTA_SCMI_CMD_PROCESS_SMT_CHANNEL;
+	}
+
+	ret = tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret) {
+		dev_err(scmi_optee_private->dev, "Can't invoke channel %u: %d / %#x\n",
+			channel->channel_id, ret, arg.ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Shall wait for OP-TEE driver to be up and ready */
+static bool scmi_optee_service_is_ready(struct device *dev)
+{
+	bool ready = scmi_optee_private && scmi_optee_private->tee_ctx;
+
+	if (!ready) {
+		int ret = scmi_optee_init();
+
+		if (ret)
+			dev_dbg(dev, "Failed to register to optee bus: %d\n", ret);
+	}
+
+	return ready;
+}
+
+static int scmi_optee_link_supplier(struct device *dev)
+{
+	if (!scmi_optee_service_is_ready(dev))
+		return -EPROBE_DEFER;
+
+	if (!device_link_add(dev, scmi_optee_private->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		dev_err(dev, "Adding link to supplier optee device failed\n");
+		return -ECANCELED;
+	}
+
+	return 0;
+}
+
+static bool scmi_optee_chan_available(struct device *dev, int idx)
+{
+	u32 channel_id;
+
+	return !of_property_read_u32_index(dev->of_node, "linaro,optee-channel-id",
+					   idx, &channel_id);
+}
+
+static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
+{
+	struct scmi_optee_channel *channel = cinfo->transport_info;
+
+	shmem_clear_channel(channel->shmem);
+}
+
+static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
+{
+	const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
+
+	channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
+	if (IS_ERR(channel->tee_shm)) {
+		dev_err(channel->cinfo->dev, "shmem allocation failed\n");
+		return -ENOMEM;
+	}
+
+	channel->shmem = (void *)tee_shm_get_va(channel->tee_shm, 0);
+	memset(channel->shmem, 0, msg_size);
+	shmem_clear_channel(channel->shmem);
+
+	return 0;
+}
+
+static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
+			      struct scmi_optee_channel *channel)
+{
+	struct device_node *np;
+	resource_size_t size;
+	struct resource res;
+	int ret;
+
+	np = of_parse_phandle(cinfo->dev->of_node, "shmem", 0);
+	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(dev, "Failed to get SCMI Tx shared memory\n");
+		goto out;
+	}
+
+	size = resource_size(&res);
+
+	channel->shmem = devm_ioremap(dev, res.start, size);
+	if (!channel->shmem) {
+		dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n");
+		ret = -EADDRNOTAVAIL;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	of_node_put(np);
+
+	return ret;
+}
+
+static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
+		       struct scmi_optee_channel *channel)
+{
+	if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
+		return setup_static_shmem(dev, cinfo, channel);
+	else
+		return setup_dynamic_shmem(dev, channel);
+}
+
+static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
+{
+	struct scmi_optee_channel *channel;
+	uint32_t channel_id;
+	int ret;
+
+	if (!tx)
+		return -ENODEV;
+
+	if (!scmi_optee_service_is_ready(dev))
+		return -EPROBE_DEFER;
+
+	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_index(cinfo->dev->of_node, "linaro,optee-channel-id",
+					 0, &channel_id);
+	if (ret)
+		return ret;
+
+	cinfo->transport_info = channel;
+	channel->cinfo = cinfo;
+	channel->channel_id = channel_id;
+	mutex_init(&channel->mu);
+
+	ret = setup_shmem(dev, cinfo, channel);
+	if (ret)
+		return ret;
+
+	ret = open_session(scmi_optee_private, &channel->tee_session);
+	if (ret)
+		return ret;
+
+	ret = get_channel(channel);
+	if (ret) {
+		close_session(scmi_optee_private, channel->tee_session);
+		return ret;
+	}
+
+	mutex_lock(&scmi_optee_private->mu);
+	list_add(&channel->link, &scmi_optee_private->channel_list);
+	mutex_unlock(&scmi_optee_private->mu);
+
+	return 0;
+}
+
+static int scmi_optee_chan_free(int id, void *p, void *data)
+{
+	struct scmi_chan_info *cinfo = p;
+	struct scmi_optee_channel *channel = cinfo->transport_info;
+
+	mutex_lock(&scmi_optee_private->mu);
+	list_del(&channel->link);
+	mutex_unlock(&scmi_optee_private->mu);
+
+	if (channel->tee_shm) {
+		tee_shm_free(channel->tee_shm);
+		channel->tee_shm = NULL;
+	}
+
+	cinfo->transport_info = NULL;
+	channel->cinfo = NULL;
+
+	scmi_free_channel(cinfo, data, id);
+
+	return 0;
+}
+
+static struct scmi_shared_mem *get_channel_shm(struct scmi_optee_channel *chan,
+					       struct scmi_xfer *xfer)
+{
+	if (!chan)
+		return NULL;
+
+	return chan->shmem;
+}
+
+
+static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
+				   struct scmi_xfer *xfer)
+{
+	struct scmi_optee_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+	int ret;
+
+	mutex_lock(&channel->mu);
+	shmem_tx_prepare(shmem, xfer);
+
+	ret = invoke_process_smt_channel(channel);
+
+	scmi_rx_callback(cinfo, shmem_read_header(shmem), NULL);
+	mutex_unlock(&channel->mu);
+
+	return ret;
+}
+
+static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
+				      struct scmi_xfer *xfer)
+{
+	struct scmi_optee_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+
+	shmem_fetch_response(shmem, xfer);
+}
+
+static bool scmi_optee_poll_done(struct scmi_chan_info *cinfo,
+				 struct scmi_xfer *xfer)
+{
+	struct scmi_optee_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+
+	return shmem_poll_done(shmem, xfer);
+}
+
+static struct scmi_transport_ops scmi_optee_ops = {
+	.link_supplier = scmi_optee_link_supplier,
+	.chan_available = scmi_optee_chan_available,
+	.chan_setup = scmi_optee_chan_setup,
+	.chan_free = scmi_optee_chan_free,
+	.send_message = scmi_optee_send_message,
+	.fetch_response = scmi_optee_fetch_response,
+	.clear_channel = scmi_optee_clear_channel,
+	.poll_done = scmi_optee_poll_done,
+};
+
+static int scmi_optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static int scmi_optee_service_probe(struct device *dev)
+{
+	struct scmi_optee_agent *agent;
+	struct tee_context *tee_ctx;
+	int ret;
+
+	/* Only one SCMI OP-TEE device allowed */
+	if (scmi_optee_private) {
+		dev_err(dev, "An SCMI OP-TEE device was already initialized: only one allowed\n");
+		return -EBUSY;
+	}
+
+	tee_ctx = tee_client_open_context(NULL, scmi_optee_ctx_match, NULL, NULL);
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
+	INIT_LIST_HEAD(&agent->channel_list);
+
+	ret = get_capabilities(agent);
+	if (ret)
+		goto err;
+
+	/* Ensure agent resources are all visible before scmi_optee_private is */
+	smp_mb();
+	scmi_optee_private = agent;
+
+	return 0;
+
+err:
+	tee_client_close_context(tee_ctx);
+
+	return ret;
+}
+
+static int scmi_optee_service_remove(struct device *dev)
+{
+	struct scmi_optee_agent *agent = scmi_optee_private;
+
+	if (!scmi_optee_private)
+		return -EINVAL;
+
+	if (!list_empty(&scmi_optee_private->channel_list))
+		return -EBUSY;
+
+	/* Ensure cleared reference is visible before resources are released */
+	smp_store_mb(scmi_optee_private, NULL);
+
+	tee_client_close_context(agent->tee_ctx);
+
+	return 0;
+}
+
+static const struct tee_client_device_id scmi_optee_service_id[] = {
+	{
+		UUID_INIT(0xa8cfe406, 0xd4f5, 0x4a2e,
+			  0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(tee, scmi_optee_service_id);
+
+static struct tee_client_driver scmi_optee_driver = {
+	.id_table	= scmi_optee_service_id,
+	.driver		= {
+		.name = "scmi-optee",
+		.bus = &tee_bus_type,
+		.probe = scmi_optee_service_probe,
+		.remove = scmi_optee_service_remove,
+	},
+};
+
+static int scmi_optee_init(void)
+{
+	return driver_register(&scmi_optee_driver.driver);
+}
+
+static void scmi_optee_exit(void)
+{
+	driver_unregister(&scmi_optee_driver.driver);
+}
+
+const struct scmi_desc scmi_optee_desc = {
+	.transport_exit = scmi_optee_exit,
+	.ops = &scmi_optee_ops,
+	.max_rx_timeout_ms = 30,
+	.max_msg = 20,
+	.max_msg_size = 128,
+};
-- 
2.17.1

