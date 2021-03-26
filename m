Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1D34AEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCZSlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:41:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE4C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TsiRdeKzRsG4Z2g+Zz4rAZb4ON63WEu5uxLHvST4XKk=; b=aYx3J8Awh3de0QfwmcAmq/EAfM
        xgcQNaHoaDYkTZSJpWvNBEUlLTJZEaYVGci6GOfVKxYl46usr2gU9f6tiiuDgUvNFLzNeqy4M/O6m
        rO7FWD/fG5XApFNSjzB324/6GTHwIM516Q9hbvffGE68ZR3d1dBdXDBgroeydktISFiJpXfooZ3+M
        n+LjgCZxU4rdm46r/YRVlcEH/yYBpwYevUm/GOFQyKlpT7+gg3Pcy/8/dYxVSswsR64OFCvjFcG3L
        XAuC1sRh3oKHLVm5wjMGlAoRifwSDTf1YeNTAYc43Ah5Zea98AN144k3FPV1nunDROJPj0tSPkSyb
        WPjymyKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPrOc-0049g8-Kc; Fri, 26 Mar 2021 18:41:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B91B981045; Fri, 26 Mar 2021 19:41:22 +0100 (CET)
Date:   Fri, 26 Mar 2021 19:41:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] sched/psi.c: Rudimentary typo fixes
Message-ID: <20210326184122.GO4746@worktop.programming.kicks-ass.net>
References: <20210326124233.7586-1-unixbhaskar@gmail.com>
 <YF4hMn4rCftcdsSm@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF4hMn4rCftcdsSm@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:00:18PM -0400, Johannes Weiner wrote:
> On Fri, Mar 26, 2021 at 06:12:33PM +0530, Bhaskar Chowdhury wrote:
> > 
> > s/possible/possible/
> > s/ exceution/execution/
> > s/manupulations/manipulations/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> >  kernel/sched/psi.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 967732c0766c..316ebc57a115 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -59,7 +59,7 @@
> >   * states, we would have to conclude a CPU SOME pressure number of
> >   * 100%, since *somebody* is waiting on a runqueue at all
> >   * times. However, that is clearly not the amount of contention the
> > - * workload is experiencing: only one out of 256 possible exceution
> > + * workload is experiencing: only one out of 256 possible execution
> 
> I thought this was the french spelling.
> 
> Joking aside, the corrections look right, but I also had no trouble
> understanding what those sentences mean. Typos happen, plus we have a
> lot of non-native speakers who won't use perfect spelling or grammar.
> 
> So for me, the bar is "this can be easily understood", not "needs to
> be perfect English", and I'd say let's skip patches like these unless
> they fix something truly unintelligble.

Ignore this robot, lots of people already have a special mail rule for
him. On top of that, this spelling mistake was already fixed by Ingo in:

 3b03706fa621 ("sched: Fix various typos")

Which is part of a series of such patches to head off the endless,
mindless, stream of this.
