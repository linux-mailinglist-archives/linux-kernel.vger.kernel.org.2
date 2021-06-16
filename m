Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2B3A9C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhFPNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:42:24 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33995 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233378AbhFPNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623850771; x=1655386771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=a7q8EuAYMzxg+4doJVnZ179Qf38aU1OCTgmBjq9gR0M=;
  b=Pa3e6elR7Dn2DyRKNOrXmZ95grXO60AAMgDEntmeNXJHwteOWKyZ5zgl
   LwPinFa9TjWi36/P9rHnWAnvl3OK0I3BIzhm3b3zitE4gfqf6qsmRlMue
   IsQ4LoB0PZchnoGlOf/BFOxvRLAY317CHDk7PCXGATsZbVT/v/DAVlgaH
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jun 2021 06:39:16 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jun 2021 06:39:11 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 06:39:10 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v7 12/15] iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
Date:   Wed, 16 Jun 2021 06:38:53 -0700
Message-ID: <1623850736-389584-13-git-send-email-quic_c_gdjako@quicinc.com>
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
 
