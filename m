Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBBD37305F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhEDTJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:09:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:38652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhEDTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:24 -0400
IronPort-SDR: IOAm1ohfZjBh4bDhiVPxSIlQz+qrlqwuCOLrE+RqAtFwyW9ZhOdfHsM18Rhgxz7x3yR4SIAKJQ
 pHeVhen/C6uQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269911"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269911"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:18 -0700
IronPort-SDR: cJnJdpoXxZmQeYZrs5vAIuUOLx2rcAzj8OBg7hUeVGrunBg1OS1q33+GO2cNUQ42nrGFZ9cYIA
 LCf/FwVv3YpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591756"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 12:07:17 -0700
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
Subject: [RFC PATCH v5 13/16] watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot parameter
Date:   Tue,  4 May 2021 12:05:23 -0700
Message-Id: <20210504190526.22347-14-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the HPET-based hardlockup detector disabled unless explicitly enabled
via a command-line argument. If such parameter is not given, the
initialization of the hpet-based hardlockup detector fails and the NMI
watchdog will fall back to use the perf-based implementation.

Implement the command-line parsing using an early_param, as
__setup("nmi_watchdog=") only parses generic options.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
--
Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * Do not imply that using nmi_watchdog=hpet means the detector is
   enabled. Instead, print a warning in such case.

Changes since v1:
 * Added documentation to the function handing the nmi_watchdog
   kernel command-line argument.
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++-
 arch/x86/kernel/watchdog_hld_hpet.c           | 22 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 74db44ce4d9a..eafa38867270 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3136,7 +3136,7 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][num,][hpet]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
@@ -3147,6 +3147,12 @@
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
+			When hpet is specified, the NMI watchdog will be driven
+			by an HPET timer, if available in the system. Otherwise,
+			it falls back to the default implementation (perf or
+			architecture-specific). Specifying hpet has no effect
+			if the NMI watchdog is not enabled (either at build time
+			or via the command line).
 
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index cd5f59b7c01b..3fd2405b31fa 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -548,6 +548,28 @@ void hardlockup_detector_hpet_stop(void)
 	disable_timer(hld_data);
 }
 
+/**
+ * hardlockup_detector_hpet_setup() - Parse command-line parameters
+ * @str:	A string containing the kernel command line
+ *
+ * Parse the nmi_watchdog parameter from the kernel command line. If
+ * selected by the user, use this implementation to detect hardlockups.
+ */
+static int __init hardlockup_detector_hpet_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (parse_option_str(str, "hpet"))
+		hardlockup_use_hpet = true;
+
+	if (!nmi_watchdog_user_enabled && hardlockup_use_hpet)
+		pr_err("Selecting HPET NMI watchdog has no effect with NMI watchdog disabled\n");
+
+	return 0;
+}
+early_param("nmi_watchdog", hardlockup_detector_hpet_setup);
+
 /**
  * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
  *
-- 
2.17.1

