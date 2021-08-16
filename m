Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C13ED29E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhHPKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236407AbhHPKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqAn7gvb0cQPTv8K840FtP8+cfzZB+z3+8LwrgK9oxg=;
        b=Q0Il+5WNEgUDEBHvO/dUkKbjC2+5MWXVMghFXc3Wb+R/EVDydkmGXc19oy22tUZf4lFvGD
        w6nXVM24uHHUac5CdxXLZfztNJ0et+1TclgD6ZhvqimLhS8VfgC+BwNgEfYfunthGJ9K/Y
        AEyB2LgpMuAeiZvLzRJSaG6oB2Gb+os=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-JkV31icWNCGO3SNikE2vaA-1; Mon, 16 Aug 2021 06:54:47 -0400
X-MC-Unique: JkV31icWNCGO3SNikE2vaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84B68EC1A2;
        Mon, 16 Aug 2021 10:54:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 389F85FC25;
        Mon, 16 Aug 2021 10:54:42 +0000 (UTC)
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
Subject: [PATCH v2 17/20] platform/x86: intel_oaktrail.c: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:16 +0800
Message-Id: <20210816105119.704302-18-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_oaktrail.c to intel sub-directory to improve
readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                           | 10 ----------
 drivers/platform/x86/Makefile                          |  1 -
 drivers/platform/x86/intel/Kconfig                     | 10 ++++++++++
 drivers/platform/x86/intel/Makefile                    |  2 ++
 .../x86/{intel_oaktrail.c => intel/oaktrail.c}         |  0
 5 files changed, 12 insertions(+), 11 deletions(-)
 rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7274b586170d..3d1cb7f03309 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -677,16 +677,6 @@ config INTEL_MENLOW
 
 	  If unsure, say N.
 
-config INTEL_OAKTRAIL
-	tristate "Intel Oaktrail Platform Extras"
-	depends on ACPI
-	depends on ACPI_VIDEO || ACPI_VIDEO = n
-	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
-	help
-	  Intel Oaktrail platform need this driver to provide interfaces to
-	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
-	  here; it will only load on supported platforms.
-
 config INTEL_VBTN
 	tristate "INTEL VIRTUAL BUTTON"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4c9a47936e65..63e78ed69fb2 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -72,7 +72,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
 
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
-obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # MSI
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index cf56a1c4474b..6df6e43d1061 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -53,6 +53,16 @@ config INTEL_INT0002_VGPIO
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_int0002_vgpio.
 
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
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel BXT Whiskey Cove TMU Driver"
 	depends on REGMAP
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 23503798b533..291219f63b04 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -14,6 +14,8 @@ intel-hid-y				:= hid.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 intel_int0002_vgpio-y				:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
+intel_oaktrail-y					:= oaktrail.o
+obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y 					:= bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel/oaktrail.c
similarity index 100%
rename from drivers/platform/x86/intel_oaktrail.c
rename to drivers/platform/x86/intel/oaktrail.c
-- 
2.31.1

