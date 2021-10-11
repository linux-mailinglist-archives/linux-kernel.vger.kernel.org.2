Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9B428C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhJKLaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:30:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22896 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhJKL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951678; x=1665487678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rUNzk6TIFLs7zjG6DIsoWGoRiw6L4nhGSRHkTEIf6IY=;
  b=XQN2UtcQCZJKpNPt+dPt/WEmvPCo7a0D9r/uypUa4K4YTX1Eigqw0wER
   dBn3BDy9ebbJLKqE0fX+Qz/0abddCy2u8ah3D3yz0vu/UibRMU+KpXLyt
   Pk4uqNfCFus1pO4/UCyCiFZX9J6VX6++7Vx/N0A2ClIIWsoelRsv2+wr8
   J9Lc//hL1Vyj9tGB8yKGcM0oF80LEukBKD9DqoKVTcPgHJthJKr0q3wZW
   sXG1xyQMGuWILawSJcLcOqPTsWCprPiJK2ZOIRq7EAF2pWuHo9zELCZub
   4oGAIZhqQhCLk34WKsqCq+AFxQOHg/2uxclWfcUJw1EC62wGB4YTlCY3A
   A==;
IronPort-SDR: oa1zIwt3XlOQ3l3m8Bu07v54+3n43bS4MuOdKFq8a7ogh0UYoBITjgF5cADQaVHKYSoE+vE+b1
 T1NI8mfjeyzdkp3MW0wPFoctDgrfetZN3DLE1PVicpYkhcpGOXSWFP+fQNtdY/U8NAzJ3FLGOx
 +pLtIc/+wojQSPq+t+kB633ZXqj3fbMBpKMvUQvrbLaVzN1kH3DhirRQ4Yrlvt3ytV82bVHbzE
 QDh6No8uDk49KLrCs5Y7xsbN5NTyjzq/tNEhjtc+NSxORbYzRKQ9mGpvGATEdfx9Bn3fWIU/yi
 W0LtVqKgwreSWILlHWmEQoey
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="147591054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:57 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 11/15] clk: at91: clk-sam9x60-pll: add notifier for div part of PLL
Date:   Mon, 11 Oct 2021 14:27:15 +0300
Message-ID: <20211011112719.3951784-12-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAM9X60's PLL which is also part of SAMA7G5 is composed of 2 parts:
one fractional part and one divider. On SAMA7G5 the CPU PLL could be
changed at run-time to implement DVFS. The hardware clock tree on
SAMA7G5 for CPU PLL is as follows:

                       +---- div1 ----------------> cpuck
                       |
FRAC PLL ---> DIV PLL -+-> prescaler ---> div0 ---> mck0

The div1 block is not implemented in Linux; on prescaler block it has
been discovered a bug on some scenarios and will be removed from Linux
in next commits. Thus, the final clock tree that will be used in Linux
will be as follows:

                       +-----------> cpuck
                       |
FRAC PLL ---> DIV PLL -+-> div0 ---> mck0

It has been proposed in [1] to not introduce a new CPUFreq driver but
to overload the proper clock drivers with proper operation such that
cpufreq-dt to be used. To accomplish this DIV PLL and div0 implement
clock notifiers which applies safe dividers before FRAC PLL is changed.
The current commit treats only the DIV PLL by adding a notifier that
sets a safe divider on PRE_RATE_CHANGE events. The safe divider is
provided by initialization clock code (sama7g5.c). The div0 is treated
in next commits (to keep the changes as clean as possible).

[1] https://lore.kernel.org/lkml/20210105104426.4tmgc2l3vyicwedd@vireshk-i7/

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 102 ++++++++++++++++++++++-------
 drivers/clk/at91/pmc.h             |   3 +-
 drivers/clk/at91/sam9x60.c         |   6 +-
 drivers/clk/at91/sama7g5.c         |  13 +++-
 4 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index a73d7c96ce1d..d757003004cb 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -47,12 +48,15 @@ struct sam9x60_div {
 	struct sam9x60_pll_core core;
 	struct at91_clk_pms pms;
 	u8 div;
+	u8 safe_div;
 };
 
 #define to_sam9x60_pll_core(hw)	container_of(hw, struct sam9x60_pll_core, hw)
 #define to_sam9x60_frac(core)	container_of(core, struct sam9x60_frac, core)
 #define to_sam9x60_div(core)	container_of(core, struct sam9x60_div, core)
 
