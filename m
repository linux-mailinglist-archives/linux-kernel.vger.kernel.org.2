Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194643A871E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhFORLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:20 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10224 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhFORK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776932; x=1655312932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SyoClSC10MZdzcjwY9Xji1VjhbSPkm7sFDJ1QrxLPog=;
  b=sNqDrg+Fe1z0AkVFgXv4cc95xW4zwzUbOxx7Bt3KK8pF3W009AYwy1Oh
   g4VSQ/M19SNnPvI9Cayy2Ql9jY9cL5/moW/erx12q0xF7t0JeM0KwkLuh
   0ByZpi6Bn7lRYqAwXfbPDHscBfeG2Rotc3l510gvx/rONoiIgEnrJycDY
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:52 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:52 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:52 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v6 09/15] iommu/io-pgtable-arm: Prepare PTE methods for handling multiple entries
Date:   Tue, 15 Jun 2021 10:08:27 -0700
Message-ID: <1623776913-390160-10-git-send-email-quic_c_gdjako@quicinc.com>
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

The PTE methods currently operate on a single entry. In preparation
for manipulating multiple PTEs in one map or unmap call, allow them
to handle multiple PTEs.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/io-pgtable-arm.c | 78 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..ea66b10c04c4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -232,20 +232,23 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	free_pages((unsigned long)pages, get_order(size));
 }
 
-static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
+static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				struct io_pgtable_cfg *cfg)
 {
 	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
-				   sizeof(*ptep), DMA_TO_DEVICE);
+				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
 static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
-			       struct io_pgtable_cfg *cfg)
+			       int num_entries, struct io_pgtable_cfg *cfg)
 {
-	*ptep = pte;
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte;
 
 	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, cfg);
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -255,47 +258,54 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
-				int lvl, arm_lpae_iopte *ptep)
+				int lvl, int num_entries, arm_lpae_iopte *ptep)
 {
 	arm_lpae_iopte pte = prot;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i;
 
 	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
-	pte |= paddr_to_iopte(paddr, data);
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
+	if (!cfg->coherent_walk)
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     unsigned long iova, phys_addr_t paddr,
-			     arm_lpae_iopte prot, int lvl,
+			     arm_lpae_iopte prot, int lvl, int num_entries,
 			     arm_lpae_iopte *ptep)
 {
-	arm_lpae_iopte pte = *ptep;
-
-	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
-		/* We require an unmap first */
-		WARN_ON(!selftest_running);
-		return -EEXIST;
-	} else if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
-		/*
-		 * We need to unmap and free the old table before
-		 * overwriting it with a block entry.
-		 */
-		arm_lpae_iopte *tblp;
-		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-
-		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
-			WARN_ON(1);
-			return -EINVAL;
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
+			/* We require an unmap first */
+			WARN_ON(!selftest_running);
+			return -EEXIST;
+		} else if (iopte_type(ptep[i]) == ARM_LPAE_PTE_TYPE_TABLE) {
+			/*
+			 * We need to unmap and free the old table before
+			 * overwriting it with a block entry.
+			 */
+			arm_lpae_iopte *tblp;
+			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
+			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
+					     lvl, tblp) != sz) {
+				WARN_ON(1);
+				return -EINVAL;
+			}
 		}
-	}
 
-	__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+	__arm_lpae_init_pte(data, paddr, prot, lvl, num_entries, ptep);
 	return 0;
 }
 
@@ -323,7 +333,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 		return old;
 
 	/* Even if it's not ours, there's no point waiting; just kick it */
-	__arm_lpae_sync_pte(ptep, cfg);
+	__arm_lpae_sync_pte(ptep, 1, cfg);
 	if (old == curr)
 		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
 
@@ -344,7 +354,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 
 	/* If we can install a leaf entry at this level, then do so */
 	if (size == block_size)
-		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
+		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, 1, ptep);
 
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
@@ -361,7 +371,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		if (pte)
 			__arm_lpae_free_pages(cptep, tblsz, cfg);
 	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
-		__arm_lpae_sync_pte(ptep, cfg);
+		__arm_lpae_sync_pte(ptep, 1, cfg);
 	}
 
 	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
@@ -543,7 +553,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		if (i == unmap_idx)
 			continue;
 
-		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, &tablep[i]);
+		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
 	}
 
 	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
@@ -585,7 +595,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 	/* If the size matches this level, we're in the right place */
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
+		__arm_lpae_set_pte(ptep, 0, 1, &iop->cfg);
 
 		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
