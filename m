Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3A415D92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbhIWMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:03:38 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240847AbhIWMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:03:32 -0400
X-UUID: 83d4b37d4b0e46f78f745f080b91e9b5-20210923
X-UUID: 83d4b37d4b0e46f78f745f080b91e9b5-20210923
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1506941841; Thu, 23 Sep 2021 20:01:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:01:57 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:01:56 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <yen-chang.chen@mediatek.com>
Subject: [PATCH v3 18/33] iommu/mediatek: Adjust device link when it is sub-common
Date:   Thu, 23 Sep 2021 19:58:25 +0800
Message-ID: <20210923115840.17813-19-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MM IOMMU, We always add device link between smi-common and IOMMU HW.
In mt8195, we add smi-sub-common. Thus, if the node is sub-common, we still
need find again to get smi-common, then do device link.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ebbb3412cb9..faea4a0d922f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -786,9 +786,9 @@ static int mtk_iommu_mm_dts_parse(struct device *dev,
 				  struct component_match **match,
 				  struct mtk_iommu_data *data)
 {
+	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
 	struct platform_device	*plarbdev;
 	struct device_link	*link;
-	struct device_node *larbnode, *smicomm_node;
 	int i, larb_nr, ret;
 
 	larb_nr = of_count_phandle_with_args(dev->of_node, "mediatek,larbs", NULL);
@@ -822,11 +822,21 @@ static int mtk_iommu_mm_dts_parse(struct device *dev,
 					    compare_of, larbnode);
 	}
 
-	/* Get smi-common dev from the last larb. */
-	smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smicomm_node)
+	/* Get smi-(sub)-common dev from the last larb. */
+	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+	if (!smi_subcomm_node)
 		return -EINVAL;
 
+	/*
+	 * It may have two level smi-common. the node is smi-sub-common if it
+	 * has a new mediatek,smi property. otherwise it is smi-commmon.
+	 */
+	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
+	if (smicomm_node)
+		of_node_put(smi_subcomm_node);
+	else
+		smicomm_node = smi_subcomm_node;
+
 	plarbdev = of_find_device_by_node(smicomm_node);
 	of_node_put(smicomm_node);
 	data->smicomm_dev = &plarbdev->dev;
-- 
2.18.0

