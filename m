Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C301935D3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344036AbhDLXS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243892AbhDLXS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:18:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B373861042;
        Mon, 12 Apr 2021 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618269489;
        bh=lwGaCdrAPJSgyrxWQRrmKC+aGd0omNPN2HvY27uQhhM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C8ZyjR6T/COcNDEzEAAFdUNU3WecdToe3zNm2WqK9avAvRpZzh2eyegr9lEgFB0F9
         oWWOrQDScD8npxjpBk842m2pTMHyxMMggSIL2ymE+tfxCEzVlUO13uGu9TLj3tU673
         aUBpkYNQj8IsO/5mDpfEov9QXIkPOqxMThWpqZE46QQuRf0S0CmJbV5uJrFobVdLvR
         ZXA5XxYn2JRtcv0Tad+68Ke1giwuuTQIjE+UzelzhkmMAriTef5Y5F2g+givsHgg7Q
         RHqYd/ZCabdmW8B4ynCj1JJxgdIuM8cXSIxjptDJZT7I0eajz5UHHkjFR8++9/qTm1
         m6izxX+tOTfeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 72A425C2303; Mon, 12 Apr 2021 16:18:09 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:18:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210412231809.GI4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87blam4iqe.ffs@nanos.tec.linutronix.de>
 <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <878s5p2jqv.ffs@nanos.tec.linutronix.de>
 <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1>
 <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1>
 <87k0p71whr.ffs@nanos.tec.linutronix.de>
 <20210412182049.GE4510@paulmck-ThinkPad-P17-Gen-1>
 <87y2dnz644.ffs@nanos.tec.linutronix.de>
 <20210412195722.GG4510@paulmck-ThinkPad-P17-Gen-1>
 <87o8ejz1c9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8ejz1c9.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:37:10PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 12 2021 at 12:57, Paul E. McKenney wrote:
> > On Mon, Apr 12, 2021 at 08:54:03PM +0200, Thomas Gleixner wrote:
> >> > I will send a new series out later today, Pacific Time.
> >> 
> >> Can you do me a favour and send it standalone and not as yet another
> >> reply to this existing thread maze. A trivial lore link to the previous
> >> version gives enough context.
> >
> > Will do!
> >
> > Of course, it turns out that lockdep also doesn't like waited-on
> > smp_call_function_single() invocations from timer handlers,
> > so I am currently looking at other options for dealing with that
> > potential use-after-free.  I am starting to like the looks of "only set
> > CLOCK_SOURCE_VERIFY_PERCPU on statically allocated clocksource structures
> > and let KASAN enforce this restriction", but I have not quite given up
> > on making it more general.
> 
> The simplest point is in the thread under the clocksource_mutex which
> prevents anything from vanishing under your feet.

And lockdep is -much- happier with the setup shown below, so thank
you again!

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f047c6cb056c..34dc38b6b923 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -519,6 +515,13 @@ static int __clocksource_watchdog_kthread(void)
 	unsigned long flags;
 	int select = 0;
 
+	/* Do any required per-CPU skew verification. */
+	list_for_each_entry(cs, &watchdog_list, wd_list) {
+		if ((cs->flags & (CLOCK_SOURCE_UNSTABLE | CLOCK_SOURCE_VERIFY_PERCPU)) ==
+		    (CLOCK_SOURCE_UNSTABLE | CLOCK_SOURCE_VERIFY_PERCPU))
+			clocksource_verify_percpu(cs);
+	}
+
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
