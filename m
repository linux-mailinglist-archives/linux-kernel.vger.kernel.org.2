Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C123A9C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhFPNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:42:32 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33975 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233375AbhFPNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623850793; x=1655386793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+HFv+DKvnPCPsWuXWYMZKBwCYe6e05uqYXwhKa4C3YE=;
  b=OPXPR7PXduTqxRhdbQzgiBhtfULTpQPCSZOWZNwyKRMrLijAuefN8Lej
   EsDBSj+JpAqArbmATUWemLXv7+InViYu4RIgAftSFardkzFOH6z63ChIj
   9e88l35a4fa+v75sU+/2Og0JJ7Xoi5OI/25/GHSeFSbJ2lHVNCDeF5kN9
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jun 2021 06:39:16 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jun 2021 06:39:09 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 06:39:08 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v7 08/15] iommu: Add support for the map_pages() callback
Date:   Wed, 16 Jun 2021 06:38:49 -0700
Message-ID: <1623850736-389584-9-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Since iommu_pgsize can calculate how many pages of the
same size can be mapped/unmapped before the next largest
page size boundary, add support for invoking an IOMMU
driver's map_pages() callback, if it provides one.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 725622c7e603..70a729ce88b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2429,6 +2429,30 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	return pgsize;
 }
 
+static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
+			     phys_addr_t paddr, size_t size, int prot,
+			     gfp_t gfp, size_t *mapped)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize, count;
+	int ret;
+
+	pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
+
+	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
+		 iova, &paddr, pgsize, count);
+
+	if (ops->map_pages) {
+		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
+				     gfp, mapped);
+	} else {
+		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
+		*mapped = ret ? 0 : pgsize;
+	}
+
+	return ret;
+}
+
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -2439,7 +2463,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(ops->map == NULL ||
+	if (unlikely(!(ops->map || ops->map_pages) ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
@@ -2463,18 +2487,21 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
+		size_t mapped = 0;
 
-		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
-			 iova, &paddr, pgsize);
-		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
+		ret = __iommu_map_pages(domain, iova, paddr, size, prot, gfp,
+					&mapped);
+		/*
+		 * Some pages may have been mapped, even if an error occurred,
+		 * so we should account for those so they can be unmapped.
+		 */
+		size -= mapped;
 
 		if (ret)
 			break;
 
-		iova += pgsize;
-		paddr += pgsize;
-		size -= pgsize;
+		iova += mapped;
+		paddr += mapped;
 	}
 
 	/* unroll mapping in case something went wrong */
