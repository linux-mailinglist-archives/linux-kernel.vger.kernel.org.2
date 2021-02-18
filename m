Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B530A31F4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSGEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:04:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:39731 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhBSGES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:04:18 -0500
IronPort-SDR: 2snYTuk1JZAAr6L7sdKo6l4NMKUhNi5TeopzL/D8dKCNGUVfC9p8yhQoKLSvld7rg23UD8+kVO
 u+7jhhv1+qow==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="171424153"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171424153"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 22:02:29 -0800
IronPort-SDR: iGS3uvHw9fSFwsAwfvfzOL8FMbWuBmMZsgsbUE9NHDkNfLXyws1lOf/lkqjzSz/1Fyj3dys3Lz
 oeWXBxCctg5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="362829348"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2021 22:02:29 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from guest
Date:   Thu, 18 Feb 2021 13:31:16 -0800
Message-Id: <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write protect bit, when set, inhibits supervisor writes to the read-only
pages. In guest supervisor shared virtual addressing (SVA), write-protect
should be honored upon guest bind supervisor PASID request.

This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP bit.

Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 5 +++++
 include/uapi/linux/iommu.h  | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0b7e0e726ade..c7a2ec930af4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
 			return -EINVAL;
 		}
 		pasid_set_sre(pte);
+		/* Enable write protect WP if guest requested */
+		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
+			if (pasid_enable_wpe(pte))
+				return -EINVAL;
+		}
 	}
 
 	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 68cb558fe8db..33f3dc7a91de 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
 #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
 #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
 #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
-#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
+#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect enable */
+#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
 	__u64 flags;
 	__u32 pat;
 	__u32 emt;
-- 
2.25.1

