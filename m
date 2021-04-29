Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5696136E702
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhD2I2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhD2I17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:27:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA70C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:27:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619684830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVMpd/7UnblAeARgM1Vh/SShHk6zopRhLEgbgPC++NY=;
        b=UNivqEbInwP3ZbgEe4XYlqDHaJwxYxlreJSvaHa1lZezLiCwWtdBj93xIQPQy1Jwq1jFSP
        rK4LsplDVRwLQw/YL3xijf6WRNelPYyMvVaHzo8N9+N9wKT/G1ln2oZ42qqCy/h1ISCdoF
        NJB0oyRCdQrZnomMEUomP2YqEDe9s7MlLiWkTUh9HN1HZWcBvaKjJ2ldFYq4aTb2hes+0H
        5gyT+p3lAt7fswlaopdT9Ug6ygvpyV7ib0HAY7MOnj6x2t/A+cUbPozxWyhU+5SNTbwD81
        Qt8J4nh9Q5rzxELvfgeT+gWkjGtBGnGB8OwnUWDNrIQlzB9ae0AvVscUj+N5vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619684830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVMpd/7UnblAeARgM1Vh/SShHk6zopRhLEgbgPC++NY=;
        b=BI+O49tfwTtdyVEur82+PHnqqMy00hPsukH6cgXnA8KMLRcRiJbpidBx4GOnQocBJhbbkv
        +xqwtXBJtHfHqsAg==
To:     paulmck@kernel.org
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
Subject: Re: [clocksource]  8c30ace35d: WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
In-Reply-To: <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de> <87a6pimt1f.ffs@nanos.tec.linutronix.de> <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 29 Apr 2021 10:27:09 +0200
Message-ID: <878s517axu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Wed, Apr 28 2021 at 11:31, Paul E. McKenney wrote:
> On Wed, Apr 28, 2021 at 03:34:52PM +0200, Thomas Gleixner wrote:
>>  2) If the host has clear indications that TSC can be trusted, then it
>>     can tell the guest that TSC is trustworthy. A synthesized CPU
>>     feature bit is the obvious solution for this.
>> 
>>     That solves several virt problems at once:
>> 
>>      - The watchdog issue
>> 
>>      - The fact that TSC synchronization checks between two vCPUs
>>        cannot ever work reliably.
>
> Such checks are subject to false negatives, but not false positives.
> And the probability of vCPU preemption within that small window is
> low enough that repeated false negatives should be extremely rare.
>
> Or am I missing another source of synchronization-check unreliability?

Oh yes. The whole CPU bringup synchronization checks which involves two
vCPUs to run side by side. That's different from the watchdog issue
which is just a single vCPU issue.

See the mess in tsc_sync.c ....

> Or are you saying that the checks should be in the host OS rather than
> in the guests?

Yes. That's where it belongs. The host has to make sure that TSC is usable
otherwise it should tell the guest not to use it. Anything else is
wishful thinking and never reliable.

>>  5) CPU has X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC and
>>     TSC_ADJUST and the not yet existing feature TSC_LOCKDOWN
>> 
>>     We're asking for this for at least 15 years now, but we also had to
>>     wait 10+ years to get a halfways usable TSC, so why am I
>>     complaining?
>
> Wait!  Don't tell me...  The BIOS vendors have been refusing to accept
> any TSC_LOCKDOWN hardware feature?  ;-)

Not sure who is refusing to accept reality. As most BIOSes keep their
hands of TSC nowadays that might be more an issue on the HW vendor side.

>> So we really care about #3 and #4.
>> 
>> #4 is the easy case because we can check MSR_TSC_ADJUST to figure out
>>    whether something has written to MSR_TSC or MSR_TSC_ADJUST and undo
>>    the damage in a sane way.
>> 
>>    That's currently only done when a CPU goes idle, but there are
>>    options to do that differently (timer, TIF flag ...)
>> 
>>    This allows to disable the clocksource watchdog completely and based
>>    on Fengs work we are going to do so sooner than later.
>
> Given correctly operating hardware, yes, the x86 arch_cpu_idle_enter()
> invokes tsc_verify_tsc_adjust(), which will print a "TSC ADJUST differs:
> CPU" message on the console, correct?  Or did I go down the wrong
> rabbit hole?

That's the correct rabbit whole.

> In addition, breakage due to age and environmentals is possible, and if
> you have enough hardware, probable.  In which case it would be good to
> get a notification so that the system in question can be dealt with.

Are you trying to find a problem for a solution again?

>>      This includes the jiffies based watchdog which is the worst bandaid
>>      which we have, though that can be made 'work' by some definition of
>>      work.
>
> Larger uncertainty_margin should handle this.  Let's see: MIPS does HZ=24
> (and HZ=1024?) and Alpha does HZ=32 (and HZ=1200?).  Apparently all the
> old HZ=10 and HZ=1 use cases have migrated to NO_HZ_FULL or something.
>
> And even HZ=24 fits nicely into an int, even allowing a factor of four for
> two measurements plus factor of safety.  So looking at both clocksource's
> uncertainty_margin as you suggest below should cover this case.
>
> Give or take the inevitable surprise.

