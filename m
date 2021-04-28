Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C371536DEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbhD1ScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232390AbhD1ScE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:32:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9B1F61412;
        Wed, 28 Apr 2021 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619634679;
        bh=fIfOWalQqoA43z7v4THKGICmJNaEqDTNQz6hUCEgc3M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GpIiqyslBXRSxgvj+w2/ZRopFnJ0pYTeaDsRUYVx/Wx0C23dlTzexJuNok4Uird39
         eXKqB9dQagMUBH1xOFI2d7rLX8bJpmbhKOqbPqcz9PDCLmKMjLB9Dmht+OqEnTOSSc
         rFfeHnqzcNNO0paqem4DFICuADQUaPxI4j1yjsCJ0VUzyjhuq5cHCYyV2rWGdoGfp0
         HIZSwL/WQbwE2/fhXQu/6Jl7SF4ZRJlf9f1L85RGIv+FWUzqhcDBNo/+HR8TgBAIf6
         7ORm/mHhiaiKCI6DtWy03a9EeriRMCtAA7TriivNkAqZwuenM1TfUGHL29xV074wfB
         uplggJc4LOWTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 706E65C00FE; Wed, 28 Apr 2021 11:31:18 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:31:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6pimt1f.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:34:52PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Tue, Apr 27 2021 at 23:09, Thomas Gleixner wrote:
> > On Tue, Apr 27 2021 at 10:50, Paul E. McKenney wrote:
> >> OK, it turns out that there are systems for which boot times in excess
> >> of one minute are expected behavior.  They are a bit rare, though.
> >> So what I will do is keep the 60-second default, add a boot parameter,
> >> and also add a comment by the warning pointing out the boot parameter.
> >
> > Oh, no. This starts to become yet another duct tape horror show.
> >
> > I'm not at all against a more robust and resilent watchdog mechanism,
> > but having a dozen knobs to tune and heuristics which are doomed to fail
> > is not a solution at all.
> 
> That said, let's take a step back and look at the trainwreck from a
> different POV.
> 
> Let's start with the easy part: Virtualization
> 
>  While I'm still convinced that virt creates more problems than it
>  solves, in this particular case, the virt solution is actually
>  halfways trivial.
> 
>  1) If the host does not trust the TSC then it clearly wants the guest
>     to use KVM clock and not TSC. KVM clock is still utilizing TSC, but
>     it's a host controlled and assisted mechanism.
> 
>  2) If the host has clear indications that TSC can be trusted, then it
>     can tell the guest that TSC is trustworthy. A synthesized CPU
>     feature bit is the obvious solution for this.
> 
>     That solves several virt problems at once:
> 
>      - The watchdog issue
> 
>      - The fact that TSC synchronization checks between two vCPUs
>        cannot ever work reliably.

Such checks are subject to false negatives, but not false positives.
And the probability of vCPU preemption within that small window is
low enough that repeated false negatives should be extremely rare.

Or am I missing another source of synchronization-check unreliability?

Or are you saying that the checks should be in the host OS rather than
in the guests?

> Now for the bare metal case. We have to distinguish the following
> scenarios:
> 
>  1) CPU does not advertise X86_FEATURE_CONSTANT_TSC
> 
>     That's a lost case and only relevant for really old hardware.
> 
>  2) CPU does advertise X86_FEATURE_CONSTANT_TSC, but does not
>     have X86_FEATURE_NONSTOP_TSC
> 
>     Mostly a lost case as well unless you disable the C-states in which
>     TSC stops working.
> 
>  3) CPU does advertise X86_FEATURE_CONSTANT_TSC and X86_FEATURE_NONSTOP_TSC
> 
>     That's the point where usable starts, which is around 2007/2008
> 
>  4) CPU has X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC and
>     TSC_ADJUST
> 
>     That's anything Intel starting from Haswell - not sure about the
>     ATOM parts though.
> 
>     Non-Intel CPUs lack this completely.

