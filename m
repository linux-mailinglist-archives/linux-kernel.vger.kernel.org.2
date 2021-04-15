Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860773607BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhDOKxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:53:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1160 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhDOKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483946; x=1650019946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VG3+HiyCtvoGYnedjwejzntF7zna9sJRsVjToN9flg=;
  b=OcsJBLcMXevcIc7vzhP0H3Z0W4p1/AGXg8P21TQt7Xcws5rjHViCsQmU
   Tyorr5H9fAzzSkz2xubaz1jM4RuAcMsvE3OwhRK0Dd1nCOyR+d1Ww+P6w
   20jHCQEj482hOYTd+51MwKjJPpDZEkVyzJbq/1W0Qqe5mtaly7+wpLfNp
   pPO/OpFMwm6K+GEN6MFMUl+Jtvelz3UU2Y26NE7do7rx7qd0CorvW66W6
   ojT1IWRG9wK5AgIJzN1+jONJ9OZMlC+OSuR4AKPsi70pgUG4x2JdLwKs3
   698PdZmAR481mtRbcV+aVyeXvA2pPUpDSiv1UVkXPduoxmksvdtG05hYA
   w==;
IronPort-SDR: Bxd+gFaDsZ7FPbvJk8rDrnGcwBGtI7BQTMfGdD27CRtU929RPCa15VUwOBvkq2kcsjOqr1NcRK
 wHdoTaDa8ctPEtdvkwY/00fzdXn8UttRXvyuE6MpyjFtx4pKSNTvb1okiPzSSt/iAtw36Awhpr
 rCFNsSeRF3Th9+d28K33dJAmbuxo94DZLo3WQKVJr9PRfp1DVuWJKYn3x4WDqodShAdGfYUl0v
 oew/QQLLyat1nx6jZQuhSsKVsj38huIM8Wcvn+bltQ7/F4aQ/p3o9qdmRWAQjbxjd4z5M+xbI2
 BKw=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="117122203"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:52:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:52:25 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:52:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 22/24] ARM: at91: sama7: introduce sama7 SoC family
Date:   Thu, 15 Apr 2021 13:50:08 +0300
Message-ID: <20210415105010.569620-23-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Introduce new family of SoCs, sama7, and first SoC, sama7g5.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: keep only the sama7_dt]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/Makefile |  1 +
 arch/arm/mach-at91/sama7.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 arch/arm/mach-at91/sama7.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index f565490f1b70..522b680b6446 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
+obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 
 # Power Management
diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
new file mode 100644
index 000000000000..19d7bcbc97f1
--- /dev/null
+++ b/arch/arm/mach-at91/sama7.c
@@ -0,0 +1,32 @@
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
+static void __init sama7_dt_device_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
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
-- 
2.25.1

