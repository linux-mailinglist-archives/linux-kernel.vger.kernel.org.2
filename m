Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C453CF190
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbhGTBE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:04:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:17240 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240447AbhGTBAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:00:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211219365"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="211219365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 18:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453887557"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 18:41:24 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Preset A/D bits for user space DMA usage
Date:   Tue, 20 Jul 2021 09:38:54 +0800
Message-Id: <20210720013856.4143880-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We preset the access and dirty bits for IOVA over first level usage only
for the kernel DMA (i.e., when domain type is IOMMU_DOMAIN_DMA). We should
also preset the FL A/D for user space DMA usage. The idea is that even the
user space A/D bit memory write is unnecessary. We should avoid it to
minimize the overhead.

Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1131b8efb050..f45c80ce2381 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2339,13 +2339,9 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
 	if (domain_use_first_level(domain)) {
-		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
-
-		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
-			attr |= DMA_FL_PTE_ACCESS;
-			if (prot & DMA_PTE_WRITE)
-				attr |= DMA_FL_PTE_DIRTY;
-		}
+		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
+		if (prot & DMA_PTE_WRITE)
+			attr |= DMA_FL_PTE_DIRTY;
 	}
 
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
-- 
2.25.1

