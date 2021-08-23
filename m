Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C03F5379
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhHWWpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:45:40 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52497C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:44:57 -0700 (PDT)
Date:   Tue, 24 Aug 2021 06:45:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629758694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IehAjYy8xWpIrZ4zT6FrRFX1lwCljbExJgIF9V68fgc=;
        b=PQwbnrmxZ53/l2mopfN68KU/jSMZA5mfYhkWr4ocMToNeMLsqAaIVUahFuXkc1bQlhJlLn
        3HKtzTA97NpdIcuk/0mxTPonywJKCuREQa3QrjVrS1QPg/f7EsxixVTrTibILzWtW1+CDm
        K3RAwLpbE6hC3QBDCSWtML5AuR2oU0c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, tao.zhou@linux.dev
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
Message-ID: <YSQlGEnpblfpeQpE@geo.homenetwork>
References: <20210820010403.946838-1-joshdon@google.com>
 <20210820010403.946838-2-joshdon@google.com>
 <YR9qRta78uYXSva6@geo.homenetwork>
 <CABk29NvH6_JoLydcrJf+yiaasGUbNEjzKdPjZxnWdrAFboJdsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvH6_JoLydcrJf+yiaasGUbNEjzKdPjZxnWdrAFboJdsg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Mon, Aug 23, 2021 at 10:29:53AM -0700, Josh Don wrote:
> Hi Tao,
> 
> On Fri, Aug 20, 2021 at 1:38 AM Tao Zhou <tao.zhou@linux.dev> wrote:
> [snip]
> > >  #ifdef CONFIG_SMP
> > >  extern void set_task_rq_fair(struct sched_entity *se,
> > >                            struct cfs_rq *prev, struct cfs_rq *next);
> > > @@ -601,6 +606,9 @@ struct cfs_rq {
> > >       struct list_head        leaf_cfs_rq_list;
> > >       struct task_group       *tg;    /* group that "owns" this runqueue */
> > >
> > > +     /* Locally cached copy of our task_group's idle value */
> > > +     int                     idle;
> > > +
> > >  #ifdef CONFIG_CFS_BANDWIDTH
> > >       int                     runtime_enabled;
> > >       s64                     runtime_remaining;
> > > --
> > > 2.33.0.rc2.250.ged5fa647cd-goog
> > >
> >
> > Cfs_rq and tg define @idle with int type.
> > In sched_group_set_idle(..., long idle), @idle is long type.
> > Use int instead.
> >
> > But, you filter idle value:
> >
> >     if (idle < 0 || idle > 1)
> >         return -EINVAL;
> >
> > So, no effect here.. Just @idle can use 4 bytes.
> >
> >
> >
> > Thanks,
> > Tao
> 
> The use of 'long'  there is because the input from the cgroup
> interface is a 64 bit value.

Yes. If the compile align the stack to 8 or other, this will have 
no effect(I've not check this, and have not much about gcc compile
align). I just presume that if the stack can save 4 bytes. But, 
that may not right though.

> - Josh



Thanks,
Tao
