Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE85136760D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbhDVAIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:08:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbhDVAIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:08:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619050086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mn1x06C8aK1JJjUCmDoFCMm/tn5bYkvmPQTNKEL7/Vo=;
        b=uuSoaXyQaJaiANPLtvwG5lPVrlLQTWdeYutjJDOf1GJWc7VjBTpiJ+OYfS0dhjBXLIudn4
        V6YZpTcxwspCt8bD0UySo077DsiAUbRz7gzqyzAdhskExa/uLSzKl6+hpDfGaNy1rdBw4h
        Cbdr5x7nMnqTe8bpwCruv9hsepf6BTnQ5pbbKrLQo4kcoZYORQlMe94QT3KePYgQPlsfNO
        4JXEGHnVAhQQ5pyh3IgYdArSyPsC5rFqaE6IyeW+zbcntIBf3GetPXOaZTIeI/TmhgChKv
        KcU1oCsQqExj1rt43bGuIkM1N0l3rwGSomixT9rUIqSQKr6J36KTul3nsQO8vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619050086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mn1x06C8aK1JJjUCmDoFCMm/tn5bYkvmPQTNKEL7/Vo=;
        b=KtxN3bMgUazyJzI7cWx3FXfcNoY0WHi8hol0dXEyee2dPJSLGZnaA3JEq/jfwB0DJt5dFS
        qLF3QfC03MSt1MAQ==
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykows?= =?utf-8?Q?ki?= 
        <zenczykowski@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
