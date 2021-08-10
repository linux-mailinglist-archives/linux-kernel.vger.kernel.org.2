Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035F23E57BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhHJKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239494AbhHJJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsmoE2LIQfJevF+eK6HUsNInZ+2k+ghC+Du+HBQVGjE=;
        b=J4aA1d6AYaMQ7LOLBZENyjJFuz0TFoVClruOoY7Owaob0odlLqZXl4ViABFZxrZ/fg+Y4/
        uspoOnaJRJaMwIw4Tdsb47jDYcjQdTlTBsGCYAMky8+8aiz+zjpTDEHsK4za0qMDWSeivh
        8s678zoB0HDmA04KA6WVmWaJtP4AZkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-o-cj46b6NNSYK2OzW3wngw-1; Tue, 10 Aug 2021 05:59:34 -0400
X-MC-Unique: o-cj46b6NNSYK2OzW3wngw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0BCC100A24D;
        Tue, 10 Aug 2021 09:59:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F66D60BF1;
        Tue, 10 Aug 2021 09:59:26 +0000 (UTC)
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
Subject: [PATCH 04/20] Move Intel chtdc_ti driver of pdx86 to improve readability.
Date:   Tue, 10 Aug 2021 17:58:16 +0800
Message-Id: <20210810095832.4234-5-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                     | 11 -----------
 drivers/platform/x86/Makefile                    |  2 +-
 drivers/platform/x86/intel/Kconfig               |  1 +
 drivers/platform/x86/intel/Makefile              |  3 ++-
 drivers/platform/x86/intel/chtdc_ti/Kconfig      | 16 ++++++++++++++++
 drivers/platform/x86/intel/chtdc_ti/Makefile     |  7 +++++++
 .../{ => intel/chtdc_ti}/intel_chtdc_ti_pwrbtn.c |  0
 7 files changed, 27 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/x86/intel/chtdc_ti/Kconfig
 create mode 100644 drivers/platform/x86/intel/chtdc_ti/Makefile
 rename drivers/platform/x86/{ => intel/chtdc_ti}/intel_chtdc_ti_pwrbtn.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9fe7fca8b572..8b71eca4fc22 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1086,17 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  will be called intel-uncore-frequency.
 
 
-config INTEL_CHTDC_TI_PWRBTN
-	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
-	depends on INTEL_SOC_PMIC_CHTDC_TI
-	depends on INPUT
-	help
-	  This option adds a power button driver driver for Dollar Cove TI
-	  PMIC on Intel Cherry Trail devices.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_chtdc_ti_pwrbtn.
-
 config INTEL_MRFLD_PWRBTN
 	tristate "Intel Merrifield Basin Cove power button driver"
 	depends on INTEL_SOC_PMIC_MRFLD
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 12b7d6338747..ee613ece9d8a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -122,7 +122,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
 
-obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
+
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 319244c251db..d09795dfccbf 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -22,5 +22,6 @@ source "drivers/platform/x86/intel/atomisp2/Kconfig"
 source "drivers/platform/x86/intel/hid/Kconfig"
 source "drivers/platform/x86/intel/wmi/Kconfig"
 source "drivers/platform/x86/intel/bxtwc/Kconfig"
+source "drivers/platform/x86/intel/chtdc_ti/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index a6945e2dcd1c..fdfa1cb6a8a7 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
 
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
\ No newline at end of file
+obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
+obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= chtdc_ti/
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/chtdc_ti/Kconfig b/drivers/platform/x86/intel/chtdc_ti/Kconfig
new file mode 100644
index 000000000000..7023380ee5e5
--- /dev/null
+++ b/drivers/platform/x86/intel/chtdc_ti/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+
+config INTEL_CHTDC_TI_PWRBTN
+	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
+	depends on INTEL_SOC_PMIC_CHTDC_TI
+	depends on INPUT
+	help
+	  This option adds a power button driver driver for Dollar Cove TI
+	  PMIC on Intel Cherry Trail devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_chtdc_ti_pwrbtn.
diff --git a/drivers/platform/x86/intel/chtdc_ti/Makefile b/drivers/platform/x86/intel/chtdc_ti/Makefile
new file mode 100644
index 000000000000..16b24796008c
--- /dev/null
+++ b/drivers/platform/x86/intel/chtdc_ti/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+
+obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
diff --git a/drivers/platform/x86/intel_chtdc_ti_pwrbtn.c b/drivers/platform/x86/intel/chtdc_ti/intel_chtdc_ti_pwrbtn.c
similarity index 100%
rename from drivers/platform/x86/intel_chtdc_ti_pwrbtn.c
rename to drivers/platform/x86/intel/chtdc_ti/intel_chtdc_ti_pwrbtn.c
-- 
2.31.1

