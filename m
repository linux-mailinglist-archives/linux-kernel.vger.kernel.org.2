Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166432AD63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837504AbhCBVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:47:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:46629 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378826AbhCBSya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:54:30 -0500
IronPort-SDR: l2GZe6xmKQ6/X5xYJeO5IanWi0VXuzC3jm6Ybsleed2RtaLZY3hUv6kq1Wu7IGHV/aDjsaqh8c
 IV/Lr1IUeAHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="186272516"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="186272516"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 10:45:47 -0800
IronPort-SDR: gbFYMDzugxJODBT+rPNQAgb/NGNuRbUxTazH2uMYYilnnA+eOY4uct7JsTJzK9GJQH4VYIADd/
 sRM5pMA4jqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="406158803"
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
Subject: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor SVM
Date:   Tue,  2 Mar 2021 02:13:57 -0800
Message-Id: <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

