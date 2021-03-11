Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254073371ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhCKMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:02:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhCKMCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:02:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615464143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M+OxKdOwj9xa7tsZOhdYegq5nkjAQ3QXloTE+/Q9m0Y=;
        b=bPhG46sHrlmPCblpOdNr0xZ4mQ+YEg0IM10HMhpAdQ0z6Mb/PjyxiQf3LQ+nUk9h2qdyYr
        6bJJ3bC+Ibkthe/mH4bphIJeADBf36GsRcn7UwdQ4ZalXDhAWtt9/449m4RXUpzJC2xa9t
        bi1iVLUPORSbfdIIKbE2JNH3tATn6Xc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E619AC17;
        Thu, 11 Mar 2021 12:02:23 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:02:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEoGyQJucV6FV3zY@dhcp22.suse.cz>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-03-21 12:36:51, Peter Zijlstra wrote:
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

OK, then I understand your point now. I thought you were arguing
an actual deadlock scenario. As I've said irq_disabled check would be
needed for sleeping operations that we already do.

> Also, Linus hates constructs like this:
> 
>   https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com
> 
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

Fair enough. As I've said I am not a great fan of this patch either
but it is a quick fix for a likely long term problem. If reworking the
hugetlb locking is preferable then be it.
-- 
Michal Hocko
SUSE Labs
