Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A693E9070
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhHKMWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:22:19 -0400
Received: from foss.arm.com ([217.140.110.172]:48548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhHKMWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7CC1396;
        Wed, 11 Aug 2021 05:21:53 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19FDB3F718;
        Wed, 11 Aug 2021 05:21:51 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v4 02/24] iommu/amd: Drop IOVA cookie management
Date:   Wed, 11 Aug 2021 13:21:16 +0100
Message-Id: <648e74e7422caa6a7db7fb0c36813c7bd2007af8.1628682048.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
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
index 52fe2326042a..0fd98d35d73b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1918,16 +1918,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
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
@@ -1944,9 +1935,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (!dom)
 		return;
 
-	if (dom->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&domain->domain);
-
 	if (domain->flags & PD_IOMMUV2_MASK)
 		free_gcr3_table(domain);
 
-- 
2.25.1

