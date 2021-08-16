Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087243ED29A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhHPKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236243AbhHPKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJsyXOdlJYM2//fxWzSx0kKAbedvDwh5E29u/1ymh/M=;
        b=fxky3+0ozPgxKMUifgtfBMDqm3lEp67nmAWj1KzlHsGw+Qyh9tid/I+HGbqbiczZmUfmZW
        ir3QsbkbtavcujMHMDUHPdn04j9hSjamhZ0IFU0xRhrTIxSL9Mf3c/ZW4ZfSNsgphYjeJc
        /LVsu6NvmDOUVkj/KvZWlhBI+dSKPS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-FoVhOtuPONm3-7VkgzKR7g-1; Mon, 16 Aug 2021 06:54:35 -0400
X-MC-Unique: FoVhOtuPONm3-7VkgzKR7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97946192D789;
        Mon, 16 Aug 2021 10:54:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59C185FC25;
        Mon, 16 Aug 2021 10:54:30 +0000 (UTC)
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
Subject: [PATCH v2 15/20] platform/x86: intel-hid: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:14 +0800
Message-Id: <20210816105119.704302-16-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-hid to intel sub-directory to improve
readability. Also, add CFLAGS to tweak the including path
of dual_accel_detect.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                      | 13 -------------
 drivers/platform/x86/Makefile                     |  1 -
 drivers/platform/x86/intel/Kconfig                | 13 +++++++++++++
 drivers/platform/x86/intel/Makefile               |  5 ++++-
 drivers/platform/x86/{intel-hid.c => intel/hid.c} |  0
 5 files changed, 17 insertions(+), 15 deletions(-)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ac4ec4e2534a..84865e1cf043 100644
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
index b5327b6f774a..734a6c266025 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 443554133f20..4ca7bec080e7 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -21,6 +21,19 @@ source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
 
+config INTEL_HID_EVENT
+	tristate "INTEL HID Event"
+	depends on ACPI
+	depends on INPUT
+	depends on I2C
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for the Intel HID Event hotkey interface.
+	  Some laptops require this driver for hotkey support.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_hid.
+
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel BXT Whiskey Cove TMU Driver"
 	depends on REGMAP
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index fd2d274f294f..e47e6ac4b5eb 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -9,6 +9,9 @@ obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= atomisp2/
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= atomisp2/
+CFLAGS_hid.o			:= -I./drivers/platform/x86
+intel-hid-y				:= hid.o
+obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y 					:= bxtwc_tmu.o
@@ -39,4 +42,4 @@ intel_turbo_max_3-y						:= turbo_max_3.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 intel-uncore-frequency-y					:= uncore-frequency.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
-obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= speed_select_if/
\ No newline at end of file
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= speed_select_if/
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel/hid.c
similarity index 100%
rename from drivers/platform/x86/intel-hid.c
rename to drivers/platform/x86/intel/hid.c
-- 
2.31.1

