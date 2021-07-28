Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC893D9289
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhG1P71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:59:27 -0400
Received: from foss.arm.com ([217.140.110.172]:59348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237363AbhG1P7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:59:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB3CE1FB;
        Wed, 28 Jul 2021 08:59:21 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 109E33F70D;
        Wed, 28 Jul 2021 08:59:19 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 09/24] iommu/sprd: Drop IOVA cookie management
Date:   Wed, 28 Jul 2021 16:58:30 +0100
Message-Id: <7aa0f8aece44391df4dd5d8d1a780f3d3ef2a1a2.1627468309.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/sprd-iommu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 73dfd9946312..2bc1de6e823d 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -144,11 +144,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	if (!dom)
 		return NULL;
 
-	if (iommu_get_dma_cookie(&dom->domain)) {
-		kfree(dom);
-		return NULL;
-	}
-
 	spin_lock_init(&dom->pgtlock);
 
 	dom->domain.geometry.aperture_start = 0;
@@ -161,7 +156,6 @@ static void sprd_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 
-	iommu_put_dma_cookie(domain);
 	kfree(dom);
 }
 
-- 
2.25.1

