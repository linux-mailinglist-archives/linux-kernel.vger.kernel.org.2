Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0073E0680
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbhHDRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:16:54 -0400
Received: from foss.arm.com ([217.140.110.172]:34968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239861AbhHDRQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:16:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC5F1042;
        Wed,  4 Aug 2021 10:16:27 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BABD93F66F;
        Wed,  4 Aug 2021 10:16:25 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com, Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 09/25] iommu/sprd: Drop IOVA cookie management
Date:   Wed,  4 Aug 2021 18:15:37 +0100
Message-Id: <5cc86b540faeb0367df9bd6901a15974f0e31c52.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Also remove unneeded include
---
 drivers/iommu/sprd-iommu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 73dfd9946312..27ac818b0354 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -8,7 +8,6 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
-#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
@@ -144,11 +143,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	if (!dom)
 		return NULL;
 
-	if (iommu_get_dma_cookie(&dom->domain)) {
-		kfree(dom);
-		return NULL;
-	}
-
 	spin_lock_init(&dom->pgtlock);
 
 	dom->domain.geometry.aperture_start = 0;
@@ -161,7 +155,6 @@ static void sprd_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 
-	iommu_put_dma_cookie(domain);
 	kfree(dom);
 }
 
-- 
2.25.1

