Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170234A035
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCZDYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:24:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48733 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230222AbhCZDXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:23:49 -0400
X-UUID: e8e2e366388342db8bebe07cf6d2f5b0-20210326
X-UUID: e8e2e366388342db8bebe07cf6d2f5b0-20210326
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1594774408; Fri, 26 Mar 2021 11:23:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 11:23:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 11:23:44 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v2 1/2] iommu/mediatek-v1: Allow building as module
Date:   Fri, 26 Mar 2021 11:23:36 +0800
Message-ID: <20210326032337.24578-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only adds support for building the IOMMU-v1 driver as module.
Correspondingly switch the config to tristate and update the iommu_ops's
owner to THIS_MODULE.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
v2: change note:
    a) Update iommu_ops's owner to THIS_MODULE
    b) Fix typo in the title from "Alloc" to "Allow"

v1: rebase on v5.12-rc2
---
 drivers/iommu/Kconfig        |  2 +-
 drivers/iommu/mtk_iommu_v1.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index 82ddfe9170d4..be1b20e3f20e 100644
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
@@ -529,6 +530,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.def_domain_type = mtk_iommu_def_domain_type,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
+	.owner          = THIS_MODULE,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
@@ -691,9 +693,7 @@ static struct platform_driver mtk_iommu_driver = {
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

