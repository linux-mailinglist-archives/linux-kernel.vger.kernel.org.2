Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFA34E31B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhC3IZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:25:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:18303 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhC3IZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:25:55 -0400
IronPort-SDR: CHkaCXplw95aptKXGVOenHqMBwsDvguAJ4v7ebE/wVAFRRSBJjCyhA6V8RmeNz0Oxj8XxbzhN7
 mvBIycP1nloA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171123246"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="171123246"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 01:25:54 -0700
IronPort-SDR: 4zIcgBhM42pzRnspE8FyKlh5H8rhzmN1MtIm3g0XvpqCDD39Lm4UHzyo5ljSD30xoT16R91Y4s
 HcNXHuvO6dzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="411500993"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2021 01:25:51 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, andi.kleen@intel.com, dave.hansen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [RFC 2/2] x86/tsc: mark tsc reliable for qualified platforms
Date:   Tue, 30 Mar 2021 16:25:47 +0800
Message-Id: <1617092747-15769-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
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

As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several generations
of Atom processor, and is always coupled with X86_FEATURE_CONSTANT_TSC
and X86_FEATURE_NONSTOP_TSC, skip checking it,. and also be more defensive
to use maxim of 2 sockets.

The check is done inside tsc_init() before registering 'tsc-early' and
'tsc' clocksources, as there were cases that both of them had been
wrongly judged as unreliable.

Another idea is to not lift the check here, but inside the
tsc_sync_check_timer, stop the clocksource watchdog timer if there is
no TSC_ADJUST overridden found in 10 minutes after boot.

[1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/tsc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc..3a451e3 100644
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
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
+	    nr_online_nodes <= 2)
+		tsc_clocksource_reliable = 1;
 }
 
 /*
-- 
2.7.4

