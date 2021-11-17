Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3616B453E82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 03:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhKQCky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 21:40:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:57589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhKQCkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:40:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233813560"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="233813560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 18:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="494730824"
Received: from shbuild999.sh.intel.com ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2021 18:37:52 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, rui.zhang@intel.com, andi.kleen@intel.com,
        len.brown@intel.com, tim.c.chen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
Date:   Wed, 17 Nov 2021 10:37:50 +0800
Message-Id: <20211117023751.24190-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally the tsc_sync will get checked every time system enters idle state,
but Thomas Gleixner mentioned there is still a caveat that a system won't
enter idle [1], either because it's too busy or configured purposely to not
enter idle. Setup a periodic timer (every 10 minitues) to make sure the
check is always on.

[1]. https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Change log:

  v3:
     * rebase against 5.16-rc1
     * small change to code comments and commit log
  
  v2:
     * skip timer setup when tsc_clocksource_reliabe==1 (Thomas)
     * refine comment and code format (Thomas) 

 arch/x86/kernel/tsc_sync.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 50a4515fe0ad..911df742145f 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -30,6 +30,7 @@ struct tsc_adjust {
 };
 
 static DEFINE_PER_CPU(struct tsc_adjust, tsc_adjust);
+static struct timer_list tsc_sync_check_timer;
 
 /*
  * TSC's on different sockets may be reset asynchronously.
@@ -77,6 +78,46 @@ void tsc_verify_tsc_adjust(bool resume)
 	}
 }
 
+/*
+ * Normally the tsc_sync will be checked every time system enters idle
+ * state, but there is still caveat that a system won't enter idle,
+ * either because it's too busy or configured purposely to not enter
+ * idle.
+ *
+ * So setup a periodic timer (every 10 minutes) to make sure the check
+ * is always on.
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
2.27.0

