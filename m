Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536DE3F1E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhHSQjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:39:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:7324 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhHSQin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238716210"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="238716210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="506153684"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2021 09:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A5EDB05; Thu, 19 Aug 2021 19:37:53 +0300 (EEST)
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
Subject: [PATCH v4 20/21] platform/x86: intel-wmi-thunderbolt: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 19:37:34 +0300
Message-Id: <20210819163735.81803-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kate Hsuan <hpa@redhat.com>

Move Intel WMI Thunderbolt driver to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                         |  2 +-
 drivers/platform/x86/Kconfig                        | 12 ------------
 drivers/platform/x86/Makefile                       |  1 -
 drivers/platform/x86/intel/wmi/Kconfig              | 13 +++++++++++++
 drivers/platform/x86/intel/wmi/Makefile             |  2 ++
 .../wmi/thunderbolt.c}                              |  0
 6 files changed, 16 insertions(+), 14 deletions(-)
 rename drivers/platform/x86/{intel-wmi-thunderbolt.c => intel/wmi/thunderbolt.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee49f50f317a..cf9b2a501552 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9597,7 +9597,7 @@ F:	drivers/platform/x86/intel/wmi/sbl-fw-update.c
 INTEL WMI THUNDERBOLT FORCE POWER DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
-F:	drivers/platform/x86/intel-wmi-thunderbolt.c
+F:	drivers/platform/x86/intel/wmi/thunderbolt.c
 
 INTEL WWAN IOSM DRIVER
 M:	M Chetan Kumar <m.chetan.kumar@intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7bbbc5e2053b..f850ac7a7dec 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -77,18 +77,6 @@ config UV_SYSFS
 	  To compile this driver as a module, choose M here: the module will
 	  be called uv_sysfs.
 
-config INTEL_WMI_THUNDERBOLT
-	tristate "Intel WMI thunderbolt force power driver"
-	depends on ACPI_WMI
-	help
-	  Say Y here if you want to be able to use the WMI interface on select
-	  systems to force the power control of Intel Thunderbolt controllers.
-	  This is useful for updating the firmware when devices are not plugged
-	  into the controller.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel-wmi-thunderbolt.
-
 config MXM_WMI
        tristate "WMI support for MXM Laptop Graphics"
        depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 9a4309c93c0d..97194707b9d7 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
-obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
diff --git a/drivers/platform/x86/intel/wmi/Kconfig b/drivers/platform/x86/intel/wmi/Kconfig
index c5753b1e8f43..8e159f712179 100644
--- a/drivers/platform/x86/intel/wmi/Kconfig
+++ b/drivers/platform/x86/intel/wmi/Kconfig
@@ -16,3 +16,16 @@ config INTEL_WMI_SBL_FW_UPDATE
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel-wmi-sbl-fw-update.
+
+config INTEL_WMI_THUNDERBOLT
+	tristate "Intel WMI thunderbolt force power driver"
+	depends on ACPI_WMI
+	select INTEL_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface on select
+	  systems to force the power control of Intel Thunderbolt controllers.
+	  This is useful for updating the firmware when devices are not plugged
+	  into the controller.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-thunderbolt.
diff --git a/drivers/platform/x86/intel/wmi/Makefile b/drivers/platform/x86/intel/wmi/Makefile
index bf1f118b6839..c2d56d25dea0 100644
--- a/drivers/platform/x86/intel/wmi/Makefile
+++ b/drivers/platform/x86/intel/wmi/Makefile
@@ -5,3 +5,5 @@
 
 intel-wmi-sbl-fw-update-y				:= sbl-fw-update.o
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
+intel-wmi-thunderbolt-y					:= thunderbolt.o
+obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel/wmi/thunderbolt.c
similarity index 100%
rename from drivers/platform/x86/intel-wmi-thunderbolt.c
rename to drivers/platform/x86/intel/wmi/thunderbolt.c
-- 
2.32.0

