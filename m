Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A854336F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhCKJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:45:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:32770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhCKJo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:44:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615455896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPGMgeu1sq1z6aVRCxKf0fbmN46tuuOHRNw/lUzEVpQ=;
        b=ATvk+YnYvkBs+GAbqbrri42v+ydF2YXmq9mRLrTFeI1bI5oL48J/nA4AiIwdNSMh7ZMKgI
        XNYd/qO8PVUOK3UBnwS6fkYek8Lh/uY58U3vHJ9UczcgfukHqSX5vPKxYmwUpI6dcd8RUL
        kx0ATR7BmwCQ2Fyh3e3vENW4kniVbjU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B62AFAB8C;
        Thu, 11 Mar 2021 09:44:56 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:44:56 +0100
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
Message-ID: <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-03-21 10:32:24, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 10:01:22AM +0100, Michal Hocko wrote:
> > On Thu 11-03-21 09:46:30, Peter Zijlstra wrote:
> > > On Wed, Mar 10, 2021 at 06:13:21PM -0800, Mike Kravetz wrote:
> > > > from irq context.  Changing the check in the code from !in_task to
> > > > in_atomic would handle the situations when called with irqs disabled.
> > > 
> > > It does not. local_irq_disable() does not change preempt_count().
> > 
> > You are right. Earlier I was suggesting to check of irq_disabled() as
> > well http://lkml.kernel.org/r/YD4I+VPr3UNt063H@dhcp22.suse.cz
> > 
> > back then it was not really clear to me that in fact we do care about
> > spin locks more than irq disabled code. I am not even sure whether we
> > need to care about irq disabled regions without any locks held that
> > wouldn't be covered by in_atomic. But it would be safer to add
> > irq_disabled check as well.
> 
> Safer still is always doing it, replace it with if (true).
> 
> What's the purpose, doing the minimal 'correct', of the maximal safe
> solution?

If we always defer to a WQ context then an admin wouldn't have any
feedback from the syscall when releasing the pool.

> The whole changelog reads like a trainwreck, but akpm already commented
> on that. I picked out a small factual incorrectness, simply because if
> you can't get that right, the whole argument looses weight.

Is there any reason why in_atomic || irq_disabled wouldn't work
universally?

> That said, I don't think you actually need it, if as you write the lock
> should be IRQ-safe, then you're worried about the IRQ recursion
> deadlock:

making hugetlb_lock irqsafe is a long way as explained by Mike
elsewhere. Not only that. The upcoming hugeltb feature to have sparse
vmemmap for hugetlb pages will need to allocate vmemmap when hugetlb
page is to be freed back to the allocator. That cannot happen in any
atomic context so there will be a need to tell those contexts for
special casing.

-- 
Michal Hocko
SUSE Labs
