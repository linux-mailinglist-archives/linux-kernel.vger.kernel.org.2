Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D146C3824DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhEQG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:59:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:26751 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhEQG73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:59:29 -0400
IronPort-SDR: E4SfaUHUvGvIp6H6efLGsRohdK40UA8HyguyORcFNtaYwv0M52YmdKp4yINprZ8F8oZhUtClil
 M9RRVZEkyIaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="221430489"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="221430489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:58:13 -0700
IronPort-SDR: +b6iXjPOeWDE8Px4zL1yzWrOmREE6ePkVz2Y2PBNBs2OiJl1JmKjcdhmIFaw6A7AIdyxdioW8g
 lzhjTKuTNekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="460174368"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2021 23:57:54 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Support asynchronous IOMMU nested capabilities
Date:   Mon, 17 May 2021 14:57:01 +0800
Message-Id: <20210517065701.5078-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current VT-d implementation supports nested translation only if all
underlying IOMMUs support the nested capability. This is unnecessary
as the upper layer is allowed to create different containers and set
them with different type of iommu backend. The IOMMU driver needs to
guarantee that devices attached to a nested mode iommu_domain should
support nested capabilility.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Change log:
v1->v2:
  - Remove unnecessary global capability check

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f1742da42478..00c6611ee839 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4755,6 +4755,13 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
+	    !ecap_nest(iommu->ecap)) {
+		dev_err(dev, "%s: iommu not support nested translation\n",
+			iommu->name);
+		return -EINVAL;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5455,7 +5462,7 @@ intel_iommu_enable_nesting(struct iommu_domain *domain)
 	int ret = -ENODEV;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	if (nested_mode_support() && list_empty(&dmar_domain->devices)) {
+	if (list_empty(&dmar_domain->devices)) {
 		dmar_domain->flags |= DOMAIN_FLAG_NESTING_MODE;
 		dmar_domain->flags &= ~DOMAIN_FLAG_USE_FIRST_LEVEL;
 		ret = 0;
-- 
2.25.1

