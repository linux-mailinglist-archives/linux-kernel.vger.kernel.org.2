Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B331F4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSGGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:06:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:39881 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSGGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:06:04 -0500
IronPort-SDR: ItsY0Gv6F3p0OVIIWgZSFZEKA9J6EUy7LSsyNa8+RuR2m7s5zINXVHZv6vE6IQZs9ROqFRDD5o
 eAvCwyBoDlcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="171424152"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171424152"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 22:02:29 -0800
IronPort-SDR: q5sM8qjyrdiqLebPhYkAic93/sddjrQ8IqEV49ww5JS2AxoW1ah9ipbTfL3+8cWY6Y9uQwbXRG
 hGCwvhHxQbjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="362829344"
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
Subject: [PATCH 1/4] iommu/vt-d: Enable write protect for supervisor SVM
Date:   Thu, 18 Feb 2021 13:31:15 -0800
Message-Id: <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write protect bit, when set, inhibits supervisor writes to the read-only
pages. In supervisor shared virtual addressing (SVA), where page tables
are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
CR0.WP bit in the CPU.
This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.

Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0cceaabc3ce6..0b7e0e726ade 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -410,6 +410,15 @@ static inline void pasid_set_sre(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[2], 1 << 0, 1);
 }
 
+/*
+ * Setup the WPE(Write Protect Enable) field (Bit 132) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_wpe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
+}
+
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
@@ -553,6 +562,20 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 	}
 }
 
+static inline int pasid_enable_wpe(struct pasid_entry *pte)
+{
+	unsigned long cr0 = read_cr0();
+
+	/* CR0.WP is normally set but just to be sure */
+	if (unlikely(!(cr0 & X86_CR0_WP))) {
+		pr_err_ratelimited("No CPU write protect!\n");
+		return -EINVAL;
+	}
+	pasid_set_wpe(pte);
+
+	return 0;
+};
+
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -584,6 +607,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 			return -EINVAL;
 		}
 		pasid_set_sre(pte);
+		if (pasid_enable_wpe(pte))
+			return -EINVAL;
+
 	}
 
 	if (flags & PASID_FLAG_FL5LP) {
-- 
2.25.1

