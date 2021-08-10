Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85673E57D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbhHJKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239540AbhHJKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3igV+kO61B3H/8m53CJPNByu9VIU4JVcTYLCXz+FFzc=;
        b=Nt93F+m07lz5r9/GuNT2lgFMf4uW4A3xfAwyCNeiFU2Z8eOGH0BDMkIodTHhOfEx+ohIct
        AQH/S8B9swOWPJ0Jbhx5Eu5Py2pB+iOBRELW+nI6SxF0nOu03UgnTtcu/hzpAIjzRXaIsA
        gYXQTzDz4apBIARGNGxIA4YL7wgE+M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Mpjx5wXDNumRAr10XKhFjA-1; Tue, 10 Aug 2021 06:00:51 -0400
X-MC-Unique: Mpjx5wXDNumRAr10XKhFjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 732CC18C9F40;
        Tue, 10 Aug 2021 10:00:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11BFF60BF1;
        Tue, 10 Aug 2021 10:00:43 +0000 (UTC)
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
Subject: [PATCH 13/20] Move Intel smartconnect driver of pdx86 to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:25 +0800
Message-Id: <20210810095832.4234-14-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                   | 13 -------------
 drivers/platform/x86/Makefile                  |  2 +-
 drivers/platform/x86/intel/Kconfig             |  1 +
 drivers/platform/x86/intel/Makefile            |  1 +
 .../platform/x86/intel/smartconnect/Kconfig    | 18 ++++++++++++++++++
 .../platform/x86/intel/smartconnect/Makefile   |  6 ++++++
 .../smartconnect}/intel-smartconnect.c         |  0
 7 files changed, 27 insertions(+), 14 deletions(-)
 create mode 100644 drivers/platform/x86/intel/smartconnect/Kconfig
 create mode 100644 drivers/platform/x86/intel/smartconnect/Makefile
 rename drivers/platform/x86/{ => intel/smartconnect}/intel-smartconnect.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ffb3957c5b57..f722f08cd89c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1027,19 +1027,6 @@ config INTEL_IMR
 	  If you are running on a Galileo/Quark say Y here.
 
 
-config INTEL_SMARTCONNECT
-        tristate "Intel Smart Connect disabling driver"
-	depends on ACPI
-	help
-	  Intel Smart Connect is a technology intended to permit devices to
-	  update state by resuming for a short period of time at regular
-	  intervals. If a user enables this functionality under Windows and
-	  then reboots into Linux, the system may remain configured to resume
-	  on suspend. In the absence of any userspace to support it, the system
-	  will then remain awake until something triggers another suspend.
-
-	  This driver checks to determine whether the device has Intel Smart
-	  Connect enabled, and if so disables it.
 
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index d3ee3413ad13..b809aaac300c 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -113,7 +113,7 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
+
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index e16b93c8ea68..0ebc6e0a24ca 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -31,6 +31,7 @@ source "drivers/platform/x86/intel/scu/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 source "drivers/platform/x86/intel/ips/Kconfig"
 source "drivers/platform/x86/intel/rst/Kconfig"
+source "drivers/platform/x86/intel/smartconnect/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 335eb1bc7eaf..5a916bb1512f 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= ips/
 obj-$(CONFIG_INTEL_RST)				+= rst/
+obj-$(CONFIG_INTEL_SMARTCONNECT)		+= smartconnect/
diff --git a/drivers/platform/x86/intel/smartconnect/Kconfig b/drivers/platform/x86/intel/smartconnect/Kconfig
new file mode 100644
index 000000000000..2cc0c8504285
--- /dev/null
+++ b/drivers/platform/x86/intel/smartconnect/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_SMARTCONNECT
+        tristate "Intel Smart Connect disabling driver"
+	depends on ACPI
+	help
+	  Intel Smart Connect is a technology intended to permit devices to
+	  update state by resuming for a short period of time at regular
+	  intervals. If a user enables this functionality under Windows and
+	  then reboots into Linux, the system may remain configured to resume
+	  on suspend. In the absence of any userspace to support it, the system
+	  will then remain awake until something triggers another suspend.
+
+	  This driver checks to determine whether the device has Intel Smart
+	  Connect enabled, and if so disables it.
diff --git a/drivers/platform/x86/intel/smartconnect/Makefile b/drivers/platform/x86/intel/smartconnect/Makefile
new file mode 100644
index 000000000000..74ef29b5b714
--- /dev/null
+++ b/drivers/platform/x86/intel/smartconnect/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel-smartconnect.c b/drivers/platform/x86/intel/smartconnect/intel-smartconnect.c
similarity index 100%
rename from drivers/platform/x86/intel-smartconnect.c
rename to drivers/platform/x86/intel/smartconnect/intel-smartconnect.c
-- 
2.31.1

