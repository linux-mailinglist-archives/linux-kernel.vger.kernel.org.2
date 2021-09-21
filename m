Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67612414127
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhIVFO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:29329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhIVFOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012045"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107698"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:14 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: [RFC 6/7] iommu: Add KVA map API
Date:   Tue, 21 Sep 2021 13:29:40 -0700
Message-Id: <1632256181-36071-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds KVA map API. It enforces KVA address range checking and
other potential sanity checks. Currently, only the direct map range is
checked.
For trusted devices, this API returns immediately after the above sanity
check. For untrusted devices, this API serves as a simple wrapper around
IOMMU map/unmap APIs. 
OPEN: Alignment at the minimum page size is required, not as rich and
flexible as DMA-APIs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  5 ++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index acfdcd7ebd6a..45ba55941209 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2490,6 +2490,63 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
+/*
+ * REVISIT: This might not be sufficient. Could also check permission match,
+ * exclude kernel text, etc.
+ */
+static inline bool is_kernel_direct_map(unsigned long start, phys_addr_t size)
+{
+	return (start >= PAGE_OFFSET) && ((start + size) <= VMALLOC_START);
+}
+
+/**
+ * @brief Map kernel virtual address for DMA remap. DMA request with
+ *	domain's default PASID will target kernel virtual address space.
+ *
+ * @param domain	Domain contains the PASID
+ * @param page		Kernel virtual address
+ * @param size		Size to map
+ * @param prot		Permissions
+ * @return int		0 on success or error code
+ */
+int iommu_map_kva(struct iommu_domain *domain, struct page *page,
+		  size_t size, int prot)
+{
+	phys_addr_t phys = page_to_phys(page);
+	void *kva = phys_to_virt(phys);
+
+	/*
+	 * TODO: Limit DMA to kernel direct mapping only, avoid dynamic range
+	 * until we have mmu_notifier for making IOTLB coherent with CPU.
+	 */
+	if (!is_kernel_direct_map((unsigned long)kva, size))
+		return -EINVAL;
+	/* KVA domain type indicates shared CPU page table, skip building
+	 * IOMMU page tables. This is the fast mode where only sanity check
+	 * is performed.
+	 */
+	if (domain->type == IOMMU_DOMAIN_KVA)
+		return 0;
+
+	return iommu_map(domain, (unsigned long)kva, phys, size, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_map_kva);
+
+int iommu_unmap_kva(struct iommu_domain *domain, void *kva,
+		    size_t size)
+{
+	if (!is_kernel_direct_map((unsigned long)kva, size))
+		return -EINVAL;
+
+	if (domain->type == IOMMU_DOMAIN_KVA) {
+		pr_debug_ratelimited("unmap kva skipped %llx", (u64)kva);
+		return 0;
+	}
+	/* REVISIT: do we need a fast version? */
+	return iommu_unmap(domain, (unsigned long)kva, size);
+}
+EXPORT_SYMBOL_GPL(iommu_unmap_kva);
+
 int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cd8225f6bc23..c0fac050ca57 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -427,6 +427,11 @@ extern size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 extern size_t iommu_map_sg_atomic(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot);
+extern int iommu_map_kva(struct iommu_domain *domain,
+			 struct page *page, size_t size, int prot);
+extern int iommu_unmap_kva(struct iommu_domain *domain,
+			   void *kva, size_t size);
+
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
-- 
2.25.1

