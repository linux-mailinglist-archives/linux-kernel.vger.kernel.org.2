Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106013E066E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhHDRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:34818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239835AbhHDRQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:16:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCDD12FC;
        Wed,  4 Aug 2021 10:16:14 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 310343F66F;
        Wed,  4 Aug 2021 10:16:13 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v3 03/25] iommu/arm-smmu: Drop IOVA cookie management
Date:   Wed,  4 Aug 2021 18:15:31 +0100
Message-Id: <73f9b2dc5666f145bd912a330c5785dbbe3734a7.1628094600.git.robin.murphy@arm.com>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  7 -------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 15 ++++-----------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  9 ---------
 3 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6346f21726f4..4c648da447bf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1984,12 +1984,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (!smmu_domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&smmu_domain->domain)) {
-		kfree(smmu_domain);
-		return NULL;
-	}
-
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
@@ -2021,7 +2015,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
 	/* Free the CD and ASID, if we allocated them */
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index ac21170fa208..970d9e4dcd69 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -868,10 +868,10 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_IDENTITY)
-		return NULL;
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_IDENTITY) {
+		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
+			return NULL;
+	}
 	/*
 	 * Allocate the domain and initialise some of its data structures.
 	 * We can't really do anything meaningful until we've added a
@@ -881,12 +881,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (!smmu_domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA && (using_legacy_binding ||
-	    iommu_get_dma_cookie(&smmu_domain->domain))) {
-		kfree(smmu_domain);
-		return NULL;
-	}
-
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
 
@@ -901,7 +895,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	 * Free the domain resources. We assume that all devices have
 	 * already been detached.
 	 */
-	iommu_put_dma_cookie(domain);
 	arm_smmu_destroy_domain_context(domain);
 	kfree(smmu_domain);
 }
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 021cf8f65ffc..b91874cb6cf3 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -10,7 +10,6 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -335,12 +334,6 @@ static struct iommu_domain *qcom_iommu_domain_alloc(unsigned type)
 	if (!qcom_domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&qcom_domain->domain)) {
-		kfree(qcom_domain);
-		return NULL;
-	}
-
 	mutex_init(&qcom_domain->init_mutex);
 	spin_lock_init(&qcom_domain->pgtbl_lock);
 
@@ -351,8 +344,6 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 
-	iommu_put_dma_cookie(domain);
-
 	if (qcom_domain->iommu) {
 		/*
 		 * NOTE: unmap can be called after client device is powered
-- 
2.25.1

