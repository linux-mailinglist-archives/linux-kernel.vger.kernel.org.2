Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEE3B7BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhF3Ck7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:40:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35726 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233726AbhF3Ckx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:40:53 -0400
X-UUID: f0f88b3d43f147ecb528a99cf183e4b4-20210630
X-UUID: f0f88b3d43f147ecb528a99cf183e4b4-20210630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1704327587; Wed, 30 Jun 2021 10:38:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:38:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:38:19 +0800
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
Subject: [PATCH 24/24] iommu/mediatek: mt8195: Enable multi-bank for infra iommu
Date:   Wed, 30 Jun 2021 10:35:04 +0800
Message-ID: <20210630023504.18177-25-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the multi-bank functions for infra-iommu. We put PCIE in bank0
and USB in the last bank(bank4). and we don't use the other banks
currently, disable them.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3aaf425d5a18..435bb0fdd73f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1260,8 +1260,11 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 	.flags            = WR_THROT_EN | DCM_DISABLE |
 			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIe_SUPPORT,
 	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
-	.bank_nr	  = 1,
-	.bank_enable      = {true},
+	.bank_nr	  = 5,
+	.bank_enable      = {true, false, false, false, true},
+	.bank_portmsk     = {[0] = GENMASK(19, 16),     /* PCIe */
+			     [4] = GENMASK(31, 20),     /* USB */
+			    },
 	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
 	.iova_region      = single_domain,
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
-- 
2.18.0

