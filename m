Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA63C35AC28
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhDJJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:12:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33533 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229591AbhDJJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:12:30 -0400
X-UUID: 36954cfc71454c1993b8acfecc617f9f-20210410
X-UUID: 36954cfc71454c1993b8acfecc617f9f-20210410
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1650693383; Sat, 10 Apr 2021 17:12:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Apr 2021 17:12:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 17:12:04 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v5 02/16] iommu/mediatek: Add probe_defer for smi-larb
Date:   Sat, 10 Apr 2021 17:11:14 +0800
Message-ID: <20210410091128.31823-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210410091128.31823-1-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu consumer should use device_link to connect with the
smi-larb(supplier). then the smi-larb should run before the iommu
consumer. Here we delay the iommu driver until the smi driver is
ready, then all the iommu consumer always is after the smi driver.

When there is no this patch, if some consumer drivers run before
smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
device_link_add, then device_links_driver_bound will use WARN_ON
to complain that the link_status of supplier is not right.

This is a preparing patch for adding device_link.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
To Matthias,

In v2, You suggested use device_is_bound here. But from [1], this
interface is not allowed to be EXPORT. It will affect this driver
built as module. thus I still use dev.driver to check here.

[1] https://lore.kernel.org/patchwork/patch/1334670/
---
 drivers/iommu/mtk_iommu.c    | 2 +-
 drivers/iommu/mtk_iommu_v1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6ecc007f07cd..7a7b8260d308 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -862,7 +862,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			id = i;
 
 		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev) {
+		if (!plarbdev || !plarbdev->dev.driver) {
 			of_node_put(larbnode);
 			return -EPROBE_DEFER;
 		}
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 82ddfe9170d4..a82466e4046e 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -597,7 +597,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			plarbdev = of_platform_device_create(
 						larb_spec.np, NULL,
 						platform_bus_type.dev_root);
-			if (!plarbdev) {
+			if (!plarbdev || !plarbdev->dev.driver) {
 				of_node_put(larb_spec.np);
 				return -EPROBE_DEFER;
 			}
-- 
2.18.0

