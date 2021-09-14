Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9C40AC99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhINLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:40:35 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35202 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232394AbhINLkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:40:32 -0400
X-UUID: dff0bf0e660146f39427f6a8ed304ea9-20210914
X-UUID: dff0bf0e660146f39427f6a8ed304ea9-20210914
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1627914494; Tue, 14 Sep 2021 19:39:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:39:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:39:08 +0800
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
Subject: [PATCH v4 11/13] memory: mtk-smi: mt8195: Add initial setting for smi-common
Date:   Tue, 14 Sep 2021 19:37:01 +0800
Message-ID: <20210914113703.31466-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the performance, add initial setting for smi-common.
some register use some fix setting(suggested from DE).

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 42 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 35853ba980c9..689a45b39a65 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -18,11 +18,19 @@
 #include <dt-bindings/memory/mtk-memory-port.h>
 
 /* SMI COMMON */
+#define SMI_L1LEN			0x100
+
 #define SMI_BUS_SEL			0x220
 #define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
 /* All are MMU0 defaultly. Only specialize mmu1 here. */
 #define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
+#define SMI_M4U_TH			0x234
+#define SMI_FIFO_TH1			0x238
+#define SMI_FIFO_TH2			0x23c
+#define SMI_DCM				0x300
+#define SMI_DUMMY			0x444
+
 /* SMI LARB */
 
 /* Below are about mmu enable registers, they are different in SoCs */
@@ -59,6 +67,13 @@
 	(_id << 8 | _id << 10 | _id << 12 | _id << 14);	\
 })
 
+#define SMI_COMMON_INIT_REGS_NR		6
+
+struct mtk_smi_reg_pair {
+	unsigned int		offset;
+	u32			value;
+};
+
 enum mtk_smi_type {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2,		/* gen2 smi common */
@@ -85,6 +100,8 @@ struct mtk_smi_common_plat {
 	enum mtk_smi_type	type;
 	bool			has_gals;
 	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
+
+	const struct mtk_smi_reg_pair	*init;
 };
 
 struct mtk_smi_larb_gen {
@@ -419,6 +436,15 @@ static struct platform_driver mtk_smi_larb_driver = {
 	}
 };
 
+static const struct mtk_smi_reg_pair mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
+	{SMI_L1LEN, 0xb},
+	{SMI_M4U_TH, 0xe100e10},
+	{SMI_FIFO_TH1, 0x506090a},
+	{SMI_FIFO_TH2, 0x506090a},
+	{SMI_DCM, 0x4f1},
+	{SMI_DUMMY, 0x1},
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
 	.type     = MTK_SMI_GEN1,
 };
@@ -453,12 +479,14 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vdo = {
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(7),
+	.init     = mtk_smi_common_mt8195_init,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vpp = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(7),
+	.init     = mtk_smi_common_mt8195_init,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
@@ -551,15 +579,21 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
-	u32 bus_sel = common->plat->bus_sel;
-	int ret;
+	const struct mtk_smi_reg_pair *init = common->plat->init;
+	u32 bus_sel = common->plat->bus_sel; /* default is 0 */
+	int ret, i;
 
 	ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
 	if (ret)
 		return ret;
 
-	if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
-		writel(bus_sel, common->base + SMI_BUS_SEL);
+	if (common->plat->type != MTK_SMI_GEN2)
+		return 0;
+
+	for (i = 0; i < SMI_COMMON_INIT_REGS_NR && init && init[i].offset; i++)
+		writel_relaxed(init[i].value, common->base + init[i].offset);
+
+	writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
 
-- 
2.18.0

