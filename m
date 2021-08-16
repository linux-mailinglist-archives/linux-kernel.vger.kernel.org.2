Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1967F3ED29C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhHPKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236346AbhHPKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjEg73jM+U3AjsSdxssEfiMhYP5By0BSc2pVM9r+sCc=;
        b=WBxazjfkp4QAKTencAYuTQwgQZ4uFP/DJkZOQseobctC6OOMl+qIJHvFqPs3cqOcvXyEgi
        gqE02jD4N6LVFfuyy4sL7ZL+VQTFk/Mn8mYAgHhSoeqspgD7/RfYCQFLfem2EXDwv93rT/
        a5LE3PLmn9o8a/xvKrZkPpipJPBsOVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-PmrOPWY9PMWz3KPBQ9s0dQ-1; Mon, 16 Aug 2021 06:54:41 -0400
X-MC-Unique: PmrOPWY9PMWz3KPBQ9s0dQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C112287D54A;
        Mon, 16 Aug 2021 10:54:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84AB45FC23;
        Mon, 16 Aug 2021 10:54:36 +0000 (UTC)
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
Subject: [PATCH v2 16/20] platform/x86: intel_int0002_vgpio: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:15 +0800
Message-Id: <20210816105119.704302-17-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_int0002_vgpio to intel sub-directory to improve
readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                  | 19 -------------------
 drivers/platform/x86/Makefile                 |  1 -
 drivers/platform/x86/intel/Kconfig            | 19 +++++++++++++++++++
 drivers/platform/x86/intel/Makefile           |  2 ++
 .../int0002_vgpio.c}                          |  0
 5 files changed, 21 insertions(+), 20 deletions(-)
 rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 84865e1cf043..7274b586170d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -667,25 +667,6 @@ config THINKPAD_LMI
 
 source "drivers/platform/x86/intel/Kconfig"
 
-config INTEL_INT0002_VGPIO
-	tristate "Intel ACPI INT0002 Virtual GPIO driver"
-	depends on GPIOLIB && ACPI && PM_SLEEP
-	select GPIOLIB_IRQCHIP
-	help
-	  Some peripherals on Bay Trail and Cherry Trail platforms signal a
-	  Power Management Event (PME) to the Power Management Controller (PMC)
-	  to wakeup the system. When this happens software needs to explicitly
-	  clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
-	  IRQ storm on IRQ 9.
-
-	  This is modelled in ACPI through the INT0002 ACPI device, which is
-	  called a "Virtual GPIO controller" in ACPI because it defines the
-	  event handler to call when the PME triggers through _AEI and _L02
-	  methods as would be done for a real GPIO interrupt in ACPI.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel_int0002_vgpio.
-
 config INTEL_MENLOW
 	tristate "Thermal Management driver for Intel menlow platform"
 	depends on ACPI_THERMAL
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 734a6c266025..4c9a47936e65 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 # Intel
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
-obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 4ca7bec080e7..cf56a1c4474b 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -34,6 +34,25 @@ config INTEL_HID_EVENT
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_hid.
 
+config INTEL_INT0002_VGPIO
+	tristate "Intel ACPI INT0002 Virtual GPIO driver"
+	depends on GPIOLIB && ACPI && PM_SLEEP
+	select GPIOLIB_IRQCHIP
+	help
+	  Some peripherals on Bay Trail and Cherry Trail platforms signal a
+	  Power Management Event (PME) to the Power Management Controller (PMC)
+	  to wakeup the system. When this happens software needs to explicitly
+	  clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
+	  IRQ storm on IRQ 9.
+
+	  This is modelled in ACPI through the INT0002 ACPI device, which is
+	  called a "Virtual GPIO controller" in ACPI because it defines the
+	  event handler to call when the PME triggers through _AEI and _L02
+	  methods as would be done for a real GPIO interrupt in ACPI.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_int0002_vgpio.
+
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel BXT Whiskey Cove TMU Driver"
 	depends on REGMAP
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index e47e6ac4b5eb..23503798b533 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= atomisp2/
 CFLAGS_hid.o			:= -I./drivers/platform/x86
 intel-hid-y				:= hid.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
+intel_int0002_vgpio-y				:= int0002_vgpio.o
+obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y 					:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
similarity index 100%
rename from drivers/platform/x86/intel_int0002_vgpio.c
rename to drivers/platform/x86/intel/int0002_vgpio.c
-- 
2.31.1

