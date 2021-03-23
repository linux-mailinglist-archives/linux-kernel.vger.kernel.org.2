Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0534579C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWF6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:58:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60099 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229590AbhCWF6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:58:24 -0400
X-UUID: 2a5c4466fbd2468cb1f5fbd24060b900-20210323
X-UUID: 2a5c4466fbd2468cb1f5fbd24060b900-20210323
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 531924362; Tue, 23 Mar 2021 13:58:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 13:58:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 13:58:18 +0800
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
Subject: [PATCH 2/2] iommu/mediatek: Alloc building as module
Date:   Tue, 23 Mar 2021 13:58:01 +0800
Message-ID: <20210323055801.16885-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210323055801.16885-1-yong.wu@mediatek.com>
References: <20210323055801.16885-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU in many SoC depends on the MM clocks and power-domain which
are device_initcall normally, thus the subsys_init here is not helpful.
This patch switches it to module_platform_driver which allow the
driver built as module.

Correspondingly switch the config to tristate.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/Kconfig     |  2 +-
 drivers/iommu/mtk_iommu.c | 16 ++++------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bc93da48bed0..74f3e15edc14 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -349,7 +349,7 @@ config S390_AP_IOMMU
 	  is not implemented as it is not necessary for VFIO.
 
 config MTK_IOMMU
-	bool "MTK IOMMU Support"
+	tristate "MediaTek IOMMU Support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6ecc007f07cd..a73ff3e20480 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
@@ -1079,16 +1080,7 @@ static struct platform_driver mtk_iommu_driver = {
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
+module_platform_driver(mtk_iommu_driver);
 
-static int __init mtk_iommu_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&mtk_iommu_driver);
-	if (ret != 0)
-		pr_err("Failed to register MTK IOMMU driver\n");
-
-	return ret;
-}
-
-subsys_initcall(mtk_iommu_init)
+MODULE_DESCRIPTION("IOMMU API for MediaTek M4U implementations");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