A lot of options, so thank you for summarizing!

>  5) CPU has X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC and
>     TSC_ADJUST and the not yet existing feature TSC_LOCKDOWN
> 
>     We're asking for this for at least 15 years now, but we also had to
>     wait 10+ years to get a halfways usable TSC, so why am I
>     complaining?

Wait!  Don't tell me...  The BIOS vendors have been refusing to accept
any TSC_LOCKDOWN hardware feature?  ;-)

> So we really care about #3 and #4.
> 
> #4 is the easy case because we can check MSR_TSC_ADJUST to figure out
>    whether something has written to MSR_TSC or MSR_TSC_ADJUST and undo
>    the damage in a sane way.
> 
>    That's currently only done when a CPU goes idle, but there are
>    options to do that differently (timer, TIF flag ...)
> 
>    This allows to disable the clocksource watchdog completely and based
>    on Fengs work we are going to do so sooner than later.

Given correctly operating hardware, yes, the x86 arch_cpu_idle_enter()
invokes tsc_verify_tsc_adjust(), which will print a "TSC ADJUST differs:
CPU" message on the console, correct?  Or did I go down the wrong
rabbit hole?

In addition, breakage due to age and environmentals is possible, and if
you have enough hardware, probable.  In which case it would be good to
get a notification so that the system in question can be dealt with.

> The problematic case is #3 because that affects any Non-Intel CPUs
> and the pre Haswell Intel ones.

I am with Peter on this one, and not just for the AMD machines.  :-/

> The approach we have taken so far is the clocksource watchdog in the
> form in which it exists today with the known limitations:
> 
>   a) Broken watchdog clocksource. Not that I care much, because then
>      all bets are off.
> 
>      This includes the jiffies based watchdog which is the worst bandaid
>      which we have, though that can be made 'work' by some definition of
>      work.

Larger uncertainty_margin should handle this.  Let's see: MIPS does HZ=24
(and HZ=1024?) and Alpha does HZ=32 (and HZ=1200?).  Apparently all the
old HZ=10 and HZ=1 use cases have migrated to NO_HZ_FULL or something.

And even HZ=24 fits nicely into an int, even allowing a factor of four for
two measurements plus factor of safety.  So looking at both clocksource's
uncertainty_margin as you suggest below should cover this case.

Give or take the inevitable surprise.

>   b) Long delays which prevent the watchdog from running
>      which in the worst case let the watchdog wrap around.
> 
>      For ACPI_PMTIMER that's ~4.69 seconds and for HPET ~300 seconds.
> 
>      Anything which keeps the watchdog timer from running for that long
>      is broken and trying to fix that at the watchdog level is putting
>      the cart before the horse.
> 
>      Ignore virt here. See above.

Agreed.  If you are hitting five-minute vCPU preemptions, you are almost
certainly blowing your response-time constraints anyway.  I mean, we might
not use full-up -rt, but we also are not a punched-card shop.

>   c) vCPUs scheduled out between the watchdog and the TSC read
> 
>      Cannot be mitigated reliably under all circumstances. See the virt
>      section above.

Your point being that the watchdog checks should be done on the KVM
hypervisor host rather than in the guest OSes, correct?

As noted in an earlier thread, I am concerned about the possibility of
some strange timer bug that affects guests but not hosts.

>   d) Long lasting NMI/SMI's between watchdog and TSC read
> 
>      Can be mitigated with reread/retry as you demonstrated.
> 
>   e) A too large threshold, which if reduced causes other problems as
>      you figured out already.

This whole thing has been a learning experience for me.  ;-)

> Unfortunately there is no other way than using the watchdog mechanism,
> simply because we need hardware assistance for detection and a reliable
> way to undo the damage, which is what we have with TSC_ADJUST. Of course
> the best case would be a mechanism to prevent writes to TSC/TSC_ADJUST
> completely after boot.

