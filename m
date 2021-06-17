Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB33ABBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhFQSdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:33:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:41916 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhFQSdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:33:00 -0400
IronPort-SDR: 1+8jNpWjqZw7/1nktWeQ02rieYU7V2VW+MPdfcIX61CwomdUmpNd5NkH75es0HIT9UFe9Z2o5r
 dNQzjxL1Koyw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267575194"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267575194"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 11:30:51 -0700
IronPort-SDR: /A6QnV/C6ydYqXLbvM73szmHefaiTET/74wsxacq2VOhMtJKAHVvb5JI+hSfjmcHwaYsZbVE0V
 HITqWwft7eUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="485381105"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2021 11:30:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03BFB431; Thu, 17 Jun 2021 21:31:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v1 4/4] platform/x86: intel_cht_int33fe: Move to its own subfolder
Date:   Thu, 17 Jun 2021 21:30:31 +0300
Message-Id: <20210617183031.70685-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617183031.70685-1-andriy.shevchenko@linux.intel.com>
References: <20210617183031.70685-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have started collecting Intel x86 specific drivers in its own folder,
Move intel_cht_int33fe to own subfolder there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                  | 24 ------------------
 drivers/platform/x86/Makefile                 |  4 ---
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/int33fe/Kconfig    | 25 +++++++++++++++++++
 drivers/platform/x86/intel/int33fe/Makefile   |  5 ++++
 .../int33fe}/intel_cht_int33fe_common.c       |  0
 .../int33fe}/intel_cht_int33fe_common.h       |  0
 .../int33fe}/intel_cht_int33fe_microb.c       |  0
 .../int33fe}/intel_cht_int33fe_typec.c        |  0
 10 files changed, 32 insertions(+), 28 deletions(-)
 create mode 100644 drivers/platform/x86/intel/int33fe/Kconfig
 create mode 100644 drivers/platform/x86/intel/int33fe/Makefile
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_common.c (100%)
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_common.h (100%)
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_microb.c (100%)
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_typec.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 79d095c0ab61..7d385c3b2239 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -687,30 +687,6 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
-config INTEL_CHT_INT33FE
-	tristate "Intel Cherry Trail ACPI INT33FE Driver"
-	depends on X86 && ACPI && I2C && REGULATOR
-	depends on CHARGER_BQ24190=y || (CHARGER_BQ24190=m && m)
-	depends on USB_ROLES_INTEL_XHCI=y || (USB_ROLES_INTEL_XHCI=m && m)
-	depends on TYPEC_MUX_PI3USB30532=y || (TYPEC_MUX_PI3USB30532=m && m)
-	help
-	  This driver add support for the INT33FE ACPI device found on
-	  some Intel Cherry Trail devices.
-
-	  There are two kinds of INT33FE ACPI device possible: for hardware
-	  with USB Type-C and Micro-B connectors. This driver supports both.
-
-	  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
-	  resources for Fuel Gauge Controller and (in the Type-C variant)
-	  FUSB302 USB Type-C Controller and PI3USB30532 USB switch.
-	  This driver instantiates i2c-clients for these, so that standard
-	  i2c drivers for these chips can bind to the them.
-
-	  If you enable this driver it is advised to also select
-	  CONFIG_BATTERY_BQ27XXX=m or CONFIG_BATTERY_BQ27XXX_I2C=m for Micro-B
-	  device and CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m
-	  for Type-C device.
-
 config INTEL_HID_EVENT
 	tristate "INTEL HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e03b59ce3f9f..7ee369aab10d 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -70,10 +70,6 @@ obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
 obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
-obj-$(CONFIG_INTEL_CHT_INT33FE)		+= intel_cht_int33fe.o
-intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
-					   intel_cht_int33fe_typec.o \
-					   intel_cht_int33fe_microb.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 33f2dab03d3d..f2eef337eb98 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -16,6 +16,7 @@ menuconfig X86_PLATFORM_DRIVERS_INTEL
 
 if X86_PLATFORM_DRIVERS_INTEL
 
+source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 3ac795d810f1..0653055942d5 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -4,4 +4,5 @@
 # Intel x86 Platform-Specific Drivers
 #
 
+obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
diff --git a/drivers/platform/x86/intel/int33fe/Kconfig b/drivers/platform/x86/intel/int33fe/Kconfig
new file mode 100644
index 000000000000..c7efb461d97d
--- /dev/null
+++ b/drivers/platform/x86/intel/int33fe/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTEL_CHT_INT33FE
+	tristate "Intel Cherry Trail ACPI INT33FE Driver"
+	depends on X86 && ACPI && I2C && REGULATOR
+	depends on CHARGER_BQ24190=y || (CHARGER_BQ24190=m && m)
+	depends on USB_ROLES_INTEL_XHCI=y || (USB_ROLES_INTEL_XHCI=m && m)
+	depends on TYPEC_MUX_PI3USB30532=y || (TYPEC_MUX_PI3USB30532=m && m)
+	help
+	  This driver add support for the INT33FE ACPI device found on
+	  some Intel Cherry Trail devices.
+
+	  There are two kinds of INT33FE ACPI device possible: for hardware
+	  with USB Type-C and Micro-B connectors. This driver supports both.
+
+	  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
+	  resources for Fuel Gauge Controller and (in the Type-C variant)
+	  FUSB302 USB Type-C Controller and PI3USB30532 USB switch.
+	  This driver instantiates i2c-clients for these, so that standard
+	  i2c drivers for these chips can bind to the them.
+
+	  If you enable this driver it is advised to also select
+	  CONFIG_BATTERY_BQ27XXX=m or CONFIG_BATTERY_BQ27XXX_I2C=m for Micro-B
+	  device and CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m
+	  for Type-C device.
+
diff --git a/drivers/platform/x86/intel/int33fe/Makefile b/drivers/platform/x86/intel/int33fe/Makefile
new file mode 100644
index 000000000000..cc11183ce179
--- /dev/null
+++ b/drivers/platform/x86/intel/int33fe/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_INTEL_CHT_INT33FE)		+= intel_cht_int33fe.o
+intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
+					   intel_cht_int33fe_typec.o \
+					   intel_cht_int33fe_microb.o
diff --git a/drivers/platform/x86/intel_cht_int33fe_common.c b/drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.c
similarity index 100%
rename from drivers/platform/x86/intel_cht_int33fe_common.c
rename to drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.c
diff --git a/drivers/platform/x86/intel_cht_int33fe_common.h b/drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.h
similarity index 100%
rename from drivers/platform/x86/intel_cht_int33fe_common.h
rename to drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.h
diff --git a/drivers/platform/x86/intel_cht_int33fe_microb.c b/drivers/platform/x86/intel/int33fe/intel_cht_int33fe_microb.c
similarity index 100%
rename from drivers/platform/x86/intel_cht_int33fe_microb.c
rename to drivers/platform/x86/intel/int33fe/intel_cht_int33fe_microb.c
diff --git a/drivers/platform/x86/intel_cht_int33fe_typec.c b/drivers/platform/x86/intel/int33fe/intel_cht_int33fe_typec.c
similarity index 100%
rename from drivers/platform/x86/intel_cht_int33fe_typec.c
rename to drivers/platform/x86/intel/int33fe/intel_cht_int33fe_typec.c
-- 
2.30.2

