Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18503CF18F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhGTBEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:04:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:17234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240470AbhGTBAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:00:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211219352"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="211219352"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 18:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453887547"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 18:41:19 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Refactor Kconfig a bit
Date:   Tue, 20 Jul 2021 09:38:52 +0800
Message-Id: <20210720013856.4143880-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put all sub-options inside a "if INTEL_IOMMU" so that they don't need to
always depend on INTEL_IOMMU. Use IS_ENABLED() instead of #ifdef as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 13 ++-----------
 drivers/iommu/intel/Kconfig | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8c116fe071a2..0440a1850b63 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -327,17 +327,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova);
 
-#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
-int dmar_disabled = 0;
-#else
-int dmar_disabled = 1;
-#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
-
-#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
-int intel_iommu_sm = 1;
-#else
-int intel_iommu_sm;
-#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
+int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
+int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 43ebd8af11c5..c1a92c3049d0 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -25,9 +25,11 @@ config INTEL_IOMMU
 	  and include PCI device scope covered by these DMA
 	  remapping devices.
 
+if INTEL_IOMMU
+
 config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
-	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+	depends on IOMMU_DEBUGFS
 	select DMAR_PERF
 	help
 	  !!!WARNING!!!
@@ -41,7 +43,7 @@ config INTEL_IOMMU_DEBUGFS
 
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
-	depends on INTEL_IOMMU && X86_64
+	depends on X86_64
 	select PCI_PASID
 	select PCI_PRI
 	select MMU_NOTIFIER
@@ -53,9 +55,8 @@ config INTEL_IOMMU_SVM
 	  means of a Process Address Space ID (PASID).
 
 config INTEL_IOMMU_DEFAULT_ON
-	def_bool y
-	prompt "Enable Intel DMA Remapping Devices by default"
-	depends on INTEL_IOMMU
+	bool "Enable Intel DMA Remapping Devices by default"
+	default y
 	help
 	  Selecting this option will enable a DMAR device at boot time if
 	  one is found. If this option is not selected, DMAR support can
@@ -63,7 +64,7 @@ config INTEL_IOMMU_DEFAULT_ON
 
 config INTEL_IOMMU_BROKEN_GFX_WA
 	bool "Workaround broken graphics drivers (going away soon)"
-	depends on INTEL_IOMMU && BROKEN && X86
+	depends on BROKEN && X86
 	help
 	  Current Graphics drivers tend to use physical address
 	  for DMA and avoid using DMA APIs. Setting this config
@@ -74,7 +75,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
 
 config INTEL_IOMMU_FLOPPY_WA
 	def_bool y
-	depends on INTEL_IOMMU && X86
+	depends on X86
 	help
 	  Floppy disk drivers are known to bypass DMA API calls
 	  thereby failing to work when IOMMU is enabled. This
@@ -83,7 +84,6 @@ config INTEL_IOMMU_FLOPPY_WA
 
 config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	bool "Enable Intel IOMMU scalable mode by default"
-	depends on INTEL_IOMMU
 	help
 	  Selecting this option will enable by default the scalable mode if
 	  hardware presents the capability. The scalable mode is defined in
@@ -92,3 +92,5 @@ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	  is not selected, scalable mode support could also be enabled by
 	  passing intel_iommu=sm_on to the kernel. If not sure, please use
 	  the default value.
+
+endif # INTEL_IOMMU
-- 
2.25.1

