Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852BB3F11B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhHSDc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236651AbhHSDcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2+un5mrDb3OD19QS1eoMM283pqIJkjV1vR91M6Ol/g=;
        b=b1dhH+dvMC+sWWTk69w7NagRBt+hTiQ5hd7ykyeXS5QzuoWktCK+AjXJxkCeZOCgDCFuIL
        dgStcUPhL7i19IcgdLjjexLrT/Hgf/w7OY1JYkh1gZscPYTpHH/m6jcMowzXA6dJBWQ90o
        hiVW7QFIudigZKbPcwZgHFoix/NA45A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-k_LFN527Pkm1YbrHvxcggg-1; Wed, 18 Aug 2021 23:31:41 -0400
X-MC-Unique: k_LFN527Pkm1YbrHvxcggg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A23F802928;
        Thu, 19 Aug 2021 03:31:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1658760657;
        Thu, 19 Aug 2021 03:31:35 +0000 (UTC)
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
Subject: [PATCH v3 12/20] platform/x86: intel-uncore-frequency: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:53 +0800
Message-Id: <20210819033001.20136-13-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-uncore-frequency to intel sub-directory to improve
readability and rename it from intel-uncore-frequency.c to uncore-frequency.c

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                         | 10 ----------
 drivers/platform/x86/Makefile                        |  5 -----
 drivers/platform/x86/intel/Kconfig                   | 12 +++++++++++-
 drivers/platform/x86/intel/Makefile                  |  2 ++
 .../uncore-frequency.c}                              |  0
 5 files changed, 13 insertions(+), 16 deletions(-)
 rename drivers/platform/x86/{intel-uncore-frequency.c => intel/uncore-frequency.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b34bfa5c5748..9d57a2860c5a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1101,16 +1101,6 @@ config INTEL_IMR
 
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
-config INTEL_UNCORE_FREQ_CONTROL
-	tristate "Intel Uncore frequency control driver"
-	depends on X86_64
-	help
-	  This driver allows control of uncore frequency limits on
-	  supported server platforms.
-	  Uncore frequency controls RING/LLC (last-level cache) clocks.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-uncore-frequency.
 
 endif # X86_PLATFORM_DEVICES
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index a57fbf26646a..80e75115a7bb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -119,11 +119,6 @@ obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
-
-
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 
-obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
-
-
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 2943619d9018..2bec3b2c3af3 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -98,7 +98,6 @@ config INTEL_SMARTCONNECT
 	  This driver checks to determine whether the device has Intel Smart
 	  Connect enabled, and if so disables it.
 
-
 config INTEL_TURBO_MAX_3
 	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
 	depends on X86_64 && SCHED_MC_PRIO
@@ -109,4 +108,15 @@ config INTEL_TURBO_MAX_3
 	  This driver is only required when the system is not using Hardware
 	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
 
+config INTEL_UNCORE_FREQ_CONTROL
+	tristate "Intel Uncore frequency control driver"
+	depends on X86_64
+	help
+	  This driver allows control of uncore frequency limits on
+	  supported server platforms.
+	  Uncore frequency controls RING/LLC (last-level cache) clocks.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-uncore-frequency.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 58ccb1f8cbd0..73d7c624fda8 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -34,3 +34,5 @@ intel-smartconnect-y				:= smartconnect.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 intel_turbo_max_3-y				:= turbo_max_3.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
+intel-uncore-frequency-y			:= uncore-frequency.o
+obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel-uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency.c
similarity index 100%
rename from drivers/platform/x86/intel-uncore-frequency.c
rename to drivers/platform/x86/intel/uncore-frequency.c
-- 
2.31.1

