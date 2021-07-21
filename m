Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3D3D1631
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhGURkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:40:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhGURkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55BD11FB;
        Wed, 21 Jul 2021 11:20:48 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BFE43F694;
        Wed, 21 Jul 2021 11:20:47 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 02/23] iommu/amd: Drop IOVA cookie management
Date:   Wed, 21 Jul 2021 19:20:13 +0100
Message-Id: <c0ab89692b33a7427be772f4b4e9d317acede0a6.1626888444.git.robin.murphy@arm.com>
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
 drivers/iommu/amd/iommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..40ae7130fc80 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1924,16 +1924,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	domain->domain.geometry.aperture_end   = ~0ULL;
 	domain->domain.geometry.force_aperture = true;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
-		goto free_domain;
-
 	return &domain->domain;
-
-free_domain:
-	protection_domain_free(domain);
-
-	return NULL;
 }
 
 static void amd_iommu_domain_free(struct iommu_domain *dom)
@@ -1950,9 +1941,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (!dom)
 		return;
 
-	if (dom->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&domain->domain);
-
 	if (domain->flags & PD_IOMMUV2_MASK)
 		free_gcr3_table(domain);
 
-- 
2.25.1

