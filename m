Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74BD418868
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIZLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 07:50:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:50513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhIZLuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 07:50:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="224393320"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="224393320"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 04:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="475640118"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:18 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/3] iommu/vt-d: Use second level for GPA->HPA translation
Date:   Sun, 26 Sep 2021 19:45:35 +0800
Message-Id: <20210926114535.923263-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926114535.923263-1-baolu.lu@linux.intel.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU VT-d implementation uses the first level for GPA->HPA translation
by default. Although both the first level and the second level could handle
the DMA translation, they're different in some way. For example, the second
level translation has separate controls for the Access/Dirty page tracking.
With the first level translation, there's no such control. On the other
hand, the second level translation has the page-level control for forcing
snoop, but the first level only has global control with pasid granularity.

This uses the second level for GPA->HPA translation so that we can provide
a consistent hardware interface for use cases like dirty page tracking for
live migration.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dc2030d014e0..426630261614 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1991,9 +1991,15 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  * Check and return whether first level is used by default for
  * DMA translation.
  */
-static bool first_level_by_default(void)
+static bool first_level_by_default(unsigned int type)
 {
-	return scalable_mode_support() && intel_cap_flts_sanity();
+	if (!scalable_mode_support())
+		return false;
+
+	if (intel_cap_flts_sanity() ^ intel_cap_slts_sanity())
+		return intel_cap_flts_sanity();
+
+	return type != IOMMU_DOMAIN_UNMANAGED;
 }
 
 static struct dmar_domain *alloc_domain(unsigned int type)
@@ -2006,7 +2012,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
-	if (first_level_by_default())
+	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
-- 
2.25.1

