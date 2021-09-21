Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE541301C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhIUIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhIUIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cn0TlieJ6NqyZSbRzL4EEQ9YqnALBn3d6Hvhye2Y3L8=; b=Rx5+Nf7Wq2OXvqg+94ZQdQjphK
        KZY6IPbo3pi+DPIBTjc6ln5fufiSKq9s0RzsPVEtZvgzbAoUJBPIThgpjfiWtC9k/sliZZXVldOQs
        YUeifDvr043uzyhMcSp1caSjCZSxUOLK4B/H6e+YZWClmmRuEvvFspvfBzHMKLraG524Can8F7/T9
        c2p6oKk+tilpSY8MM6ohGNrEEv/Ix1dahO+dVy1I+Mm9BXHMTJwj5gILiuLfRbRZlTITJYARakLxx
        9JVWBjLWG4LCF3F+22r8oIPGFbIdTeQRJVjA/koULKBs0fZPxT+BpaUWgE18X/dvi1FTBWJDCJ6UF
        u9EB661g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSb1l-003dD4-76; Tue, 21 Sep 2021 08:21:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DD64300252;
        Tue, 21 Sep 2021 10:21:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B805213969B1; Tue, 21 Sep 2021 10:21:19 +0200 (CEST)
Date:   Tue, 21 Sep 2021 10:21:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Remove redundant lookup of rq in
 check_preempt_wakeup
Message-ID: <YUmV/7puqVrYPfyL@hirez.programming.kicks-ass.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-2-mgorman@techsingularity.net>
 <CAKfTPtBTL+KTJdEWv=-6OF8mFvnWUQ1PWKufzhKOASzMcUbnww@mail.gmail.com>
 <20210921075309.GK3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921075309.GK3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 08:53:09AM +0100, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 09:21:16AM +0200, Vincent Guittot wrote:
> > On Mon, 20 Sept 2021 at 16:26, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > The rq for curr is read during the function preamble, remove the
> > > redundant lookup.
> > >
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index ff69f245b939..038edfaaae9e 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7190,7 +7190,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> > >         if (cse_is_idle != pse_is_idle)
> > >                 return;
> > >
> > > -       update_curr(cfs_rq_of(se));
> > > +       update_curr(cfs_rq);
> > 
> > se can have been modified by find_matching_se(&se, &pse)
> > 
> 
> I still expected the cfs_rq to be the same, particularly given that the
> context is about preempting the current task on a runqueue. Is that
> wrong?

Yes. There's a cfs_rq for every se. What we do in find_matching_se() is
walk up the hiarachy until both are in the same cfs_rq, otherwse we
cannot compare them.

Fundamentally this means the effective cfs_rq also changes.
