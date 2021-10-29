Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6749443F820
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJ2HwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhJ2HwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:52:04 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432DC061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 00:49:36 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t127so22025753ybf.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bu7YxSYqr/X6X0+/GirTZqKgt8kA95BIgwyeiAdSqIE=;
        b=e1Uv7clmPQpOZv7v9E5hHYk9hlMC+7EA/McfE10vBCyLxrpucszaoylLPCbSh9AM+s
         bVYMYZcjzrZfW7sHhcf93iAR4CNLGvmdV5dP92fiHUPTvGl4jG0sozWOzxqyz0Ibku1f
         eiV6EWIRSQyhXdZw1KKF7wXUtAWJTHNYhDLMFJuIBm/x/kwszSwWCOwl+8Gs4IjhFCFQ
         p+B7+nPs119AF3MaeC0F/q2lIFjeoCCeYwhLVLnQSrmqaxNx65fnM1GTzlnyweXVhYMv
         PaFiKf2AEbZLVMXpIkw4d3Hf9bFELGAhXTjX/qWmA5Y9vre7z2ps4su1R4DtCATMCxMl
         rJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bu7YxSYqr/X6X0+/GirTZqKgt8kA95BIgwyeiAdSqIE=;
        b=imbRxbxUC60smAhn9M+F+b1wMT93NJOUTqhw7yOZ6NZ8dG9apiCBTJ5G+A0GJ5D0DK
         ldml9MR7VOgEJkStAvoZB2ceznSVlR60BfOPd+34RZI3X6BuzQ4X2EJ0H6UNBlEUA+p/
         bn0XFj7bMDvpv9lma+1I3xPkWrR1EhfUH5DWYZbnCmq0xDHYTKw1wvMnKApoX42FAZR2
         dmAgCoL3C5FFHN8Jkz1c6tpfGpgta6U/aMYFNqaSUEbqiSv6zadIh5NuftagEHSyR77A
         ij9IgkwmoHAPy9SBaNZAm6RSbCZQeDO0eSH/NsFB/+IzrL5vjrDHbjBwjXgupORORJfQ
         UYlA==
X-Gm-Message-State: AOAM5310QSylPIFUfrrSr8Hk8oxSQ9ADem1J0JJ8GHz9Zdl5GKR2qICu
        j20y77JbzXe9FZV3pUx9JV6qaoewD3DNQb8SQwE00g==
X-Google-Smtp-Source: ABdhPJziWAVDOLFMdcClURVpA7fBms+DG6dniAQwaERPngRdX3jhxm7x8h2Wxp4pRopFM6AmGZ45S5QYV95Rfl/hlPw=
X-Received: by 2002:a05:6902:727:: with SMTP id l7mr10622983ybt.259.1635493775227;
 Fri, 29 Oct 2021 00:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org> <YXsxXqkLx+fKA1Ab@google.com>
In-Reply-To: <YXsxXqkLx+fKA1Ab@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 29 Oct 2021 09:49:23 +0200
Message-ID: <CAKfTPtD8Djqg=kDCmoniXr+KASt7-zQ2f-9Fy9ey-WmV5XEH=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joelaf@google.com, dianders@google.com,
        qais.yousef@arm.com, Chris.Redpath@arm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 01:25, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi,  Vincent, Peter,
>
> On Tue, Oct 19, 2021 at 02:35:32PM +0200, Vincent Guittot wrote:
> > This patchset updates newidle lb cost tracking and early abort:
> >
> > The time spent running update_blocked_averages is now accounted in the 1st
> > sched_domain level. This time can be significant and move the cost of
> > newidle lb above the avg_idle time.
> >
> > The decay of max_newidle_lb_cost is modified to start only when the field
> > has not been updated for a while. Recent update will not be decayed
> > immediatlybut only after a while.
> >
> > The condition of an avg_idle lower than sysctl_sched_migration_cost has
> > been removed as the 500us value is quite large and prevent opportunity to
> > pull task on the newly idle CPU for at least 1st domain levels.
>
> It appears this series is not yet in upstream Linus's tree. What's the latest on it?
>

I sent an addon yesterday to cover cases that Tim cares about

> I see a lot of times on ARM64 devices that load balance is skipped due to the
> high the sysctl_sched_migration_cost. I saw another thread as well where

Have you tested the patchset ? Does it enable more load balance on
your platform ?

> someone complained the performance varies and the default might be too high:
> https://lkml.org/lkml/2021/9/14/150

Added  Yicong and Barry in the list

>
> Any other thoughts? Happy to help on any progress on this series as well. Thanks,
>
>  - Joel
>
> >
> > Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> > THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> > following results:
> >        min    avg   max
> > SMT:   1us   33us  273us - this one includes the update of blocked load
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
> > Change since v2:
> > - Update and decay of sd->last_decay_max_lb_cost are gathered in
> >   update_newidle_cost(). The behavior remains almost the same except that
> >   the decay can happen during newidle_balance now.
> >
> >   Tests results haven't shown any differences
> >
> >   I haven't modified rq->max_idle_balance_cost. It acts as the max value
> >   for avg_idle and prevents the latter to reach high value during long
> >   idle phase. Moving on an IIR filter instead, could delay the convergence
> >   of avg_idle to a reasonnable value that reflect current situation.
> >
> > - Added a minor cleanup of newidle_balance
> >
> > Change since v1:
> > - account the time spent in update_blocked_averages() in the 1st domain
> >
> > - reduce number of call of sched_clock_cpu()
> >
> > - change the way max_newidle_lb_cost is decayed. Peter suggested to use a
> >   IIR but keeping a track of the current max value gave the best result
> >
> > - removed the condition (this_rq->avg_idle < sysctl_sched_migration_cost)
> >   as suggested by Peter
> >
> > Vincent Guittot (5):
> >   sched/fair: Account update_blocked_averages in newidle_balance cost
> >   sched/fair: Skip update_blocked_averages if we are defering load
> >     balance
> >   sched/fair: Wait before decaying max_newidle_lb_cost
> >   sched/fair: Remove sysctl_sched_migration_cost condition
> >   sched/fair: cleanup newidle_balance
> >
> >  include/linux/sched/topology.h |  2 +-
> >  kernel/sched/fair.c            | 65 ++++++++++++++++++++++------------
> >  kernel/sched/topology.c        |  2 +-
> >  3 files changed, 45 insertions(+), 24 deletions(-)
> >
> > --
> > 2.17.1
> >
