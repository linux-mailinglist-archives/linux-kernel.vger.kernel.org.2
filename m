Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3234FF01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhCaLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40149 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhCaLAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188416; x=1648724416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ntEqB5PgwPCe/PS0yLqwZ+7nakptiiHXromZoHhD7/8=;
  b=rOcfmdPMH/Z5/HPpZl9+D50UEfKoaT5k5WpJCD14Ezn3mswvF0FmrU63
   ocgUnZJx75kIEPWV5+jL5fb2K9/KGCGHjF6ZGGZ5swTorAM2hPvBJZFc4
   alH7bPrF/V5Sf8ovrotp877vuxPuf6lAzVZhwRNc1zc/Y+T4HUFZV9wrr
   oEkQXVwtKu8WVmphhTumUSqZ9eh0qoGx4Sm7gFLMqesh3mQ5w2jbSxM1a
   qloZQdPWaSFyOpWNJN8Bm5aujIUifprewNgINXyo67zMd/ORvedkA9dEC
   1ZNqv8qJKd3KwEQJ4N9uROsuL2eV7vh7KvKErD/MPkieeigvMB0u7qKk+
   A==;
IronPort-SDR: t/WE8aXkB8EK19Rn+COffG/uB9FrigZWBwrxBAD9OnPjHyV5WpqWsK79RL9IrU+CuI2hohBM/n
 jWvhPHAd4JqRL2W4TAIF4ukcmyLQG0FfCCe/J/uEQUe46ksZsa+xSmTvPxwyAeA+qQ4nC+5cMw
 r840qSuNrxrDQjuevmGEvM/W1skHTqz6EYfMP+XkS3ASVgFYldZEy1frinxwgCjn922bUCUAfR
 KjAgo3hHaCq+PcZ2JK9Ybu0NUMl712/GCV8NP6/9wXlT7KtxLvIODjd3WoHHwdDhpwmxHijqYs
 PA0=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333387"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 04:00:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 04:00:08 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 04:00:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Date:   Wed, 31 Mar 2021 13:59:06 +0300
Message-ID: <20210331105908.23027-23-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Introduce new family of SoCs, sama7, and first SoC, sama7g5.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/Makefile |  1 +
 arch/arm/mach-at91/sama7.c  | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 arch/arm/mach-at91/sama7.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index f565490f1b70..6cc6624cddac 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
+obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 
 # Power Management
 obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
new file mode 100644
index 000000000000..e04cadb569ad
--- /dev/null
+++ b/arch/arm/mach-at91/sama7.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Setup code for SAMA7
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
+static void __init sama7_common_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+}
+
+static void __init sama7_dt_device_init(void)
+{
+	sama7_common_init();
+}
+
+static const char *const sama7_dt_board_compat[] __initconst = {
+	"microchip,sama7",
+	NULL
+};
+
+DT_MACHINE_START(sama7_dt, "Microchip SAMA7")
+	/* Maintainer: Microchip */
+	.init_machine	= sama7_dt_device_init,
+	.dt_compat	= sama7_dt_board_compat,
+MACHINE_END
+
+static const char *const sama7g5_dt_board_compat[] __initconst = {
+	"microchip,sama7g5",
+	NULL
+};
+
+DT_MACHINE_START(sama7g5_dt, "Microchip SAMA7G5")
+	/* Maintainer: Microchip */
+	.init_machine	= sama7_dt_device_init,
+	.dt_compat	= sama7g5_dt_board_compat,
+MACHINE_END
+
-- 
2.25.1