+static struct sam9x60_div *notifier_div;
+
 static inline bool sam9x60_pll_ready(struct regmap *regmap, int id)
 {
 	unsigned int status;
@@ -329,6 +333,26 @@ static const struct clk_ops sam9x60_frac_pll_ops_chg = {
 	.restore_context = sam9x60_frac_pll_restore_context,
 };
 
+/* This function should be called with spinlock acquired. */
+static void sam9x60_div_pll_set_div(struct sam9x60_pll_core *core, u32 div,
+				    bool enable)
+{
+	struct regmap *regmap = core->regmap;
+	u32 ena_msk = enable ? core->layout->endiv_mask : 0;
+	u32 ena_val = enable ? (1 << core->layout->endiv_shift) : 0;
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
+			   core->layout->div_mask | ena_msk,
+			   (div << core->layout->div_shift) | ena_val);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
+
+	while (!sam9x60_pll_ready(regmap, core->id))
+		cpu_relax();
+}
+
 static int sam9x60_div_pll_set(struct sam9x60_pll_core *core)
 {
 	struct sam9x60_div *div = to_sam9x60_div(core);
@@ -346,17 +370,7 @@ static int sam9x60_div_pll_set(struct sam9x60_pll_core *core)
 	if (!!(val & core->layout->endiv_mask) && cdiv == div->div)
 		goto unlock;
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
-			   core->layout->div_mask | core->layout->endiv_mask,
-			   (div->div << core->layout->div_shift) |
-			   (1 << core->layout->endiv_shift));
-
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
-			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
-			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
-
-	while (!sam9x60_pll_ready(regmap, core->id))
-		cpu_relax();
+	sam9x60_div_pll_set_div(core, div->div, 1);
 
 unlock:
 	spin_unlock_irqrestore(core->lock, flags);
@@ -502,16 +516,7 @@ static int sam9x60_div_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 	if (cdiv == div->div)
 		goto unlock;
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
-			   core->layout->div_mask,
-			   (div->div << core->layout->div_shift));
-
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
-			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
-			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
-
-	while (!sam9x60_pll_ready(regmap, core->id))
-		cpu_relax();
+	sam9x60_div_pll_set_div(core, div->div, 0);
 
 unlock:
 	spin_unlock_irqrestore(core->lock, irqflags);
@@ -538,6 +543,48 @@ static void sam9x60_div_pll_restore_context(struct clk_hw *hw)
 		sam9x60_div_pll_set(core);
 }
 
