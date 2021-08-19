Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0425A3F11B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhHSDcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236797AbhHSDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTNLdaoxX+iY5+/08rni2r7T1taKqPsRPWWtB6v/9TM=;
        b=KA64I2QW5RdGivlSgzS40r56L3pViCqxUuNLr1We0xOiUw6WNvjIZcjb/KcjhrfT7HBScq
        BMpEoRgJrFRL7RWBYV0Yi+bNzO/BmHjcTKDvj4t9rJq+6Q9W8S9ZSHGpdg29aDWJYKvcfN
        7Z8Z1YBTsqbigHhzc3xRkywEDLfmPw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-RODtqAJuNAyxz92WEigohg-1; Wed, 18 Aug 2021 23:31:55 -0400
X-MC-Unique: RODtqAJuNAyxz92WEigohg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 382E71008066;
        Thu, 19 Aug 2021 03:31:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24C2660657;
        Thu, 19 Aug 2021 03:31:49 +0000 (UTC)
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
Subject: [PATCH v3 15/20] platform/x86: intel-hid: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:56 +0800
Message-Id: <20210819033001.20136-16-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-hid to intel sub-directory to improve
readability. Also, add CFLAGS to tweak the including path
of dual_accel_detect.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                      | 13 -------------
 drivers/platform/x86/Makefile                     |  2 --
 drivers/platform/x86/intel/Kconfig                | 13 +++++++++++++
 drivers/platform/x86/intel/Makefile               |  2 ++
 drivers/platform/x86/{intel-hid.c => intel/hid.c} |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 196e70a8b264..70cd67703f8f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -667,19 +667,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_HID_EVENT
-	tristate "INTEL HID Event"
-	depends on ACPI
-	depends on INPUT
-	depends on I2C
-	select INPUT_SPARSEKMAP
-	help
-	  This driver provides support for the Intel HID Event hotkey interface.
-	  Some laptops require this driver for hotkey support.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_hid.
-
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
 	depends on GPIOLIB && ACPI && PM_SLEEP
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2a48171c11c1..62494618f890 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -69,11 +69,9 @@ obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
-
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 01db66ec1462..2241d47dbee7 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -21,6 +21,19 @@ source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
 
+config INTEL_HID_EVENT
+       tristate "INTEL HID Event"
+       depends on ACPI
+       depends on INPUT
+       depends on I2C
+       select INPUT_SPARSEKMAP
+       help
+         This driver provides support for the Intel HID Event hotkey interface.
+         Some laptops require this driver for hotkey support.
+
+         To compile this driver as a module, choose M here: the module will
+         be called intel_hid.
+
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel BXT Whiskey Cove TMU Driver"
 	depends on REGMAP
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 05a012118ea1..ade6dddd0306 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -9,6 +9,8 @@ obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_ATOMISP2_LED)       += atomisp2/
 obj-$(CONFIG_INTEL_ATOMISP2_PM)                += atomisp2/
+intel-hid-y                            := hid.o
+obj-$(CONFIG_INTEL_HID_EVENT)          += intel-hid.o
 
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel/hid.c
similarity index 99%
rename from drivers/platform/x86/intel-hid.c
rename to drivers/platform/x86/intel/hid.c
index 2e4e97a626a5..a33a5826e81a 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
-#include "dual_accel_detect.h"
+#include "../dual_accel_detect.h"
 
 /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
 #define TABLET_MODE_FLAG BIT(6)
-- 
2.31.1

