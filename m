Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E747C4317A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhJRLno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJRLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:43:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25466C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:41:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so40735314wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HU49kdSZlXfJsHh3n1FYDHKTTW2yz6H3NoV36qQXdWI=;
        b=pstQneN05iPy2bqRhu5mK6vZIJPmfPtpA9Kaue2yTOqPymSA2aSWcxGYNGI8fRGGiV
         QhZcJ4V1H9yRML/RA+Me0YsXT+x+YRyockvrBKvAizpk3uJ/2KCNVnJfqyQZsagODct+
         rzsIs0Duc1EONteELAo0tFmFnkznBDqFHzDhTc6EUTRWavqvBYiO1hj9R+qt+SbdtxiE
         xwsW95V+xnmzd0exKI81b8QyK5aYlw6WbMLkLvzClRbXO+x8BAkSCng/6x07Vbj45loe
         Ke45CMiEx4S/YCb19q4dqC49d+6B+1YjZOagN+x/Ka0vnOMvjLWOGK49YvevybYzorg7
         oZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HU49kdSZlXfJsHh3n1FYDHKTTW2yz6H3NoV36qQXdWI=;
        b=2NAv1yHDDnEqePP/KV1pDQ7N2WPX3fP7ic+cIKFOBsqVRGGf8Pph71lO1hxiD5CbVZ
         QQ/XHZHN47TirIjuMmftGE5is9RFCT0uDPlYotmTpribhdgu0Np1Q7IjeiisOfXtC7Wv
         KiQe5TwEo546h+SCsJ4jG8+o0tO/AIkG317CLzP3Ya9gjXVT7vcGuArbJFFnu0Rdb+Bh
         NvRPdWC0BTlJ2EMAg4gbD0xdwLLrnu+soeVxPe8CJ8aV32Wq7j2dPxYI+OJKKfjcUSue
         8HJ081aKXylYsn9L5VDBhKqnhYfAB7OouK3LBPza3SwPxFQvYm7wkgD76GqgF641Tfhl
         o87Q==
X-Gm-Message-State: AOAM530Oi/GDRG+vk5HQXGPwxlIO+Tll1xEXuWttbJM7hpEtLazfV5az
        OingFWuiZ0YczUmRlt+8/dTR4GbeE3g=
X-Google-Smtp-Source: ABdhPJygNJX28fzovPbjDlb4rKe94Ah2VRzB8FFSpI41ijfUtuBJx9NEJt4Hf46ZxaFoXIUbNqHZ+g==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr35400540wro.101.1634557289202;
        Mon, 18 Oct 2021 04:41:29 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:1042:58b3:f8bd:7b81:c866:9456])
        by smtp.gmail.com with ESMTPSA id p18sm13595588wrt.54.2021.10.18.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:41:28 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v3 2/2] firmware: arm_scmi: Add optee transport
Date:   Mon, 18 Oct 2021 13:40:46 +0200
Message-Id: <20211018114046.25571-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211018114046.25571-1-etienne.carriere@linaro.org>
References: <20211018114046.25571-1-etienne.carriere@linaro.org>
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
 drivers/firmware/arm_scmi/optee.c  | 559 +++++++++++++++++++++++++++++
 5 files changed, 578 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/optee.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 3d7081e84853..9107e249023c 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -77,6 +77,18 @@ config ARM_SCMI_TRANSPORT_VIRTIO
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on VirtIO, answer Y.
 
+config ARM_SCMI_TRANSPORT_OPTEE
+	bool "SCMI transport based on OP-TEE service"
+	depends on OPTEE
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
index dea1bfbe1052..82ff3c3a6d2d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -421,6 +421,9 @@ extern const struct scmi_desc scmi_smc_desc;
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 extern const struct scmi_desc scmi_virtio_desc;
 #endif
