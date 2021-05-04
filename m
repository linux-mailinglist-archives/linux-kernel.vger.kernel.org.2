Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1C373060
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEDTJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:09:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:38656 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232130AbhEDTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:24 -0400
IronPort-SDR: ovmwOvNNWDlzX3nVRpNbl3Xz1A31qL+k/YqtgLxb9H4LfjS9FCE0W6yN/AMLav6elAEo/vD/7h
 VIHlLVpcxiFw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269912"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269912"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:18 -0700
IronPort-SDR: JV0AMvwR2no6YNpPZBxyDIxDMlicGNSCxzgpFPC4XoVhGsaaIpF68b8FB1xRNB9lHepPTrkMx1
 qr8SwjbcZpqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591759"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 12:07:18 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>
Subject: [RFC PATCH v5 14/16] x86/watchdog: Add a shim hardlockup detector
Date:   Tue,  4 May 2021 12:05:24 -0700
Message-Id: <20210504190526.22347-15-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic hardlockup detector is based on perf. It also provides a set
of weak stubs that CPU architectures can override. Add a shim hardlockup
detector for x86 that selects between perf and hpet implementations.

Specifically, this shim implementation is needed for the HPET-based
hardlockup detector; it can also be used for future implementations.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Use a switch to enable and disable the various available detectors.
   (Andi)

Changes since v3:
 * Fixed style in multi-line comment. (Randy Dunlap)

Changes since v2:
 * Pass cpu number as argument to hardlockup_detector_[enable|disable].
   (Thomas Gleixner)

Changes since v1:
 * Introduced this patch: Added an x86-specific shim hardlockup
   detector. (Nicholas Piggin)
---
 arch/x86/Kconfig.debug         |  4 ++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/watchdog_hld.c | 80 ++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0731da557a6d..4cdac3f80e80 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -117,9 +117,13 @@ config IOMMU_LEAK
 config HAVE_MMIOTRACE_SUPPORT
 	def_bool y
 
+config X86_HARDLOCKUP_DETECTOR
+	bool
+
 config X86_HARDLOCKUP_DETECTOR_HPET
 	bool "HPET Timer for Hard Lockup Detection"
 	select HARDLOCKUP_DETECTOR_CORE
+	select X86_HARDLOCKUP_DETECTOR
 	depends on HARDLOCKUP_DETECTOR && HPET_TIMER && HPET && (X86_64 || X86_32)
 	help
 	  The hardlockup detector is driven by one counter of the Performance
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 5d1a90b23577..3303f10b3d0a 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR) += watchdog_hld.o
 obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..8947a7644421
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A shim hardlockup detector. It overrides the weak stubs of the generic
+ * implementation to select between the perf- or the hpet-based implementation.
+ *
+ * Copyright (C) Intel Corporation 2021
+ */
+
+#include <linux/nmi.h>
+#include <asm/hpet.h>
+
+enum x86_hardlockup_detector {
+	X86_HARDLOCKUP_DETECTOR_PERF,
+	X86_HARDLOCKUP_DETECTOR_HPET,
+};
+
+static enum __read_mostly x86_hardlockup_detector detector_type;
+
+int watchdog_nmi_enable(unsigned int cpu)
+{
+	int ret = 0;
+
+	switch (detector_type) {
+	case X86_HARDLOCKUP_DETECTOR_PERF:
+		hardlockup_detector_perf_enable();
+		break;
+	case X86_HARDLOCKUP_DETECTOR_HPET:
+		hardlockup_detector_hpet_enable(cpu);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	switch (detector_type) {
+	case X86_HARDLOCKUP_DETECTOR_PERF:
+		hardlockup_detector_perf_disable();
+		break;
+	case X86_HARDLOCKUP_DETECTOR_HPET:
+		hardlockup_detector_hpet_disable(cpu);
+		break;
+	}
+}
+
+int __init watchdog_nmi_probe(void)
+{
+	int ret;
+
+	/*
+	 * Try first with the HPET hardlockup detector. It will only
+	 * succeed if selected at build time and the nmi_watchdog
+	 * command-line parameter is configured. This ensure that the
+	 * perf-based detector is used by default, if selected at
+	 * build time.
+	 */
+	ret = hardlockup_detector_hpet_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_HPET;
+		return ret;
+	}
+
+	ret = hardlockup_detector_perf_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
+		return ret;
+	}
+
+	return ret;
+}
+
+void watchdog_nmi_stop(void)
+{
+	/* Only the HPET lockup detector defines a stop function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_stop();
+}
-- 
2.17.1

