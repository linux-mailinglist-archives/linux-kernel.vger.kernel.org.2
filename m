Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7334D3FCBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhHaQnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:43:23 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58462 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240447AbhHaQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:43:12 -0400
X-UUID: f9d12a002fd7498ba245fe0e1adc524f-20210901
X-UUID: f9d12a002fd7498ba245fe0e1adc524f-20210901
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1558391481; Wed, 01 Sep 2021 00:42:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 00:42:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Sep 2021 00:42:12 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/4] clk: mediatek: support COMMON_CLK_MEDIATEK module build
Date:   Wed, 1 Sep 2021 00:42:08 +0800
Message-ID: <20210831164210.15455-3-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210831164210.15455-1-miles.chen@mediatek.com>
References: <20210831164210.15455-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support COMMON_CLK_MEDIATEK module build,
add MODULE_LICENSE and export necessary symbols.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Hanks Chen <hanks.chen@mediatek.com>
Cc: Wendell Lin <wendell.lin@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 3 +++
 drivers/clk/mediatek/clk-cpumux.c  | 3 +++
 drivers/clk/mediatek/clk-gate.c    | 8 ++++++++
 drivers/clk/mediatek/clk-mtk.c     | 8 ++++++++
 drivers/clk/mediatek/clk-mux.c     | 4 ++++
 drivers/clk/mediatek/clk-pll.c     | 4 ++++
 drivers/clk/mediatek/reset.c       | 2 ++
 7 files changed, 32 insertions(+)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index 258d128370f2..caa9119413f1 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
@@ -97,3 +98,5 @@ struct clk * __init mtk_clk_register_ref2usb_tx(const char *name,
 
 	return clk;
 }
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 79fe09028742..f85c755c9fc1 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
@@ -106,3 +107,5 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 
 	return 0;
 }
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index a35cf0b22150..b02d2f74dd0d 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clkdev.h>
+#include <linux/module.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -122,24 +123,28 @@ const struct clk_ops mtk_clk_gate_ops_setclr = {
 	.enable		= mtk_cg_enable,
 	.disable	= mtk_cg_disable,
 };
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr);
 
 const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
 	.is_enabled	= mtk_cg_bit_is_set,
 	.enable		= mtk_cg_enable_inv,
 	.disable	= mtk_cg_disable_inv,
 };
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_inv);
 
 const struct clk_ops mtk_clk_gate_ops_no_setclr = {
 	.is_enabled	= mtk_cg_bit_is_cleared,
 	.enable		= mtk_cg_enable_no_setclr,
 	.disable	= mtk_cg_disable_no_setclr,
 };
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr);
 
 const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 	.is_enabled	= mtk_cg_bit_is_set,
 	.enable		= mtk_cg_enable_inv_no_setclr,
 	.disable	= mtk_cg_disable_inv_no_setclr,
 };
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
 struct clk *mtk_clk_register_gate(
 		const char *name,
@@ -181,3 +186,6 @@ struct clk *mtk_clk_register_gate(
 
 	return clk;
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_gate);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cec1c8a27211..cb2dabe60aaf 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clkdev.h>
+#include <linux/module.h>
 #include <linux/mfd/syscon.h>
 #include <linux/device.h>
 
@@ -41,6 +42,7 @@ struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(mtk_alloc_clk_data);
 
 void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 		int num, struct clk_onecell_data *clk_data)
@@ -67,6 +69,7 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 			clk_data->clks[rc->id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
 
 void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 		int num, struct clk_onecell_data *clk_data)
@@ -93,6 +96,7 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 			clk_data->clks[ff->id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 		const struct mtk_gate *clks,
@@ -145,6 +149,7 @@ int mtk_clk_register_gates(struct device_node *node,
 	return mtk_clk_register_gates_with_dev(node,
 		clks, num, clk_data, NULL);
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
@@ -258,6 +263,7 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
 			clk_data->clks[mc->id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
 
 void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 			int num, void __iomem *base, spinlock_t *lock,
@@ -286,3 +292,5 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 			clk_data->clks[mcd->id] = clk;
 	}
 }
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index b0c61709bacc..a507eea26cc7 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -8,6 +8,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 
 #include "clk-mtk.h"
 #include "clk-mux.h"
@@ -190,3 +191,6 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f440f2cd0b69..399e7b4297c8 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -7,6 +7,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
@@ -368,3 +369,6 @@ void mtk_clk_register_plls(struct device_node *node,
 		clk_data->clks[pll->id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index cb939c071b0c..9079bfc29ec0 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -137,3 +137,5 @@ void mtk_register_reset_controller_set_clr(struct device_node *np,
 	mtk_register_reset_controller_common(np, num_regs, regofs,
 		&mtk_reset_ops_set_clr);
 }
+
+MODULE_LICENSE("GPL");
-- 
2.18.0

