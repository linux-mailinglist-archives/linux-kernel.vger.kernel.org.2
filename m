Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F63E54DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhHJILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:11:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39034 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237941AbhHJIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:10:16 -0400
X-UUID: 11fea1a6ad5e44dea7fb36c7ee42b9c9-20210810
X-UUID: 11fea1a6ad5e44dea7fb36c7ee42b9c9-20210810
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1792854006; Tue, 10 Aug 2021 16:09:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:09:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:09:50 +0800
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
Subject: [PATCH v3 04/13] memory: mtk-smi: Rename smi_gen to smi_type
Date:   Tue, 10 Aug 2021 16:08:50 +0800
Message-ID: <20210810080859.29511-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for adding smi sub common. Only rename from smi_gen to smi_type.
No functional change.

About the current "smi_gen", we have gen1/gen2 that stand for the
generation number for HW. I plan to add a new type(sub_common), then the
name "gen" is not proper.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/memory/mtk-smi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index f91eaf5c3ab0..02a584dfb9b1 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -55,7 +55,7 @@
 /* All are MMU0 defaultly. Only specialize mmu1 here. */
 #define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
-enum mtk_smi_gen {
+enum mtk_smi_type {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
 };
@@ -75,9 +75,9 @@ static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1
 #define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
 
 struct mtk_smi_common_plat {
-	enum mtk_smi_gen gen;
-	bool             has_gals;
-	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
+	enum mtk_smi_type	type;
+	bool			has_gals;
+	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -409,29 +409,29 @@ static struct platform_driver mtk_smi_larb_driver = {
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
-	.gen = MTK_SMI_GEN1,
+	.type     = MTK_SMI_GEN1,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
-	.gen = MTK_SMI_GEN2,
+	.type	  = MTK_SMI_GEN2,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
-	.gen		= MTK_SMI_GEN2,
-	.has_gals	= true,
-	.bus_sel	= F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
-			  F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
+	.type	  = MTK_SMI_GEN2,
+	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
+		    F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
-	.gen      = MTK_SMI_GEN2,
+	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
-	.gen      = MTK_SMI_GEN2,
+	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(6),
@@ -494,7 +494,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	if (common->plat->gen == MTK_SMI_GEN1) {
+	if (common->plat->type == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(common->smi_ao_base))
@@ -534,7 +534,7 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
+	if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
 		writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
-- 
2.18.0

