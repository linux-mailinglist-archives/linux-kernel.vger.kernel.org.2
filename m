Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04994350F36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhDAGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:40:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49028 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233167AbhDAGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:40:21 -0400
X-UUID: d1d4a8549a6a4747b03ac9ac3aab082b-20210401
X-UUID: d1d4a8549a6a4747b03ac9ac3aab082b-20210401
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1837515410; Thu, 01 Apr 2021 14:40:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Apr 2021 14:40:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Apr 2021 14:40:16 +0800
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
Subject: [PATCH v2 5/6] soc: mediatek: devapc: add debug register for new IC support
Date:   Thu, 1 Apr 2021 14:38:06 +0800
Message-ID: <1617259087-5502-5-git-send-email-nina-cm.wu@mediatek.com>
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

There are 3 debug info registers in new ICs while in legacy ones,
we have only 2. When dumping the debug info, we need to check first
if the 3rd debug register exists and then we can konw how to decipher
the debug info.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index bcf6e3c..af55c01 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -26,9 +26,19 @@ struct mtk_devapc_vio_dbgs {
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
@@ -37,6 +47,7 @@ struct mtk_devapc_data {
 	u32 vio_sta_offset;
 	u32 vio_dbg0_offset;
 	u32 vio_dbg1_offset;
+	u32 vio_dbg2_offset;
 	u32 apc_con_offset;
 	u32 vio_shift_sta_offset;
 	u32 vio_shift_sel_offset;
@@ -158,12 +169,29 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
 	struct mtk_devapc_vio_dbgs vio_dbgs;
 	void __iomem *vio_dbg0_reg;
 	void __iomem *vio_dbg1_reg;
+	void __iomem *vio_dbg2_reg;
+	u32 vio_addr, bus_id;
 
 	vio_dbg0_reg = ctx->base + ctx->data->vio_dbg0_offset;
 	vio_dbg1_reg = ctx->base + ctx->data->vio_dbg1_offset;
+	vio_dbg2_reg = ctx->base + ctx->data->vio_dbg2_offset;
 
 	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
 	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
+	vio_dbgs.vio_dbg2 = readl(vio_dbg2_reg);
+
+	if (!ctx->data->vio_dbg2_offset) {
+		/* arch version 1 */
+		bus_id = vio_dbgs.dbg0_bits.mstid;
+		vio_addr = vio_dbgs.vio_dbg1;
+	} else {
+		/* arch version 2 */
+		bus_id = vio_dbgs.vio_dbg1;
+		vio_addr = vio_dbgs.vio_dbg2;
+
+		/* To align with the bit definition of arch_ver 1 */
+		vio_dbgs.vio_dbg0 = (vio_dbgs.vio_dbg0 << 16);
+	}
 
 	/* Print violation information */
 	if (vio_dbgs.dbg0_bits.vio_w)
@@ -172,8 +200,7 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
 		dev_info(ctx->dev, "Read Violation\n");
 
 	dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
-		 vio_dbgs.dbg0_bits.mstid, vio_dbgs.dbg0_bits.dmnid,
-		 vio_dbgs.vio_dbg1);
+		 bus_id, vio_dbgs.dbg0_bits.dmnid, vio_addr);
 }
 
 /*
-- 
2.6.4

