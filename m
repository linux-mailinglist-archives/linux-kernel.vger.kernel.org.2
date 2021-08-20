Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034023F2A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbhHTLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:15772 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239575AbhHTLFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238881734"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="238881734"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="532953488"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2021 04:05:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED8F4629; Fri, 20 Aug 2021 14:05:00 +0300 (EEST)
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
Subject: [PATCH v5 09/20] platform/x86: intel-rst: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:47 +0300
Message-Id: <20210820110458.73018-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel RST driver to intel sub-directory to improve readability
and rename it from intel-rst.c to rst.c.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                      | 12 ------------
 drivers/platform/x86/Makefile                     |  1 -
 drivers/platform/x86/intel/Kconfig                | 12 ++++++++++++
 drivers/platform/x86/intel/Makefile               |  4 ++++
 drivers/platform/x86/{intel-rst.c => intel/rst.c} |  0
 5 files changed, 16 insertions(+), 13 deletions(-)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index d12b40ab079d..5d5c4046deb6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1110,18 +1110,6 @@ config INTEL_IPS
 	  functionality.  If in doubt, say Y here; it will only load on
 	  supported platforms.
 
-config INTEL_RST
-        tristate "Intel Rapid Start Technology Driver"
-	depends on ACPI
-	help
-	  This driver provides support for modifying parameters on systems
-	  equipped with Intel's Rapid Start Technology. When put in an ACPI
-	  sleep state, these devices will wake after either a configured
-	  timeout or when the system battery reaches a critical state,
-	  automatically copying memory contents to disk. On resume, the
-	  firmware will copy the memory contents back to RAM and resume the OS
-	  as usual.
-
 config INTEL_SMARTCONNECT
         tristate "Intel Smart Connect disabling driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index eae2be9b01e5..dd07f40a5927 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,7 +120,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
-obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 71f131de5a56..e4faa7db6b62 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -66,4 +66,16 @@ config PMC_ATOM
        depends on PCI
        select COMMON_CLK
 
+config INTEL_RST
+	tristate "Intel Rapid Start Technology Driver"
+	depends on ACPI
+	help
+	  This driver provides support for modifying parameters on systems
+	  equipped with Intel's Rapid Start Technology. When put in an ACPI
+	  sleep state, these devices will wake after either a configured
+	  timeout or when the system battery reaches a critical state,
+	  automatically copying memory contents to disk. On resume, the
+	  firmware will copy the memory contents back to RAM and resume the OS
+	  as usual.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index c52f6215a310..76afe3ca66b8 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -21,3 +21,7 @@ obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 intel_punit_ipc-y			:= punit_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
+
+# Intel Uncore drivers
+intel-rst-y				:= rst.o
+obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel/rst.c
similarity index 100%
rename from drivers/platform/x86/intel-rst.c
rename to drivers/platform/x86/intel/rst.c
-- 
2.32.0

