Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0D336DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhCKI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:26:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhCKI0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:26:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615451163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sx/f3zD8RJf1ft1qnWi2YDTRWP7OIzqVLoqNUEi5Uw=;
        b=dHZVvvf4PKotWNg1/LtPQ3ylvs9skG4kibEn67IzJq+O/W9Z//D+JZ0zp2Ag2tNRGFltYA
        a1dLT9VxaaFb+w/dK4yAeFXtHjB2tCXyjtVNzYwPjjMZnq9jDVzPe+ZbW+yvJj9HcKH0/H
        1IpgCIV14uPIY7lB0TwGieoI1AXa5XQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4144CAC17;
        Thu, 11 Mar 2021 08:26:03 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:26:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>, peterz@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEnUGtx79QaMNGVN@dhcp22.suse.cz>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311021321.127500-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 18:13:21, Mike Kravetz wrote:
> put_page does not correctly handle all calling contexts for hugetlb
> pages.  This was recently discussed in the threads [1] and [2].
> 
> free_huge_page is the routine called for the final put_page of huegtlb
> pages.  Since at least the beginning of git history, free_huge_page has
> acquired the hugetlb_lock to move the page to a free list and possibly
> perform other processing. When this code was originally written, the
> hugetlb_lock should have been made irq safe.
> 
> For many years, nobody noticed this situation until lockdep code caught
> free_huge_page being called from irq context.  By this time, another
> lock (hugetlb subpool) was also taken in the free_huge_page path.  In
> addition, hugetlb cgroup code had been added which could hold
> hugetlb_lock for a considerable period of time.  Because of this, commit
> c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> context") was added to address the issue of free_huge_page being called
> from irq context.  That commit hands off free_huge_page processing to a
> workqueue if !in_task.
> 
> The !in_task check handles the case of being called from irq context.
> However, it does not take into account the case when called with irqs
> disabled as in [1].
> 
> To complicate matters, functionality has been added to hugetlb
> such that free_huge_page may block/sleep in certain situations.  The
> hugetlb_lock is of course dropped before potentially blocking.
> 
> One way to handle all calling contexts is to have free_huge_page always
> send pages to the workqueue for processing.  This idea was briefly
> discussed here [3], but has some undesirable side effects.

s@undesirable side effects@undesirable user visible side effects@

> Ideally, the hugetlb_lock should have been irq safe from the beginning
> and any code added to the free_huge_page path should have taken this
> into account.  However, this has not happened.  The code today does have
> the ability to hand off requests to a workqueue.  It does this for calls
> from irq context.  Changing the check in the code from !in_task to
> in_atomic would handle the situations when called with irqs disabled.
> However, it does not not handle the case when called with a spinlock
> held.  This is needed because the code could block/sleep.
> 
> Select PREEMPT_COUNT if HUGETLB_PAGE is enabled so that in_atomic can be
> used to detect all atomic contexts where sleeping is not possible.
> 
> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> [2] https://lore.kernel.org/linux-mm/YEjji9oAwHuZaZEt@dhcp22.suse.cz/
> [3] https://lore.kernel.org/linux-mm/YDzaAWK41K4gD35V@dhcp22.suse.cz/
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

While not an ideal solution I believe this is the most straightforward
one wrt to backporting to older kernels which are affected. I have a
hope that a preemption model independent in_atomic() is going to become
a norm. RCU is very much interested in the same thing as well. Now we
have two core kernel users requiring this so hopefully this will make
the case stronger.

That being said
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/Kconfig   |  1 +
>  mm/hugetlb.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 462253ae483a..403d7a7a619a 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -235,6 +235,7 @@ config HUGETLBFS
>  
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
> +	select PREEMPT_COUNT
>  
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 33b0d8778551..5407e77ca803 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1437,9 +1437,9 @@ static void __free_huge_page(struct page *page)
>  }
>  
>  /*
> - * As free_huge_page() can be called from a non-task context, we have
> - * to defer the actual freeing in a workqueue to prevent potential
> - * hugetlb_lock deadlock.
> + * If free_huge_page() is called from an atomic context, we have to defer
> + * the actual freeing in a workqueue.  This is to prevent possible sleeping
> + * while in atomic and potential hugetlb_lock deadlock.
>   *
>   * free_hpage_workfn() locklessly retrieves the linked list of pages to
>   * be freed and frees them one-by-one. As the page->mapping pointer is
> @@ -1467,9 +1467,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>  void free_huge_page(struct page *page)
>  {
>  	/*
> -	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> +	 * Defer freeing if in atomic context and sleeping is not allowed
>  	 */
> -	if (!in_task()) {
> +	if (in_atomic()) {
>  		/*
>  		 * Only call schedule_work() if hpage_freelist is previously
>  		 * empty. Otherwise, schedule_work() had been called but the
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs
