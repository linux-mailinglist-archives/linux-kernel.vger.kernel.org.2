Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57F1440351
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJ2Tjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2Tje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:39:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED000C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:37:05 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a132so9341701qkg.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mwCYD5mtFeuXzWMFxcaV8U0aIlpIDC8IRXBnth9aMGI=;
        b=eLYjvPXW8u1AcI1CLbbPMdR+GJvaUsVWVG3AAn8ysBpHKZ1xy/i8tvXcNlB1+av/0j
         CcAWmcmMpD7tgwnke2/jxBkBhQnilD41cIoXBTGer6dhnyxriL6fARjp6Qsb5JRrv++y
         YU6ct5jwCNq7SLNdWsHNMENvt03ARme9AivXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwCYD5mtFeuXzWMFxcaV8U0aIlpIDC8IRXBnth9aMGI=;
        b=sSsIof4bcowKhUm1TgKJfCKvWLq+GkMN7FamB7RVirUU4vCYtvclD2Dxsyxx2ECHgY
         ZmQV0TDRz6Ao1LyE+abMR6kSbYrF3xBVF1YjnspSxYL/jGaBP0FspfhNj//49xNqpN8m
         efxpx7zUGCcHPylzwLEocoxZ9NvP50RQjuVaoD8Qm90VAQ2L00wUe5id7tgyo4LFMyku
         UcSFf+FAjE2S4XNsSwfE159IHgePw0RZ3tXdibABOieP2nfP/C7Hs62smZ+Ef1dNF9WR
         gGVA7uQR0mA6h1SUqRQcgUr66x69t0AzlRu2afgUAwGXpIadfXzQ1hCPuILGAWke9JRp
         XjCw==
X-Gm-Message-State: AOAM530efJhxcuLxmQa16jThqgj7VPxhEPqenGsNrusMA8Rx6U7ST2My
        kR5yLN9Un+GJj3Z+f8DdG7EjPw==
X-Google-Smtp-Source: ABdhPJx03jC6JWIBfyuRVCS13OqBeWyI0cDv6mNMxAbEfpzvvLj59dBc7t6KptrAKx8EkgITVZxQnQ==
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr10690340qkc.321.1635536225078;
        Fri, 29 Oct 2021 12:37:05 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:a1ce:c34e:d65e:c964])
        by smtp.gmail.com with ESMTPSA id i22sm4948727qkn.80.2021.10.29.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:37:04 -0700 (PDT)
Date:   Fri, 29 Oct 2021 15:37:04 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, dianders@google.com,
        qais.yousef@arm.com, Chris.Redpath@arm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
Message-ID: <YXxNYG6kfyXHP6J6@google.com>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <YXsxXqkLx+fKA1Ab@google.com>
 <CAKfTPtD8Djqg=kDCmoniXr+KASt7-zQ2f-9Fy9ey-WmV5XEH=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD8Djqg=kDCmoniXr+KASt7-zQ2f-9Fy9ey-WmV5XEH=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Oct 29, 2021 at 09:49:23AM +0200, Vincent Guittot wrote:
> On Fri, 29 Oct 2021 at 01:25, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi,  Vincent, Peter,
> >
> > On Tue, Oct 19, 2021 at 02:35:32PM +0200, Vincent Guittot wrote:
> > > This patchset updates newidle lb cost tracking and early abort:
> > >
> > > The time spent running update_blocked_averages is now accounted in the 1st
> > > sched_domain level. This time can be significant and move the cost of
> > > newidle lb above the avg_idle time.
> > >
> > > The decay of max_newidle_lb_cost is modified to start only when the field
> > > has not been updated for a while. Recent update will not be decayed
> > > immediatlybut only after a while.
> > >
> > > The condition of an avg_idle lower than sysctl_sched_migration_cost has
> > > been removed as the 500us value is quite large and prevent opportunity to
> > > pull task on the newly idle CPU for at least 1st domain levels.
> >
> > It appears this series is not yet in upstream Linus's tree. What's the latest on it?
> >
> 
> I sent an addon yesterday to cover cases that Tim cares about

Oh ok, I'll check it out. Thanks for letting me know.

> > I see a lot of times on ARM64 devices that load balance is skipped due to the
> > high the sysctl_sched_migration_cost. I saw another thread as well where
> 
> Have you tested the patchset ? Does it enable more load balance on
> your platform ?

Yes I tested and noticed load balance happening more often. I ran some
workloads noticed it makes things smoother. I am doing more tests as well.

Also, we need this series to fix the update_blocked_averages() latency issues
and I verified that preemptoff tracer does not show same high latency with
this series.

thanks,

 - Joel

> > someone complained the performance varies and the default might be too high:
> > https://lkml.org/lkml/2021/9/14/150
> 
> Added  Yicong and Barry in the list
> 
> >
> > Any other thoughts? Happy to help on any progress on this series as well. Thanks,
> >
> >  - Joel
> >
> > >
> > > Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> > > THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> > > following results:
> > >        min    avg   max
> > > SMT:   1us   33us  273us - this one includes the update of blocked load
> > > MC:    7us   49us  398us
> > > NUMA: 10us   45us  158us
> > >
> > >
> > > Some results for hackbench -l $LOOPS -g $group :
> > > group      tip/sched/core     + this patchset
> > > 1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
> > > 4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
> > > 16           3.654(+/- 1%)        2.922(+/- 3%) +20%
> > > 32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
> > > 64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
> > > 128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
> > > 256          2.951(+/- 1%)        2.894(+/- 1%)  +2%
> > >
> > > tbench and reaim have not shown any difference
> > >
> > > Change since v2:
> > > - Update and decay of sd->last_decay_max_lb_cost are gathered in
> > >   update_newidle_cost(). The behavior remains almost the same except that
> > >   the decay can happen during newidle_balance now.
> > >
> > >   Tests results haven't shown any differences
> > >
> > >   I haven't modified rq->max_idle_balance_cost. It acts as the max value
> > >   for avg_idle and prevents the latter to reach high value during long
> > >   idle phase. Moving on an IIR filter instead, could delay the convergence
> > >   of avg_idle to a reasonnable value that reflect current situation.
> > >
> > > - Added a minor cleanup of newidle_balance
> > >
> > > Change since v1:
> > > - account the time spent in update_blocked_averages() in the 1st domain
> > >
> > > - reduce number of call of sched_clock_cpu()
> > >
> > > - change the way max_newidle_lb_cost is decayed. Peter suggested to use a
> > >   IIR but keeping a track of the current max value gave the best result
> > >
> > > - removed the condition (this_rq->avg_idle < sysctl_sched_migration_cost)
> > >   as suggested by Peter
> > >
> > > Vincent Guittot (5):
> > >   sched/fair: Account update_blocked_averages in newidle_balance cost
> > >   sched/fair: Skip update_blocked_averages if we are defering load
> > >     balance
> > >   sched/fair: Wait before decaying max_newidle_lb_cost
> > >   sched/fair: Remove sysctl_sched_migration_cost condition
> > >   sched/fair: cleanup newidle_balance
> > >
> > >  include/linux/sched/topology.h |  2 +-
> > >  kernel/sched/fair.c            | 65 ++++++++++++++++++++++------------
> > >  kernel/sched/topology.c        |  2 +-
> > >  3 files changed, 45 insertions(+), 24 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
