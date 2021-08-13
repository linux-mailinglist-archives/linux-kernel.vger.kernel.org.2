Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5163EB0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhHMG4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:56:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38062 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239118AbhHMG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:56:14 -0400
X-UUID: 4bb8f6a2d7584e2e8c1406bb51c0d472-20210813
X-UUID: 4bb8f6a2d7584e2e8c1406bb51c0d472-20210813
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1442998272; Fri, 13 Aug 2021 14:55:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:55:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:55:42 +0800
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
Subject: [PATCH v2 16/29] iommu/mediatek: Adjust device link when it is sub-common
Date:   Fri, 13 Aug 2021 14:53:11 +0800
Message-ID: <20210813065324.29220-17-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
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
 drivers/iommu/mtk_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a4479916ad33..a72241724adb 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -845,6 +845,17 @@ static int mtk_iommu_mm_dts_parse(struct device *dev,
 	if (!smicomm_node)
 		return -EINVAL;
 
+	/* Find smi-common again if this is smi-sub-common */
+	if (of_property_read_bool(smicomm_node, "mediatek,smi_sub_common")) {
+		of_node_put(smicomm_node); /* put the sub common */
+
+		smicomm_node = of_parse_phandle(smicomm_node, "mediatek,smi", 0);
+		if (!smicomm_node) {
+			dev_err(dev, "sub-comm has no common.\n");
+			return -EINVAL;
+		}
+	}
+
 	plarbdev = of_find_device_by_node(smicomm_node);
 	of_node_put(smicomm_node);
 	data->smicomm_dev = &plarbdev->dev;
-- 
2.18.0

