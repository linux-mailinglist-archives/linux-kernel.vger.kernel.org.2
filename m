Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9143C5E35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhGLOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:22:30 -0400
Received: from foss.arm.com ([217.140.110.172]:56088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235120AbhGLOWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:22:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8658031B;
        Mon, 12 Jul 2021 07:19:41 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C3803F774;
        Mon, 12 Jul 2021 07:19:37 -0700 (PDT)
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
Subject: [PATCH v6 12/17] firmware: arm_scmi: Make shmem support optional for transports
Date:   Mon, 12 Jul 2021 15:18:28 +0100
Message-Id: <20210712141833.6628-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Upcoming new SCMI transports won't need any kind of shared memory support.
Compile shmem.c only if a shmem based transport is selected.

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: Adapted patch/commit_msg to new SCMI Kconfig layout ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- Adapted to new SCMI Kconfig layout
---
 drivers/firmware/arm_scmi/Kconfig  | 8 ++++++++
 drivers/firmware/arm_scmi/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 479fc8a3533e..ee6517b24080 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -28,10 +28,17 @@ config ARM_SCMI_HAVE_TRANSPORT
 	  Used to trigger a build bug when trying to build SCMI without any
 	  configured transport.
 
+config ARM_SCMI_HAVE_SHMEM
+	bool
+	help
+	  This declares whether a shared memory based transport for SCMI is
+	  available.
+
 config ARM_SCMI_TRANSPORT_MAILBOX
 	bool "SCMI transport based on Mailbox"
 	depends on ARM_SCMI_PROTOCOL && MAILBOX
 	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
 	default y
 	help
 	  Enable mailbox based transport for SCMI.
@@ -45,6 +52,7 @@ config ARM_SCMI_TRANSPORT_SMC
 	bool "SCMI transport based on SMC"
 	depends on ARM_SCMI_PROTOCOL && HAVE_ARM_SMCCC_DISCOVERY
 	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
 	default y
 	help
 	  Enable SMC based transport for SCMI.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 38163d6991b3..e0e6bd3dba9e 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o notify.o
-scmi-transport-y = shmem.o
+scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
-- 
2.17.1

