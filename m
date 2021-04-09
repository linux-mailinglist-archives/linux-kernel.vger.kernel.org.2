Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F476359D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhDILSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:18:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49775 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbhDILST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967087; x=1649503087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VG3+HiyCtvoGYnedjwejzntF7zna9sJRsVjToN9flg=;
  b=hqVvH9AC/LHbCJqublI2pjiItFaer3b9wAe/SQRbXG6hmzCiO3ANI8QM
   NCTtIlIs3TFQnKb+R3kPkSFr4ADMRJ/58jPm/z58/mzpP3FTxxAsOGLWZ
   uiQqcCdowbF/ReWualWXOI+ndnTwHBaksxshnh8yL9txE43iZ1eckxg9T
   HFQUv84/P9YOBST550kdgJZl31qNq9F6Gb658itk4s1922ylzUPcGso4x
   87clRf4TzISx0B/Y0MP1Gw60fJYqujkgjBwvWwH+jI6ndrCb+1bFuoBXa
   HvqQQspwDbq4xTmTCZvey0KAqM0MYWjIBOW5C+dbx473kqjta+/TiZ5nw
   w==;
IronPort-SDR: Stv5uJSpxoeKoSfvw9fZuhkEq+SsDtDXkSiFp4RiEdfZB+gsvJ9zwQHoVxQuwGDvuO7ZcLsmdJ
 utckKlxCtqRk952PofWOqWkzjtJAzv+y0ukxlT6SXRvvRD2GZE9XibNv0x3/bnKwMvJNADbOBg
 vr8SZA9lTLB9E6LdD6Dr9v9GFRQSotoWDBUOTF703DfFZIUdYVMIXnbrJPfIIMbJbxkgzSFfeo
 xqQDvvdWDMbLeztnxOfHHWuHrROavKfXkxZBLmqbIwTtLXktMDntlLdY0IuyWG4hzspNUHhwy7
 tYI=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:18:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:18:06 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:18:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 22/24] ARM: at91: sama7: introduce sama7 SoC family
Date:   Fri, 9 Apr 2021 14:13:43 +0300
Message-ID: <20210409111345.294472-23-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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

