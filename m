Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6EB3F2AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbhHTLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:54047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240229AbhHTLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:06:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213630982"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="213630982"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="573922367"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2021 04:05:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1325E683; Fri, 20 Aug 2021 14:05:01 +0300 (EEST)
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
Subject: [PATCH v5 11/20] platform/x86: intel_turbo_max_3: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:49 +0300
Message-Id: <20210820110458.73018-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel Turbo Max 3 driver to intel sub-directory to improve readability
and rename it from intel_turbo_max_3.c to turbo_max_3.c.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                          | 10 ----------
 drivers/platform/x86/Makefile                         |  1 -
 drivers/platform/x86/intel/Kconfig                    | 11 +++++++++++
 drivers/platform/x86/intel/Makefile                   |  2 ++
 .../x86/{intel_turbo_max_3.c => intel/turbo_max_3.c}  |  0
 5 files changed, 13 insertions(+), 11 deletions(-)
 rename drivers/platform/x86/{intel_turbo_max_3.c => intel/turbo_max_3.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 709f990243b6..0c645fcb09c5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1112,16 +1112,6 @@ config INTEL_IPS
 
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
-config INTEL_TURBO_MAX_3
-	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
-	depends on X86_64 && SCHED_MC_PRIO
-	help
-	  This driver reads maximum performance ratio of each CPU and set up
-	  the scheduler priority metrics. In this way scheduler can prefer
-	  CPU with higher performance to schedule tasks.
-	  This driver is only required when the system is not using Hardware
-	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
-
 config INTEL_UNCORE_FREQ_CONTROL
 	tristate "Intel Uncore frequency control driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c0d367455c7a..531cdac793d8 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -121,7 +121,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 39494a8b6a05..ccaaf93717bd 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -92,4 +92,15 @@ config INTEL_SMARTCONNECT
 	  This driver checks to determine whether the device has Intel Smart
 	  Connect enabled, and if so disables it.
 
+config INTEL_TURBO_MAX_3
+	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
+	depends on X86_64 && SCHED_MC_PRIO
+	help
+	  This driver reads maximum performance ratio of each CPU and set up
+	  the scheduler priority metrics. In this way scheduler can prefer
+	  CPU with higher performance to schedule tasks.
+
+	  This driver is only required when the system is not using Hardware
+	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index a62f593b90fa..ffeeecd513d8 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -27,3 +27,5 @@ intel-rst-y				:= rst.o
 obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
 intel-smartconnect-y			:= smartconnect.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
+intel_turbo_max_3-y			:= turbo_max_3.o
+obj-$(CONFIG_INTEL_TURBO_MAX_3)		+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
similarity index 100%
rename from drivers/platform/x86/intel_turbo_max_3.c
rename to drivers/platform/x86/intel/turbo_max_3.c
-- 
2.32.0

