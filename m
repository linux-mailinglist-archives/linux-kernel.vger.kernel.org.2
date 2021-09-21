Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47641311E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhIUKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:04:57 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:38825 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhIUKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:04:54 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id A21F21C59C9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:03:25 +0100 (IST)
Received: (qmail 18526 invoked from network); 21 Sep 2021 10:03:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 10:03:25 -0000
Date:   Tue, 21 Sep 2021 11:03:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Remove redundant lookup of rq in
 check_preempt_wakeup
Message-ID: <20210921100323.GL3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-2-mgorman@techsingularity.net>
 <CAKfTPtBTL+KTJdEWv=-6OF8mFvnWUQ1PWKufzhKOASzMcUbnww@mail.gmail.com>
 <20210921075309.GK3959@techsingularity.net>
 <YUmV/7puqVrYPfyL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YUmV/7puqVrYPfyL@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:21:19AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 08:53:09AM +0100, Mel Gorman wrote:
> > On Tue, Sep 21, 2021 at 09:21:16AM +0200, Vincent Guittot wrote:
> > > On Mon, 20 Sept 2021 at 16:26, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > > The rq for curr is read during the function preamble, remove the
> > > > redundant lookup.
> > > >
> > > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index ff69f245b939..038edfaaae9e 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -7190,7 +7190,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> > > >         if (cse_is_idle != pse_is_idle)
> > > >                 return;
> > > >
> > > > -       update_curr(cfs_rq_of(se));
> > > > +       update_curr(cfs_rq);
> > > 
> > > se can have been modified by find_matching_se(&se, &pse)
> > > 
> > 
> > I still expected the cfs_rq to be the same, particularly given that the
> > context is about preempting the current task on a runqueue. Is that
> > wrong?
> 
> Yes. There's a cfs_rq for every se. What we do in find_matching_se() is
> walk up the hiarachy until both are in the same cfs_rq, otherwse we
> cannot compare them.
> 
> Fundamentally this means the effective cfs_rq also changes.

Ok, thanks. I'll read into this more but the patch is dead.

-- 
Mel Gorman
SUSE Labs
