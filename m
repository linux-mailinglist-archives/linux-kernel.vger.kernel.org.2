Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8030979F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhA3Sqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:46:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:15035 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhA3SqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:46:25 -0500
IronPort-SDR: B6LuqG9RUeOmhD2ybVpqjfpok0zea/4nxYtKRM/pFP6v6V0zn0RTKKdK/ByzHQfjMvvI9+fp9w
 eni+8lcrCVPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="265377341"
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="265377341"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 10:45:28 -0800
IronPort-SDR: tMpFrlz3725YJbL8uwg4zc/kmZY9wtpWELTiBxJDEas8/WeWlJRMahVxUPzBzmy/Qwd+4zQoXf
 Q4x56jkAqxpg==
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="580053462"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 10:45:28 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, ricardo.neri@intel.com, ravi.v.shankar@intel.com,
        kevin.tian@intel.com, ashok.raj@intel.com, sohil.mehta@intel.com,
        kyung.min.park@intel.com
Subject: [PATCH v5 1/2] iommu/vt-d: Audit IOMMU Capabilities and add helper functions
Date:   Sat, 30 Jan 2021 10:44:51 -0800
Message-Id: <20210130184452.31711-2-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130184452.31711-1-kyung.min.park@intel.com>
References: <20210130184452.31711-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit IOMMU Capability/Extended Capability and check if the IOMMUs have
the consistent value for features. Report out or scale to the lowest
supported when IOMMU features have incompatibility among IOMMUs.

Report out features when below features are mismatched:
  - First Level 5 Level Paging Support (FL5LP)
  - First Level 1 GByte Page Support (FL1GP)
  - Read Draining (DRD)
  - Write Draining (DWD)
  - Page Selective Invalidation (PSI)
  - Zero Length Read (ZLR)
  - Caching Mode (CM)
  - Protected High/Low-Memory Region (PHMR/PLMR)
  - Required Write-Buffer Flushing (RWBF)
  - Advanced Fault Logging (AFL)
  - RID-PASID Support (RPS)
  - Scalable Mode Page Walk Coherency (SMPWC)
  - First Level Translation Support (FLTS)
  - Second Level Translation Support (SLTS)
  - No Write Flag Support (NWFS)
  - Second Level Accessed/Dirty Support (SLADS)
  - Virtual Command Support (VCS)
  - Scalable Mode Translation Support (SMTS)
  - Device TLB Invalidation Throttle (DIT)
  - Page Drain Support (PDS)
  - Process Address Space ID Support (PASID)
  - Extended Accessed Flag Support (EAFS)
  - Supervisor Request Support (SRS)
  - Execute Request Support (ERS)
  - Page Request Support (PRS)
  - Nested Translation Support (NEST)
  - Snoop Control (SC)
  - Pass Through (PT)
  - Device TLB Support (DT)
  - Queued Invalidation (QI)
  - Page walk Coherency (C)

