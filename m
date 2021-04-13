Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927435D746
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbhDMFcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:32:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:34746 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243206AbhDMFcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:32:09 -0400
IronPort-SDR: pZvwXe5JYgitehmH15+cXH05bJP0ttZ6G/z94Lw2qIOLqWeHvW2tdd26JCdqJ/S0kXutY6NeKJ
 VVO+qoy6eThA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194457341"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="194457341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 22:31:45 -0700
IronPort-SDR: 0zVF37Fgp+1eFvvJR1XbMVadDH9SvfBMwiebOJn0Jt6q8xi8PB8YjG2iXfm/bF60zcGHctXcUP
 F+pQnFnWEQEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="521469345"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2021 22:31:42 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, andi.kleen@intel.com, dave.hansen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 2/2] x86/tsc: skip tsc watchdog checking for qualified platforms
Date:   Tue, 13 Apr 2021 13:31:37 +0800
Message-Id: <1618291897-71581-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618291897-71581-1-git-send-email-feng.tang@intel.com>
References: <1618291897-71581-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases that tsc clocksources are wrongly judged as unstable by
clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
there is hardly a general reliable way to check the validity of a
watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:

"I'm inclined to lift that requirement when the CPU has:

    1) X86_FEATURE_CONSTANT_TSC
    2) X86_FEATURE_NONSTOP_TSC
    3) X86_FEATURE_NONSTOP_TSC_S3
    4) X86_FEATURE_TSC_ADJUST
    5) At max. 4 sockets

 After two decades of horrors we're finally at a point where TSC seems
 to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
 was really key as we can now detect even small modifications reliably
 and the important point is that we can cure them as well (not pretty
 but better than all other options)."

As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several generations
of Atom processor, and is always coupled with X86_FEATURE_CONSTANT_TSC
and X86_FEATURE_NONSTOP_TSC, skip checking it, and also be more defensive
to use maxim of 2 sockets.

The check is done inside tsc_init() before registering 'tsc-early' and
'tsc' clocksources, as there were cases that both of them had been
wrongly judged as unreliable.

[1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Change log:

  v2:
    * Directly skip watchdog check without messing flag
      'tsc_clocksource_reliable' (Thomas)

 arch/x86/kernel/tsc.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc..bfd013b 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1177,6 +1177,12 @@ void mark_tsc_unstable(char *reason)
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
 
+static void __init tsc_skip_watchdog_verify(void)
+{
+	clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+}
+
 static void __init check_system_tsc_reliable(void)
 {
 #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
@@ -1193,6 +1199,17 @@ static void __init check_system_tsc_reliable(void)
 #endif
 	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
 		tsc_clocksource_reliable = 1;
+
+	/*
+	 * Ideally the socket number should be checked, but this is called
+	 * by tsc_init() which is in early boot phase and the socket numbers
+	 * may not be available. Use 'nr_online_nodes' as a fallback solution
+	 */
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
+	    nr_online_nodes <= 2)
+		tsc_skip_watchdog_verify();
 }
 
 /*
@@ -1384,9 +1401,6 @@ static int __init init_tsc_clocksource(void)
 	if (tsc_unstable)
 		goto unreg;
 
-	if (tsc_clocksource_reliable || no_tsc_watchdog)
-		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
-
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
 		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 
@@ -1524,7 +1538,7 @@ void __init tsc_init(void)
 	}
 
 	if (tsc_clocksource_reliable || no_tsc_watchdog)
-		clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+		tsc_skip_watchdog_verify();
 
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
-- 
2.7.4

