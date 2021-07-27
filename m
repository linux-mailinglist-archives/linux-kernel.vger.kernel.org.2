Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45B3D7B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhG0Qv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:51:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:33393 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhG0Qv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:51:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="192081321"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="192081321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="498873264"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2021 09:51:56 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 635AC58086A;
        Tue, 27 Jul 2021 09:51:56 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] platform/x86/intel: Move Intel PMT drivers to new subfolder
Date:   Tue, 27 Jul 2021 09:49:28 -0700
Message-Id: <20210727164928.3171521-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all Intel Platform Monitoring Technology drivers to
drivers/platform/x86/intel/pmt.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

V3:	Fix folder in MAINTAINERS and build flag in Makefile as suggested by
	Joe Perches

V2:	Remove 'pmt' prefix on files as suggested by Andy.

 MAINTAINERS                                   |  2 +-
 drivers/platform/x86/Kconfig                  | 36 -----------------
 drivers/platform/x86/Makefile                 |  3 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/pmt/Kconfig        | 40 +++++++++++++++++++
 drivers/platform/x86/intel/pmt/Makefile       | 12 ++++++
 .../{intel_pmt_class.c => intel/pmt/class.c}  |  2 +-
 .../{intel_pmt_class.h => intel/pmt/class.h}  |  0
 .../pmt/crashlog.c}                           |  2 +-
 .../pmt/telemetry.c}                          |  2 +-
 11 files changed, 58 insertions(+), 43 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmt/Makefile
 rename drivers/platform/x86/{intel_pmt_class.c => intel/pmt/class.c} (99%)
 rename drivers/platform/x86/{intel_pmt_class.h => intel/pmt/class.h} (100%)
 rename drivers/platform/x86/{intel_pmt_crashlog.c => intel/pmt/crashlog.c} (99%)
 rename drivers/platform/x86/{intel_pmt_telemetry.c => intel/pmt/telemetry.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffed30dc86b0..bcf1e91fd5df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9494,7 +9494,7 @@ INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_pmt.c
-F:	drivers/platform/x86/intel_pmt_*
+F:	drivers/platform/x86/intel/pmt/
 
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
index 49962f4dfdec..a740af2a0939 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
+obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
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
index 000000000000..019103ee6522
--- /dev/null
+++ b/drivers/platform/x86/intel/pmt/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/intel/pmt
+# Intel Platform Monitoring Technology Drivers
+#
+
+pmt_class-objs				+= class.o
+obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt_class.o
+pmt_telemetry-objs			+= telemetry.o
+obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt_telemetry.o
+pmt_crashlog-objs			+= crashlog.o
+obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt_crashlog.o
diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel/pmt/class.c
similarity index 99%
rename from drivers/platform/x86/intel_pmt_class.c
rename to drivers/platform/x86/intel/pmt/class.c
index c86ff15b1ed5..659b1073033c 100644
--- a/drivers/platform/x86/intel_pmt_class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -13,7 +13,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
-#include "intel_pmt_class.h"
+#include "class.h"
 
 #define PMT_XA_START		0
 #define PMT_XA_MAX		INT_MAX
diff --git a/drivers/platform/x86/intel_pmt_class.h b/drivers/platform/x86/intel/pmt/class.h
similarity index 100%
rename from drivers/platform/x86/intel_pmt_class.h
rename to drivers/platform/x86/intel/pmt/class.h
diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
similarity index 99%
rename from drivers/platform/x86/intel_pmt_crashlog.c
rename to drivers/platform/x86/intel/pmt/crashlog.c
index 56963ceb6345..1c1021f04d3c 100644
--- a/drivers/platform/x86/intel_pmt_crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -15,7 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/overflow.h>
 
-#include "intel_pmt_class.h"
+#include "class.h"
 
 #define DRV_NAME		"pmt_crashlog"
 
diff --git a/drivers/platform/x86/intel_pmt_telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
similarity index 99%
rename from drivers/platform/x86/intel_pmt_telemetry.c
rename to drivers/platform/x86/intel/pmt/telemetry.c
index 9b95ef050457..a58843360fbf 100644
--- a/drivers/platform/x86/intel_pmt_telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -15,7 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/overflow.h>
 
-#include "intel_pmt_class.h"
+#include "class.h"
 
 #define TELEM_DEV_NAME		"pmt_telemetry"
 
-- 
2.25.1

