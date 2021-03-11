Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4160D336BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCKFnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhCKFnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:43:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB8964FC4;
        Thu, 11 Mar 2021 05:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615441397;
        bh=rg/0bFjI5MjZPkKD2yLe402jF3c+8cdDal2oy4B42SU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iwng5mXntF72a0+BJIh2nNgcaKhdxKxQevwLWsiRxKR7Akhobuvehqn8n2OTlafVl
         XWnSO5SLe/cWlN7hHyo3mv3ShGbwB6Kx0GvILPH0PSynmbY97fCGWdtQ9KRwnhdszf
         Qq3xe9bVTO4m3TS2yJUKvZ2eVP98Dphy32Qxu8t4=
Date:   Wed, 10 Mar 2021 21:43:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>, peterz@infradead.org
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-Id: <20210310214316.6d1ffb19a4219b4e70123e19@linux-foundation.org>
In-Reply-To: <20210311021321.127500-1-mike.kravetz@oracle.com>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 18:13:21 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

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
> 
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
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -235,6 +235,7 @@ config HUGETLBFS
>  
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
> +	select PREEMPT_COUNT
>  

Well this is unfortunate.  hugetlb is forcing PREEMPT_COUNT because we
screwed things up.

Did we consider changing the networking code to call a new
free_huge_tlb_from_irq()?  So the callee doesn't need to guess.

Or something else?

Is anyone looking onto fixing this for real?

