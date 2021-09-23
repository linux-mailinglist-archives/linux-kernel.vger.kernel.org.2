Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A499416189
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhIWPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:00:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241839AbhIWPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:00:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51DF112FC;
        Thu, 23 Sep 2021 07:58:33 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3163F718;
        Thu, 23 Sep 2021 07:58:31 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 03/13] firmware: arm_scmi: Add forced polling support to mailbox transport
Date:   Thu, 23 Sep 2021 15:57:52 +0100
Message-Id: <20210923145802.50938-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923145802.50938-1-cristian.marussi@arm.com>
References: <20210923145802.50938-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Kernel configuration option to force polling mode operation on the
TX path for SCMI Mailbox transport even when completion IRQ mechanism is
available.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig   | 10 ++++++++++
 drivers/firmware/arm_scmi/mailbox.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 3d7081e84853..62517417848b 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -54,6 +54,16 @@ config ARM_SCMI_TRANSPORT_MAILBOX
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on mailboxes, answer Y.
 
+config ARM_SCMI_TRANSPORT_MAILBOX_FORCE_POLLING
+	bool "Force polling mode for SCMI Mailbox"
+	depends on ARM_SCMI_TRANSPORT_MAILBOX
+	help
+	  Force polling mode for SCMI Mailbox transports.
+
+	  If you want the whole SCMI Mailbox transport to use polling mode on
+	  the TX path and do not use any completion IRQ facility even when
+	  available, answer Y. If unsure, say N.
+
 config ARM_SCMI_TRANSPORT_SMC
 	bool "SCMI transport based on SMC"
 	depends on HAVE_ARM_SMCCC_DISCOVERY
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index e09eb12bf421..4839deebee6b 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -201,4 +201,5 @@ const struct scmi_desc scmi_mailbox_desc = {
 	.max_rx_timeout_ms = 30, /* We may increase this if required */
 	.max_msg = 20, /* Limited by MBOX_TX_QUEUE_LEN */
 	.max_msg_size = 128,
+	.force_polling = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX_FORCE_POLLING),
 };
-- 
2.17.1

