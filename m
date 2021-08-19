Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09DD3F1E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhHSQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:38:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:1924 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="280332699"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="280332699"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="681847594"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDD863C5; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Subject: [PATCH v4 07/21] platform/x86: intel_telemetry: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:21 +0300
Message-Id: <20210819163735.81803-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel telemetry driver to intel sub-directory to improve readability.

While at it, spell APL fully in the Kconfig.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                      |  2 +-
 drivers/platform/x86/Kconfig                     | 12 ------------
 drivers/platform/x86/Makefile                    |  4 ----
 drivers/platform/x86/intel/Kconfig               |  1 +
 drivers/platform/x86/intel/Makefile              |  1 +
 drivers/platform/x86/intel/telemetry/Kconfig     | 16 ++++++++++++++++
 drivers/platform/x86/intel/telemetry/Makefile    | 11 +++++++++++
 .../telemetry/core.c}                            |  0
 .../telemetry/debugfs.c}                         |  0
 .../telemetry/pltdrv.c}                          |  0
 10 files changed, 30 insertions(+), 17 deletions(-)
 create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
 create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
 rename drivers/platform/x86/{intel_telemetry_core.c => intel/telemetry/core.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_debugfs.c => intel/telemetry/debugfs.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_pltdrv.c => intel/telemetry/pltdrv.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa08fdb02ecb..0c73e6216142 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9559,7 +9559,7 @@ M:	"David E. Box" <david.e.box@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
-F:	drivers/platform/x86/intel_telemetry*
+F:	drivers/platform/x86/intel/telemetry/
 
 INTEL UNCORE FREQUENCY CONTROL
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1b85a1f6fc5f..b6e32551a8f5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1159,18 +1159,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_TELEMETRY
-	tristate "Intel SoC Telemetry Driver"
-	depends on X86_64
-	depends on MFD_INTEL_PMC_BXT
-	depends on INTEL_PUNIT_IPC
-	help
-	  This driver provides interfaces to configure and use
-	  telemetry for INTEL SoC from APL onwards. It is also
-	  used to get various SoC events and parameters
-	  directly via debugfs files. Various tools may use
-	  this interface for SoC state monitoring.
-
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 026c97ba68f6..633cc14eba2c 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -126,8 +126,4 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
-# Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
-					   intel_telemetry_pltdrv.o \
-					   intel_telemetry_debugfs.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 72f4a5b79342..bedd3bdb0662 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -22,6 +22,7 @@ source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
+source "drivers/platform/x86/intel/telemetry/Kconfig"
 
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel Broxton Whiskey Cove TMU Driver"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 15e5124d70ec..d446771dbff2 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_SCU)			+= scu/
+obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
 # Intel PMIC / PMC / P-Unit drivers
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel/telemetry/Kconfig b/drivers/platform/x86/intel/telemetry/Kconfig
new file mode 100644
index 000000000000..da887bd03731
--- /dev/null
+++ b/drivers/platform/x86/intel/telemetry/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_TELEMETRY
+	tristate "Intel SoC Telemetry driver"
+	depends on X86_64
+	depends on MFD_INTEL_PMC_BXT
+	depends on INTEL_PUNIT_IPC
+	help
+	  This driver provides interfaces to configure and use
+	  telemetry for Intel SoC from Apollo Lake onwards.
+	  It is also used to get various SoC events and parameters
+	  directly via debugfs files. Various tools may use
+	  this interface for SoC state monitoring.
diff --git a/drivers/platform/x86/intel/telemetry/Makefile b/drivers/platform/x86/intel/telemetry/Makefile
new file mode 100644
index 000000000000..bfdba5b6c59a
--- /dev/null
+++ b/drivers/platform/x86/intel/telemetry/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+intel_telemetry_core-y			:= core.o
+obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o
+intel_telemetry_pltdrv-y		:= pltdrv.o
+obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_pltdrv.o
+intel_telemetry_debugfs-y		:= debugfs.o
+obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_debugfs.o
diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel/telemetry/core.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_core.c
rename to drivers/platform/x86/intel/telemetry/core.c
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel/telemetry/debugfs.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_debugfs.c
rename to drivers/platform/x86/intel/telemetry/debugfs.c
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel/telemetry/pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_pltdrv.c
rename to drivers/platform/x86/intel/telemetry/pltdrv.c
-- 
2.32.0

