Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518C43824D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhEQG4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:56:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:44899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEQG4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:56:44 -0400
IronPort-SDR: jAUYmO+lT3PwvRpX6CSZgDIzHKeJ7t5CqxhdhparXXlq1EX4jxPtCM0kHF7najQFPh+uhi+hQc
 WqPdu04Dv5hQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200449440"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="200449440"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:55:25 -0700
IronPort-SDR: KeXez7K1RYKXJwlOE1fJAV0gc9GZTGTEZb8gsphTouGsZIjMSV3CccSWBhidmZyMrkZkiYLTSK
 T7SF46e1K7AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="460173873"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2021 23:55:22 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Tweak the description of a DMA fault
Date:   Mon, 17 May 2021 14:54:25 +0800
Message-Id: <20210517065425.4953-1-baolu.lu@linux.intel.com>
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
This is confusing. Tweak this by adding "NO_PASID" explicitly.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

Change log:
v1->v2:
 - Add "0x" prefix to all hex numbers

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1757ac1e1623..1e31e6799d5c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1911,16 +1911,23 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02d] %s\n",
-			source_id >> 8, PCI_SLOT(source_id & 0xFF),
-			PCI_FUNC(source_id & 0xFF), addr >> 48,
-			fault_reason, reason);
-	else
-		pr_err("[%s] Request device [%02x:%02x.%d] PASID %x fault addr %llx [fault reason %02d] %s\n",
+		pr_err("[INTR-REMAP] Request device [0x%02x:0x%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		       PCI_FUNC(source_id & 0xFF), addr >> 48,
+		       fault_reason, reason);
+	else if (pasid == INVALID_IOASID)
+		pr_err("[%s NO_PASID] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), pasid, addr,
+		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
+	else
+		pr_err("[%s PASID 0x%x] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		       type ? "DMA Read" : "DMA Write", pasid,
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		       PCI_FUNC(source_id & 0xFF), addr,
+		       fault_reason, reason);
+
 	return 0;
 }
 
@@ -1987,7 +1994,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : -1,
+					  pasid_present ? pasid : INVALID_IOASID,
 					  source_id, guest_addr);
 
 		fault_index++;
-- 
2.25.1

