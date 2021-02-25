Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50A324A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhBYGjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:39:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:22399 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233618AbhBYGjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:39:07 -0500
IronPort-SDR: e4R1r0YdC8uZ9T/0EmRPTbsbIqGyraqmVrNQoDwXfEBiBLUjXDETEZbAPZoENL5FQJJVOSoqes
 hhiEb/4Blskw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="246838694"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="246838694"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:36:09 -0800
IronPort-SDR: zQBp+o/NyfHIG8/7LC1ul7d39A0VmCYqs76ZWVuLikz0kjMnRukB+72vAuXpEIQVg9ZipiRd9p
 ZS3IKlhZDQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="499965342"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:36:07 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Avoid unnecessary cache flush in pasid entry teardown
Date:   Thu, 25 Feb 2021 14:26:54 +0800
Message-Id: <20210225062654.2864322-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a present pasid entry is disassembled, all kinds of pasid related
caches need to be flushed. But when a pasid entry is not being used
(PRESENT bit not set), we don't need to do this. Check the PRESENT bit
in intel_pasid_tear_down_entry() and avoid flushing caches if it's not
set.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 07531e5edfa2..9fb3d3e80408 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -493,6 +493,9 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	if (WARN_ON(!pte))
 		return;
 
+	if (!(pte->val[0] & PASID_PTE_PRESENT))
+		return;
+
 	did = pasid_get_domain_id(pte);
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
 
-- 
2.25.1

