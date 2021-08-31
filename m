Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F23FC590
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhHaKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:22:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45196 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbhHaKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630405306; x=1661941306;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=lS1HgJMUvIX3HSRFAT1nvoN6FUBX0UTcTqsk5k75S0U=;
  b=UqAgoVREe3uyClY3JGC8wLlO+F/k0lXeE2AscqqfO/5bOrEBFJ+Scgmt
   5ql3kgxbH7Xkuar4UDtgo94n77gAK2xaer18ejsAF27Qu0jQNeX9BNA7T
   6xhYWYI+nSDeWwScQFKfTTrdvcX4WMcR/ljmJhleG+1dG7eudS+gqPwKb
   240SIC+ha+J2oQIGxvIX6Hij3FgSzzmfRTt9Ry2BRwyQ8afVxnHEoyhJL
   hrjl4PtzBIHacMSlnmXGY0cqEpv9GFkbacFO19EcHpZ2dCM693qqoROb/
   1MYbYXz3cCbelPhJKV02g3UPHgYIjBiT9Mih7uqypXa4b8op0ybRPg0tm
   g==;
IronPort-SDR: YGLHHjHri8oGde+FUz7IfKOl/hFWe1Cx9IJoDG0Svr+EAkPoQjWo0eziSTcop0nALunY52JqA4
 7Sq1C5+aslY7MPfgwYeBRKz3p8tEcOVDv0P536ctcE36xD/RxTwDg43isEeThwU27JJYzVXOv6
 sSKukQjFfKul4YYpgO2QhsuukzNrVzSr3cYiZE1i7q912UPy1hjaqEJFlG1TmaxbmQle4juHHs
 v6DleeKe7eoEk8LLv8EflsCYUZ2umqRZhxxbYPR73NQYfzieksE+StAJAEQdUaKmSDSz78W58k
 PyLyjV8fuRbnaMBH3fbeypHK
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="134263072"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2021 03:21:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 Aug 2021 03:21:44 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 31 Aug 2021 03:21:41 -0700
From:   <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>, <Madhuri.Sripada@microchip.com>
Subject: [PATCH v2] ARM: at91: add basic support for new SoC lan966x
Date:   Tue, 31 Aug 2021 15:51:38 +0530
Message-ID: <20210831102138.2476-1-kavyasree.kotagiri@microchip.com>
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
v1 -> v2:
- Removed lan966x_dt_device_init().
  System boots fine without this function.

 arch/arm/mach-at91/Kconfig   | 13 +++++++++++++
 arch/arm/mach-at91/Makefile  |  1 +
 arch/arm/mach-at91/lan966x.c | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
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
index 000000000000..154d616569ae
--- /dev/null
+++ b/arch/arm/mach-at91/lan966x.c
@@ -0,0 +1,25 @@
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
+static const char *const lan966x_dt_board_compat[] __initconst = {
+	"microchip,lan966x",
+	NULL
+};
+
+DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
+	/* Maintainer: Microchip */
+	.dt_compat	= lan966x_dt_board_compat,
+MACHINE_END
-- 
2.17.1

