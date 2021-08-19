Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7965C3F1E19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhHSQjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:9173 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhHSQik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277617374"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="277617374"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="679529654"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0AF49629; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 11/21] platform/x86: intel_turbo_max_3: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:25 +0300
Message-Id: <20210819163735.81803-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
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
index 2c99c43c166f..e43b8f1e7ec6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1102,16 +1102,6 @@ config INTEL_IMR
 
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
index 5a9ce0158a82..fd44f1c13064 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,7 +120,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index d9f80932410f..afede107a805 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -98,4 +98,15 @@ config INTEL_SMARTCONNECT
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
index 8513fbdf3454..62f8a1421c47 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -29,3 +29,5 @@ intel-rst-y				:= rst.o
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

