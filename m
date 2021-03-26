Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578034A290
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhCZHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:34:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54027 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230006AbhCZHe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:34:27 -0400
X-UUID: 72fd9a0a576544e898dcdd3f44bbb84f-20210326
X-UUID: 72fd9a0a576544e898dcdd3f44bbb84f-20210326
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 974240742; Fri, 26 Mar 2021 15:34:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 15:34:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 15:34:21 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nina Wu <Nina-CM.Wu@mediatek.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Subject: [PATCH 2/2] soc: mediatek: Add mt8192 devapc driver
Date:   Fri, 26 Mar 2021 15:31:11 +0800
Message-ID: <1616743871-8087-2-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

The hardware architecture of mt8192 devapc is slightly
different from that of the previous IC.
We add necessary extensions to support mt8192 and be
back-compatible with other ICs.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 213 ++++++++++++++++++++++++++++----------
 1 file changed, 156 insertions(+), 57 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f1cea04..1e40a52 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -15,6 +15,11 @@
 #define VIO_MOD_TO_REG_IND(m)	((m) / 32)
 #define VIO_MOD_TO_REG_OFF(m)	((m) % 32)
 
+#define FOR_EACH_SLAVE_TYPE(ctx, idx) \
+	for ((idx) = 0; (idx) < (ctx)->slave_type_num; (idx)++)
+#define BASE(i)			(ctx->base_list[i])
+#define VIO_IDX_NUM(i)		(ctx->vio_idx_num[i])
+
 struct mtk_devapc_vio_dbgs {
 	union {
 		u32 vio_dbg0;
@@ -26,20 +31,28 @@ struct mtk_devapc_vio_dbgs {
 			u32 addr_h:4;
 			u32 resv:4;
 		} dbg0_bits;
+
+		/* Not used, reference only */
+		struct {
+			u32 dmnid:6;
+			u32 vio_w:1;
+			u32 vio_r:1;
+			u32 addr_h:4;
+			u32 resv:20;
+		} dbg0_bits_ver2;
 	};
 
 	u32 vio_dbg1;
+	u32 vio_dbg2;
 };
 
 struct mtk_devapc_data {
-	/* numbers of violation index */
-	u32 vio_idx_num;
-
 	/* reg offset */
 	u32 vio_mask_offset;
 	u32 vio_sta_offset;
 	u32 vio_dbg0_offset;
 	u32 vio_dbg1_offset;
+	u32 vio_dbg2_offset;
 	u32 apc_con_offset;
 	u32 vio_shift_sta_offset;
 	u32 vio_shift_sel_offset;
@@ -48,7 +61,10 @@ struct mtk_devapc_data {
 
 struct mtk_devapc_context {
 	struct device *dev;
-	void __iomem *infra_base;
+	u32 arch_ver;
+	u32 slave_type_num;
+	void __iomem **base_list;
+	u32 *vio_idx_num;
 	struct clk *infra_clk;
 	const struct mtk_devapc_data *data;
 };
@@ -56,39 +72,39 @@ struct mtk_devapc_context {
 static void clear_vio_status(struct mtk_devapc_context *ctx)
 {
 	void __iomem *reg;
-	int i;
+	int i, j;
 
-	reg = ctx->infra_base + ctx->data->vio_sta_offset;
+	FOR_EACH_SLAVE_TYPE(ctx, i) {
+		reg = BASE(i) + ctx->data->vio_sta_offset;
 
-	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
-		writel(GENMASK(31, 0), reg + 4 * i);
+		for (j = 0; j < VIO_MOD_TO_REG_IND(VIO_IDX_NUM(i) - 1); j++)
+			writel(GENMASK(31, 0), reg + 4 * j);
+
+		writel(GENMASK(VIO_MOD_TO_REG_OFF(VIO_IDX_NUM(i) - 1), 0),
+		       reg + 4 * j);
+	}
 
-	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0),
-	       reg + 4 * i);
 }
 
-static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
+static void mask_module_irq(void __iomem *reg, int vio_idx_num, bool mask)
 {
-	void __iomem *reg;
 	u32 val;
 	int i;
 
-	reg = ctx->infra_base + ctx->data->vio_mask_offset;
-
 	if (mask)
 		val = GENMASK(31, 0);
 	else
 		val = 0;
 
-	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
+	for (i = 0; i < VIO_MOD_TO_REG_IND(vio_idx_num - 1); i++)
 		writel(val, reg + 4 * i);
 
 	val = readl(reg + 4 * i);
 	if (mask)
-		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
+		val |= GENMASK(VIO_MOD_TO_REG_OFF(vio_idx_num - 1),
 			       0);
 	else
-		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
+		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(vio_idx_num - 1),
 				0);
 
 	writel(val, reg + 4 * i);
@@ -108,6 +124,8 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
  */
 static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
 {
+	int i;
+	void __iomem *reg_base;
 	void __iomem *pd_vio_shift_sta_reg;
 	void __iomem *pd_vio_shift_sel_reg;
 	void __iomem *pd_vio_shift_con_reg;
@@ -115,57 +133,87 @@ static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
 	int ret;
 	u32 val;
 
-	pd_vio_shift_sta_reg = ctx->infra_base +
-			       ctx->data->vio_shift_sta_offset;
-	pd_vio_shift_sel_reg = ctx->infra_base +
-			       ctx->data->vio_shift_sel_offset;
-	pd_vio_shift_con_reg = ctx->infra_base +
-			       ctx->data->vio_shift_con_offset;
+	FOR_EACH_SLAVE_TYPE(ctx, i) {
+		reg_base = BASE(i);
 
-	/* Find the minimum shift group which has violation */
-	val = readl(pd_vio_shift_sta_reg);
-	if (!val)
-		return false;
+		pd_vio_shift_sta_reg = reg_base +
+				       ctx->data->vio_shift_sta_offset;
+		pd_vio_shift_sel_reg = reg_base +
+				       ctx->data->vio_shift_sel_offset;
+		pd_vio_shift_con_reg = reg_base +
+				       ctx->data->vio_shift_con_offset;
 
-	min_shift_group = __ffs(val);
+		/* Find the minimum shift group which has violation */
+		val = readl(pd_vio_shift_sta_reg);
+		if (!val)
+			continue;
 
-	/* Assign the group to sync */
-	writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
+		min_shift_group = __ffs(val);
 
-	/* Start syncing */
-	writel(0x1, pd_vio_shift_con_reg);
+		/* Assign the group to sync */
+		writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
 
-	ret = readl_poll_timeout(pd_vio_shift_con_reg, val, val == 0x3, 0,
-				 PHY_DEVAPC_TIMEOUT);
-	if (ret) {
-		dev_err(ctx->dev, "%s: Shift violation info failed\n", __func__);
-		return false;
-	}
+		/* Start syncing */
+		writel(0x1, pd_vio_shift_con_reg);
+
+		ret = readl_poll_timeout(pd_vio_shift_con_reg, val, val == 0x3,
+					 0, PHY_DEVAPC_TIMEOUT);
+		if (ret) {
+			dev_err(ctx->dev, "%s: Shift violation info failed\n",
+				__func__);
+			return -ETIMEDOUT;
+		}
 
-	/* Stop syncing */
-	writel(0x0, pd_vio_shift_con_reg);
+		/* Stop syncing */
+		writel(0x0, pd_vio_shift_con_reg);
 
-	/* Write clear */
-	writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);
+		/* Write clear */
+		writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);
 
-	return true;
+		return i;
+	}
+
+	/* No violation found */
+	return -ENODATA;
 }
 
 /*
  * devapc_extract_vio_dbg - extract full violation information after doing
  *                          shift mechanism.
  */
