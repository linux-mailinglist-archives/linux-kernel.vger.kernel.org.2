Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B603F2A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhHTLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:05:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:1505 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239533AbhHTLFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203951728"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="203951728"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="642096221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2021 04:05:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C42B53C5; Fri, 20 Aug 2021 14:05:00 +0300 (EEST)
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
Subject: [PATCH v5 05/20] platform/x86: intel_punit_ipc: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:43 +0300
Message-Id: <20210820110458.73018-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel P-Unit IPC driver to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                                 | 2 +-
 drivers/platform/x86/Kconfig                                | 6 ------
 drivers/platform/x86/Makefile                               | 1 -
 drivers/platform/x86/intel/Kconfig                          | 6 ++++++
 drivers/platform/x86/intel/Makefile                         | 2 ++
 .../platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c}   | 0
 6 files changed, 9 insertions(+), 8 deletions(-)
 rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b731988a4452..21813a0e00eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9475,7 +9475,7 @@ M:	Zha Qipeng <qipeng.zha@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	arch/x86/include/asm/intel_punit_ipc.h
-F:	drivers/platform/x86/intel_punit_ipc.c
+F:	drivers/platform/x86/intel/punit_ipc.c
 
 INTEL PMC CORE DRIVER
 M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2d6723bb6459..9cadce7908ea 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1180,12 +1180,6 @@ config INTEL_PMC_CORE
 		- Low Power Mode registers (Tigerlake and beyond)
 		- PMC quirks as needed to enable SLPS0/S0ix
 
-config INTEL_PUNIT_IPC
-	tristate "Intel P-Unit IPC Driver"
-	help
-	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
-	  which is used to bridge the communications between kernel and P-Unit.
-
 config INTEL_SCU_IPC
 	bool
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index f70c0aa30cdd..776370ce8fbb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
-obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 9e719db8450c..c4ceb5ee83f3 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -53,4 +53,10 @@ config INTEL_MRFLD_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_mrfld_pwrbtn.
 
+config INTEL_PUNIT_IPC
+	tristate "Intel P-Unit IPC Driver"
+	help
+	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
+	  which is used to bridge the communications between kernel and P-Unit.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 4ff755a11770..58fc8e7a3b62 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -16,3 +16,5 @@ intel_chtdc_ti_pwrbtn-y			:= chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
+intel_punit_ipc-y			:= punit_ipc.o
+obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel/punit_ipc.c
similarity index 100%
rename from drivers/platform/x86/intel_punit_ipc.c
rename to drivers/platform/x86/intel/punit_ipc.c
-- 
2.32.0

