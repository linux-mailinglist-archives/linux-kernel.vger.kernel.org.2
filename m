Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA53CCF06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhGSIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:07:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31636 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhGSIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626681833; x=1658217833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6nzt5yiAvhxMKL7rPLuDR0oOaQ4zLZ3+WTR88aoj8sI=;
  b=Kb3aMdVBD+clVwr8iaEm4egxrcjXmCInt5jiQ4CuadhK3V1hakH7DR3S
   6CQ/763RLux8AMQtQf4orgjqjKa1q29gQJIVuIaSa5m2bVfsN6u/su5rb
   PyP0nI/VaYlVkc3mUFgAKTBMebqOpzBfJewdZHJtcM9BRuYIih9Qi3vhi
   lPmeKxPKGUuNIZy17NENIv/xC5zaXDYhx70y3hhFXfLBNeG00Ub0MJjIr
   0k+DXhKUorMJoXEmcxZRnAG7cB4x+dgnL0UPpGlGnrGDdMkTOhcDRxOxB
   JIl7+6EFJ8YGDzgFLH3r4CoLIOfpzRfX7ofMOOtK2At/JBSIzSJq++6YD
   g==;
IronPort-SDR: dhI/Rgc7DzpyD+1nHj7ZiWhO4QaiQ4xmX02N1cUmgqu7bDrctZVHg7Gj/uiVY1lha9wsgYL67u
 VBVgc8kTJrH/q3q6LMd0BK8wFoVqpO4Xxzc8+8BoE92LXIpi7dKNWI5XH0U6XqhuX0KU6+dCiW
 dODI/coRVvL1Ia9l67yQgOdbpdQomdqaZgnRaw7E52BFovFfEsaceIKVg9iuG5qYyqVpPfnbKa
 Pjw14maDgA0kqDqKO5c/1wUkp89r9quERyHaGwfJOTY+0mJQ/Akq8TaxLL/itc0K0XMiSptOUQ
 9OfHpe70TAyw9uc3tqTtRhsZ
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="136432819"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2021 01:03:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 01:03:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 01:03:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <sfr@canb.auug.org.au>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] clk: at91: add register definition for sama7g5's master clock
Date:   Mon, 19 Jul 2021 11:03:17 +0300
Message-ID: <20210719080317.1045832-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
References: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register definitions for SAMA7G5's master clock. These would be
also used by architecture specific power saving code.

Fixes: 6cb0e54412a3 ("ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Stephen,

This is a part from patch at [1]. I keep it at minimum (only definitions)
for faster acceptance as the build is broken on arm multi_v7_defconfig
without it).
In next version of patch at [1] I will update it accordingly.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/linux-clk/20210401122726.28528-5-claudiu.beznea@microchip.com/

 include/linux/clk/at91_pmc.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index a4f82e836a7c..ccb3f034bfa9 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -137,6 +137,32 @@
 #define			AT91_PMC_PLLADIV2_ON		(1 << 12)
 #define		AT91_PMC_H32MXDIV	BIT(24)
 
+#define	AT91_PMC_MCR_V2		0x30				/* Master Clock Register [SAMA7G5 only] */
+#define		AT91_PMC_MCR_V2_ID_MSK	(0xF)
+#define			AT91_PMC_MCR_V2_ID(_id)		((_id) & AT91_PMC_MCR_V2_ID_MSK)
+#define		AT91_PMC_MCR_V2_CMD	(1 << 7)
+#define		AT91_PMC_MCR_V2_DIV	(7 << 8)
+#define			AT91_PMC_MCR_V2_DIV1		(0 << 8)
+#define			AT91_PMC_MCR_V2_DIV2		(1 << 8)
+#define			AT91_PMC_MCR_V2_DIV4		(2 << 8)
+#define			AT91_PMC_MCR_V2_DIV8		(3 << 8)
+#define			AT91_PMC_MCR_V2_DIV16		(4 << 8)
+#define			AT91_PMC_MCR_V2_DIV32		(5 << 8)
+#define			AT91_PMC_MCR_V2_DIV64		(6 << 8)
+#define			AT91_PMC_MCR_V2_DIV3		(7 << 8)
+#define		AT91_PMC_MCR_V2_CSS	(0x1F << 16)
+#define			AT91_PMC_MCR_V2_CSS_MD_SLCK	(0 << 16)
+#define			AT91_PMC_MCR_V2_CSS_TD_SLCK	(1 << 16)
+#define			AT91_PMC_MCR_V2_CSS_MAINCK	(2 << 16)
+#define			AT91_PMC_MCR_V2_CSS_MCK0	(3 << 16)
+#define			AT91_PMC_MCR_V2_CSS_SYSPLL	(5 << 16)
+#define			AT91_PMC_MCR_V2_CSS_DDRPLL	(6 << 16)
+#define			AT91_PMC_MCR_V2_CSS_IMGPLL	(7 << 16)
+#define			AT91_PMC_MCR_V2_CSS_BAUDPLL	(8 << 16)
+#define			AT91_PMC_MCR_V2_CSS_AUDIOPLL	(9 << 16)
+#define			AT91_PMC_MCR_V2_CSS_ETHPLL	(10 << 16)
+#define		AT91_PMC_MCR_V2_EN	(1 << 28)
+
 #define AT91_PMC_XTALF		0x34			/* Main XTAL Frequency Register [SAMA7G5 only] */
 
 #define	AT91_PMC_USB		0x38			/* USB Clock Register [some SAM9 only] */
-- 
2.25.1

