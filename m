Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B9447A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 07:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhKHGVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 01:21:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:43721 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhKHGVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 01:21:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="295611078"
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="295611078"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 22:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="491091846"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2021 22:18:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashish Mhetre <amhetre@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com,
        ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Extend mutex lock scope in iommu_probe_device()
Date:   Mon,  8 Nov 2021 14:13:49 +0800
Message-Id: <20211108061349.1985579-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the scope of holding group->mutex so that it can cover the default
domain check/attachment and direct mappings of reserved regions.

Cc: Ashish Mhetre <amhetre@nvidia.com>
Fixes: 211ff31b3d33b ("iommu: Fix race condition during default domain allocation")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd7863e453a5..8b86406b7162 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -288,11 +288,11 @@ int iommu_probe_device(struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
-	mutex_unlock(&group->mutex);
 
 	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
+			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
 			goto err_release;
 		}
@@ -300,6 +300,7 @@ int iommu_probe_device(struct device *dev)
 
 	iommu_create_device_direct_mappings(group, dev);
 
+	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
 	if (ops->probe_finalize)
-- 
2.25.1

