Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504113ACB77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhFRM52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:57:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:41863 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhFRM5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:57:12 -0400
IronPort-SDR: 36BkAUBa/FdrFuVojpFrVgOPil6rSXBAWHN6hO4sklmOdftg6FsCFcUL//kbda+2XhmHEPVdSZ
 11PH3mqrhNrg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267692219"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="267692219"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:55:03 -0700
IronPort-SDR: E49q3gCvKCtho0CsHzQAj/U/S+Fq7uZgwI9UtqCCu57X/wkVEKTB+3E5JWZFzWWsz80CbXBNIT
 2B1eetkuht7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="404970804"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2021 05:54:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC93E702; Fri, 18 Jun 2021 15:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 7/8] platform/x86: intel_skl_int3472: Move to intel/ subfolder
Date:   Fri, 18 Jun 2021 15:55:15 +0300
Message-Id: <20210618125516.53510-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start collecting Intel x86 related drivers in its own subfolder.
Move intel_skl_int3472 first.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/platform/x86/Kconfig                  |  4 ++--
 drivers/platform/x86/Makefile                 |  3 ++-
 drivers/platform/x86/intel/Kconfig            | 21 +++++++++++++++++++
 drivers/platform/x86/intel/Makefile           |  7 +++++++
 .../{intel-int3472 => intel/int3472}/Kconfig  |  0
 .../{intel-int3472 => intel/int3472}/Makefile |  0
 .../intel_skl_int3472_clk_and_regulator.c     |  0
 .../int3472}/intel_skl_int3472_common.c       |  0
 .../int3472}/intel_skl_int3472_common.h       |  0
 .../int3472}/intel_skl_int3472_discrete.c     |  0
 .../int3472}/intel_skl_int3472_tps68470.c     |  0
 11 files changed, 32 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/x86/intel/Kconfig
 create mode 100644 drivers/platform/x86/intel/Makefile
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/Kconfig (100%)
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/Makefile (100%)
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/intel_skl_int3472_clk_and_regulator.c (100%)
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/intel_skl_int3472_common.c (100%)
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/intel_skl_int3472_common.h (100%)
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/intel_skl_int3472_discrete.c (100%)
 rename drivers/platform/x86/{intel-int3472 => intel/int3472}/intel_skl_int3472_tps68470.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ccb827b57f1f..79d095c0ab61 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -651,6 +651,8 @@ config THINKPAD_LMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called think-lmi.
 
+source "drivers/platform/x86/intel/Kconfig"
+
 config INTEL_ATOMISP2_LED
 	tristate "Intel AtomISP2 camera LED driver"
 	depends on GPIOLIB && LEDS_GPIO
@@ -709,8 +711,6 @@ config INTEL_CHT_INT33FE
 	  device and CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m
 	  for Type-C device.
 
-source "drivers/platform/x86/intel-int3472/Kconfig"
-
 config INTEL_HID_EVENT
 	tristate "INTEL HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index a1f64613af71..e03b59ce3f9f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -66,6 +66,8 @@ obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 
 # Intel
+obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
+
 obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= intel_cht_int33fe.o
@@ -76,7 +78,6 @@ obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
-obj-$(CONFIG_INTEL_SKL_INT3472)		+= intel-int3472/
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # MSI
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
new file mode 100644
index 000000000000..33f2dab03d3d
--- /dev/null
+++ b/drivers/platform/x86/intel/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+menuconfig X86_PLATFORM_DRIVERS_INTEL
+	bool "Intel x86 Platform Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for device drivers for
+	  various Intel x86 platforms, including vendor-specific
+	  drivers. This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped
+	  and disabled.
+
+if X86_PLATFORM_DRIVERS_INTEL
+
+source "drivers/platform/x86/intel/int3472/Kconfig"
+
+endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
new file mode 100644
index 000000000000..3ac795d810f1
--- /dev/null
+++ b/drivers/platform/x86/intel/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for drivers/platform/x86/intel
+# Intel x86 Platform-Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
diff --git a/drivers/platform/x86/intel-int3472/Kconfig b/drivers/platform/x86/intel/int3472/Kconfig
similarity index 100%
rename from drivers/platform/x86/intel-int3472/Kconfig
rename to drivers/platform/x86/intel/int3472/Kconfig
diff --git a/drivers/platform/x86/intel-int3472/Makefile b/drivers/platform/x86/intel/int3472/Makefile
similarity index 100%
rename from drivers/platform/x86/intel-int3472/Makefile
rename to drivers/platform/x86/intel/int3472/Makefile
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_clk_and_regulator.c
similarity index 100%
rename from drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
rename to drivers/platform/x86/intel/int3472/intel_skl_int3472_clk_and_regulator.c
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
similarity index 100%
rename from drivers/platform/x86/intel-int3472/intel_skl_int3472_common.c
rename to drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h b/drivers/platform/x86/intel/int3472/intel_skl_int3472_common.h
similarity index 100%
rename from drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
rename to drivers/platform/x86/intel/int3472/intel_skl_int3472_common.h
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_discrete.c
similarity index 100%
rename from drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
rename to drivers/platform/x86/intel/int3472/intel_skl_int3472_discrete.c
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_tps68470.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
similarity index 100%
rename from drivers/platform/x86/intel-int3472/intel_skl_int3472_tps68470.c
rename to drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
-- 
2.30.2

