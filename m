Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A799C35979A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhDIIU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:20:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231611AbhDIIU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:20:58 -0400
X-UUID: 5899287af987436a9503bb03280da807-20210409
X-UUID: 5899287af987436a9503bb03280da807-20210409
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 410803061; Fri, 09 Apr 2021 16:20:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 16:20:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 16:20:40 +0800
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
Subject: [PATCH v3 2/7] soc: mediatek: devapc: get 'vio_idx_num' info from DT
Date:   Fri, 9 Apr 2021 16:19:32 +0800
Message-ID: <1617956377-4075-2-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1617956377-4075-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1617956377-4075-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B5C52ED3F213A169401BCC329992EA7DF7EE60B81DBE64B968EE3C50EF3ADD072000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

For new ICs, there are multiple devapc HWs for different subsys.
The number of devices controlled by each devapc (i.e. 'vio_idx_num')
will be set in DT for per devapc node.
On the other hand, for old ICs which have only one devapc HW, the
'vio_idx_num' info is set in compatible data.
To be backward compatible, the 'vio_idx_num' in compatible data is set
as the default value. Only when the default value is 0 will we get the
'vio_idx_num' from DT.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f1cea04..71643d1 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -32,7 +32,7 @@ struct mtk_devapc_vio_dbgs {
 };
 
 struct mtk_devapc_data {
-	/* numbers of violation index */
+	/* default numbers of violation index */
 	u32 vio_idx_num;
 
 	/* reg offset */
@@ -51,6 +51,9 @@ struct mtk_devapc_context {
 	void __iomem *infra_base;
 	struct clk *infra_clk;
 	const struct mtk_devapc_data *data;
+
+	/* numbers of violation index */
+	u32 vio_idx_num;
 };
 
 static void clear_vio_status(struct mtk_devapc_context *ctx)
@@ -60,10 +63,10 @@ static void clear_vio_status(struct mtk_devapc_context *ctx)
 
 	reg = ctx->infra_base + ctx->data->vio_sta_offset;
 
-	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
+	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num) - 1; i++)
 		writel(GENMASK(31, 0), reg + 4 * i);
 
-	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0),
+	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num) - 1, 0),
 	       reg + 4 * i);
 }
 
@@ -80,15 +83,15 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
 	else
 		val = 0;
 
-	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
+	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num) - 1; i++)
 		writel(val, reg + 4 * i);
 
 	val = readl(reg + 4 * i);
 	if (mask)
-		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
+		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num) - 1,
 			       0);
 	else
-		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
+		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num) - 1,
 				0);
 
 	writel(val, reg + 4 * i);
@@ -256,6 +259,16 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 	if (!ctx->infra_base)
 		return -EINVAL;
 
+	/* Set vio_idx_num to default value.
+	 * If the value is 0, get the info from DT.
+	 */
+	ctx->vio_idx_num = ctx->data->vio_idx_num;
+	if (!ctx->vio_idx_num)
+		if (of_property_read_u32(node,
+					 "vio-idx-num",
+					 &ctx->vio_idx_num))
+			return -EINVAL;
+
 	devapc_irq = irq_of_parse_and_map(node, 0);
 	if (!devapc_irq)
 		return -EINVAL;
-- 
2.6.4

