Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C48137B655
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELGwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:52:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:44107 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhELGwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:52:14 -0400
IronPort-SDR: aScTFc9P4hb3QSEAP81nUivpsyaHUdwZp2v7KEuusZFrnXW4HuJ3jVfKMoCi1Cjv0fh+21b2Jv
 kmAyYyM5EoVw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="187063686"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="187063686"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 23:51:06 -0700
IronPort-SDR: XsTo/Mp5oNwxlkxch9HKJo5RnNmsRj4lcs98XirJXSx3J5Zslhf5UN4hxLZTrVZkhGvdadizel
 eTr927OPLNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="537509490"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 23:51:03 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Tweak the description of a DMA fault
Date:   Wed, 12 May 2021 14:50:12 +0800
Message-Id: <20210512065012.3441160-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel IOMMU driver reports the DMA fault reason in a decimal number
while the VT-d specification uses a hexadecimal one. It's inconvenient
that users need to covert them everytime before consulting the spec.
Let's use hexadecimal number for a DMA fault reason.

The fault message uses 0xffffffff as PASID for DMA requests w/o PASID.
This is confusing. Tweak this by adding "w/o PASID" explicitly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1757ac1e1623..11e37d2c2af2 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1911,15 +1911,21 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02d] %s\n",
-			source_id >> 8, PCI_SLOT(source_id & 0xFF),
-			PCI_FUNC(source_id & 0xFF), addr >> 48,
-			fault_reason, reason);
-	else
-		pr_err("[%s] Request device [%02x:%02x.%d] PASID %x fault addr %llx [fault reason %02d] %s\n",
+		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02xh] %s\n",
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		       PCI_FUNC(source_id & 0xFF), addr >> 48,
+		       fault_reason, reason);
+	else if (pasid == INVALID_IOASID)
+		pr_err("[%s w/o PASID] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), pasid, addr,
+		       PCI_FUNC(source_id & 0xFF), addr,
+		       fault_reason, reason);
+	else
+		pr_err("[%s w/ PASID %x] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
+		       type ? "DMA Read" : "DMA Write", pasid,
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 	return 0;
 }
@@ -1987,7 +1993,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : -1,
+					  pasid_present ? pasid : INVALID_IOASID,
 					  source_id, guest_addr);
 
 		fault_index++;
-- 
2.25.1