Yes, and TBH I'm not worried about this case at all.

>>   b) Long delays which prevent the watchdog from running
>>      which in the worst case let the watchdog wrap around.
>> 
>>      For ACPI_PMTIMER that's ~4.69 seconds and for HPET ~300 seconds.
>> 
>>      Anything which keeps the watchdog timer from running for that long
>>      is broken and trying to fix that at the watchdog level is putting
>>      the cart before the horse.
>> 
>>      Ignore virt here. See above.
>
> Agreed.  If you are hitting five-minute vCPU preemptions, you are almost
> certainly blowing your response-time constraints anyway.  I mean, we might
> not use full-up -rt, but we also are not a punched-card shop.

Punch-card computing was only non-deterministic up to the point where
your cards hit the reader assumed that the assistant did not drop the
pile and resorted it in the wrong order. Once the job got on the CPU it
was very deterministic :)

>>   c) vCPUs scheduled out between the watchdog and the TSC read
>> 
>>      Cannot be mitigated reliably under all circumstances. See the virt
>>      section above.
>
> Your point being that the watchdog checks should be done on the KVM
> hypervisor host rather than in the guest OSes, correct?
>
> As noted in an earlier thread, I am concerned about the possibility of
> some strange timer bug that affects guests but not hosts.

Well, you might then also build safety nets for interrupts, exceptions
and if you go fully paranoid for every single CPU instruction. :)

>> Unfortunately there is no other way than using the watchdog mechanism,
>> simply because we need hardware assistance for detection and a reliable
>> way to undo the damage, which is what we have with TSC_ADJUST. Of course
>> the best case would be a mechanism to prevent writes to TSC/TSC_ADJUST
>> completely after boot.
>
> There will be other failure modes that result in skew detection,
> especially if the systems are old or under environmental stress,
> correct?

Well, if the system goes down that road then it's most likely that other
parts will expose failures and the aging/stress applies to the watchdog
as well.

>> Now let's look at the cases which cause TSC problems in the real world:
>> 
>>     1) Boot time (or resume time) TSC inconsistency
>> 
>>        That's the major problem today, but that's not a watchdog issue.
>> 
>>        On TSC_ADJUST equipped machines we fix the wreckage up, on others
>>        we give up. For the latter case we don't need a watchdog :)
>
> I bet that "whack the hardware over the head and reboot" is still a
> popular error-handling strategy, and it would handle this case.  ;-)

Then you might end up with a endless boot, whack, reboot cycles :)

>>     2) Runtime wreckage caused by BIOS/SMM
>> 
>>        That used to be a wide spread problem 10 years ago and today it's
>>        only a sporadic issue, but it's not eliminated completely which
>>        is why we have this discussion at all.
>> 
>> As we have no reliable indicator whether a BIOS can be trusted and
>> history taught us that it can't be trusted, we need to have this
>> trainwreck until hardware people actually come to senses and fix the
>> root cause once and forever.
>
> On new hardware, it looks like checking for "TSC ADJUST differs: CPU"
> console messages would be a good thing during system evaluation.
> Noted!

Correct.

>> So let's look at the issues a - e above:
>> 
>>    a) Is not fixable though the hillarious refined-jiffies case can
>>       be handled to some degree. But I really don't care much about
>>       it because it's a lost case.
>
> Given the HZ settings available these days, your suggestion of
> uncertainty_margin should avoid false positives.
>
>>    b) Not interesting at all. If that ever happens, then sure the
>>       TSC will be marked unstable for the wrong reasons, but that's
>>       the least of the problems in that case.
>> 
>>       And that includes virt because virt should not use the watchdog
>>       ever.
>> 
>>    c) Not relevant because virt has to solve the problems which virt
>>       causes at the virt level and not here.
>> 
>>    d) The reread/retry mechanism is sensible.
>> 
>>       Though all the command line knobs for delay injection are really
>>       horrible. If at all this can be avoided by having a special
>>       watchdog clocksource module which registers a 'preferred' watchdog
>>       clocksource and hides all the magic outside of the actual watchdog
>>       code.
>
> You mean move the watchdog code to a kernel/time/clocksourcewdg.c file
> or some such?  Either way, the delay-injection parameters need to be
> specified somehow, and there needs to be a way of reliably injecting
> the types of errors required to exercise the code.

Sure. If you have a seperate module then you can add module params to it
obviously. But you don't need any of the muck in the actual watchdog
code because the watchdog::read() function in that module will simply
handle the delay injection. Hmm?

>> In case we agree on that option, I'm volunteering to write the
>> documentation.
>
> My concern here is that a lot of people seem to be getting excited about
> creating their own CPUs.  I would rather have code that automatically
> slaps their wrists for getting per-CPU timing wrong than to have to chase
> it down the hard way.  Much as I would hope that they would learn from
> the TSC experience, that does not always appear to be the trend.  :-/

As I said to Peter already: Nothing prevents me from dreaming :)

Thanks,

        tglx