+static int sam9x60_div_pll_notifier_fn(struct notifier_block *notifier,
+				       unsigned long code, void *data)
+{
+	struct sam9x60_div *div = notifier_div;
+	struct sam9x60_pll_core core = div->core;
+	struct regmap *regmap = core.regmap;
+	unsigned long irqflags;
+	u32 val, cdiv;
+	int ret = NOTIFY_DONE;
+
+	if (code != PRE_RATE_CHANGE)
+		return ret;
+
+	/*
+	 * We switch to safe divider to avoid overclocking of other domains
+	 * feed by us while the frac PLL (our parent) is changed.
+	 */
+	div->div = div->safe_div;
+
+	spin_lock_irqsave(core.lock, irqflags);
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
+			   core.id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
+	cdiv = (val & core.layout->div_mask) >> core.layout->div_shift;
+
+	/* Stop if nothing changed. */
+	if (cdiv == div->safe_div)
+		goto unlock;
+
+	sam9x60_div_pll_set_div(&core, div->div, 0);
+	ret = NOTIFY_OK;
+
+unlock:
+	spin_unlock_irqrestore(core.lock, irqflags);
+
+	return ret;
+}
+
+static struct notifier_block sam9x60_div_pll_notifier = {
+	.notifier_call = sam9x60_div_pll_notifier_fn,
+};
+
 static const struct clk_ops sam9x60_div_pll_ops = {
 	.prepare = sam9x60_div_pll_prepare,
 	.unprepare = sam9x60_div_pll_unprepare,
@@ -647,7 +694,8 @@ struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 			     const char *name, const char *parent_name, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
-			     const struct clk_pll_layout *layout, u32 flags)
+			     const struct clk_pll_layout *layout, u32 flags,
+			     u32 safe_div)
 {
 	struct sam9x60_div *div;
 	struct clk_hw *hw;
@@ -656,9 +704,13 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	unsigned int val;
 	int ret;
 
-	if (id > PLL_MAX_ID || !lock)
+	/* We only support one changeable PLL. */
+	if (id > PLL_MAX_ID || !lock || (safe_div && notifier_div))
 		return ERR_PTR(-EINVAL);
 
+	if (safe_div >= PLL_DIV_MAX)
+		safe_div = PLL_DIV_MAX - 1;
+
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
 		return ERR_PTR(-ENOMEM);
@@ -678,6 +730,7 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	div->core.layout = layout;
 	div->core.regmap = regmap;
 	div->core.lock = lock;
+	div->safe_div = safe_div;
 
 	spin_lock_irqsave(div->core.lock, irqflags);
 
@@ -693,6 +746,9 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	if (ret) {
 		kfree(div);
 		hw = ERR_PTR(ret);
+	} else if (div->safe_div) {
+		notifier_div = div;
+		clk_notifier_register(hw->clk, &sam9x60_div_pll_notifier);
 	}
 
 	return hw;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 45df094498ce..207ecccef29f 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -214,7 +214,8 @@ struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 			     const char *name, const char *parent_name, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
-			     const struct clk_pll_layout *layout, u32 flags);
+			     const struct clk_pll_layout *layout, u32 flags,
+			     u32 safe_div);
 
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 5f6fa89571b7..5c264185f261 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -242,7 +242,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 					    * This feeds CPU. It should not
 					    * be disabled.
 					    */
-					  CLK_IS_CRITICAL | CLK_SET_RATE_GATE);
+					  CLK_IS_CRITICAL | CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -260,7 +260,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 					  &pll_div_layout,
 					  CLK_SET_RATE_GATE |
 					  CLK_SET_PARENT_GATE |
-					  CLK_SET_RATE_PARENT);
+					  CLK_SET_RATE_PARENT, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -279,7 +279,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
 					  "masterck_pres", &sam9x60_master_layout,
 					  &mck_characteristics, &mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 970135e19a75..ae52c10af040 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -127,6 +127,8 @@ static const struct clk_pll_characteristics pll_characteristics = {
  * @t:		clock type
  * @f:		clock flags
  * @eid:	export index in sama7g5->chws[] array
+ * @safe_div:	intermediate divider need to be set on PRE_RATE_CHANGE
+ *		notification
  */
 static const struct {
 	const char *n;
@@ -136,6 +138,7 @@ static const struct {
 	unsigned long f;
 	u8 t;
 	u8 eid;
+	u8 safe_div;
 } sama7g5_plls[][PLL_ID_MAX] = {
 	[PLL_ID_CPU] = {
 		{ .n = "cpupll_fracck",
@@ -156,7 +159,12 @@ static const struct {
 		  .t = PLL_TYPE_DIV,
 		   /* This feeds CPU. It should not be disabled. */
 		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-		  .eid = PMC_CPUPLL, },
+		  .eid = PMC_CPUPLL,
+		  /*
+		   * Safe div=15 should be safe even for switching b/w 1GHz and
+		   * 90MHz (frac pll might go up to 1.2GHz).
+		   */
+		  .safe_div = 15, },
 	},
 
 	[PLL_ID_SYS] = {
@@ -967,7 +975,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 					sama7g5_plls[i][j].p, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
-					sama7g5_plls[i][j].f);
+					sama7g5_plls[i][j].f,
+					sama7g5_plls[i][j].safe_div);
 				break;
 
 			default:
-- 
2.25.1

