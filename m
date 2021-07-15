Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84DA3C9E58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhGOMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:15:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39636 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233131AbhGOMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:15:52 -0400
X-UUID: c16661f49439486c8c060586c7d03850-20210715
X-UUID: c16661f49439486c8c060586c7d03850-20210715
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 76615491; Thu, 15 Jul 2021 20:12:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:12:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:12:53 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>
Subject: [PATCH v2 03/11] memory: mtk-smi: Use clk_bulk clock ops
Date:   Thu, 15 Jul 2021 20:12:01 +0800
Message-ID: <20210715121209.31024-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210715121209.31024-1-yong.wu@mediatek.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_bulk interface instead of the orginal one to simplify the code.

SMI have several clocks: apb/smi/gals, the apb/smi clocks are required
for both smi-common and smi-larb while the gals clock are optional.
thus, use devm_clk_bulk_get for apb/smi and use
devm_clk_bulk_get_optional for gals.

For gals clocks, we already use get_optional for it, then the flag
"has_gals" is not helpful now, remove it.

Also remove clk fail logs since bulk interface already output fail log.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 138 +++++++++++++--------------------------
 1 file changed, 47 insertions(+), 91 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index c5fb51f73b34..a2213452059d 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -60,9 +60,15 @@ enum mtk_smi_gen {
 	MTK_SMI_GEN2
 };
 
+#define MTK_SMI_CLK_NR_MAX			4
+
+/* Always require apb/smi clocks while gals clocks are optional. */
+static const char * const mtk_smi_clks_required[] = {"apb", "smi"};
+static const char * const mtk_smi_common_clks_optional[] = {"gals0", "gals1"};
+static const char * const mtk_smi_larb_clks_optional[] = {"gals"};
+
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
-	bool             has_gals;
 	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
@@ -70,13 +76,12 @@ struct mtk_smi_larb_gen {
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *dev);
 	unsigned int			larb_direct_to_common_mask;
-	bool				has_gals;
 };
 
 struct mtk_smi {
 	struct device			*dev;
-	struct clk			*clk_apb, *clk_smi;
-	struct clk			*clk_gals0, *clk_gals1;
+	unsigned int			clk_num;
+	struct clk_bulk_data		clks[MTK_SMI_CLK_NR_MAX];
 	struct clk			*clk_async; /*only needed by mt2701*/
 	union {
 		void __iomem		*smi_ao_base; /* only for gen1 */
@@ -95,45 +100,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	unsigned char			*bank;
 };
 
-static int mtk_smi_clk_enable(const struct mtk_smi *smi)
-{
-	int ret;
-
-	ret = clk_prepare_enable(smi->clk_apb);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(smi->clk_smi);
-	if (ret)
-		goto err_disable_apb;
-
-	ret = clk_prepare_enable(smi->clk_gals0);
-	if (ret)
-		goto err_disable_smi;
-
-	ret = clk_prepare_enable(smi->clk_gals1);
-	if (ret)
-		goto err_disable_gals0;
-
-	return 0;
-
-err_disable_gals0:
-	clk_disable_unprepare(smi->clk_gals0);
-err_disable_smi:
-	clk_disable_unprepare(smi->clk_smi);
-err_disable_apb:
-	clk_disable_unprepare(smi->clk_apb);
-	return ret;
-}
-
-static void mtk_smi_clk_disable(const struct mtk_smi *smi)
-{
-	clk_disable_unprepare(smi->clk_gals1);
-	clk_disable_unprepare(smi->clk_gals0);
-	clk_disable_unprepare(smi->clk_smi);
-	clk_disable_unprepare(smi->clk_apb);
-}
-
 int mtk_smi_larb_get(struct device *larbdev)
 {
 	int ret = pm_runtime_resume_and_get(larbdev);
@@ -270,7 +236,6 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
-	.has_gals                   = true,
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 	.larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
 				      /* IPU0 | IPU1 | CCU */
@@ -312,6 +277,27 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{}
 };
 
+static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
+				unsigned int clk_nr_optional,
+				const char * const clk_optional[])
+{
+	int i, ret, clk_nr_required;
+
+	clk_nr_required = ARRAY_SIZE(mtk_smi_clks_required);
+	for (i = 0; i < clk_nr_required; i++)
+		smi->clks[i].id = mtk_smi_clks_required[i];
+	ret = devm_clk_bulk_get(dev, clk_nr_required, smi->clks);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < clk_nr_optional; i++)
+		smi->clks[i + clk_nr_required].id = clk_optional[i];
+	ret = devm_clk_bulk_get_optional(dev, clk_nr_optional,
+					 smi->clks + clk_nr_required);
+	smi->clk_num = clk_nr_required + clk_nr_optional;
+	return ret;
+}
+
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
@@ -320,6 +306,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
 	struct device_link *link;
