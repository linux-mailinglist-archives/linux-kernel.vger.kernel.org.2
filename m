Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910C33F1E16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhHSQjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:5079 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="196853713"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="196853713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="594867707"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B728039E; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
Subject: [PATCH v4 05/21] platform/x86: intel_pmc_core: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:19 +0300
Message-Id: <20210819163735.81803-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel PMC core driver to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                   |  2 +-
 drivers/platform/x86/Kconfig                  | 21 ----------------
 drivers/platform/x86/Makefile                 |  1 -
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/pmc/Kconfig        | 25 +++++++++++++++++++
 drivers/platform/x86/intel/pmc/Makefile       |  9 +++++++
 .../{intel_pmc_core.c => intel/pmc/core.c}    |  2 +-
 .../{intel_pmc_core.h => intel/pmc/core.h}    |  0
 .../pmc/pltdrv.c}                             |  0
 10 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
 rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21813a0e00eb..eefe4edb1b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9483,7 +9483,7 @@ M:	David E Box <david.e.box@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
-F:	drivers/platform/x86/intel_pmc_core*
+F:	drivers/platform/x86/intel/pmc/
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9cadce7908ea..aed7570388ef 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1159,27 +1159,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_PMC_CORE
-	tristate "Intel PMC Core driver"
-	depends on PCI
-	depends on ACPI
-	help
-	  The Intel Platform Controller Hub for Intel Core SoCs provides access
-	  to Power Management Controller registers via various interfaces. This
-	  driver can utilize debugging capabilities and supported features as
-	  exposed by the Power Management Controller. It also may perform some
-	  tasks in the PMC in order to enable transition into the SLPS0 state.
-	  It should be selected on all Intel platforms supported by the driver.
-
-	  Supported features:
-		- SLP_S0_RESIDENCY counter
-		- PCH IP Power Gating status
-		- LTR Ignore / LTR Show
-		- MPHY/PLL gating status (Sunrisepoint PCH only)
-		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
-		- Low Power Mode registers (Tigerlake and beyond)
-		- PMC quirks as needed to enable SLPS0/S0ix
-
 config INTEL_SCU_IPC
 	bool
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 776370ce8fbb..1668f7360833 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -127,7 +127,6 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index c4ceb5ee83f3..7de11636904d 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -19,6 +19,7 @@ if X86_PLATFORM_DRIVERS_INTEL
 source "drivers/platform/x86/intel/int1092/Kconfig"
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
+source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 
 config INTEL_BXTWC_PMIC_TMU
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 58fc8e7a3b62..a1555a1e421d 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
+obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 
 # Intel PMIC / PMC / P-Unit drivers
diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
new file mode 100644
index 000000000000..b526597e4deb
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Intel x86 Platform-Specific Drivers
+#
+
+config INTEL_PMC_CORE
+	tristate "Intel PMC Core driver"
+	depends on PCI
+	depends on ACPI
+	help
+	  The Intel Platform Controller Hub for Intel Core SoCs provides access
+	  to Power Management Controller registers via various interfaces. This
+	  driver can utilize debugging capabilities and supported features as
+	  exposed by the Power Management Controller. It also may perform some
+	  tasks in the PMC in order to enable transition into the SLPS0 state.
+	  It should be selected on all Intel platforms supported by the driver.
+
+	  Supported features:
+		- SLP_S0_RESIDENCY counter
+		- PCH IP Power Gating status
+		- LTR Ignore / LTR Show
+		- MPHY/PLL gating status (Sunrisepoint PCH only)
+		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
+		- Low Power Mode registers (Tigerlake and beyond)
+		- PMC quirks as needed to enable SLPS0/S0ix
diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
new file mode 100644
index 000000000000..8966fcdc0e1d
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Intel x86 Platform-Specific Drivers
+#
+
+intel_pmc_core-y			:= core.o
+obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
+intel_pmc_core_pltdrv-y			:= pltdrv.o
+obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel/pmc/core.c
similarity index 99%
rename from drivers/platform/x86/intel_pmc_core.c
rename to drivers/platform/x86/intel/pmc/core.c
index ae410a358ffe..9963bc3d470c 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -31,7 +31,7 @@
 #include <asm/msr.h>
 #include <asm/tsc.h>
 
-#include "intel_pmc_core.h"
+#include "core.h"
 
 #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
 #define ACPI_GET_LOW_MODE_REGISTERS	1
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel/pmc/core.h
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core.h
rename to drivers/platform/x86/intel/pmc/core.h
diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core_pltdrv.c
rename to drivers/platform/x86/intel/pmc/pltdrv.c
-- 
2.32.0

