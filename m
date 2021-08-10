Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508993E57BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhHJJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239466AbhHJJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAVTmE+gJsnZN88+Ib2g766dWb2EYOFdY8FoJPAsxqA=;
        b=ZJxPSe7UH86ToHBPqX2FqW6ZZvCr6ZwmmxoIwe7URCh57GaWNi0HTXQOoOv2SyZDxlRjDT
        4qMJRO3ytNrmUmvli2fymhTbRtoqB9tgJ0CP7wGHw2YSSeFHmVvpZq79x2XR4+fpd/tMZ8
        Mhu/1PWBXyV30jv5rXbdNWpgr9igBos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-pyxYJCtcPX2KqA2lM8I_Bw-1; Tue, 10 Aug 2021 05:59:26 -0400
X-MC-Unique: pyxYJCtcPX2KqA2lM8I_Bw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F043F2E75;
        Tue, 10 Aug 2021 09:59:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA33160BF1;
        Tue, 10 Aug 2021 09:59:18 +0000 (UTC)
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
Subject: [PATCH 03/20] Move Intel bxtwc driver of pdx86 to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:15 +0800
Message-Id: <20210810095832.4234-4-hpa@redhat.com>
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/Kconfig                      |  9 ---------
 drivers/platform/x86/Makefile                     |  2 +-
 drivers/platform/x86/intel/Kconfig                |  1 +
 drivers/platform/x86/intel/Makefile               |  4 ++++
 drivers/platform/x86/intel/bxtwc/Kconfig          | 15 +++++++++++++++
 drivers/platform/x86/intel/bxtwc/Makefile         |  6 ++++++
 .../x86/{ => intel/bxtwc}/intel_bxtwc_tmu.c       |  0
 7 files changed, 27 insertions(+), 10 deletions(-)
 create mode 100644 drivers/platform/x86/intel/bxtwc/Kconfig
 create mode 100644 drivers/platform/x86/intel/bxtwc/Makefile
 rename drivers/platform/x86/{ => intel/bxtwc}/intel_bxtwc_tmu.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2e45d5e0d08a..9fe7fca8b572 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1085,15 +1085,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_BXTWC_PMIC_TMU
-	tristate "Intel BXT Whiskey Cove TMU Driver"
-	depends on REGMAP
-	depends on MFD_INTEL_PMC_BXT
-	depends on INTEL_SOC_PMIC_BXTWC
-	help
-	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
-	  This driver enables the alarm wakeup functionality in the TMU unit
-	  of Whiskey Cove PMIC.
 
 config INTEL_CHTDC_TI_PWRBTN
 	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c184989563c8..12b7d6338747 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -121,7 +121,7 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
+
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index d541e63d0d2b..319244c251db 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -21,5 +21,6 @@ source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
 source "drivers/platform/x86/intel/hid/Kconfig"
 source "drivers/platform/x86/intel/wmi/Kconfig"
+source "drivers/platform/x86/intel/bxtwc/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 653719491fa9..a6945e2dcd1c 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -11,3 +11,7 @@ obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= atomisp2/
 obj-$(CONFIG_INTEL_HID_EVENT)		+= hid/
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
+
+
+# Intel PMIC / PMC / P-Unit devices
+obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/bxtwc/Kconfig b/drivers/platform/x86/intel/bxtwc/Kconfig
new file mode 100644
index 000000000000..87802bba9665
--- /dev/null
+++ b/drivers/platform/x86/intel/bxtwc/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+
+config INTEL_BXTWC_PMIC_TMU
+	tristate "Intel BXT Whiskey Cove TMU Driver"
+	depends on REGMAP
+	depends on MFD_INTEL_PMC_BXT
+	depends on INTEL_SOC_PMIC_BXTWC
+	help
+	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
+	  This driver enables the alarm wakeup functionality in the TMU unit
+	  of Whiskey Cove PMIC.
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/bxtwc/Makefile b/drivers/platform/x86/intel/bxtwc/Makefile
new file mode 100644
index 000000000000..62b4ece63d0e
--- /dev/null
+++ b/drivers/platform/x86/intel/bxtwc/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel/bxtwc/intel_bxtwc_tmu.c
similarity index 100%
rename from drivers/platform/x86/intel_bxtwc_tmu.c
rename to drivers/platform/x86/intel/bxtwc/intel_bxtwc_tmu.c
-- 
2.31.1

