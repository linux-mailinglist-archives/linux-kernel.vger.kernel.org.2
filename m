Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B343E57E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhHJKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239660AbhHJKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txlun0lAPvcijRW0P28VOpGx1u5QRiIBKr9FcIZwHL0=;
        b=Ne+iPBhN5/neau4gvJq8FCqzz4Jxm4V6obd1jsgkWLckP2cxVHHSQ59Q+xtu8P5DteXMlm
        5f0GBbaR7N47cdqHEpXL81G0zCqXIf48nFl+B4/y20g/J80dCWbcu4WmDaRVPyN9PQr4m5
        uQ8KN4ubPVOaiZsTG4BUZw17sALpRJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-TOfXTc5bO0afoJoLFfPL-g-1; Tue, 10 Aug 2021 06:01:33 -0400
X-MC-Unique: TOfXTc5bO0afoJoLFfPL-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94399879A0B;
        Tue, 10 Aug 2021 10:01:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C2C60BF1;
        Tue, 10 Aug 2021 10:01:24 +0000 (UTC)
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
Subject: [PATCH 18/20] Move Intel thermal driver for menlow platform driver to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:30 +0800
Message-Id: <20210810095832.4234-19-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                       |  8 --------
 drivers/platform/x86/Makefile                      |  2 +-
 drivers/platform/x86/intel/Kconfig                 |  1 +
 drivers/platform/x86/intel/Makefile                |  2 ++
 drivers/platform/x86/intel/menlow/Kconfig          | 14 ++++++++++++++
 drivers/platform/x86/intel/menlow/Makefile         |  6 ++++++
 .../platform/x86/{ => intel/menlow}/intel_menlow.c |  0
 7 files changed, 24 insertions(+), 9 deletions(-)
 create mode 100644 drivers/platform/x86/intel/menlow/Kconfig
 create mode 100644 drivers/platform/x86/intel/menlow/Makefile
 rename drivers/platform/x86/{ => intel/menlow}/intel_menlow.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b9c0d2d97793..50ded236a841 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -632,15 +632,7 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_MENLOW
-	tristate "Thermal Management driver for Intel menlow platform"
-	depends on ACPI_THERMAL
-	select THERMAL
-	help
-	  ACPI thermal management enhancement driver on
-	  Intel Menlow platform.
 
-	  If unsure, say N.
 
 config INTEL_OAKTRAIL
 	tristate "Intel Oaktrail Platform Extras"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index f4c6ced59da1..ea5f5dd3f78a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
 
-obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
+
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 4efb5ad3e3e1..59c9b602c784 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -36,6 +36,7 @@ source "drivers/platform/x86/intel/intel_speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/turbo_max_3/Kconfig"
 source "drivers/platform/x86/intel/uncore_freq/Kconfig"
 source "drivers/platform/x86/intel/int0002/Kconfig"
+source "drivers/platform/x86/intel/menlow/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index fe5058c3af18..b2326554bd84 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_INTEL_HID_EVENT)		+= hid/
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= int0002/
+obj-$(CONFIG_INTEL_MENLOW)		+= menlow/
 
 
 # Intel PMIC / PMC / P-Unit devices
@@ -38,3 +39,4 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= turbo_max_3/
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= uncore_freq/
 
+
diff --git a/drivers/platform/x86/intel/menlow/Kconfig b/drivers/platform/x86/intel/menlow/Kconfig
new file mode 100644
index 000000000000..b2920d259ff7
--- /dev/null
+++ b/drivers/platform/x86/intel/menlow/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_MENLOW
+	tristate "Thermal Management driver for Intel menlow platform"
+	depends on ACPI_THERMAL
+	select THERMAL
+	help
+	  ACPI thermal management enhancement driver on
+	  Intel Menlow platform.
+
+	  If unsure, say N.
diff --git a/drivers/platform/x86/intel/menlow/Makefile b/drivers/platform/x86/intel/menlow/Makefile
new file mode 100644
index 000000000000..0e9fda9bff98
--- /dev/null
+++ b/drivers/platform/x86/intel/menlow/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel/menlow/intel_menlow.c
similarity index 100%
rename from drivers/platform/x86/intel_menlow.c
rename to drivers/platform/x86/intel/menlow/intel_menlow.c
-- 
2.31.1

