Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C73F2AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhHTLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:15764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239601AbhHTLFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238881733"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="238881733"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="532953486"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2021 04:05:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 061DC647; Fri, 20 Aug 2021 14:05:00 +0300 (EEST)
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
Subject: [PATCH v5 10/20] platform/x86: intel-smartconnect: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:48 +0300
Message-Id: <20210820110458.73018-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel Smart Connect driver to intel sub-directory to improve readability
and rename it from intel-smartconnect.c to smartconnect.c.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                       | 14 --------------
 drivers/platform/x86/Makefile                      |  1 -
 drivers/platform/x86/intel/Kconfig                 | 14 ++++++++++++++
 drivers/platform/x86/intel/Makefile                |  2 ++
 .../{intel-smartconnect.c => intel/smartconnect.c} |  0
 5 files changed, 16 insertions(+), 15 deletions(-)
 rename drivers/platform/x86/{intel-smartconnect.c => intel/smartconnect.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5d5c4046deb6..709f990243b6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1110,20 +1110,6 @@ config INTEL_IPS
 	  functionality.  If in doubt, say Y here; it will only load on
 	  supported platforms.
 
-config INTEL_SMARTCONNECT
-        tristate "Intel Smart Connect disabling driver"
-	depends on ACPI
-	help
-	  Intel Smart Connect is a technology intended to permit devices to
-	  update state by resuming for a short period of time at regular
-	  intervals. If a user enables this functionality under Windows and
-	  then reboots into Linux, the system may remain configured to resume
-	  on suspend. In the absence of any userspace to support it, the system
-	  will then remain awake until something triggers another suspend.
-
-	  This driver checks to determine whether the device has Intel Smart
-	  Connect enabled, and if so disables it.
-
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
 config INTEL_TURBO_MAX_3
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index dd07f40a5927..c0d367455c7a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,7 +120,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
-obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index e4faa7db6b62..39494a8b6a05 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -78,4 +78,18 @@ config INTEL_RST
 	  firmware will copy the memory contents back to RAM and resume the OS
 	  as usual.
 
+config INTEL_SMARTCONNECT
+	tristate "Intel Smart Connect disabling driver"
+	depends on ACPI
+	help
+	  Intel Smart Connect is a technology intended to permit devices to
+	  update state by resuming for a short period of time at regular
+	  intervals. If a user enables this functionality under Windows and
+	  then reboots into Linux, the system may remain configured to resume
+	  on suspend. In the absence of any userspace to support it, the system
+	  will then remain awake until something triggers another suspend.
+
+	  This driver checks to determine whether the device has Intel Smart
+	  Connect enabled, and if so disables it.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 76afe3ca66b8..a62f593b90fa 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -25,3 +25,5 @@ obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
 # Intel Uncore drivers
 intel-rst-y				:= rst.o
 obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
+intel-smartconnect-y			:= smartconnect.o
+obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
diff --git a/drivers/platform/x86/intel-smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
similarity index 100%
rename from drivers/platform/x86/intel-smartconnect.c
rename to drivers/platform/x86/intel/smartconnect.c
-- 
2.32.0

