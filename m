Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC72324A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhBYGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:37:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:22397 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbhBYGhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:37:43 -0500
IronPort-SDR: BH8jPSW4l/ewPMZTMe98s9OxV4EnH/Hm7XdGm7aKNGuEdgeeme6RXroUUQm+Mtfw6jKmvpYya4
 /aib4DhYwimw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="246838623"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="246838623"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:35:57 -0800
IronPort-SDR: hqBfn55cAHG2xvl0XbZBQ6CN2UP3n2oXQj3i7cmwE35nk8tykC2iM/qy6JCBKCZGCq05eeksT0
 dA8lfYJKeMEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="499965252"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:35:54 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Report the right page fault address
Date:   Thu, 25 Feb 2021 14:26:50 +0800
Message-Id: <20210225062654.2864322-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Address field of the Page Request Descriptor only keeps bit [63:12]
of the offending address. Convert it to a full address before reporting
it to device drivers.

Fixes: eb8d93ea3c1d3 ("iommu/vt-d: Report page request faults for guest SVA")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 574a7e657a9a..d76cc79f3496 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -862,7 +862,7 @@ intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
 	/* Fill in event data for device specific processing */
 	memset(&event, 0, sizeof(struct iommu_fault_event));
 	event.fault.type = IOMMU_FAULT_PAGE_REQ;
-	event.fault.prm.addr = desc->addr;
+	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
 	event.fault.prm.pasid = desc->pasid;
 	event.fault.prm.grpid = desc->prg_index;
 	event.fault.prm.perm = prq_to_iommu_prot(desc);
-- 
2.25.1

