Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC2415F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbhIWNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30280 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbhIWNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403292; x=1663939292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lSKdiOrxbun8N+a4R4QbmxvwI0kObncGgHB7kuDzTE0=;
  b=lHBdsoNHa1gzGwm2tE/UwrHB4rc3x50Vgoy4NR4lgpC0kqfxSDh/YyZn
   rhYJAXfMqXrbdiOC3/GaAoZwX8vA/m62ZfC9gn/GRmhCTPFQ2/CIGRikm
   lgbVitBCgtgJS7PoPc43xzGnYKFEOplSdNTYx+kpxM9j8ipyA+j5imJCn
   6KVwN1VKHxLtOzHrBGTZsMKLF1pAxDqK5FfEdXrSuVAFaqqg9v3T24a9D
   F/WcjYW4YQe5dd7XMwu5EIl/b/mRjglxAT06IRHUsg4XgWKtXKDovECwK
   jpaySLZbOn4hDRKIY7GTjil9CfV814AXupLszw5iTuwY7pHOs+iOadQkR
   A==;
IronPort-SDR: Fg1yEcnV0C+x+Qdn7qoKmjJVkOodu0I1qXjbjhy3cV6vPTNBesJqJZeamh1peROfmqc+MmgKHs
 TkItOzbVDbt2JkGI1AJgbgck5dUQjnUfdnr19LUWA5waoQrpkVw1yMmVERt+iSJDvyVAi0/vLS
 svK38o8ZwZbM8EQ93ioPfVYwZdWxhfLWuDQy0hZ0TGnJ1feARl6lqjdTwnHKqfT/ecD1cKKju6
 J2LlvoVgAjih7etKIFp6iYc5zIakMy1gA+3GHxchu0VbfG32UVaewHnedbHQgelAlKUfOTUJFf
 /437OlC0u1vQJhSG51+74ODk
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="130352831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:31 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 12/17] clk: at91: clk-master: add notifier for divider
Date:   Thu, 23 Sep 2021 16:20:41 +0300
Message-ID: <20210923132046.1860549-13-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 supports DVFS by changing cpuck. On SAMA7G5 mck0 shares the same
parent with cpuck as seen in the following clock tree:

                       +----------> cpuck
                       |
FRAC PLL ---> DIV PLL -+-> DIV ---> mck0

mck0 could go b/w 32KHz and 200MHz on SAMA7G5. To avoid mck0 overclocking
while changing FRAC PLL or DIV PLL the commit implements a notifier for
mck0 which applies a safe divider to register (maximum value of the divider
which is 5) on PRE_RATE_CHANGE events (such that changes on PLL to not
overclock mck0) and sets the maximum allowed rate on POST_RATE_CHANGE
events.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  |   2 +-
 drivers/clk/at91/at91sam9260.c |   2 +-
 drivers/clk/at91/at91sam9g45.c |   2 +-
 drivers/clk/at91/at91sam9n12.c |   2 +-
 drivers/clk/at91/at91sam9rl.c  |   2 +-
 drivers/clk/at91/at91sam9x5.c  |   2 +-
 drivers/clk/at91/clk-master.c  | 244 +++++++++++++++++++++++----------
 drivers/clk/at91/dt-compat.c   |   2 +-
 drivers/clk/at91/pmc.h         |   2 +-
 drivers/clk/at91/sama5d2.c     |   2 +-
 drivers/clk/at91/sama5d3.c     |   2 +-
 drivers/clk/at91/sama5d4.c     |   2 +-
 drivers/clk/at91/sama7g5.c     |   2 +-
 13 files changed, 186 insertions(+), 82 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 428a6f4b9ebc..fff4fdda974f 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -152,7 +152,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 					  "masterck_pres",
 					  &at91rm9200_master_layout,
 					  &rm9200_mck_characteristics,
-					  &rm9200_mck_lock, CLK_SET_RATE_GATE);
+					  &rm9200_mck_lock, CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index b29843bea278..79802f864ee5 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -429,7 +429,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 					  &at91rm9200_master_layout,
 					  data->mck_characteristics,
 					  &at91sam9260_mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 15da0dfe3ef2..7ed984f8058c 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -164,7 +164,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 					  &at91rm9200_master_layout,
 					  &mck_characteristics,
 					  &at91sam9g45_mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 7fe435f4b46b..63cc58944b00 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -191,7 +191,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics,
 					  &at91sam9n12_mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index ecbabf5162bd..4d4faf6c61d8 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -132,7 +132,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 					  "masterck_pres",
 					  &at91rm9200_master_layout,
 					  &sam9rl_mck_characteristics,
