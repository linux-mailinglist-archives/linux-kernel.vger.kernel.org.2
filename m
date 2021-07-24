Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACD3D4476
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 04:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhGXCN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 22:13:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:58859 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233804AbhGXCNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 22:13:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="273090126"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="273090126"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 19:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="434300635"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2021 19:53:42 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id DFEB35805EC;
        Fri, 23 Jul 2021 19:53:41 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/intel: Move Intel PMT drivers to new subfolder
Date:   Fri, 23 Jul 2021 19:51:32 -0700
Message-Id: <20210724025132.2726164-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all Intel Platform Monitoring Technology drivers to
drivers/platform/x86/intel/pmt.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 MAINTAINERS                                   |  2 +-
 drivers/platform/x86/Kconfig                  | 36 -----------------
 drivers/platform/x86/Makefile                 |  3 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/pmt/Kconfig        | 40 +++++++++++++++++++
 drivers/platform/x86/intel/pmt/Makefile       |  9 +++++
 .../pmt/pmt_class.c}                          |  2 +-
 .../pmt/pmt_class.h}                          |  0
 .../pmt/pmt_crashlog.c}                       |  2 +-
 .../pmt/pmt_telemetry.c}                      |  2 +-
 11 files changed, 55 insertions(+), 43 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmt/Makefile
 rename drivers/platform/x86/{intel_pmt_class.c => intel/pmt/pmt_class.c} (99%)
 rename drivers/platform/x86/{intel_pmt_class.h => intel/pmt/pmt_class.h} (100%)
 rename drivers/platform/x86/{intel_pmt_crashlog.c => intel/pmt/pmt_crashlog.c} (99%)
 rename drivers/platform/x86/{intel_pmt_telemetry.c => intel/pmt/pmt_telemetry.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffed30dc86b0..ffd741306dcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9494,7 +9494,7 @@ INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_pmt.c
-F:	drivers/platform/x86/intel_pmt_*
+F:	drivers/platform/x86/intel/pmt/pmt_*
 
 INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
 M:	Stanislav Yakovlev <stas.yakovlev@gmail.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cae72922f448..f06ccd00f6c4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1184,42 +1184,6 @@ config INTEL_MRFLD_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_mrfld_pwrbtn.
 
-config INTEL_PMT_CLASS
-	tristate
-	help
-	  The Intel Platform Monitoring Technology (PMT) class driver provides
-	  the basic sysfs interface and file hierarchy used by PMT devices.
-
-	  For more information, see:
-	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_pmt_class.
-
-config INTEL_PMT_TELEMETRY
-	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
-	depends on MFD_INTEL_PMT
-	select INTEL_PMT_CLASS
-	help
-	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
-	  access to hardware telemetry metrics on devices that support the
-	  feature.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_pmt_telemetry.
-
-config INTEL_PMT_CRASHLOG
-	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
-	depends on MFD_INTEL_PMT
-	select INTEL_PMT_CLASS
-	help
-	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
-	  access to hardware crashlog capabilities on devices that support the
-	  feature.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_pmt_crashlog.
-
 config INTEL_PUNIT_IPC
 	tristate "Intel P-Unit IPC Driver"
 	help
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 43d36f8c36f1..d517d5cbc9ca 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,9 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
-obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
-obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
-obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 8ca021785f67..0b238026c082 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -19,5 +19,6 @@ if X86_PLATFORM_DRIVERS_INTEL
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmc/Kconfig"
+source "drivers/platform/x86/intel/pmt/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 49962f4dfdec..93026884ae03 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
+obj-y					+= pmt/
diff --git a/drivers/platform/x86/intel/pmt/Kconfig b/drivers/platform/x86/intel/pmt/Kconfig
new file mode 100644
index 000000000000..d630f883a717
--- /dev/null
+++ b/drivers/platform/x86/intel/pmt/Kconfig
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel Platform Monitoring Technology drivers
+#
+
+config INTEL_PMT_CLASS
+	tristate
+	help
+	  The Intel Platform Monitoring Technology (PMT) class driver provides
+	  the basic sysfs interface and file hierarchy used by PMT devices.
+
+	  For more information, see:
+	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_class.
+
+config INTEL_PMT_TELEMETRY
+	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
+	depends on MFD_INTEL_PMT
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
+	  access to hardware telemetry metrics on devices that support the
+	  feature.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_telemetry.
+
+config INTEL_PMT_CRASHLOG
+	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
+	depends on MFD_INTEL_PMT
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
+	  access to hardware crashlog capabilities on devices that support the
+	  feature.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_crashlog.
diff --git a/drivers/platform/x86/intel/pmt/Makefile b/drivers/platform/x86/intel/pmt/Makefile
new file mode 100644
index 000000000000..5c95cdbb57b1
--- /dev/null
+++ b/drivers/platform/x86/intel/pmt/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/intel/pmt
+# Intel Platform Monitoring Technology Drivers
+#
+
+obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt_class.o
+obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt_telemetry.o
+obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt_crashlog.o
diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel/pmt/pmt_class.c
similarity index 99%
rename from drivers/platform/x86/intel_pmt_class.c
rename to drivers/platform/x86/intel/pmt/pmt_class.c
index c86ff15b1ed5..05c16a812e00 100644
--- a/drivers/platform/x86/intel_pmt_class.c
+++ b/drivers/platform/x86/intel/pmt/pmt_class.c
@@ -13,7 +13,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
-#include "intel_pmt_class.h"
+#include "pmt_class.h"
 
 #define PMT_XA_START		0
 #define PMT_XA_MAX		INT_MAX
diff --git a/drivers/platform/x86/intel_pmt_class.h b/drivers/platform/x86/intel/pmt/pmt_class.h
similarity index 100%
rename from drivers/platform/x86/intel_pmt_class.h
rename to drivers/platform/x86/intel/pmt/pmt_class.h
diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel/pmt/pmt_crashlog.c
similarity index 99%
rename from drivers/platform/x86/intel_pmt_crashlog.c
rename to drivers/platform/x86/intel/pmt/pmt_crashlog.c
index 56963ceb6345..e869dfcdce31 100644
--- a/drivers/platform/x86/intel_pmt_crashlog.c
+++ b/drivers/platform/x86/intel/pmt/pmt_crashlog.c
@@ -15,7 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/overflow.h>
 
-#include "intel_pmt_class.h"
+#include "pmt_class.h"
 
 #define DRV_NAME		"pmt_crashlog"
 
diff --git a/drivers/platform/x86/intel_pmt_telemetry.c b/drivers/platform/x86/intel/pmt/pmt_telemetry.c
similarity index 99%
rename from drivers/platform/x86/intel_pmt_telemetry.c
rename to drivers/platform/x86/intel/pmt/pmt_telemetry.c
index 9b95ef050457..b90ae25caba5 100644
--- a/drivers/platform/x86/intel_pmt_telemetry.c
+++ b/drivers/platform/x86/intel/pmt/pmt_telemetry.c
@@ -15,7 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/overflow.h>
 
-#include "intel_pmt_class.h"
+#include "pmt_class.h"
 
 #define TELEM_DEV_NAME		"pmt_telemetry"
 
-- 
2.25.1

