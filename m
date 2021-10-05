Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E857E422C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhJEPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:25:26 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24219 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhJEPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:25:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HP1Y11zrmzGp6H;
        Tue,  5 Oct 2021 23:22:29 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 23:23:27 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 23:23:27 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <will@kernel.org>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v2 2/2] iommu/vt-d: avoid duplicated removing in __domain_mapping
Date:   Tue, 5 Oct 2021 23:23:08 +0800
Message-ID: <20211005152308.1061-3-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211005152308.1061-1-longpeng2@huawei.com>
References: <20211005152308.1061-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__domain_mapping() always removes the pages in the range from
'iov_pfn' to 'end_pfn', but the 'end_pfn' is always the last pfn
of the range that the caller wants to map.

This would introduce too many duplicated removing and leads the
map operation take too long, for example:

  Map iova=0x100000,nr_pages=0x7d61800
    iov_pfn: 0x100000, end_pfn: 0x7e617ff
    iov_pfn: 0x140000, end_pfn: 0x7e617ff
    iov_pfn: 0x180000, end_pfn: 0x7e617ff
    iov_pfn: 0x1c0000, end_pfn: 0x7e617ff
    iov_pfn: 0x200000, end_pfn: 0x7e617ff
    ...
  it takes about 50ms in total.

We can reduce the cost by recalculate the 'end_pfn' and limit it
to the boundary of the end of this pte page.

  Map iova=0x100000,nr_pages=0x7d61800
    iov_pfn: 0x100000, end_pfn: 0x13ffff
    iov_pfn: 0x140000, end_pfn: 0x17ffff
    iov_pfn: 0x180000, end_pfn: 0x1bffff
    iov_pfn: 0x1c0000, end_pfn: 0x1fffff
    iov_pfn: 0x200000, end_pfn: 0x23ffff
    ...
  it only need 9ms now.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++-----
 include/linux/intel-iommu.h |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59a..87cbf34 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2354,12 +2354,18 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				return -ENOMEM;
 			first_pte = pte;
 
+			lvl_pages = lvl_to_nr_pages(largepage_lvl);
+			BUG_ON(nr_pages < lvl_pages);
+
 			/* It is large page*/
 			if (largepage_lvl > 1) {
 				unsigned long end_pfn;
+				unsigned long pages_to_remove;
 
 				pteval |= DMA_PTE_LARGE_PAGE;
-				end_pfn = ((iov_pfn + nr_pages) & level_mask(largepage_lvl)) - 1;
+				pages_to_remove = min_t(unsigned long, nr_pages,
+							nr_pte_to_next_page(pte) * lvl_pages);
+				end_pfn = iov_pfn + pages_to_remove - 1;
 				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
 			} else {
 				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
@@ -2381,10 +2387,6 @@ static void switch_to_super_page(struct dmar_domain *domain,
 			WARN_ON(1);
 		}
 
-		lvl_pages = lvl_to_nr_pages(largepage_lvl);
-
-		BUG_ON(nr_pages < lvl_pages);
-
 		nr_pages -= lvl_pages;
 		iov_pfn += lvl_pages;
 		phys_pfn += lvl_pages;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a590b00..623b407 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -713,6 +713,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
+static inline int nr_pte_to_next_page(struct dma_pte *pte)
+{
+	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
+		(struct dma_pte *)ALIGN((unsigned long)pte, VTD_PAGE_SIZE) - pte;
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-- 
1.8.3.1

