Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C030418865
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhIZLuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 07:50:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:50513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZLuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 07:50:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="224393317"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="224393317"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 04:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="475640103"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:13 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/3] iommu/vt-d: Remove duplicate identity domain flag
Date:   Sun, 26 Sep 2021 19:45:33 +0800
Message-Id: <20210926114535.923263-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926114535.923263-1-baolu.lu@linux.intel.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu_domain data structure already has the "type" field to keep the
type of a domain. It's unnecessary to have the DOMAIN_FLAG_STATIC_IDENTITY
flag in the vt-d implementation. This cleans it up with no functionality
change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h | 3 ---
 drivers/iommu/intel/iommu.c | 9 ++++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4bff70c26416..c24bdf5a9285 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -517,9 +517,6 @@ struct context_entry {
 	u64 hi;
 };
 
-/* si_domain contains mulitple devices */
-#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
-
 /*
  * When VT-d works in the scalable mode, it allows DMA translation to
  * happen through either first level or second level page table. This
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b0076f54f5f4..dc2030d014e0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -528,7 +528,7 @@ static inline void free_devinfo_mem(void *vaddr)
 
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
-	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
+	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
 static inline bool domain_use_first_level(struct dmar_domain *domain)
@@ -1996,7 +1996,7 @@ static bool first_level_by_default(void)
 	return scalable_mode_support() && intel_cap_flts_sanity();
 }
 
-static struct dmar_domain *alloc_domain(int flags)
+static struct dmar_domain *alloc_domain(unsigned int type)
 {
 	struct dmar_domain *domain;
 
@@ -2006,7 +2006,6 @@ static struct dmar_domain *alloc_domain(int flags)
 
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
-	domain->flags = flags;
 	if (first_level_by_default())
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
@@ -2830,7 +2829,7 @@ static int __init si_domain_init(int hw)
 	struct device *dev;
 	int i, nid, ret;
 
-	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
+	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
 
@@ -4639,7 +4638,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
 	case IOMMU_DOMAIN_UNMANAGED:
-		dmar_domain = alloc_domain(0);
+		dmar_domain = alloc_domain(type);
 		if (!dmar_domain) {
 			pr_err("Can't allocate dmar_domain\n");
 			return NULL;
-- 
2.25.1

