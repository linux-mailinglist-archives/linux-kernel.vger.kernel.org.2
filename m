Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C03E066D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhHDRQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:16:27 -0400
Received: from foss.arm.com ([217.140.110.172]:34790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239695AbhHDRQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:16:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E71E711FB;
        Wed,  4 Aug 2021 10:16:12 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3767F3F66F;
        Wed,  4 Aug 2021 10:16:11 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v3 02/25] iommu/amd: Drop IOVA cookie management
Date:   Wed,  4 Aug 2021 18:15:30 +0100
Message-Id: <ebc82f082d5fde58557efbec66f34b1be6a12599.1628094600.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Also remove unneeded include
---
 drivers/iommu/amd/iommu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52fe2326042a..92f7cbe3d14a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -20,7 +20,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-iommu.h>
 #include <linux/iommu-helper.h>
 #include <linux/delay.h>
 #include <linux/amd-iommu.h>
@@ -1918,16 +1917,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
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
@@ -1944,9 +1934,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (!dom)
 		return;
 
-	if (dom->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&domain->domain);
-
 	if (domain->flags & PD_IOMMUV2_MASK)
 		free_gcr3_table(domain);
 
-- 
2.25.1

