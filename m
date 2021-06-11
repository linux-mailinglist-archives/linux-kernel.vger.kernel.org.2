Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6E3A4741
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhFKRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:02:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKRCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:02:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D2C91396;
        Fri, 11 Jun 2021 10:00:45 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70763F719;
        Fri, 11 Jun 2021 10:00:41 -0700 (PDT)
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
Subject: [PATCH v4 06/16] firmware: arm_scmi, smccc, mailbox: Make shmem based transports optional
Date:   Fri, 11 Jun 2021 17:59:27 +0100
Message-Id: <20210611165937.701-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Upon adding the virtio transport in this patch series, SCMI will also
work without shared memory based transports. Also, the mailbox transport
may not be needed if the smc transport is used.

- Compile shmem.c only if a shmem based transport is available.

- Remove hard dependency of SCMI on mailbox.

[ Peter: Adapted patch for submission to upstream. ]

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/Kconfig           | 8 +++++++-
 drivers/firmware/arm_scmi/Makefile | 2 +-
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/smccc/Kconfig     | 1 +
 drivers/mailbox/Kconfig            | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 1db738d5b301..358f895847b5 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
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
index 0edc04bc434c..4666777019fa 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -375,7 +375,9 @@ struct scmi_desc {
 	bool support_xfers_delegation;
 };
 
+#ifdef CONFIG_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
+#endif
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 extern const struct scmi_desc scmi_smc_desc;
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
2.17.1

