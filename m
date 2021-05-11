Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5A379B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhEKAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:25 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:14836 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhEKA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 962D8A1987;
        Tue, 11 May 2021 02:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=ZmQx0CHn1ZF5
        cPFnLZkXuV6S6R2qGPhY3pMc8jECLR4=; b=il1zd/GZusW0+LGf64dGfIzZfK2X
        6rtXy4NzRDPp/xJ/H9LD/u3lb+mEbrDfkrq0otBFs0FmD7doJa6WYAI8zvzKLuI6
        TzSblCZ08WtYp1Yo8aI/8YXf84U0Ocepsutiw2ruyb7cGCENsKkQc9wVGLr5OA1+
        ygcmRTnfhRIjeRYjGVwoHlKKx3e7W/2qiyQpDfMhXvGq2mkREcmQ9FJNu74y3DED
        bGSdsGny+e/xIUR5Rh1dopIcNptVkHBpsVFOrkJ57mhvGdg2c4j/Y8W/YHsajAm3
        6xbtDEwy46drTlR/JpejC4fPb2HuaBZyFZDnAlBkyykGJq8BOjZ7xSJyTw==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [RFC PATCH v3 01/12] firmware: arm_scmi, smccc, mailbox: Make shmem based transports optional
Date:   Tue, 11 May 2021 02:20:29 +0200
Message-ID: <20210511002040.802226-2-peter.hilber@opensynergy.com>
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

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Upon adding the virtio transport in this patch series, SCMI will also
work without shared memory based transports. Also, the mailbox transport
may not be needed if the smc transport is used.

- Compile shmem.c only if a shmem based transport is available.

- Remove hard dependency of SCMI on mailbox.

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/Kconfig           | 8 +++++++-
 drivers/firmware/arm_scmi/Makefile | 2 +-
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/arm_scmi/driver.c | 2 ++
 drivers/firmware/smccc/Kconfig     | 1 +
 drivers/mailbox/Kconfig            | 1 +
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index db0ea2d2d75a..80ff49dadf35 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX
+	depends on ARM_SCMI_HAVE_SHMEM
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are
@@ -27,6 +27,12 @@ config ARM_SCMI_PROTOCOL
 	  This protocol library provides interface for all the client drivers
 	  making use of the features offered by the SCMI.
 
+config ARM_SCMI_HAVE_SHMEM
+	bool
+	help
+	  This declares whether a shared memory based transport for SCMI is
+	  available.
+
 config ARM_SCMI_POWER_DOMAIN
 	tristate "SCMI power domain driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6a2ef63306d6..5a2d4c32e0ae 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o notify.o
-scmi-transport-y = shmem.o
+scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 228bf4a71d23..94dcfb8c0176 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -330,7 +330,9 @@ struct scmi_desc {
 	int max_msg_size;
 };
 
+#ifdef CONFIG_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
+#endif
 #ifdef CONFIG_HAVE_ARM_SMCCC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 66eb3f0e5daf..41d80bbaa9a2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1567,7 +1567,9 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
+#ifdef CONFIG_MAILBOX
 	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
+#endif
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 #endif
diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
index 15e7466179a6..69c4d6cabf62 100644
--- a/drivers/firmware/smccc/Kconfig
+++ b/drivers/firmware/smccc/Kconfig
@@ -9,6 +9,7 @@ config HAVE_ARM_SMCCC_DISCOVERY
 	bool
 	depends on ARM_PSCI_FW
 	default y
+	select ARM_SCMI_HAVE_SHMEM
 	help
 	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
 	 to add SMCCC discovery mechanism though the PSCI firmware
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 68de2c6af727..fc02c38c0739 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig MAILBOX
 	bool "Mailbox Hardware Support"
+	select ARM_SCMI_HAVE_SHMEM
 	help
 	  Mailbox is a framework to control hardware communication between
 	  on-chip processors through queued messages and interrupt driven
-- 
2.25.1


