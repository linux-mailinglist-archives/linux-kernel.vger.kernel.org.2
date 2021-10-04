Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96C4209A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhJDLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:01:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58757 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhJDLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633345202; x=1664881202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cCBt27NmzLjTnwhh2EWbfKpzOQNpkZnqzC+mhw7lZkQ=;
  b=HAeY5F426Z/zaj+nWh8q9wVu0eTr/+pTJ5hzhDaLJnjVLpxjGiKKxKd0
   2AanmZiE9SB4/UdN4CLxoy5u4bfxUaTAL0durTbTPrh9aBWo4gyhIedOs
   57K/SLPS/lMky2i4ISgU8nNRgofPuXE5qpZY3zCOY9uqI6u6cAbhRaRdJ
   7kcl+vsn6z6W4AKuNqi6mi9eea/uAgMuy/x02ve8JZ3sc/9LTnv2rJSq+
   2Emck7aK6W3KyKdbBsNOhglLKihgZzKapu2Ppg2YrN+bSiLbMEQ/j7lkX
   EvijBEXNbjrUr1U2KplueDTN7SfETxnoFOJ466F467tUUzXSURwD+00yS
   w==;
IronPort-SDR: JIDlaUgSwcfbej0BBuUK47E79OfY5gnZvV6pvgM1U0i1XVqDlt16xdZHu8At9AiN0W7kiYv5Lz
 dl5ej3Xv/82ASNqdScJwbvUslcCUqvphIKgv7megy+WRjAhQRNPvB7psqX++EXBX1wTeP6Z1eW
 bzTW9gvZAL1Vfhcj/j0HXlLBXX5k5G2lewDw939EPCNnMapNj0GfJvmyz/wBNkR07iZR4bKE1g
 8c9w/n9dIKUSVDKrQ3P9Cp7QB562izqOd4AwYnPoh+aTaKzOzEnQ0llzB1/2XoIMtn7V/s8dWP
 zgiBz150QLwqThu9CVNlLvGw
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="131634588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 04:00:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 04:00:01 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 03:59:57 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <corbet@lwn.net>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 4/4] ARM: at91: remove lan966x file
Date:   Mon, 4 Oct 2021 16:29:26 +0530
Message-ID: <20211004105926.5696-5-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
References: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Makefile entry and lan966x.c file as it is
not required.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/mach-at91/Makefile  |  1 -
 arch/arm/mach-at91/lan966x.c | 25 -------------------------
 2 files changed, 26 deletions(-)
 delete mode 100644 arch/arm/mach-at91/lan966x.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 2bb65f2c8863..522b680b6446 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -6,7 +6,6 @@
 # CPU-specific support
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
-obj-$(CONFIG_SOC_LAN966X)	+= lan966x.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
diff --git a/arch/arm/mach-at91/lan966x.c b/arch/arm/mach-at91/lan966x.c
deleted file mode 100644
index 154d616569ae..000000000000
--- a/arch/arm/mach-at91/lan966x.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Setup code for LAN966X
- *
- * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
- *
- */
-
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-#include <asm/system_misc.h>
-
-#include "generic.h"
-
-static const char *const lan966x_dt_board_compat[] __initconst = {
-	"microchip,lan966x",
-	NULL
-};
-
-DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
-	/* Maintainer: Microchip */
-	.dt_compat	= lan966x_dt_board_compat,
-MACHINE_END
-- 
2.17.1

