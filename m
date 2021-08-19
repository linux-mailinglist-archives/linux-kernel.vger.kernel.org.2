Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4E3F1E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhHSQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:1247 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhHSQim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203745255"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="203745255"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="679529685"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2021 09:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56E0995F; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 17/21] platform/x86: intel_oaktrail: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:31 +0300
Message-Id: <20210819163735.81803-18-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel Oaktrail driver to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                           | 10 ----------
 drivers/platform/x86/Makefile                          |  1 -
 drivers/platform/x86/intel/Kconfig                     | 10 ++++++++++
 drivers/platform/x86/intel/Makefile                    |  2 ++
 .../x86/{intel_oaktrail.c => intel/oaktrail.c}         |  0
 5 files changed, 12 insertions(+), 11 deletions(-)
 rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c3693ea68e71..abbafb42b7ca 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -668,16 +668,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_OAKTRAIL
-	tristate "Intel Oaktrail Platform Extras"
-	depends on ACPI
-	depends on ACPI_VIDEO || ACPI_VIDEO = n
-	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
-	help
-	  Intel Oaktrail platform need this driver to provide interfaces to
-	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
-	  here; it will only load on supported platforms.
-
 config INTEL_VBTN
 	tristate "INTEL VIRTUAL BUTTON"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index a7be69a2afd2..044c430e8e6f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # MSI
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index a72fa2157b6e..66a9284dc3f8 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -58,6 +58,16 @@ config INTEL_INT0002_VGPIO
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_int0002_vgpio.
 
+config INTEL_OAKTRAIL
+	tristate "Intel Oaktrail Platform Extras"
+	depends on ACPI
+	depends on ACPI_VIDEO || ACPI_VIDEO=n
+	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
+	help
+	  Intel Oaktrail platform need this driver to provide interfaces to
+	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
+	  here; it will only load on supported platforms.
+
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel Broxton Whiskey Cove TMU Driver"
 	depends on INTEL_SOC_PMIC_BXTWC
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 12647076ea0d..dfcf44ad02ed 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 # Intel miscellaneous drivers
 intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
+intel_oaktrail-y			:= oaktrail.o
+obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 
 # Intel PMIC / PMC / P-Unit drivers
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel/oaktrail.c
similarity index 100%
rename from drivers/platform/x86/intel_oaktrail.c
rename to drivers/platform/x86/intel/oaktrail.c
-- 
2.32.0

