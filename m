Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D43ED28D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhHPKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236311AbhHPKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45FSMZY66a+NaN5uLJ6dvqEAZwM0dYmYPL4W0EaFBjk=;
        b=g4Yb+6/CVpLQ048bpnKNbtxfkEvaMm1pYBIkFzCEf/5359FHcdgqruP+Q7MvSswPJSMvaR
        TcblfOt30le/MrnC0pmyn20Ecpmqt3Jpk+YRP8YNKslX1nXaWUkVo986LIuKnMBHxdrPg4
        Vy+X2rwzv78LleNvhbDsuvhcaIDz/1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-yFU2Md6OPvWQzlURVrJCxQ-1; Mon, 16 Aug 2021 06:53:39 -0400
X-MC-Unique: yFU2Md6OPvWQzlURVrJCxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06DE51008060;
        Mon, 16 Aug 2021 10:53:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E51A5C23A;
        Mon, 16 Aug 2021 10:53:34 +0000 (UTC)
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
Subject: [PATCH v2 08/20] platform/x86: intel_ips: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:07 +0800
Message-Id: <20210816105119.704302-9-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 drivers/platform/x86/intel/Makefile               |  7 +++++++
 drivers/platform/x86/{intel_ips.c => intel/ips.c} |  0
 5 files changed, 18 insertions(+), 11 deletions(-)
 rename drivers/platform/x86/{intel_ips.c => intel/ips.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index fdc8b4c259ee..eca113f6dd0c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1109,16 +1109,6 @@ config INTEL_IMR
 
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
index bd9754dfa37d..fdbaaf9486df 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,7 +120,7 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
+
 obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index fb409f044e27..300fc8bbc907 100644
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
index 51ea5ee1f833..adb61cf3a387 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -25,3 +25,10 @@ obj-$(CONFIG_INTEL_SCU_WDT)			+= scu/
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= scu/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 
+# Intel uncore drivers
+CFLAGS_ips.o				:= -I./drivers/platform/x86
+intel_ips-y							:= ips.o
+obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
+
+
+
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel/ips.c
similarity index 100%
rename from drivers/platform/x86/intel_ips.c
rename to drivers/platform/x86/intel/ips.c
-- 
2.31.1

