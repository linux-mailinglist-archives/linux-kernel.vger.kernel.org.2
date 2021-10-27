Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E210543C580
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhJ0IwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbhJ0IwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:52:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:49:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r184so4444159ybc.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7v97GZsBc3GwS31cv/kL7gwWb5rRYExQxWI8jr90dtE=;
        b=hyOREpcWPyBwMLLPOzWmyNTD/+xsgrEQPeGMBwnMqQGMFdaXyt1qHpn7hRNwgc1q6m
         bwhLZlxJEDBEED6IsmT5bFPNzdkMjpJolvGL/0kuzQXNK2lI/XMAB9pnLwO63Qd/bilz
         ZAnT7/ijMsfNzGnXcbH9upiv2mkdij4oI3wCazjfi7ifZnMUfOcSxlsQCy0f6+IdW0zX
         hvJI6iCqsz35tJke6P6XFsJ5IB6hD92Y+mgvDedAEvxWPgvm8BWfyIPXgjtDtnggzfu5
         UJm9zD39UZuV7I85Eu9fidBeDXv+tgzkLjiiBI+rPQ75r+ei+D2AaS1V8c6WcAB1a/Rk
         sX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7v97GZsBc3GwS31cv/kL7gwWb5rRYExQxWI8jr90dtE=;
        b=Ue3H5O7bw0PEW7SVminYLJp4lwEifGUBl17gRTtYBhvNgUytK2LD8pM42LVZ5lC/1b
         hmo5K5sN2jR+8W1oudwox94qOJDCudNVQ0/rZbk6eqe6jwso7m7G8+IeU811ef7iVPRB
         0c8SmqUifNwnfEzs9/yrzEa7N2THPqzT6I0tZAF2/3P5t04s4MmWjCxk91MJ1zH3jRMc
         geRHcNpbT3oM6WsMIVTyRE0T3Ee+3z/B/uJ3+e3iwkRM+7IwSy5APKrArce22lJ/pzRf
         HoAriYwSvoiLYMkAWDHAjaF1qqj/fJSKJBQRP0zkcYo38wc8OccnLx/bCDLX04AOwfDw
         FVOg==
X-Gm-Message-State: AOAM531RTAaY5ev9eKFFfckjEV1NzLRE2dAlHD9UEbwYu7VD0/YbfoxL
        vwr29z9eofJ6Jli3khoWft8ksnTx4+iR5JVmqV4NaA==
X-Google-Smtp-Source: ABdhPJy2mkEG39vij7iebRTHinx1BjDFY5i9I5jjO87NMiXDtGBEbdvlQHG3HpDqkFqkjiWvHI75yTi/3P/+eRtmFBc=
X-Received: by 2002:a25:2d49:: with SMTP id s9mr30209604ybe.546.1635324587023;
 Wed, 27 Oct 2021 01:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org> <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
In-Reply-To: <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Oct 2021 10:49:35 +0200
Message-ID: <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 19:25, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Tue, 2021-10-19 at 14:35 +0200, Vincent Guittot wrote:
> > This patchset updates newidle lb cost tracking and early abort:
> >
> > The time spent running update_blocked_averages is now accounted in
> > the 1st
> > sched_domain level. This time can be significant and move the cost of
> > newidle lb above the avg_idle time.
> >
> > The decay of max_newidle_lb_cost is modified to start only when the
> > field
> > has not been updated for a while. Recent update will not be decayed
> > immediatlybut only after a while.
> >
> > The condition of an avg_idle lower than sysctl_sched_migration_cost
> > has
> > been removed as the 500us value is quite large and prevent
> > opportunity to
> > pull task on the newly idle CPU for at least 1st domain levels.
> >
> > Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> > THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> > following results:
> >        min    avg   max
> > SMT:   1us   33us  273us - this one includes the update of blocked
> > load
> > MC:    7us   49us  398us
> > NUMA: 10us   45us  158us
> >
> >
> > Some results for hackbench -l $LOOPS -g $group :
> > group      tip/sched/core     + this patchset
> > 1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
> > 4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
> > 16           3.654(+/- 1%)        2.922(+/- 3%) +20%
> > 32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
> > 64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
> > 128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
> > 256          2.951(+/- 1%)        2.894(+/- 1%)  +2%
> >
> > tbench and reaim have not shown any difference
> >
>
> Vincent,
>
> Our benchmark team tested the patches for our OLTP benchmark
> on a 2 socket Cascade Lake
> with 28 cores/socket.  It is a smaller configuration
> than the 2 socket Ice Lake we hae tested previously that has 40
> cores/socket so the overhead on update_blocked_averages is smaller
> (~4%).
>
> Here's a summary of the results:
>                                         Relative Performance
>                                         (higher better)
> 5.15 rc4 vanilla (cgroup disabled)      100%
> 5.15 rc4 vanilla (cgroup enabled)       96%
> patch v2                                96%
> patch v3                                96%
>
> We didn't see much change in performance from the patch set.

Thanks for testing.
I was not expecting this patch to fix all your problems but at least
those which have been highlighted during previous exchanges.

Few problems still remain in your case if I'm not wrong:
There is a patch that ensures that rq->next_balance is never set in the past.
IIRC, you also mentioned in a previous thread that the idle LB
happening during the tick just after the new idle balance was a
problem in your case. Which is probably linked to your figures below

>
> Looking at the profile on update_blocked_averages a bit more,
> the majority of the call to update_blocked_averages
> happens in run_rebalance_domain.  And we are not
> including that cost of update_blocked_averages for
> run_rebalance_domains in our current patch set. I think
> the patch set should account for that too.

nohz_newidle_balance keeps using sysctl_sched_migration_cost to
trigger a _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
This would probably benefit to take into account the cost of
update_blocked_averages instead

>
>
>       0.60%     0.00%             3  [kernel.vmlinux]    [k] run_rebalance_domains                                                                                                                                                  -      -
>             |
>              --0.59%--run_rebalance_domains
>                        |
>                         --0.57%--update_blocked_averages
>
> Thanks.
>
> Tim
>
