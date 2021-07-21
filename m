Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D33D1642
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhGURlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:41:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238331AbhGURki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F34EE12FC;
        Wed, 21 Jul 2021 11:21:14 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 815103F694;
        Wed, 21 Jul 2021 11:21:13 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 17/23] iommu/vt-d: Prepare for multiple DMA domain types
Date:   Wed, 21 Jul 2021 19:20:28 +0100
Message-Id: <11efdfa4ee223d12769d17459fcf789c626d7b82.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the strict vs. non-strict decision for DMA domains to
be expressed in the domain type, make sure we expose our flush queue
awareness by accepting the new domain type, and test the specific
feature flag where we want to identify DMA domains in general. The DMA
ops setup can simply be made unconditional, since iommu-dma already
knows not to touch identity domains.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e2add5a0caef..77d322272743 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -601,7 +601,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	int iommu_id;
 
 	/* si_domain and vm domain should not get here. */
-	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
+	if (WARN_ON(!(domain->domain.type & __IOMMU_DOMAIN_DMA)))
 		return NULL;
 
 	for_each_domain_iommu(iommu_id, domain)
@@ -1035,7 +1035,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain_use_first_level(domain)) {
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
-				if (domain->domain.type == IOMMU_DOMAIN_DMA)
+				if (domain->domain.type & __IOMMU_DOMAIN_DMA_API)
 					pteval |= DMA_FL_PTE_ACCESS;
 			}
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
@@ -2346,7 +2346,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if (domain_use_first_level(domain)) {
 		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
-		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
+		if (domain->domain.type & __IOMMU_DOMAIN_DMA_API) {
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
@@ -5164,12 +5165,8 @@ static void intel_iommu_release_device(struct device *dev)
 
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

