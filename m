Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE78D3F11AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhHSDcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236426AbhHSDcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzXbu3hkaez3+g115g8QJoUutgtOPpCs9Ww0EHPyONU=;
        b=DJBhV18QkCO/5OIEF6BVjPOcQQkDOQN4rfjFrYJxbrSNNYVtBoF1C60yGZ3fXKbxs853F5
        ukG0y9F7pRvVOqricS2zLhQN5lJ027/iPQ613Bu6bozVEPQsmUokE2PxsYryY1W7HrsKtw
        TlWS4a5OZnPZniZU/dByKI4QoFIDZ9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-ZumiqH2GO5Cy_PRWLsbTpA-1; Wed, 18 Aug 2021 23:31:28 -0400
X-MC-Unique: ZumiqH2GO5Cy_PRWLsbTpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE8D11008067;
        Thu, 19 Aug 2021 03:31:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC0660657;
        Thu, 19 Aug 2021 03:31:23 +0000 (UTC)
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
Subject: [PATCH v3 10/20] platform/x86: intel-smartconnect: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:51 +0800
Message-Id: <20210819033001.20136-11-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-smartconnect to intel sub-directory to improve readability
and rename it from intel-smartconnect.c to smartconnect.c

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                      | 14 --------------
 drivers/platform/x86/Makefile                     |  1 -
 drivers/platform/x86/intel/Kconfig                | 15 +++++++++++++++
 drivers/platform/x86/intel/Makefile               |  6 ++++--
 .../smartconnect.c}                               |  0
 5 files changed, 19 insertions(+), 17 deletions(-)
 rename drivers/platform/x86/{intel-smartconnect.c => intel/smartconnect.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 81e793a752bb..0edd59ffb6b6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1099,20 +1099,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-config INTEL_SMARTCONNECT
-        tristate "Intel Smart Connect disabling driver"
-	depends on ACPI
-	help
-	  Intel Smart Connect is a technology intended to permit devices to
-	  update state by resuming for a short period of time at regular
-	  intervals. If a user enables this functionality under Windows and
-	  then reboots into Linux, the system may remain configured to resume
-	  on suspend. In the absence of any userspace to support it, the system
-	  will then remain awake until something triggers another suspend.
-
-	  This driver checks to determine whether the device has Intel Smart
-	  Connect enabled, and if so disables it.
-
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
 config INTEL_TURBO_MAX_3
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c3631ebbdbb0..6082d4d1dad8 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -121,7 +121,6 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 # Intel uncore drivers
 
 
-obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 6e673c104330..481811ea4bf8 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -84,4 +84,19 @@ config INTEL_RST
 	  firmware will copy the memory contents back to RAM and resume the OS
 	  as usual.
 
+config INTEL_SMARTCONNECT
+        tristate "Intel Smart Connect disabling driver"
+	depends on ACPI
+	help
+	  Intel Smart Connect is a technology intended to permit devices to
+	  update state by resuming for a short period of time at regular
+	  intervals. If a user enables this functionality under Windows and
+	  then reboots into Linux, the system may remain configured to resume
+	  on suspend. In the absence of any userspace to support it, the system
+	  will then remain awake until something triggers another suspend.
+
+	  This driver checks to determine whether the device has Intel Smart
+	  Connect enabled, and if so disables it.
+
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index e04efb799b4a..53d55a9b17b9 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -28,7 +28,9 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 # Intel uncore drivers
 intel_ips-y				:= ips.o
 obj-$(CONFIG_INTEL_IPS)			+= intel_ips.o
-intel-rst-y							:= rst.o
-obj-$(CONFIG_INTEL_RST)				+= intel-rst.o
+intel-rst-y				:= rst.o
+obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
+intel-smartconnect-y				:= smartconnect.o
+obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 
 
diff --git a/drivers/platform/x86/intel-smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
similarity index 100%
rename from drivers/platform/x86/intel-smartconnect.c
rename to drivers/platform/x86/intel/smartconnect.c
-- 
2.31.1

