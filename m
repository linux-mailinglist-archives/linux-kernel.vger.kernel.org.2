Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF833C5E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhGLOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:22:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234988AbhGLOWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:22:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF7831B;
        Mon, 12 Jul 2021 07:19:14 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC763F774;
        Mon, 12 Jul 2021 07:19:11 -0700 (PDT)
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
Subject: [PATCH v6 05/17] firmware: arm_scmi: Add transport optional init/exit support
Date:   Mon, 12 Jul 2021 15:18:21 +0100
Message-Id: <20210712141833.6628-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SCMI transport could need to perform some transport specific setup
before they can be used by the SCMI core transport layer: typically this
early setup consists in registering with some other kernel subsystem.

Add the optional capability for a transport to provide a couple of .init
and .exit functions that are assured to be called early during the SCMI
core initialization phase, well before the SCMI core probing step.

[ Peter: Adapted RFC patch by Cristian for submission to upstream. ]
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: Fixed scmi_transports_exit point of invocation ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> V5
- removed useless pr_debug
- moved scmi_transport_exit() invocation
---
 drivers/firmware/arm_scmi/common.h |  8 +++++
 drivers/firmware/arm_scmi/driver.c | 56 ++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7c2b9fd7e929..6bb734e0e3ac 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -321,6 +321,12 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
 /**
  * struct scmi_desc - Description of SoC integration
  *
+ * @init: An optional function that a transport can provide to initialize some
+ *	  transport-specific setup during SCMI core initialization, so ahead of
+ *	  SCMI core probing.
+ * @exit: An optional function that a transport can provide to de-initialize
+ *	  some transport-specific setup during SCMI core de-initialization, so
+ *	  after SCMI core removal.
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
  * @max_msg: Maximum number of messages that can be pending
@@ -328,6 +334,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
+	int (*init)(void);
+	void (*exit)(void);
 	const struct scmi_transport_ops *ops;
 	int max_rx_timeout_ms;
 	int max_msg;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d2c183fa7949..4c77ee13b1ad 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1578,10 +1578,64 @@ static struct platform_driver scmi_driver = {
 	.remove = scmi_remove,
 };
 
+/**
+ * __scmi_transports_setup  - Common helper to call transport-specific
+ * .init/.exit code if provided.
+ *
+ * @init: A flag to distinguish between init and exit.
+ *
+ * Note that, if provided, we invoke .init/.exit functions for all the
+ * transports currently compiled in.
+ *
+ * Return: 0 on Success.
+ */
+static inline int __scmi_transports_setup(bool init)
+{
+	int ret = 0;
+	const struct of_device_id *trans;
+
+	for (trans = scmi_of_match; trans->data; trans++) {
+		const struct scmi_desc *tdesc = trans->data;
+
+		if ((init && !tdesc->init) || (!init && !tdesc->exit))
+			continue;
+
+		if (init)
+			ret = tdesc->init();
+		else
+			tdesc->exit();
+
+		if (ret) {
+			pr_err("SCMI transport %s FAILED initialization!\n",
+			       trans->compatible);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int __init scmi_transports_init(void)
+{
+	return __scmi_transports_setup(true);
+}
+
+static void __exit scmi_transports_exit(void)
+{
+	__scmi_transports_setup(false);
+}
+
 static int __init scmi_driver_init(void)
 {
+	int ret;
+
 	scmi_bus_init();
 
+	/* Initialize any compiled-in transport which provided an init/exit */
+	ret = scmi_transports_init();
+	if (ret)
+		return ret;
+
 	scmi_base_register();
 
 	scmi_clock_register();
@@ -1610,6 +1664,8 @@ static void __exit scmi_driver_exit(void)
 
 	scmi_bus_exit();
 
+	scmi_transports_exit();
+
 	platform_driver_unregister(&scmi_driver);
 }
 module_exit(scmi_driver_exit);
-- 
2.17.1

