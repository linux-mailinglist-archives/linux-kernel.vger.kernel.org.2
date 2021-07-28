Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4713D9290
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhG1P7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:59:33 -0400
Received: from foss.arm.com ([217.140.110.172]:59384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237382AbhG1P71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B79D6E;
        Wed, 28 Jul 2021 08:59:25 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E098E3F70D;
        Wed, 28 Jul 2021 08:59:23 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 11/24] iommu/virtio: Drop IOVA cookie management
Date:   Wed, 28 Jul 2021 16:58:32 +0100
Message-Id: <d9f524e29a580d094c7f9a7322e1bea6f3637c19.1627468309.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/virtio-iommu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 6abdcab7273b..80930ce04a16 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -598,12 +598,6 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	spin_lock_init(&vdomain->mappings_lock);
 	vdomain->mappings = RB_ROOT_CACHED;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&vdomain->domain)) {
-		kfree(vdomain);
-		return NULL;
-	}
-
 	return &vdomain->domain;
 }
 
@@ -643,8 +637,6 @@ static void viommu_domain_free(struct iommu_domain *domain)
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	iommu_put_dma_cookie(domain);
-
 	/* Free all remaining mappings (size 2^64) */
 	viommu_del_mappings(vdomain, 0, 0);
 
-- 
2.25.1

