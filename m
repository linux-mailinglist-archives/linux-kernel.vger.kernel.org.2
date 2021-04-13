Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E021635D745
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbhDMFcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:32:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:34741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243206AbhDMFcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:32:02 -0400
IronPort-SDR: plvvLNxG192VjKNsg79P6A4iU02Sr8Z2bddU7RyuB8C+5Kqi4tfcE+TUM9PyDq4RAXjcE2XcL9
 C+2G0FnrVeyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194457337"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="194457337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 22:31:42 -0700
IronPort-SDR: 2XOnrPR2Qbhpj2AuNnofFkGP0QPF6AXYuxkutw4j//KCmxXtqUtXYKOqb+QWQ0oFkGqFGaAiT9
 Z439+IcHj6HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="521469331"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2021 22:31:38 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, andi.kleen@intel.com, dave.hansen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
Date:   Tue, 13 Apr 2021 13:31:36 +0800
Message-Id: <1618291897-71581-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally the tsc_sync will get checked every time system enters idle state,
but Thomas Gleixner mentioned there is still a caveat that a system won't
enter idle [1], either because it's too busy or configured purposely to not
enter idle. Setup a periodic timer to make sure the check is always on.

[1]. https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Change log:
  
  v2:
     * skip timer setup when tsc_clocksource_reliabe==1 (Thomas)
     * refine comment and code format (Thomas) 

 arch/x86/kernel/tsc_sync.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 3d3c761..39f18fa 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -30,6 +30,7 @@ struct tsc_adjust {
 };
 
 static DEFINE_PER_CPU(struct tsc_adjust, tsc_adjust);
+static struct timer_list tsc_sync_check_timer;
 
 /*
  * TSC's on different sockets may be reset asynchronously.
@@ -77,6 +78,44 @@ void tsc_verify_tsc_adjust(bool resume)
 	}
 }
 
+/*
+ * Normally the tsc_sync will be checked every time system enters idle state,
+ * but there is still caveat that a system won't enter idle, either because
+ * it's too busy or configured purposely to not enter idle.
+ *
+ * So setup a periodic timer to make sure the check is always on.
+ */
+
+#define SYNC_CHECK_INTERVAL		(HZ * 600)
+
+static void tsc_sync_check_timer_fn(struct timer_list *unused)
+{
+	int next_cpu;
+
+	tsc_verify_tsc_adjust(false);
+
+	/* Run the check for all onlined CPUs in turn */
+	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
+	if (next_cpu >= nr_cpu_ids)
+		next_cpu = cpumask_first(cpu_online_mask);
+
+	tsc_sync_check_timer.expires += SYNC_CHECK_INTERVAL;
+	add_timer_on(&tsc_sync_check_timer, next_cpu);
+}
+
+static int __init start_sync_check_timer(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST) || tsc_clocksource_reliable)
+		return 0;
+
+	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
+	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
+	add_timer(&tsc_sync_check_timer);
+
+	return 0;
+}
+late_initcall(start_sync_check_timer);
+
 static void tsc_sanitize_first_cpu(struct tsc_adjust *cur, s64 bootval,
 				   unsigned int cpu, bool bootcpu)
 {
-- 
2.7.4

