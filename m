Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241113E9083
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhHKMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:22:46 -0400
Received: from foss.arm.com ([217.140.110.172]:48758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237607AbhHKMWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD221396;
        Wed, 11 Aug 2021 05:22:10 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F12633F718;
        Wed, 11 Aug 2021 05:22:08 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 10/24] iommu/sun50i: Drop IOVA cookie management
Date:   Wed, 11 Aug 2021 13:21:24 +0100
Message-Id: <147edb0ba59be563df19cec3e63e621aa65b7b68.1628682048.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

CC: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Also remove unneeded include
---
 drivers/iommu/sun50i-iommu.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 181bb1c3437c..92997021e188 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -7,7 +7,6 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-direction.h>
-#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -610,14 +609,10 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 	if (!sun50i_domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&sun50i_domain->domain))
-		goto err_free_domain;
-
 	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 						    get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
-		goto err_put_cookie;
+		goto err_free_domain;
 
 	refcount_set(&sun50i_domain->refcnt, 1);
 
@@ -627,10 +622,6 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 
 	return &sun50i_domain->domain;
 
-err_put_cookie:
-	if (type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&sun50i_domain->domain);
-
 err_free_domain:
 	kfree(sun50i_domain);
 
@@ -644,8 +635,6 @@ static void sun50i_iommu_domain_free(struct iommu_domain *domain)
 	free_pages((unsigned long)sun50i_domain->dt, get_order(DT_SIZE));
 	sun50i_domain->dt = NULL;
 
-	iommu_put_dma_cookie(domain);
-
 	kfree(sun50i_domain);
 }
 
-- 
2.25.1

