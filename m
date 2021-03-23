Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE034579B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCWF6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:58:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59937 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229904AbhCWF6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:58:10 -0400
X-UUID: 130c39ac86e84e91b16636f38ebe63a4-20210323
X-UUID: 130c39ac86e84e91b16636f38ebe63a4-20210323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 375069684; Tue, 23 Mar 2021 13:58:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 13:58:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 13:58:06 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH 1/2] iommu/mediatek-v1: Alloc building as module
Date:   Tue, 23 Mar 2021 13:58:00 +0800
Message-ID: <20210323055801.16885-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only adds support for building the IOMMU-v1 driver as module.
Correspondingly switch the config to tristate.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
rebase on v5.12-rc2.
---
 drivers/iommu/Kconfig        | 2 +-
 drivers/iommu/mtk_iommu_v1.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f61310..bc93da48bed0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -364,7 +364,7 @@ config MTK_IOMMU
 	  If unsure, say N here.
 
 config MTK_IOMMU_V1
-	bool "MTK IOMMU Version 1 (M4U gen1) Support"
+	tristate "MediaTek IOMMU Version 1 (M4U gen1) Support"
 	depends on ARM
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 82ddfe9170d4..71370037083a 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -20,6 +20,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
@@ -691,9 +692,7 @@ static struct platform_driver mtk_iommu_driver = {
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
+module_platform_driver(mtk_iommu_driver);
 
-static int __init m4u_init(void)
-{
-	return platform_driver_register(&mtk_iommu_driver);
-}
-subsys_initcall(m4u_init);
+MODULE_DESCRIPTION("IOMMU API for MediaTek M4U v1 implementations");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