There will be other failure modes that result in skew detection,
especially if the systems are old or under environmental stress, correct?

> Now let's look at the cases which cause TSC problems in the real world:
> 
>     1) Boot time (or resume time) TSC inconsistency
> 
>        That's the major problem today, but that's not a watchdog issue.
> 
>        On TSC_ADJUST equipped machines we fix the wreckage up, on others
>        we give up. For the latter case we don't need a watchdog :)

I bet that "whack the hardware over the head and reboot" is still a
popular error-handling strategy, and it would handle this case.  ;-)

>     2) Runtime wreckage caused by BIOS/SMM
> 
>        That used to be a wide spread problem 10 years ago and today it's
>        only a sporadic issue, but it's not eliminated completely which
>        is why we have this discussion at all.
> 
> As we have no reliable indicator whether a BIOS can be trusted and
> history taught us that it can't be trusted, we need to have this
> trainwreck until hardware people actually come to senses and fix the
> root cause once and forever.

On new hardware, it looks like checking for "TSC ADJUST differs: CPU"
console messages would be a good thing during system evaluation.  Noted!

> So let's look at the issues a - e above:
> 
>    a) Is not fixable though the hillarious refined-jiffies case can
>       be handled to some degree. But I really don't care much about
>       it because it's a lost case.

Given the HZ settings available these days, your suggestion of
uncertainty_margin should avoid false positives.

>    b) Not interesting at all. If that ever happens, then sure the
>       TSC will be marked unstable for the wrong reasons, but that's
>       the least of the problems in that case.
> 
>       And that includes virt because virt should not use the watchdog
>       ever.
> 
>    c) Not relevant because virt has to solve the problems which virt
>       causes at the virt level and not here.
> 
>    d) The reread/retry mechanism is sensible.
> 
>       Though all the command line knobs for delay injection are really
>       horrible. If at all this can be avoided by having a special
>       watchdog clocksource module which registers a 'preferred' watchdog
>       clocksource and hides all the magic outside of the actual watchdog
>       code.

You mean move the watchdog code to a kernel/time/clocksourcewdg.c file
or some such?  Either way, the delay-injection parameters need to be
specified somehow, and there needs to be a way of reliably injecting
the types of errors required to exercise the code.

>       Neither I'm sure whether this IPI collect data muck is adding much
>       value, but shrug.
>
>    e) As I said elsewhere already this is an issue which has two
>       components if we want to handle the refined-jiffies case:
> 
>       clocksource frequency is not accurate: early-TSC
>       watchdog is not accurate: refined-jiffies
> 
>       So the threshold wants to be:
> 
>          max(cs->uncertainty_margin, wd->uncertainty_margin)
> 
>       So the right thing to do here is to set a small and reasonable
>       default margin ($N us) in the clock source registration code if
>       cs->uncertainty_margin == 0 and add the larger margins to
>       early-TSC and refined-jiffies.

That does make a lot of sense, thank you!  I would be tempted to add the
two ->uncertainty_margin fields rather than take the max(), but in real
life it should not matter much.

> The only other option to handle this mess is to declare the watchdog
> experiment as failed, rip it out completely and emit a fat warning on
> boot when a non-trustable TSC is detected:
> 
>      HARDWARE-BUG: Untrusted TSC detected. For further information see:
>      https://www.kernel.org/doc/html/latest/admin-guide/hw-trainwrecks/tsc.html
> 
> I can live with that and maybe we should have done that 15 years ago
> instead of trying to work around it at the symptom level.
> 
> In case we agree on that option, I'm volunteering to write the
> documentation.

My concern here is that a lot of people seem to be getting excited about
creating their own CPUs.  I would rather have code that automatically
slaps their wrists for getting per-CPU timing wrong than to have to chase
it down the hard way.  Much as I would hope that they would learn from
the TSC experience, that does not always appear to be the trend.  :-/

							Thanx, Paul
