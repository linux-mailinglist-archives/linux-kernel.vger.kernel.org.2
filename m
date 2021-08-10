Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4213E57D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhHJKBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236775AbhHJKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8znhXIMZK1L533fRVbwQtjY4m/p0PYIZqhn054nSVg=;
        b=MzEBvhg1ozxM6yQsQrzoEsCB+oQ4HiJkgMF2SC9/1c2PYzjz1VWr20Uik8/+ZnHUB5xS8l
        ryXkF6QawgOLyD9Dx32Jcg7OpAprUUJmEYfxn/+78SZki3rOlPRbBphUBFCmKrCmPbB2AJ
        sHPq+S5wwrLYEuk328mPgOziNAsu5Ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-UP_SmvIAMbubgzaGbdI8pw-1; Tue, 10 Aug 2021 06:00:27 -0400
X-MC-Unique: UP_SmvIAMbubgzaGbdI8pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CF7D8799F6;
        Tue, 10 Aug 2021 10:00:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3622660BF1;
        Tue, 10 Aug 2021 10:00:16 +0000 (UTC)
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
Subject: [PATCH 10/20] Move Intel SoC telemetry driver to intel directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:22 +0800
Message-Id: <20210810095832.4234-11-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                     | 13 -------------
 drivers/platform/x86/Makefile                    |  3 ---
 drivers/platform/x86/intel/Kconfig               |  1 +
 drivers/platform/x86/intel/Makefile              |  1 +
 drivers/platform/x86/intel/telemetry/Kconfig     | 16 ++++++++++++++++
 drivers/platform/x86/intel/telemetry/Makefile    |  9 +++++++++
 .../{ => intel/telemetry}/intel_telemetry_core.c |  0
 .../telemetry}/intel_telemetry_debugfs.c         |  0
 .../telemetry}/intel_telemetry_pltdrv.c          |  0
 9 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
 create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
 rename drivers/platform/x86/{ => intel/telemetry}/intel_telemetry_core.c (100%)
 rename drivers/platform/x86/{ => intel/telemetry}/intel_telemetry_debugfs.c (100%)
 rename drivers/platform/x86/{ => intel/telemetry}/intel_telemetry_pltdrv.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c8c58a8f0ef9..b14c3a2953db 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1085,19 +1085,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-
-config INTEL_TELEMETRY
-	tristate "Intel SoC Telemetry Driver"
-	depends on X86_64
-	depends on MFD_INTEL_PMC_BXT
-	depends on INTEL_PUNIT_IPC
-	help
-	  This driver provides interfaces to configure and use
-	  telemetry for INTEL SoC from APL onwards. It is also
-	  used to get various SoC events and parameters
-	  directly via debugfs files. Various tools may use
-	  this interface for SoC state monitoring.
-
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 72b1a4782d48..1d7acccf5e3a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -126,7 +126,4 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 
 
-obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
-					   intel_telemetry_pltdrv.o \
-					   intel_telemetry_debugfs.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 0f1543dc5299..02e7792d34b0 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -28,6 +28,7 @@ source "drivers/platform/x86/intel/pmc_core/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/punit/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
+source "drivers/platform/x86/intel/telemetry/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 6fff503ba998..3edbd5209072 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_INTEL_SCU_PCI)		+= scu/
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
 obj-$(CONFIG_INTEL_SCU_WDT)		+= scu/
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
+obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
diff --git a/drivers/platform/x86/intel/telemetry/Kconfig b/drivers/platform/x86/intel/telemetry/Kconfig
new file mode 100644
index 000000000000..af7a712ae90e
--- /dev/null
+++ b/drivers/platform/x86/intel/telemetry/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_TELEMETRY
+	tristate "Intel SoC Telemetry Driver"
+	depends on X86_64
+	depends on MFD_INTEL_PMC_BXT
+	depends on INTEL_PUNIT_IPC
+	help
+	  This driver provides interfaces to configure and use
+	  telemetry for INTEL SoC from APL onwards. It is also
+	  used to get various SoC events and parameters
+	  directly via debugfs files. Various tools may use
+	  this interface for SoC state monitoring.
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/telemetry/Makefile b/drivers/platform/x86/intel/telemetry/Makefile
new file mode 100644
index 000000000000..c28c45ee5e9c
--- /dev/null
+++ b/drivers/platform/x86/intel/telemetry/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+
+obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
+					   intel_telemetry_pltdrv.o \
+					   intel_telemetry_debugfs.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel/telemetry/intel_telemetry_core.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_core.c
rename to drivers/platform/x86/intel/telemetry/intel_telemetry_core.c
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel/telemetry/intel_telemetry_debugfs.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_debugfs.c
rename to drivers/platform/x86/intel/telemetry/intel_telemetry_debugfs.c
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel/telemetry/intel_telemetry_pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_pltdrv.c
rename to drivers/platform/x86/intel/telemetry/intel_telemetry_pltdrv.c
-- 
2.31.1