-					  &sam9rl_mck_lock, CLK_SET_RATE_GATE);
+					  &sam9rl_mck_lock, CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 5cce48c64ea2..bd8007b4f3e0 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -210,7 +210,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 					  "masterck_pres",
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index e67bcd03a827..b2d0a7f4f7f9 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/clk.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
@@ -36,8 +37,12 @@ struct clk_master {
 	u8 id;
 	u8 parent;
 	u8 div;
+	u32 safe_div;
 };
 
+/* MCK div reference to be used by notifier. */
+static struct clk_master *master_div;
+
 static inline bool clk_master_ready(struct clk_master *master)
 {
 	unsigned int bit = master->id ? AT91_PMC_MCKXRDY : AT91_PMC_MCKRDY;
@@ -153,107 +158,81 @@ static const struct clk_ops master_div_ops = {
 	.restore_context = clk_master_div_restore_context,
 };
 
-static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long parent_rate)
+/* This function must be called with lock acquired. */
+static int clk_master_div_set(struct clk_master *master,
+			      unsigned long parent_rate, int div)
 {
-	struct clk_master *master = to_clk_master(hw);
 	const struct clk_master_characteristics *characteristics =
 						master->characteristics;
-	unsigned long flags;
-	unsigned int mckr, tmp;
-	int div, i;
+	unsigned long rate = parent_rate;
+	unsigned int max_div = 0, div_index = 0, max_div_index = 0;
+	unsigned int i, mckr, tmp;
 	int ret;
 
-	div = DIV_ROUND_CLOSEST(parent_rate, rate);
-	if (div > ARRAY_SIZE(characteristics->divisors))
-		return -EINVAL;
-
 	for (i = 0; i < ARRAY_SIZE(characteristics->divisors); i++) {
 		if (!characteristics->divisors[i])
 			break;
 
-		if (div == characteristics->divisors[i]) {
-			div = i;
-			break;
+		if (div == characteristics->divisors[i])
+			div_index = i;
+
+		if (max_div < characteristics->divisors[i]) {
+			max_div = characteristics->divisors[i];
+			max_div_index = i;
 		}
 	}
 
-	if (i == ARRAY_SIZE(characteristics->divisors))
-		return -EINVAL;
+	if (div > max_div)
+		div_index = max_div_index;
 
-	spin_lock_irqsave(master->lock, flags);
 	ret = regmap_read(master->regmap, master->layout->offset, &mckr);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	mckr &= master->layout->mask;
 	tmp = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
-	if (tmp == div)
-		goto unlock;
+	if (tmp == div_index)
+		return 0;
+
+	rate /= characteristics->divisors[div_index];
+	if (rate < characteristics->output.min)
+		pr_warn("master clk div is underclocked");
+	else if (rate > characteristics->output.max)
+		pr_warn("master clk div is overclocked");
 
 	mckr &= ~(MASTER_DIV_MASK << MASTER_DIV_SHIFT);
-	mckr |= (div << MASTER_DIV_SHIFT);
+	mckr |= (div_index << MASTER_DIV_SHIFT);
 	ret = regmap_write(master->regmap, master->layout->offset, mckr);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	while (!clk_master_ready(master))
 		cpu_relax();
-unlock:
-	spin_unlock_irqrestore(master->lock, flags);
+
+	master->div = characteristics->divisors[div_index];
 
 	return 0;
 }
 
-static int clk_master_div_determine_rate(struct clk_hw *hw,
-					 struct clk_rate_request *req)
+static unsigned long clk_master_div_recalc_rate_chg(struct clk_hw *hw,
+						    unsigned long parent_rate)
 {
 	struct clk_master *master = to_clk_master(hw);
-	const struct clk_master_characteristics *characteristics =
-						master->characteristics;
-	struct clk_hw *parent;
-	unsigned long parent_rate, tmp_rate, best_rate = 0;
-	int i, best_diff = INT_MIN, tmp_diff;
-
-	parent = clk_hw_get_parent(hw);
-	if (!parent)
-		return -EINVAL;
-
-	parent_rate = clk_hw_get_rate(parent);
-	if (!parent_rate)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(characteristics->divisors); i++) {
-		if (!characteristics->divisors[i])
-			break;
 
-		tmp_rate = DIV_ROUND_CLOSEST_ULL(parent_rate,
-						 characteristics->divisors[i]);
-		tmp_diff = abs(tmp_rate - req->rate);
-
-		if (!best_rate || best_diff > tmp_diff) {
-			best_diff = tmp_diff;
-			best_rate = tmp_rate;
-		}
-
-		if (!best_diff)
-			break;
-	}
-
-	req->best_parent_rate = best_rate;
-	req->best_parent_hw = parent;
-	req->rate = best_rate;
-
-	return 0;
+	return DIV_ROUND_CLOSEST_ULL(parent_rate, master->div);
 }
 
 static void clk_master_div_restore_context_chg(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
 	int ret;
 
-	ret = clk_master_div_set_rate(hw, master->pms.rate,
-				      master->pms.parent_rate);
+	spin_lock_irqsave(master->lock, flags);
+	ret = clk_master_div_set(master, master->pms.parent_rate,
+				 DIV_ROUND_CLOSEST(master->pms.parent_rate,
+						   master->pms.rate));
+	spin_unlock_irqrestore(master->lock, flags);
 	if (ret)
 		pr_warn("Failed to restore MCK DIV clock\n");
 }
