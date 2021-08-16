Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819613ED2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhHPK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236633AbhHPKzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFflC0zLzMPAB/2U5K7UvJmcJ6dorvVEBrSXm7nwkDQ=;
        b=ZLhIDxj2YuV4tFRUanQVARhN+ZdYRRDEAElkKf1oVAU6rG1WjPDuMmBIRqDJlYePuYPk6j
        RzKLluiuNOytlLVC73rhFLmf2uJCeaBmrNPTS268UPOymKYT06Y9Z/Nn1c74JaO40tMXmY
        uvCWwkwrpdhHRQbUBBYSMbFKudv7xfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-daG6amDgNU-vHeURY_SJQg-1; Mon, 16 Aug 2021 06:55:11 -0400
X-MC-Unique: daG6amDgNU-vHeURY_SJQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0401CEC1A6;
        Mon, 16 Aug 2021 10:55:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C42B95FC23;
        Mon, 16 Aug 2021 10:55:02 +0000 (UTC)
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
Subject: [PATCH v2 20/20] platform/x86: intel-wmi-thunderbolt: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:19 +0800
Message-Id: <20210816105119.704302-21-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel-wmi-thunderbolt to intel sub-directory to improve
readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                         | 12 ------------
 drivers/platform/x86/Makefile                        |  2 --
 drivers/platform/x86/intel/Makefile                  |  1 +
 drivers/platform/x86/intel/wmi/Kconfig               | 12 ++++++++++++
 drivers/platform/x86/intel/wmi/Makefile              |  2 ++
 .../wmi/thunderbolt.c}                               |  0
 6 files changed, 15 insertions(+), 14 deletions(-)
 rename drivers/platform/x86/{intel-wmi-thunderbolt.c => intel/wmi/thunderbolt.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index a5b0a654e028..be2c91b2c3a7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -77,18 +77,6 @@ config UV_SYSFS
 	  To compile this driver as a module, choose M here: the module will
 	  be called uv_sysfs.
 
-config INTEL_WMI_THUNDERBOLT
-	tristate "Intel WMI thunderbolt force power driver"
-	depends on ACPI_WMI
-	help
-	  Say Y here if you want to be able to use the WMI interface on select
-	  systems to force the power control of Intel Thunderbolt controllers.
-	  This is useful for updating the firmware when devices are not plugged
-	  into the controller.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called intel-wmi-thunderbolt.
-
 config MXM_WMI
        tristate "WMI support for MXM Laptop Graphics"
        depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 60015a4c6b6c..f8500a0439b3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -10,8 +10,6 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
-
-obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 794aa821611b..6ed28f14a4cf 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= speed_select_if/
 
 #WMI drivers
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= wmi/
+obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= wmi/
diff --git a/drivers/platform/x86/intel/wmi/Kconfig b/drivers/platform/x86/intel/wmi/Kconfig
index fc70728e0f1f..0d65fc90f5b1 100644
--- a/drivers/platform/x86/intel/wmi/Kconfig
+++ b/drivers/platform/x86/intel/wmi/Kconfig
@@ -12,3 +12,15 @@ config INTEL_WMI_SBL_FW_UPDATE
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel-wmi-sbl-fw-update.
+
+config INTEL_WMI_THUNDERBOLT
+	tristate "Intel WMI thunderbolt force power driver"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface on select
+	  systems to force the power control of Intel Thunderbolt controllers.
+	  This is useful for updating the firmware when devices are not plugged
+	  into the controller.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-thunderbolt.
diff --git a/drivers/platform/x86/intel/wmi/Makefile b/drivers/platform/x86/intel/wmi/Makefile
index bf1f118b6839..c2d56d25dea0 100644
--- a/drivers/platform/x86/intel/wmi/Makefile
+++ b/drivers/platform/x86/intel/wmi/Makefile
@@ -5,3 +5,5 @@
 
 intel-wmi-sbl-fw-update-y				:= sbl-fw-update.o
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
+intel-wmi-thunderbolt-y					:= thunderbolt.o
+obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel/wmi/thunderbolt.c
similarity index 100%
rename from drivers/platform/x86/intel-wmi-thunderbolt.c
rename to drivers/platform/x86/intel/wmi/thunderbolt.c
-- 
2.31.1

