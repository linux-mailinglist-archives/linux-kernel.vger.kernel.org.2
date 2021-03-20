Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38782342A24
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 04:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCTDEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 23:04:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:61111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhCTDDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 23:03:47 -0400
IronPort-SDR: 4DHQnN4T5v7oXXZyNd9cWJt9fGKNtpPoIxVKP9jfAnGSaOF/K7bNxd8jTsDl4oxuSF1OYI2WkW
 gc1wGiiGlt6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186661576"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186661576"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 20:03:47 -0700
IronPort-SDR: MkhRtXD3WD8Ork4d5rD1aaNNQBC0c2qcEdT9ridhUknnuOpIKUe+tWiSL9J0BQ5fzpbiSOMiLA
 SPyV3LJJNleQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441520662"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 20:03:45 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 4/5] iommu/vt-d: Use user privilege for RID2PASID translation
Date:   Sat, 20 Mar 2021 10:54:14 +0800
Message-Id: <20210320025415.641201-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320025415.641201-1-baolu.lu@linux.intel.com>
References: <20210320025415.641201-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When first-level page tables are used for IOVA translation, we use user
privilege by setting U/S bit in the page table entry. This is to make it
consistent with the second level translation, where the U/S enforcement
is not available. Clear the SRE (Supervisor Request Enable) field in the
pasid table entry of RID2PASID so that requests requesting the supervisor
privilege are blocked and treated as DMA remapping faults.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 +++++--
 drivers/iommu/intel/pasid.c | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 868f195f55ff..7354f9ce47d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2494,9 +2494,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct device *dev,
 				    u32 pasid)
 {
-	int flags = PASID_FLAG_SUPERVISOR_MODE;
 	struct dma_pte *pgd = domain->pgd;
 	int agaw, level;
+	int flags = 0;
 
 	/*
 	 * Skip top levels of page tables for iommu which has
@@ -2512,7 +2512,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level != 4 && level != 5)
 		return -EINVAL;
 
-	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
+	if (pasid != PASID_RID2PASID)
+		flags |= PASID_FLAG_SUPERVISOR_MODE;
+	if (level == 5)
+		flags |= PASID_FLAG_FL5LP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
 					     domain->iommu_did[iommu->seq_id],
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0bf7e0a76890..dd69df5a188a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -673,7 +673,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
 	 */
-	pasid_set_sre(pte);
+	if (pasid != PASID_RID2PASID)
+		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	pasid_flush_caches(iommu, pte, pasid, did);
 
-- 
2.25.1