@@ -261,13 +240,116 @@ static void clk_master_div_restore_context_chg(struct clk_hw *hw)
 static const struct clk_ops master_div_ops_chg = {
 	.prepare = clk_master_prepare,
 	.is_prepared = clk_master_is_prepared,
-	.recalc_rate = clk_master_div_recalc_rate,
-	.determine_rate = clk_master_div_determine_rate,
-	.set_rate = clk_master_div_set_rate,
+	.recalc_rate = clk_master_div_recalc_rate_chg,
 	.save_context = clk_master_div_save_context,
 	.restore_context = clk_master_div_restore_context_chg,
 };
 
+static int clk_master_div_notifier_fn(struct notifier_block *notifier,
+				      unsigned long code, void *data)
+{
+	const struct clk_master_characteristics *characteristics =
+						master_div->characteristics;
+	struct clk_notifier_data *cnd = data;
+	unsigned long flags, new_parent_rate, new_rate;
+	unsigned int mckr, div, new_div = 0;
+	int ret, i;
+	long tmp_diff;
+	long best_diff = -1;
+
+	spin_lock_irqsave(master_div->lock, flags);
+	switch (code) {
+	case PRE_RATE_CHANGE:
+		/*
+		 * We want to avoid any overclocking of MCK DIV domain. To do
+		 * this we set a safe divider (the underclocking is not of
+		 * interest as we can go as low as 32KHz). The relation
+		 * b/w this clock and its parents are as follows:
+		 *
+		 * FRAC PLL -> DIV PLL -> MCK DIV
+		 *
+		 * With the proper safe divider we should be good even with FRAC
+		 * PLL at its maximum value.
+		 */
+		ret = regmap_read(master_div->regmap, master_div->layout->offset,
+				  &mckr);
+		if (ret) {
+			ret = NOTIFY_STOP_MASK;
+			goto unlock;
+		}
+
+		mckr &= master_div->layout->mask;
+		div = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+
+		/* Switch to safe divider. */
+		clk_master_div_set(master_div,
+				   cnd->old_rate * characteristics->divisors[div],
+				   master_div->safe_div);
+		break;
+
+	case POST_RATE_CHANGE:
+		/*
+		 * At this point we want to restore MCK DIV domain to its maximum
+		 * allowed rate.
+		 */
+		ret = regmap_read(master_div->regmap, master_div->layout->offset,
+				  &mckr);
+		if (ret) {
+			ret = NOTIFY_STOP_MASK;
+			goto unlock;
+		}
+
+		mckr &= master_div->layout->mask;
+		div = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+		new_parent_rate = cnd->new_rate * characteristics->divisors[div];
+
+		for (i = 0; i < ARRAY_SIZE(characteristics->divisors); i++) {
+			if (!characteristics->divisors[i])
+				break;
+
+			new_rate = DIV_ROUND_CLOSEST_ULL(new_parent_rate,
+							 characteristics->divisors[i]);
+
+			tmp_diff = characteristics->output.max - new_rate;
+			if (tmp_diff < 0)
+				continue;
+
+			if (best_diff < 0 || best_diff > tmp_diff) {
+				new_div = characteristics->divisors[i];
+				best_diff = tmp_diff;
+			}
+
+			if (!tmp_diff)
+				break;
+		}
+
+		if (!new_div) {
+			ret = NOTIFY_STOP_MASK;
+			goto unlock;
+		}
+
+		/* Update the div to preserve MCK DIV clock rate. */
+		clk_master_div_set(master_div, new_parent_rate,
+				   new_div);
+
+		ret = NOTIFY_OK;
+		break;
+
+	default:
+		ret = NOTIFY_DONE;
+		break;
+	}
+
+unlock:
+	spin_unlock_irqrestore(master_div->lock, flags);
+
+	return ret;
+}
+
+static struct notifier_block clk_master_div_notifier = {
+	.notifier_call = clk_master_div_notifier_fn,
+};
+
 static void clk_sama7g5_master_best_diff(struct clk_rate_request *req,
 					 struct clk_hw *parent,
 					 unsigned long parent_rate,
@@ -496,6 +578,8 @@ at91_clk_register_master_internal(struct regmap *regmap,
 	struct clk_master *master;
 	struct clk_init_data init;
 	struct clk_hw *hw;
+	unsigned int mckr;
+	unsigned long irqflags;
 	int ret;
 
 	if (!name || !num_parents || !parent_names || !lock)
@@ -518,6 +602,16 @@ at91_clk_register_master_internal(struct regmap *regmap,
 	master->chg_pid = chg_pid;
 	master->lock = lock;
 
+	if (ops == &master_div_ops_chg) {
+		spin_lock_irqsave(master->lock, irqflags);
+		regmap_read(master->regmap, master->layout->offset, &mckr);
+		spin_unlock_irqrestore(master->lock, irqflags);
+
+		mckr &= layout->mask;
+		mckr = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+		master->div = characteristics->divisors[mckr];
+	}
+
 	hw = &master->hw;
 	ret = clk_hw_register(NULL, &master->hw);
 	if (ret) {
@@ -554,19 +648,29 @@ at91_clk_register_master_div(struct regmap *regmap,
 		const char *name, const char *parent_name,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
-		spinlock_t *lock, u32 flags)
+		spinlock_t *lock, u32 flags, u32 safe_div)
 {
 	const struct clk_ops *ops;
+	struct clk_hw *hw;
 
 	if (flags & CLK_SET_RATE_GATE)
 		ops = &master_div_ops;
 	else
 		ops = &master_div_ops_chg;
 
-	return at91_clk_register_master_internal(regmap, name, 1,
-						 &parent_name, layout,
-						 characteristics, ops,
-						 lock, flags, -EINVAL);
+	hw = at91_clk_register_master_internal(regmap, name, 1,
+					       &parent_name, layout,
+					       characteristics, ops,
+					       lock, flags, -EINVAL);
+
+	if (!IS_ERR(hw) && safe_div) {
+		master_div = to_clk_master(hw);
+		master_div->safe_div = safe_div;
+		clk_notifier_register(hw->clk,
+				      &clk_master_div_notifier);
+	}
+
+	return hw;
 }
 
 static unsigned long
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index a97b99c2dc12..ca2dbb65b9df 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -399,7 +399,7 @@ of_at91_clk_master_setup(struct device_node *np,
 
 	hw = at91_clk_register_master_div(regmap, name, "masterck_pres",
 					  layout, characteristics,
-					  &mck_lock, CLK_SET_RATE_GATE);
+					  &mck_lock, CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 207ecccef29f..3a1bf6194c28 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -182,7 +182,7 @@ at91_clk_register_master_div(struct regmap *regmap, const char *name,
 			     const char *parent_names,
 			     const struct clk_master_layout *layout,
 			     const struct clk_master_characteristics *characteristics,
-			     spinlock_t *lock, u32 flags);
+			     spinlock_t *lock, u32 flags, u32 safe_div);
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 3d1f78176c3e..d027294a0089 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -249,7 +249,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 					  "masterck_pres",
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index d376257807d2..339d0f382ff0 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -184,7 +184,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 					  "masterck_pres",
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 5cbaac68da44..4af75b1e39e9 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -199,7 +199,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 					  "masterck_pres",
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
-					  CLK_SET_RATE_GATE);
+					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index ae52c10af040..c66bde6f7b47 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1003,7 +1003,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	hw = at91_clk_register_master_div(regmap, "mck0", "cpuck",
 					  &mck0_layout, &mck0_characteristics,
-					  &pmc_mck0_lock, 0);
+					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.25.1

