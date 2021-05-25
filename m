Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2055938FA60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhEYFz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:55:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55592 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231236AbhEYFzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:55:25 -0400
X-UUID: 8bf493a8c2ce45c6b9fa369e5a711627-20210525
X-UUID: 8bf493a8c2ce45c6b9fa369e5a711627-20210525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 370248539; Tue, 25 May 2021 13:53:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 13:53:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 13:53:51 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nina Wu <Nina-CM.Wu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 5/7] soc: mediatek: devapc: add debug register for new IC support
Date:   Tue, 25 May 2021 13:53:04 +0800
Message-ID: <1621921986-20578-5-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

There are 3 debug info registers in new ICs while in legacy ones,
we have only 2. We add a 'version' field in compatible data to
decide how we extract the debug info.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 43 +++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f5d63c5..bdc8fe9 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -26,12 +26,24 @@ struct mtk_devapc_vio_dbgs {
 			u32 addr_h:4;
 			u32 resv:4;
 		} dbg0_bits;
+
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
+	/* architecture version */
+	u32 version;
+
 	/* default numbers of violation index */
 	u32 vio_idx_num;
 
@@ -40,6 +52,7 @@ struct mtk_devapc_data {
 	u32 vio_sta_offset;
 	u32 vio_dbg0_offset;
 	u32 vio_dbg1_offset;
+	u32 vio_dbg2_offset;
 	u32 apc_con_offset;
 	u32 vio_shift_sta_offset;
 	u32 vio_shift_sel_offset;
@@ -163,22 +176,43 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
 	struct mtk_devapc_vio_dbgs vio_dbgs;
 	void __iomem *vio_dbg0_reg;
 	void __iomem *vio_dbg1_reg;
+	void __iomem *vio_dbg2_reg;
+	u32 vio_addr, bus_id, domain_id;
+	u32 vio_w, vio_r;
 
 	vio_dbg0_reg = ctx->base + ctx->data->vio_dbg0_offset;
 	vio_dbg1_reg = ctx->base + ctx->data->vio_dbg1_offset;
+	vio_dbg2_reg = ctx->base + ctx->data->vio_dbg2_offset;
 
 	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
 	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
+	if (ctx->data->version == 2U)
+		vio_dbgs.vio_dbg2 = readl(vio_dbg2_reg);
+
+	if (ctx->data->version == 1U) {
+		/* arch version 1 */
+		bus_id = vio_dbgs.dbg0_bits.mstid;
+		vio_addr = vio_dbgs.vio_dbg1;
+		domain_id = vio_dbgs.dbg0_bits.dmnid;
+		vio_w = vio_dbgs.dbg0_bits.vio_w;
+		vio_r = vio_dbgs.dbg0_bits.vio_r;
+	} else {
+		/* arch version 2 */
+		bus_id = vio_dbgs.vio_dbg1;
+		vio_addr = vio_dbgs.vio_dbg2;
+		domain_id = vio_dbgs.dbg0_bits_ver2.dmnid;
+		vio_w = vio_dbgs.dbg0_bits_ver2.vio_w;
+		vio_r = vio_dbgs.dbg0_bits_ver2.vio_r;
+	}
 
 	/* Print violation information */
-	if (vio_dbgs.dbg0_bits.vio_w)
+	if (vio_w)
 		dev_info(ctx->dev, "Write Violation\n");
-	else if (vio_dbgs.dbg0_bits.vio_r)
+	else if (vio_r)
 		dev_info(ctx->dev, "Read Violation\n");
 
 	dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
-		 vio_dbgs.dbg0_bits.mstid, vio_dbgs.dbg0_bits.dmnid,
-		 vio_dbgs.vio_dbg1);
+		 bus_id, domain_id, vio_addr);
 }
 
 /*
@@ -219,6 +253,7 @@ static void stop_devapc(struct mtk_devapc_context *ctx)
 }
 
 static const struct mtk_devapc_data devapc_mt6779 = {
+	.version = 1,
 	.vio_idx_num = 511,
 	.vio_mask_offset = 0x0,
 	.vio_sta_offset = 0x400,
-- 
2.6.4

