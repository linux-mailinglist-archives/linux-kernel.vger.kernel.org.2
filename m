Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA903E57C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbhHJKAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239509AbhHJKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVDVUL0SOiOvITU8MEbbyuqJmPahPOZQpPmprIqzwug=;
        b=WSfd3a0zeKOEuP1tiBid+p/R7lFyAFa2qzPoBjklje7yDnxuSyUdfpJXHDFd7djNMVdbUj
        MuM3FpB0MSYcgNlcUVz5MGSQ1PUw7iY1F7uWyMaRGi0YnakBtrbrKzSYCjqJYKlQpZTf/T
        eQvy5QINjOavUbG/MoSeEfjyERBevKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-cCsa6wBpMPOBIjz9B29-mw-1; Tue, 10 Aug 2021 05:59:42 -0400
X-MC-Unique: cCsa6wBpMPOBIjz9B29-mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1EE118C9F52;
        Tue, 10 Aug 2021 09:59:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9071A60BF1;
        Tue, 10 Aug 2021 09:59:34 +0000 (UTC)
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
Subject: [PATCH 05/20] Move MRFLD power button driver of pdx86 to intel directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:17 +0800
Message-Id: <20210810095832.4234-6-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                    | 11 -----------
 drivers/platform/x86/Makefile                   |  2 +-
 drivers/platform/x86/intel/Kconfig              |  1 +
 drivers/platform/x86/intel/Makefile             |  3 ++-
 drivers/platform/x86/intel/mrfld/Kconfig        | 17 +++++++++++++++++
 drivers/platform/x86/intel/mrfld/Makefile       |  6 ++++++
 .../x86/{ => intel/mrfld}/intel_mrfld_pwrbtn.c  |  0
 7 files changed, 27 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/x86/intel/mrfld/Kconfig
 create mode 100644 drivers/platform/x86/intel/mrfld/Makefile
 rename drivers/platform/x86/{ => intel/mrfld}/intel_mrfld_pwrbtn.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8b71eca4fc22..ecd8daf6c240 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1086,17 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  will be called intel-uncore-frequency.
 
 
-config INTEL_MRFLD_PWRBTN
-	tristate "Intel Merrifield Basin Cove power button driver"
-	depends on INTEL_SOC_PMIC_MRFLD
-	depends on INPUT
-	help
-	  This option adds a power button driver for Basin Cove PMIC
-	  on Intel Merrifield devices.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_mrfld_pwrbtn.
-
 config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ee613ece9d8a..a659fdcfd2d3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -123,7 +123,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 # Intel PMIC / PMC / P-Unit devices
 
 
-obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
+
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index d09795dfccbf..afbf34a12811 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -23,5 +23,6 @@ source "drivers/platform/x86/intel/hid/Kconfig"
 source "drivers/platform/x86/intel/wmi/Kconfig"
 source "drivers/platform/x86/intel/bxtwc/Kconfig"
 source "drivers/platform/x86/intel/chtdc_ti/Kconfig"
+source "drivers/platform/x86/intel/mrfld/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index fdfa1cb6a8a7..f5fe2ff0417b 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
 
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
-obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= chtdc_ti/
\ No newline at end of file
+obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= chtdc_ti/
+obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= mrfld/
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/mrfld/Kconfig b/drivers/platform/x86/intel/mrfld/Kconfig
new file mode 100644
index 000000000000..657281203062
--- /dev/null
+++ b/drivers/platform/x86/intel/mrfld/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+
+
+config INTEL_MRFLD_PWRBTN
+	tristate "Intel Merrifield Basin Cove power button driver"
+	depends on INTEL_SOC_PMIC_MRFLD
+	depends on INPUT
+	help
+	  This option adds a power button driver for Basin Cove PMIC
+	  on Intel Merrifield devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_mrfld_pwrbtn.
diff --git a/drivers/platform/x86/intel/mrfld/Makefile b/drivers/platform/x86/intel/mrfld/Makefile
new file mode 100644
index 000000000000..9a31c21b0bec
--- /dev/null
+++ b/drivers/platform/x86/intel/mrfld/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
diff --git a/drivers/platform/x86/intel_mrfld_pwrbtn.c b/drivers/platform/x86/intel/mrfld/intel_mrfld_pwrbtn.c
similarity index 100%
rename from drivers/platform/x86/intel_mrfld_pwrbtn.c
rename to drivers/platform/x86/intel/mrfld/intel_mrfld_pwrbtn.c
-- 
2.31.1

