Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0B336DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCKIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:20:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhCKIUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:20:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615450837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDyv33vblbOBiA6/8yIJlsYlnNvdAjdMwuO2OFe/iBg=;
        b=bdu4M1e2uQ1/9Mx8YWwJdhFnuSMmGxo+Uj/7gT721vi+BAIBHAyD+9R1dWD50UBKxTwNjH
        G18q+oGGbr+V20iDbM/8MH1Ov75D1GRAWlioNUes4tCrn6MnsZNWProoh8rqj5WIpQTcOV
        pmMunKu8aSTBBaRx+ZJkCjEv2uS8j+8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF074AB8C;
        Thu, 11 Mar 2021 08:20:36 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:20:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>, peterz@infradead.org
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEnS1EcVCGuMuhMy@dhcp22.suse.cz>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <20210310214316.6d1ffb19a4219b4e70123e19@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310214316.6d1ffb19a4219b4e70123e19@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 21:43:16, Andrew Morton wrote:
> On Wed, 10 Mar 2021 18:13:21 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > put_page does not correctly handle all calling contexts for hugetlb
> > pages.  This was recently discussed in the threads [1] and [2].
> > 
> > free_huge_page is the routine called for the final put_page of huegtlb
> > pages.  Since at least the beginning of git history, free_huge_page has
> > acquired the hugetlb_lock to move the page to a free list and possibly
> > perform other processing. When this code was originally written, the
> > hugetlb_lock should have been made irq safe.
> > 
> > For many years, nobody noticed this situation until lockdep code caught
> > free_huge_page being called from irq context.  By this time, another
> > lock (hugetlb subpool) was also taken in the free_huge_page path.  In
> > addition, hugetlb cgroup code had been added which could hold
> > hugetlb_lock for a considerable period of time.  Because of this, commit
> > c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> > context") was added to address the issue of free_huge_page being called
> > from irq context.  That commit hands off free_huge_page processing to a
> > workqueue if !in_task.
> > 
> > The !in_task check handles the case of being called from irq context.
> > However, it does not take into account the case when called with irqs
> > disabled as in [1].
> > 
> > To complicate matters, functionality has been added to hugetlb
> > such that free_huge_page may block/sleep in certain situations.  The
> > hugetlb_lock is of course dropped before potentially blocking.
> > 
> > One way to handle all calling contexts is to have free_huge_page always
> > send pages to the workqueue for processing.  This idea was briefly
> > discussed here [3], but has some undesirable side effects.
> > 
> > Ideally, the hugetlb_lock should have been irq safe from the beginning
> > and any code added to the free_huge_page path should have taken this
> > into account.  However, this has not happened.  The code today does have
> > the ability to hand off requests to a workqueue.  It does this for calls
> > from irq context.  Changing the check in the code from !in_task to
> > in_atomic would handle the situations when called with irqs disabled.
> > However, it does not not handle the case when called with a spinlock
> > held.  This is needed because the code could block/sleep.
> > 
> > Select PREEMPT_COUNT if HUGETLB_PAGE is enabled so that in_atomic can be
> > used to detect all atomic contexts where sleeping is not possible.
> > 
> > [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> > [2] https://lore.kernel.org/linux-mm/YEjji9oAwHuZaZEt@dhcp22.suse.cz/
> > [3] https://lore.kernel.org/linux-mm/YDzaAWK41K4gD35V@dhcp22.suse.cz/
> > 
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -235,6 +235,7 @@ config HUGETLBFS
> >  
> >  config HUGETLB_PAGE
> >  	def_bool HUGETLBFS
> > +	select PREEMPT_COUNT
> >  
> 
> Well this is unfortunate.  hugetlb is forcing PREEMPT_COUNT because we
> screwed things up.

Yes this is far from ideal but we have tried to explore other ways all
looking much more complex. [1] shows that this is a problem already and
needs a reasonable fix to be backported for older kernels.

> Did we consider changing the networking code to call a new
> free_huge_tlb_from_irq()?  So the callee doesn't need to guess.

I do not think we want to pollute networking or any other code that
simply wants to put_page with a hugetlb specific knowledge.

> Or something else?
> 
> Is anyone looking onto fixing this for real?

Mike said he would be looking into making hugetlb_lock irq safe but
there is a non trivial way there and this would be not a great candidate
for backporting.

Btw. RCU already wants to have a reliable in_atomic as well and that
effectivelly means enabling PREEMPT_COUNT for everybody. The overhead of
per-cpu preempt counter should pretty much invisible AFAIK.

-- 
Michal Hocko
SUSE Labs
