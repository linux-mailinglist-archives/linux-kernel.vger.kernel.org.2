Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA073F11A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhHSDbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236387AbhHSDbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uWXnFAjYCuSCakOTROcZ3wOT0x/LE+77kUedqYbNeI=;
        b=Wb7q/m0NKTeSSqrKbsIfnBHhiXZmV2yLC6Lv+HNvXSvc5QRXnKBqUe8KPUSqn2gAPJkeD8
        lDKl5KJlHqw1wBONVa6DQWi6RLv9Qugh1uq+gNeSv6zHJSwOfjibpU7XNpFSLiGVJUXUky
        U/F/mwGOQNkeJh2AAiPr1OZEt8bK4C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-nyiqRRGLPMateyhHVTvx2g-1; Wed, 18 Aug 2021 23:30:58 -0400
X-MC-Unique: nyiqRRGLPMateyhHVTvx2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A72CC73A0;
        Thu, 19 Aug 2021 03:30:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE948189C4;
        Thu, 19 Aug 2021 03:30:52 +0000 (UTC)
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
Subject: [PATCH v3 04/20] platform/x86: intel_punit_ipc: Move to intel sub-directory
Date:   Thu, 19 Aug 2021 11:29:45 +0800
Message-Id: <20210819033001.20136-5-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-1-hpa@redhat.com>
References: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_punit_ipc to intel sub-directory
to improve readability.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                                | 6 ------
 drivers/platform/x86/Makefile                               | 2 +-
 drivers/platform/x86/intel/Kconfig                          | 6 ++++++
 drivers/platform/x86/intel/Makefile                         | 2 ++
 .../platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c}   | 0
 5 files changed, 9 insertions(+), 7 deletions(-)
 rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cb8cb75d3a31..019a625f1fa3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1179,12 +1179,6 @@ config INTEL_PMC_CORE
 		- Low Power Mode registers (Tigerlake and beyond)
 		- PMC quirks as needed to enable SLPS0/S0ix
 
-config INTEL_PUNIT_IPC
-	tristate "Intel P-Unit IPC Driver"
-	help
-	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
-	  which is used to bridge the communications between kernel and P-Unit.
-
 config INTEL_SCU_IPC
 	bool
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6e6436b6b441..344d7a4a33f0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -129,7 +129,7 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 # Intel PMIC / PMC / P-Unit devices
 
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
-obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
+
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 2e76d479b0f3..78314ca39786 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -52,4 +52,10 @@ config INTEL_MRFLD_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_mrfld_pwrbtn.
 
+config INTEL_PUNIT_IPC
+	tristate "Intel P-Unit IPC Driver"
+	help
+	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
+	  which is used to bridge the communications between kernel and P-Unit.
+
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index cfdaa01e5610..a9aa5e15e8bd 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -15,3 +15,5 @@ intel_chtdc_ti_pwrbtn-y			:= chtdc_ti_pwrbtn.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
+intel_punit_ipc-y			:= punit_ipc.o
+obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel/punit_ipc.c
similarity index 100%
rename from drivers/platform/x86/intel_punit_ipc.c
rename to drivers/platform/x86/intel/punit_ipc.c
-- 
2.31.1

