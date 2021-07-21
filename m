Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95023D163C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhGURk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:40:59 -0400
Received: from foss.arm.com ([217.140.110.172]:33352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236533AbhGURkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF7D139F;
        Wed, 21 Jul 2021 11:21:08 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8845E3F694;
        Wed, 21 Jul 2021 11:21:06 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 13/23] iommu/dma: Remove redundant "!dev" checks
Date:   Wed, 21 Jul 2021 19:20:24 +0100
Message-Id: <4395626d7a4ba84ecce4ff8bc6d086795cebf0a6.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_dma_init_domain() is now only called from iommu_setup_dma_ops(),
which has already assumed dev to be non-NULL.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 10067fbc4309..e28396cea6eb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -363,7 +363,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	if (!cookie->fq_domain && !dev_is_untrusted(dev) &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
@@ -372,9 +372,6 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 			cookie->fq_domain = domain;
 	}
 
-	if (!dev)
-		return 0;
-
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
-- 
2.25.1

