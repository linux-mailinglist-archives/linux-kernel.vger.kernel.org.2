Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BF3ED292
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbhHPKy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236423AbhHPKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+Qi+34OQ4oOerTa9fYnzfZpbz2HLLMYGXCa+MZv2AU=;
        b=PgtEVe5DbbR/qAtAn7PTV6v4HTHwciO37kMZTEc2gggQt4jEPUGI+maqbCGEo+fex6Vum5
        LKwuIFq2i7lJTm4vUpJeT0BNoS/+XH8HoXUrk2vSb5mvBCCKJUGjoIai4p7vAB5kGxnoff
        2MO2923Rn7odJoswpADYnCWUUYfdDVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-JHMY8TZwPH-hxiowmi3QyA-1; Mon, 16 Aug 2021 06:54:08 -0400
X-MC-Unique: JHMY8TZwPH-hxiowmi3QyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4606D801AEB;
        Mon, 16 Aug 2021 10:54:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A58A5FC23;
        Mon, 16 Aug 2021 10:54:00 +0000 (UTC)
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
Subject: [PATCH v2 11/20] platform/x86: intel_turbo_max_3: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:10 +0800
Message-Id: <20210816105119.704302-12-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_turbo_max_3 to intel sub-directory to improve readability
and rename it from intel_turbo_max_3.c to turbo_max_3.c

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                           | 10 ----------
 drivers/platform/x86/Makefile                          |  2 +-
 drivers/platform/x86/intel/Kconfig                     | 10 ++++++++++
 drivers/platform/x86/intel/Makefile                    |  4 ++--
 .../x86/{intel_turbo_max_3.c => intel/turbo_max_3.c}   |  0
 5 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/platform/x86/{intel_turbo_max_3.c => intel/turbo_max_3.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index a9eb1f6e184f..666103c7f0de 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1111,16 +1111,6 @@ config INTEL_IMR
 
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
index 0389fe12e7c0..fb39644db7f9 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -123,7 +123,7 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
-obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
+
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 83f7dc3e9506..8070804fe916 100644
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
index da8fbe87bf03..cff65fa2b1aa 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -33,5 +33,5 @@ intel-rst-y							:= rst.o
 obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 intel-smartconnect-y				:= smartconnect.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
-
-
+intel_turbo_max_3-y						:= turbo_max_3.o
+obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
similarity index 100%
rename from drivers/platform/x86/intel_turbo_max_3.c
rename to drivers/platform/x86/intel/turbo_max_3.c
-- 
2.31.1

