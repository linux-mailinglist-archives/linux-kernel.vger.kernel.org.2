Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECF3F11C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhHSDdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236929AbhHSDcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQpziQ6Rj2gnabS9wmfFf8vTlI/P7DAPk0LPZgWEcOo=;
        b=MKGXBmjKyAROFuO4OLl0TvD/V5egz1LFrF4a8rRLUvujNeCMbpgLfSZna0ZqZoWtJzpLx+
        Ys9FXSDtLurxhwNR3tkWVy0beOyp+WYHUmA5Ts52LTsh+eF9rjlqkwANmVugzNeeuAQK7x
        8mvpgZPI2fCou5gFJHQzkbqhrro8hfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-1GpmDY2iOPCMYTq-JKyZEQ-1; Wed, 18 Aug 2021 23:32:13 -0400
X-MC-Unique: 1GpmDY2iOPCMYTq-JKyZEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8C8190B2A9;
        Thu, 19 Aug 2021 03:32:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B94EA19C87;
        Thu, 19 Aug 2021 03:32:08 +0000 (UTC)
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
Subject: [PATCH v3 19/20] platform/x86: intel-wmi-sbl-fw-updat: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:30:00 +0800
Message-Id: <20210819033001.20136-20-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-wmi-sbl-fw-updat to intel sub-directory to improve
readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                       | 10 ----------
 drivers/platform/x86/Makefile                      |  2 +-
 drivers/platform/x86/intel/Kconfig                 |  3 +++
 drivers/platform/x86/intel/Makefile                |  3 +++
 drivers/platform/x86/intel/wmi/Kconfig             | 14 ++++++++++++++
 drivers/platform/x86/intel/wmi/Makefile            |  7 +++++++
 .../wmi/sbl-fw-update.c}                           |  0
 7 files changed, 28 insertions(+), 11 deletions(-)
 create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
 create mode 100644 drivers/platform/x86/intel/wmi/Makefile
 rename drivers/platform/x86/{intel-wmi-sbl-fw-update.c => intel/wmi/sbl-fw-update.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b8ce4e6d90dd..611930985b1d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -77,16 +77,6 @@ config UV_SYSFS
 	  To compile this driver as a module, choose M here: the module will
 	  be called uv_sysfs.
 
-config INTEL_WMI_SBL_FW_UPDATE
-	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
-	depends on ACPI_WMI
-	help
-	  Say Y here if you want to be able to use the WMI interface to signal
-	  Slim Bootloader to trigger update on next reboot.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel-wmi-sbl-fw-update.
-
 config INTEL_WMI_THUNDERBOLT
 	tristate "Intel WMI thunderbolt force power driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index d8b193e910bd..0a6dca068d5a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
-obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
+
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 3a13f7a6da4d..665146ac65e9 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -177,4 +177,7 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
+source "drivers/platform/x86/intel/wmi/Kconfig"
+
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 4211c683315f..0b27be3b9334 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -47,3 +47,6 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 intel-uncore-frequency-y					:= uncore-frequency.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= speed_select_if/
+
+#WMI drivers
+obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)		+= wmi/
diff --git a/drivers/platform/x86/intel/wmi/Kconfig b/drivers/platform/x86/intel/wmi/Kconfig
new file mode 100644
index 000000000000..fc70728e0f1f
--- /dev/null
+++ b/drivers/platform/x86/intel/wmi/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_WMI_SBL_FW_UPDATE
+	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface to signal
+	  Slim Bootloader to trigger update on next reboot.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-sbl-fw-update.
diff --git a/drivers/platform/x86/intel/wmi/Makefile b/drivers/platform/x86/intel/wmi/Makefile
new file mode 100644
index 000000000000..bf1f118b6839
--- /dev/null
+++ b/drivers/platform/x86/intel/wmi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+intel-wmi-sbl-fw-update-y				:= sbl-fw-update.o
+obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
diff --git a/drivers/platform/x86/intel-wmi-sbl-fw-update.c b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
similarity index 100%
rename from drivers/platform/x86/intel-wmi-sbl-fw-update.c
rename to drivers/platform/x86/intel/wmi/sbl-fw-update.c
-- 
2.31.1

