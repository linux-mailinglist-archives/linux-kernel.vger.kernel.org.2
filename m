Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E133D5800
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhGZKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:17:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233287AbhGZKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:17:39 -0400
X-UUID: 9f0a6f5047d142a0b1ef16b6840f1729-20210726
X-UUID: 9f0a6f5047d142a0b1ef16b6840f1729-20210726
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 810884174; Mon, 26 Jul 2021 18:58:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Jul 2021 18:58:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Jul 2021 18:58:02 +0800
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
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v14 08/21] clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
Date:   Mon, 26 Jul 2021 18:57:06 +0800
Message-ID: <20210726105719.15793-9-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of subsystem clock providers only need to register clock gates
in their probe() function.
To reduce the duplicated code by add a generic function.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 23 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 37d2aa32175e..4b6096c44d74 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -13,6 +13,7 @@
 #include <linux/clkdev.h>
 #include <linux/mfd/syscon.h>
 #include <linux/device.h>
+#include <linux/of_device.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -286,3 +287,25 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 			clk_data->clks[mcd->id] = clk;
 	}
 }
+
+int mtk_clk_simple_probe(struct platform_device *pdev)
+{
+	const struct mtk_clk_desc *mcd;
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	mcd = of_device_get_match_data(&pdev->dev);
+	if (!mcd)
+		return -EINVAL;
+
+	clk_data = mtk_alloc_clk_data(mcd->num_clks);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks, clk_data);
+	if (r)
+		return r;
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 31c7cb304508..7de41c3b3206 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -10,6 +10,7 @@
 #include <linux/regmap.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
+#include <linux/platform_device.h>
 
 struct clk;
 struct clk_onecell_data;
@@ -250,4 +251,11 @@ void mtk_register_reset_controller(struct device_node *np,
 void mtk_register_reset_controller_set_clr(struct device_node *np,
 	unsigned int num_regs, int regofs);
 
+struct mtk_clk_desc {
+	const struct mtk_gate *clks;
+	size_t num_clks;
+};
+
+int mtk_clk_simple_probe(struct platform_device *pdev);
+
 #endif /* __DRV_CLK_MTK_H */
-- 
2.18.0

