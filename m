Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2D3F1E17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhHSQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:38684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216630817"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216630817"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="512158782"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2021 09:37:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30D216D5; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 14/21] platform/x86: intel_atomisp2: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:28 +0300
Message-Id: <20210819163735.81803-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel AtomISP v2 drivers to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                   |  4 +-
 drivers/platform/x86/Kconfig                  | 34 ---------------
 drivers/platform/x86/Makefile                 |  2 -
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/atomisp2/Kconfig   | 43 +++++++++++++++++++
 drivers/platform/x86/intel/atomisp2/Makefile  |  9 ++++
 .../atomisp2/led.c}                           |  0
 .../atomisp2/pm.c}                            |  0
 9 files changed, 56 insertions(+), 38 deletions(-)
 create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
 create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
 rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
 rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb8e848a0f83..ce79ad253afe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9212,13 +9212,13 @@ INTEL ATOMISP2 DUMMY / POWER-MANAGEMENT DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel_atomisp2_pm.c
+F:	drivers/platform/x86/intel/atomisp2/pm.c
 
 INTEL ATOMISP2 LED DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel_atomisp2_led.c
+F:	drivers/platform/x86/intel/atomisp2/led.c
 
 INTEL BIOS SAR INT1092 DRIVER
 M:	Shravan S <s.shravan@intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2c80597cfa4d..feca8ae551a1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -668,40 +668,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_ATOMISP2_LED
-	tristate "Intel AtomISP2 camera LED driver"
-	depends on GPIOLIB && LEDS_GPIO
-	help
-	  Many Bay Trail and Cherry Trail devices come with a camera attached
-	  to Intel's Image Signal Processor. Linux currently does not have a
-	  driver for these, so they do not work as a camera. Some of these
-	  camera's have a LED which is controlled through a GPIO.
-
-	  Some of these devices have a firmware issue where the LED gets turned
-	  on at boot. This driver will turn the LED off at boot and also allows
-	  controlling the LED (repurposing it) through the sysfs LED interface.
-
-	  Which GPIO is attached to the LED is usually not described in the
-	  ACPI tables, so this driver contains per-system info about the GPIO
-	  inside the driver, this means that this driver only works on systems
-	  the driver knows about.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_atomisp2_led.
-
-config INTEL_ATOMISP2_PM
-	tristate "Intel AtomISP2 dummy / power-management driver"
-	depends on PCI && IOSF_MBI && PM
-	depends on !INTEL_ATOMISP
-	help
-	  Power-management driver for Intel's Image Signal Processor found on
-	  Bay Trail and Cherry Trail devices. This dummy driver's sole purpose
-	  is to turn the ISP off (put it in D3) to save power and to allow
-	  entering of S0ix modes.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_atomisp2_pm.
-
 config INTEL_HID_EVENT
 	tristate "INTEL HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6fd63ff22e38..1f3e48a1721f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,8 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
-obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 02a2161894d2..351640511eee 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -16,6 +16,7 @@ menuconfig X86_PLATFORM_DRIVERS_INTEL
 
 if X86_PLATFORM_DRIVERS_INTEL
 
+source "drivers/platform/x86/intel/atomisp2/Kconfig"
 source "drivers/platform/x86/intel/int1092/Kconfig"
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 5b45acd32591..e5ea0e8ba516 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -4,6 +4,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
+obj-$(CONFIG_INTEL_ATOMISP2_PDX86)	+= atomisp2/
 obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
diff --git a/drivers/platform/x86/intel/atomisp2/Kconfig b/drivers/platform/x86/intel/atomisp2/Kconfig
new file mode 100644
index 000000000000..35dd2be9d2a1
--- /dev/null
+++ b/drivers/platform/x86/intel/atomisp2/Kconfig
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_ATOMISP2_PDX86
+	bool
+
+config INTEL_ATOMISP2_LED
+	tristate "Intel AtomISP v2 camera LED driver"
+	depends on GPIOLIB && LEDS_GPIO
+	select INTEL_ATOMISP2_PDX86
+	help
+	  Many Bay Trail and Cherry Trail devices come with a camera attached
+	  to Intel's Image Signal Processor. Linux currently does not have a
+	  driver for these, so they do not work as a camera. Some of these
+	  camera's have a LED which is controlled through a GPIO.
+
+	  Some of these devices have a firmware issue where the LED gets turned
+	  on at boot. This driver will turn the LED off at boot and also allows
+	  controlling the LED (repurposing it) through the sysfs LED interface.
+
+	  Which GPIO is attached to the LED is usually not described in the
+	  ACPI tables, so this driver contains per-system info about the GPIO
+	  inside the driver, this means that this driver only works on systems
+	  the driver knows about.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_atomisp2_led.
+
+config INTEL_ATOMISP2_PM
+	tristate "Intel AtomISP v2 dummy / power-management driver"
+	depends on PCI && IOSF_MBI && PM
+	depends on !INTEL_ATOMISP
+	select INTEL_ATOMISP2_PDX86
+	help
+	  Power-management driver for Intel's Image Signal Processor found on
+	  Bay Trail and Cherry Trail devices. This dummy driver's sole purpose
+	  is to turn the ISP off (put it in D3) to save power and to allow
+	  entering of S0ix modes.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_atomisp2_pm.
diff --git a/drivers/platform/x86/intel/atomisp2/Makefile b/drivers/platform/x86/intel/atomisp2/Makefile
new file mode 100644
index 000000000000..96b1e877d1f1
--- /dev/null
+++ b/drivers/platform/x86/intel/atomisp2/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+intel_atomisp2_led-y			:= led.o
+obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
+intel_atomisp2_pm-y			+= pm.o
+obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel/atomisp2/led.c
similarity index 100%
rename from drivers/platform/x86/intel_atomisp2_led.c
rename to drivers/platform/x86/intel/atomisp2/led.c
diff --git a/drivers/platform/x86/intel_atomisp2_pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
similarity index 100%
rename from drivers/platform/x86/intel_atomisp2_pm.c
rename to drivers/platform/x86/intel/atomisp2/pm.c
-- 
2.32.0

