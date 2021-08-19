Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE13F11BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhHSDc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237010AbhHSDcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NK34S7ohejHSsYRUoxQlrWyqLvCvQn9c8SCE8RIYOX8=;
        b=Hpb3qBQCMJQVWQmv04vLoBpplpdLsOvNJ5fYAZtbutN4stb0uJ6goX6USOZYpNngwcegmq
        nuvZLT0uVKFMekL6UjZRxt9lNxqkG0jksiUA+8A/a7Re0XkBkK/QaiymHvnwZkc5phh0ZP
        P9wF0lSWdUF9HeOwNhymoi8Drrl5hjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-JvjqaducN4KAaDd0oZSvXw-1; Wed, 18 Aug 2021 23:32:09 -0400
X-MC-Unique: JvjqaducN4KAaDd0oZSvXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8461E190B2A6;
        Thu, 19 Aug 2021 03:32:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 500FA19C87;
        Thu, 19 Aug 2021 03:32:04 +0000 (UTC)
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
Subject: [PATCH v3 18/20] platform/x86: intel-vbtn: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:59 +0800
Message-Id: <20210819033001.20136-19-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-vbtn to intel sub-directory to improve
readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                        | 13 -------------
 drivers/platform/x86/Makefile                       |  3 +--
 drivers/platform/x86/intel/Kconfig                  | 13 +++++++++++++
 drivers/platform/x86/intel/Makefile                 |  2 ++
 drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)
 rename drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} (99%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6ed05e5faac1..b8ce4e6d90dd 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -667,19 +667,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_VBTN
-	tristate "INTEL VIRTUAL BUTTON"
-	depends on ACPI
-	depends on INPUT
-	depends on I2C
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
index afeea9ce34b8..d8b193e910bd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -69,11 +69,10 @@ obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
+
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
-
 # MSI
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 5ca3c36ac187..3a13f7a6da4d 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -53,6 +53,19 @@ config INTEL_INT0002_VGPIO
          To compile this driver as a module, choose M here: the module will
          be called intel_int0002_vgpio.
 
+config INTEL_VBTN
+       tristate "INTEL VIRTUAL BUTTON"
+       depends on ACPI
+       depends on INPUT
+       depends on I2C
+       select INPUT_SPARSEKMAP
+       help
+         This driver provides support for the Intel Virtual Button interface.
+         Some laptops require this driver for power button support.
+
+         To compile this driver as a module, choose M here: the module will
+         be called intel_vbtn.
+
 config INTEL_OAKTRAIL
         tristate "Intel Oaktrail Platform Extras"
         depends on ACPI
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index da238e2e352d..4211c683315f 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -15,6 +15,8 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
+intel-vbtn-y				:= vbtn.o
+obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y			:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel/vbtn.c
similarity index 99%
rename from drivers/platform/x86/intel-vbtn.c
rename to drivers/platform/x86/intel/vbtn.c
index 309166431063..15f013af9e62 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
-#include "dual_accel_detect.h"
+#include "../dual_accel_detect.h"
 
 /* Returned when NOT in tablet mode on some HP Stream x360 11 models */
 #define VGBS_TABLET_MODE_FLAG_ALT	0x10
-- 
2.31.1

