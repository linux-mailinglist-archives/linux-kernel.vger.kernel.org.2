Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8832AD57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382396AbhCBVpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:45:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:46626 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581330AbhCBSuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:50:35 -0500
IronPort-SDR: WhfO6RHApUrurbpUeFbaYEA/mG6LDheLz3GdP3e9zilJzFNZQyl2Ex/n8MZIvL8NM1Ubke9SuY
 /IPgpOA3/b3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="186272519"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="186272519"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 10:45:47 -0800
IronPort-SDR: yctoz7wOsaC6ovQ6iA1L2smLEcz6NgqtoM1gGgSvh2YtEvSBqFMgiDcqP+UMGRUGVzIs8+kC6A
 o4OvWFwrvMCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="406158807"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 10:45:47 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [PATCH v2 2/4] iommu/vt-d: Enable write protect propagation from guest
Date:   Tue,  2 Mar 2021 02:13:58 -0800
Message-Id: <1614680040-1989-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/intel/pasid.c | 3 +++
 include/uapi/linux/iommu.h  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0b7e0e726ade..b7e39239f539 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -763,6 +763,9 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
 			return -EINVAL;
 		}
 		pasid_set_sre(pte);
+		/* Enable write protect WP if guest requested */
+		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE)
+			pasid_set_wpe(pte);
 	}
 
 	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 35d48843acd8..3a9164cc9937 100644
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

