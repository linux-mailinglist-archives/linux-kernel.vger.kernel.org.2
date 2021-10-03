Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2431420401
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJCVIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhJCVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 17:08:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB77C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 14:06:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l7so33269778edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D33TFwm+9VLFGwCQLSqEYU7W28ptqtn0UU85U8qmedU=;
        b=TStFJS9+L59c/9md2lVaPrpYiOfE//Yya5z+gCGMjbLODRheDYTn/d3yoZCEbtxsd4
         q9noOTfcT5oty/Ov2gA7auGDEJyNIs45VyaaeURnTqA0UwlOwNdu7aDpAidoR1/ap/t6
         qgjAO05u1zRX4tJZifgOKuahHR5DzP55z21o5JFHWyWhI/VyPlz5iPsm5Y0/hR5SmxgI
         ZesxHvFaB7KqOGqckDJEzNAZwmAD1jsSGlJIrD8bUp3cBkWZKZQUIBfGfVrTAIfvDQNK
         hqcyKlk9tQ5a/pcKToeClFt3vYR/pTJmnzKkY4CyZWNepd99MVrN3iuLdoqs9+2CnMFg
         i8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D33TFwm+9VLFGwCQLSqEYU7W28ptqtn0UU85U8qmedU=;
        b=BMWtkQibQSlpykbTXysq3jyJ1DA+69ZXWgPDa3o618xYG1vSJ0Ok3yZKbCQfwh6goe
         FoDobCKvLDRnJVq+/QJT4aXh22MVIBeSOZPJI+s31O7az1cnmgQ1X4+0MJXY6IRjwkv9
         wyL7oEgXCLBZrZ+USrnKaCiO1QKxvq/LdkepaCqbvRcAh5M2oOgacxJQs25x8vrV2s9F
         XlrwdTcvSYcdmbyuIQRFeygAsUC5H3VGFCL1cupoMIxhTZ8CWJN6z60GeW4MbX33tXSv
         lOi/pAtgPsbVm8RJGSeHHeuS1a3yoD7kN4h0xl0OG0jeEjPwCpznWGsbaD7kKORY56zh
         KtMw==
X-Gm-Message-State: AOAM5324444iZc1Fn+B9lGu1RuEG2svFgJ9KU8rD8RPyN6AXtSPhj26M
        1L9tXF2c6paLYySxDEtU+6ZjKlxKbvMnbpVRwJY=
X-Google-Smtp-Source: ABdhPJzFNff33fm9WayuWfBKZ5nZlHPlsWYBehzhqj9yC63dIfo0l6pJQ139CL0gapGxdjcohRzPGDqymsgk43ysHRM=
X-Received: by 2002:a17:906:1341:: with SMTP id x1mr12571446ejb.277.1633295179922;
 Sun, 03 Oct 2021 14:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net> <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net> <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de> <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
 <4713ffb37ee8f6042626904ad33fa91b5151f0d6.camel@gmx.de>
