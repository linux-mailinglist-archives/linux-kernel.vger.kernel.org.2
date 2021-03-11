Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D273B336F37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhCKJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhCKJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:49:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A10C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qTTXD4rDBXLQmKbDmwsmX4CcXJeQvWfH6qNaQAGLaWQ=; b=dQPNckSHiEl3oEVreFjBKR+61Y
        M3JWAzF9I9MiI+7YJaHHBZpjiIgk/ky4xehaAWQwDIa+imXla9ugmp8s9x2CsFHjxrIKMPGO2MzaK
        5+mAbrFn1H59FIB6OuuXvnHO3TktcR2vDMj+yvoBj+2BbRYD2rQntsivq01hjAKkubPvO0Gbw0BOZ
        TL9UdTtIHRTfSoZk5i3a8h8aeFU25gy0Y/A7wsRnQCT+22fQVRNjDs4tUvlAV8kWQXRNmvwn5p8ds
        QVPOFfoiKV5ZqZFTRAzcHNbK6br3+OwBTy9agVa6isH+z/aAFxODpOgXkU2sX9LgbPkHazFurDZUw
        t0lQMBaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKHwb-008mST-HR; Thu, 11 Mar 2021 09:49:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE17A300455;
        Thu, 11 Mar 2021 10:49:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D06EE2027A4AC; Thu, 11 Mar 2021 10:49:23 +0100 (CET)
Date:   Thu, 11 Mar 2021 10:49:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEnno0Qt90omMXUG@hirez.programming.kicks-ass.net>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311021321.127500-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 06:13:21PM -0800, Mike Kravetz wrote:
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
> lock (hugetlb subpool) was also taken in the free_huge_page path. 

AFAICT there's no actual problem with making spool->lock IRQ-safe too.

> In addition, hugetlb cgroup code had been added which could hold
> hugetlb_lock for a considerable period of time. 

cgroups, always bloody cgroups. The scheduler (and a fair number of
other places) get to deal with cgroups with IRQs disabled, so I'm sure
this can too.

> Because of this, commit
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

AFAICT that's because CMA, right? That's only hstate_is_gigantic() and
free_gigantic_page() that has that particular trainwreck.

So you could move the workqueue there, and leave all the other hugetlb
sizes unaffected. Afaict if you limit the workqueue crud to
cma_clear_bitmap(), you don't get your..

> One way to handle all calling contexts is to have free_huge_page always
> send pages to the workqueue for processing.  This idea was briefly
> discussed here [3], but has some undesirable side effects.

... user visible side effects either.

> Ideally, the hugetlb_lock should have been irq safe from the beginning
> and any code added to the free_huge_page path should have taken this
> into account.  However, this has not happened.  The code today does have
> the ability to hand off requests to a workqueue.  It does this for calls
> from irq context.  Changing the check in the code from !in_task to
> in_atomic would handle the situations when called with irqs disabled.
> However, it does not not handle the case when called with a spinlock
> held.  This is needed because the code could block/sleep.

I'll argue the current workqueue thing is in the wrong place to begin
with.

So how about you make hugetlb_lock and spool->lock IRQ-safe, move thw
workqueue thingy into cma_release(), and then worry about optimizing the
cgroup crap?

Correctness first, performance second. Also, if you really care about
performance, not using cgroups is a very good option anyway.
