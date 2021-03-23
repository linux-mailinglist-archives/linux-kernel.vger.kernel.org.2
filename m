Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF33454D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhCWBQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:21999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhCWBPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:45 -0400
IronPort-SDR: hTiU4NN6wooHsNwPub/tneW07DCgNZztpBD8pzTwmMWic6EchyiCE9svZRDCTxLHqf80iFHP+2
 O2CHm64kpSZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210455659"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210455659"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:15:45 -0700
IronPort-SDR: HpKNHSiD+2UsfsqyxBTbitDphh8WIpiC3L7NItgAzn9jwje4HKDlz1anOtast1Fh0R3vyYO8w/
 8192iuNHMsBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435362476"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/5] iommu/vt-d: Remove unused function declarations
Date:   Tue, 23 Mar 2021 09:05:59 +0800
Message-Id: <20210323010600.678627-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions have been deprecated. Remove the remaining function
delarations.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 444c0bec221a..90a3268d7a77 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -99,9 +99,6 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 }
 
 extern unsigned int intel_pasid_max_id;
-int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
-void intel_pasid_free_id(u32 pasid);
-void *intel_pasid_lookup_id(u32 pasid);
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
-- 
2.25.1

