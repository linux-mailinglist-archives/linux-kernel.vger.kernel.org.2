Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD793F1E13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhHSQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:38:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:7324 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238716197"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="238716197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="506153657"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F315E59A; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
Subject: [PATCH v4 10/21] platform/x86: intel-smartconnect: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:24 +0300
Message-Id: <20210819163735.81803-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
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
index 3031236fc2e6..2c99c43c166f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1100,20 +1100,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
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
index 5684529d182e..5a9ce0158a82 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -119,7 +119,6 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 014784f58f6b..d9f80932410f 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -84,4 +84,18 @@ config INTEL_RST
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
index 258835e9bd80..8513fbdf3454 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -27,3 +27,5 @@ intel_ips-y				:= ips.o
 obj-$(CONFIG_INTEL_IPS)			+= intel_ips.o
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