In-Reply-To: <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com>
Date:   Thu, 22 Apr 2021 02:08:05 +0200
Message-ID: <87v98fxjtm.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21 2021 at 23:08, Lorenzo Colitti wrote:
> On Tue, Apr 20, 2021 at 11:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>   1) hrtimer is contrary to timer_list not really suited for high
>>      frequency start/cancel/start/... cycles of a timer. It's optimized
>>      for the start and expire precisely case.
>
> Ack. This is not what the f_ncm gadget code needs. It just needs a
> timer to fire "about 300us after the last packet submitted". Under
> load the timer will almost never fire since there will always be
> another packet coming. So the speed of adding/updating the timer is
> much more important than the accuracy. We will try to move it to
> timer_list.
>
>>      I assume that's an ARM64 system. ARM64 CPUs have an architected per
>>      CPU timer where the reprogramming is pretty fast as it's next to
>>      the CPU, but who knows what your system is using.
>
> This system appears to be using timer hardware that is... slow to
> program (microseconds). We're looking at whether it's possible to use
> the arch timer instead.
>
>> Now in the meantime I looked into __hrtimer_start_range_ns() whether
>> that double reprogram can be avoided without creating a total trainwreck
>> and imposing penalty on all sensible use cases. Completely untested
>> patch below should do the trick and it's not ugly enough that I hate it
>> with a passion.
>
> I tested this and in my simple benchmark, the double calls are gone
> and hrtimer_start calls tick_program_event approximately once (more
> precisely, 90.06% of the time; sometimes it doesn't call it at all).
> This is not enough to cancel the regression we're seeing because the
> previous code would pretty much never call tick_program_event at all.
> But it's definitely better.

It's hardly a regression when the behaviour relies on a bug in the core
code which should have never been there in the first place.

If you look at what you are doing it's obvious that reprogramming has to
take place quite often.

Your timeout is relative 300us and it's moved every N microseconds
ahead. So if there is not much other hrtimer activity on that CPU which
is often the case and the only other relevant hrtimer which is armed
(and expires) is the tick, then it depends on the HZ setting how often
reprogramming is required.

Lets assume HZ=1000 and a rearm period of 20us, which means the timer is
rearmed 50 times per tick and reprogramming is needed for each rearm
before the tick timer becomes the first expiring timer, i.e. 300us
before the tick. So 700/20 = 35 times per 1ms the hardware needs to be
updated because the first expiry time moves 20us farther into the future
on every update. That's 70%

So depending on how long that takes on your machine 35 updates can be a
significant amount of time.

With HZ=250 that's 200 times rearming / tick and the reprogramming is
then 3700/20 = 185 which is 92.5% which is close enough to the 90% you
are seing...

Now, if your timer hardware needs several microseconds to be programmed
then it's obvious that you lose a lot of CPU time.

Just for comparison. In a VM I'm experimenting with right now the
reprogramming time is ~500ns which is still a lot of cycles, but
compared to 5us faster by an order of magnitude. And on the sane
machine bare metal its way faster and therefore less noticeable.

The use case still sucks, but that's not a problem of hrtimers as they
are not designed for this use case.

Now looking at the usecase. The comment above the hrtimer callback,
which is the only hint there, says:

 * The transmit should only be run if no skb data has been sent for a
 * certain duration.

which is useless word salad.

So looking at the commit which added that muck: 6d3865f9d41f ("usb:
gadget: NCM: Add transmit multi-frame."). The changelog mutters:

    It has a time out of 300ms to ensure that smaller number of packets
    still maintain a normal latency.

while the timeout is defined as:

+#define TX_TIMEOUT_NSECS       300000

which is clearly 300us and not 300ms. So much for useful information in
changelogs.

But at least the rest of the commit message gives a clue why this is
useful:

    This adds multi-frame support to the NCM NTB's for
    the gadget driver. This allows multiple network
    packets to be put inside a single USB NTB with a
    maximum size of 16kB.

So the timer ensures that for batching xmit packets into a single NTB
the maximum delay is 300us if the NTB is not filled up on time.

Though there is ZERO explanation why 300us is a sensible number and why
it's a brilliant idea to use a hrtimer which is clearly documented to be
not suitable for this.

I'm pretty sure that the original author did not develop that on
hardware which used a timer based on a hardware trainwreck, but alone
the fact that:

 - rbtree reshuffling _is_ always required
 - high frequency reprogramming of the timer hardware might be required
 - in case that CONFIG_HIGH_RES_TIMERS is off or not enabled at runtime
   for whatever reason this is still subject to the CONFIG_HZ setting
 
tells me that this is clearly well thought out and based on "works for
me" engineering.

Plus at the time when this was hacked up, the bug which was fixed by the
commit you refer to, did not exist yet as it was introduced with the
softirq based expiry changes years later.

Back then the timer expiry was scheduling a tasklet to ensure that
->ndo_start_xmit() is called from softirq context.

The softirq based expiry changes which introduced the correctness bug
removed that tasklet indirection.

And going back to 4.14 yields the proof of this. The same microbenchmark
as described above i.e. modifying the timer every 20us has exactly the
same effect vs. reprogramming the clock event device:

 It's programmed twice on every hrtimer_start() ~90% of the time

So no. The real regression was introduced with:

  5da70160462e ("hrtimer: Implement support for softirq based hrtimers")

and related changes, but that had not a negative effect on that USB
driver usage, quite the contrary it papered over it.

commit 46eb1701c0 fixed that regression and thereby unearthed the issue
with that USB driver usage issue in combination with that timer
hardware.

If 5da70160462e et al. would not had introduced that bug then the
problems with that hrtimer usage in combination with that timer hardware
trainwreck would have been noticed way earlier. IOW it would never have
worked at all.

Aside of that any use case which does not use the _SOFT variant of
hrtimers was not affected by 5da70160462e et al. Which in turn means
that all !_SOFT usecases are not abusing hrtimers and NONE of the
_SOFT usecases cares about correctness and accuracy at all.

So pretty please stop claiming that this is a regression. It was broken
forever, but papered over and therefore just not noticed.

IOW, the problem was introduced with 6d3865f9d41f, i.e. 6+ years
ago. The reasons why this pops up now are:

 - There was an unnoticed bug since 5da70160462e in the hrtimers code
   for 3 years.

 - It's only observable on hardware which has abysmal per cpu timers

TBH, I'm telling HW people for 15+ years now that clockevents and
clocksources are performance critical and relevant for correctness, but
obviously they don't listen. Otherwise we would not have code in tree
which has comments like this:

  hpet_clkevt_set_next_event(...)
	 * HPETs are a complete disaster. The compare register is

or any other clock event which is compare equal based and has to do read
back based interrupt loss prevention like

     pxa_osmr0_set_next_event() and other trainwrecks.

Along with the insanities of watchdogs to monitor correctness and
clocksources/events which stop to work when entering deep power states.

Not to talk about gems like this:

  exynos4_mct_write()
	/* Wait maximum 1 ms until written values are applied */

along with all the magic patches which make this the preferred device
for the very wrong reasons.

I have no idea which particular trainwreck you are dealing with because
you didn't tell, but TBH I don't want to know at all. It's probably just
another incarnation of broken which is not covered by the above, but
fits nicely.

That said, even if you manage to avoid the timer hardware trainwreck on
which your system is depending on right now, then still the underlying
problem remains that hrtimers are not the proper tool for high frequency
modification and never will be.

There are smarter approaches to that USB/NTB problem, but that's beyond
the discussion at hand.

Thanks,

        tglx


