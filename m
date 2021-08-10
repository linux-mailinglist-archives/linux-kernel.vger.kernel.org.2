Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC33E57CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhHJKA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239564AbhHJKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2Rfx/XieZHPmLIf/HGchrUr8qymq2p+6uiheYABfZ0=;
        b=HDZE9d/rqTmh9HuL2fL9sPVGzv64NJX9Gyfas+tLp20P2eyCke3ssV5KzN2cYAc7ZrTiND
        3Z3Y4v9r5gQB0Y0xnWLf7ndCL3U9ho/bpKdeHUQHAHq1cCkSZmypF0v/FIroxM/76g3ILj
        PeL45hn/H68CruUKrCejfPccUQAksbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-ZSlIcgsnO-K99twjPaC-Zw-1; Tue, 10 Aug 2021 06:00:17 -0400
X-MC-Unique: ZSlIcgsnO-K99twjPaC-Zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F24188799EB;
        Tue, 10 Aug 2021 10:00:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC6F60BF1;
        Tue, 10 Aug 2021 10:00:09 +0000 (UTC)
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
Subject: [PATCH 09/20] Move Intel SCU IPC of pdx86 to intel directory to increase readability.
Date:   Tue, 10 Aug 2021 17:58:21 +0800
Message-Id: <20210810095832.4234-10-hpa@redhat.com>
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                  | 47 -----------------
 drivers/platform/x86/Makefile                 |  6 +--
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  5 ++
 drivers/platform/x86/intel/scu/Kconfig        | 52 +++++++++++++++++++
 drivers/platform/x86/intel/scu/Makefile       | 11 ++++
 .../x86/{ => intel/scu}/intel_scu_ipc.c       |  0
 .../x86/{ => intel/scu}/intel_scu_ipcutil.c   |  0
 .../x86/{ => intel/scu}/intel_scu_pcidrv.c    |  0
 .../x86/{ => intel/scu}/intel_scu_pltdrv.c    |  0
 .../x86/{ => intel/scu}/intel_scu_wdt.c       |  0
 11 files changed, 70 insertions(+), 52 deletions(-)
 create mode 100644 drivers/platform/x86/intel/scu/Kconfig
 create mode 100644 drivers/platform/x86/intel/scu/Makefile
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipc.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipcutil.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_pcidrv.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_pltdrv.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_wdt.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 00fa213e9adb..c8c58a8f0ef9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1086,53 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  will be called intel-uncore-frequency.
 
 
-config INTEL_SCU_IPC
-	bool
-
-config INTEL_SCU
-	bool
-	select INTEL_SCU_IPC
-
-config INTEL_SCU_PCI
-	bool "Intel SCU PCI driver"
-	depends on PCI
-	select INTEL_SCU
-	help
-	  This driver is used to bridge the communications between kernel
-	  and SCU on some embedded Intel x86 platforms. It also creates
-	  devices that are connected to the SoC through the SCU.
-	  Platforms supported:
-	    Medfield
-	    Clovertrail
-	    Merrifield
-	    Broxton
-	    Apollo Lake
-
-config INTEL_SCU_PLATFORM
-	tristate "Intel SCU platform driver"
-	depends on ACPI
-	select INTEL_SCU
-	help
-	  This driver is used to bridge the communications between kernel
-	  and SCU (sometimes called PMC as well). The driver currently
-	  supports Intel Elkhart Lake and compatible platforms.
-
-config INTEL_SCU_WDT
-	bool
-	default INTEL_SCU_PCI
-	depends on INTEL_MID_WATCHDOG
-	help
-	  This is a specific platform code to instantiate watchdog device
-	  on ACPI-based Intel MID platforms.
-
-config INTEL_SCU_IPC_UTIL
-	tristate "Intel SCU IPC utility driver"
-	depends on INTEL_SCU
-	help
-	  The IPC Util driver provides an interface with the SCU enabling
-	  low level access for debug work and updating the firmware. Say
-	  N unless you will be doing this on an Intel MID platform.
-
 config INTEL_TELEMETRY
 	tristate "Intel SoC Telemetry Driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index dbb62085e7f9..72b1a4782d48 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -125,11 +125,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 
 
-obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
-obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
-obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
-obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
-obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
+
 obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
 					   intel_telemetry_pltdrv.o \
 					   intel_telemetry_debugfs.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 189a34226fe0..0f1543dc5299 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -27,6 +27,7 @@ source "drivers/platform/x86/intel/mrfld/Kconfig"
 source "drivers/platform/x86/intel/pmc_core/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/punit/Kconfig"
+source "drivers/platform/x86/intel/scu/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 9bd49a920900..6fff503ba998 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -22,3 +22,8 @@ obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt/
 obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt/
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= punit/
+obj-$(CONFIG_INTEL_SCU_IPC)		+= scu/
+obj-$(CONFIG_INTEL_SCU_PCI)		+= scu/
+obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
+obj-$(CONFIG_INTEL_SCU_WDT)		+= scu/
+obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
diff --git a/drivers/platform/x86/intel/scu/Kconfig b/drivers/platform/x86/intel/scu/Kconfig
new file mode 100644
index 000000000000..ac3b2ab039b4
--- /dev/null
+++ b/drivers/platform/x86/intel/scu/Kconfig
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_SCU_IPC
+	bool
+
+config INTEL_SCU
+	bool
+	select INTEL_SCU_IPC
+
+config INTEL_SCU_PCI
+	bool "Intel SCU PCI driver"
+	depends on PCI
+	select INTEL_SCU
+	help
+	  This driver is used to bridge the communications between kernel
+	  and SCU on some embedded Intel x86 platforms. It also creates
+	  devices that are connected to the SoC through the SCU.
+	  Platforms supported:
+	    Medfield
+	    Clovertrail
+	    Merrifield
+	    Broxton
+	    Apollo Lake
+
+config INTEL_SCU_PLATFORM
+	tristate "Intel SCU platform driver"
+	depends on ACPI
+	select INTEL_SCU
+	help
+	  This driver is used to bridge the communications between kernel
+	  and SCU (sometimes called PMC as well). The driver currently
+	  supports Intel Elkhart Lake and compatible platforms.
+
+config INTEL_SCU_WDT
+	bool
+	default INTEL_SCU_PCI
+	depends on INTEL_MID_WATCHDOG
+	help
+	  This is a specific platform code to instantiate watchdog device
+	  on ACPI-based Intel MID platforms.
+
+config INTEL_SCU_IPC_UTIL
+	tristate "Intel SCU IPC utility driver"
+	depends on INTEL_SCU
+	help
+	  The IPC Util driver provides an interface with the SCU enabling
+	  low level access for debug work and updating the firmware. Say
+	  N unless you will be doing this on an Intel MID platform.
+
diff --git a/drivers/platform/x86/intel/scu/Makefile b/drivers/platform/x86/intel/scu/Makefile
new file mode 100644
index 000000000000..39cab5f19029
--- /dev/null
+++ b/drivers/platform/x86/intel/scu/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
+obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
+obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
+obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
+obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
+
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel/scu/intel_scu_ipc.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_ipc.c
rename to drivers/platform/x86/intel/scu/intel_scu_ipc.c
diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel/scu/intel_scu_ipcutil.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_ipcutil.c
rename to drivers/platform/x86/intel/scu/intel_scu_ipcutil.c
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel/scu/intel_scu_pcidrv.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_pcidrv.c
rename to drivers/platform/x86/intel/scu/intel_scu_pcidrv.c
diff --git a/drivers/platform/x86/intel_scu_pltdrv.c b/drivers/platform/x86/intel/scu/intel_scu_pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_pltdrv.c
rename to drivers/platform/x86/intel/scu/intel_scu_pltdrv.c
diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel/scu/intel_scu_wdt.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_wdt.c
rename to drivers/platform/x86/intel/scu/intel_scu_wdt.c
-- 
2.31.1

