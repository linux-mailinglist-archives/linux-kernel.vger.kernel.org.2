Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB99E3F11A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhHSDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236387AbhHSDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3V1Q8O8Vu7JSJXKkZZtS/7skcye+XSCbFFeG4xZNwbk=;
        b=J4XmVW0C7uWnoR6+vCq/eI/XElMjYIZ04xZxlALgc6gzz/MyNOC/8h9xpmwrI3esBzRl5c
        8ceuHmMRJkU4j2B4sVtEctWgoT+YevNTQGaGyESjUuthYPFD0BYeQIkFuzdlNQhdoBUwyl
        izNJj3ww5dlSsmuQYqeZpvzBfWAzdao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-sC9DDK_hPxKeRiOSh6jYaw-1; Wed, 18 Aug 2021 23:31:03 -0400
X-MC-Unique: sC9DDK_hPxKeRiOSh6jYaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ED5F1008060;
        Thu, 19 Aug 2021 03:31:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0073F2C00F;
        Thu, 19 Aug 2021 03:30:57 +0000 (UTC)
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
Subject: [PATCH v3 05/20] platform/x86: intel_pmc_core: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:46 +0800
Message-Id: <20210819033001.20136-6-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_pmc_core to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                  | 21 ---------------
 drivers/platform/x86/Makefile                 |  2 --
 drivers/platform/x86/intel/Kconfig            |  2 ++
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/pmc/Kconfig        | 26 +++++++++++++++++++
 drivers/platform/x86/intel/pmc/Makefile       |  9 +++++++
 .../x86/{ => intel/pmc}/intel_pmc_core.h      |  0
 .../pmc/pmc_core.c}                           |  0
 .../pmc/pmc_core_pltdrv.c}                    |  0
 9 files changed, 38 insertions(+), 23 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (100%)
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/pmc_core.c} (100%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pmc_core_pltdrv.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 019a625f1fa3..79b6e0abc2ab 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1158,27 +1158,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_PMC_CORE
-	tristate "Intel PMC Core driver"
-	depends on PCI
-	depends on ACPI
-	help
-	  The Intel Platform Controller Hub for Intel Core SoCs provides access
-	  to Power Management Controller registers via various interfaces. This
-	  driver can utilize debugging capabilities and supported features as
-	  exposed by the Power Management Controller. It also may perform some
-	  tasks in the PMC in order to enable transition into the SLPS0 state.
-	  It should be selected on all Intel platforms supported by the driver.
-
-	  Supported features:
-		- SLP_S0_RESIDENCY counter
-		- PCH IP Power Gating status
-		- LTR Ignore / LTR Show
-		- MPHY/PLL gating status (Sunrisepoint PCH only)
-		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
-		- Low Power Mode registers (Tigerlake and beyond)
-		- PMC quirks as needed to enable SLPS0/S0ix
-
 config INTEL_SCU_IPC
 	bool
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 344d7a4a33f0..37ad6a436dda 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,8 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
 
-obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
-
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 78314ca39786..e59ff836b592 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -58,4 +58,6 @@ config INTEL_PUNIT_IPC
 	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
 	  which is used to bridge the communications between kernel and P-Unit.
 
+source "drivers/platform/x86/intel/pmc/Kconfig"
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index a9aa5e15e8bd..1f343ee7c9b4 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -17,3 +17,4 @@ intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 intel_punit_ipc-y			:= punit_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
+obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
new file mode 100644
index 000000000000..d44a3e34210f
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86
+# x86 Platform-Specific Drivers
+#
+
+config INTEL_PMC_CORE
+	tristate "Intel PMC Core driver"
+	depends on PCI
+	depends on ACPI
+	help
+	  The Intel Platform Controller Hub for Intel Core SoCs provides access
+	  to Power Management Controller registers via various interfaces. This
+	  driver can utilize debugging capabilities and supported features as
+	  exposed by the Power Management Controller. It also may perform some
+	  tasks in the PMC in order to enable transition into the SLPS0 state.
+	  It should be selected on all Intel platforms supported by the driver.
+
+	  Supported features:
+		- SLP_S0_RESIDENCY counter
+		- PCH IP Power Gating status
+		- LTR Ignore / LTR Show
+		- MPHY/PLL gating status (Sunrisepoint PCH only)
+		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
+		- Low Power Mode registers (Tigerlake and beyond)
+		- PMC quirks as needed to enable SLPS0/S0ix
diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
new file mode 100644
index 000000000000..db305c9e5f37
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86
+# x86 Platform-Specific Drivers
+#
+
+intel_pmc_core-y			:= pmc_core.o
+intel_pmc_core_pltdrv-y			:= pmc_core_pltdrv.o
+obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o intel_pmc_core.o
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel/pmc/intel_pmc_core.h
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core.h
rename to drivers/platform/x86/intel/pmc/intel_pmc_core.h
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel/pmc/pmc_core.c
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core.c
rename to drivers/platform/x86/intel/pmc/pmc_core.c
diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel/pmc/pmc_core_pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core_pltdrv.c
rename to drivers/platform/x86/intel/pmc/pmc_core_pltdrv.c
-- 
2.31.1

