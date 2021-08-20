Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38023F2AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhHTLGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:1505 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239496AbhHTLFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203951731"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="203951731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="642096225"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2021 04:05:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2BD8A707; Fri, 20 Aug 2021 14:05:01 +0300 (EEST)
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
Subject: [PATCH v5 13/20] platform/x86: intel_speed_select_if: Move to intel sub-directory
Date:   Fri, 20 Aug 2021 14:04:51 +0300
Message-Id: <20210820110458.73018-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
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
 MAINTAINERS                                                     | 2 +-
 drivers/platform/x86/Kconfig                                    | 2 --
 drivers/platform/x86/Makefile                                   | 1 -
 drivers/platform/x86/intel/Kconfig                              | 1 +
 drivers/platform/x86/intel/Makefile                             | 1 +
 .../{intel_speed_select_if => intel/speed_select_if}/Kconfig    | 0
 .../{intel_speed_select_if => intel/speed_select_if}/Makefile   | 0
 .../speed_select_if}/isst_if_common.c                           | 0
 .../speed_select_if}/isst_if_common.h                           | 0
 .../speed_select_if}/isst_if_mbox_msr.c                         | 0
 .../speed_select_if}/isst_if_mbox_pci.c                         | 0
 .../speed_select_if}/isst_if_mmio.c                             | 0
 12 files changed, 3 insertions(+), 4 deletions(-)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Kconfig (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Makefile (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.h (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_msr.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_pci.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mmio.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fe92c8e9214..cf29f7154889 100644
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
index 138c44d08e93..55820fc60a63 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1110,8 +1110,6 @@ config INTEL_IPS
 	  functionality.  If in doubt, say Y here; it will only load on
 	  supported platforms.
 
-source "drivers/platform/x86/intel_speed_select_if/Kconfig"
-
 config INTEL_SCU_IPC
 	bool
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index fe064b303732..1b1f4337a77f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,7 +120,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
-obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 9c682e8c2972..0c044b31e822 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -21,6 +21,7 @@ source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
+source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 
 config INTEL_BXTWC_PMIC_TMU
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index b16c17b317dc..9858657f3f39 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
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

