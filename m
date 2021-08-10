Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3FC3E57C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhHJKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239509AbhHJKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1QbzEeaEqfyvCF/AXLdVs3hF2+TJPczLXNjx4I3gBs=;
        b=TeuriWgKqb9gnE6F9pd/sT5dXSZCqozQiB3jrwwUFBFxWhujQfBIyKhKawEC7elWk5/2M6
        u69HV9qp929W7Qhtvq0foODHdQAnA1KRPlCcD63mkCSYyZUaE2xryRjajJS0VCxmh6DxEP
        U8ruwtmiZorjkQwv6lKg5u1Ldb0uMZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511--j8tss-4P_-bVrm2JT3PmA-1; Tue, 10 Aug 2021 05:59:52 -0400
X-MC-Unique: -j8tss-4P_-bVrm2JT3PmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3694801A92;
        Tue, 10 Aug 2021 09:59:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FB9760C05;
        Tue, 10 Aug 2021 09:59:41 +0000 (UTC)
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
Subject: [PATCH 06/20] Move Intel PMC core of pdx86 to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:18 +0800
Message-Id: <20210810095832.4234-7-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                  | 20 --------------
 drivers/platform/x86/Makefile                 |  2 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  3 ++-
 drivers/platform/x86/intel/pmc_core/Kconfig   | 26 +++++++++++++++++++
 drivers/platform/x86/intel/pmc_core/Makefile  |  6 +++++
 .../x86/{ => intel/pmc_core}/intel_pmc_core.c |  0
 .../x86/{ => intel/pmc_core}/intel_pmc_core.h |  0
 .../pmc_core}/intel_pmc_core_pltdrv.c         |  0
 9 files changed, 35 insertions(+), 23 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc_core/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc_core/Makefile
 rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core.c (100%)
 rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core.h (100%)
 rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core_pltdrv.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ecd8daf6c240..b9a324ba17e3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1086,26 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
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
 
 config INTEL_PMT_CLASS
 	tristate
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index a659fdcfd2d3..30771dd51a84 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -123,8 +123,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 # Intel PMIC / PMC / P-Unit devices
 
 
-
-obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
 obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index afbf34a12811..2565b676b911 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -24,5 +24,6 @@ source "drivers/platform/x86/intel/wmi/Kconfig"
 source "drivers/platform/x86/intel/bxtwc/Kconfig"
 source "drivers/platform/x86/intel/chtdc_ti/Kconfig"
 source "drivers/platform/x86/intel/mrfld/Kconfig"
+source "drivers/platform/x86/intel/pmc_core/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index f5fe2ff0417b..7a9faf15bfb9 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -16,4 +16,5 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= chtdc_ti/
-obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= mrfld/
\ No newline at end of file
+obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= mrfld/
+obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc_core/
diff --git a/drivers/platform/x86/intel/pmc_core/Kconfig b/drivers/platform/x86/intel/pmc_core/Kconfig
new file mode 100644
index 000000000000..fcabdaf40bf3
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc_core/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
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
diff --git a/drivers/platform/x86/intel/pmc_core/Makefile b/drivers/platform/x86/intel/pmc_core/Makefile
new file mode 100644
index 000000000000..805400a593e9
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc_core/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel/pmc_core/intel_pmc_core.c
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core.c
rename to drivers/platform/x86/intel/pmc_core/intel_pmc_core.c
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel/pmc_core/intel_pmc_core.h
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core.h
rename to drivers/platform/x86/intel/pmc_core/intel_pmc_core.h
diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel/pmc_core/intel_pmc_core_pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_pmc_core_pltdrv.c
rename to drivers/platform/x86/intel/pmc_core/intel_pmc_core_pltdrv.c
-- 
2.31.1

