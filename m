Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699FE3ED286
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhHPKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236222AbhHPKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zsv4koQZcQwmO5S4WR54Z6HNGBQ408/kRCLK++LM2wc=;
        b=QTvWmPm7wivdt8bTofzmkyBJAHtwwi3uWzC0iVOu2Ze9t2OIc5PMon2uV08PGh1zwMOZ1k
        Rej/yrOjPI6cc73TerGNK+F0UNrEgKi6Sp59VQfHWo4r9435OjMa5YbNE2R7/szv83QTLH
        uRqZcOk1o+PMruEVfSNh61hIH1u3tiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Y4QFkSvUMv6UXKzY9OwctQ-1; Mon, 16 Aug 2021 06:53:24 -0400
X-MC-Unique: Y4QFkSvUMv6UXKzY9OwctQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C61887D544;
        Mon, 16 Aug 2021 10:53:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25F805FC23;
        Mon, 16 Aug 2021 10:53:18 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v2 06/20] platform/x86: intel_scu: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:05 +0800
Message-Id: <20210816105119.704302-7-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_scu to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                  | 46 ----------------
 drivers/platform/x86/Makefile                 |  6 +--
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  6 +++
 drivers/platform/x86/intel/scu/Kconfig        | 52 +++++++++++++++++++
 drivers/platform/x86/intel/scu/Makefile       | 16 ++++++
 .../x86/{intel_scu_ipc.c => intel/scu/ipc.c}  |  0
 .../scu/ipcutil.c}                            |  0
 .../scu/pcidrv.c}                             |  0
 .../scu/pltdrv.c}                             |  0
 .../x86/{intel_scu_wdt.c => intel/scu/wdt.c}  |  0
 11 files changed, 76 insertions(+), 51 deletions(-)
 create mode 100644 drivers/platform/x86/intel/scu/Kconfig
 create mode 100644 drivers/platform/x86/intel/scu/Makefile
 rename drivers/platform/x86/{intel_scu_ipc.c => intel/scu/ipc.c} (100%)
 rename drivers/platform/x86/{intel_scu_ipcutil.c => intel/scu/ipcutil.c} (100%)
 rename drivers/platform/x86/{intel_scu_pcidrv.c => intel/scu/pcidrv.c} (100%)
 rename drivers/platform/x86/{intel_scu_pltdrv.c => intel/scu/pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_scu_wdt.c => intel/scu/wdt.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7d929970fb38..e34e6af7a7d4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1168,52 +1168,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
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
 
 config INTEL_TELEMETRY
 	tristate "Intel SoC Telemetry Driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 152ef10d2a2b..e96f0e77df88 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -129,11 +129,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
 
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
index 4d689d0be585..672b6ad64ff1 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -59,5 +59,6 @@ config INTEL_PUNIT_IPC
 	  which is used to bridge the communications between kernel and P-Unit.
 
 source "drivers/platform/x86/intel/pmc/Kconfig"
+source "drivers/platform/x86/intel/scu/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 0986da945239..e842a72fa516 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -18,3 +18,9 @@ obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 intel_punit_ipc-y			:= punit_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
+obj-$(CONFIG_INTEL_SCU_IPC)			+= scu/
+obj-$(CONFIG_INTEL_SCU_PCI)			+= scu/
+obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
+obj-$(CONFIG_INTEL_SCU_WDT)			+= scu/
+obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
+
diff --git a/drivers/platform/x86/intel/scu/Kconfig b/drivers/platform/x86/intel/scu/Kconfig
new file mode 100644
index 000000000000..9e9910ef5349
--- /dev/null
+++ b/drivers/platform/x86/intel/scu/Kconfig
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for drivers/platform/x86/intel
+# Intel x86 Platform-Specific Drivers
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
diff --git a/drivers/platform/x86/intel/scu/Makefile b/drivers/platform/x86/intel/scu/Makefile
new file mode 100644
index 000000000000..ba99f01483a5
--- /dev/null
+++ b/drivers/platform/x86/intel/scu/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for drivers/platform/x86/intel
+# Intel x86 Platform-Specific Drivers
+#
+
+intel_scu_ipc-y					:= ipc.o
+obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
+intel_scu_pcidrv-y				:= pcidrv.o
+obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
+intel_scu_pltdrv-y 				:= pltdrv.o
+obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
+intel_scu_wdt-y					:= wdt.o
+obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
+intel_scu_ipcutil-y				:= ipcutil.o
+obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel/scu/ipc.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_ipc.c
rename to drivers/platform/x86/intel/scu/ipc.c
diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel/scu/ipcutil.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_ipcutil.c
rename to drivers/platform/x86/intel/scu/ipcutil.c
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel/scu/pcidrv.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_pcidrv.c
rename to drivers/platform/x86/intel/scu/pcidrv.c
diff --git a/drivers/platform/x86/intel_scu_pltdrv.c b/drivers/platform/x86/intel/scu/pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_pltdrv.c
rename to drivers/platform/x86/intel/scu/pltdrv.c
diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel/scu/wdt.c
similarity index 100%
rename from drivers/platform/x86/intel_scu_wdt.c
rename to drivers/platform/x86/intel/scu/wdt.c
-- 
2.31.1

