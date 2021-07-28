Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE813D92A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhG1QAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:00:04 -0400
Received: from foss.arm.com ([217.140.110.172]:59444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237496AbhG1P7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:59:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B9F11D4;
        Wed, 28 Jul 2021 08:59:36 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0443F3F70D;
        Wed, 28 Jul 2021 08:59:34 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH v2 17/24] iommu/vt-d: Prepare for multiple DMA domain types
Date:   Wed, 28 Jul 2021 16:58:38 +0100
Message-Id: <3cf1ab93d3a4868db3b2e60c7c9781619e449694.1627468309.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the strict vs. non-strict decision for DMA domains
to be expressed in the domain type, make sure we expose our flush queue
awareness by accepting the new domain type, and test the specific
feature flag where we want to identify DMA domains in general. The DMA
ops reset/setup can simply be made unconditional, since iommu-dma
already knows only to touch DMA domains.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7e168634c433..8fc46c9d6b96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -582,7 +582,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	int iommu_id;
 
 	/* si_domain and vm domain should not get here. */
-	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
+	if (WARN_ON(!iommu_is_dma_domain(&domain->domain)))
 		return NULL;
 
 	for_each_domain_iommu(iommu_id, domain)
@@ -1034,7 +1034,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain_use_first_level(domain)) {
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
-				if (domain->domain.type == IOMMU_DOMAIN_DMA)
+				if (iommu_is_dma_domain(&domain->domain))
 					pteval |= DMA_FL_PTE_ACCESS;
 			}
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
@@ -2345,7 +2345,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if (domain_use_first_level(domain)) {
 		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
-		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
+		if (iommu_is_dma_domain(&domain->domain)) {
 			attr |= DMA_FL_PTE_ACCESS;
 			if (prot & DMA_PTE_WRITE)
 				attr |= DMA_FL_PTE_DIRTY;
@@ -4528,6 +4528,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 
 	switch (type) {
 	case IOMMU_DOMAIN_DMA:
+	case IOMMU_DOMAIN_DMA_FQ:
 	case IOMMU_DOMAIN_UNMANAGED:
 		dmar_domain = alloc_domain(0);
 		if (!dmar_domain) {
@@ -5197,12 +5198,8 @@ static void intel_iommu_release_device(struct device *dev)
 
 static void intel_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-
-	if (domain && domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, 0, U64_MAX);
-	else
-		set_dma_ops(dev, NULL);
+	set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.25.1

