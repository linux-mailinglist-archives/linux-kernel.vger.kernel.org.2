Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3233F2AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbhHTLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:30934 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239403AbhHTLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="214913369"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="214913369"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="680060291"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2021 04:05:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50482990; Fri, 20 Aug 2021 14:05:01 +0300 (EEST)
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
Subject: [PATCH v5 16/20] platform/x86: intel_int0002_vgpio: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:54 +0300
Message-Id: <20210820110458.73018-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel vGPIO (INT0002) driver to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                  | 19 -------------------
 drivers/platform/x86/Makefile                 |  1 -
 drivers/platform/x86/intel/Kconfig            | 19 +++++++++++++++++++
 drivers/platform/x86/intel/Makefile           |  4 ++++
 .../int0002_vgpio.c}                          |  0
 5 files changed, 23 insertions(+), 20 deletions(-)
 rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 79480826f816..6bdcf197b550 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -668,25 +668,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_INT0002_VGPIO
-	tristate "Intel ACPI INT0002 Virtual GPIO driver"
-	depends on GPIOLIB && ACPI && PM_SLEEP
-	select GPIOLIB_IRQCHIP
-	help
-	  Some peripherals on Bay Trail and Cherry Trail platforms signal a
-	  Power Management Event (PME) to the Power Management Controller (PMC)
-	  to wakeup the system. When this happens software needs to explicitly
-	  clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
-	  IRQ storm on IRQ 9.
-
-	  This is modelled in ACPI through the INT0002 ACPI device, which is
-	  called a "Virtual GPIO controller" in ACPI because it defines the
-	  event handler to call when the PME triggers through _AEI and _L02
-	  methods as would be done for a real GPIO interrupt in ACPI.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_int0002_vgpio.
-
 config INTEL_OAKTRAIL
 	tristate "Intel Oaktrail Platform Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4294843ead8a..75bcf6fe33b9 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 048dfdd02ee7..53b2d5858ad0 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -38,6 +38,25 @@ config INTEL_HID_EVENT
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_hid.
 
+config INTEL_INT0002_VGPIO
+	tristate "Intel ACPI INT0002 Virtual GPIO driver"
+	depends on GPIOLIB && ACPI && PM_SLEEP
+	select GPIOLIB_IRQCHIP
+	help
+	  Some peripherals on Bay Trail and Cherry Trail platforms signal a
+	  Power Management Event (PME) to the Power Management Controller (PMC)
+	  to wakeup the system. When this happens software needs to explicitly
+	  clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
+	  IRQ storm on IRQ 9.
+
+	  This is modelled in ACPI through the INT0002 ACPI device, which is
+	  called a "Virtual GPIO controller" in ACPI because it defines the
+	  event handler to call when the PME triggers through _AEI and _L02
+	  methods as would be done for a real GPIO interrupt in ACPI.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_int0002_vgpio.
+
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel Broxton Whiskey Cove TMU Driver"
 	depends on INTEL_SOC_PMIC_BXTWC
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index e63d03d86e20..7fdf35ab70bf 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -17,6 +17,10 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 intel-hid-y				:= hid.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 
+# Intel miscellaneous drivers
+intel_int0002_vgpio-y			:= int0002_vgpio.o
+obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
+
 # Intel PMIC / PMC / P-Unit drivers
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
similarity index 100%
rename from drivers/platform/x86/intel_int0002_vgpio.c
rename to drivers/platform/x86/intel/int0002_vgpio.c
-- 
2.32.0

