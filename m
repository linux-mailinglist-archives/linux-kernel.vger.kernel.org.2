Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC93A8722
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhFORLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:31 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10224 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231241AbhFORK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776934; x=1655312934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=a7q8EuAYMzxg+4doJVnZ179Qf38aU1OCTgmBjq9gR0M=;
  b=jAqM8bv34cy0xh2lGit+S3G2kBz0Scm8n45OuSB2MIm/duZ9UhhYO+DY
   6xAtc9PWv9I6CDJETCfdWL6Tqob2Nfpx47aDFuzH0I4WCfWKiemCNe+Hz
   wtagRGFdO3TGrBMI3fqJk/cdcI4WQU+Ieo7WW/w9JBuK4mRQNXe4WYq6N
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:54 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:53 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:53 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v6 12/15] iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
Date:   Tue, 15 Jun 2021 10:08:30 -0700
Message-ID: <1623776913-390160-13-git-send-email-quic_c_gdjako@quicinc.com>
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

Implement the unmap_pages() callback for the ARM v7s io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d4004bcf333a..1af060686985 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -710,15 +710,32 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 	return __arm_v7s_unmap(data, gather, iova, size, lvl + 1, ptep);
 }
 
-static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
-			    size_t size, struct iommu_iotlb_gather *gather)
+static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
+				  size_t pgsize, size_t pgcount,
+				  struct iommu_iotlb_gather *gather)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	size_t unmapped = 0, ret;
 
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;
 
-	return __arm_v7s_unmap(data, gather, iova, size, 1, data->pgd);
+	while (pgcount--) {
+		ret = __arm_v7s_unmap(data, gather, iova, pgsize, 1, data->pgd);
+		if (!ret)
+			break;
+
+		unmapped += pgsize;
+		iova += pgsize;
+	}
+
+	return unmapped;
+}
+
+static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
+			    size_t size, struct iommu_iotlb_gather *gather)
+{
+	return arm_v7s_unmap_pages(ops, iova, size, 1, gather);
 }
 
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
@@ -781,6 +798,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
 		.unmap		= arm_v7s_unmap,
+		.unmap_pages	= arm_v7s_unmap_pages,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
 	};
 
