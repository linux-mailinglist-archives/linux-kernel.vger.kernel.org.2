Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA53F2A97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhHTLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:05:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:15764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239300AbhHTLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238881706"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="238881706"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="523529925"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2021 04:05:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B9E923B0; Fri, 20 Aug 2021 14:05:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com
Cc:     Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Subject: [PATCH v5 04/20] platform/x86: intel_mrfld_pwrbtn: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:42 +0300
Message-Id: <20210820110458.73018-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel Merrifield power button driver to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                          | 11 -----------
 drivers/platform/x86/Makefile                         |  1 -
 drivers/platform/x86/intel/Kconfig                    | 11 +++++++++++
 drivers/platform/x86/intel/Makefile                   |  2 ++
 .../{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c}    |  0
 5 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ba0454450335..2d6723bb6459 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1159,17 +1159,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_MRFLD_PWRBTN
-	tristate "Intel Merrifield Basin Cove power button driver"
-	depends on INTEL_SOC_PMIC_MRFLD
-	depends on INPUT
-	help
-	  This option adds a power button driver for Basin Cove PMIC
-	  on Intel Merrifield devices.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_mrfld_pwrbtn.
-
 config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index bf94af0749f5..f70c0aa30cdd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -127,7 +127,6 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 3792a5492a8a..9e719db8450c 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -42,4 +42,15 @@ config INTEL_CHTDC_TI_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_chtdc_ti_pwrbtn.
 
+config INTEL_MRFLD_PWRBTN
+	tristate "Intel Merrifield Basin Cove power button driver"
+	depends on INTEL_SOC_PMIC_MRFLD
+	depends on INPUT
+	help
+	  This option adds a power button driver for Basin Cove PMIC
+	  on Intel Merrifield devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_mrfld_pwrbtn.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 52d7bc0948f3..4ff755a11770 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -14,3 +14,5 @@ intel_bxtwc_tmu-y			:= bxtwc_tmu.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 intel_chtdc_ti_pwrbtn-y			:= chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
+intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
+obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
diff --git a/drivers/platform/x86/intel_mrfld_pwrbtn.c b/drivers/platform/x86/intel/mrfld_pwrbtn.c
similarity index 100%
rename from drivers/platform/x86/intel_mrfld_pwrbtn.c
rename to drivers/platform/x86/intel/mrfld_pwrbtn.c
-- 
2.32.0

