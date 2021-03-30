Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3F34DE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhC3CVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:21:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:15998 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhC3CVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:21:15 -0400
IronPort-SDR: D3WEz1tBrQ9kcqxpGiorTWhMhT/nz8wft6oxetq2s8U+avAvMpe2QATRA/Iho1XM4J6rUGbJr4
 OJ3MnXLI/Tkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="189419677"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="189419677"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:21:15 -0700
IronPort-SDR: thY1xfMfCudyvHP/ptJA+h7xWnv+Pj6Sc/+E9k1g0KfRjBNmUTJC6nd5d0D8fbHgozlg0ZW1i9
 WziO4JM2DcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="444879565"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2021 19:21:13 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com,
        rajesh.sankaran@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Report right snoop capability when using FL for IOVA
Date:   Tue, 30 Mar 2021 10:11:45 +0800
Message-Id: <20210330021145.13824-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel VT-d driver checks wrong register to report snoop capablility
when using first level page table for GPA to HPA translation. This might
lead the IOMMU driver to say that it supports snooping control, but in
reality, it does not. Fix this by always setting PASID-table-entry.PGSNP
whenever a pasid entry is setting up for GPA to HPA translation so that
the IOMMU driver could report snoop capability as long as it runs in the
scalable mode.

Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Suggested-by: Rajesh Sankaran <rajesh.sankaran@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  1 +
 drivers/iommu/intel/iommu.c | 11 ++++++++++-
 drivers/iommu/intel/pasid.c | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 079534fcf55d..5ff61c3d401f 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -48,6 +48,7 @@
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
 #define PASID_FLAG_NESTED		BIT(1)
+#define PASID_FLAG_PAGE_SNOOP		BIT(2)
 
 /*
  * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7354f9ce47d8..deaa87ad4e5f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -657,7 +657,14 @@ static int domain_update_iommu_snooping(struct intel_iommu *skip)
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
 		if (iommu != skip) {
-			if (!ecap_sc_support(iommu->ecap)) {
+			/*
+			 * If the hardware is operating in the scalable mode,
+			 * the snooping control is always supported since we
+			 * always set PASID-table-entry.PGSNP bit if the domain
+			 * is managed outside (UNMANAGED).
+			 */
+			if (!sm_supported(iommu) &&
+			    !ecap_sc_support(iommu->ecap)) {
 				ret = 0;
 				break;
 			}
@@ -2516,6 +2523,8 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 		flags |= PASID_FLAG_SUPERVISOR_MODE;
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
+	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+		flags |= PASID_FLAG_PAGE_SNOOP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
 					     domain->iommu_did[iommu->seq_id],
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c896aef7db40..b901909da79e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -425,6 +425,16 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
+/*
+ * Setup the Page Snoop (PGSNP) field (Bit 88) of a scalable mode
+ * PASID entry.
+ */
+static inline void
+pasid_set_pgsnp(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1ULL << 24, 1ULL << 24);
+}
+
 /*
  * Setup the First Level Page table Pointer field (Bit 140~191)
  * of a scalable mode PASID entry.
@@ -599,6 +609,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
+	if (flags & PASID_FLAG_PAGE_SNOOP)
+		pasid_set_pgsnp(pte);
+
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
@@ -677,6 +690,9 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
+	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+		pasid_set_pgsnp(pte);
+
 	/*
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
-- 
2.25.1

