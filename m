Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BDA40AC87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhINLjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:39:37 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33316 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232217AbhINLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:39:30 -0400
X-UUID: d20806d33d304792b247e30a167888cd-20210914
X-UUID: d20806d33d304792b247e30a167888cd-20210914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 343189939; Tue, 14 Sep 2021 19:38:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:38:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:38:08 +0800
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
Subject: [PATCH v4 05/13] memory: mtk-smi: Adjust some code position
Date:   Tue, 14 Sep 2021 19:36:55 +0800
Message-ID: <20210914113703.31466-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Only move the code position to make the code more
readable.
1. Put the register smi-common above smi-larb. Prepare to add some others
   register setting.
2. Put mtk_smi_larb_unbind around larb_bind.
3. Sort the SoC data alphabetically. and put them in one line as the
   current kernel allow it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/memory/mtk-smi.c | 188 ++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 113 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 02a584dfb9b1..33b6c5efe102 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -17,13 +17,16 @@
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <dt-bindings/memory/mtk-memory-port.h>
 
-/* mt8173 */
-#define SMI_LARB_MMU_EN		0xf00
+/* SMI COMMON */
+#define SMI_BUS_SEL			0x220
+#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
+/* All are MMU0 defaultly. Only specialize mmu1 here. */
+#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
-/* mt8167 */
-#define MT8167_SMI_LARB_MMU_EN	0xfc0
+/* SMI LARB */
 
-/* mt2701 */
+/* Below are about mmu enable registers, they are different in SoCs */
+/* gen1: mt2701 */
 #define REG_SMI_SECUR_CON_BASE		0x5c0
 
 /* every register control 8 port, register offset 0x4 */
@@ -41,20 +44,21 @@
 /* mt2701 domain should be set to 3 */
 #define SMI_SECUR_CON_VAL_DOMAIN(id)	(0x3 << ((((id) & 0x7) << 2) + 1))
 
-/* mt2712 */
-#define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
-#define F_MMU_EN		BIT(0)
-#define BANK_SEL(id)		({			\
+/* gen2: */
+/* mt8167 */
+#define MT8167_SMI_LARB_MMU_EN		0xfc0
+
+/* mt8173 */
+#define MT8173_SMI_LARB_MMU_EN		0xf00
+
+/* general */
+#define SMI_LARB_NONSEC_CON(id)		(0x380 + ((id) * 4))
+#define F_MMU_EN			BIT(0)
+#define BANK_SEL(id)			({		\
 	u32 _id = (id) & 0x3;				\
 	(_id << 8 | _id << 10 | _id << 12 | _id << 14);	\
 })
 
-/* SMI COMMON */
-#define SMI_BUS_SEL			0x220
-#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
-/* All are MMU0 defaultly. Only specialize mmu1 here. */
-#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
-
 enum mtk_smi_type {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
@@ -140,36 +144,16 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
-{
-	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-	u32 reg;
-	int i;
-
-	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
-		return;
-
-	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
-		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
-		reg |= F_MMU_EN;
-		reg |= BANK_SEL(larb->bank[i]);
-		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
-	}
-}
-
-static void mtk_smi_larb_config_port_mt8173(struct device *dev)
+static void
+mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-
-	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
+	/* Do nothing as the iommu is always enabled. */
 }
 
-static void mtk_smi_larb_config_port_mt8167(struct device *dev)
-{
-	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-
-	writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
-}
+static const struct component_ops mtk_smi_larb_component_ops = {
+	.bind = mtk_smi_larb_bind,
+	.unbind = mtk_smi_larb_unbind,
+};
 
 static void mtk_smi_larb_config_port_gen1(struct device *dev)
 {
@@ -202,26 +186,36 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 	}
 }
 
-static void
-mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
+static void mtk_smi_larb_config_port_mt8167(struct device *dev)
 {
-	/* Do nothing as the iommu is always enabled. */
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
 }
 
-static const struct component_ops mtk_smi_larb_component_ops = {
-	.bind = mtk_smi_larb_bind,
-	.unbind = mtk_smi_larb_unbind,
-};
+static void mtk_smi_larb_config_port_mt8173(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
-static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
-	/* mt8173 do not need the port in larb */
-	.config_port = mtk_smi_larb_config_port_mt8173,
-};
+	writel(*larb->mmu, larb->base + MT8173_SMI_LARB_MMU_EN);
+}
 
-static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
-	/* mt8167 do not need the port in larb */
-	.config_port = mtk_smi_larb_config_port_mt8167,
-};
+static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	u32 reg;
+	int i;
+
+	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
+		return;
+
+	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
+		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
+		reg |= F_MMU_EN;
+		reg |= BANK_SEL(larb->bank[i]);
+		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
+	}
+}
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
@@ -243,6 +237,16 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
 		/* DUMMY | IPU0 | IPU1 | CCU | MDLA */
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
+	/* mt8167 do not need the port in larb */
+	.config_port = mtk_smi_larb_config_port_mt8167,
+};
+
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
+	/* mt8173 do not need the port in larb */
+	.config_port = mtk_smi_larb_config_port_mt8173,
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 	.larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
@@ -254,34 +258,13 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-	{
-		.compatible = "mediatek,mt8167-smi-larb",
-		.data = &mtk_smi_larb_mt8167
-	},
-	{
-		.compatible = "mediatek,mt8173-smi-larb",
-		.data = &mtk_smi_larb_mt8173
-	},
-	{
-		.compatible = "mediatek,mt2701-smi-larb",
-		.data = &mtk_smi_larb_mt2701
-	},
-	{
-		.compatible = "mediatek,mt2712-smi-larb",
-		.data = &mtk_smi_larb_mt2712
-	},
-	{
-		.compatible = "mediatek,mt6779-smi-larb",
-		.data = &mtk_smi_larb_mt6779
-	},
-	{
-		.compatible = "mediatek,mt8183-smi-larb",
-		.data = &mtk_smi_larb_mt8183
-	},
-	{
-		.compatible = "mediatek,mt8192-smi-larb",
-		.data = &mtk_smi_larb_mt8192
-	},
+	{.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
+	{.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
+	{.compatible = "mediatek,mt6779-smi-larb", .data = &mtk_smi_larb_mt6779},
+	{.compatible = "mediatek,mt8167-smi-larb", .data = &mtk_smi_larb_mt8167},
+	{.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
+	{.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
+	{.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
 	{}
 };
 
@@ -438,34 +421,13 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 };
 
 static const struct of_device_id mtk_smi_common_of_ids[] = {
-	{
-		.compatible = "mediatek,mt8173-smi-common",
-		.data = &mtk_smi_common_gen2,
-	},
-	{
-		.compatible = "mediatek,mt8167-smi-common",
-		.data = &mtk_smi_common_gen2,
-	},
-	{
-		.compatible = "mediatek,mt2701-smi-common",
-		.data = &mtk_smi_common_gen1,
-	},
-	{
-		.compatible = "mediatek,mt2712-smi-common",
-		.data = &mtk_smi_common_gen2,
-	},
-	{
-		.compatible = "mediatek,mt6779-smi-common",
-		.data = &mtk_smi_common_mt6779,
-	},
-	{
-		.compatible = "mediatek,mt8183-smi-common",
-		.data = &mtk_smi_common_mt8183,
-	},
-	{
-		.compatible = "mediatek,mt8192-smi-common",
-		.data = &mtk_smi_common_mt8192,
-	},
+	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
+	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt6779-smi-common", .data = &mtk_smi_common_mt6779},
+	{.compatible = "mediatek,mt8167-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
+	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
 	{}
 };
 
-- 
2.18.0

