Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB640F724
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbhIQMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52243 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbhIQMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880416; x=1663416416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMAJzlLQWHfPLEYAqNjpQbE6NgSO2QK2F0a5gUvdtUs=;
  b=n0aXByvFtgI1JZl2/IcFGYmIPKv8YOIW5TpzIUk+sV22qRpnRvv64Lbm
   IhAZLwKhzWpxobgqius+FbQziLaklbvRVlnYojco3iRiyWaF7xyPbwu+t
   yZxIAsL7igIZu23b7DiosObWQqr7EL2tHtOJ4MlXfMbKv+IratQziBzY2
   Xjatqutcap+BaTB3f6KPBpfVx7HfWQGN/gNnyBhEEL90V743lQLPqt4Cd
   j24gdVFOunhYHulYoQ/VOjC5eEwBCzYr7sQrhP02WGviBgZsHoW4nGDXM
   BRSu9dEVvH/OMshtD3/+By+tpSki3dPf8TZ6n4SeTD/UShE+3GcIAbI3M
   A==;
IronPort-SDR: 0IEEXhUNwQYsaCQ+5nGHFVUbHbRBE02f84yFXYSfTyYK2sxk7UnSlBzmgpRlmZ9UZmM3mFd9rP
 mpkXDySUJrCeJWM45KcFcA8JksbB3ncvThDhe5VsjBUeFKLNtT5hRdiuMj0I11OMOOo7YJKFb7
 FhCvvrIaszedSr0ZycyoYke4rzAffnmY+vo5gH152drLVZlLc8R0bmvJyP8PZQkTi1tlauzcog
 9ize0Thz4nQVHWAYf8I1AFxtOWrxO2OUNPTUn1U4nYf+5pn1G0gRg7hr1daQ5KHuhr775riQ4k
 XnXm0yfl+TOryX/tiFRq+E2m
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="132201067"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:06:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:06:55 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:06:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 04/17] clk: at91: clk-master: add register definition for sama7g5's master clock
Date:   Fri, 17 Sep 2021 15:06:29 +0300
Message-ID: <20210917120642.8993-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 has 4 master clocks (MCK1..4) which are controlled though the
register at offset 0x30 (relative to PMC). In the last/first phase of
suspend/resume procedure (which is architecture specific) the parent
of master clocks are changed (via assembly code) for more power saving
(see file arch/arm/mach-at91/pm_suspend.S, macros at91_mckx_ps_enable
and at91_mckx_ps_restore). Thus the macros corresponding to register
at offset 0x30 need to be shared b/w clk-master.c and pm_suspend.S.
commit ec03f18cc222 ("clk: at91: add register definition for sama7g5's
master clock") introduced the proper macros but didn't adapted the
clk-master.c as well. Thus, this commit adapt the clk-master.c to use
the macros introduced in commit ec03f18cc222 ("clk: at91: add register
definition for sama7g5's master clock").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 50 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index f75549fff023..88f7af1bfff6 100644
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
 
@@ -687,20 +679,22 @@ static void clk_sama7g5_master_set(struct clk_master *master,
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
@@ -725,10 +719,12 @@ static void clk_sama7g5_master_disable(struct clk_hw *hw)
 
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
@@ -741,12 +737,12 @@ static int clk_sama7g5_master_is_enabled(struct clk_hw *hw)
 
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
@@ -842,10 +838,10 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
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
-- 
2.25.1

