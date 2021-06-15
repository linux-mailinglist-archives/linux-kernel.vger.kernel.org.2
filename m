Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752263A8C87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFOXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:33:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4E6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:30:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id r19so640260qvw.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiBulhyHEqL7H3uqc5V/LUZYaDanCYUuO5RpzcXg368=;
        b=LxliHIJ5ujEeuMA2FXLHuWsLMym8teFf+Msxt6R+2yI21t/9Kk1Ov9RfruPxnK5Z2g
         faYmFOHpTpqKE3owCJncWnmIg2t5fud5gYkEFAHCy4A2XoeiIDV+DXEu644cCeTEIbDO
         75jAvsRF/OA1tTBaXF0rEVjC5+i8GUGzQ7dGOCs1Ev/3V3GnbuuUGgvlSyoflLsmuZDh
         GjaMuJpeo6XFGyroJXuUaxaDLAyKoYfSO0l5KB22nVbXDBGc52p3N7dbpmCqks287Wrh
         fxCN0PXukK0re5URKFJK9EKFY+jCEs/dSGossooLfSB++Nh9YtnQPuaFmYj5i9m/Utoa
         kfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiBulhyHEqL7H3uqc5V/LUZYaDanCYUuO5RpzcXg368=;
        b=hcLFKpQYurQLX60n4ApqWaUU+zXRmYIeQ/ZXMfgGHuTWigz7dll4PAWjXZI8whWVdK
         V9sXNR0o5InRWgJqoMZBkvsuiKql0xBzNok3KCcYg0nlfD6P2wEtNMZSlnoXWlxBEVdk
         KDZMhpkhTXKW2ResRnSrAb6E1ZLP03ARVE+BRGWV/m1oEojwczrIfJgpqnjeGKMstCYA
         giJ0EzHwJfImps4tc3HpfIWmrQw/DnVWbhWcDsgodDSkwPGLD5xVuRe423KSJYcw+Xlp
         hYJkwcqlPIDZsErQK57UBpFpdMlf1OOlwqQq4Z00uXoSghDSkorgCodO7vmPEXeangAe
         VF5A==
X-Gm-Message-State: AOAM531yi16dkyN/h6VPFk9SykzcjxXBf+Uc7oV5gSdvQPS/7yK9/6gz
        hT/Nb/sezSsqTe95GpIkFW17MIjIg1zNawNypzyEKg==
X-Google-Smtp-Source: ABdhPJxYto4Tm3pE1FLT21PwVUUWqHFlBnlvUy0Vbl4X8uzwQ5ITYK+j6I73Sf/qW2U8pYES5lG0XvYwpsWl5AqC5Sk=
X-Received: by 2002:a05:6214:1c0d:: with SMTP id u13mr8047555qvc.49.1623799854221;
 Tue, 15 Jun 2021 16:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
 <CABk29Nu=mxz3tugjhDV9xCF7DRsMi9U747H+BqubviEva36RUw@mail.gmail.com>
 <7222c20a-5cbb-d443-a2fd-19067652a38e@arm.com> <CABk29NtVRG8cotfbK=R0kKXuKCnkEG514H=6ncri=CM8Qr9uiQ@mail.gmail.com>
 <f48b5233-ce60-7e1a-02e6-1bfbcc852271@arm.com>
In-Reply-To: <f48b5233-ce60-7e1a-02e6-1bfbcc852271@arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 15 Jun 2021 16:30:43 -0700
Message-ID: <CABk29NvX8-kygVSB2ePNUsnebThyijrSfjxcEPft9kUfNm01cQ@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 3:07 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 12/06/2021 01:34, Josh Don wrote:
> > On Fri, Jun 11, 2021 at 9:43 AM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 10/06/2021 21:14, Josh Don wrote:

[snip]

> > Setting cpu.idle carries additional properties in addition to just the
> > weight. Currently, it primarily includes (a) special wakeup preemption
> > handling, and (b) contribution to idle_h_nr_running for the purpose of
> > marking a cpu as a sched_idle_cpu(). Essentially, the current
> > SCHED_IDLE mechanics. I've also discussed with Peter a potential
> > extension to SCHED_IDLE to manipulate vruntime.
>
> Right, I forgot about (b).
>
> But IMHO, (a) could be handled with this special tg->shares value for
> SCHED_IDLE.
>
> If there would be a way to open up `cpu.weight`, `cpu.weight.nice` (and
> `cpu,shares` for v1) to take a special value for SCHED_IDLE, then you
> won't need cpu.idle.
> And you could handle the functionality from sched_group_set_idle()
> directly in sched_group_set_shares().
> In this case sched_group_set_shares() wouldn't have to be rejected on an
> idle tg.
> A tg would just become !idle by writing a different cpu.weight value.
> Currently, if you !idle a tg it gets the default NICE_0_LOAD.
>
> I guess cpu.weight [1, 10000] would be easy, 0 could be taken for that
> and mapped into weight = WEIGHT_IDLEPRIO (3, 3072) to call
> sched_group_set_shares(..., scale_load(weight).
> cpu.weight = 1 maps to (10, 10240)
>
> cpu.weight.nice [-20, 19] would be already more complicated, 20?
>
> And for cpu.shares [2, 2 << 18] 0 could be used. The issue here is that
> WEIGHT_IDLEPRIO (3, 3072) is a valid value already for shares.
>
> > We set the cgroup weight here, since by definition SCHED_IDLE entities
> > have the least scheduling weight. From the perspective of your
> > question, the analogous statement for tasks would be that we set task
> > weight to the min when doing setsched(SCHED_IDLE), even though we
> > already have a renice mechanism.
>
> I agree. `cpu.idle = 1` is like setting the task policy to SCHED_IDLE.
> And there is even the `cpu.weight.nice` to support the `task - tg`
> analogy on nice values.
>
> I'm just wondering if integrating this into `cpu.weight` and friends
> would be better to make the code behind this easier to grasp.

Might be confusing that we manipulate cgroup SCHED_IDLE via special
weight/weight.nice values, whereas task SCHED_IDLE is manipulated via
setsched (and we would allow nice 20 for cgroups but not for tasks,
for example).

More importantly, I think it would be better to avoid unintentional
side effects caused by overloading the weight interfaces. Thoughts on
that?

Another (less compelling) reason for the separate interface is that it
allows further extension. For example, negative values in cpu.idle
could indicate increasingly more latency-sensitive cgroups, which
could benefit from better wakeup preemption, entity placement, etc.
