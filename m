Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB03F11A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhHSDb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236555AbhHSDbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1LWERUcp4tnN95cn3xo4eniYoMz9NhUHXw3Z8XL3DI=;
        b=GmSiX4Rsqs6JOZMy/MF5erY+PUXyAp0mgCQ5d+2/9bYVzWHeFrSoDX/lJVa4FlFdqtN+Sy
        EMVtqX6+bYYLOkkNrCnQ44BG61RKASC+jnVWaGeJH7VudaXJGLpo7M7g8NGOh0DRqSrtIf
        MDkPsTNyF2WySzkU/iAT2o3CbjieK1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-MTpsY26ePUCJQZ4I5_20hQ-1; Wed, 18 Aug 2021 23:31:18 -0400
X-MC-Unique: MTpsY26ePUCJQZ4I5_20hQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FACAC73A4;
        Thu, 19 Aug 2021 03:31:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E23960657;
        Thu, 19 Aug 2021 03:31:13 +0000 (UTC)
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
Subject: [PATCH v3 08/20] platform/x86: intel_ips: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:49 +0800
Message-Id: <20210819033001.20136-9-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_ips to intel sub-directory to improve readability
and rename it from intel_ips.c to ips.c

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                      | 10 ----------
 drivers/platform/x86/Makefile                     |  2 +-
 drivers/platform/x86/intel/Kconfig                | 10 ++++++++++
 drivers/platform/x86/intel/Makefile               |  6 ++++++
 drivers/platform/x86/{intel_ips.c => intel/ips.c} |  2 +-
 5 files changed, 18 insertions(+), 12 deletions(-)
 rename drivers/platform/x86/{intel_ips.c => intel/ips.c} (99%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 4750ce36c4d5..5201a0e95b58 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1099,16 +1099,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-config INTEL_IPS
-	tristate "Intel Intelligent Power Sharing"
-	depends on ACPI && PCI
-	help
-	  Intel Calpella platforms support dynamic power sharing between the
-	  CPU and GPU, maximizing performance in a given TDP.  This driver,
-	  along with the CPU frequency and i915 drivers, provides that
-	  functionality.  If in doubt, say Y here; it will only load on
-	  supported platforms.
-
 config INTEL_RST
         tristate "Intel Rapid Start Technology Driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6210833289a1..9c5b7bf63187 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -119,7 +119,7 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
+
 obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index b1b89cd14efc..388e669c9eb9 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -62,4 +62,14 @@ source "drivers/platform/x86/intel/pmc/Kconfig"
 source "drivers/platform/x86/intel/scu/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 
+config INTEL_IPS
+	tristate "Intel Intelligent Power Sharing"
+	depends on ACPI && PCI
+	help
+	  Intel Calpella platforms support dynamic power sharing between the
+	  CPU and GPU, maximizing performance in a given TDP.  This driver,
+	  along with the CPU frequency and i915 drivers, provides that
+	  functionality.  If in doubt, say Y here; it will only load on
+	  supported platforms.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 834c9ff2e1f6..59cb6be2703e 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -25,3 +25,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)		+= scu/
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
+# Intel uncore drivers
+intel_ips-y				:= ips.o
+obj-$(CONFIG_INTEL_IPS)			+= intel_ips.o
+
+
+
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel/ips.c
similarity index 99%
rename from drivers/platform/x86/intel_ips.c
rename to drivers/platform/x86/intel/ips.c
index 4dfdbfca6841..15254cd9042f 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel/ips.c
@@ -62,7 +62,7 @@
 #include <drm/i915_drm.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
-#include "intel_ips.h"
+#include "../intel_ips.h"
 
 #include <linux/io-64-nonatomic-lo-hi.h>
 
-- 
2.31.1

