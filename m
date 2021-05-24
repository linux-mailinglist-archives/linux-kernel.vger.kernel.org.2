Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6038E907
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhEXOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:46:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55115 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233052AbhEXOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:46:45 -0400
X-UUID: b927cc3968194133b1d2c04322e16423-20210524
X-UUID: b927cc3968194133b1d2c04322e16423-20210524
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1008611881; Mon, 24 May 2021 20:29:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 May 2021 20:29:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 May 2021 20:29:11 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "chun-jie . chen" <chun-jie.chen@mediatek.com>
Subject: [PATCH v9 08/22] clk: mediatek: Add configurable enable control to mtk_pll_data
Date:   Mon, 24 May 2021 20:20:39 +0800
Message-ID: <20210524122053.17155-9-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all MediaTek PLL design, bit0 of CON0 register is always
the enable bit.
However, there's a special case of usbpll on MT8192.
The enable bit of usbpll is moved to bit2 of other register.
Add configurable en_reg and pll_en_bit for enable control or
default 0 where pll data are static variables.
Hence, CON0_BASE_EN could also be removed.
And there might have another special case on other chips,
the enable bit is still on CON0 register but not at bit0.

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.h | 20 +++++++++++---------
 drivers/clk/mediatek/clk-pll.c | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c3d6756b0c7e..31c7cb304508 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -213,13 +213,13 @@ struct mtk_pll_div_table {
 struct mtk_pll_data {
 	int id;
 	const char *name;
-	uint32_t reg;
-	uint32_t pwr_reg;
-	uint32_t en_mask;
-	uint32_t pd_reg;
-	uint32_t tuner_reg;
-	uint32_t tuner_en_reg;
-	uint8_t tuner_en_bit;
+	u32 reg;
+	u32 pwr_reg;
+	u32 en_mask;
+	u32 pd_reg;
+	u32 tuner_reg;
+	u32 tuner_en_reg;
+	u8 tuner_en_bit;
 	int pd_shift;
 	unsigned int flags;
 	const struct clk_ops *ops;
@@ -228,11 +228,13 @@ struct mtk_pll_data {
 	unsigned long fmax;
 	int pcwbits;
 	int pcwibits;
-	uint32_t pcw_reg;
+	u32 pcw_reg;
 	int pcw_shift;
-	uint32_t pcw_chg_reg;
+	u32 pcw_chg_reg;
 	const struct mtk_pll_div_table *div_table;
 	const char *parent_name;
+	u32 en_reg;
+	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 };
 
 void mtk_clk_register_plls(struct device_node *node,
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 11ed5d1d1c36..7fb001a4e7d8 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -44,6 +44,7 @@ struct mtk_clk_pll {
 	void __iomem	*tuner_en_addr;
 	void __iomem	*pcw_addr;
 	void __iomem	*pcw_chg_addr;
+	void __iomem	*en_addr;
 	const struct mtk_pll_data *data;
 };
 
@@ -56,7 +57,7 @@ static int mtk_pll_is_prepared(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
-	return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
+	return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
 }
 
 static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
@@ -248,8 +249,8 @@ static int mtk_pll_prepare(struct clk_hw *hw)
 	writel(r, pll->pwr_addr);
 	udelay(1);
 
-	r = readl(pll->base_addr + REG_CON0) | CON0_BASE_EN;
-	writel(r, pll->base_addr + REG_CON0);
+	r = readl(pll->en_addr) | BIT(pll->data->pll_en_bit);
+	writel(r, pll->en_addr);
 
 	div_en_mask = pll->data->en_mask & ~CON0_BASE_EN;
 	if (div_en_mask) {
@@ -290,8 +291,8 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
 		writel(r, pll->base_addr + REG_CON0);
 	}
 
-	r = readl(pll->base_addr + REG_CON0) & ~CON0_BASE_EN;
-	writel(r, pll->base_addr + REG_CON0);
+	r = readl(pll->en_addr) & ~BIT(pll->data->pll_en_bit);
+	writel(r, pll->en_addr);
 
 	r = readl(pll->pwr_addr) | CON0_ISO_EN;
 	writel(r, pll->pwr_addr);
@@ -333,6 +334,10 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		pll->tuner_addr = base + data->tuner_reg;
 	if (data->tuner_en_reg)
 		pll->tuner_en_addr = base + data->tuner_en_reg;
+	if (data->en_reg)
+		pll->en_addr = base + data->en_reg;
+	else
+		pll->en_addr = pll->base_addr + REG_CON0;
 	pll->hw.init = &init;
 	pll->data = data;
 
-- 
2.18.0