In-Reply-To: <4713ffb37ee8f6042626904ad33fa91b5151f0d6.camel@gmx.de>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 4 Oct 2021 10:06:08 +1300
Message-ID: <CAGsJ_4zAN-K_OrhC8wec9nyXxbP+sS_-N4djvaUYYVuYj+zbyQ@mail.gmail.com>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
To:     Mike Galbraith <efault@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 3:52 AM Mike Galbraith <efault@gmx.de> wrote:
>
> On Sun, 2021-10-03 at 20:34 +1300, Barry Song wrote:
> > >
> > > I looked into that crazy stacking depth...
> > >
> > > static int
> > > wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> > >                    int this_cpu, int prev_cpu, int sync)
> > > {
> > >         s64 this_eff_load, prev_eff_load;
> > >         unsigned long task_load;
> > >
> > >         this_eff_load = cpu_load(cpu_rq(this_cpu));
> > >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^ the butler didit!
> > >
> > > That's pretty darn busted as it sits.  Between load updates, X, or any
> > > other waker of many, can stack wakees to a ludicrous depth.  Tracing
> > > kbuild vs firefox playing a youtube clip, I watched X stack 20 of the
> > > zillion firefox minions while their previous CPUs all had 1 lousy task
> > > running but a cpu_load() higher than the cpu_load() of X's CPU.  Most
> > > of those prev_cpus were where X had left them when it migrated. Each
> > > and every crazy depth migration was wake_affine_weight() deciding we
> > > should pull based on crappy data.  As instantaneous load on the waker
> > > CPU blew through the roof in my trace snapshot, its cpu_load() did
> > > finally budge.. a tiny bit.. downward.  No idea where the stack would
> > > have topped out, my tracing_off() limit was 20.
> >
> > Mike, not quite sure I caught your point. It seems you mean x wakes up
> > many firefoxes within a short period, so it pulls them to the CPU where x
> > is running. Technically those pulling should increase cpu_load of x' CPU.
> > But due to some reason, the cpu_load is not increased in time on x' CPU,
> > So this makes a lot of firefoxes piled on x' CPU, but at that time,  the load
> > of the cpu which firefox was running on is still larger than x' cpu with a lot
> > of firefoxes?
>
> It looked like this.
>
> X-2211    [007] d...211  2327.810997: select_task_rq_fair: this_run/load:4:373 prev_run/load:4:373 waking firefox:4971 CPU7 ==> CPU7
> X-2211    [007] d...211  2327.811004: select_task_rq_fair: this_run/load:5:373 prev_run/load:1:1029 waking QXcbEventQueue:4952 CPU0 ==> CPU7
> X-2211    [007] d...211  2327.811010: select_task_rq_fair: this_run/load:6:373 prev_run/load:1:1528 waking QXcbEventQueue:3969 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811015: select_task_rq_fair: this_run/load:7:373 prev_run/load:1:1029 waking evolution-alarm:3833 CPU0 ==> CPU7
> X-2211    [007] d...211  2327.811021: select_task_rq_fair: this_run/load:8:373 prev_run/load:1:1528 waking QXcbEventQueue:3860 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811026: select_task_rq_fair: this_run/load:8:373 prev_run/load:1:1528 waking QXcbEventQueue:3800 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811032: select_task_rq_fair: this_run/load:9:373 prev_run/load:1:1528 waking xdg-desktop-por:3341 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811037: select_task_rq_fair: this_run/load:10:373 prev_run/load:1:289 waking at-spi2-registr:3165 CPU4 ==> CPU7
> X-2211    [007] d...211  2327.811042: select_task_rq_fair: this_run/load:11:373 prev_run/load:1:1029 waking ibus-ui-gtk3:2865 CPU0 ==> CPU0
> X-2211    [007] d...211  2327.811049: select_task_rq_fair: this_run/load:11:373 prev_run/load:1:226 waking ibus-x11:2868 CPU2 ==> CPU2
> X-2211    [007] d...211  2327.811054: select_task_rq_fair: this_run/load:11:373 prev_run/load:11:373 waking ibus-extension-:2866 CPU7 ==> CPU7
> X-2211    [007] d...211  2327.811059: select_task_rq_fair: this_run/load:12:373 prev_run/load:1:289 waking QXcbEventQueue:2804 CPU4 ==> CPU7
> X-2211    [007] d...211  2327.811063: select_task_rq_fair: this_run/load:13:373 prev_run/load:1:935 waking QXcbEventQueue:2756 CPU1 ==> CPU7
> X-2211    [007] d...211  2327.811068: select_task_rq_fair: this_run/load:14:373 prev_run/load:1:1528 waking QXcbEventQueue:2753 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811074: select_task_rq_fair: this_run/load:15:373 prev_run/load:1:1528 waking QXcbEventQueue:2741 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811079: select_task_rq_fair: this_run/load:16:373 prev_run/load:1:1528 waking QXcbEventQueue:2730 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811085: select_task_rq_fair: this_run/load:17:373 prev_run/load:1:5 waking QXcbEventQueue:2724 CPU0 ==> CPU0
> X-2211    [007] d...211  2327.811090: select_task_rq_fair: this_run/load:17:373 prev_run/load:1:1010 waking QXcbEventQueue:2721 CPU6 ==> CPU7
> X-2211    [007] d...211  2327.811096: select_task_rq_fair: this_run/load:18:373 prev_run/load:1:1528 waking QXcbEventQueue:2720 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811101: select_task_rq_fair: this_run/load:19:373 prev_run/load:1:1528 waking QXcbEventQueue:2704 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811105: select_task_rq_fair: this_run/load:20:373 prev_run/load:0:226 waking QXcbEventQueue:2705 CPU2 ==> CPU2
> X-2211    [007] d...211  2327.811110: select_task_rq_fair: this_run/load:19:342 prev_run/load:1:1528 waking QXcbEventQueue:2695 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811115: select_task_rq_fair: this_run/load:20:342 prev_run/load:1:1528 waking QXcbEventQueue:2694 CPU5 ==> CPU7
> X-2211    [007] d...211  2327.811120: select_task_rq_fair: this_run/load:21:342 prev_run/load:1:1528 waking QXcbEventQueue:2679 CPU5 ==> CPU7

What is the topology of your hardware?  shouldn't select_idle_sibling
find some other idle CPUs in CPU7's LLC domain?
Why are you always getting CPU7?

one thing bothering me is that we are using the load of a single CPU
in wake_affine_weight(), but we are actually scanning
the whole LLC afterwards.

>
> Legend: foo_run/load:foo->nr_running:cpu_load(foo)
>
> Every migration to CPU7 in the above was due to wake_affine_weight()
> seeing more or less static effective load numbers (the trace was wider,
> showing which path was taken).
>
> > I am wondering if this should be the responsibility of wake_wide()?
>
> That's a good point.  I'm not so sure that would absolve use of what
> appears to be stagnant state though.  If we hadn't gotten there, this
> stack obviously wouldn't have happened.. but we did get there, and
> state that was used did not reflect reality.  wake_wide() deflecting
> this particular gaggle wouldn't improved state accuracy one whit for a
> subsequent wakeup, or?
>
>         -Mike

Thanks
barry
