Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2793EB0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhHMGz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:55:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60726 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239089AbhHMGzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:55:53 -0400
X-UUID: 92c4d768209f4c60b415758281627d23-20210813
X-UUID: 92c4d768209f4c60b415758281627d23-20210813
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1298665535; Fri, 13 Aug 2021 14:55:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:55:24 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:55:23 +0800
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
Subject: [PATCH v2 13/29] iommu/mediatek: Add SUB_COMMON_3BITS flag
Date:   Fri, 13 Aug 2021 14:53:08 +0800
Message-ID: <20210813065324.29220-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prevous SoC, the sub common id occupy 2 bits. the mt8195's sub common
id has 3bits. Add a new flag for this. and rename the prevous flag to
_2BITS. For readable, I put these two flags together, then move the
other flags. no functional change.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++----------
 drivers/iommu/mtk_iommu.h |  2 +-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a831e56a90eb..f75fbfd951e0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -106,6 +106,8 @@
 #define REG_MMU1_INT_ID				0x154
 #define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
+#define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
+#define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
@@ -117,13 +119,14 @@
 #define HAS_VLD_PA_RNG			BIT(2)
 #define RESET_AXI			BIT(3)
 #define OUT_ORDER_WR_EN			BIT(4)
-#define HAS_SUB_COMM			BIT(5)
-#define WR_THROT_EN			BIT(6)
-#define HAS_LEGACY_IVRP_PADDR		BIT(7)
-#define IOVA_34_EN			BIT(8)
-#define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
-#define DCM_DISABLE			BIT(10)
-#define NOT_STD_AXI_MODE		BIT(11)
+#define HAS_SUB_COMM_2BITS		BIT(5)
+#define HAS_SUB_COMM_3BITS		BIT(6)
+#define WR_THROT_EN			BIT(7)
+#define HAS_LEGACY_IVRP_PADDR		BIT(8)
+#define IOVA_34_EN			BIT(9)
+#define SHARE_PGTABLE			BIT(10) /* 2 HW share pgtable */
+#define DCM_DISABLE			BIT(11)
+#define NOT_STD_AXI_MODE		BIT(12)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -304,9 +307,12 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_pa |= (u64)pa34_32 << 32;
 
 	fault_port = F_MMU_INT_ID_PORT_ID(regval);
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
 		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+	} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
+		fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
+		sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
 	} else {
 		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
 	}
@@ -1035,7 +1041,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
-	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN |
+	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
 			 NOT_STD_AXI_MODE,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
 	.iova_region   = single_domain,
@@ -1073,7 +1079,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
-	.flags          = HAS_BCLK | HAS_SUB_COMM | OUT_ORDER_WR_EN |
+	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
 			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
 	.iova_region    = mt8192_multi_dom,
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 027a42396557..5b32277fee99 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -20,7 +20,7 @@
 #include <dt-bindings/memory/mtk-memory-port.h>
 
 #define MTK_LARB_COM_MAX	8
-#define MTK_LARB_SUBCOM_MAX	4
+#define MTK_LARB_SUBCOM_MAX	8
 
 #define MTK_IOMMU_GROUP_MAX	8
 
-- 
2.18.0

