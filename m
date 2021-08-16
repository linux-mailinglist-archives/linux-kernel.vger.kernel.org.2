Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938633ED279
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhHPKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236033AbhHPKxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1fSK8te6DjAtG5QdRGSUJsV8VDWEEurXw1xIyCV/bc=;
        b=Axi/yQijYK9naXK5Zh2cj3gmRBjA4uHQywR+UxIi8PMpa4bSmKZB3XTt79PHNW2q2vrLbW
        7ELxiUxfGLEaeYLhsO0IYenIO3GCNBkRm1ozBDY4GE5oQ7EMEQD+Z+qFO23iw1RbTBumgM
        EJRNkOKLF7uZLwqLkzRsmBnNXmRVfrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-7lKq8Us9P_agGjzdQ0xdYw-1; Mon, 16 Aug 2021 06:52:46 -0400
X-MC-Unique: 7lKq8Us9P_agGjzdQ0xdYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8351083E82;
        Mon, 16 Aug 2021 10:52:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DB9D5FC23;
        Mon, 16 Aug 2021 10:52:39 +0000 (UTC)
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
Subject: [PATCH v2 02/20] platform/x86: intel_chtdc_ti_pwrbtn: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:01 +0800
Message-Id: <20210816105119.704302-3-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_chtdc_ti_pwrbtn to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                          | 11 -----------
 drivers/platform/x86/Makefile                         |  2 +-
 drivers/platform/x86/intel/Kconfig                    | 11 +++++++++++
 drivers/platform/x86/intel/Makefile                   |  2 ++
 .../chtdc_ti_pwrbtn.c}                                |  0
 5 files changed, 14 insertions(+), 12 deletions(-)
 rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 15d66892ea92..0b49cb62514a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1168,17 +1168,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_CHTDC_TI_PWRBTN
-	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
-	depends on INTEL_SOC_PMIC_CHTDC_TI
-	depends on INPUT
-	help
-	  This option adds a power button driver driver for Dollar Cove TI
-	  PMIC on Intel Cherry Trail devices.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_chtdc_ti_pwrbtn.
-
 config INTEL_MRFLD_PWRBTN
 	tristate "Intel Merrifield Basin Cove power button driver"
 	depends on INTEL_SOC_PMIC_MRFLD
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2477d46937c2..683e3abaa8e6 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,7 +128,7 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
+
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index b274ff4192b2..0a3ca61db14f 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -30,4 +30,15 @@ config INTEL_BXTWC_PMIC_TMU
 	  This driver enables the alarm wakeup functionality in the TMU unit
 	  of Whiskey Cove PMIC.
 
+config INTEL_CHTDC_TI_PWRBTN
+	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
+	depends on INTEL_SOC_PMIC_CHTDC_TI
+	depends on INPUT
+	help
+	  This option adds a power button driver driver for Dollar Cove TI
+	  PMIC on Intel Cherry Trail devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_chtdc_ti_pwrbtn.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 92ab6fa7438f..e0bbb855e08b 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 # Intel PMIC / PMC / P-Unit devices
 intel_bxtwc_tmu-y 					:= bxtwc_tmu.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
+intel_chtdc_ti_pwrbtn-y				:= chtdc_ti_pwrbtn.o
+obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
diff --git a/drivers/platform/x86/intel_chtdc_ti_pwrbtn.c b/drivers/platform/x86/intel/chtdc_ti_pwrbtn.c
similarity index 100%
rename from drivers/platform/x86/intel_chtdc_ti_pwrbtn.c
rename to drivers/platform/x86/intel/chtdc_ti_pwrbtn.c
-- 
2.31.1

