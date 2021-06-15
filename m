Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723973A8723
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFORLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:34 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34931 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhFORK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776934; x=1655312934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rwL0tPjHeJsi9VvRsGNXckNgcDwBnKl7/N+tguBCVBM=;
  b=wEDGfR001+rybPuJEvwYF2UEkLQxmmq9cJfZX9LoJbz2b5CyeLkWIEXr
   JmjtwIOP5tSl7tgfK2k/CTgPpRBlno1eN3p8A+ntrQt/7SzRsNS3X4Ebs
   TvmBM1WsS0zjqs6KbBejmiX49+G1CRqcJwvcyVREI65u7XgNlRvweM/62
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2021 10:08:54 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:54 -0700
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
Subject: [PATCH v6 13/15] iommu/io-pgtable-arm-v7s: Implement arm_v7s_map_pages()
Date:   Tue, 15 Jun 2021 10:08:31 -0700
Message-ID: <1623776913-390160-14-git-send-email-quic_c_gdjako@quicinc.com>
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

Implement the map_pages() callback for the ARM v7s io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1af060686985..5db90d7ce2ec 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -519,11 +519,12 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 	return __arm_v7s_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
 }
 
-static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			     int prot, gfp_t gfp, size_t *mapped)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	int ret;
+	int ret = -EINVAL;
 
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
 		    paddr >= (1ULL << data->iop.cfg.oas)))
@@ -533,7 +534,17 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
-	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd, gfp);
+	while (pgcount--) {
+		ret = __arm_v7s_map(data, iova, paddr, pgsize, prot, 1, data->pgd,
+				    gfp);
+		if (ret)
+			break;
+
+		iova += pgsize;
+		paddr += pgsize;
+		if (mapped)
+			*mapped += pgsize;
+	}
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -543,6 +554,12 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
+static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
+		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	return arm_v7s_map_pages(ops, iova, paddr, size, 1, prot, gfp, NULL);
+}
+
 static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_to_data(iop);
@@ -797,6 +814,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
+		.map_pages	= arm_v7s_map_pages,
 		.unmap		= arm_v7s_unmap,
 		.unmap_pages	= arm_v7s_unmap_pages,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
