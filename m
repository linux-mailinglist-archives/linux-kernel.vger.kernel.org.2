Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51473F1E14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhHSQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:38:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:9173 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhHSQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277617372"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="277617372"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="679529652"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2021 09:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA6AB411; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
Subject: [PATCH v4 08/21] platform/x86: intel_ips: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:22 +0300
Message-Id: <20210819163735.81803-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel IPS driver to intel sub-directory to improve readability
and rename it from intel_ips.c to ips.c.

The header file is deliberately left untouched and will be moved
as part of DRM subsystem development.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig                      | 10 ----------
 drivers/platform/x86/Makefile                     |  1 -
 drivers/platform/x86/intel/Kconfig                | 10 ++++++++++
 drivers/platform/x86/intel/Makefile               |  4 ++++
 drivers/platform/x86/{intel_ips.c => intel/ips.c} |  3 ++-
 5 files changed, 16 insertions(+), 12 deletions(-)
 rename drivers/platform/x86/{intel_ips.c => intel/ips.c} (99%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b6e32551a8f5..27af97d1407a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1100,16 +1100,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-config INTEL_IPS
-	tristate "Intel Intelligent Power Sharing"
-	depends on ACPI && PCI
-	help
-	  Intel Calpella platforms support dynamic power sharing between the
-	  CPU and GPU, maximizing performance in a given TDP.  This driver,
-	  along with the CPU frequency and i915 drivers, provides that
-	  functionality.  If in doubt, say Y here; it will only load on
-	  supported platforms.
-
 config INTEL_RST
         tristate "Intel Rapid Start Technology Driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 633cc14eba2c..fef347925d81 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -119,7 +119,6 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
 obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index bedd3bdb0662..5f1dc8b1a874 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -62,4 +62,14 @@ config INTEL_PUNIT_IPC
 	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
 	  which is used to bridge the communications between kernel and P-Unit.
 
+config INTEL_IPS
+	tristate "Intel Intelligent Power Sharing"
+	depends on ACPI && PCI
+	help
+	  Intel Calpella platforms support dynamic power sharing between
+	  the CPU and GPU, maximizing performance in a given TDP. This driver,
+	  along with the CPU frequency and i915 drivers, provides that
+	  functionality. If in doubt, say Y here; it will only load on
+	  supported platforms.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index d446771dbff2..77cb50b90e67 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -21,3 +21,7 @@ intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 intel_punit_ipc-y			:= punit_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
+
+# Intel Uncore drivers
+intel_ips-y				:= ips.o
+obj-$(CONFIG_INTEL_IPS)			+= intel_ips.o
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel/ips.c
similarity index 99%
rename from drivers/platform/x86/intel_ips.c
rename to drivers/platform/x86/intel/ips.c
index 4dfdbfca6841..0c86bdbcc5d5 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel/ips.c
@@ -62,7 +62,8 @@
 #include <drm/i915_drm.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
-#include "intel_ips.h"
+
+#include "../intel_ips.h"
 
 #include <linux/io-64-nonatomic-lo-hi.h>
 
-- 
2.32.0

