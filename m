Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA643E57B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhHJJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238415AbhHJJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0q0EEupqb4oFJlbN32pbb6vdh1tZZd8uiY7xRlPgJEU=;
        b=cWotfxBZHgSCW04CO9xuQB65fEwDPgaSjeo1o9+RPak61yHBv78Y58anYnUAU9/2wez1e/
        vZXrIGQucBxZwIlJXHmhFEtZaKX1KWvvqVD1t+ySvCqyODvJcAmkr1zYbhkSGt7I6uZ1BE
        6Xr/4LrzceQm1WCc3fNTLFFxl59n5qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-RkBnu1agPruIgtysAC_Y2Q-1; Tue, 10 Aug 2021 05:59:18 -0400
X-MC-Unique: RkBnu1agPruIgtysAC_Y2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0CE018C9F40;
        Tue, 10 Aug 2021 09:59:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7072160BF1;
        Tue, 10 Aug 2021 09:59:10 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH 02/20] Move Intel WMI driver of pdx86 to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:14 +0800
Message-Id: <20210810095832.4234-3-hpa@redhat.com>
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/Kconfig                  | 21 ---------------
 drivers/platform/x86/Makefile                 |  2 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  3 ++-
 drivers/platform/x86/intel/wmi/Kconfig        | 26 +++++++++++++++++++
 drivers/platform/x86/intel/wmi/Makefile       |  7 +++++
 .../{ => intel/wmi}/intel-wmi-sbl-fw-update.c |  0
 .../{ => intel/wmi}/intel-wmi-thunderbolt.c   |  0
 8 files changed, 36 insertions(+), 24 deletions(-)
 create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
 create mode 100644 drivers/platform/x86/intel/wmi/Makefile
 rename drivers/platform/x86/{ => intel/wmi}/intel-wmi-sbl-fw-update.c (100%)
 rename drivers/platform/x86/{ => intel/wmi}/intel-wmi-thunderbolt.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6765f613ce0e..2e45d5e0d08a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -77,27 +77,6 @@ config UV_SYSFS
 	  To compile this driver as a module, choose M here: the module will
 	  be called uv_sysfs.
 
-config INTEL_WMI_SBL_FW_UPDATE
-	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
-	depends on ACPI_WMI
-	help
-	  Say Y here if you want to be able to use the WMI interface to signal
-	  Slim Bootloader to trigger update on next reboot.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel-wmi-sbl-fw-update.
-
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
 
 config MXM_WMI
        tristate "WMI support for MXM Laptop Graphics"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 328f4bcf99d0..c184989563c8 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -10,8 +10,6 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
-obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
-obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index d2254ab6aad8..d541e63d0d2b 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -20,5 +20,6 @@ source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
 source "drivers/platform/x86/intel/hid/Kconfig"
+source "drivers/platform/x86/intel/wmi/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 6f04221456fb..653719491fa9 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= atomisp2/
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= atomisp2/
 obj-$(CONFIG_INTEL_HID_EVENT)		+= hid/
-
+obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
+obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
diff --git a/drivers/platform/x86/intel/wmi/Kconfig b/drivers/platform/x86/intel/wmi/Kconfig
new file mode 100644
index 000000000000..5c3e2885e196
--- /dev/null
+++ b/drivers/platform/x86/intel/wmi/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_WMI_THUNDERBOLT
+	tristate "Intel WMI thunderbolt force power driver"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface on select
+	  systems to force the power control of Intel Thunderbolt controllers.
+	  This is useful for updating the firmware when devices are not plugged
+	  into the controller.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-thunderbolt.
+
+config INTEL_WMI_SBL_FW_UPDATE
+	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface to signal
+	  Slim Bootloader to trigger update on next reboot.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-sbl-fw-update.
diff --git a/drivers/platform/x86/intel/wmi/Makefile b/drivers/platform/x86/intel/wmi/Makefile
new file mode 100644
index 000000000000..7aa3789b0f5c
--- /dev/null
+++ b/drivers/platform/x86/intel/wmi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
+obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel-wmi-sbl-fw-update.c b/drivers/platform/x86/intel/wmi/intel-wmi-sbl-fw-update.c
similarity index 100%
rename from drivers/platform/x86/intel-wmi-sbl-fw-update.c
rename to drivers/platform/x86/intel/wmi/intel-wmi-sbl-fw-update.c
diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel/wmi/intel-wmi-thunderbolt.c
similarity index 100%
rename from drivers/platform/x86/intel-wmi-thunderbolt.c
rename to drivers/platform/x86/intel/wmi/intel-wmi-thunderbolt.c
-- 
2.31.1

