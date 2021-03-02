Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECBA32A0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576801AbhCBEch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:16564 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241994AbhCBCxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:53:39 -0500
IronPort-SDR: qWk072xW7WhoAO6GYS5HcBsK/2eefsMwKYJGgi3QU37EVwh8lVj3SE9LGihaYDjrK3J+OvV1vP
 9YKjVqpYm8Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="173801464"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="173801464"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 18:52:56 -0800
IronPort-SDR: 18V1aoMyv3V3gXtdjNZJMIAp6u1rqnzBWf0/4mbI/SZefjq82V2kMlN3dlvIrRm7WpyTPl/Yzq
 eFf2lV2VO4Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="398030320"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2021 18:52:53 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, dave.hansen@intel.com, andi.kleen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH] x86/tsc: mark tsc reliable for qualified platforms
Date:   Tue,  2 Mar 2021 10:52:52 +0800
Message-Id: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases that tsc clocksource are wrongly judged as unstable by
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

So implement it with slight change as discussed in the thread, and be
more defensive to use maxim of 2 sockets.

The check is done inside tsc_init() before registering 'tsc-early' and
'tsc' clocksources, as there were cases that both of them have been
wrongly judged as unreliable.

[1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/tsc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc..a7e3980 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1193,6 +1193,17 @@ static void __init check_system_tsc_reliable(void)
 #endif
 	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
 		tsc_clocksource_reliable = 1;
+
+	/*
+	 * Ideally the socket number should be checked, but this is called
+	 * by tsc_init() which is in early boot phase and the socket numbers
+	 * may not be available. Use 'nr_online_nodes' as a fallback solution
+	 */
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC)
+		&& boot_cpu_has(X86_FEATURE_NONSTOP_TSC)
+		&& boot_cpu_has(X86_FEATURE_TSC_ADJUST)
+		&& nr_online_nodes <= 2)
+		tsc_clocksource_reliable = 1;
 }
 
 /*
-- 
2.7.4

