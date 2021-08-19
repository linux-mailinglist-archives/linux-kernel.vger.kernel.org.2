Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2813F1E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhHSQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:1924 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhHSQim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="280332712"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="280332712"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="681847603"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2021 09:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D7EB707; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 15/21] platform/x86: intel-hid: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:29 +0300
Message-Id: <20210819163735.81803-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel HID driver to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                       |  2 +-
 drivers/platform/x86/Kconfig                      | 13 -------------
 drivers/platform/x86/Makefile                     |  1 -
 drivers/platform/x86/intel/Kconfig                | 13 +++++++++++++
 drivers/platform/x86/intel/Makefile               |  4 ++++
 drivers/platform/x86/{intel-hid.c => intel/hid.c} |  2 +-
 6 files changed, 19 insertions(+), 16 deletions(-)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce79ad253afe..5d25d0d9f1a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9321,7 +9321,7 @@ INTEL HID EVENT DRIVER
 M:	Alex Hung <alex.hung@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel-hid.c
+F:	drivers/platform/x86/intel/hid.c
 
 INTEL I/OAT DMA DRIVER
 M:	Dave Jiang <dave.jiang@intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index feca8ae551a1..7f3912c16338 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -668,19 +668,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_HID_EVENT
-	tristate "INTEL HID Event"
-	depends on ACPI
-	depends on INPUT
-	depends on I2C
-	select INPUT_SPARSEKMAP
-	help
-	  This driver provides support for the Intel HID Event hotkey interface.
-	  Some laptops require this driver for hotkey support.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_hid.
-
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
 	depends on GPIOLIB && ACPI && PM_SLEEP
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1f3e48a1721f..2a8f03f89273 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 351640511eee..b97061e85a3d 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -26,6 +26,19 @@ source "drivers/platform/x86/intel/scu/Kconfig"
 source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 
+config INTEL_HID_EVENT
+	tristate "Intel HID Event"
+	depends on ACPI
+	depends on INPUT
+	depends on I2C
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for the Intel HID Event hotkey interface.
+	  Some laptops require this driver for hotkey support.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_hid.
+
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel Broxton Whiskey Cove TMU Driver"
 	depends on INTEL_SOC_PMIC_BXTWC
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index e5ea0e8ba516..8bfa9fb0a528 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -14,6 +14,10 @@ obj-$(CONFIG_INTEL_SCU)			+= scu/
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += speed_select_if/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
+# Intel input drivers
+intel-hid-y				:= hid.o
+obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
+
 # Intel PMIC / PMC / P-Unit drivers
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel/hid.c
similarity index 99%
rename from drivers/platform/x86/intel-hid.c
rename to drivers/platform/x86/intel/hid.c
index 2e4e97a626a5..a33a5826e81a 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
-#include "dual_accel_detect.h"
+#include "../dual_accel_detect.h"
 
 /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
 #define TABLET_MODE_FLAG BIT(6)
-- 
2.32.0

