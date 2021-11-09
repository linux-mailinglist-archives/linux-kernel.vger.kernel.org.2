Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3344A566
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhKIDuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:50:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236843AbhKIDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:50:43 -0500
X-UUID: fd162331aa2844248900026026701ba0-20211109
X-UUID: fd162331aa2844248900026026701ba0-20211109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 624539531; Tue, 09 Nov 2021 11:47:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 9 Nov 2021 11:47:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 9 Nov 2021 11:47:51 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v1] clk: mediatek: Integrated vppsys with mtk-mmsys in MT8195
Date:   Tue, 9 Nov 2021 11:47:41 +0800
Message-ID: <20211109034741.27083-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrated vpp0 and vpp1 with mtk-mmsys driver which
will populate device by platform_device_register_data
to start vppsys clock driver.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
This patch is based on v5.15-rc7 and [1].

Due to the modification in [2], the vppsys clock driver will be trigger
from mmsys driver

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=546235
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20211020071448.14187-7-roy-cw.yeh@mediatek.com/
---
 drivers/clk/mediatek/clk-mt8195-vpp0.c | 39 +++++++++++++++++---------
 drivers/clk/mediatek/clk-mt8195-vpp1.c | 39 +++++++++++++++++---------
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index c3241466a8d0..c7fec35db1e6 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -86,25 +86,36 @@ static const struct mtk_gate vpp0_clks[] = {
 	GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
 };
 
-static const struct mtk_clk_desc vpp0_desc = {
-	.clks = vpp0_clks,
-	.num_clks = ARRAY_SIZE(vpp0_clks),
-};
+static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data;
+	int r;
 
-static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
-	{
-		.compatible = "mediatek,mt8195-vppsys0",
-		.data = &vpp0_desc,
-	}, {
-		/* sentinel */
-	}
-};
+	clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
+	if (r)
+		goto free_vpp0_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_vpp0_data;
+
+	return r;
+
+free_vpp0_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
 
 static struct platform_driver clk_mt8195_vpp0_drv = {
-	.probe = mtk_clk_simple_probe,
+	.probe = clk_mt8195_vpp0_probe,
 	.driver = {
 		.name = "clk-mt8195-vpp0",
-		.of_match_table = of_match_clk_mt8195_vpp0,
 	},
 };
 builtin_platform_driver(clk_mt8195_vpp0_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index ce0b9a40a179..40ec8c26ede6 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -84,25 +84,36 @@ static const struct mtk_gate vpp1_clks[] = {
 	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),
 };
 
-static const struct mtk_clk_desc vpp1_desc = {
-	.clks = vpp1_clks,
-	.num_clks = ARRAY_SIZE(vpp1_clks),
-};
+static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data;
+	int r;
 
-static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
-	{
-		.compatible = "mediatek,mt8195-vppsys1",
-		.data = &vpp1_desc,
-	}, {
-		/* sentinel */
-	}
-};
+	clk_data = mtk_alloc_clk_data(CLK_VPP1_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
+	if (r)
+		goto free_vpp1_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_vpp1_data;
+
+	return r;
+
+free_vpp1_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
 
 static struct platform_driver clk_mt8195_vpp1_drv = {
-	.probe = mtk_clk_simple_probe,
+	.probe = clk_mt8195_vpp1_probe,
 	.driver = {
 		.name = "clk-mt8195-vpp1",
-		.of_match_table = of_match_clk_mt8195_vpp1,
 	},
 };
 builtin_platform_driver(clk_mt8195_vpp1_drv);
-- 
2.18.0

