Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF63E57D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbhHJKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239636AbhHJKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvE07P9oN1fx2RopjpISGNmGFfpMH0soDjIjmIT5xoA=;
        b=EsbuSz3UW39VyMjZgRH4f0j8+GmtuzMrrw6FoYwEtcnvInOo6DOvRm1PH7GA+MY4osVWQ1
        TdFFA2snTSZmd2ucjA4O6nqo7cOxTQUV4dVj02uGyVr4G2RVXKeNn68e9+/PJIk8jSj/Ve
        5yRsQ+tvLLFJ9TWtn00qlb1U7fb2sh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-PVdB8pjOMlafpi0w1I9D4g-1; Tue, 10 Aug 2021 06:01:07 -0400
X-MC-Unique: PVdB8pjOMlafpi0w1I9D4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8803418C9F48;
        Tue, 10 Aug 2021 10:01:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 452B060BF1;
        Tue, 10 Aug 2021 10:00:59 +0000 (UTC)
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
Subject: [PATCH 15/20] Move Intel turbo max 3 driver to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:27 +0800
Message-Id: <20210810095832.4234-16-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                       | 10 ----------
 drivers/platform/x86/Makefile                      |  1 -
 drivers/platform/x86/intel/Kconfig                 |  1 +
 drivers/platform/x86/intel/Makefile                |  3 ++-
 drivers/platform/x86/intel/turbo_max_3/Kconfig     | 14 ++++++++++++++
 drivers/platform/x86/intel/turbo_max_3/Makefile    |  6 ++++++
 .../{ => intel/turbo_max_3}/intel_turbo_max_3.c    |  0
 7 files changed, 23 insertions(+), 12 deletions(-)
 create mode 100644 drivers/platform/x86/intel/turbo_max_3/Kconfig
 create mode 100644 drivers/platform/x86/intel/turbo_max_3/Makefile
 rename drivers/platform/x86/{ => intel/turbo_max_3}/intel_turbo_max_3.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ff0a36a61404..735949c406d3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1028,16 +1028,6 @@ config INTEL_IMR
 
 
 
-config INTEL_TURBO_MAX_3
-	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
-	depends on X86_64 && SCHED_MC_PRIO
-	help
-	  This driver reads maximum performance ratio of each CPU and set up
-	  the scheduler priority metrics. In this way scheduler can prefer
-	  CPU with higher performance to schedule tasks.
-	  This driver is only required when the system is not using Hardware
-	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
-
 config INTEL_UNCORE_FREQ_CONTROL
 	tristate "Intel Uncore frequency control driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2ce50bae6b71..e3ea8bf3647b 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -115,7 +115,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 # Intel uncore drivers
 
 
-obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index f6c326d33ea0..d3f1be45a25f 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -33,6 +33,7 @@ source "drivers/platform/x86/intel/ips/Kconfig"
 source "drivers/platform/x86/intel/rst/Kconfig"
 source "drivers/platform/x86/intel/smartconnect/Kconfig"
 source "drivers/platform/x86/intel/intel_speed_select_if/Kconfig"
+source "drivers/platform/x86/intel/turbo_max_3/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 972076bdcd4e..040109e2908a 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 obj-$(CONFIG_INTEL_IPS)				+= ips/
 obj-$(CONFIG_INTEL_RST)				+= rst/
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= smartconnect/
-obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
\ No newline at end of file
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
+obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= turbo_max_3/
diff --git a/drivers/platform/x86/intel/turbo_max_3/Kconfig b/drivers/platform/x86/intel/turbo_max_3/Kconfig
new file mode 100644
index 000000000000..e4518914ccc4
--- /dev/null
+++ b/drivers/platform/x86/intel/turbo_max_3/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_TURBO_MAX_3
+	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
+	depends on X86_64 && SCHED_MC_PRIO
+	help
+	  This driver reads maximum performance ratio of each CPU and set up
+	  the scheduler priority metrics. In this way scheduler can prefer
+	  CPU with higher performance to schedule tasks.
+	  This driver is only required when the system is not using Hardware
+	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
diff --git a/drivers/platform/x86/intel/turbo_max_3/Makefile b/drivers/platform/x86/intel/turbo_max_3/Makefile
new file mode 100644
index 000000000000..4715da45373b
--- /dev/null
+++ b/drivers/platform/x86/intel/turbo_max_3/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3/intel_turbo_max_3.c
similarity index 100%
rename from drivers/platform/x86/intel_turbo_max_3.c
rename to drivers/platform/x86/intel/turbo_max_3/intel_turbo_max_3.c
-- 
2.31.1

