Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBB3F1E18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhHSQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:1924 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="280332701"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="280332701"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="681847599"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2021 09:37:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2394F683; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 13/21] platform/x86: intel_speed_select_if: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:27 +0300
Message-Id: <20210819163735.81803-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel Speed Select interface driver to intel sub-directory to improve
readability and rename it from intel_speed_select_if to speed_select_if.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                                    | 2 +-
 drivers/platform/x86/Kconfig                                   | 2 --
 drivers/platform/x86/Makefile                                  | 3 ---
 drivers/platform/x86/intel/Kconfig                             | 1 +
 drivers/platform/x86/intel/Makefile                            | 1 +
 .../{intel_speed_select_if => intel/speed_select_if}/Kconfig   | 0
 .../{intel_speed_select_if => intel/speed_select_if}/Makefile  | 0
 .../speed_select_if}/isst_if_common.c                          | 0
 .../speed_select_if}/isst_if_common.h                          | 0
 .../speed_select_if}/isst_if_mbox_msr.c                        | 0
 .../speed_select_if}/isst_if_mbox_pci.c                        | 0
 .../speed_select_if}/isst_if_mmio.c                            | 0
 12 files changed, 3 insertions(+), 6 deletions(-)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Kconfig (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Makefile (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.h (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_msr.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_pci.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mmio.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8cf3d267aaf..bb8e848a0f83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9538,7 +9538,7 @@ INTEL SPEED SELECT TECHNOLOGY
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel_speed_select_if/
+F:	drivers/platform/x86/intel/speed_select_if/
 F:	include/uapi/linux/isst_if.h
 F:	tools/power/x86/intel-speed-select/
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f716f4ad0d79..2c80597cfa4d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1100,8 +1100,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-source "drivers/platform/x86/intel_speed_select_if/Kconfig"
-
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 80e75115a7bb..6fd63ff22e38 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -118,7 +118,4 @@ obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
-# Intel uncore drivers
-obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 1e40591f9e37..02a2161894d2 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -22,6 +22,7 @@ source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
+source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 
 config INTEL_BXTWC_PMIC_TMU
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 0f6b60124309..5b45acd32591 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_SCU)			+= scu/
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += speed_select_if/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
 # Intel PMIC / PMC / P-Unit drivers
diff --git a/drivers/platform/x86/intel_speed_select_if/Kconfig b/drivers/platform/x86/intel/speed_select_if/Kconfig
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/Kconfig
rename to drivers/platform/x86/intel/speed_select_if/Kconfig
diff --git a/drivers/platform/x86/intel_speed_select_if/Makefile b/drivers/platform/x86/intel/speed_select_if/Makefile
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/Makefile
rename to drivers/platform/x86/intel/speed_select_if/Makefile
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_common.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_common.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_common.h
rename to drivers/platform/x86/intel/speed_select_if/isst_if_common.h
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
-- 
2.32.0

