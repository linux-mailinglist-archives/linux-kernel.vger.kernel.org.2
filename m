Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD203A871C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFORLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:13 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10212 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhFORK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776932; x=1655312932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=S018wa2gdw8J/yqGiI977vZ9/2XFkFo+h4T7W/Qq1xk=;
  b=qJQiihey/uJrYU5Y+QYr1hUmrf/jEGtXzoTDGDb30YzBe1VmrE1XI4Gh
   uuRp1tdP5ZJvyuP2y6m3tE+Gfhl8vV1DKNMErHus4hlrY0rH56btJkv3Q
   klk5LklA0VP40H95j3BgOOL5i5ATmemayr3dmbvbheya9TCk7yKzdTDH5
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:52 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:51 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:51 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v6 07/15] iommu: Hook up '->unmap_pages' driver callback
Date:   Tue, 15 Jun 2021 10:08:25 -0700
Message-ID: <1623776913-390160-8-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Extend iommu_pgsize() to populate an optional 'count' parameter so that
we can direct unmapping operation to the ->unmap_pages callback if it
has been provided by the driver.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/iommu.c | 59 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 80e14c139d40..725622c7e603 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2376,11 +2376,11 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
 static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
-			   phys_addr_t paddr, size_t size)
+			   phys_addr_t paddr, size_t size, size_t *count)
 {
-	unsigned int pgsize_idx;
+	unsigned int pgsize_idx, pgsize_idx_next;
 	unsigned long pgsizes;
-	size_t pgsize;
+	size_t offset, pgsize, pgsize_next;
 	unsigned long addr_merge = paddr | iova;
 
 	/* Page sizes supported by the hardware and small enough for @size */
@@ -2396,7 +2396,36 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	/* Pick the biggest page size remaining */
 	pgsize_idx = __fls(pgsizes);
 	pgsize = BIT(pgsize_idx);
+	if (!count)
+		return pgsize;
 
+	/* Find the next biggest support page size, if it exists */
+	pgsizes = domain->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
+	if (!pgsizes)
+		goto out_set_count;
+
+	pgsize_idx_next = __ffs(pgsizes);
+	pgsize_next = BIT(pgsize_idx_next);
+
+	/*
+	 * There's no point trying a bigger page size unless the virtual
+	 * and physical addresses are similarly offset within the larger page.
+	 */
+	if ((iova ^ paddr) & (pgsize_next - 1))
+		goto out_set_count;
+
+	/* Calculate the offset to the next page size alignment boundary */
+	offset = pgsize_next - (addr_merge & (pgsize_next - 1));
+
+	/*
+	 * If size is big enough to accommodate the larger page, reduce
+	 * the number of smaller pages.
+	 */
+	if (offset + pgsize_next <= size)
+		size = offset;
+
+out_set_count:
+	*count = size >> pgsize_idx;
 	return pgsize;
 }
 
@@ -2434,7 +2463,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize = iommu_pgsize(domain, iova, paddr, size);
+		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
 
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
@@ -2485,6 +2514,19 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map_atomic);
 
+static size_t __iommu_unmap_pages(struct iommu_domain *domain,
+				  unsigned long iova, size_t size,
+				  struct iommu_iotlb_gather *iotlb_gather)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize, count;
+
+	pgsize = iommu_pgsize(domain, iova, iova, size, &count);
+	return ops->unmap_pages ?
+	       ops->unmap_pages(domain, iova, pgsize, count, iotlb_gather) :
+	       ops->unmap(domain, iova, pgsize, iotlb_gather);
+}
+
 static size_t __iommu_unmap(struct iommu_domain *domain,
 			    unsigned long iova, size_t size,
 			    struct iommu_iotlb_gather *iotlb_gather)
@@ -2494,7 +2536,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
-	if (unlikely(ops->unmap == NULL ||
+	if (unlikely(!(ops->unmap || ops->unmap_pages) ||
 		     domain->pgsize_bitmap == 0UL))
 		return 0;
 
@@ -2522,10 +2564,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	 * or we hit an area that isn't mapped.
 	 */
 	while (unmapped < size) {
-		size_t pgsize;
-
-		pgsize = iommu_pgsize(domain, iova, iova, size - unmapped);
-		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
+		unmapped_page = __iommu_unmap_pages(domain, iova,
+						    size - unmapped,
+						    iotlb_gather);
 		if (!unmapped_page)
 			break;
 
