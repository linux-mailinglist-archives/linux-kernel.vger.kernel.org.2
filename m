Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367A3E57E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhHJKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239687AbhHJKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eycIdSAELO2BZpcPDa4Yqaz6UsFPGywf7kXBBnISRM=;
        b=LI7WsEWDr0lS8sLBE5ROrowANBUqWpsSgm3CYkXKWfrDQCFQWm5KgNXqh3RX1RsaOeBld2
        33I+CilM/50YSAU2K1pC7N3+EE39aMwvEZmx/nijLoxTmsbSvTefnwIOcx/pt3v67uylKa
        U1oVO8muJZb5NRmukduFO2e7XPI4iW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-fGTzcjgOOzu0IxxCZtw3tw-1; Tue, 10 Aug 2021 06:01:41 -0400
X-MC-Unique: fGTzcjgOOzu0IxxCZtw3tw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D202A100A24F;
        Tue, 10 Aug 2021 10:01:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFE3D60BF1;
        Tue, 10 Aug 2021 10:01:32 +0000 (UTC)
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
Subject: [PATCH 19/20] Move OakTrail driver to the intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:31 +0800
Message-Id: <20210810095832.4234-20-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                      |  9 ---------
 drivers/platform/x86/Makefile                     |  3 ---
 drivers/platform/x86/intel/Kconfig                |  1 +
 drivers/platform/x86/intel/Makefile               |  2 +-
 drivers/platform/x86/intel/oaktrail/Kconfig       | 15 +++++++++++++++
 drivers/platform/x86/intel/oaktrail/Makefile      |  6 ++++++
 .../x86/{ => intel/oaktrail}/intel_oaktrail.c     |  0
 7 files changed, 23 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/x86/intel/oaktrail/Kconfig
 create mode 100644 drivers/platform/x86/intel/oaktrail/Makefile
 rename drivers/platform/x86/{ => intel/oaktrail}/intel_oaktrail.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 50ded236a841..2426f8feb41f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -634,15 +634,6 @@ source "drivers/platform/x86/intel/Kconfig"
 
 
 
-config INTEL_OAKTRAIL
-	tristate "Intel Oaktrail Platform Extras"
-	depends on ACPI
-	depends on ACPI_VIDEO || ACPI_VIDEO = n
-	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
-	help
-	  Intel Oaktrail platform need this driver to provide interfaces to
-	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
-	  here; it will only load on supported platforms.
 
 config INTEL_VBTN
 	tristate "INTEL VIRTUAL BUTTON"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ea5f5dd3f78a..d3992588408a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -66,9 +66,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-
-
-obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # MSI
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 59c9b602c784..afc0f70c45ac 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -37,6 +37,7 @@ source "drivers/platform/x86/intel/turbo_max_3/Kconfig"
 source "drivers/platform/x86/intel/uncore_freq/Kconfig"
 source "drivers/platform/x86/intel/int0002/Kconfig"
 source "drivers/platform/x86/intel/menlow/Kconfig"
+source "drivers/platform/x86/intel/oaktrail/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index b2326554bd84..6acf5db0e847 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= int0002/
 obj-$(CONFIG_INTEL_MENLOW)		+= menlow/
-
+obj-$(CONFIG_INTEL_OAKTRAIL)		+= oaktrail/
 
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
diff --git a/drivers/platform/x86/intel/oaktrail/Kconfig b/drivers/platform/x86/intel/oaktrail/Kconfig
new file mode 100644
index 000000000000..6063fd4e19ca
--- /dev/null
+++ b/drivers/platform/x86/intel/oaktrail/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_OAKTRAIL
+	tristate "Intel Oaktrail Platform Extras"
+	depends on ACPI
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
+	help
+	  Intel Oaktrail platform need this driver to provide interfaces to
+	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
+	  here; it will only load on supported platforms.
+
diff --git a/drivers/platform/x86/intel/oaktrail/Makefile b/drivers/platform/x86/intel/oaktrail/Makefile
new file mode 100644
index 000000000000..dc2a7e850153
--- /dev/null
+++ b/drivers/platform/x86/intel/oaktrail/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel/oaktrail/intel_oaktrail.c
similarity index 100%
rename from drivers/platform/x86/intel_oaktrail.c
rename to drivers/platform/x86/intel/oaktrail/intel_oaktrail.c
-- 
2.31.1

