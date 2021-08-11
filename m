Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACDA3E9078
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhHKMWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:22:34 -0400
Received: from foss.arm.com ([217.140.110.172]:48688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237691AbhHKMW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651381396;
        Wed, 11 Aug 2021 05:22:04 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 877D83F718;
        Wed, 11 Aug 2021 05:22:02 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v4 07/24] iommu/mtk: Drop IOVA cookie management
Date:   Wed, 11 Aug 2021 13:21:21 +0100
Message-Id: <b856648e7ee2b1017e7c7c02e2ddd50eaf72cbf7.1628682048.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

CC: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Also remove unneeded includes
---
 drivers/iommu/mtk_iommu.c    | 7 -------
 drivers/iommu/mtk_iommu_v1.c | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6f7c69688ce2..185694eb4456 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -9,7 +9,6 @@
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -441,17 +440,11 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (!dom)
 		return NULL;
 
-	if (iommu_get_dma_cookie(&dom->domain)) {
-		kfree(dom);
-		return NULL;
-	}
-
 	return &dom->domain;
 }
 
 static void mtk_iommu_domain_free(struct iommu_domain *domain)
 {
-	iommu_put_dma_cookie(domain);
 	kfree(to_mtk_domain(domain));
 }
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 778e66f5f1aa..be22fcf988ce 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -13,7 +13,6 @@
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
2.25.1

