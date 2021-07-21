Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04663D1637
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhGURkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:40:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234991AbhGURkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C3DC11FB;
        Wed, 21 Jul 2021 11:20:59 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0B443F694;
        Wed, 21 Jul 2021 11:20:57 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 08/23] iommu/rockchip: Drop IOVA cookie management
Date:   Wed, 21 Jul 2021 19:20:19 +0100
Message-Id: <f63858319b91820de754ae61414939a4e4780ff6.1626888444.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9febfb7f3025..c24561f54f32 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1074,10 +1074,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	if (!rk_domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&rk_domain->domain))
-		goto err_free_domain;
-
 	/*
 	 * rk32xx iommus use a 2 level pagetable.
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
@@ -1085,7 +1081,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	 */
 	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
 	if (!rk_domain->dt)
-		goto err_put_cookie;
+		goto err_free_domain;
 
 	rk_domain->dt_dma = dma_map_single(dma_dev, rk_domain->dt,
 					   SPAGE_SIZE, DMA_TO_DEVICE);
@@ -1106,9 +1102,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 
 err_free_dt:
 	free_page((unsigned long)rk_domain->dt);
-err_put_cookie:
-	if (type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&rk_domain->domain);
 err_free_domain:
 	kfree(rk_domain);
 
@@ -1137,8 +1130,6 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 			 SPAGE_SIZE, DMA_TO_DEVICE);
 	free_page((unsigned long)rk_domain->dt);
 
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&rk_domain->domain);
 	kfree(rk_domain);
 }
 
-- 
2.25.1

