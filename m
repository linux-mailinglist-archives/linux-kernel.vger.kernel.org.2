Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E34350F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhDAGjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:39:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41615 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233102AbhDAGjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:39:32 -0400
X-UUID: 62d6e9a0872d42658b94ccc97ae5c1f2-20210401
X-UUID: 62d6e9a0872d42658b94ccc97ae5c1f2-20210401
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 889749307; Thu, 01 Apr 2021 14:39:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Apr 2021 14:39:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Apr 2021 14:39:27 +0800
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
Subject: [PATCH v2 2/6] soc: mediatek: devapc: move 'vio_idx_num' info to DT
Date:   Thu, 1 Apr 2021 14:38:03 +0800
Message-ID: <1617259087-5502-2-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

For new ICs, there are multiple devapc HWs for different subsys.
The number of devices controlled by each devapc (i.e. 'vio_idx_num'
in the code) varies.
We move this info from compatible data to DT so that we do not need
to add n compatible for a certain IC which has n devapc HWs with
different 'vio_idx_num', respectively.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f1cea04..a0f6fbd 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -32,9 +32,6 @@ struct mtk_devapc_vio_dbgs {
 };
 
 struct mtk_devapc_data {
-	/* numbers of violation index */
-	u32 vio_idx_num;
-
 	/* reg offset */
 	u32 vio_mask_offset;
 	u32 vio_sta_offset;
@@ -49,6 +46,7 @@ struct mtk_devapc_data {
 struct mtk_devapc_context {
 	struct device *dev;
 	void __iomem *infra_base;
+	u32 vio_idx_num;
 	struct clk *infra_clk;
 	const struct mtk_devapc_data *data;
 };
@@ -60,10 +58,10 @@ static void clear_vio_status(struct mtk_devapc_context *ctx)
 
 	reg = ctx->infra_base + ctx->data->vio_sta_offset;
 
-	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
+	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num - 1); i++)
 		writel(GENMASK(31, 0), reg + 4 * i);
 
-	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0),
+	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num - 1), 0),
 	       reg + 4 * i);
 }
 
@@ -80,15 +78,15 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
 	else
 		val = 0;
 
-	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
+	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num - 1); i++)
 		writel(val, reg + 4 * i);
 
 	val = readl(reg + 4 * i);
 	if (mask)
-		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
+		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num - 1),
 			       0);
 	else
-		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
+		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num - 1),
 				0);
 
 	writel(val, reg + 4 * i);
@@ -216,7 +214,6 @@ static void stop_devapc(struct mtk_devapc_context *ctx)
 }
 
 static const struct mtk_devapc_data devapc_mt6779 = {
-	.vio_idx_num = 511,
 	.vio_mask_offset = 0x0,
 	.vio_sta_offset = 0x400,
 	.vio_dbg0_offset = 0x900,
@@ -256,6 +253,9 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 	if (!ctx->infra_base)
 		return -EINVAL;
 
+	if (of_property_read_u32(node, "vio_idx_num", &ctx->vio_idx_num))
+		return -EINVAL;
+
 	devapc_irq = irq_of_parse_and_map(node, 0);
 	if (!devapc_irq)
 		return -EINVAL;
-- 
2.6.4

