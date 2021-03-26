Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11F34AEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZSbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZSam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:30:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B113C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X3uQLAMw9mpcnPe/FGqyshXbloG5ZX2W2XuSLqsdMdg=; b=P76Xw1o0k+eQy4S9LRKMM2Pvch
        6UO3iCKRI02/7Ppq1Rc/eWIIqIRVOPDPH165ysrQYevVrpdHHImKXLM8N1GHgFRzXr4UYmzGIqzIY
        QU6DgIRpRR2H4o9uvfZKUAUV6eisGpJWe9qNmL/r+Gb8ZnTCMG/mita8Zq2YkaKd7Od/3LOJDxdo7
        JzQzgEemW1k7Abmq7QvuXEeeFfI9JBeclyJ6nBmTxab+/qKdOp1OI3VBr9j0VcM4VCGmLQ7hrJv6B
        MX6Z+bPA28zDxzXjZc7yPoeeUuoa8WJlEWb1RQf1x9T666B+K4A35B/12HFUC7ALbGTdFKB/iMFbU
        bw6u8mtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPrE1-0049Bt-Mo; Fri, 26 Mar 2021 18:30:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 741AD981045; Fri, 26 Mar 2021 19:30:24 +0100 (CET)
Date:   Fri, 26 Mar 2021 19:30:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Don <joshdon@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [PATCH 9/9] sched,fair: Alternative sched_slice()
Message-ID: <20210326183024.GM4746@worktop.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.444833549@infradead.org>
 <CAKfTPtB0NEQhuphhYXDZTQvgmLxoLFvbT17gcz6aTrdMUf-_Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB0NEQhuphhYXDZTQvgmLxoLFvbT17gcz6aTrdMUf-_Vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:37:03PM +0100, Vincent Guittot wrote:
> On Fri, 26 Mar 2021 at 11:43, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > The current sched_slice() seems to have issues; there's two possible
> > things that could be improved:
> >
> >  - the 'nr_running' used for __sched_period() is daft when cgroups are
> >    considered. Using the RQ wide h_nr_running seems like a much more
> >    consistent number.
> >
> >  - (esp) cgroups can slice it real fine, which makes for easy
> >    over-scheduling, ensure min_gran is what the name says.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/fair.c     |   15 ++++++++++++++-
> >  kernel/sched/features.h |    3 +++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -680,7 +680,16 @@ static u64 __sched_period(unsigned long
> >   */
> >  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> > -       u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
> > +       unsigned int nr_running = cfs_rq->nr_running;
> > +       u64 slice;
> > +
> > +       if (sched_feat(ALT_PERIOD))
> > +               nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
> > +
> > +       slice = __sched_period(nr_running + !se->on_rq);
> > +
> > +       if (sched_feat(BASE_SLICE))
> > +               slice -= sysctl_sched_min_granularity;
> >
> >         for_each_sched_entity(se) {
> >                 struct load_weight *load;
> > @@ -697,6 +706,10 @@ static u64 sched_slice(struct cfs_rq *cf
> >                 }
> >                 slice = __calc_delta(slice, se->load.weight, load);
> >         }
> > +
> > +       if (sched_feat(BASE_SLICE))
> > +               slice += sysctl_sched_min_granularity;
> 
> Why not only doing a max of slice and sysctl_sched_min_granularity
> instead of scaling only the part above sysctl_sched_min_granularity ?
> 
> With your change, cases where the slices would have been in a good
> range already, will be modified as well

Can do I suppose. Not sure how I ended up with this.
