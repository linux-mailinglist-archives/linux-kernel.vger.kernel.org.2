Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847C3F1E15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhHSQi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:38:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:5070 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="196853716"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="196853716"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="522506742"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E69BA487; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
Subject: [PATCH v4 09/21] platform/x86: intel-rst: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:23 +0300
Message-Id: <20210819163735.81803-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
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
 drivers/platform/x86/intel/Makefile               |  2 ++
 drivers/platform/x86/{intel-rst.c => intel/rst.c} |  0
 5 files changed, 14 insertions(+), 13 deletions(-)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 27af97d1407a..3031236fc2e6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1100,18 +1100,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
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
index fef347925d81..5684529d182e 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -119,7 +119,6 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 5f1dc8b1a874..014784f58f6b 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -72,4 +72,16 @@ config INTEL_IPS
 	  functionality. If in doubt, say Y here; it will only load on
 	  supported platforms.
 
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
index 77cb50b90e67..258835e9bd80 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -25,3 +25,5 @@ obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 # Intel Uncore drivers
 intel_ips-y				:= ips.o
 obj-$(CONFIG_INTEL_IPS)			+= intel_ips.o
+intel-rst-y				:= rst.o
+obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel/rst.c
similarity index 100%
rename from drivers/platform/x86/intel-rst.c
rename to drivers/platform/x86/intel/rst.c
-- 
2.32.0

