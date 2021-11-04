Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9875444D87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhKDDHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:07:10 -0400
Received: from [113.204.237.245] ([113.204.237.245]:53802 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230319AbhKDDG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:06:59 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(16723:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 04 Nov 2021 10:58:10 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v4 09/10] ARM: sunplus: Add initial support for Sunplus SP7021 SoC
Date:   Thu,  4 Nov 2021 10:57:06 +0800
Message-Id: <480a3ab57b45f4483612db1211dd25d424d90ec5.1635993377.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635993377.git.qinjian@cqplus1.com>
References: <cover.1635993377.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to add an initial support for Sunplus SP7021 SoC.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                         |  1 +
 arch/arm/Kconfig                    | 20 ++++++++++++++++++++
 arch/arm/Makefile                   |  2 ++
 arch/arm/mach-sunplus/Kconfig       | 20 ++++++++++++++++++++
 arch/arm/mach-sunplus/Makefile      |  9 +++++++++
 arch/arm/mach-sunplus/Makefile.boot |  3 +++
 arch/arm/mach-sunplus/sp7021.c      | 16 ++++++++++++++++
 7 files changed, 71 insertions(+)
 create mode 100644 arch/arm/mach-sunplus/Kconfig
 create mode 100644 arch/arm/mach-sunplus/Makefile
 create mode 100644 arch/arm/mach-sunplus/Makefile.boot
 create mode 100644 arch/arm/mach-sunplus/sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index febbd97bf..0ae537a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2664,6 +2664,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 59baf6c13..feba287eb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -487,6 +487,24 @@ config ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
+config ARCH_SUNPLUS
+	bool "Sunplus SoCs"
+	select CLKSRC_OF
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
+	select SERIAL_SUNPLUS
+	select SERIAL_SUNPLUS_CONSOLE
+	select USE_OF
+	select RTC_CLASS
+	select RESET_SUNPLUS
+	help
+	  Support for Sunplus SoC family: SP7021 and succeed SoCs based systems,
+	  such as the Banana Pi BPI-F2S development board ( and derivatives).
+	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
+	  (<https://tibbo.com/store/plus1.html>)
+
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	depends on MMU
@@ -689,6 +707,8 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
+source "arch/arm/mach-sunplus/Kconfig"
+
 source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 847c31e7c..cac95a950 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
+textofs-$(CONFIG_ARCH_SUNPLUS) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
@@ -212,6 +213,7 @@ machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
 machine-$(CONFIG_ARCH_INTEL_SOCFPGA)	+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
+machine-$(CONFIG_ARCH_SUNPLUS)		+= sunplus
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-sunplus/Kconfig b/arch/arm/mach-sunplus/Kconfig
new file mode 100644
index 000000000..f7ad76959
--- /dev/null
+++ b/arch/arm/mach-sunplus/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+config SOC_SP7021
+	bool "Sunplus SP7021 SoC support"
+	default y
+	select CPU_V7
+	select ARM_GIC
+	select SUNPLUS_SP7021_INTC
+	select HAVE_SMP
+	select ARM_PSCI
+	select COMMON_CLK_SP7021
+	select PINCTRL
+	select PINCTRL_SPPCTL
+	select OF_OVERLAY
+	select GPIOLIB
+	help
+	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
+	  Cotex-A7 with various peripherals (ex: I2C, SPI, SDIO,
+	  Ethernet and etc.), FPGA interface,  chip-to-chip bus.
+	  It is designed for industrial control.
diff --git a/arch/arm/mach-sunplus/Makefile b/arch/arm/mach-sunplus/Makefile
new file mode 100644
index 000000000..c902580a7
--- /dev/null
+++ b/arch/arm/mach-sunplus/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+# Object file lists.
+
+obj-$(CONFIG_SOC_SP7021)	+= sp7021.o
+
diff --git a/arch/arm/mach-sunplus/Makefile.boot b/arch/arm/mach-sunplus/Makefile.boot
new file mode 100644
index 000000000..401c30840
--- /dev/null
+++ b/arch/arm/mach-sunplus/Makefile.boot
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+zreladdr-$(CONFIG_ARCH_SUNPLUS) := 0x00308000
diff --git a/arch/arm/mach-sunplus/sp7021.c b/arch/arm/mach-sunplus/sp7021.c
new file mode 100644
index 000000000..774d0a5bd
--- /dev/null
+++ b/arch/arm/mach-sunplus/sp7021.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <asm/mach/arch.h>
+
+static const char *sp7021_compat[] __initconst = {
+	"sunplus,sp7021",
+	NULL
+};
+
+DT_MACHINE_START(SP7021_DT, "SP7021")
+	.dt_compat	= sp7021_compat,
+MACHINE_END
-- 
2.33.1

