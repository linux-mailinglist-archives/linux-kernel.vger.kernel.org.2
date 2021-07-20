Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F23CF1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhGTBaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:30:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:12590 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242605AbhGTB2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:28:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190749826"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="190749826"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 19:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453891974"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 19:08:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, robin.murphy@arm.com,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/3] iommu/vt-d: Move clflush'es from iotlb_sync_map() to map_pages()
Date:   Tue, 20 Jul 2021 10:06:15 +0800
Message-Id: <20210720020615.4144323-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
References: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the Intel VT-d driver has switched to use the iommu_ops.map_pages()
callback, multiple pages of the same size will be mapped in a call.
There's no need to put the clflush'es in iotlb_sync_map() callback.
Move them back into __domain_mapping() to simplify the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 48 ++++++-------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6114dac8777d..8c116fe071a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2331,9 +2331,9 @@ static int
 __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 unsigned long phys_pfn, unsigned long nr_pages, int prot)
 {
+	struct dma_pte *first_pte = NULL, *pte = NULL;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
-	struct dma_pte *pte = NULL;
 	phys_addr_t pteval;
 	u64 attr;
 
@@ -2366,6 +2366,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl);
 			if (!pte)
 				return -ENOMEM;
+			first_pte = pte;
+
 			/* It is large page*/
 			if (largepage_lvl > 1) {
 				unsigned long end_pfn;
@@ -2413,14 +2415,14 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 * recalculate 'pte' and switch back to smaller pages for the
 		 * end of the mapping, if the trailing size is not enough to
 		 * use another superpage (i.e. nr_pages < lvl_pages).
-		 *
-		 * We leave clflush for the leaf pte changes to iotlb_sync_map()
-		 * callback.
 		 */
 		pte++;
 		if (!nr_pages || first_pte_in_page(pte) ||
-		    (largepage_lvl > 1 && nr_pages < lvl_pages))
+		    (largepage_lvl > 1 && nr_pages < lvl_pages)) {
+			domain_flush_cache(domain, first_pte,
+					   (void *)pte - (void *)first_pte);
 			pte = NULL;
+		}
 	}
 
 	return 0;
@@ -5561,39 +5563,6 @@ static bool risky_device(struct pci_dev *pdev)
 	return false;
 }
 
-static void clflush_sync_map(struct dmar_domain *domain, unsigned long clf_pfn,
-			     unsigned long clf_pages)
-{
-	struct dma_pte *first_pte = NULL, *pte = NULL;
-	unsigned long lvl_pages = 0;
-	int level = 0;
-
-	while (clf_pages > 0) {
-		if (!pte) {
-			level = 0;
-			pte = pfn_to_dma_pte(domain, clf_pfn, &level);
-			if (WARN_ON(!pte))
-				return;
-			first_pte = pte;
-			lvl_pages = lvl_to_nr_pages(level);
-		}
-
-		if (WARN_ON(!lvl_pages || clf_pages < lvl_pages))
-			return;
-
-		clf_pages -= lvl_pages;
-		clf_pfn += lvl_pages;
-		pte++;
-
-		if (!clf_pages || first_pte_in_page(pte) ||
-		    (level > 1 && clf_pages < lvl_pages)) {
-			domain_flush_cache(domain, first_pte,
-					   (void *)pte - (void *)first_pte);
-			pte = NULL;
-		}
-	}
-}
-
 static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				       unsigned long iova, size_t size)
 {
@@ -5603,9 +5572,6 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	struct intel_iommu *iommu;
 	int iommu_id;
 
-	if (!dmar_domain->iommu_coherency)
-		clflush_sync_map(dmar_domain, pfn, pages);
-
 	for_each_domain_iommu(iommu_id, dmar_domain) {
 		iommu = g_iommus[iommu_id];
 		__mapping_notify_one(iommu, dmar_domain, pfn, pages);
-- 
2.25.1

