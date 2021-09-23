Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF82415D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhIWMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:01:01 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:48374 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240743AbhIWMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:00:57 -0400
X-UUID: fc9c943ab4914ebbb2966de184455dad-20210923
X-UUID: fc9c943ab4914ebbb2966de184455dad-20210923
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1970080684; Thu, 23 Sep 2021 19:59:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 19:59:22 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 19:59:21 +0800
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
Subject: [PATCH v3 03/33] iommu/mediatek: Fix 2 HW sharing pgtable issue
Date:   Thu, 23 Sep 2021 19:58:10 +0800
Message-ID: <20210923115840.17813-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 4f956c97d26b ("iommu/mediatek: Move domain_finalise into
attach_device"), I overlooked the sharing pgtable case.
After that commit, the "data" in the mtk_iommu_domain_finalise always is
the data of the current IOMMU HW. Fix this for the sharing pgtable case.

Only affect mt2712 which is the only SoC that share pgtable currently.

Fixes: 4f956c97d26b ("iommu/mediatek: Move domain_finalise into attach_device")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d837adfd1da5..3e8f0164d26c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -451,7 +451,7 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct device *m4udev = data->dev;
 	int ret, domid;
@@ -461,7 +461,10 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		return domid;
 
 	if (!dom->data) {
-		if (mtk_iommu_domain_finalise(dom, data, domid))
+		/* Data is in the frstdata in sharing pgtable case. */
+		frstdata = mtk_iommu_get_m4u_data();
+
+		if (mtk_iommu_domain_finalise(dom, frstdata, domid))
 			return -ENODEV;
 		dom->data = data;
 	}
-- 
2.18.0

