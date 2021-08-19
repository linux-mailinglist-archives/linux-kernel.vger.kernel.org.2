Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04123F11A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhHSDb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236313AbhHSDb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4k5YGefbmjweZrc0B2RbFD5epHAltqQeW3ClNlWue0w=;
        b=BOuzxw+/ScUzSHJfo08+gaogwBemYTIglyQ8VjNju1RG21CSEJ+4GVPSQq8MVQr2rXmPQX
        2DTeKytEhUcBxjv6r6pxC/3s/0U2YsNvdPeBtr6/CYix8TEEhzwyumtzMkFexLEDfOfgwZ
        OrX3qs/ucDq7mvnIeFQQT4HPykwkHq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-to-PTmiLMoawW5HTLJP0Fg-1; Wed, 18 Aug 2021 23:30:49 -0400
X-MC-Unique: to-PTmiLMoawW5HTLJP0Fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8E24C73A1;
        Thu, 19 Aug 2021 03:30:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A58CA189C4;
        Thu, 19 Aug 2021 03:30:44 +0000 (UTC)
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
Subject: [PATCH v3 03/20] platform/x86: intel_mrfld_pwrbtn: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:44 +0800
Message-Id: <20210819033001.20136-4-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_mrfld_pwrbtn to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                          | 11 -----------
 drivers/platform/x86/Makefile                         |  1 -
 drivers/platform/x86/intel/Kconfig                    | 11 +++++++++++
 drivers/platform/x86/intel/Makefile                   |  2 ++
 .../{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c}    |  0
 5 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7bccbfc417f7..cb8cb75d3a31 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1158,17 +1158,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_MRFLD_PWRBTN
-	tristate "Intel Merrifield Basin Cove power button driver"
-	depends on INTEL_SOC_PMIC_MRFLD
-	depends on INPUT
-	help
-	  This option adds a power button driver for Basin Cove PMIC
-	  on Intel Merrifield devices.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel_mrfld_pwrbtn.
-
 config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 21fd8cb0a1b7..6e6436b6b441 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
 
-obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index ea1f85e49bab..2e76d479b0f3 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -41,4 +41,15 @@ config INTEL_CHTDC_TI_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_chtdc_ti_pwrbtn.
 
+config INTEL_MRFLD_PWRBTN
+	tristate "Intel Merrifield Basin Cove power button driver"
+	depends on INTEL_SOC_PMIC_MRFLD
+	depends on INPUT
+	help
+	  This option adds a power button driver for Basin Cove PMIC
+	  on Intel Merrifield devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_mrfld_pwrbtn.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index cc826a4dd69c..cfdaa01e5610 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -13,3 +13,5 @@ intel_bxtwc_tmu-y			:= bxtwc_tmu.o
 obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 intel_chtdc_ti_pwrbtn-y			:= chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
+intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
+obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
diff --git a/drivers/platform/x86/intel_mrfld_pwrbtn.c b/drivers/platform/x86/intel/mrfld_pwrbtn.c
similarity index 100%
rename from drivers/platform/x86/intel_mrfld_pwrbtn.c
rename to drivers/platform/x86/intel/mrfld_pwrbtn.c
-- 
2.31.1

