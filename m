Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436AE363EED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhDSJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:40:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238723AbhDSJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:39:56 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J9RIWc027862;
        Mon, 19 Apr 2021 11:39:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=uXyVtTDBUJmtuxUnvWVmbHUglnSWIEMzsIhbNXhG5/8=;
 b=GfzPtqmqJpeVDiWRoQhxbyybIgjuOqsManO2+prwtr3ZkhT96E+L4v03lJ4yaIy9qtfO
 h+IPT8TnY7gCtLupm/4bvQt5r5G1RaCrb7Ghlz7FU3wHkmvAY1T17gWDlLa5dlQnJ0Y3
 OHs82JiuHRsIz7T0pnTysVRAJDxOXdJraX6TbDUJbGSmlGxNlfb7GVlW9Mn7ajNDrTFz
 t56cpoyTR0LIOQBpE5riQc142qg7l7XCJe/UvX8EEgH7bKyIz90K71vHL8E6RHFmlgGf
 Lp2U6GvDhuqE755fWOPpHj1dzcgu5uLd6v/1B3mNPgDFdBYEXx27eBIl/JrqScYZboPJ +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380s8c3bga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:39:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59431100034;
        Mon, 19 Apr 2021 11:39:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4887820A07F;
        Mon, 19 Apr 2021 11:39:08 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 11:39:07
 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/11] clk: stm32mp1: remove intermediate pll clocks
Date:   Mon, 19 Apr 2021 11:38:44 +0200
Message-ID: <20210419093852.14978-4-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
References: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_05:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

This patch is to prepare STM32MP1 clocks in trusted mode.
Integrate the mux clock into pll clock will facilitate to have a more
coherent clock tree in no trusted / trusted mode.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/clk-stm32mp1.c | 65 ++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index a7c244fd0b03..24d99da07fc8 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -731,6 +731,7 @@ struct stm32_pll_obj {
 	spinlock_t *lock;
 	void __iomem *reg;
 	struct clk_hw hw;
+	struct clk_mux mux;
 };
 
 #define to_pll(_hw) container_of(_hw, struct stm32_pll_obj, hw)
@@ -745,6 +746,8 @@ struct stm32_pll_obj {
 #define FRAC_MASK	0x1FFF
 #define FRAC_SHIFT	3
 #define FRACLE		BIT(16)
+#define PLL_MUX_SHIFT	0
+#define PLL_MUX_MASK	3
 
 static int __pll_is_enabled(struct clk_hw *hw)
 {
@@ -856,16 +859,29 @@ static int pll_is_enabled(struct clk_hw *hw)
 	return ret;
 }
 
+static u8 pll_get_parent(struct clk_hw *hw)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+	struct clk_hw *mux_hw = &clk_elem->mux.hw;
+
+	__clk_hw_set_clk(mux_hw, hw);
+
+	return clk_mux_ops.get_parent(mux_hw);
+}
+
 static const struct clk_ops pll_ops = {
 	.enable		= pll_enable,
 	.disable	= pll_disable,
 	.recalc_rate	= pll_recalc_rate,
 	.is_enabled	= pll_is_enabled,
+	.get_parent	= pll_get_parent,
 };
 
 static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
-				       const char *parent_name,
+				       const char * const *parent_names,
+				       int num_parents,
 				       void __iomem *reg,
+				       void __iomem *mux_reg,
 				       unsigned long flags,
 				       spinlock_t *lock)
 {
@@ -881,8 +897,15 @@ static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
 	init.name = name;
 	init.ops = &pll_ops;
 	init.flags = flags;
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	element->mux.lock = lock;
+	element->mux.reg =  mux_reg;
+	element->mux.shift = PLL_MUX_SHIFT;
+	element->mux.mask =  PLL_MUX_MASK;
+	element->mux.flags =  CLK_MUX_READ_ONLY;
+	element->mux.reg =  mux_reg;
 
 	element->hw.init = &init;
 	element->reg = reg;
@@ -1074,6 +1097,7 @@ static const struct clk_ops rtc_div_clk_ops = {
 
 struct stm32_pll_cfg {
 	u32 offset;
+	u32 muxoff;
 };
 
 static struct clk_hw *_clk_register_pll(struct device *dev,
@@ -1083,8 +1107,11 @@ static struct clk_hw *_clk_register_pll(struct device *dev,
 {
 	struct stm32_pll_cfg *stm_pll_cfg = cfg->cfg;
 
-	return clk_register_pll(dev, cfg->name, cfg->parent_name,
-				base + stm_pll_cfg->offset, cfg->flags, lock);
+	return clk_register_pll(dev, cfg->name, cfg->parent_names,
+				cfg->num_parents,
+				base + stm_pll_cfg->offset,
+				base + stm_pll_cfg->muxoff,
+				cfg->flags, lock);
 }
 
 struct stm32_cktim_cfg {
@@ -1194,14 +1221,16 @@ _clk_stm32_register_composite(struct device *dev,
 	.func		= _clk_hw_register_mux,\
 }
 
-#define PLL(_id, _name, _parent, _flags, _offset)\
+#define PLL(_id, _name, _parents, _flags, _offset_p, _offset_mux)\
 {\
 	.id		= _id,\
 	.name		= _name,\
-	.parent_name	= _parent,\
-	.flags		= _flags,\
+	.parent_names	= _parents,\
+	.num_parents	= ARRAY_SIZE(_parents),\
+	.flags		= CLK_IGNORE_UNUSED | (_flags),\
 	.cfg		=  &(struct stm32_pll_cfg) {\
-		.offset = _offset,\
+		.offset = _offset_p,\
+		.muxoff = _offset_mux,\
 	},\
 	.func		= _clk_register_pll,\
 }
@@ -1717,21 +1746,11 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 
 	FIXED_FACTOR(CK_HSE_DIV2, "clk-hse-div2", "ck_hse", 0, 1, 2),
 
-	/* ref clock pll */
-	MUX(NO_ID, "ref1", ref12_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK12SELR,
-	    0, 2, CLK_MUX_READ_ONLY),
-
-	MUX(NO_ID, "ref3", ref3_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK3SELR,
-	    0, 2, CLK_MUX_READ_ONLY),
-
-	MUX(NO_ID, "ref4", ref4_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK4SELR,
-	    0, 2, CLK_MUX_READ_ONLY),
-
 	/* PLLs */
-	PLL(PLL1, "pll1", "ref1", CLK_IGNORE_UNUSED, RCC_PLL1CR),
-	PLL(PLL2, "pll2", "ref1", CLK_IGNORE_UNUSED, RCC_PLL2CR),
-	PLL(PLL3, "pll3", "ref3", CLK_IGNORE_UNUSED, RCC_PLL3CR),
-	PLL(PLL4, "pll4", "ref4", CLK_IGNORE_UNUSED, RCC_PLL4CR),
+	PLL(PLL1, "pll1", ref12_parents, 0, RCC_PLL1CR, RCC_RCK12SELR),
+	PLL(PLL2, "pll2", ref12_parents, 0, RCC_PLL2CR, RCC_RCK12SELR),
+	PLL(PLL3, "pll3", ref3_parents, 0, RCC_PLL3CR, RCC_RCK3SELR),
+	PLL(PLL4, "pll4", ref4_parents, 0, RCC_PLL4CR, RCC_RCK4SELR),
 
 	/* ODF */
 	COMPOSITE(PLL1_P, "pll1_p", PARENT("pll1"), 0,
-- 
2.17.1

