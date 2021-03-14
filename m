Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6177833A7C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhCNURx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:17:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:29413 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhCNURd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:17:33 -0400
IronPort-SDR: yfopMLkq3yCrhRJiWgJOTz4Rg/o4GPI+iGmODlcp68s/oryxhf08LShQGePxTp2GVcj7fM2h5h
 N8TnGWkHHzVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="253026618"
X-IronPort-AV: E=Sophos;i="5.81,248,1610438400"; 
   d="scan'208";a="253026618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 13:17:32 -0700
IronPort-SDR: UKg6vP2QaPF9ZOgY1ASKSPGUfhWXxvU9Btffdz5bnN7cCbQjV75xvA49XW6dH5qy0ARtWSewr3
 UhHCUiF6YCaQ==
X-IronPort-AV: E=Sophos;i="5.81,248,1610438400"; 
   d="scan'208";a="411627303"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 13:17:31 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, ravi.v.shankar@intel.com, yian.chen@intel.com,
        sohil.mehta@intel.com, Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH] iommu/vt-d: Disable SVM when ATS/PRI/PASID are not enabled in the device
Date:   Sun, 14 Mar 2021 13:15:34 -0700
Message-Id: <20210314201534.918-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Intel VT-d supports Shared Virtual Memory (SVM) only when
IO page fault is supported. Otherwise, shared memory pages can not be
swapped out and need to be pinned. The device needs the Address Translation
Service (ATS), Page Request Interface (PRI) and Process Address Space
Identifier (PASID) capabilities to be enabled to support IO page fault.

Disable SVM when ATS, PRI and PASID are not enabled in the device.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..956a02eb40b4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5380,6 +5380,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		if (!info)
 			return -EINVAL;
 
+		if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+			return -EINVAL;
+
 		if (info->iommu->flags & VTD_FLAG_SVM_CAPABLE)
 			return 0;
 	}
-- 
2.17.1

