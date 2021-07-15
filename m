Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3283C9E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhGOMQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:16:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39790 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233131AbhGOMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:15:58 -0400
X-UUID: d3fa8daf89e34009809db14d58e88d0c-20210715
X-UUID: d3fa8daf89e34009809db14d58e88d0c-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1541169425; Thu, 15 Jul 2021 20:13:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:13:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:13:00 +0800
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
Subject: [PATCH v2 04/11] memory: mtk-smi: Rename smi_gen to smi_type
Date:   Thu, 15 Jul 2021 20:12:02 +0800
Message-ID: <20210715121209.31024-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210715121209.31024-1-yong.wu@mediatek.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
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
name "gen" is not prober.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index a2213452059d..ff07b14bcd66 100644
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
@@ -68,8 +68,8 @@ static const char * const mtk_smi_common_clks_optional[] = {"gals0", "gals1"};
 static const char * const mtk_smi_larb_clks_optional[] = {"gals"};
 
 struct mtk_smi_common_plat {
-	enum mtk_smi_gen gen;
-	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
+	enum mtk_smi_type	type;
+	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -402,27 +402,27 @@ static struct platform_driver mtk_smi_larb_driver = {
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
-	.bus_sel	= F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
-			  F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
+	.type	  = MTK_SMI_GEN2,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
+		    F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
-	.gen      = MTK_SMI_GEN2,
+	.type     = MTK_SMI_GEN2,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
-	.gen      = MTK_SMI_GEN2,
+	.type     = MTK_SMI_GEN2,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(6),
 };
@@ -483,7 +483,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	if (common->plat->gen == MTK_SMI_GEN1) {
+	if (common->plat->type == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(common->smi_ao_base))
@@ -523,7 +523,7 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
+	if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
 		writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
-- 
2.18.0