Set capability to the lowest supported when below features are mismatched:
  - Maximum Address Mask Value (MAMV)
  - Number of Fault Recording Registers (NFR)
  - Second Level Large Page Support (SLLPS)
  - Fault Recording Offset (FRO)
  - Maximum Guest Address Width (MGAW)
  - Supported Adjusted Guest Address Width (SAGAW)
  - Number of Domains supported (NDOMS)
  - Pasid Size Supported (PSS)
  - Maximum Handle Mask Value (MHMV)
  - IOTLB Register Offset (IRO)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/Makefile        |   4 +-
 drivers/iommu/intel/cap_audit.c     | 185 ++++++++++++++++++++++++++++
 drivers/iommu/intel/cap_audit.h     | 110 +++++++++++++++++
 drivers/iommu/intel/iommu.c         |   9 ++
 drivers/iommu/intel/irq_remapping.c |   8 ++
 include/linux/intel-iommu.h         |  39 +++---
 6 files changed, 335 insertions(+), 20 deletions(-)
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fb8e1e8c8029..1e576c840175 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
-obj-$(CONFIG_INTEL_IOMMU) += trace.o
+obj-$(CONFIG_INTEL_IOMMU) += trace.o cap_audit.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
-obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
+obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o cap_audit.o
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
new file mode 100644
index 000000000000..049bc0c76a00
--- /dev/null
+++ b/drivers/iommu/intel/cap_audit.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cap_audit.c - audit iommu capabilities for boot time and hot plug
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Kyung Min Park <kyung.min.park@intel.com>
+ *         Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/intel-iommu.h>
+#include "cap_audit.h"
+
+static u64 intel_iommu_cap_sanity;
+static u64 intel_iommu_ecap_sanity;
+
+static inline void check_irq_capabilities(struct intel_iommu *a,
+					  struct intel_iommu *b)
+{
+	CHECK_FEATURE_MISMATCH(a, b, cap, pi_support, CAP_PI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, eim_support, ECAP_EIM_MASK);
+}
+
+static inline void check_dmar_capabilities(struct intel_iommu *a,
+					   struct intel_iommu *b)
+{
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MAMV_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_NFR_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SLLPS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_FRO_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MGAW_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SAGAW_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_NDOMS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_PSS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_MHMV_MASK);
+	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_IRO_MASK);
+
+	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, write_drain, CAP_WD_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, pgsel_inv, CAP_PSI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, zlr, CAP_ZLR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, caching_mode, CAP_CM_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, phmr, CAP_PHMR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, plmr, CAP_PLMR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, rwbf, CAP_RWBF_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, afl, CAP_AFL_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, rps, ECAP_RPS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, smpwc, ECAP_SMPWC_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, flts, ECAP_FLTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, slts, ECAP_SLTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, nwfs, ECAP_NWFS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, slads, ECAP_SLADS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, vcs, ECAP_VCS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, smts, ECAP_SMTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pds, ECAP_PDS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, dit, ECAP_DIT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pasid, ECAP_PASID_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, eafs, ECAP_EAFS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, srs, ECAP_SRS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, ers, ECAP_ERS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, prs, ECAP_PRS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, nest, ECAP_NEST_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, mts, ECAP_MTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, sc_support, ECAP_SC_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pass_through, ECAP_PT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, dev_iotlb_support, ECAP_DT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, qis, ECAP_QI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, coherent, ECAP_C_MASK);
+}
+
+static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type)
+{
+	bool mismatch = false;
+	u64 old_cap = intel_iommu_cap_sanity;
+	u64 old_ecap = intel_iommu_ecap_sanity;
+
+	if (type == CAP_AUDIT_HOTPLUG_IRQR) {
+		CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, pi_support, CAP_PI_MASK);
+		CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, eim_support, ECAP_EIM_MASK);
+		goto out;
+	}
+
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, read_drain, CAP_RD_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, write_drain, CAP_WD_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, pgsel_inv, CAP_PSI_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, zlr, CAP_ZLR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, caching_mode, CAP_CM_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, phmr, CAP_PHMR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, plmr, CAP_PLMR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, rwbf, CAP_RWBF_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, afl, CAP_AFL_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, rps, ECAP_RPS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, smpwc, ECAP_SMPWC_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, flts, ECAP_FLTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slts, ECAP_SLTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, nwfs, ECAP_NWFS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slads, ECAP_SLADS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, vcs, ECAP_VCS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, smts, ECAP_SMTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pds, ECAP_PDS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, dit, ECAP_DIT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pasid, ECAP_PASID_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, eafs, ECAP_EAFS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, srs, ECAP_SRS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, ers, ECAP_ERS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, prs, ECAP_PRS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, nest, ECAP_NEST_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, mts, ECAP_MTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, sc_support, ECAP_SC_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pass_through, ECAP_PT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, dev_iotlb_support, ECAP_DT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, qis, ECAP_QI_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, coherent, ECAP_C_MASK);
+
+	/* Abort hot plug if the hot plug iommu feature is smaller than global */
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, max_amask_val, CAP_MAMV_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, num_fault_regs, CAP_NFR_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, super_page_val, CAP_SLLPS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, fault_reg_offset, CAP_FRO_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, mgaw, CAP_MGAW_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, sagaw, CAP_SAGAW_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, cap, ndoms, CAP_NDOMS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, pss, ECAP_PSS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, max_handle_mask, ECAP_MHMV_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, iotlb_offset, ECAP_IRO_MASK, mismatch);
+
+out:
+	if (mismatch) {
+		intel_iommu_cap_sanity = old_cap;
+		intel_iommu_ecap_sanity = old_ecap;
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
+{
+	struct dmar_drhd_unit *d;
+	struct intel_iommu *i;
+
+	rcu_read_lock();
+	if (list_empty(&dmar_drhd_units))
+		goto out;
+
+	for_each_active_iommu(i, d) {
+		if (!iommu) {
+			intel_iommu_ecap_sanity = i->ecap;
+			intel_iommu_cap_sanity = i->cap;
+			iommu = i;
+			continue;
+		}
+
+		if (type == CAP_AUDIT_STATIC_DMAR)
+			check_dmar_capabilities(iommu, i);
+		else
+			check_irq_capabilities(iommu, i);
+	}
+
+out:
+	rcu_read_unlock();
+	return 0;
+}
+
+int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
+{
+	switch (type) {
+	case CAP_AUDIT_STATIC_DMAR:
+	case CAP_AUDIT_STATIC_IRQR:
+		return cap_audit_static(iommu, type);
+	case CAP_AUDIT_HOTPLUG_DMAR:
+	case CAP_AUDIT_HOTPLUG_IRQR:
+		return cap_audit_hotplug(iommu, type);
+	default:
+		break;
+	}
+
+	return -EFAULT;
+}
diff --git a/drivers/iommu/intel/cap_audit.h b/drivers/iommu/intel/cap_audit.h
new file mode 100644
index 000000000000..a6a1530441b7
--- /dev/null
+++ b/drivers/iommu/intel/cap_audit.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * cap_audit.h - audit iommu capabilities header
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Kyung Min Park <kyung.min.park@intel.com>
+ */
+
+/*
+ * Capability Register Mask
+ */
+#define CAP_FL5LP_MASK		BIT_ULL(60)
+#define CAP_PI_MASK		BIT_ULL(59)
+#define CAP_FL1GP_MASK		BIT_ULL(56)
+#define CAP_RD_MASK		BIT_ULL(55)
+#define CAP_WD_MASK		BIT_ULL(54)
+#define CAP_MAMV_MASK		GENMASK_ULL(53, 48)
+#define CAP_NFR_MASK		GENMASK_ULL(47, 40)
+#define CAP_PSI_MASK		BIT_ULL(39)
+#define CAP_SLLPS_MASK		GENMASK_ULL(37, 34)
+#define CAP_FRO_MASK		GENMASK_ULL(33, 24)
+#define CAP_ZLR_MASK		BIT_ULL(22)
+#define CAP_MGAW_MASK		GENMASK_ULL(21, 16)
+#define CAP_SAGAW_MASK		GENMASK_ULL(12, 8)
+#define CAP_CM_MASK		BIT_ULL(7)
+#define CAP_PHMR_MASK		BIT_ULL(6)
+#define CAP_PLMR_MASK		BIT_ULL(5)
+#define CAP_RWBF_MASK		BIT_ULL(4)
+#define CAP_AFL_MASK		BIT_ULL(3)
+#define CAP_NDOMS_MASK		GENMASK_ULL(2, 0)
+
+/*
+ * Extended Capability Register Mask
+ */
+#define ECAP_RPS_MASK		BIT_ULL(49)
+#define ECAP_SMPWC_MASK		BIT_ULL(48)
+#define ECAP_FLTS_MASK		BIT_ULL(47)
+#define ECAP_SLTS_MASK		BIT_ULL(46)
+#define ECAP_SLADS_MASK		BIT_ULL(45)
+#define ECAP_VCS_MASK		BIT_ULL(44)
+#define ECAP_SMTS_MASK		BIT_ULL(43)
+#define ECAP_PDS_MASK		BIT_ULL(42)
+#define ECAP_DIT_MASK		BIT_ULL(41)
+#define ECAP_PASID_MASK		BIT_ULL(40)
+#define ECAP_PSS_MASK		GENMASK_ULL(39, 35)
+#define ECAP_EAFS_MASK		BIT_ULL(34)
+#define ECAP_NWFS_MASK		BIT_ULL(33)
+#define ECAP_SRS_MASK		BIT_ULL(31)
+#define ECAP_ERS_MASK		BIT_ULL(30)
+#define ECAP_PRS_MASK		BIT_ULL(29)
+#define ECAP_NEST_MASK		BIT_ULL(26)
+#define ECAP_MTS_MASK		BIT_ULL(25)
+#define ECAP_MHMV_MASK		GENMASK_ULL(23, 20)
+#define ECAP_IRO_MASK		GENMASK_ULL(17, 8)
+#define ECAP_SC_MASK		BIT_ULL(7)
+#define ECAP_PT_MASK		BIT_ULL(6)
+#define ECAP_EIM_MASK		BIT_ULL(4)
+#define ECAP_DT_MASK		BIT_ULL(2)
+#define ECAP_QI_MASK		BIT_ULL(1)
+#define ECAP_C_MASK		BIT_ULL(0)
+
+/*
+ * u64 intel_iommu_cap_sanity, intel_iommu_ecap_sanity will be adjusted as each
+ * IOMMU gets audited.
+ */
+#define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
+do { \
+	if (cap##_##feature(a) != cap##_##feature(b)) { \
+		intel_iommu_##cap##_sanity &= ~(MASK); \
+		pr_info("IOMMU feature %s inconsistent", #feature); \
+	} \
+} while (0)
+
+#define CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
+	DO_CHECK_FEATURE_MISMATCH((a)->cap, (b)->cap, cap, feature, MASK)
+
+#define CHECK_FEATURE_MISMATCH_HOTPLUG(b, cap, feature, MASK) \
+do { \
+	if (cap##_##feature(intel_iommu_##cap##_sanity)) \
+		DO_CHECK_FEATURE_MISMATCH(intel_iommu_##cap##_sanity, \
+					  (b)->cap, cap, feature, MASK); \
+} while (0)
+
+#define MINIMAL_FEATURE_IOMMU(iommu, cap, MASK) \
+do { \
+	u64 min_feature = intel_iommu_##cap##_sanity & (MASK); \
+	min_feature = min_t(u64, min_feature, (iommu)->cap & (MASK)); \
+	intel_iommu_##cap##_sanity = (intel_iommu_##cap##_sanity & ~(MASK)) | \
+				     min_feature; \
+} while (0)
+
+#define MINIMAL_FEATURE_HOTPLUG(iommu, cap, feature, MASK, mismatch) \
+do { \
+	if ((intel_iommu_##cap##_sanity & (MASK)) > \
+	    (cap##_##feature((iommu)->cap))) \
+		mismatch = true; \
+	else \
+		(iommu)->cap = ((iommu)->cap & ~(MASK)) | \
+		(intel_iommu_##cap##_sanity & (MASK)); \
+} while (0)
+
+enum cap_audit_type {
+	CAP_AUDIT_STATIC_DMAR,
+	CAP_AUDIT_STATIC_IRQR,
+	CAP_AUDIT_HOTPLUG_DMAR,
+	CAP_AUDIT_HOTPLUG_IRQR,
+};
+
+int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f665322a0991..861b6b84074d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -48,6 +48,7 @@
 
 #include "../irq_remapping.h"
 #include "pasid.h"
+#include "cap_audit.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -3197,6 +3198,10 @@ static int __init init_dmars(void)
 		goto error;
 	}
 
+	ret = intel_cap_audit(CAP_AUDIT_STATIC_DMAR, NULL);
+	if (ret)
+		goto free_iommu;
+
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
 			iommu_disable_translation(iommu);
@@ -3748,6 +3753,10 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (g_iommus[iommu->seq_id])
 		return 0;
 
+	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
+	if (ret)
+		goto out;
+
 	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
 		pr_warn("%s: Doesn't support hardware pass through.\n",
 			iommu->name);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 685200a5cff0..611ef5243cb6 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -22,6 +22,7 @@
 #include <asm/pci-direct.h>
 
 #include "../irq_remapping.h"
+#include "cap_audit.h"
 
 enum irq_mode {
 	IRQ_REMAPPING,
@@ -734,6 +735,9 @@ static int __init intel_prepare_irq_remapping(void)
 	if (dmar_table_init() < 0)
 		return -ENODEV;
 
+	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
+		goto error;
+
 	if (!dmar_ir_support())
 		return -ENODEV;
 
@@ -1439,6 +1443,10 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	int ret;
 	int eim = x2apic_enabled();
 
+	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_IRQR, iommu);
+	if (ret)
+		return ret;
+
 	if (eim && !ecap_eim_support(iommu->ecap)) {
 		pr_info("DRHD %Lx: EIM not supported by DRHD, ecap %Lx\n",
 			iommu->reg_phys, iommu->ecap);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 09c6a0bf3892..65aa963cc115 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -168,34 +168,37 @@
  * Extended Capability Register
  */
 
+#define	ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_slads(e)		(((e) >> 45) & 0x1)
 #define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
-#define ecap_dit(e)		((e >> 41) & 0x1)
-#define ecap_pasid(e)		((e >> 40) & 0x1)
-#define ecap_pss(e)		((e >> 35) & 0x1f)
-#define ecap_eafs(e)		((e >> 34) & 0x1)
-#define ecap_nwfs(e)		((e >> 33) & 0x1)
-#define ecap_srs(e)		((e >> 31) & 0x1)
-#define ecap_ers(e)		((e >> 30) & 0x1)
-#define ecap_prs(e)		((e >> 29) & 0x1)
-#define ecap_broken_pasid(e)	((e >> 28) & 0x1)
-#define ecap_dis(e)		((e >> 27) & 0x1)
-#define ecap_nest(e)		((e >> 26) & 0x1)
-#define ecap_mts(e)		((e >> 25) & 0x1)
-#define ecap_ecs(e)		((e >> 24) & 0x1)
+#define ecap_dit(e)		(((e) >> 41) & 0x1)
+#define ecap_pds(e)		(((e) >> 42) & 0x1)
+#define ecap_pasid(e)		(((e) >> 40) & 0x1)
+#define ecap_pss(e)		(((e) >> 35) & 0x1f)
+#define ecap_eafs(e)		(((e) >> 34) & 0x1)
+#define ecap_nwfs(e)		(((e) >> 33) & 0x1)
+#define ecap_srs(e)		(((e) >> 31) & 0x1)
+#define ecap_ers(e)		(((e) >> 30) & 0x1)
+#define ecap_prs(e)		(((e) >> 29) & 0x1)
+#define ecap_broken_pasid(e)	(((e) >> 28) & 0x1)
+#define ecap_dis(e)		(((e) >> 27) & 0x1)
+#define ecap_nest(e)		(((e) >> 26) & 0x1)
+#define ecap_mts(e)		(((e) >> 25) & 0x1)
+#define ecap_ecs(e)		(((e) >> 24) & 0x1)
 #define ecap_iotlb_offset(e) 	((((e) >> 8) & 0x3ff) * 16)
 #define ecap_max_iotlb_offset(e) (ecap_iotlb_offset(e) + 16)
 #define ecap_coherent(e)	((e) & 0x1)
 #define ecap_qis(e)		((e) & 0x2)
-#define ecap_pass_through(e)	((e >> 6) & 0x1)
-#define ecap_eim_support(e)	((e >> 4) & 0x1)
-#define ecap_ir_support(e)	((e >> 3) & 0x1)
+#define ecap_pass_through(e)	(((e) >> 6) & 0x1)
+#define ecap_eim_support(e)	(((e) >> 4) & 0x1)
+#define ecap_ir_support(e)	(((e) >> 3) & 0x1)
 #define ecap_dev_iotlb_support(e)	(((e) >> 2) & 0x1)
-#define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
-#define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
+#define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
+#define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
 
 /* Virtual command interface capability */
 #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
-- 
2.17.1

