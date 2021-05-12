Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF34737B654
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhELGqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:46:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:27652 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhELGqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:46:40 -0400
IronPort-SDR: +RGGDsfjlf9B4Mkv02sQeVUrCwZiHUkPF3qcVry2kMX0YrV5yijJRd0B3Sf/Mcm7Iz9tK21eQh
 Hi5wSVicoNFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186766408"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="186766408"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 23:45:18 -0700
IronPort-SDR: Mr3TRUPpSvEHoNhG9TuJWJVY4Ky1OcWmkCaLmvCBTSbhjuIRKC/YSNN+FYi/Sj6S1ME9yciJOf
 LjG6s6JugrVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="537496288"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 23:45:15 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RESEND PATACH 1/1] iommu/vt-d: Use user privilege for RID2PASID translation
Date:   Wed, 12 May 2021 14:44:26 +0800
Message-Id: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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
index 708f430af1c4..f1742da42478 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2525,9 +2525,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct device *dev,
 				    u32 pasid)
 {
-	int flags = PASID_FLAG_SUPERVISOR_MODE;
 	struct dma_pte *pgd = domain->pgd;
 	int agaw, level;
+	int flags = 0;
 
 	/*
 	 * Skip top levels of page tables for iommu which has
@@ -2543,7 +2543,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level != 4 && level != 5)
 		return -EINVAL;
 
-	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
+	if (pasid != PASID_RID2PASID)
+		flags |= PASID_FLAG_SUPERVISOR_MODE;
+	if (level == 5)
+		flags |= PASID_FLAG_FL5LP;
 
 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
 		flags |= PASID_FLAG_PAGE_SNOOP;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 72646bafc52f..72dc84821dad 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -699,7 +699,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
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

