Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A5337180
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhCKLhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhCKLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:37:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C29C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/DiY0qaj2nFITzHvwjqHjC1a1V0Ha/y0lvFzt5E8g24=; b=iC0lV94KTX9MteHo0vfibT3OF3
        4S1EokiPKRwOdcll9BVXXzs/pK6yXzWsMi5xEwHqMt0SfCYDc2vmbvrqsyRlL0SxDVAX3s/tfGfbt
        Twzj8rqgp3cVw/NvHgdWfkzfxHMu/mfJ/jF5OVxrdC6dLR9qc6xRviH8NtV+ilGJ8EitV9qfHguZw
        ENATc6XiNVhwYPGH2gL5naM7leQL1nUsqD6larSoD5Eb/sbv/ELATc97CtFFCkn7X6IVN0sUrEq2l
        qcEJNFiQOWEql0zW0Z4eXUD45Iz3zZBU1S68Au749edBNE2CzE5c5VrjuIQTiusfRuexm9ylttmmD
        /9jOZepQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKJca-007FvX-PF; Thu, 11 Mar 2021 11:36:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B979304D28;
        Thu, 11 Mar 2021 12:36:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72C092077BB0B; Thu, 11 Mar 2021 12:36:51 +0100 (CET)
Date:   Thu, 11 Mar 2021 12:36:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
 <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
 <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
 <YEn6W0RcjNiP0N0P@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEn6W0RcjNiP0N0P@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:09:15PM +0100, Michal Hocko wrote:

> Sorry for being dense but I do not follow. You have provided the
> following example
>   spin_lock(&A);
>   <IRQ>
>         spin_lock(&A);
> 
> if A == hugetlb_lock then we should never reenter with
> free_huge_page

What I'm saying is that if irq_disabled(), the that interrupt cannot
happen, so the second spin_lock cannot happen, so the deadlock cannot
happen.

So: '!irqs_disabled() && in_atomic()' is sufficient to avoid the IRQ
recursion deadlock.

Also, Linus hates constructs like this:

  https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com

> From the code simplicity POV (and hugetlb has grown a lot of complexity)
> it would be really easiest to make sure __free_huge_page to be called
> from a non-atomic process context. There are few ways to do that
> - defer each call to a WQ - user visible which sucks
> - defer from atomic or otherwise non-sleeping contextx - requires
>   reliable in_atomic AFAICS
> - defer sleeping operations - makes the code flow more complex and it
>   would be again user visible in some cases.
> 
> So I would say we are in "pick your own poison" kind of situation.

Just to be clear:

NAK on this patch and any and all ductape crap. Fix it properly, make
hugetlb_lock, spool->lock IRQ-safe, move the workqueue into the CMA
thing.

The code really doesn't look _that_ complicated.
