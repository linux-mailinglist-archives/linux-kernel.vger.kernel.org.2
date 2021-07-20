Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746783CF191
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhGTBFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:05:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:17234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240564AbhGTBAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:00:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211219358"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="211219358"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 18:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453887552"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 18:41:22 -0700
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
Subject: [PATCH 2/5] iommu/vt-d: Enable Intel IOMMU scalable mode by default
Date:   Tue, 20 Jul 2021 09:38:53 +0800
Message-Id: <20210720013856.4143880-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8950dcd83ae7d ("iommu/vt-d: Leave scalable mode default off")
leaves the scalable mode default off and end users could turn it on with
"intel_iommu=sm_on". Using the Intel IOMMU scalable mode for kernel DMA,
user-level device access and Shared Virtual Address have been enabled.
This enables the scalable mode by default if the hardware advertises the
support and adds kernel options of "intel_iommu=sm_on/sm_off" for end
users to configure it through the kernel parameters.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++++++-----
 drivers/iommu/intel/iommu.c                     |  5 ++++-
 drivers/iommu/intel/Kconfig                     |  1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..388eaf40fbe5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1951,11 +1951,12 @@
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
 			not be supported.
-		sm_on [Default Off]
-			By default, scalable mode will be disabled even if the
-			hardware advertises that it has support for the scalable
-			mode translation. With this option set, scalable mode
-			will be used on hardware which claims to support it.
+		sm_on
+			Enable the Intel IOMMU scalable mode if the hardware
+			advertises that it has support for the scalable mode
+			translation.
+		sm_off
+			Disallow use of the Intel IOMMU scalable mode.
 		tboot_noforce [Default Off]
 			Do not force the Intel IOMMU enabled under tboot.
 			By default, tboot will force Intel IOMMU on, which
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0440a1850b63..1131b8efb050 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -433,8 +433,11 @@ static int __init intel_iommu_setup(char *str)
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
 		} else if (!strncmp(str, "sm_on", 5)) {
-			pr_info("Intel-IOMMU: scalable mode supported\n");
+			pr_info("Enable scalable mode if hardware supports\n");
 			intel_iommu_sm = 1;
+		} else if (!strncmp(str, "sm_off", 6)) {
+			pr_info("Scalable mode is disallowed\n");
+			intel_iommu_sm = 0;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			pr_info("Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index c1a92c3049d0..0ddb77115be7 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -84,6 +84,7 @@ config INTEL_IOMMU_FLOPPY_WA
 
 config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	bool "Enable Intel IOMMU scalable mode by default"
+	default y
 	help
 	  Selecting this option will enable by default the scalable mode if
 	  hardware presents the capability. The scalable mode is defined in
-- 
2.25.1

