Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71663ED277
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbhHPKxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235784AbhHPKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z44Anr20YgU89oDOMqQx3+MrkexN78PZip+zNikWlWI=;
        b=FjSHP5qbqPVB5XXPg2Vr+Wp1ItSzEaAdtibylmEbz42Pl6+r5VoK2U2D6j/zbFIEpp2Cq8
        7CuaOZ1JEKEJX3OZ+wgfgTfph9hUB2arfxB9BuKbMSksuMnd2i2B3fv7Ay69fkiI73aREz
        F1LjuYs2fbbKm2eihxKDramdN9gwRJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-rTbwzBE4MkK7P_N7oSUy9A-1; Mon, 16 Aug 2021 06:52:35 -0400
X-MC-Unique: rTbwzBE4MkK7P_N7oSUy9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87DAD1051476;
        Mon, 16 Aug 2021 10:52:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09A465FC25;
        Mon, 16 Aug 2021 10:52:26 +0000 (UTC)
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
Subject: [PATCH v2 01/20] platform/x86: intel_bxtwc_tmu: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:00 +0800
Message-Id: <20210816105119.704302-2-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_bxtwc_tmu to intel sub-directory to
improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                           | 10 ----------
 drivers/platform/x86/Makefile                          |  1 -
 drivers/platform/x86/intel/Kconfig                     | 10 ++++++++++
 drivers/platform/x86/intel/Makefile                    |  4 ++++
 .../x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}       |  0
 5 files changed, 14 insertions(+), 11 deletions(-)
 rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 432d72170b00..15d66892ea92 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1168,16 +1168,6 @@ config INTEL_UNCORE_FREQ_CONTROL
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
 
-config INTEL_BXTWC_PMIC_TMU
-	tristate "Intel BXT Whiskey Cove TMU Driver"
-	depends on REGMAP
-	depends on MFD_INTEL_PMC_BXT
-	depends on INTEL_SOC_PMIC_BXTWC
-	help
-	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
-	  This driver enables the alarm wakeup functionality in the TMU unit
-	  of Whiskey Cove PMIC.
-
 config INTEL_CHTDC_TI_PWRBTN
 	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
 	depends on INTEL_SOC_PMIC_CHTDC_TI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 9bb3c3f77386..2477d46937c2 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
 # Intel PMIC / PMC / P-Unit devices
-obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 6eec084d9bf9..b274ff4192b2 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -20,4 +20,14 @@ source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmt/Kconfig"
 
+config INTEL_BXTWC_PMIC_TMU
+	tristate "Intel BXT Whiskey Cove TMU Driver"
+	depends on REGMAP
+	depends on MFD_INTEL_PMC_BXT
+	depends on INTEL_SOC_PMIC_BXTWC
+	help
+	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
+	  This driver enables the alarm wakeup functionality in the TMU unit
+	  of Whiskey Cove PMIC.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index ca0ec2c85b05..92ab6fa7438f 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -7,3 +7,7 @@
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
+
+# Intel PMIC / PMC / P-Unit devices
+intel_bxtwc_tmu-y 					:= bxtwc_tmu.o
+obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel/bxtwc_tmu.c
similarity index 100%
rename from drivers/platform/x86/intel_bxtwc_tmu.c
rename to drivers/platform/x86/intel/bxtwc_tmu.c
-- 
2.31.1

