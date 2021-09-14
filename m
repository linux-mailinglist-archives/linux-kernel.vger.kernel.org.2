Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3490F40B6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhINSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhINSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:32:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50EA660F44;
        Tue, 14 Sep 2021 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631644302;
        bh=muly+Dmck52Ug2Tq86rnSCcvbWROds/qp05G9zAz1Qo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m+iZMFxR5LnWXBFlv144Qb0N3yzssXiTPaj1m4mNubbor+zSMKtQF08xPDnbalpz+
         T9Jd1peRHdjlKI+YO0ZpQDFksJopneLfjq1fHMcdE5ikZUSnwiYUBvo5pgkpNsj59I
         DvWJhEjESInYtP34Fqd6E54w3Z3rI6MIAjbuDYq9rPdFFSS6qwSGOI9HPAq00VcZ6X
         hRhqYZ0D6/aAMUbLPpI9qcxFuPXFZQaCYTwHBa7qFAOWaN8dEHDU0mwK05aBLyjI/m
         J9IW/Z9VOsFHshCxOtRvXJjHnHdxPsw5h/Ard0aUwjMlnNt1vHm+8CWmetvRWKc+Ij
         1LBKiWA4U7xLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 198FC5C054C; Tue, 14 Sep 2021 11:31:42 -0700 (PDT)
Date:   Tue, 14 Sep 2021 11:31:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
Message-ID: <20210914183142.GP4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000eaacf005ca975d1a@google.com>
 <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com>
 <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:00:04PM +0200, Dmitry Vyukov wrote:
> On Tue, 14 Sept 2021 at 16:58, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, Sep 14 2021 at 20:37, Hillf Danton wrote:
> >
> > > On Mon, 13 Sep 2021 12:28:14 +0200 Thomas Gleixner wrote:
> > >>On Tue, Aug 31 2021 at 15:45, Hillf Danton wrote:
> > >>> On Mon, 30 Aug 2021 12:58:58 +0200 Dmitry Vyukov wrote:
> > >>>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
> > >>>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
> > >>>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
> > >>>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
> > >>>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
> > >>>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
> > >>>
> > >>> Add debug info only to help kasan catch the timer running longer than 2 ticks.
> > >>>
> > >>> Is it anything in the right direction, tglx?
> > >>
> > >>Not really. As Dmitry pointed out this seems to be related to
> > >
> > > Thanks for taking a look.
> > >
> > >>mac80211_hwsim and if you look at the above stacktrace then how is
> > >>adding something to the timer wheel helpful?
> > >
> > > Given the stall was printed on CPU1 while the supposedly offending timer was
> > > expiring on CPU0, what was proposed is the lame debug info only for kasan to
> > > catch the timer red handed.
> > >
> > > It is more appreciated if the tglx dude would likely spend a couple of minutes
> > > giving us a lesson on the expertises needed for collecting evidence that any
> > > timer runs longer than two ticks. It helps beyond the extent of kasan.
> >
> > That tglx dude already picked the relevant part of the stack trace (see
> > also above):
> >
> > >>>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
> > >>>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
> > >>>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
> > >>>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
> > >>>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
> > >>>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
> >
> > and then asked the question how a timer wheel timer runtime check
> > helps. He just omitted the appendix "if the timer in question is a
> > hrtimer" as he assumed that this is pretty obvious from the stack trace.
> >
> > Aside of that if the wireless timer callback runs in an endless loop,
> > what is a runtime detection of that in the hrtimer softirq invocation
> > helping to decode the problem if the stall detector catches it when it
> > hangs there?
> >
> > Now that mac80211 hrtimer callback might actually be not the real
> > problem. It's certainly containing a bunch of loops, but I couldn't find
> > an endless loop there during a cursory inspection.
> >
> > But that callback does rearm the hrtimer and that made me look at
> > hrtimer_run_queues() which might be the reason for the endless loop as
> > it only terminates when there is no timer to expire anymore.
> >
> > Now what happens when the mac80211 callback rearms the timer so it
> > expires immediately again:
> >
> >         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
> >                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
> >
> > bcn is a user space controlled value. Now lets assume that bcn_int is <=1,
> > which would certainly cause the loop in hrtimer_run_queues() to keeping
> > looping forever.
> >
> > That should be easy to verify by implementing a simple test which
> > reschedules a hrtimer from the callback with a expiry time close to now.
> >
> > Not today as I'm about to head home to fire up the pizza oven.
> 
> This question definitely shouldn't take priority over the pizza. But I
> think I saw this "rearm a timer with a user-controlled value without
> any checks" pattern lots of times and hangs are inherently harder to
> localize and reproduce. So I wonder if it makes sense to add a debug
> config that would catch such cases right when the timer is set up
> (issue a WARNING)?
> However, for automated testing there is the usual question of
> balancing between false positives and false negatives. The check
> should not produce false positives, but at the same time it should
> catch [almost] all actual stalls so that they don't manifest as
> duplicate stall reports.
> 
> If I understand it correctly the timer is not actually set up as
> periodic, but rather each callback invocation arms it again. Setting
> up a timer for 1 ns _once_ (or few times) is probably fine (right?),
> so the check needs to be somewhat more elaborate and detect "infinite"
> rearming.

If it were practical, I would suggest checking for a CPU never actually
executing any instructions in the interrupted context.  The old-school
way of doing this was to check the amount of time spent interrupted,
perhaps adding some guess at interrupt entry/exit overhead.  Is there
a better new-school way?

							Thanx, Paul
