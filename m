Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA7342A21
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 04:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCTDEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 23:04:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:61111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCTDDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 23:03:41 -0400
IronPort-SDR: bWeGWmWSADqM3thQAs8MrboL7HSGK5ikX//T38D4Jt4DwI7sfLSjhc6qGU8R8jihYOYoURHaST
 ka6ipK2ZsDGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186661566"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186661566"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 20:03:41 -0700
IronPort-SDR: fpiwkw3yLR7fHZ7LNe40p5sIt6bwUWLCEd++a0XDi3ZDN6QxYEYb4aQjcqQNwZxbVJO3+oTG2L
 /dn9zWPxNc9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441520639"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 20:03:39 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/5] iommu/vt-d: Report the right page fault address
Date:   Sat, 20 Mar 2021 10:54:11 +0800
Message-Id: <20210320025415.641201-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320025415.641201-1-baolu.lu@linux.intel.com>
References: <20210320025415.641201-1-baolu.lu@linux.intel.com>
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
index 54db58945c2d..677d7f6b43bb 100644
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