+#ifdef CONFIG_OPTEE
+extern const struct scmi_desc scmi_optee_desc;
+#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b406b3f78f46..06f0a9846c7e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1999,6 +1999,9 @@ static const struct of_device_id scmi_of_match[] = {
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
+#endif
+#ifdef CONFIG_OPTEE
+	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
 #endif
 	{ /* Sentinel */ },
 };
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
new file mode 100644
index 000000000000..e294cff37bea
--- /dev/null
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -0,0 +1,559 @@
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
+#define DRIVER_NAME "optee-scmi"
+
+enum optee_smci_pta_cmd {
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
+ * Capabilities
+ */
+enum pta_scmi_caps {
+	PTA_SCMI_CAPS_NONE = 0,
+	/*
+	 * Supports command using SMT header protocol (SCMI shmem) in shared
+	 * memory buffers to carry SCMI protocol synchronisation information.
+	 */
+	PTA_SCMI_CAPS_SMT_HEADER = BIT(0),
+};
+
+/**
+ * struct optee_channel - Description of an OP-TEE SCMI channel
+ *
+ * @channel_id: OP-TEE channel ID used for this transport
+ * @mu: Mutex protection on channel access
+ * @tee_session: TEE session identifier
+ * @cinfo: SCMI channel information
+ * @shmem: Virtual base address of the shared memory
+ * @tee_shm: Reference to TEE shared memory or NULL if using static shmem
+ * @caps: OP-TEE SCMI channel capabilities
+ * @link: Reference in agent's channel list
+ */
+struct optee_channel {
+	u32 channel_id;
+	struct mutex mu;
+	u32 tee_session;
+	struct scmi_chan_info *cinfo;
+	struct scmi_shared_mem __iomem *shmem;
+	struct tee_shm *tee_shm;
+	enum pta_scmi_caps caps;
+	struct list_head link;
+};
+
+/**
+ * struct optee_agent - OP-TEE transport private data
+ *
+ * @dev: Device used for communication with TEE
+ * @tee_ctx: TEE context used for communication
+ * @caps: Supported channel capabilities
+ * @mu: Mutex for protection of @channel_list
+ * @channel_list: List of all created channels for the agent
+ */
+struct optee_agent {
+	struct device *dev;
+	struct tee_context *tee_ctx;
+	enum pta_scmi_caps caps;
+	struct mutex mu;
+	struct list_head channel_list;
+};
+
+/* There can be only 1 SCMI service in OP-TEE we connect to */
+static struct optee_agent *optee_private;
+
+/* Open a session toward SCMI OP-TEE service with REE_KERNEL identity */
+static int open_session(u32 *tee_session)
+{
+	struct device *dev = optee_private->dev;
+	struct tee_client_device *scmi_pta = to_tee_client_device(dev);
+	struct tee_ioctl_open_session_arg arg = { };
+	int ret;
+
+	memcpy(arg.uuid, scmi_pta->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret = tee_client_open_session(optee_private->tee_ctx, &arg, NULL);
+	if (ret < 0 || arg.ret) {
+		dev_err(dev, "Can't open tee session: %d / %#x\n", ret, arg.ret);
+
+		return -EOPNOTSUPP;
+	}
+
+	*tee_session = arg.session;
+
+	return 0;
+}
+
+static void close_session(u32 tee_session)
+{
+	tee_client_close_session(optee_private->tee_ctx, tee_session);
+}
+
+static int get_capabilities(void)
+{
+	struct optee_agent *agent = optee_private;
+	struct tee_ioctl_invoke_arg arg = { };
+	struct tee_param param[1] = { };
+	u32 tee_session;
+	int ret;
+
+	ret = open_session(&tee_session);
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
+	close_session(tee_session);
+
+	if (ret < 0 || arg.ret) {
+		dev_err(agent->dev, "Can't get capabilities: %d / %#x\n", ret, arg.ret);
+
+		return -EOPNOTSUPP;
+	}
+
+	agent->caps = param[0].u.value.a;
+
+	if (!(agent->caps & PTA_SCMI_CAPS_SMT_HEADER)) {
+		dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\n");
+
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int get_channel(struct optee_channel *channel)
+{
+	struct device *dev = optee_private->dev;
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
+	ret = tee_client_invoke_func(optee_private->tee_ctx, &arg, param);
+
+	if (ret || arg.ret) {
+		dev_err(dev, "Can't get channel with caps %#x: %d / %#x\n", caps, ret, arg.ret);
+
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
+static int invoke_process_smt_channel(struct optee_channel *channel)
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
+		const size_t msg_size = scmi_optee_desc.max_msg_size;
+
+		param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+		param[1].u.memref.shm = channel->tee_shm;
+		param[1].u.memref.size = msg_size;
+		arg.num_params = 2;
+		arg.func = PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE;
+	} else {
+		arg.num_params = 1;
+		arg.func = PTA_SCMI_CMD_PROCESS_SMT_CHANNEL;
+	}
+
+	ret = tee_client_invoke_func(optee_private->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret) {
+		dev_err(optee_private->dev, "Failed on channel %u: %d / %#x\n",
+			channel->channel_id, ret, arg.ret);
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool optee_chan_available(struct device *dev, int idx)
+{
+	u32 channel_id;
+
+	return !of_property_read_u32_index(dev->of_node, "linaro,optee-channel-id",
+					   idx, &channel_id);
+}
+
+static int setup_dynamic_shmem(struct device *dev, struct optee_channel *channel)
+{
+	const size_t msg_size = scmi_optee_desc.max_msg_size;
+
+	channel->tee_shm = tee_shm_alloc_kernel_buf(optee_private->tee_ctx, msg_size);
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
+			      struct optee_channel *channel)
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
+static int optee_chan_setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
+				  bool tx, struct optee_channel *channel)
+{
+	struct device *cdev = cinfo->dev;
+
+	if (of_find_property(cdev->of_node, "shmem", NULL))
+		return setup_static_shmem(dev, cinfo, channel);
+	else
+		return setup_dynamic_shmem(dev, channel);
+}
+
+static void optee_clear_channel(struct scmi_chan_info *cinfo)
+{
+	struct optee_channel *channel = cinfo->transport_info;
+
+	shmem_clear_channel(channel->shmem);
+}
+
+static int optee_chan_setup(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
+{
+	struct optee_channel *channel;
+	uint32_t channel_id;
+	int ret;
+
+	if (!tx)
+		return -ENODEV;
+
+	/* Shall wait for OP-TEE driver to be up and ready */
+	if (!optee_private || !optee_private->tee_ctx)
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
+	ret = optee_chan_setup_shmem(dev, cinfo, tx, channel);
+	if (ret)
+		return ret;
+
+	ret = open_session(&channel->tee_session);
+	if (ret)
+		return ret;
+
+	ret = get_channel(channel);
+	if (ret) {
+		close_session(channel->tee_session);
+
+		return ret;
+	}
+
+	mutex_lock(&optee_private->mu);
+	list_add(&channel->link, &optee_private->channel_list);
+	mutex_unlock(&optee_private->mu);
+
+	return 0;
+}
+
+static int optee_chan_free(int id, void *p, void *data)
+{
+	struct scmi_chan_info *cinfo = p;
+	struct optee_channel *channel = cinfo->transport_info;
+
+	mutex_lock(&optee_private->mu);
+	list_del(&channel->link);
+	mutex_unlock(&optee_private->mu);
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
+static struct scmi_shared_mem *get_channel_shm(struct optee_channel *chan, struct scmi_xfer *xfer)
+{
+	if (!chan)
+		return NULL;
+
+	return chan->shmem;
+}
+
+
+static int optee_send_message(struct scmi_chan_info *cinfo,
+			      struct scmi_xfer *xfer)
+{
+	struct optee_channel *channel = cinfo->transport_info;
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
+static void optee_fetch_response(struct scmi_chan_info *cinfo,
+				 struct scmi_xfer *xfer)
+{
+	struct optee_channel *channel = cinfo->transport_info;
+	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+
+	shmem_fetch_response(shmem, xfer);
+}
+
+static bool optee_poll_done(struct scmi_chan_info *cinfo,
+			    struct scmi_xfer *xfer)
+{
+	struct optee_channel *channel = cinfo->transport_info;
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
+	.max_rx_timeout_ms = 30,
+	.max_msg = 20,
+	.max_msg_size = 128,
+};
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static int optee_service_probe(struct device *dev)
+{
+	struct optee_agent *agent;
+	struct tee_context *tee_ctx;
+	int ret;
+
+	/* Only one SCMI OP-TEE device allowed */
+	if (optee_private) {
+		dev_err(dev, "An SCMI OP-TEE device was already initialized: only one allowed\n");
+		return -EBUSY;
+	}
+
+	tee_ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(tee_ctx))
+		return -ENODEV;
+
+	agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
+	if (!agent) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	agent->dev = dev;
+	agent->tee_ctx = tee_ctx;
+	INIT_LIST_HEAD(&agent->channel_list);
+
+	optee_private = agent;
+
+	ret = get_capabilities();
+
+out:
+	if (ret) {
+		tee_client_close_context(tee_ctx);
+		optee_private = NULL;
+	}
+
+	return ret;
+}
+
+static int optee_service_remove(struct device *dev)
+{
+	if (optee_private)
+		return -EINVAL;
+
+	if (!list_empty(&optee_private->channel_list))
+		return -EBUSY;
+
+	tee_client_close_context(optee_private->tee_ctx);
+
+	optee_private = NULL;
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
+		.probe = optee_service_probe,
+		.remove = optee_service_remove,
+	},
+};
+
+static int __init scmi_optee_init(void)
+{
+	return driver_register(&scmi_optee_driver.driver);
+}
+
+static void __exit scmi_optee_exit(void)
+{
+	driver_unregister(&scmi_optee_driver.driver);
+}
+
+device_initcall(scmi_optee_init)
+module_exit(scmi_optee_exit);
-- 
2.17.1

