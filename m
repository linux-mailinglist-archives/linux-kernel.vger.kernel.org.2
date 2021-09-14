Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11140AC80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhINLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:39:10 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60810 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232168AbhINLjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:39:09 -0400
X-UUID: 98ca5b14233148e7bbdb3a3f6d20cd1e-20210914
X-UUID: 98ca5b14233148e7bbdb3a3f6d20cd1e-20210914
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1920202189; Tue, 14 Sep 2021 19:37:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:37:48 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:37:46 +0800
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
        <anthony.huang@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v4 03/13] memory: mtk-smi: Use clk_bulk clock ops
Date:   Tue, 14 Sep 2021 19:36:53 +0800
Message-ID: <20210914113703.31466-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_bulk interface instead of the orginal one to simplify the code.

For SMI larbs: Require apb/smi clocks while gals is optional.
For SMI common: Require apb/smi/gals0/gal1 in has_gals case. Otherwise,
                also only require apb/smi, No optional clk here.

About the "has_gals" flag, for smi larbs, the gals clock also may be
optional even this platform support it. thus it always use
*_bulk_get_optional, then the flag has_gals is unnecessary. Remove it.
The smi_common's has_gals still keep it.

Also remove clk fail logs since bulk interface already output fail log.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 143 +++++++++++++++------------------------
 1 file changed, 55 insertions(+), 88 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index c5fb51f73b34..f91eaf5c3ab0 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -60,6 +60,20 @@ enum mtk_smi_gen {
 	MTK_SMI_GEN2
 };
 
+#define MTK_SMI_CLK_NR_MAX			4
+
+/* larbs: Require apb/smi clocks while gals is optional. */
+static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
+#define MTK_SMI_LARB_REQ_CLK_NR		2
+#define MTK_SMI_LARB_OPT_CLK_NR		1
+
+/*
+ * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
+ */
+static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
+#define MTK_SMI_COM_REQ_CLK_NR		2
+#define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
+
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
 	bool             has_gals;
@@ -70,13 +84,12 @@ struct mtk_smi_larb_gen {
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
@@ -95,45 +108,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
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
@@ -270,7 +244,6 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
-	.has_gals                   = true,
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 	.larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
 				      /* IPU0 | IPU1 | CCU */
@@ -312,6 +285,27 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{}
 };
 
+static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
+				const char * const clks[],
+				unsigned int clk_nr_required,
+				unsigned int clk_nr_optional)
+{
+	int i, ret;
+
+	for (i = 0; i < clk_nr_required; i++)
+		smi->clks[i].id = clks[i];
+	ret = devm_clk_bulk_get(dev, clk_nr_required, smi->clks);
+	if (ret)
+		return ret;
+
+	for (i = clk_nr_required; i < clk_nr_required + clk_nr_optional; i++)
+		smi->clks[i].id = clks[i];
+	ret = devm_clk_bulk_get_optional(dev, clk_nr_optional,
+					 smi->clks + clk_nr_required);
+	smi->clk_num = clk_nr_required + clk_nr_optional;
+	return ret;
+}
+
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
@@ -320,6 +314,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
 	struct device_link *link;
+	int ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
@@ -331,24 +326,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
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
+	ret = mtk_smi_dts_clk_init(dev, &larb->smi, mtk_smi_larb_clks,
+				   MTK_SMI_LARB_REQ_CLK_NR, MTK_SMI_LARB_OPT_CLK_NR);
+	if (ret)
+		return ret;
 
+	larb->smi.dev = dev;
 	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
 	if (!smi_node)
 		return -EINVAL;
@@ -391,11 +374,9 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
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
@@ -407,7 +388,7 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
-	mtk_smi_clk_disable(&larb->smi);
+	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
 	return 0;
 }
 
@@ -493,7 +474,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
 	struct resource *res;
-	int ret;
+	int ret, clk_required = MTK_SMI_COM_REQ_CLK_NR;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
@@ -501,23 +482,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
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
+	if (common->plat->has_gals)
+		clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
+	ret = mtk_smi_dts_clk_init(dev, common, mtk_smi_common_clks, clk_required, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
@@ -561,11 +530,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
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
@@ -576,7 +543,7 @@ static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
 
-	mtk_smi_clk_disable(common);
+	clk_bulk_disable_unprepare(common->clk_num, common->clks);
 	return 0;
 }
 
-- 
2.18.0

