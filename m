Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A823F1E20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhHSQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:41626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhHSQio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="302182630"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="302182630"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="442321548"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2021 09:38:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6284D990; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 18/21] platform/x86: intel-vbtn: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:32 +0300
Message-Id: <20210819163735.81803-19-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel vButton driver to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                         |  2 +-
 drivers/platform/x86/Kconfig                        | 13 -------------
 drivers/platform/x86/Makefile                       |  2 --
 drivers/platform/x86/intel/Kconfig                  | 13 +++++++++++++
 drivers/platform/x86/intel/Makefile                 |  2 ++
 drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)
 rename drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d25d0d9f1a6..4d2f26f13248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9571,7 +9571,7 @@ INTEL VIRTUAL BUTTON DRIVER
 M:	AceLan Kao <acelan.kao@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel-vbtn.c
+F:	drivers/platform/x86/intel/vbtn.c
 
 INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index abbafb42b7ca..555d2ed8e4e1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -668,19 +668,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_VBTN
-	tristate "INTEL VIRTUAL BUTTON"
-	depends on ACPI
-	depends on INPUT
-	depends on I2C
-	select INPUT_SPARSEKMAP
-	help
-	  This driver provides support for the Intel Virtual Button interface.
-	  Some laptops require this driver for power button support.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_vbtn.
-
 config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 044c430e8e6f..ec6a8c369e70 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,8 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
-
 # MSI
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 66a9284dc3f8..a2f2675e5c34 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -39,6 +39,19 @@ config INTEL_HID_EVENT
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_hid.
 
+config INTEL_VBTN
+	tristate "Intel Virtual Button"
+	depends on ACPI
+	depends on INPUT
+	depends on I2C
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for the Intel Virtual Button interface.
+	  Some laptops require this driver for power button support.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_vbtn.
+
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
 	depends on GPIOLIB && ACPI && PM_SLEEP
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index dfcf44ad02ed..41b88d912de5 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 # Intel input drivers
 intel-hid-y				:= hid.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
+intel-vbtn-y				:= vbtn.o
+obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # Intel miscellaneous drivers
 intel_int0002_vgpio-y			:= int0002_vgpio.o
diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel/vbtn.c
similarity index 99%
rename from drivers/platform/x86/intel-vbtn.c
rename to drivers/platform/x86/intel/vbtn.c
index 309166431063..15f013af9e62 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
-#include "dual_accel_detect.h"
+#include "../dual_accel_detect.h"
 
 /* Returned when NOT in tablet mode on some HP Stream x360 11 models */
 #define VGBS_TABLET_MODE_FLAG_ALT	0x10
-- 
2.32.0

