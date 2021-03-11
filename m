Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B386337B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCKRvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhCKRuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:50:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB68264F93;
        Thu, 11 Mar 2021 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615485055;
        bh=QDASRPXhjMA2e2jMibB5HEDLwOxOvU8zcbAAQZpaVqo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Hivnwp2FLA5U5LKOicyIaWSwa0af7vR6EsRbFWoJQV9T+kng1fdB9O9MfgD1ld1Jl
         Dm6oqKl4JNqQG8RNC4YUIXiuh6PNisuZqgXpeEJ6MtlBCKFX0EyLlziajiwXWVh3l2
         DLb1yQagXkxMNzqUKZ574csqvn9Ma/fLwJUnT5QmoUCdXBieE9Wsqxbl9bsIDSmgzO
         RNkkHWW7BrNDvpq8v+Iay5VSynwZreUmtp1koNN4PmlZBAf2k1yUpltelbvscWiv/D
         sHBIhVI3Dr0oPUD2SHZxd24kU60KLVuiKK7/bK///sRyrZSja5VTls2wYxmAYfwl95
         MblZMEA0TM9yQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80CF83523945; Thu, 11 Mar 2021 09:50:54 -0800 (PST)
Date:   Thu, 11 Mar 2021 09:50:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        tglx@linutronix.de, john.ogness@linutronix.de, urezki@gmail.com,
        ast@fb.com, Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <20210311175054.GA2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
 <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
 <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
 <YEn6W0RcjNiP0N0P@dhcp22.suse.cz>
 <YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:36:51PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 12:09:15PM +0100, Michal Hocko wrote:
> 
> > Sorry for being dense but I do not follow. You have provided the
> > following example
> >   spin_lock(&A);
> >   <IRQ>
> >         spin_lock(&A);
> > 
> > if A == hugetlb_lock then we should never reenter with
> > free_huge_page
> 
> What I'm saying is that if irq_disabled(), the that interrupt cannot
> happen, so the second spin_lock cannot happen, so the deadlock cannot
> happen.
> 
> So: '!irqs_disabled() && in_atomic()' is sufficient to avoid the IRQ
> recursion deadlock.
> 
> Also, Linus hates constructs like this:
> 
>   https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com

To be fair, later in that same thread Linus states that his main concern
is not core code, but rather driver code:

https://lore.kernel.org/lkml/CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com/

Nevertheless, if the job can be done reasonably without checking the
preemption/interrupt state, why not?  And Mike's patch is still useful
for people hitting this bug.

							Thanx, Paul

> > From the code simplicity POV (and hugetlb has grown a lot of complexity)
> > it would be really easiest to make sure __free_huge_page to be called
> > from a non-atomic process context. There are few ways to do that
> > - defer each call to a WQ - user visible which sucks
> > - defer from atomic or otherwise non-sleeping contextx - requires
> >   reliable in_atomic AFAICS
> > - defer sleeping operations - makes the code flow more complex and it
> >   would be again user visible in some cases.
> > 
> > So I would say we are in "pick your own poison" kind of situation.
> 
> Just to be clear:
> 
> NAK on this patch and any and all ductape crap. Fix it properly, make
> hugetlb_lock, spool->lock IRQ-safe, move the workqueue into the CMA
> thing.
> 
> The code really doesn't look _that_ complicated.
