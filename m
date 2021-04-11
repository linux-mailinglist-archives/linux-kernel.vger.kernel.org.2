Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEDC35B22A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhDKHVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 03:21:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:46858 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKHVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 03:21:45 -0400
IronPort-SDR: DbF8OBuUunY58cCECaDKiza3nepIT5tDSnQ7AfkXZ053JQYQln0IetF7OTOliAZqITlQoqcZrM
 nT7oiwmzVK9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="279290046"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="279290046"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 00:21:28 -0700
IronPort-SDR: TpZUl78n1HerQ6d8MU2DjWqvE4kCXWjCsrXXKsgsjlBnf6LdrPX6JNNiN+dYTVptTLgQl6OwIP
 Zkup/BQhZ2Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="459756026"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2021 00:21:22 -0700
Date:   Sun, 11 Apr 2021 15:21:21 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always
 checked
Message-ID: <20210411072121.GA81632@shbuild999.sh.intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
 <20210410143804.GB22054@shbuild999.sh.intel.com>
 <87blam2d0x.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blam2d0x.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 08:46:38PM +0200, Thomas Gleixner wrote:
> Feng,
> 
> On Sat, Apr 10 2021 at 22:38, Feng Tang wrote:
> > On Sat, Apr 10, 2021 at 11:27:11AM +0200, Thomas Gleixner wrote:
> >> > +static int __init start_sync_check_timer(void)
> >> > +{
> >> > +	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
> >> > +		return 0;
> >> > +
> >> > +	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
> >> > +	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
> >> > +	add_timer(&tsc_sync_check_timer);
> >> > +
> >> > +	return 0;
> >> > +}
> >> > +late_initcall(start_sync_check_timer);
> >> 
> >> So right now, if someone adds 'tsc=reliable' on the kernel command line
> >> then all of the watchdog checking, except for the idle enter TSC_ADJUST
> >> check is disabled. The NOHZ full people are probably going to be pretty
> >> unhappy about yet another unconditional timer they have to chase down.
> >> 
> >> So this needs some more thought.
> >
> > 'tsc=reliable' in cmdline will set 'tsc_clocksource_reliable' to 1, so
> > we can skip starting this timer if 'tsc_clocksource_reliable==1' ?
> 
> Then we can just ignore that patch alltogether because of 2/2 doing:
> 
> +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> +	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> +	    nr_online_nodes <= 2)
> +		tsc_clocksource_reliable = 1;
> 
> ....
> 
> I said for a reason:
 
Sorry, I missed that part and should have put more thought on it,
which is much trickier than I thought.

In the very first patch I set 'tsc_clocksource_reliable' to 1 to
try reusing the logic of clearing CLOCK_SOURCE_MUST_VERIFY bit,
and now we may need to decouple them.

One thing I can think of now is something below:

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

Thanks,
Feng

> >> So this needs some more thought.
> 
> Thanks,
> 
>         tglx
