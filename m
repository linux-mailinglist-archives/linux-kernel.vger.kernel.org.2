Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE636D985
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhD1O0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhD1OZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:25:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D3BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:24:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id o1so5158428qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvac3EFFEvEMUQhP6uFo8bTeNA0dhCxqnWcKqP7KlxA=;
        b=jp8QkvxvfCMG1g9Usz1wpDVzALrXQKoaa+xll5ufNPoctOU8dn3TXmfbdYVfKgs59I
         zO14GnwTKcfs6gbQ0pNbZ2KWE3KNR6ku2YhWGmhhIT1H0OfdiaikvNQiMIJKxIWUe7fc
         GsNbR1+cNM4QK52WeyVZ/OMTkVC1Njk35z9NmRfqza2Mdk2mjY8w9UdAFJWgViHDNaPA
         3SswhoqDRl69kp3Vi9u1cthj2FwZoAu19h6ern0i2H7StuuMwrB2m1zauIYywaykbkGb
         C5sIEv9wovA0y8XFVK2QnrGNPBjf9o4czxu30YM6bGsv/KnOUmt/OOGOTzWJlHcdbKAg
         ZnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvac3EFFEvEMUQhP6uFo8bTeNA0dhCxqnWcKqP7KlxA=;
        b=csZeGMjPLhjVMgUaX+r95KDKhUOvfzI8DRRvfWr/Z56+52UVi57fQdndYb+jYgeqDX
         bo0ixtPwpn/q6BZo4caWbDcuvyNI5m46p9IxmJUPC6/zKvEovJe83SgRUU3vDeRqqNBe
         QjWSkTmWEwuvFmLG1HPk0C0U4pTi/uIdmWCAw1wHLhi4PYbrxQUpSTz1B8gEsI0oq3+4
         fx350v2qamg8zHxLKO2OhlBgcfQITUouzf4w4hKHMZgBr1zUZI/jSRQfhCBocuKmi1Zs
         mSZye4fGNWhzKox338CJwgSVQhnTfv9LT0pB+A3zM4+DY/9iP+wK5Tqh7Valtn4ldbsS
         ji5Q==
X-Gm-Message-State: AOAM531K6th9kFiYyBXH8s+3Dk2hkauKPa5LRd5OEbWZCg8n0atEDx4J
        njSxHTuA6azHkbNGD1Pf0Gxe7xlWfqO5u9ZXqUsSzTY6fmA=
X-Google-Smtp-Source: ABdhPJx63DiaL6uppXNTZI9CgtYuvKHwXAz4/BuO7W4JcCn4Mfk0wQ7tV3w7CzUikun6CYjXUYWc3EJRpCTzIc+JciQ=
X-Received: by 2002:ac8:6b05:: with SMTP id w5mr14208091qts.204.1619619893490;
 Wed, 28 Apr 2021 07:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org> <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1> <20210426160008.GY1401198@tassilo.jf.intel.com>
 <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1> <20210426175627.GZ1401198@tassilo.jf.intel.com>
 <20210426182433.GD975577@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZxgJuc2OJfvT_k3Xmk_qsxzm=xX5wm4NqeRo7vkTcZk6w@mail.gmail.com>
 <20210428135725.GN975577@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210428135725.GN975577@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Wed, 28 Apr 2021 22:24:42 +0800
Message-ID: <CAJRGBZyFbvpdrbKmV9KrXz7VkMcTMqVp2PAcFRvroZue6b9tag@mail.gmail.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
To:     paulmck@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 9:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Apr 28, 2021 at 12:49:12PM +0800, Luming Yu wrote:
> > We 'd expect to see clock_source watchdog can avoid to do wrong thing
> > due to the injected delay or
> > in real life delay by doing tsc sync-re-check by applying the patch-set.
> > However , the noise is still cause wrong actions and the patch doesn't
> > defeat the injected's delay
> > please correct me if  I'm wrong.
>
> Injecting delay is just a test.  In real life, if you got four delays
> in a row, the cause is likely that the clock read is broken and taking
> a very long time.  In which case marking that clock unstable is a
> reasonable response.
>
> Other causes include having an NMI or SMI storm, getting extremely
> unlucky with vCPU preemptions, and so on.  In these cases, you are not
> making much forward progress anyway, so marked-unstable clock is the
> least of your worries.
>
> I ran this (without injected delays) for more than a thousand hours on
> rcutorture guest OSes and didn't see any instances of even two consecutive
> bad reads.   There was the very occasional single instance of a bad read.
>
> Therefore, the code marks the clock unstable if it has four bad reads
> in a row, as it should.

The hard problem to solve is tsc is still in good shape and it can be verified
with a quick cross check with other thread/core's tsc counts in the
injected situation or in real life case
to prove if it is  truly a tsc problem or reference clock's problem of
the watchdog.

Ideally, we could factor out hard-to-debug unstable tsc problems from
clock source watchdog problems
and get less and less tsc sightings caused by clock source watchdog.

>
>                                                         Thanx, Paul
>
> > parameters]# cat *
> > 1
> > 1
> > -1
> > 3
> > 8
> >
> > [62939.809615] clocksource: clocksource_watchdog_inject_delay():
> > Injecting delay.
> > [62939.816867] clocksource: clocksource_watchdog_inject_delay():
> > Injecting delay.
> > [62939.824094] clocksource: clocksource_watchdog_inject_delay():
> > Injecting delay.
> > [62939.831314] clocksource: clocksource_watchdog_inject_delay():
> > Injecting delay.
> > [62939.838536] clocksource: timekeeping watchdog on CPU26: hpet
> > read-back delay of 7220833ns, attempt 4, marking unstable
> > [62939.849230] tsc: Marking TSC unstable due to clocksource watchdog
> > [62939.855340] TSC found unstable after boot, most likely due to
> > broken BIOS. Use 'tsc=unstable'.
> > [62939.863972] sched_clock: Marking unstable (62943398530130,
> > -3543150114)<-(62941186607503, -1331276112)
> > [62939.875104] clocksource: Checking clocksource tsc synchronization
> > from CPU 123 to CPUs 0,6,26,62,78,97-98,137.
> > [62939.886518] clocksource: Switched to clocksource hpet
> >
> > On Tue, Apr 27, 2021 at 2:27 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Mon, Apr 26, 2021 at 10:56:27AM -0700, Andi Kleen wrote:
> > > > > ------------------------------------------------------------------------
> > > > >
> > > > > - module parameters
> > > > >
> > > > >   If the scope of the fault injection capability is limited to a
> > > > >   single kernel module, it is better to provide module parameters to
> > > > >   configure the fault attributes.
> > > > >
> > > > > ------------------------------------------------------------------------
> > > > >
> > > > > And in this case, the fault injection capability is in fact limited to
> > > > > kernel/clocksource.c.
> > > >
> > > >
> > > > I disagree with this recommendation because it prevents fuzzer coverage.
> > > >
> > > > Much better to have an uniform interface that can be automatically
> > > > explored.
> > >
> > > The permissions for these module parameters is 0644, so there is no
> > > reason why the fuzzers cannot use them via sysfs.
> > >
> > >                                                         Thanx, Paul
