Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3B3F1E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhHSQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:38697 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhHSQil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216630826"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216630826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="489731330"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C174D3B0; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
Subject: [PATCH v4 06/21] platform/x86: intel_scu: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:20 +0300
Message-Id: <20210819163735.81803-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel SCU drivers to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                   |  2 +-
 drivers/platform/x86/Kconfig                  | 47 -----------------
 drivers/platform/x86/Makefile                 |  5 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/scu/Kconfig        | 51 +++++++++++++++++++
 drivers/platform/x86/intel/scu/Makefile       | 15 ++++++
 .../x86/{intel_scu_ipc.c => intel/scu/ipc.c}  |  0
 .../scu/ipcutil.c}                            |  0
 .../scu/pcidrv.c}                             |  0
 .../scu/pltdrv.c}                             |  0
 .../x86/{intel_scu_wdt.c => intel/scu/wdt.c}  |  0
 12 files changed, 69 insertions(+), 53 deletions(-)
 create mode 100644 drivers/platform/x86/intel/scu/Kconfig
 create mode 100644 drivers/platform/x86/intel/scu/Makefile
 rename drivers/platform/x86/{intel_scu_ipc.c => intel/scu/ipc.c} (100%)
 rename drivers/platform/x86/{intel_scu_ipcutil.c => intel/scu/ipcutil.c} (100%)
 rename drivers/platform/x86/{intel_scu_pcidrv.c => intel/scu/pcidrv.c} (100%)
 rename drivers/platform/x86/{intel_scu_pltdrv.c => intel/scu/pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_scu_wdt.c => intel/scu/wdt.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eefe4edb1b3d..aa08fdb02ecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9527,7 +9527,7 @@ INTEL SCU DRIVERS
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 S:	Maintained
 F:	arch/x86/include/asm/intel_scu_ipc.h
-F:	drivers/platform/x86/intel_scu_*
+F:	drivers/platform/x86/intel/scu/
 
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index aed7570388ef..1b85a1f6fc5f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1159,53 +1159,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_SCU_IPC
-	bool
-
-config INTEL_SCU
-	bool
-	select INTEL_SCU_IPC
-
-config INTEL_SCU_PCI
-	bool "Intel SCU PCI driver"
-	depends on PCI
-	select INTEL_SCU
-	help
-	  This driver is used to bridge the communications between kernel
-	  and SCU on some embedded Intel x86 platforms. It also creates
-	  devices that are connected to the SoC through the SCU.
-	  Platforms supported:
-	    Medfield
-	    Clovertrail
-	    Merrifield
-	    Broxton
-	    Apollo Lake
-
-config INTEL_SCU_PLATFORM
-	tristate "Intel SCU platform driver"
-	depends on ACPI
-	select INTEL_SCU
-	help
-	  This driver is used to bridge the communications between kernel
-	  and SCU (sometimes called PMC as well). The driver currently
-	  supports Intel Elkhart Lake and compatible platforms.
-
-config INTEL_SCU_WDT
-	bool
-	default INTEL_SCU_PCI
-	depends on INTEL_MID_WATCHDOG
-	help
-	  This is a specific platform code to instantiate watchdog device
-	  on ACPI-based Intel MID platforms.
-
-config INTEL_SCU_IPC_UTIL
-	tristate "Intel SCU IPC utility driver"
-	depends on INTEL_SCU
-	help
-	  The IPC Util driver provides an interface with the SCU enabling
-	  low level access for debug work and updating the firmware. Say
-	  N unless you will be doing this on an Intel MID platform.
-
 config INTEL_TELEMETRY
 	tristate "Intel SoC Telemetry Driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1668f7360833..026c97ba68f6 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -127,11 +127,6 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
-obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
-obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
-obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
-obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
 obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
 					   intel_telemetry_pltdrv.o \
 					   intel_telemetry_debugfs.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 7de11636904d..72f4a5b79342 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -21,6 +21,7 @@ source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
+source "drivers/platform/x86/intel/scu/Kconfig"
 
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel Broxton Whiskey Cove TMU Driver"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index a1555a1e421d..15e5124d70ec 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
+obj-$(CONFIG_INTEL_SCU)			+= scu/
 
 # Intel PMIC / PMC / P-Unit drivers
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel/scu/Kconfig b/drivers/platform/x86/intel/scu/Kconfig
new file mode 100644
index 000000000000..5ce2554e2b90
--- /dev/null
+++ b/drivers/platform/x86/intel/scu/Kconfig
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Intel x86 Platform-Specific Drivers
+#
+
+config INTEL_SCU_IPC
+	bool
+
+config INTEL_SCU_IPC_UTIL
+	tristate "Intel SCU IPC utility driver"
+	depends on INTEL_SCU
+	help
+	  The IPC utility driver provides an interface with the SCU enabling
+	  low level access for debug work and updating the firmware.
+	  Say N unless you will be doing this on an Intel MID platform.
+
+config INTEL_SCU
+	bool
+	select INTEL_SCU_IPC
+
+config INTEL_SCU_PCI
+	bool "Intel SCU PCI driver"
+	depends on PCI
+	select INTEL_SCU
+	help
+	  This driver is used to bridge the communications between kernel
+	  and SCU on some embedded Intel x86 platforms. It also creates
+	  devices that are connected to the SoC through the SCU.
+	  Platforms supported:
+	    Medfield
+	    Clovertrail
+	    Merrifield
+	    Broxton
+	    Apollo Lake
+
+config INTEL_SCU_PLATFORM
+	tristate "Intel SCU platform driver"
+	depends on ACPI
+	select INTEL_SCU
+	help
+	  This driver is used to bridge the communications between kernel
+	  and SCU (sometimes called PMC as well). The driver currently
+	  supports Intel Elkhart Lake and compatible platforms.
+
+config INTEL_SCU_WDT
+	bool
+	default INTEL_SCU_PCI
+	depends on INTEL_MID_WATCHDOG
+	help
+	  This is a specific platform code to instantiate watchdog device
+	  on ACPI-based Intel MID platforms.
diff --git a/drivers/platform/x86/intel/scu/Makefile b/drivers/platform/x86/intel/scu/Makefile
new file mode 100644
index 000000000000..601a720f97dc
--- /dev/null
+++ b/drivers/platform/x86/intel/scu/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Intel x86 Platform-Specific Drivers
+#
+
+intel_scu_ipc-y				:= ipc.o
+obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
+intel_scu_ipcutil-y			:= ipcutil.o
+obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
+intel_scu_pci-y				:= pcidrv.o
+obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
+intel_scu_pltdrv-y			:= pltdrv.o
+obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
+intel_scu_wdt-y				:= wdt.o
+obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel/scu/ipc.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_ipc.c
rename to drivers/platform/x86/intel/scu/ipc.c
diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel/scu/ipcutil.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_ipcutil.c
rename to drivers/platform/x86/intel/scu/ipcutil.c
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel/scu/pcidrv.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_pcidrv.c
rename to drivers/platform/x86/intel/scu/pcidrv.c
diff --git a/drivers/platform/x86/intel_scu_pltdrv.c b/drivers/platform/x86/intel/scu/pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_pltdrv.c
rename to drivers/platform/x86/intel/scu/pltdrv.c
diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel/scu/wdt.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_wdt.c
rename to drivers/platform/x86/intel/scu/wdt.c
-- 
2.32.0

