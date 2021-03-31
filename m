Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749EF34FEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhCaLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57770 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhCaK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188383; x=1648724383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EIwoE6xdH41w/s2cb732B6ELAnBKKbdQvfImNvzlTc=;
  b=VkeDEuDPxXQLLWzUrwpjUvRU4AX2MEvvDmnziYaCYgJez5wmy2F+o0Dc
   qpgZrtIXgWIYtzwJXWjnmpvQ2gSyHJGSC/Ihl6Yt+HxFPg1R1vgRmWlgC
   hiTVJ1GLX5ScVqIINruaOYv8+h/i4p28U2SFddrjcKrGsbmltukLB4rEM
   /IHzJSgiKHXVAUGEkM8qO43/Ias8nKpHP6CIv4CjOi2v1u/Mls8uRDsB/
   c61JkFXoqRpO+Pwv+KVBRaZQZd/wFU1aqAxIzh0RRDWft9o2KEpPsxU1h
   OvNOEY9AychWonh5tJbm4GFRBLfBFAvdt8U2tf1n4LEV/qD74tcQNcEgA
   g==;
IronPort-SDR: m+u7UxageJ3H+HtMUIkA1Ktqhl/rUFrG1tPulc5tlU8h/mH2h2Ss3nWgyiAgadxq9+nmlxmQSr
 n1uyHQMi5m7DA/BxWTgl1awD236HrGGAWBa1576r89sACxNg8hYpDe/owkOajbH649jdfLBVsL
 R0erWmyDYNm/NQH4bq2zZqSY35DuPq8bmcFyrw4dWt/oOLucf4pcG59ktSX58NNg07jsdZLCDB
 DO/NhoYVucc82Q9zW2TPdnM8PzlXpqr6+uscySbV68OMRfI4OVkMcoUygnCWWQCXtWoZUU99IU
 hX4=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="114825672"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:40 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 11/24] ARM: at91: ddr: add registers definitions for sama7g5's ddr
Date:   Wed, 31 Mar 2021 13:58:55 +0300
Message-ID: <20210331105908.23027-12-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add registers and bits definitions for SAMA7G5's UDDRC and DDR3PHY.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/soc/at91/sama7-ddr.h | 80 ++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 include/soc/at91/sama7-ddr.h

diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
new file mode 100644
index 000000000000..f6542584ca13
--- /dev/null
+++ b/include/soc/at91/sama7-ddr.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Microchip SAMA7 UDDR Controller and DDR3 PHY Controller registers offsets
+ * and bit definitions.
+ *
+ * Copyright (C) [2020] Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#ifndef __SAMA7_DDR_H__
+#define __SAMA7_DDR_H__
+
+#ifdef CONFIG_SOC_SAMA7
+
+/* DDR3PHY */
+#define DDR3PHY_PIR				(0x04)		/* DDR3PHY PHY Initialization Register	*/
+#define	DDR3PHY_PIR_DLLBYP		(1 << 17)	/* DLL Bypass */
+#define		DDR3PHY_PIR_ITMSRST		(1 << 4)	/* Interface Timing Module Soft Reset */
+#define	DDR3PHY_PIR_DLLLOCK		(1 << 2)	/* DLL Lock */
+#define		DDR3PHY_PIR_DLLSRST		(1 << 1)	/* DLL Soft Rest */
+#define	DDR3PHY_PIR_INIT		(1 << 0)	/* Initialization Trigger */
+
+#define DDR3PHY_PGCR				(0x08)		/* DDR3PHY PHY General Configuration Register */
+#define		DDR3PHY_PGCR_CKDV1		(1 << 13)	/* CK# Disable Value */
+#define		DDR3PHY_PGCR_CKDV0		(1 << 12)	/* CK Disable Value */
+
+#define	DDR3PHY_PGSR				(0x0C)		/* DDR3PHY PHY General Status Register */
+#define		DDR3PHY_PGSR_IDONE		(1 << 0)	/* Initialization Done */
+
+#define DDR3PHY_ACIOCR				(0x24)		/*  DDR3PHY AC I/O Configuration Register */
+#define		DDR3PHY_ACIOCR_CSPDD_CS0	(1 << 18)	/* CS#[0] Power Down Driver */
+#define		DDR3PHY_ACIOCR_CKPDD_CK0	(1 << 8)	/* CK[0] Power Down Driver */
+#define		DDR3PHY_ACIORC_ACPDD		(1 << 3)	/* AC Power Down Driver */
+
+#define DDR3PHY_DXCCR				(0x28)		/* DDR3PHY DATX8 Common Configuration Register */
+#define		DDR3PHY_DXCCR_DXPDR		(1 << 3)	/* Data Power Down Receiver */
+
+#define DDR3PHY_DSGCR				(0x2C)		/* DDR3PHY DDR System General Configuration Register */
+#define		DDR3PHY_DSGCR_ODTPDD_ODT0	(1 << 20)	/* ODT[0] Power Down Driver */
+
+#define DDR3PHY_ZQ0SR0				(0x188)		/* ZQ status register 0 */
+
+/* UDDRC */
+#define UDDRC_STAT				(0x04)		/* UDDRC Operating Mode Status Register */
+#define		UDDRC_STAT_SELFREF_TYPE_DIS	(0x0 << 4)	/* SDRAM is not in Self-refresh */
+#define		UDDRC_STAT_SELFREF_TYPE_PHY	(0x1 << 4)	/* SDRAM is in Self-refresh, which was caused by PHY Master Request */
+#define		UDDRC_STAT_SELFREF_TYPE_SW	(0x2 << 4)	/* SDRAM is in Self-refresh, which was not caused solely under Automatic Self-refresh control */
+#define		UDDRC_STAT_SELFREF_TYPE_AUTO	(0x3 << 4)	/* SDRAM is in Self-refresh, which was caused by Automatic Self-refresh only */
+#define		UDDRC_STAT_SELFREF_TYPE_MSK	(0x3 << 4)	/* Self-refresh type mask */
+#define		UDDRC_STAT_OPMODE_INIT		(0x0 << 0)	/* Init */
+#define		UDDRC_STAT_OPMODE_NORMAL	(0x1 << 0)	/* Normal */
+#define		UDDRC_STAT_OPMODE_PWRDOWN	(0x2 << 0)	/* Power-down */
+#define		UDDRC_STAT_OPMODE_SELF_REFRESH	(0x3 << 0)	/* Self-refresh */
+#define		UDDRC_STAT_OPMODE_MSK		(0x7 << 0)	/* Operating mode mask */
+
+#define UDDRC_PWRCTL				(0x30)		/* UDDRC Low Power Control Register */
+#define		UDDRC_PWRCTRL_SELFREF_SW	(1 << 5)	/* Software self-refresh */
+
+#define UDDRC_DFIMISC				(0x1B0)		/* UDDRC DFI Miscellaneous Control Register */
+#define		UDDRC_DFIMISC_DFI_INIT_COMPLETE_EN (1 << 0)	/* PHY initialization complete enable signal */
+
+#define UDDRC_SWCTRL				(0x320)		/* UDDRC Software Register Programming Control Enable */
+#define		UDDRC_SWCTRL_SW_DONE		(1 << 0)	/* Enable quasi-dynamic register programming outside reset */
+
+#define UDDRC_SWSTAT				(0x324)		/* UDDRC Software Register Programming Control Status */
+#define		UDDRC_SWSTAT_SW_DONE_ACK	(1 << 0)	/* Register programming done */
+
+#define UDDRC_PSTAT				(0x3FC)		/* UDDRC Port Status Register */
+#define	UDDRC_PSTAT_ALL_PORTS		(0x1F001F)	/* Read + writes outstanding transactions on all ports */
+
+#define UDDRC_PCTRL_0				(0x490)		/* UDDRC Port 0 Control Register */
+#define UDDRC_PCTRL_1				(0x540)		/* UDDRC Port 1 Control Register */
+#define UDDRC_PCTRL_2				(0x5F0)		/* UDDRC Port 2 Control Register */
+#define UDDRC_PCTRL_3				(0x6A0)		/* UDDRC Port 3 Control Register */
+#define UDDRC_PCTRL_4				(0x750)		/* UDDRC Port 4 Control Register */
+
+#endif /* CONFIG_SOC_SAMA7 */
+
+#endif /* __SAMA7_DDR_H__ */
-- 
2.25.1

