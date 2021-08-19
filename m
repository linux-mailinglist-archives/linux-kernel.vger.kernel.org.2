Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF53F11AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhHSDcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236576AbhHSDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZPbBOMsNpduSAknYI+koMMDJvEX5RZZ82ISzhfV7+A=;
        b=MIBwNoqoPpnDgQENdSV+UCIjYbJkxEjp3SpcER+5uWh3NLIBmqXPn/Qk2lqKKKi4KpQBM6
        65Z6Sr8XUiqzV6AijF1KAhJJMxdxzbSqfh4XWqvbs0d+M2EhXG+jNEWfbUUoeBCKUActrk
        EANkGY2FHAMx7kmBmQhkU48qgWdiU64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-qUh8Hru9M--ltqq49dU-TA-1; Wed, 18 Aug 2021 23:31:33 -0400
X-MC-Unique: qUh8Hru9M--ltqq49dU-TA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB1BB802929;
        Thu, 19 Aug 2021 03:31:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAFB179B3;
        Thu, 19 Aug 2021 03:31:28 +0000 (UTC)
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
Subject: [PATCH v3 11/20] platform/x86: intel_turbo_max_3: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:52 +0800
Message-Id: <20210819033001.20136-12-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_turbo_max_3 to intel sub-directory to improve readability
and rename it from intel_turbo_max_3.c to turbo_max_3.c

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/Kconfig                           | 10 ----------
 drivers/platform/x86/Makefile                          |  2 +-
 drivers/platform/x86/intel/Kconfig                     | 10 ++++++++++
 drivers/platform/x86/intel/Makefile                    |  4 ++--
 .../x86/{intel_turbo_max_3.c => intel/turbo_max_3.c}   |  0
 5 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/platform/x86/{intel_turbo_max_3.c => intel/turbo_max_3.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0edd59ffb6b6..b34bfa5c5748 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1101,16 +1101,6 @@ config INTEL_IMR
 
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
-config INTEL_TURBO_MAX_3
-	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
-	depends on X86_64 && SCHED_MC_PRIO
-	help
-	  This driver reads maximum performance ratio of each CPU and set up
-	  the scheduler priority metrics. In this way scheduler can prefer
-	  CPU with higher performance to schedule tasks.
-	  This driver is only required when the system is not using Hardware
-	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
-
 config INTEL_UNCORE_FREQ_CONTROL
 	tristate "Intel Uncore frequency control driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6082d4d1dad8..a57fbf26646a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -122,7 +122,7 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
+
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 481811ea4bf8..2943619d9018 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -99,4 +99,14 @@ config INTEL_SMARTCONNECT
 	  Connect enabled, and if so disables it.
 
 
+config INTEL_TURBO_MAX_3
+	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
+	depends on X86_64 && SCHED_MC_PRIO
+	help
+	  This driver reads maximum performance ratio of each CPU and set up
+	  the scheduler priority metrics. In this way scheduler can prefer
+	  CPU with higher performance to schedule tasks.
+	  This driver is only required when the system is not using Hardware
+	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 53d55a9b17b9..58ccb1f8cbd0 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -32,5 +32,5 @@ intel-rst-y				:= rst.o
 obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
 intel-smartconnect-y				:= smartconnect.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
-
-
+intel_turbo_max_3-y				:= turbo_max_3.o
+obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
similarity index 100%
rename from drivers/platform/x86/intel_turbo_max_3.c
rename to drivers/platform/x86/intel/turbo_max_3.c
-- 
2.31.1

