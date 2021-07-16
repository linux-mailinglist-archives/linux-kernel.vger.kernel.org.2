Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9153CBBF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhGPSoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:44:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:56652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhGPSog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:44:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="191144868"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="191144868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 11:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="460843452"
Received: from otcpl-manager.jf.intel.com (HELO localhost.localdomain) ([10.54.39.234])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2021 11:41:40 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, hdegoede@redhat.com,
        irenic.rajneesh@gmail.com, andriy.shevchenko@linux.intel.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 1/5] platform/x86/intel: intel_pmc_core: Move intel_pmc_core* files to pmc subfolder
Date:   Fri, 16 Jul 2021 11:38:33 -0700
Message-Id: <b2cb6b10b75445acceab3030c3a9aa585e7c7b65.1626459866.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626459866.git.gayatri.kammela@intel.com>
References: <cover.1626459866.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of collecting Intel x86 specific drivers in their own
folder, move intel_pmc_core* files to its own subfolder there.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: David Box <david.e.box@intel.com>
Cc: You-Sheng Yang <vicamo.yang@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 MAINTAINERS                                   |  2 +-
 drivers/platform/x86/Kconfig                  | 21 ------------------
 drivers/platform/x86/Makefile                 |  1 -
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/pmc/Kconfig        | 22 +++++++++++++++++++
 drivers/platform/x86/intel/pmc/Makefile       |  5 +++++
 .../{intel_pmc_core.c => intel/pmc/core.c}    |  2 +-
 .../{intel_pmc_core.h => intel/pmc/core.h}    |  0
 .../pmc/pltdrv.c}                             |  0
 10 files changed, 31 insertions(+), 24 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
 rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c8be735cc91..c5d610885bf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9477,7 +9477,7 @@ M:	David E Box <david.e.box@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
-F:	drivers/platform/x86/intel_pmc_core*
+F:	drivers/platform/x86/intel/pmc/core*
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7d385c3b2239..cae72922f448 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1184,27 +1184,6 @@ config INTEL_MRFLD_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_mrfld_pwrbtn.
 
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
 config INTEL_PMT_CLASS
 	tristate
 	help
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 7ee369aab10d..43d36f8c36f1 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
-obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
 obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index f2eef337eb98..8ca021785f67 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -18,5 +18,6 @@ if X86_PLATFORM_DRIVERS_INTEL
 
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
+source "drivers/platform/x86/intel/pmc/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 0653055942d5..49962f4dfdec 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
+obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
new file mode 100644
index 000000000000..b4c955a35674
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
index 000000000000..e0182e10a035
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+
+obj-$(CONFIG_INTEL_PMC_CORE)	+= core.o
+obj-$(CONFIG_INTEL_PMC_CORE)	+= pltdrv.o
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel/pmc/core.c
similarity index 99%
rename from drivers/platform/x86/intel_pmc_core.c
rename to drivers/platform/x86/intel/pmc/core.c
index b0e486a6bdfb..f9de78b08e5d 100644
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
2.25.1

