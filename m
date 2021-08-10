Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D583E57CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhHJKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237695AbhHJKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVebG3jG74UX7OY2AlyRDC85AZ5AEqCH0K8nwkfyQOQ=;
        b=R/tOYr60TQnU8F1jojBgDLyPI76xyDUdSxRbFlWqkVimPGj9xJWmzplaWvcNqF1m7vSz/S
        VsF1m6EAf+TZCANgWXFJnvzlEQfkHlXXfbE55DMbDIGauYeCFVuAZ2VlBQV+jt3y/q5dxO
        sQrcuVKSy2JvjSAx07xeO2BndrQTELA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-IQIYDwB9OweF-eNc4vjJ_A-1; Tue, 10 Aug 2021 06:00:09 -0400
X-MC-Unique: IQIYDwB9OweF-eNc4vjJ_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D7A8799F0;
        Tue, 10 Aug 2021 10:00:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A7BF60BF1;
        Tue, 10 Aug 2021 09:59:59 +0000 (UTC)
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
Subject: [PATCH 08/20] Move Intel P-Unit of pdx86 to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:20 +0800
Message-Id: <20210810095832.4234-9-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                  | 43 -------------------
 drivers/platform/x86/Makefile                 |  2 +-
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/punit/Kconfig      | 10 +++++
 drivers/platform/x86/intel/punit/Makefile     |  6 +++
 .../x86/{ => intel/punit}/intel_punit_ipc.c   |  0
 7 files changed, 19 insertions(+), 44 deletions(-)
 create mode 100644 drivers/platform/x86/intel/punit/Kconfig
 create mode 100644 drivers/platform/x86/intel/punit/Makefile
 rename drivers/platform/x86/{ => intel/punit}/intel_punit_ipc.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b9a324ba17e3..00fa213e9adb 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1086,49 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  will be called intel-uncore-frequency.
 
 
-
-config INTEL_PMT_CLASS
-	tristate
-	help
-	  The Intel Platform Monitoring Technology (PMT) class driver provides
-	  the basic sysfs interface and file hierarchy used by PMT devices.
-
-	  For more information, see:
-	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_pmt_class.
-
-config INTEL_PMT_TELEMETRY
-	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
-	depends on MFD_INTEL_PMT
-	select INTEL_PMT_CLASS
-	help
-	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
-	  access to hardware telemetry metrics on devices that support the
-	  feature.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_pmt_telemetry.
-
-config INTEL_PMT_CRASHLOG
-	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
-	depends on MFD_INTEL_PMT
-	select INTEL_PMT_CLASS
-	help
-	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
-	  access to hardware crashlog capabilities on devices that support the
-	  feature.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_pmt_crashlog.
-
-config INTEL_PUNIT_IPC
-	tristate "Intel P-Unit IPC Driver"
-	help
-	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
-	  which is used to bridge the communications between kernel and P-Unit.
-
 config INTEL_SCU_IPC
 	bool
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1310b1ebc3f0..dbb62085e7f9 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -124,7 +124,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 
 
-obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
+
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 38bfca25940d..189a34226fe0 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -26,6 +26,7 @@ source "drivers/platform/x86/intel/chtdc_ti/Kconfig"
 source "drivers/platform/x86/intel/mrfld/Kconfig"
 source "drivers/platform/x86/intel/pmc_core/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
+source "drivers/platform/x86/intel/punit/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 746bee1db055..9bd49a920900 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc_core/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt/
 obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt/
+obj-$(CONFIG_INTEL_PUNIT_IPC)		+= punit/
diff --git a/drivers/platform/x86/intel/punit/Kconfig b/drivers/platform/x86/intel/punit/Kconfig
new file mode 100644
index 000000000000..db56ef3bb086
--- /dev/null
+++ b/drivers/platform/x86/intel/punit/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# X86 Platform Specific Drivers
+#
+
+config INTEL_PUNIT_IPC
+	tristate "Intel P-Unit IPC Driver"
+	help
+	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
+	  which is used to bridge the communications between kernel and P-Unit.
diff --git a/drivers/platform/x86/intel/punit/Makefile b/drivers/platform/x86/intel/punit/Makefile
new file mode 100644
index 000000000000..f25284806f63
--- /dev/null
+++ b/drivers/platform/x86/intel/punit/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# X86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel/punit/intel_punit_ipc.c
similarity index 100%
rename from drivers/platform/x86/intel_punit_ipc.c
rename to drivers/platform/x86/intel/punit/intel_punit_ipc.c
-- 
2.31.1

