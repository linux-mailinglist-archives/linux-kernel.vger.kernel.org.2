Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D83A871D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhFORLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:16 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10212 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231173AbhFORK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776932; x=1655312932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LGJGpnuG0uMt0y87eWE3gLIkYnYBQba4VrRy65O7wqg=;
  b=IAbnUsnXk4p0LZsSjPJC8x1/hIiL+DJgfKaZJzVMis72MPUP7TWJqKVy
   0RYDk6yQCCzszACC2UXcMN0W0DY++Rrw9h0WUJ7qZkFdLhCvF84TIDIyf
   uP7TjcEv6JBE/DZhUh/ETjhY6/vAUD8eb6aaxkq3HdHjp8MoFlBYnCPiK
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:52 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:52 -0700
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
Subject: [PATCH v6 08/15] iommu: Add support for the map_pages() callback
Date:   Tue, 15 Jun 2021 10:08:26 -0700
Message-ID: <1623776913-390160-9-git-send-email-quic_c_gdjako@quicinc.com>
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
index 725622c7e603..89f8ab6a72a9 100644
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
+	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %ld\n",
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
