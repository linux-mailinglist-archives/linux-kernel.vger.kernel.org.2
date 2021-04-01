Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950C351CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhDASTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:19:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19898 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbhDASAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617300021; x=1648836021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4jTs6ZreLvCAN6irnrww27Z1diof5VE62LFqus8s7M=;
  b=De/rifz6UeRyWtyIrWUKTmTohFh4rceJQB1Nwv6lrdWd2523PjIU1KXV
   27QlkwLmLGaGhjL6j2YuYNTf4PtRHQAjUCFXByS+CCR+QJZOhGr42NOLO
   lOh0S9+5T3qYpWpB3ytMpJVva3sda/fHB6Pai4/eNKGAdXj77htqGRUX2
   EYryLoNj+Tg7K9mVb/mAoJLNcgCfVJJjN36wm3aKObde5K6ouVDirssM+
   rUzAJw7m5S6tPAV/suDA4ZnjOvcpNz8eASM4VCc3xtGPsaai/e5/86XA/
   LHkRwVpVW1NPAoxCcyaQ7H/TqzXtI2jMhS1offVEuJLVbgj9BdnV+Dng2
   g==;
IronPort-SDR: 6Xo6eM/RhaSsRhjMBu/eoqbLRedLPDnmecXdubZXuTR9UQ/0G2Xlyn6ISFTdHZrDu+x6R6ylFF
 MMWD8qzoY84nLtUeSIlQ9fbIRDWlyfx2f992Ceq/NIdytWCuXkSPbiQw3FuPIxltD5B1MJ4/bg
 JgpW3/08FO9D8KtloZ3FcJRqD/4pGXcgSBotqErOaYdybiD3IBCw4qhgNkqJYCmHUWRgy8+LhY
 B+zXBzKN8QRTUMXJ1r54XFhPe/vA492KyDrse3XBLbnVgrzTUwWszWbLom6vMZRJhhVgyVpvNu
 F2k=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="109344813"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 05:27:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 05:27:42 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 05:27:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/6] clk: at91: clk-master: add register definition for sama7g5's master clock
Date:   Thu, 1 Apr 2021 15:27:24 +0300
Message-ID: <20210401122726.28528-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401122726.28528-1-claudiu.beznea@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register definitions for SAMA7G5's master clock. These would be
also used by architecture specific power saving code. With this, update
also clk-master.c.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 50 ++++++++++++++++-------------------
 include/linux/clk/at91_pmc.h  | 26 ++++++++++++++++++
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 21e82111890d..736406528824 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -17,15 +17,7 @@
 #define MASTER_DIV_SHIFT	8
 #define MASTER_DIV_MASK		0x7
 
-#define PMC_MCR			0x30
-#define PMC_MCR_ID_MSK		GENMASK(3, 0)
-#define PMC_MCR_CMD		BIT(7)
-#define PMC_MCR_DIV		GENMASK(10, 8)
-#define PMC_MCR_CSS		GENMASK(20, 16)
 #define PMC_MCR_CSS_SHIFT	(16)
-#define PMC_MCR_EN		BIT(28)
-
-#define PMC_MCR_ID(x)		((x) & PMC_MCR_ID_MSK)
 
 #define MASTER_MAX_ID		4
 
@@ -682,20 +674,22 @@ static void clk_sama7g5_master_set(struct clk_master *master,
 {
 	unsigned long flags;
 	unsigned int val, cparent;
-	unsigned int enable = status ? PMC_MCR_EN : 0;
+	unsigned int enable = status ? AT91_PMC_MCR_V2_EN : 0;
 
 	spin_lock_irqsave(master->lock, flags);
 
-	regmap_write(master->regmap, PMC_MCR, PMC_MCR_ID(master->id));
-	regmap_read(master->regmap, PMC_MCR, &val);
-	regmap_update_bits(master->regmap, PMC_MCR,
-			   enable | PMC_MCR_CSS | PMC_MCR_DIV |
-			   PMC_MCR_CMD | PMC_MCR_ID_MSK,
+	regmap_write(master->regmap, AT91_PMC_MCR_V2,
+		     AT91_PMC_MCR_V2_ID(master->id));
+	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
+	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
+			   enable | AT91_PMC_MCR_V2_CSS | AT91_PMC_MCR_V2_DIV |
+			   AT91_PMC_MCR_V2_CMD | AT91_PMC_MCR_V2_ID_MSK,
 			   enable | (master->parent << PMC_MCR_CSS_SHIFT) |
 			   (master->div << MASTER_DIV_SHIFT) |
-			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
+			   AT91_PMC_MCR_V2_CMD |
+			   AT91_PMC_MCR_V2_ID(master->id));
 
-	cparent = (val & PMC_MCR_CSS) >> PMC_MCR_CSS_SHIFT;
+	cparent = (val & AT91_PMC_MCR_V2_CSS) >> PMC_MCR_CSS_SHIFT;
 
 	/* Wait here only if parent is being changed. */
 	while ((cparent != master->parent) && !clk_master_ready(master))
@@ -720,10 +714,12 @@ static void clk_sama7g5_master_disable(struct clk_hw *hw)
 
 	spin_lock_irqsave(master->lock, flags);
 
-	regmap_write(master->regmap, PMC_MCR, master->id);
-	regmap_update_bits(master->regmap, PMC_MCR,
-			   PMC_MCR_EN | PMC_MCR_CMD | PMC_MCR_ID_MSK,
-			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
+	regmap_write(master->regmap, AT91_PMC_MCR_V2, master->id);
+	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
+			   AT91_PMC_MCR_V2_EN | AT91_PMC_MCR_V2_CMD |
+			   AT91_PMC_MCR_V2_ID_MSK,
+			   AT91_PMC_MCR_V2_CMD |
+			   AT91_PMC_MCR_V2_ID(master->id));
 
 	spin_unlock_irqrestore(master->lock, flags);
 }
@@ -736,12 +732,12 @@ static int clk_sama7g5_master_is_enabled(struct clk_hw *hw)
 
 	spin_lock_irqsave(master->lock, flags);
 
-	regmap_write(master->regmap, PMC_MCR, master->id);
-	regmap_read(master->regmap, PMC_MCR, &val);
+	regmap_write(master->regmap, AT91_PMC_MCR_V2, master->id);
+	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
 
 	spin_unlock_irqrestore(master->lock, flags);
 
-	return !!(val & PMC_MCR_EN);
+	return !!(val & AT91_PMC_MCR_V2_EN);
 }
 
 static int clk_sama7g5_master_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -837,10 +833,10 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 	master->mux_table = mux_table;
 
 	spin_lock_irqsave(master->lock, flags);
-	regmap_write(master->regmap, PMC_MCR, master->id);
-	regmap_read(master->regmap, PMC_MCR, &val);
-	master->parent = (val & PMC_MCR_CSS) >> PMC_MCR_CSS_SHIFT;
-	master->div = (val & PMC_MCR_DIV) >> MASTER_DIV_SHIFT;
+	regmap_write(master->regmap, AT91_PMC_MCR_V2, master->id);
+	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
+	master->parent = (val & AT91_PMC_MCR_V2_CSS) >> PMC_MCR_CSS_SHIFT;
+	master->div = (val & AT91_PMC_MCR_V2_DIV) >> MASTER_DIV_SHIFT;
 	spin_unlock_irqrestore(master->lock, flags);
 
 	hw = &master->hw;
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

