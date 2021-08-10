Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C33E57E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhHJKDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239659AbhHJKCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3LCly5veAM5JbmBfqRiWB5Ea8URtl1A80G69rdPHuE=;
        b=P96GSDfrVCciTN9xmUk2utx1TmJ4kHwC26kxaNMUJA2VuGxWWEV1ZQGgAsW6Ye5m24hJc2
        5GkWt9td9K0KQbIEeGU63QNsjbDcNoK4ED5Sh3lDeeEtpxKqExGk9hu9c2iiFnqdF+w1Q6
        h3/NBln2WcazqSK9UAuZsE+AE5z6YaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-hKKRCu8VNTODHrV7nhqvmw-1; Tue, 10 Aug 2021 06:01:52 -0400
X-MC-Unique: hKKRCu8VNTODHrV7nhqvmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6421190A7AA;
        Tue, 10 Aug 2021 10:01:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB98D78C00;
        Tue, 10 Aug 2021 10:01:40 +0000 (UTC)
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
Subject: [PATCH 20/20] Move Intel virtual botton driver to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:32 +0800
Message-Id: <20210810095832.4234-21-hpa@redhat.com>
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
 drivers/platform/x86/Kconfig                  | 15 ---------------
 drivers/platform/x86/Makefile                 |  2 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           | 19 +++++++++----------
 drivers/platform/x86/intel/vbtn/Kconfig       | 16 ++++++++++++++++
 drivers/platform/x86/intel/vbtn/Makefile      |  6 ++++++
 .../x86/{ => intel/vbtn}/intel-vbtn.c         |  0
 7 files changed, 32 insertions(+), 27 deletions(-)
 create mode 100644 drivers/platform/x86/intel/vbtn/Kconfig
 create mode 100644 drivers/platform/x86/intel/vbtn/Makefile
 rename drivers/platform/x86/{ => intel/vbtn}/intel-vbtn.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2426f8feb41f..a27584b77c52 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -632,21 +632,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-
-
-
-config INTEL_VBTN
-	tristate "INTEL VIRTUAL BUTTON"
-	depends on ACPI
-	depends on INPUT
-	select INPUT_SPARSEKMAP
-	help
-	  This driver provides support for the Intel Virtual Button interface.
-	  Some laptops require this driver for power button support.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_vbtn.
-
 config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index d3992588408a..a797e3444e63 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -66,8 +66,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
-
 # MSI
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index afc0f70c45ac..2f376edab328 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -38,6 +38,7 @@ source "drivers/platform/x86/intel/uncore_freq/Kconfig"
 source "drivers/platform/x86/intel/int0002/Kconfig"
 source "drivers/platform/x86/intel/menlow/Kconfig"
 source "drivers/platform/x86/intel/oaktrail/Kconfig"
+source "drivers/platform/x86/intel/vbtn/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 6acf5db0e847..5decc9eb1b0e 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -12,8 +12,9 @@ obj-$(CONFIG_INTEL_HID_EVENT)		+= hid/
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= int0002/
-obj-$(CONFIG_INTEL_MENLOW)		+= menlow/
+obj-$(CONFIG_INTEL_MENLOW)			+= menlow/
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= oaktrail/
+obj-$(CONFIG_INTEL_VBTN)			+= vbtn/
 
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc/
@@ -24,19 +25,17 @@ obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt/
 obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt/
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= punit/
-obj-$(CONFIG_INTEL_SCU_IPC)		+= scu/
-obj-$(CONFIG_INTEL_SCU_PCI)		+= scu/
+obj-$(CONFIG_INTEL_SCU_IPC)			+= scu/
+obj-$(CONFIG_INTEL_SCU_PCI)			+= scu/
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= scu/
-obj-$(CONFIG_INTEL_SCU_WDT)		+= scu/
+obj-$(CONFIG_INTEL_SCU_WDT)			+= scu/
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_IPS)				+= ips/
-obj-$(CONFIG_INTEL_RST)				+= rst/
-obj-$(CONFIG_INTEL_SMARTCONNECT)		+= smartconnect/
+obj-$(CONFIG_INTEL_IPS)						+= ips/
+obj-$(CONFIG_INTEL_RST)						+= rst/
+obj-$(CONFIG_INTEL_SMARTCONNECT)			+= smartconnect/
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= turbo_max_3/
+obj-$(CONFIG_INTEL_TURBO_MAX_3)				+= turbo_max_3/
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= uncore_freq/
-
-
diff --git a/drivers/platform/x86/intel/vbtn/Kconfig b/drivers/platform/x86/intel/vbtn/Kconfig
new file mode 100644
index 000000000000..c5dfd520530d
--- /dev/null
+++ b/drivers/platform/x86/intel/vbtn/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+config INTEL_VBTN
+	tristate "INTEL VIRTUAL BUTTON"
+	depends on ACPI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for the Intel Virtual Button interface.
+	  Some laptops require this driver for power button support.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_vbtn.
diff --git a/drivers/platform/x86/intel/vbtn/Makefile b/drivers/platform/x86/intel/vbtn/Makefile
new file mode 100644
index 000000000000..596833e13a31
--- /dev/null
+++ b/drivers/platform/x86/intel/vbtn/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Intel x86 Platform Specific Drivers
+#
+
+obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel/vbtn/intel-vbtn.c
similarity index 100%
rename from drivers/platform/x86/intel-vbtn.c
rename to drivers/platform/x86/intel/vbtn/intel-vbtn.c
-- 
2.31.1

