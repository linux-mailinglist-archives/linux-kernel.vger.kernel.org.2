Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF33F1E22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhHSQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:9173 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhHSQis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277617391"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="277617391"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="679529683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2021 09:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E8BEA2A; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 19/21] platform/x86: intel-wmi-sbl-fw-update: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:33 +0300
Message-Id: <20210819163735.81803-20-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel WMI Slim Bootloader FW update driver to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                    |  2 +-
 drivers/platform/x86/Kconfig                   | 10 ----------
 drivers/platform/x86/Makefile                  |  1 -
 drivers/platform/x86/intel/Kconfig             |  1 +
 drivers/platform/x86/intel/Makefile            |  1 +
 drivers/platform/x86/intel/wmi/Kconfig         | 18 ++++++++++++++++++
 drivers/platform/x86/intel/wmi/Makefile        |  7 +++++++
 .../wmi/sbl-fw-update.c}                       |  0
 8 files changed, 28 insertions(+), 12 deletions(-)
 create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
 create mode 100644 drivers/platform/x86/intel/wmi/Makefile
 rename drivers/platform/x86/{intel-wmi-sbl-fw-update.c => intel/wmi/sbl-fw-update.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d2f26f13248..ee49f50f317a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9592,7 +9592,7 @@ M:	Jithu Joseph <jithu.joseph@intel.com>
 R:	Maurice Ma <maurice.ma@intel.com>
 S:	Maintained
 W:	https://slimbootloader.github.io/security/firmware-update.html
-F:	drivers/platform/x86/intel-wmi-sbl-fw-update.c
+F:	drivers/platform/x86/intel/wmi/sbl-fw-update.c
 
 INTEL WMI THUNDERBOLT FORCE POWER DRIVER
 L:	Dell.Client.Kernel@dell.com
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 555d2ed8e4e1..7bbbc5e2053b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -77,16 +77,6 @@ config UV_SYSFS
 	  To compile this driver as a module, choose M here: the module will
 	  be called uv_sysfs.
 
-config INTEL_WMI_SBL_FW_UPDATE
-	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
-	depends on ACPI_WMI
-	help
-	  Say Y here if you want to be able to use the WMI interface to signal
-	  Slim Bootloader to trigger update on next reboot.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel-wmi-sbl-fw-update.
-
 config INTEL_WMI_THUNDERBOLT
 	tristate "Intel WMI thunderbolt force power driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ec6a8c369e70..9a4309c93c0d 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
-obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index a2f2675e5c34..453dc98a009e 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -25,6 +25,7 @@ source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
 source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
+source "drivers/platform/x86/intel/wmi/Kconfig"
 
 config INTEL_HID_EVENT
 	tristate "Intel HID Event"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 41b88d912de5..cfc3a1f3a048 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_SCU)			+= scu/
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += speed_select_if/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
+obj-$(CONFIG_INTEL_WMI)			+= wmi/
 
 # Intel input drivers
 intel-hid-y				:= hid.o
diff --git a/drivers/platform/x86/intel/wmi/Kconfig b/drivers/platform/x86/intel/wmi/Kconfig
new file mode 100644
index 000000000000..c5753b1e8f43
--- /dev/null
+++ b/drivers/platform/x86/intel/wmi/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_WMI
+	bool
+
+config INTEL_WMI_SBL_FW_UPDATE
+	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
+	depends on ACPI_WMI
+	select INTEL_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface to signal
+	  Slim Bootloader to trigger update on next reboot.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-sbl-fw-update.
diff --git a/drivers/platform/x86/intel/wmi/Makefile b/drivers/platform/x86/intel/wmi/Makefile
new file mode 100644
index 000000000000..bf1f118b6839
--- /dev/null
+++ b/drivers/platform/x86/intel/wmi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+intel-wmi-sbl-fw-update-y				:= sbl-fw-update.o
+obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
diff --git a/drivers/platform/x86/intel-wmi-sbl-fw-update.c b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
similarity index 100%
rename from drivers/platform/x86/intel-wmi-sbl-fw-update.c
rename to drivers/platform/x86/intel/wmi/sbl-fw-update.c
-- 
2.32.0

