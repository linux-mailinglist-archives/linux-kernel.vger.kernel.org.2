Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C83F1E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhHSQis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:38:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:38684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216630814"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216630814"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="512158778"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 17004647; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 12/21] platform/x86: intel-uncore-frequency: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:26 +0300
Message-Id: <20210819163735.81803-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel Uncore frequency driver to intel sub-directory to improve
readability and rename it from intel-uncore-frequency.c to
uncore-frequency.c.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                          |  2 +-
 drivers/platform/x86/Kconfig                         | 11 -----------
 drivers/platform/x86/Makefile                        |  1 -
 drivers/platform/x86/intel/Kconfig                   | 12 ++++++++++++
 drivers/platform/x86/intel/Makefile                  |  2 ++
 .../uncore-frequency.c}                              |  0
 6 files changed, 15 insertions(+), 13 deletions(-)
 rename drivers/platform/x86/{intel-uncore-frequency.c => intel/uncore-frequency.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c73e6216142..d8cf3d267aaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9565,7 +9565,7 @@ INTEL UNCORE FREQUENCY CONTROL
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel-uncore-frequency.c
+F:	drivers/platform/x86/intel/uncore-frequency.c
 
 INTEL VIRTUAL BUTTON DRIVER
 M:	AceLan Kao <acelan.kao@canonical.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e43b8f1e7ec6..f716f4ad0d79 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1102,17 +1102,6 @@ config INTEL_IMR
 
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
-config INTEL_UNCORE_FREQ_CONTROL
-	tristate "Intel Uncore frequency control driver"
-	depends on X86_64
-	help
-	  This driver allows control of uncore frequency limits on
-	  supported server platforms.
-	  Uncore frequency controls RING/LLC (last-level cache) clocks.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-uncore-frequency.
-
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index fd44f1c13064..80e75115a7bb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,6 +120,5 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index afede107a805..1e40591f9e37 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -109,4 +109,16 @@ config INTEL_TURBO_MAX_3
 	  This driver is only required when the system is not using Hardware
 	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
 
+config INTEL_UNCORE_FREQ_CONTROL
+	tristate "Intel Uncore frequency control driver"
+	depends on X86_64
+	help
+	  This driver allows control of Uncore frequency limits on
+	  supported server platforms.
+
+	  Uncore frequency controls RING/LLC (last-level cache) clocks.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-uncore-frequency.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 62f8a1421c47..0f6b60124309 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -31,3 +31,5 @@ intel-smartconnect-y			:= smartconnect.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
 intel_turbo_max_3-y			:= turbo_max_3.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3)		+= intel_turbo_max_3.o
+intel-uncore-frequency-y		:= uncore-frequency.o
+obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)	+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel-uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency.c
similarity index 100%
rename from drivers/platform/x86/intel-uncore-frequency.c
rename to drivers/platform/x86/intel/uncore-frequency.c
-- 
2.32.0

