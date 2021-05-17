Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014D3834C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbhEQPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:12:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242448AbhEQPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:02:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621263675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AThSGm5OQuAO1AbHn0HdByw0Hz9ncErXKEkKWb45GJ8=;
        b=ipxYmDuF/AuIA53EP8K7Ur6NTgRzEYx73crGDJKllXSOtmxmWimFsuicZ1PJdlxYTXKbAl
        h2ublfy0HBRvjRM7I8/pjOIifrfvscoA5iibedw5MouKA1zFCG1gQGCiIAKteLNccOiRtM
        tbnz9whjmTVlSTSYLG02eNswraHxQ+8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DE7BAF2C;
        Mon, 17 May 2021 15:01:15 +0000 (UTC)
Date:   Mon, 17 May 2021 17:01:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] watchdog: Cleanup handling of false positives
Message-ID: <YKKFOoMVfAZtDWqE@alley>
References: <YKD3/RuL/2qUcRhL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKD3/RuL/2qUcRhL@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-05-16 19:46:21, Sergey Senozhatsky wrote:
> Hi,
> 
> // This was never in my inbox, so sorry if I mess up the "Reply-to"
> // Original message:  https://lore.kernel.org/lkml/20210311122130.6788-7-pmladek@suse.com/
> 
> 
> >@@ -375,7 +375,14 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> > 	/* .. and repeat */
> > 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
> >
> > -	/* Reset the interval when touched externally by a known slow code. */
> > +	/*
> > +	 * If a virtual machine is stopped by the host it can look to
> > +	 * the watchdog like a soft lockup. Check to see if the host
> > +	 * stopped the vm before we process the timestamps.
> > +	 */
> > +	kvm_check_and_clear_guest_paused();
> > +
> [..]
> >@@ -401,14 +405,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> > 	 */
> > 	duration = is_softlockup(touch_ts, period_ts);
> > 	if (unlikely(duration)) {
> > -		/*
> > -		 * If a virtual machine is stopped by the host it can look to
> > -		 * the watchdog like a soft lockup, check to see if the host
> > -		 * stopped the vm before we issue the warning
> > -		 */
> > -		if (kvm_check_and_clear_guest_paused())
> > -			return HRTIMER_RESTART;
> 
> This looks racy to me. I believe kvm_check_and_clear_guest_paused()
> was in the right place.
> 
> VCPU can be scheduled out/preepmpted any time at any point; and then
> guest VM (or even the entire system) can be suspended. When we resume
> the VM we continue from where we were preempted (from VCPU POW).
> 
> So what the old code did
> 
> watchdog_timer_fn()
> {
> 	...
> 	<<!!>>
> 
> 	// Suppose we are suspended here. When we are getting resumed
> 	// jiffies jump forward, which may look like a soft lockup.
> 	duration = is_softlockup(touch_ts, period_ts);
> 	if (unlikely(duration)) {
> 		// And this is where kvm_check_and_clear_guest_paused()
> 		// jumps in. We know already that jiffies have jumped,
> 		// we don't know if jiffies jumped because the VM was
> 		// suspended. And this is what we figure out here and
> 		// bail out
> 		if (kvm_check_and_clear_guest_paused())
> 			return HRTIMER_RESTART;
> 	}
> }
> 
> The new code does the following
> 
> watchdog_timer_fn()
> {
> 	...
> 	kvm_check_and_clear_guest_paused(); // PVCLOCK_GUEST_STOPPED is not set
> 
> 	<<!!>>
> 
> 	// Suppose the VM got suspended at this point. PVCLOCK_GUEST_STOPPED
> 	// is set, but we don't check it. jiffies will jump and this will look
> 	// like a lockup, but we don't check if jiffies jumped because the VM
> 	// was suspended
> 	duration = is_softlockup(touch_ts, period_ts);
> 	if (unlikely(duration)) {
> 		// report the lockup and perhaps panic the system,
> 		// depending on the configuration
> 	}
> }
> 
> What am I missing?

Great catch! You have a point.

Well, I think that the entire code is racy. touch_ts and period_ts are
set by:

	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
	unsigned long period_ts = __this_cpu_read(watchdog_report_ts);

They are neither volatile not there are any barriers. It means that
period_ts might be re-read in these two checks:

	/* Reset the interval when touched by known problematic code. */
	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
		update_report_ts();
		return HRTIMER_RESTART;
	}

and

	duration = is_softlockup(touch_ts, period_ts);


where:

static int is_softlockup(unsigned long touch_ts, unsigned long period_ts)
{
	unsigned long now = get_timestamp();

	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
		/* Warn about unreasonable delays. */
		if (time_after(now, period_ts + get_softlockup_thresh()))
			return now - touch_ts;
	}
	return 0;
}

Now, if the watchdog is touched from NMI. period_ts might be
SOFTLOCKUP_DELAY_REPORT. It is ULONG_MAX.

As a result period_ts + get_softlockup_thresh() would overflow and
we could report softlockup even when there is none.

I probably does not happen because the per-CPU variable is read only
once. And watchdogs are not typically touched from NMI. Except that
show_regs() actually touch the watchdog.

That said. This patch most likely made things worse and should be
reverted. But even better solution would be to remove this race.
I mean to make the code safe and sane at the same time.

Best Regards,
Petr
