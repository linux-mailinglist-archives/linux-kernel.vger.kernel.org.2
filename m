Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB53A8721
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhFORL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:26 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34909 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231229AbhFORK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776933; x=1655312933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RkUxbPOsV+XN7vIXyWNniRgdCryIUPWS7ilq0vkeuZQ=;
  b=RJ2tST1Q+cDvrsDM6YN2gRfBUU++ZOLkkTU8gOSDYci6BOzV3QrMsoaM
   wU0jyS/LtZkQzDekdqAb3mRV6vLEFiXHEHRKmU4drzRxcdJuEe1LiAVEN
   PJfEEv8b//MTeEWwVwa6122UjzoEtmBz+GwGVwCJOlomanE8YUkBQnzc+
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2021 10:08:53 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:53 -0700
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
Subject: [PATCH v6 11/15] iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
Date:   Tue, 15 Jun 2021 10:08:29 -0700
Message-ID: <1623776913-390160-12-git-send-email-quic_c_gdjako@quicinc.com>
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

Implement the map_pages() callback for the ARM LPAE io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/io-pgtable-arm.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 1b690911995a..6a6af9b0678e 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -344,20 +344,30 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 }
 
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
-			  phys_addr_t paddr, size_t size, arm_lpae_iopte prot,
-			  int lvl, arm_lpae_iopte *ptep, gfp_t gfp)
+			  phys_addr_t paddr, size_t size, size_t pgcount,
+			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
+			  gfp_t gfp, size_t *mapped)
 {
 	arm_lpae_iopte *cptep, pte;
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	size_t tblsz = ARM_LPAE_GRANULE(data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	int ret = 0, num_entries, max_entries, map_idx_start;
 
 	/* Find our entry at the current level */
-	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	ptep += map_idx_start;
 
 	/* If we can install a leaf entry at this level, then do so */
-	if (size == block_size)
-		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, 1, ptep);
+	if (size == block_size) {
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
+		if (!ret && mapped)
+			*mapped += num_entries * size;
+
+		return ret;
+	}
 
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
@@ -386,7 +396,8 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	}
 
 	/* Rinse, repeat */
-	return __arm_lpae_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
+	return __arm_lpae_map(data, iova, paddr, size, pgcount, prot, lvl + 1,
+			      cptep, gfp, mapped);
 }
 
 static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
@@ -453,8 +464,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	return pte;
 }
 
-static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
+static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int iommu_prot, gfp_t gfp, size_t *mapped)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
@@ -463,7 +475,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte prot;
 	long iaext = (s64)iova >> cfg->ias;
 
-	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize))
 		return -EINVAL;
 
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
@@ -476,7 +488,8 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 		return 0;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
+	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
+			     ptep, gfp, mapped);
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -486,6 +499,13 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
+static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
+			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
+{
+	return arm_lpae_map_pages(ops, iova, paddr, size, 1, iommu_prot, gfp,
+				  NULL);
+}
+
 static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 				    arm_lpae_iopte *ptep)
 {
@@ -782,6 +802,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
+		.map_pages	= arm_lpae_map_pages,
 		.unmap		= arm_lpae_unmap,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
