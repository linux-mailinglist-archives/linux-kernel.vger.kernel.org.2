Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2D3F1E21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHSQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:5089 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhHSQir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="196853739"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="196853739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="594867761"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2021 09:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A17B924; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 16/21] platform/x86: intel_int0002_vgpio: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:30 +0300
Message-Id: <20210819163735.81803-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
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
index 7f3912c16338..c3693ea68e71 100644
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
index 2a8f03f89273..a7be69a2afd2 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index b97061e85a3d..a72fa2157b6e 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -39,6 +39,25 @@ config INTEL_HID_EVENT
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
index 8bfa9fb0a528..12647076ea0d 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -18,6 +18,10 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
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

