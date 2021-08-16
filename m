Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E383A3ED28F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhHPKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236278AbhHPKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwXdfMbTU7iCEMFmM5n0iQzUa/Khps05w/TJ9eU1f9k=;
        b=bw2lAMwNmuy4ZbD6WefSLMb64t7qGHqmopwrK0IY3IAEZGPNfUx90iM1zbIyxlMLsaw9ch
        IOwmiJEqCVuln+WeDVVsyzYMtCyUZE4z3kcREybvpWCElBvD1rpv5FqMriMUUtGdtTGFgD
        65xW6PDMBYu8swUpEKfpP99cX4jJYek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-kB8x77z8PnmRi_AYQvkZDQ-1; Mon, 16 Aug 2021 06:53:48 -0400
X-MC-Unique: kB8x77z8PnmRi_AYQvkZDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C33E802CB3;
        Mon, 16 Aug 2021 10:53:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D29395C23A;
        Mon, 16 Aug 2021 10:53:41 +0000 (UTC)
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
Subject: [PATCH v2 09/20] platform/x86: intel-rst: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:08 +0800
Message-Id: <20210816105119.704302-10-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-rst to intel sub-directory to improve readability
and rename it from intel-rst.c to ips.c

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                      | 12 ------------
 drivers/platform/x86/Makefile                     |  2 +-
 drivers/platform/x86/intel/Kconfig                | 12 ++++++++++++
 drivers/platform/x86/intel/Makefile               |  3 ++-
 drivers/platform/x86/{intel-rst.c => intel/rst.c} |  0
 5 files changed, 15 insertions(+), 14 deletions(-)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index eca113f6dd0c..c3682ea48af0 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1109,18 +1109,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-config INTEL_RST
-        tristate "Intel Rapid Start Technology Driver"
-	depends on ACPI
-	help
-	  This driver provides support for modifying parameters on systems
-	  equipped with Intel's Rapid Start Technology. When put in an ACPI
-	  sleep state, these devices will wake after either a configured
-	  timeout or when the system battery reaches a critical state,
-	  automatically copying memory contents to disk. On resume, the
-	  firmware will copy the memory contents back to RAM and resume the OS
-	  as usual.
-
 config INTEL_SMARTCONNECT
         tristate "Intel Smart Connect disabling driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index fdbaaf9486df..16d9f142ca7a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -121,7 +121,7 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 
-obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
+
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 300fc8bbc907..b0b2566be981 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -72,4 +72,16 @@ config INTEL_IPS
 	  functionality.  If in doubt, say Y here; it will only load on
 	  supported platforms.
 
+config INTEL_RST
+        tristate "Intel Rapid Start Technology Driver"
+	depends on ACPI
+	help
+	  This driver provides support for modifying parameters on systems
+	  equipped with Intel's Rapid Start Technology. When put in an ACPI
+	  sleep state, these devices will wake after either a configured
+	  timeout or when the system battery reaches a critical state,
+	  automatically copying memory contents to disk. On resume, the
+	  firmware will copy the memory contents back to RAM and resume the OS
+	  as usual.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index adb61cf3a387..cc72262d9283 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 CFLAGS_ips.o				:= -I./drivers/platform/x86
 intel_ips-y							:= ips.o
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
-
+intel-rst-y							:= rst.o
+obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
 
 
diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel/rst.c
similarity index 100%
rename from drivers/platform/x86/intel-rst.c
rename to drivers/platform/x86/intel/rst.c
-- 
2.31.1

