Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70539342A22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 04:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhCTDED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 23:04:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:61111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhCTDDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 23:03:43 -0400
IronPort-SDR: wdYKCDzgbnILfprHhai/4zCS9oLPHapeyOYn8PZYZHkfPLmKuPAn5uonGcuR2+sjx+AMskouxc
 BcHD3n5m2m+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186661571"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186661571"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 20:03:43 -0700
IronPort-SDR: nADkqDnUmm43RghzXn8GdGtmdOHcoX52L/+9g9FBZUmYrL5SHI9dwOH9Yz/Ty/hSMCKMrclVo6
 Y9ByZJiRqnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441520645"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 20:03:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v2 2/5] iommu/vt-d: Remove WO permissions on second-level paging entries
Date:   Sat, 20 Mar 2021 10:54:12 +0800
Message-Id: <20210320025415.641201-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320025415.641201-1-baolu.lu@linux.intel.com>
References: <20210320025415.641201-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the first level page table is used for IOVA translation, it only
supports Read-Only and Read-Write permissions. The Write-Only permission
is not supported as the PRESENT bit (implying Read permission) should
always set. When using second level, we still give separate permissions
that allows WriteOnly which seems inconsistent and awkward. We want to
have consistent behavior. After moving to 1st level, we don't want things
to work sometimes, and break if we use 2nd level for the same mappings.
Hence remove this configuration.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 167219ea8d70..132cbf9f214f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2304,8 +2304,9 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		return -EINVAL;
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
+	attr |= DMA_FL_PTE_PRESENT;
 	if (domain_use_first_level(domain)) {
-		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD | DMA_FL_PTE_US;
+		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
 		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
 			attr |= DMA_FL_PTE_ACCESS;
-- 
2.25.1

