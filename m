Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDA40A379
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhINCTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52400 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238631AbhINCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:19:07 -0400
X-UUID: c8607808247b4488a4eaf985649cad4c-20210914
X-UUID: c8607808247b4488a4eaf985649cad4c-20210914
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1419661368; Tue, 14 Sep 2021 10:17:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:46 +0800
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
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v3 24/24] clk: mediatek: Add MT8195 apusys clock support
Date:   Tue, 14 Sep 2021 10:16:33 +0800
Message-ID: <20210914021633.26377-25-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 apusys clock controller which provides PLLs
in AI processor Unit.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile                |  3 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 92 ++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apusys_pll.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 3c602af49c0a..dc96038a0155 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
 				   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
 				   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
-				   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o
+				   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
+				   clk-mt8195-apusys_pll.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
new file mode 100644
index 000000000000..f1c84186346e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8195-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#define MT8195_PLL_FMAX		(3800UL * MHZ)
+#define MT8195_PLL_FMIN		(1500UL * MHZ)
+#define MT8195_INTEGER_BITS	(8)
+#define MT8195_PCW_BITS		(22)
+#define MT8195_POSDIV_SHIFT	(24)
+#define MT8195_PLL_EN_BIT	(0)
+#define MT8195_PCW_SHIFT	(0)
+
+/*
+ * The "en_reg" and "pcw_chg_reg" fields are standard offset register compared
+ * with "reg" field, so set zero to imply it.
+ * No tuner control in apu pll, so set "tuner_XXX" as zero to imply it.
+ * No rst or post divider enable in apu pll, so set "rst_bar_mask" and "en_mask"
+ * as zero to imply it.
+ */
+#define PLL(_id, _name, _reg, _pwr_reg, _pd_reg, _pcw_reg) {		\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = 0,						\
+		.flags = 0,						\
+		.rst_bar_mask = 0,					\
+		.fmax = MT8195_PLL_FMAX,				\
+		.fmin = MT8195_PLL_FMIN,				\
+		.pcwbits = MT8195_PCW_BITS,				\
+		.pcwibits = MT8195_INTEGER_BITS,			\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = MT8195_POSDIV_SHIFT,			\
+		.tuner_reg = 0,						\
+		.tuner_en_reg = 0,					\
+		.tuner_en_bit = 0,					\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = MT8195_PCW_SHIFT,				\
+		.pcw_chg_reg = 0,					\
+		.en_reg = 0,						\
+		.pll_en_bit = MT8195_PLL_EN_BIT,			\
+	}
+
+static const struct mtk_pll_data apusys_plls[] = {
+	PLL(CLK_APUSYS_PLL_APUPLL, "apusys_pll_apupll", 0x008, 0x014, 0x00c, 0x00c),
+	PLL(CLK_APUSYS_PLL_NPUPLL, "apusys_pll_npupll", 0x018, 0x024, 0x01c, 0x01c),
+	PLL(CLK_APUSYS_PLL_APUPLL1, "apusys_pll_apupll1", 0x028, 0x034, 0x02c, 0x02c),
+	PLL(CLK_APUSYS_PLL_APUPLL2, "apusys_pll_apupll2", 0x038, 0x044, 0x03c, 0x03c),
+};
+
+static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_APUSYS_PLL_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_apusys_pll_data;
+
+	return r;
+
+free_apusys_pll_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
+	{ .compatible = "mediatek,mt8195-apusys_pll", },
+	{}
+};
+
+static struct platform_driver clk_mt8195_apusys_pll_drv = {
+	.probe = clk_mt8195_apusys_pll_probe,
+	.driver = {
+		.name = "clk-mt8195-apusys_pll",
+		.of_match_table = of_match_clk_mt8195_apusys_pll,
+	},
+};
+builtin_platform_driver(clk_mt8195_apusys_pll_drv);
-- 
2.18.0

