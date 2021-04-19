Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25260364D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhDSVuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:50:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:61937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhDSVul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:50:41 -0400
IronPort-SDR: sJGgATM4ncQ4hhmchJrEgUYNQBuniFV8zaoPOzIWs5lw2m8QBp72HF/ATL3xfGDHTd3MgyQPFr
 vLqPMTAtVlTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193279425"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="193279425"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:50:10 -0700
IronPort-SDR: NQPfHq4lWHnsjiqPaymmU4GHGuz/jIH+2dfXS/dE6Tydm/cCFucijLJIWi0tQEDGJmYcfZ3vPM
 6QfTKRDHbrHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="534277609"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2021 14:50:10 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/4] x86/bus_lock: Set rate limit for bus lock
Date:   Mon, 19 Apr 2021 21:49:56 +0000
Message-Id: <20210419214958.4035512-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419214958.4035512-1-fenghua.yu@intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus lock can be thousands of cycles slower than atomic operation within
one cache line. It also disrupts performance on other cores. Malicious
users may generate multiple bus locks to degrade the whole system
performance.

To mitigate the issue, the kernel can set a system wide rate limit for
bus locks via a kernel parameter:
	split_lock_detect=ratelimit:N

When the system detects bus locks at a rate higher than N/sec (where
N can be set by the kernel boot argument in the range [1..1000]) any
task triggering a bus lock will be forced to sleep for at least 20ms
until the overall system rate of bus locks drops below the threshold.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 43 +++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fe0bec14d7ec..149c4d33e8c4 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -10,6 +10,7 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/delay.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -41,6 +42,7 @@ enum split_lock_detect_state {
 	sld_off = 0,
 	sld_warn,
 	sld_fatal,
+	sld_ratelimit,
 };
 
 /*
@@ -997,13 +999,31 @@ static const struct {
 	{ "off",	sld_off   },
 	{ "warn",	sld_warn  },
 	{ "fatal",	sld_fatal },
+	{ "ratelimit:", sld_ratelimit },
 };
 
+static struct ratelimit_state bld_ratelimit;
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
-	int len = strlen(opt);
+	int len = strlen(opt), ratelimit;
+
+	if (strncmp(arg, opt, len))
+		return false;
+
+	/*
+	 * Min ratelimit is 1 bus lock/sec.
+	 * Max ratelimit is 1000 bus locks/sec.
+	 */
+	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 &&
+	    ratelimit > 0 && ratelimit <= 1000) {
+		ratelimit_state_init(&bld_ratelimit, HZ, ratelimit);
+		ratelimit_set_flags(&bld_ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
-	return len == arglen && !strncmp(arg, opt, len);
+		return true;
+	}
+
+	return len == arglen;
 }
 
 static bool split_lock_verify_msr(bool on)
@@ -1082,6 +1102,15 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
+	/*
+	 * #DB for bus lock handles ratelimit and #AC for split lock is
+	 * disabled.
+	 */
+	if (sld_state == sld_ratelimit) {
+		split_lock_verify_msr(false);
+		return;
+	}
+
 	if (cpu_model_supports_sld)
 		split_lock_verify_msr(sld_state != sld_off);
 }
@@ -1154,6 +1183,12 @@ void handle_bus_lock(struct pt_regs *regs)
 	switch (sld_state) {
 	case sld_off:
 		break;
+	case sld_ratelimit:
+		/* Enforce no more than bld_ratelimit bus locks/sec. */
+		while (!__ratelimit(&bld_ratelimit))
+			msleep(20);
+		/* Warn on the bus lock. */
+		fallthrough;
 	case sld_warn:
 		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, regs->ip);
@@ -1259,6 +1294,10 @@ static void sld_state_show(void)
 				" from non-WB" : "");
 		}
 		break;
+	case sld_ratelimit:
+		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: setting system wide bus lock rate limit to %u/sec\n", bld_ratelimit.burst);
+		break;
 	}
 }
 
-- 
2.31.1

