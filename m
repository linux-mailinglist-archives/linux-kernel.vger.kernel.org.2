Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384033EB0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbhHMG4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:56:43 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38768 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238869AbhHMG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:56:41 -0400
X-UUID: 1691ceafd79f4bf59a68f1d66e8be64c-20210813
X-UUID: 1691ceafd79f4bf59a68f1d66e8be64c-20210813
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 656944775; Fri, 13 Aug 2021 14:56:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:56:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:56:07 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v2 19/29] iommu/mediatek: Add mt8195 support
Date:   Fri, 13 Aug 2021 14:53:14 +0800
Message-ID: <20210813065324.29220-20-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8195 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
is for vpp. and 1 INFRA IOMMU.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 42 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b7a31f3a1bcf..d7eec20f0476 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1168,6 +1168,45 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 			   {0, 14, 16}, {0, 13, 18, 17}},
 };
 
+static const struct mtk_iommu_plat_data mt8195_data_infra = {
+	.m4u_plat	  = M4U_MT8195,
+	.flags            = WR_THROT_EN | DCM_DISABLE |
+			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIe_SUPPORT,
+	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
+	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
+	.iova_region      = single_domain,
+	.iova_region_nr   = ARRAY_SIZE(single_domain),
+};
+
+static const struct mtk_iommu_plat_data mt8195_data_vdo = {
+	.m4u_plat	= M4U_MT8195,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | NOT_STD_AXI_MODE | IOVA_34_EN |
+			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
+			   {13, 17, 15/* 17b */, 25}, {5}},
+};
+
+static const struct mtk_iommu_plat_data mt8195_data_vpp = {
+	.m4u_plat	= M4U_MT8195,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | NOT_STD_AXI_MODE | IOVA_34_EN |
+			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{1}, {3}, {22, 0, 0, 0, 23}, {8},
+			   {20}, {12},
+			   /* 16: 16a; 29: 16b; 30: CCUtop0; 31: CCUtop1 */
+			   {14, 16, 29, 26, 30, 31, 18},
+			   {4, 0, 0, 0, 6}},
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1175,6 +1214,9 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
+	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
+	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
+	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 676d306af046..e7ede1123624 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -46,6 +46,7 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 	M4U_MT8183,
 	M4U_MT8192,
+	M4U_MT8195,
 };
 
 struct mtk_iommu_iova_region;
-- 
2.18.0

