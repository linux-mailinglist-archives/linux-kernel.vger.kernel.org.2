Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867FA3E57B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbhHJJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237569AbhHJJ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+obnZq/7XkcEizeAmSarMyeT0F0j9gGSrpe8vbnBSpw=;
        b=ZjjDf0g7883Q77C+b8fmaUEVuhKDEzHGJ6eWR1zPP6lU/+Y3s/UqQ3U9DQhtjJqinPNazb
        Fhu+1pF97VB7UcTsITkdKykAZbWXFflhq86zuU901f6BUJq0Mkrk4KPFsU3qIcOqnXC06m
        ZSsVlC6n886SlK+jSmE3fQmUpKTueMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-zEjkY5U-NvuElQIvPfUYZw-1; Tue, 10 Aug 2021 05:59:09 -0400
X-MC-Unique: zEjkY5U-NvuElQIvPfUYZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB5BF802947;
        Tue, 10 Aug 2021 09:59:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E58860BF1;
        Tue, 10 Aug 2021 09:59:01 +0000 (UTC)
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
Subject: [PATCH 01/20] Move Intel hid of pdx86 to intel directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:13 +0800
Message-Id: <20210810095832.4234-2-hpa@redhat.com>
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/Kconfig                    | 12 ------------
 drivers/platform/x86/Makefile                   |  2 +-
 drivers/platform/x86/intel/Kconfig              |  1 +
 drivers/platform/x86/intel/Makefile             |  2 ++
 drivers/platform/x86/intel/hid/Kconfig          | 17 +++++++++++++++++
 drivers/platform/x86/intel/hid/Makefile         |  7 +++++++
 .../platform/x86/{ => intel/hid}/intel-hid.c    |  0
 7 files changed, 28 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/x86/intel/hid/Kconfig
 create mode 100644 drivers/platform/x86/intel/hid/Makefile
 rename drivers/platform/x86/{ => intel/hid}/intel-hid.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 38f3e774d5f3..6765f613ce0e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -653,18 +653,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_HID_EVENT
-	tristate "INTEL HID Event"
-	depends on ACPI
-	depends on INPUT
-	select INPUT_SPARSEKMAP
-	help
-	  This driver provides support for the Intel HID Event hotkey interface.
-	  Some laptops require this driver for hotkey support.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_hid.
-
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
 	depends on GPIOLIB && ACPI && PM_SLEEP
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index f8b475b7a962..328f4bcf99d0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
+
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 161aa19ee863..d2254ab6aad8 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -19,5 +19,6 @@ if X86_PLATFORM_DRIVERS_INTEL
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
+source "drivers/platform/x86/intel/hid/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index af9442e3d2a9..6f04221456fb 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -8,3 +8,5 @@ obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= atomisp2/
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= atomisp2/
+obj-$(CONFIG_INTEL_HID_EVENT)		+= hid/
+
diff --git a/drivers/platform/x86/intel/hid/Kconfig b/drivers/platform/x86/intel/hid/Kconfig
new file mode 100644
index 000000000000..daacd698aec4
--- /dev/null
+++ b/drivers/platform/x86/intel/hid/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for drivers/platform/x86/intel
+# Intel x86 Platform-Specific Drivers
+#
+
+config INTEL_HID_EVENT
+	tristate "INTEL HID Event"
+	depends on ACPI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for the Intel HID Event hotkey interface.
+	  Some laptops require this driver for hotkey support.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_hid.
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/hid/Makefile b/drivers/platform/x86/intel/hid/Makefile
new file mode 100644
index 000000000000..9e2e753834d5
--- /dev/null
+++ b/drivers/platform/x86/intel/hid/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for drivers/platform/x86/intel
+# Intel x86 Platform-Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel/hid/intel-hid.c
similarity index 100%
rename from drivers/platform/x86/intel-hid.c
rename to drivers/platform/x86/intel/hid/intel-hid.c
-- 
2.31.1

