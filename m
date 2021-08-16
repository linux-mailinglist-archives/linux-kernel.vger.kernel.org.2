Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8A3ED28A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhHPKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236273AbhHPKyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCT7KnHs8H7sKejKTiNnvLeLkx5tQLV3iJxhOfOhMJ4=;
        b=dhKGiPkgm0X4spPZJGVihiU7mbfxaEwE4V9zgiZxR4j0s9NaTjSL/w+Ah6QThWJypEC+Wd
        /Y086aDRYdl6CddyHcHIjUORzUMk5RNm5ptdalsKXIOlcZjqLMgYgDnOpMZhGboFo8N2ky
        iRz95Vnj7soGIApZfaVUjIX2t678C3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-YpQ-8Ga-O4yksNmyMn_n8Q-1; Mon, 16 Aug 2021 06:53:31 -0400
X-MC-Unique: YpQ-8Ga-O4yksNmyMn_n8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3DAE1051470;
        Mon, 16 Aug 2021 10:53:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804925FC25;
        Mon, 16 Aug 2021 10:53:26 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v2 07/20] platform/x86: intel_telemetry: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:06 +0800
Message-Id: <20210816105119.704302-8-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_telemetry to intel sub-directory to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                     | 13 -------------
 drivers/platform/x86/Makefile                    |  5 -----
 drivers/platform/x86/intel/Kconfig               |  1 +
 drivers/platform/x86/intel/Makefile              |  1 +
 drivers/platform/x86/intel/telemetry/Kconfig     | 16 ++++++++++++++++
 drivers/platform/x86/intel/telemetry/Makefile    | 11 +++++++++++
 .../telemetry/telemetry_core.c}                  |  0
 .../telemetry/telemetry_debugfs.c}               |  0
 .../telemetry/telemetry_pltdrv.c}                |  0
 9 files changed, 29 insertions(+), 18 deletions(-)
 create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
 create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
 rename drivers/platform/x86/{intel_telemetry_core.c => intel/telemetry/telemetry_core.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_debugfs.c => intel/telemetry/telemetry_debugfs.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_pltdrv.c => intel/telemetry/telemetry_pltdrv.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e34e6af7a7d4..fdc8b4c259ee 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1168,19 +1168,6 @@ config INTEL_UNCORE_FREQ_CONTROL
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
index e96f0e77df88..bd9754dfa37d 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -127,10 +127,5 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
-# Intel PMIC / PMC / P-Unit devices
 
-
-obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
-					   intel_telemetry_pltdrv.o \
-					   intel_telemetry_debugfs.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 672b6ad64ff1..fb409f044e27 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -60,5 +60,6 @@ config INTEL_PUNIT_IPC
 
 source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
+source "drivers/platform/x86/intel/telemetry/Kconfig"
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index e842a72fa516..51ea5ee1f833 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -23,4 +23,5 @@ obj-$(CONFIG_INTEL_SCU_PCI)			+= scu/
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
 obj-$(CONFIG_INTEL_SCU_WDT)			+= scu/
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
+obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
diff --git a/drivers/platform/x86/intel/telemetry/Kconfig b/drivers/platform/x86/intel/telemetry/Kconfig
new file mode 100644
index 000000000000..9fbc06dc4593
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
diff --git a/drivers/platform/x86/intel/telemetry/Makefile b/drivers/platform/x86/intel/telemetry/Makefile
new file mode 100644
index 000000000000..74344f36eb99
--- /dev/null
+++ b/drivers/platform/x86/intel/telemetry/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+intel_telemetry_core-y				:= telemetry_core.o
+intel_telemetry_pltdrv-y			:= telemetry_pltdrv.o
+intel_telemetry_debugfs-y			:= telemetry_debugfs.o
+obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
+									   intel_telemetry_pltdrv.o \
+									   intel_telemetry_debugfs.o
diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel/telemetry/telemetry_core.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_core.c
rename to drivers/platform/x86/intel/telemetry/telemetry_core.c
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel/telemetry/telemetry_debugfs.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_debugfs.c
rename to drivers/platform/x86/intel/telemetry/telemetry_debugfs.c
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel/telemetry/telemetry_pltdrv.c
similarity index 100%
rename from drivers/platform/x86/intel_telemetry_pltdrv.c
rename to drivers/platform/x86/intel/telemetry/telemetry_pltdrv.c
-- 
2.31.1

