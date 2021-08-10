Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A43E57D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbhHJKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239579AbhHJKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxJmuD+6BZ9dfrjxwJDGWFMtwr42fesXLtTN6tMl5hI=;
        b=WQjPs0ogP/0A0R/woa9KAGczq27Du9r3UYF2Qjc1oFnL3XfRljXkqgZSPzY7Cb7vtuDjpg
        VPgcGUUlTatusVz3HwDGNz5NCY4z6fV4v2AUi9/l/ZWK2XHnIoQyKt7Ag+dYxvkOGdDlCF
        xxoidYbsEyjOCyQgjXlSs1qzA7Lzsoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-DYglKOrGO9m0xi_7ZMBeWw-1; Tue, 10 Aug 2021 06:00:44 -0400
X-MC-Unique: DYglKOrGO9m0xi_7ZMBeWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F19801008064;
        Tue, 10 Aug 2021 10:00:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5A760C9F;
        Tue, 10 Aug 2021 10:00:35 +0000 (UTC)
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
Subject: [PATCH 12/20] Move Intel RST driver of pdx86 to intel directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:24 +0800
Message-Id: <20210810095832.4234-13-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                  | 21 -------------------
 drivers/platform/x86/Makefile                 |  2 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/rst/Kconfig        | 16 ++++++++++++++
 drivers/platform/x86/intel/rst/Makefile       |  6 ++++++
 .../platform/x86/{ => intel/rst}/intel-rst.c  |  0
 7 files changed, 24 insertions(+), 23 deletions(-)
 create mode 100644 drivers/platform/x86/intel/rst/Kconfig
 create mode 100644 drivers/platform/x86/intel/rst/Makefile
 rename drivers/platform/x86/{ => intel/rst}/intel-rst.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b14c3a2953db..ffb3957c5b57 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1026,27 +1026,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-config INTEL_IPS
-	tristate "Intel Intelligent Power Sharing"
-	depends on ACPI && PCI
-	help
-	  Intel Calpella platforms support dynamic power sharing between the
-	  CPU and GPU, maximizing performance in a given TDP.  This driver,
-	  along with the CPU frequency and i915 drivers, provides that
-	  functionality.  If in doubt, say Y here; it will only load on
-	  supported platforms.
-
-config INTEL_RST
-        tristate "Intel Rapid Start Technology Driver"
-	depends on ACPI
-	help
-	  This driver provides support for modifying parameters on systems
-	  equipped with Intel's Rapid Start Technology. When put in an ACPI
-	  sleep state, these devices will wake after either a configured
-	  timeout or when the system battery reaches a critical state,
-	  automatically copying memory contents to disk. On resume, the
-	  firmware will copy the memory contents back to RAM and resume the OS
-	  as usual.
 
 config INTEL_SMARTCONNECT
         tristate "Intel Smart Connect disabling driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index a755736341a0..d3ee3413ad13 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -113,8 +113,6 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-
-obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 5cbc1e4a4756..e16b93c8ea68 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -30,6 +30,7 @@ source "drivers/platform/x86/intel/punit/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 source "drivers/platform/x86/intel/ips/Kconfig"
+source "drivers/platform/x86/intel/rst/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index b87767623f94..335eb1bc7eaf 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= ips/
+obj-$(CONFIG_INTEL_RST)				+= rst/
diff --git a/drivers/platform/x86/intel/rst/Kconfig b/drivers/platform/x86/intel/rst/Kconfig
new file mode 100644
index 000000000000..12265c2c9c32
--- /dev/null
+++ b/drivers/platform/x86/intel/rst/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_RST
+        tristate "Intel Rapid Start Technology Driver"
+	depends on ACPI
+	help
+	  This driver provides support for modifying parameters on systems
+	  equipped with Intel's Rapid Start Technology. When put in an ACPI
+	  sleep state, these devices will wake after either a configured
+	  timeout or when the system battery reaches a critical state,
+	  automatically copying memory contents to disk. On resume, the
+	  firmware will copy the memory contents back to RAM and resume the OS
+	  as usual.
diff --git a/drivers/platform/x86/intel/rst/Makefile b/drivers/platform/x86/intel/rst/Makefile
new file mode 100644
index 000000000000..2dc6d16fca19
--- /dev/null
+++ b/drivers/platform/x86/intel/rst/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel/rst/intel-rst.c
similarity index 100%
rename from drivers/platform/x86/intel-rst.c
rename to drivers/platform/x86/intel/rst/intel-rst.c
-- 
2.31.1