+	int ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
@@ -331,24 +318,13 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (IS_ERR(larb->base))
 		return PTR_ERR(larb->base);
 
-	larb->smi.clk_apb = devm_clk_get(dev, "apb");
-	if (IS_ERR(larb->smi.clk_apb))
-		return PTR_ERR(larb->smi.clk_apb);
-
-	larb->smi.clk_smi = devm_clk_get(dev, "smi");
-	if (IS_ERR(larb->smi.clk_smi))
-		return PTR_ERR(larb->smi.clk_smi);
-
-	if (larb->larb_gen->has_gals) {
-		/* The larbs may still haven't gals even if the SoC support.*/
-		larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
-		if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
-			larb->smi.clk_gals0 = NULL;
-		else if (IS_ERR(larb->smi.clk_gals0))
-			return PTR_ERR(larb->smi.clk_gals0);
-	}
-	larb->smi.dev = dev;
+	ret = mtk_smi_dts_clk_init(dev, &larb->smi,
+				   ARRAY_SIZE(mtk_smi_larb_clks_optional),
+				   mtk_smi_larb_clks_optional);
+	if (ret)
+		return ret;
 
+	larb->smi.dev = dev;
 	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
 	if (!smi_node)
 		return -EINVAL;
@@ -391,11 +367,9 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
 	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
 	int ret;
 
-	ret = mtk_smi_clk_enable(&larb->smi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable clock(%d).\n", ret);
+	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Configure the basic setting for this larb */
 	larb_gen->config_port(dev);
@@ -407,7 +381,7 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
-	mtk_smi_clk_disable(&larb->smi);
+	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
 	return 0;
 }
 
@@ -437,21 +411,18 @@ static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
 	.gen		= MTK_SMI_GEN2,
-	.has_gals	= true,
 	.bus_sel	= F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
 			  F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
 	.gen      = MTK_SMI_GEN2,
-	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 	.gen      = MTK_SMI_GEN2,
-	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(6),
 };
@@ -501,23 +472,10 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	common->dev = dev;
 	common->plat = of_device_get_match_data(dev);
 
-	common->clk_apb = devm_clk_get(dev, "apb");
-	if (IS_ERR(common->clk_apb))
-		return PTR_ERR(common->clk_apb);
-
-	common->clk_smi = devm_clk_get(dev, "smi");
-	if (IS_ERR(common->clk_smi))
-		return PTR_ERR(common->clk_smi);
-
-	if (common->plat->has_gals) {
-		common->clk_gals0 = devm_clk_get(dev, "gals0");
-		if (IS_ERR(common->clk_gals0))
-			return PTR_ERR(common->clk_gals0);
-
-		common->clk_gals1 = devm_clk_get(dev, "gals1");
-		if (IS_ERR(common->clk_gals1))
-			return PTR_ERR(common->clk_gals1);
-	}
+	ret = mtk_smi_dts_clk_init(dev, common, ARRAY_SIZE(mtk_smi_common_clks_optional),
+				   mtk_smi_common_clks_optional);
+	if (ret)
+		return ret;
 
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
@@ -561,11 +519,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 	u32 bus_sel = common->plat->bus_sel;
 	int ret;
 
-	ret = mtk_smi_clk_enable(common);
-	if (ret) {
-		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
+	ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
+	if (ret)
 		return ret;
-	}
 
 	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
 		writel(bus_sel, common->base + SMI_BUS_SEL);
@@ -576,7 +532,7 @@ static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
 
-	mtk_smi_clk_disable(common);
+	clk_bulk_disable_unprepare(common->clk_num, common->clks);
 	return 0;
 }
 
-- 
2.18.0

