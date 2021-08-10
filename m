Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330003E57D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhHJKBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239540AbhHJKBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0iOhFOiHCE75l+M+6ygTcfw1Md7cOy6sIwCci05tYg=;
        b=I5GI9yiL0ab3IDkncGZcKc4qP+CNqvPRgc7xIGWSA4rivZmWNKzf63MKnRORWBT3PbdXJ+
        /ARy3u/UH3KqtEmq7pR+sOybS4vv/Ij7oE3t7ZcScTWZokyL6PJ8Gct/L2Tn6hgbJR0dN1
        IjVuW689KZpzTDgLVdyPIsW7YUdkdWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-S2yMeDnOP1WsJBTZinuq0w-1; Tue, 10 Aug 2021 06:00:35 -0400
X-MC-Unique: S2yMeDnOP1WsJBTZinuq0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2626B107ACF5;
        Tue, 10 Aug 2021 10:00:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D522360BF1;
        Tue, 10 Aug 2021 10:00:27 +0000 (UTC)
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
Subject: [PATCH 11/20] Move Intel IPS driver of pdx86 to improve readability.
Date:   Tue, 10 Aug 2021 17:58:23 +0800
Message-Id: <20210810095832.4234-12-hpa@redhat.com>
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
 drivers/platform/x86/Makefile                    |  7 +------
 drivers/platform/x86/intel/Kconfig               |  1 +
 drivers/platform/x86/intel/Makefile              |  3 +++
 drivers/platform/x86/intel/ips/Kconfig           | 14 ++++++++++++++
 drivers/platform/x86/intel/ips/Makefile          |  6 ++++++
 drivers/platform/x86/{ => intel/ips}/intel_ips.c |  0
 drivers/platform/x86/{ => intel/ips}/intel_ips.h |  0
 7 files changed, 25 insertions(+), 6 deletions(-)
 create mode 100644 drivers/platform/x86/intel/ips/Kconfig
 create mode 100644 drivers/platform/x86/intel/ips/Makefile
 rename drivers/platform/x86/{ => intel/ips}/intel_ips.c (100%)
 rename drivers/platform/x86/{ => intel/ips}/intel_ips.h (100%)

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1d7acccf5e3a..a755736341a0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -113,17 +113,12 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
+
 obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
-# Intel PMIC / PMC / P-Unit devices
-
-
-
-
 
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 02e7792d34b0..5cbc1e4a4756 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -29,6 +29,7 @@ source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/punit/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
+source "drivers/platform/x86/intel/ips/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 3edbd5209072..b87767623f94 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -28,3 +28,6 @@ obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
 obj-$(CONFIG_INTEL_SCU_WDT)		+= scu/
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
+
+# Intel uncore drivers
+obj-$(CONFIG_INTEL_IPS)				+= ips/
diff --git a/drivers/platform/x86/intel/ips/Kconfig b/drivers/platform/x86/intel/ips/Kconfig
new file mode 100644
index 000000000000..3417f3586d73
--- /dev/null
+++ b/drivers/platform/x86/intel/ips/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_IPS
+	tristate "Intel Intelligent Power Sharing"
+	depends on ACPI && PCI
+	help
+	  Intel Calpella platforms support dynamic power sharing between the
+	  CPU and GPU, maximizing performance in a given TDP.  This driver,
+	  along with the CPU frequency and i915 drivers, provides that
+	  functionality.  If in doubt, say Y here; it will only load on
+	  supported platforms.
\ No newline at end of file
diff --git a/drivers/platform/x86/intel/ips/Makefile b/drivers/platform/x86/intel/ips/Makefile
new file mode 100644
index 000000000000..a76450b840c8
--- /dev/null
+++ b/drivers/platform/x86/intel/ips/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel/ips/intel_ips.c
similarity index 100%
rename from drivers/platform/x86/intel_ips.c
rename to drivers/platform/x86/intel/ips/intel_ips.c
diff --git a/drivers/platform/x86/intel_ips.h b/drivers/platform/x86/intel/ips/intel_ips.h
similarity index 100%
rename from drivers/platform/x86/intel_ips.h
rename to drivers/platform/x86/intel/ips/intel_ips.h
-- 
2.31.1

