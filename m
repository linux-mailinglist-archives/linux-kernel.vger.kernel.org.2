Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DB13ED297
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhHPKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236221AbhHPKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6YQwz0m6qTbdSvroo1C1n+ZVy1/P811PkKLVx7WHvc=;
        b=AjThJEmxtaPriFw79tGSqzLFa8YHn4Q9urYX1mKt/D8pUwKbSTlifrb0wLKFfugV4R+/FD
        la8E+Hcllf+bm3mcgWcYnIXb2shXMKwCOIxuCCrbKHa2iTjtpriLxpMoctiwEW+XDd8mXW
        7lDBt3FrVn5vDoW5PU7yG3xwrlG+hYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-LdnkM4Z4M1OkMw9Lm9X4UA-1; Mon, 16 Aug 2021 06:54:28 -0400
X-MC-Unique: LdnkM4Z4M1OkMw9Lm9X4UA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3809087D542;
        Mon, 16 Aug 2021 10:54:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D304618017;
        Mon, 16 Aug 2021 10:54:22 +0000 (UTC)
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
Subject: [PATCH v2 14/20] platform/x86: intel_atomisp2_led: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:13 +0800
Message-Id: <20210816105119.704302-15-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_atomisp2_led to intel sub-directory to improve
readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                  | 34 ------------------
 drivers/platform/x86/Makefile                 |  2 --
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  2 ++
 drivers/platform/x86/intel/atomisp2/Kconfig   | 35 +++++++++++++++++++
 drivers/platform/x86/intel/atomisp2/Makefile  |  5 +++
 .../atomisp2/led.c}                           |  0
 .../atomisp2/pm.c}                            |  0
 8 files changed, 43 insertions(+), 36 deletions(-)
 create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
 create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
 rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
 rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b864e37c6781..ac4ec4e2534a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -667,40 +667,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_ATOMISP2_LED
-	tristate "Intel AtomISP2 camera LED driver"
-	depends on GPIOLIB && LEDS_GPIO
-	help
-	  Many Bay Trail and Cherry Trail devices come with a camera attached
-	  to Intel's Image Signal Processor. Linux currently does not have a
-	  driver for these, so they do not work as a camera. Some of these
-	  camera's have a LED which is controlled through a GPIO.
-
-	  Some of these devices have a firmware issue where the LED gets turned
-	  on at boot. This driver will turn the LED off at boot and also allows
-	  controlling the LED (repurposing it) through the sysfs LED interface.
-
-	  Which GPIO is attached to the LED is usually not described in the
-	  ACPI tables, so this driver contains per-system info about the GPIO
-	  inside the driver, this means that this driver only works on systems
-	  the driver knows about.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_atomisp2_led.
-
-config INTEL_ATOMISP2_PM
-	tristate "Intel AtomISP2 dummy / power-management driver"
-	depends on PCI && IOSF_MBI && PM
-	depends on !INTEL_ATOMISP
-	help
-	  Power-management driver for Intel's Image Signal Processor found on
-	  Bay Trail and Cherry Trail devices. This dummy driver's sole purpose
-	  is to turn the ISP off (put it in D3) to save power and to allow
-	  entering of S0ix modes.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_atomisp2_pm.
-
 config INTEL_HID_EVENT
 	tristate "INTEL HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index f30cee767252..b5327b6f774a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,8 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
-obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 01c73d184461..443554133f20 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -19,6 +19,7 @@ if X86_PLATFORM_DRIVERS_INTEL
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
+source "drivers/platform/x86/intel/atomisp2/Kconfig"
 
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel BXT Whiskey Cove TMU Driver"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index ae2a3cec8d82..fd2d274f294f 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -7,6 +7,8 @@
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
+obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= atomisp2/
+obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= atomisp2/
 
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y 					:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel/atomisp2/Kconfig b/drivers/platform/x86/intel/atomisp2/Kconfig
new file mode 100644
index 000000000000..49305b8605fe
--- /dev/null
+++ b/drivers/platform/x86/intel/atomisp2/Kconfig
@@ -0,0 +1,35 @@
+
+config INTEL_ATOMISP2_LED
+	tristate "Intel AtomISP2 camera LED driver"
+	depends on GPIOLIB && LEDS_GPIO
+	help
+	  Many Bay Trail and Cherry Trail devices come with a camera attached
+	  to Intel's Image Signal Processor. Linux currently does not have a
+	  driver for these, so they do not work as a camera. Some of these
+	  camera's have a LED which is controlled through a GPIO.
+
+	  Some of these devices have a firmware issue where the LED gets turned
+	  on at boot. This driver will turn the LED off at boot and also allows
+	  controlling the LED (repurposing it) through the sysfs LED interface.
+
+	  Which GPIO is attached to the LED is usually not described in the
+	  ACPI tables, so this driver contains per-system info about the GPIO
+	  inside the driver, this means that this driver only works on systems
+	  the driver knows about.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_atomisp2_led.
+
+config INTEL_ATOMISP2_PM
+	tristate "Intel AtomISP2 dummy / power-management driver"
+	depends on PCI && IOSF_MBI && PM
+	depends on !INTEL_ATOMISP
+	help
+	  Power-management driver for Intel's Image Signal Processor found on
+	  Bay Trail and Cherry Trail devices. This dummy driver's sole purpose
+	  is to turn the ISP off (put it in D3) to save power and to allow
+	  entering of S0ix modes.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_atomisp2_pm.
+
diff --git a/drivers/platform/x86/intel/atomisp2/Makefile b/drivers/platform/x86/intel/atomisp2/Makefile
new file mode 100644
index 000000000000..6937ff24861e
--- /dev/null
+++ b/drivers/platform/x86/intel/atomisp2/Makefile
@@ -0,0 +1,5 @@
+
+intel_atomisp2_led-y 				:= led.o
+obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
+intel_atomisp2_pm-y					+= pm.o
+obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel/atomisp2/led.c
similarity index 100%
rename from drivers/platform/x86/intel_atomisp2_led.c
rename to drivers/platform/x86/intel/atomisp2/led.c
diff --git a/drivers/platform/x86/intel_atomisp2_pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
similarity index 100%
rename from drivers/platform/x86/intel_atomisp2_pm.c
rename to drivers/platform/x86/intel/atomisp2/pm.c
-- 
2.31.1

