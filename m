Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6193D36DCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbhD1QLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhD1QLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2371D61407;
        Wed, 28 Apr 2021 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619626269;
        bh=1I9gQXY80qwKA6TumfD7Ydm/GIdUx7cZWoqKVciceg4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UH3Z8WW0pbZYmpyctNRIhvTFCwIT2/3MNoyuyDrbmnqkFb6IEax+ZfFGgvgQRIGc7
         Ehc9MO5lRF1ixSkMXLhKIyll9ZYJobiPY0THw7FCKuAheSkY4uhCjss8VXnAF1FMNb
         mF89JN7UbvzvCNTg1k8Pv3JnCeLOUIj0W+uS47BxF1uF4TQnetsJDI9Fm+x2QgdGr1
         3YmmwAtlRUzZGCANL7yQNBGRsChfWCu3EYa172VaOtih4hPU7CSBdsDiGGqm0vJZ/3
         zONS9Ll/Ltx/UWrTsSed5e2VOchEjvstVb8BxW8q4/g+MQqOv2tDhQWEuhL9Lyun4f
         PiRdQoGmnhDCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF1FD5C0163; Wed, 28 Apr 2021 09:11:08 -0700 (PDT)
Date:   Wed, 28 Apr 2021 09:11:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 08:13:53AM -0700, Andy Lutomirski wrote:
> On Wed, Apr 28, 2021 at 8:05 AM Michel Lespinasse <michel@lespinasse.org> wrote:
> >
> > On Wed, Apr 07, 2021 at 08:36:01AM -0700, Andy Lutomirski wrote:
> > > On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> > > > The page table tree is walked with local irqs disabled, which prevents
> > > > page table reclamation (similarly to what fast GUP does). The logic is
> > > > otherwise similar to the non-speculative path, but with additional
> > > > restrictions: in the speculative path, we do not handle huge pages or
> > > > wiring new pages tables.
> > >
> > > Not on most architectures.  Quoting the actual comment in mm/gup.c:
> > >
> > > >  * Before activating this code, please be aware that the following assumptions
> > > >  * are currently made:
> > > >  *
> > > >  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
> > > >  *  free pages containing page tables or TLB flushing requires IPI broadcast.
> > >
> > > On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
> > > assumption that it is safe to dereference a pointer in a page table just
> > > because irqs are off.  You need RCU protection, too.
> > >
> > > You have the same error in the cover letter.
> >
> > Hi Andy,
> >
> > Thanks for your comment. At first I thought did not matter, because we
> > only enable ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT on selected
> > architectures, and I thought MMU_GATHER_RCU_TABLE_FREE is not set on
> > these. But I was wrong - MMU_GATHER_RCU_TABLE_FREE is enabled on X86
> > with paravirt. So I took another look at fast GUP to make sure I
> > actually understand it.
> >
> > This brings a question about lockless_pages_from_mm() - I see it
> > disabling interrupts, which it explains is necessary for disabling THP
> > splitting IPIs, but I do not see it taking an RCU read lock as would
> > be necessary for preventing paga table freeing on
> > MMU_GATHER_RCU_TABLE_FREE configs. I figure local_irq_save()
> > indirectly takes an rcu read lock somehow ? I think this is something
> > I should also mention in my explanation, and I have not seen a good
> > description of this on the fast GUP side...
> 
> Sounds like a bug!  That being said, based on my extremely limited
> understanding of how the common RCU modes work, local_irq_save()
> probably implies an RCU lock in at least some cases.  Hi Paul!

In modern kernels, local_irq_save() does have RCU reader semantics,
meaning that synchronize_rcu() will wait for pre-exiting irq-disabled
regions.  It will also wait for pre-existing bh-disable, preempt-disable,
and of course rcu_read_lock() sections of code.

But don't try this in older kernels, that is not in kernel in which
synchronize_sched() is defined!

							Thanx, Paul
