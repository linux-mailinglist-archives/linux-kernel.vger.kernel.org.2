Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75023370DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhCKLJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:09:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:44370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbhCKLJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:09:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615460956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Ftb4gg7aNzOFmaBhKRMtFjVDjZpix86WNXDo3VsIpM=;
        b=TEB0emmNTwLphzFCW5mCrb6GRxhndTYFCHtZn9z7EFbHx5KgICDlDzhZHOUzQNksX4aGfZ
        36L/3kX5dBoVGnMvkZMQV5hOiPRdoZfroHqtaleJIP3UjgAnnKSk6kxGDJmKQV6MqOuGJ5
        nUqe+9rfadyyqC5zPHWIP0JoSaswsyc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C201AB8C;
        Thu, 11 Mar 2021 11:09:16 +0000 (UTC)
Date:   Thu, 11 Mar 2021 12:09:15 +0100
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
Message-ID: <YEn6W0RcjNiP0N0P@dhcp22.suse.cz>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
 <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
 <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-03-21 10:52:50, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 10:44:56AM +0100, Michal Hocko wrote:
> > On Thu 11-03-21 10:32:24, Peter Zijlstra wrote:
> > > The whole changelog reads like a trainwreck, but akpm already commented
> > > on that. I picked out a small factual incorrectness, simply because if
> > > you can't get that right, the whole argument looses weight.
> > 
> > Is there any reason why in_atomic || irq_disabled wouldn't work
> > universally?
> 
> I just explained to you how you really wanted:
> 
>   in_atomic() && !irq_disabled()

Sorry for being dense but I do not follow. You have provided the
following example
  spin_lock(&A);
  <IRQ>
        spin_lock(&A);

if A == hugetlb_lock then we should never reenter with
free_huge_page
	if (in_atomic() || irq_disabled())
		schedule_in_wq();
	else
		free_directly()

because hugetlb_lock is never held in irq context other than from
put_page (aka the above) path which will explicitly defer the handling and
thus the lock to a different context. We need to check for irq_disabled
because of the sleeping paths in the freeing path. Or do I miss
something?

From the code simplicity POV (and hugetlb has grown a lot of complexity)
it would be really easiest to make sure __free_huge_page to be called
from a non-atomic process context. There are few ways to do that
- defer each call to a WQ - user visible which sucks
- defer from atomic or otherwise non-sleeping contextx - requires
  reliable in_atomic AFAICS
- defer sleeping operations - makes the code flow more complex and it
  would be again user visible in some cases.

So I would say we are in "pick your own poison" kind of situation.
-- 
Michal Hocko
SUSE Labs
