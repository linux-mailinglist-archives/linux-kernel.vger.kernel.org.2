Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA03E57C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhHJKA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238509AbhHJKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBpQeJKvS2vIpxhESN0lYa2/U/LjyurbSXqU+O6M3BQ=;
        b=ev9Y56Ce66NlRctmJslbOoAu/JDkaETrDbw9/IpNCOA6x5gW7t6+K3iWr2AzM+7kYiwG0H
        fALSDysLLJz9gB+1BNDXz4ltIGYIMSLhFbNrk2rX1Nybhti1YCBoq0fVs7I1p6hDf59TwJ
        aqlM3ejaRLxpydvf+wOE2BWHNMiyr2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-xIkL3VQCOXSVcxrTjnZ5LA-1; Tue, 10 Aug 2021 06:00:00 -0400
X-MC-Unique: xIkL3VQCOXSVcxrTjnZ5LA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A908DC2A;
        Tue, 10 Aug 2021 09:59:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A22C60BF1;
        Tue, 10 Aug 2021 09:59:51 +0000 (UTC)
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
Subject: [PATCH 07/20] Move Intel PMT driver of pdx86 to intel/ to improve readability.
Date:   Tue, 10 Aug 2021 17:58:19 +0800
Message-Id: <20210810095832.4234-8-hpa@redhat.com>
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
 drivers/platform/x86/Makefile                 |  4 +-
 drivers/platform/x86/intel/Kconfig            |  2 +
 drivers/platform/x86/intel/Makefile           |  3 ++
 drivers/platform/x86/intel/pmt/Kconfig        | 41 +++++++++++++++++++
 drivers/platform/x86/intel/pmt/Makefile       |  9 ++++
 .../x86/{ => intel/pmt}/intel_pmt_class.c     |  0
 .../x86/{ => intel/pmt}/intel_pmt_class.h     |  0
 .../x86/{ => intel/pmt}/intel_pmt_crashlog.c  |  0
 .../x86/{ => intel/pmt}/intel_pmt_telemetry.c |  0
 9 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmt/Makefile
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.c (100%)
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.h (100%)
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_crashlog.c (100%)
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_telemetry.c (100%)

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 30771dd51a84..1310b1ebc3f0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -123,9 +123,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 # Intel PMIC / PMC / P-Unit devices
 
 
-obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
-obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
-obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
+
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 2565b676b911..38bfca25940d 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -25,5 +25,7 @@ source "drivers/platform/x86/intel/bxtwc/Kconfig"
 source "drivers/platform/x86/intel/chtdc_ti/Kconfig"
 source "drivers/platform/x86/intel/mrfld/Kconfig"
 source "drivers/platform/x86/intel/pmc_core/Kconfig"
+source "drivers/platform/x86/intel/pmt/Kconfig"
+
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 7a9faf15bfb9..746bee1db055 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -18,3 +18,6 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= chtdc_ti/
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= mrfld/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc_core/
+obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
+obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt/
+obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt/
diff --git a/drivers/platform/x86/intel/pmt/Kconfig b/drivers/platform/x86/intel/pmt/Kconfig
new file mode 100644
index 000000000000..1a5f0fa789e0
--- /dev/null
+++ b/drivers/platform/x86/intel/pmt/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_PMT_CLASS
+	tristate
+	help
+	  The Intel Platform Monitoring Technology (PMT) class driver provides
+	  the basic sysfs interface and file hierarchy used by PMT devices.
+
+	  For more information, see:
+	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_class.
+
+config INTEL_PMT_TELEMETRY
+	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
+	depends on MFD_INTEL_PMT
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
+	  access to hardware telemetry metrics on devices that support the
+	  feature.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_telemetry.
+
+config INTEL_PMT_CRASHLOG
+	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
+	depends on MFD_INTEL_PMT
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
+	  access to hardware crashlog capabilities on devices that support the
+	  feature.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_crashlog.
+
diff --git a/drivers/platform/x86/intel/pmt/Makefile b/drivers/platform/x86/intel/pmt/Makefile
new file mode 100644
index 000000000000..b41f52e09f27
--- /dev/null
+++ b/drivers/platform/x86/intel/pmt/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+
+obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
+obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
+obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel/pmt/intel_pmt_class.c
similarity index 100%
rename from drivers/platform/x86/intel_pmt_class.c
rename to drivers/platform/x86/intel/pmt/intel_pmt_class.c
diff --git a/drivers/platform/x86/intel_pmt_class.h b/drivers/platform/x86/intel/pmt/intel_pmt_class.h
similarity index 100%
rename from drivers/platform/x86/intel_pmt_class.h
rename to drivers/platform/x86/intel/pmt/intel_pmt_class.h
diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel/pmt/intel_pmt_crashlog.c
similarity index 100%
rename from drivers/platform/x86/intel_pmt_crashlog.c
rename to drivers/platform/x86/intel/pmt/intel_pmt_crashlog.c
diff --git a/drivers/platform/x86/intel_pmt_telemetry.c b/drivers/platform/x86/intel/pmt/intel_pmt_telemetry.c
similarity index 100%
rename from drivers/platform/x86/intel_pmt_telemetry.c
rename to drivers/platform/x86/intel/pmt/intel_pmt_telemetry.c
-- 
2.31.1

