Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF353F96F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbhH0J12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:27:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43987 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244825AbhH0J11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630056399; x=1661592399;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=J3i9uBz3EG1ucQmcepffYGi/MTUpR71z9RNb52yBNBM=;
  b=jrIHicTmAuqevjYUoGgo3XgsdtlArYACbvUa3v2nA7BwyHKNNcZKQzVS
   1KoU/S3BNcOL5Uyk3B3Zi3OGlFkwi42toOyMH5NO/5eEZRCRmmsY589aW
   8ycNMFYzap2Lbi8unlDfiQtEsAjfLf4oxuZVhsBnkuoRQMvmunA3HnnHS
   vFR6QKRCjjDlCRINC7moBflkjBCpkaPb7jNBqVRBBLw/eg2v09IQxTzkx
   f+h9KwHi8BxSPDODv/OhnQKgYd6TpS2WNn/0YmvGhNCEgskDfCTZqoiaD
   b9VPoVB4qwZo3XUPPEn6eh3mT/orp1rLAh7Z6J1xoA2SUMTWUgn2a8H57
   w==;
IronPort-SDR: WQMlE/SKoDrKt+PMq0eLk352Hwz5nTAFqmiuu0jmPCUpZy0oU8CfYEjyvWkVDXY5H2HMCoCgaz
 RLN3FbLcfoRYQD9K2FngKfeFo7FA68/DsbOkK53ohyDZus7j6INmlvygdRLnkS+PRbbzOmU06Z
 4F169O+c1Sns0nO9FtbhueFUhmexCsCwZMeJoDjr6F83NCjvyUDpVkUVbiioorkl7wcstdL6tA
 8RlENh0B9msbV/ylq1esqJovy6YcTNGOYMvwyq3DC3cLxL8RHYQeotT4bAqllYsNig79t2cqzy
 dBoqqpYBculQut68iy/x0peo
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="133873674"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2021 02:26:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 27 Aug 2021 02:26:37 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 27 Aug 2021 02:26:34 -0700
From:   <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>, <Madhuri.Sripada@microchip.com>
Subject: [PATCH] ARM: at91: add basic support for new SoC lan966x
Date:   Fri, 27 Aug 2021 14:56:23 +0530
Message-ID: <20210827092623.10677-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>

This patch introduces Microchip LAN966X ARMv7 based SoC family
of multiport gigabit AVB/TSN-capable ethernet switches.
It supports two SKUs: 4-port LAN9662 with multiprotocol
processing support and 8-port LAN9668 switch.

LAN966X includes copper and serial ethernet interfaces,
peripheral interfaces such as PCIe, USB, TWI, SPI, UART, QSPI,
SD/eMMC, Parallel Interface (PI) as well as synchronization
and trigger inputs/outputs.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/mach-at91/Kconfig   | 13 +++++++++++++
 arch/arm/mach-at91/Makefile  |  1 +
 arch/arm/mach-at91/lan966x.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/arm/mach-at91/lan966x.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index ccd7e80ce943..06cb425af761 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -122,6 +122,14 @@ config SOC_SAM9X60
 	help
 	  Select this if you are using Microchip's SAM9X60 SoC

+config SOC_LAN966X
+	bool "ARMv7 based Microchip LAN966X SoC family"
+	depends on ARCH_MULTI_V7
+	select SOC_LAN966
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for ARMv7 based Microchip LAN966X SoC family.
+
 comment "Clocksource driver selection"

 config ATMEL_CLOCKSOURCE_PIT
@@ -188,6 +196,11 @@ config SOC_SAMA5
 	select SOC_SAM_V7
 	select SRAM if PM

+config SOC_LAN966
+	bool
+	select ARM_GIC
+	select MEMORY
+
 config ATMEL_PM
 	bool

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index f565490f1b70..93cfd5b4e6d4 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -6,6 +6,7 @@
 # CPU-specific support
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
+obj-$(CONFIG_SOC_LAN966X)	+= lan966x.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
diff --git a/arch/arm/mach-at91/lan966x.c b/arch/arm/mach-at91/lan966x.c
new file mode 100644
index 000000000000..de689f854068
--- /dev/null
+++ b/arch/arm/mach-at91/lan966x.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Setup code for LAN966X
+ *
+ * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
+ *
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/system_misc.h>
+
+#include "generic.h"
+
+static void __init lan966x_dt_device_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+}
+
+static const char *const lan966x_dt_board_compat[] __initconst = {
+	"microchip,lan966x",
+	NULL
+};
+
+DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
+	/* Maintainer: Microchip */
+	.init_machine	= lan966x_dt_device_init,
+	.dt_compat	= lan966x_dt_board_compat,
+MACHINE_END
--
2.17.1

