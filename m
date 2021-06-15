Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C493A8724
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhFORLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:41 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10234 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhFORK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776934; x=1655312934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CBMDlnsh+qaJMApeNPDUroxv7h3NodYrYtMqWk/jypA=;
  b=GLEo4hM16whwzQ1qsu8ObyAh4Yu0Bcm2SdXcRi7XcAbkvPISZ45nbYpO
   v89cWy/XgwHq1iyY0+nyry3a03jSL1+jT8lTm0OayIr9elYDZYLqLLgno
   ShjbOl/nHTT5qPLJ+XmSZpmaH2EEzEek9J5cpMiiaXPDwZRWbPXScQfKK
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:54 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:54 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:54 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v6 14/15] iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
Date:   Tue, 15 Jun 2021 10:08:32 -0700
Message-ID: <1623776913-390160-15-git-send-email-quic_c_gdjako@quicinc.com>
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

Implement the unmap_pages() callback for the ARM SMMU driver
to allow calls from iommu_unmap to unmap multiple pages of
the same size in one call. Also, remove the unmap() callback
for the SMMU driver, as it will no longer be used.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 61233bcc4588..593a15cfa8d5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1210,8 +1210,9 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			     size_t size, struct iommu_iotlb_gather *gather)
+static size_t arm_smmu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
+				   size_t pgsize, size_t pgcount,
+				   struct iommu_iotlb_gather *iotlb_gather)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
@@ -1221,7 +1222,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 		return 0;
 
 	arm_smmu_rpm_get(smmu);
-	ret = ops->unmap(ops, iova, size, gather);
+	ret = ops->unmap_pages(ops, iova, pgsize, pgcount, iotlb_gather);
 	arm_smmu_rpm_put(smmu);
 
 	return ret;
@@ -1574,7 +1575,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
-	.unmap			= arm_smmu_unmap,
+	.unmap_pages		= arm_smmu_unmap_pages,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
