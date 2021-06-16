Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D988A3A9C40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhFPNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:42:50 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33995 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233463AbhFPNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623850818; x=1655386818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BYgsDpGVXiNQKbjx1zEY4QnnueERRkwQ3EUBgFLcp1s=;
  b=Y7XBeVy6E6hJ/roF0P8uaQziS5UeHgTWpzP1gvxLbplYW1G70cSyWZ7t
   czaKFdWSTXq5Tiuj7hL8AzX9Lh3iRkoel6NPWb3ureXRJCX+8axe2jXOo
   GdAICZm9yZInBiEkrpEuSoVdUqb09mBKHNU0Jo+md+8svLUJvU4zYvVuF
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jun 2021 06:39:16 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jun 2021 06:39:12 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 06:39:11 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v7 15/15] iommu/arm-smmu: Implement the map_pages() IOMMU driver callback
Date:   Wed, 16 Jun 2021 06:38:56 -0700
Message-ID: <1623850736-389584-16-git-send-email-quic_c_gdjako@quicinc.com>
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

Implement the map_pages() callback for the ARM SMMU driver
to allow calls from iommu_map to map multiple pages of
the same size in one call. Also, remove the map() callback
for the ARM SMMU driver, as it will no longer be used.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 593a15cfa8d5..c1ca3b49a620 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1193,8 +1193,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
-static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int prot, gfp_t gfp, size_t *mapped)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
@@ -1204,7 +1205,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		return -ENODEV;
 
 	arm_smmu_rpm_get(smmu);
-	ret = ops->map(ops, iova, paddr, size, prot, gfp);
+	ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
 	arm_smmu_rpm_put(smmu);
 
 	return ret;
@@ -1574,7 +1575,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
-	.map			= arm_smmu_map,
+	.map_pages		= arm_smmu_map_pages,
 	.unmap_pages		= arm_smmu_unmap_pages,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