-static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
+static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx,
+				   int vio_slave_type)
 {
 	struct mtk_devapc_vio_dbgs vio_dbgs;
 	void __iomem *vio_dbg0_reg;
 	void __iomem *vio_dbg1_reg;
+	void __iomem *vio_dbg2_reg;
+	u32 vio_addr, bus_id;
 
-	vio_dbg0_reg = ctx->infra_base + ctx->data->vio_dbg0_offset;
-	vio_dbg1_reg = ctx->infra_base + ctx->data->vio_dbg1_offset;
+	vio_dbg0_reg = BASE(vio_slave_type) + ctx->data->vio_dbg0_offset;
+	vio_dbg1_reg = BASE(vio_slave_type) + ctx->data->vio_dbg1_offset;
+	vio_dbg2_reg = BASE(vio_slave_type) + ctx->data->vio_dbg2_offset;
 
 	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
 	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
+	vio_dbgs.vio_dbg2 = readl(vio_dbg2_reg);
+
+	switch (ctx->arch_ver) {
+	case 1:
+		bus_id = vio_dbgs.dbg0_bits.mstid;
+		vio_addr = vio_dbgs.vio_dbg1;
+		break;
+	case 2:
+		bus_id = vio_dbgs.vio_dbg1;
+		vio_addr = vio_dbgs.vio_dbg2;
+
+		/* To align with the bit definition of arch_ver 1 */
+		vio_dbgs.vio_dbg0 = (vio_dbgs.vio_dbg0 << 16);
+		break;
+	default:
+		/* Not Supported */
+		return;
+	}
 
 	/* Print violation information */
 	if (vio_dbgs.dbg0_bits.vio_w)
@@ -174,8 +222,7 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
 		dev_info(ctx->dev, "Read Violation\n");
 
 	dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
-		 vio_dbgs.dbg0_bits.mstid, vio_dbgs.dbg0_bits.dmnid,
-		 vio_dbgs.vio_dbg1);
+		 bus_id, vio_dbgs.dbg0_bits.dmnid, vio_addr);
 }
 
 /*
@@ -186,9 +233,10 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
 static irqreturn_t devapc_violation_irq(int irq_number, void *data)
 {
 	struct mtk_devapc_context *ctx = data;
+	int vio_slave_type;
 
-	while (devapc_sync_vio_dbg(ctx))
-		devapc_extract_vio_dbg(ctx);
+	while ((vio_slave_type = devapc_sync_vio_dbg(ctx)) >= 0)
+		devapc_extract_vio_dbg(ctx, vio_slave_type);
 
 	clear_vio_status(ctx);
 
@@ -200,9 +248,15 @@ static irqreturn_t devapc_violation_irq(int irq_number, void *data)
  */
 static void start_devapc(struct mtk_devapc_context *ctx)
 {
-	writel(BIT(31), ctx->infra_base + ctx->data->apc_con_offset);
+	int i;
+	void __iomem *reg_base;
 
-	mask_module_irq(ctx, false);
+	FOR_EACH_SLAVE_TYPE(ctx, i) {
+		writel(BIT(31), BASE(i) + ctx->data->apc_con_offset);
+
+		reg_base = BASE(i) + ctx->data->vio_mask_offset;
+		mask_module_irq(reg_base, VIO_IDX_NUM(i), false);
+	}
 }
 
 /*
@@ -210,13 +264,18 @@ static void start_devapc(struct mtk_devapc_context *ctx)
  */
 static void stop_devapc(struct mtk_devapc_context *ctx)
 {
-	mask_module_irq(ctx, true);
+	int i;
+	void __iomem *reg_base;
+
+	FOR_EACH_SLAVE_TYPE(ctx, i) {
+		reg_base = BASE(i) + ctx->data->vio_mask_offset;
+		mask_module_irq(reg_base, VIO_IDX_NUM(i), true);
 
-	writel(BIT(2), ctx->infra_base + ctx->data->apc_con_offset);
+		writel(BIT(2), BASE(i) + ctx->data->apc_con_offset);
+	}
 }
 
 static const struct mtk_devapc_data devapc_mt6779 = {
-	.vio_idx_num = 511,
 	.vio_mask_offset = 0x0,
 	.vio_sta_offset = 0x400,
 	.vio_dbg0_offset = 0x900,
@@ -227,11 +286,26 @@ static const struct mtk_devapc_data devapc_mt6779 = {
 	.vio_shift_con_offset = 0xF20,
 };
 
+static const struct mtk_devapc_data devapc_mt8192 = {
+	.vio_mask_offset = 0x0,
+	.vio_sta_offset = 0x400,
+	.vio_dbg0_offset = 0x900,
+	.vio_dbg1_offset = 0x904,
+	.vio_dbg2_offset = 0x908,
+	.apc_con_offset = 0xF00,
+	.vio_shift_sta_offset = 0xF20,
+	.vio_shift_sel_offset = 0xF30,
+	.vio_shift_con_offset = 0xF10,
+};
+
 static const struct of_device_id mtk_devapc_dt_match[] = {
 	{
 		.compatible = "mediatek,mt6779-devapc",
 		.data = &devapc_mt6779,
 	}, {
+		.compatible = "mediatek,mt8192-devapc",
+		.data = &devapc_mt8192,
+	}, {
 	},
 };
 
@@ -239,6 +313,7 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct mtk_devapc_context *ctx;
+	int i;
 	u32 devapc_irq;
 	int ret;
 
@@ -252,8 +327,32 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 	ctx->data = of_device_get_match_data(&pdev->dev);
 	ctx->dev = &pdev->dev;
 
-	ctx->infra_base = of_iomap(node, 0);
-	if (!ctx->infra_base)
+	if (of_property_read_u32(node, "version", &ctx->arch_ver))
+		return -EINVAL;
+
+	if (of_property_read_u32(node, "slave_type_num", &ctx->slave_type_num))
+		return -EINVAL;
+
+	ctx->base_list = devm_kzalloc(&pdev->dev,
+				      sizeof(void *) * ctx->slave_type_num,
+				      GFP_KERNEL);
+	if (!ctx->base_list)
+		return -ENOMEM;
+
+	FOR_EACH_SLAVE_TYPE(ctx, i) {
+		BASE(i) = of_iomap(node, i);
+		if (!BASE(i))
+			return -EINVAL;
+	}
+
+	ctx->vio_idx_num = devm_kzalloc(&pdev->dev,
+					sizeof(u32) * ctx->slave_type_num,
+					GFP_KERNEL);
+	if (!ctx->vio_idx_num)
+		return -ENOMEM;
+
+	if (of_property_read_u32_array(node, "vio_idx_num",
+				       ctx->vio_idx_num, ctx->slave_type_num))
 		return -EINVAL;
 
 	devapc_irq = irq_of_parse_and_map(node, 0);
-- 
2.6.4

