Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A036EDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhD2Pxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhD2Pxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1E9061409;
        Thu, 29 Apr 2021 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619711570;
        bh=0apMfOT7yVxKteFX5jy7z8m501eJwcSbWxO68VHKSRk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LTi6GOSaGUd+ShHp6T14DN+0KcAC/Cf+iJ2wo3JeY4KcVLGrNG7PJX/9lwfGjbBxY
         xTDUu4H8qbLvYG/bZdRYHjvMpNWvsHCLMLEMJIxagThFeNcyS2oFcoADgUJm66fmy2
         pNMUT97gaDLMpoH/LXSAHJgmq92dUwedEYxRW9E5ZrweAl2gVcGUE84KvAewzfqDf3
         oVryRx81P1d8gW5CUIUeFOfEVnrodkdPAAcn0ktZzpZvArHntb4DE/cSYIWiEBBrrC
         xw8Kf8ja7mJLZPAMMRPa4ouCPVy29JrJx3wBy3gM1Mfib7jmRf8aN06yAR8W82z/El
         oY1ohtDICNDpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 30F475C00E9; Thu, 29 Apr 2021 08:52:50 -0700 (PDT)
Date:   Thu, 29 Apr 2021 08:52:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
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
Message-ID: <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429000225.GC10973@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 05:02:25PM -0700, Michel Lespinasse wrote:
> On Wed, Apr 28, 2021 at 09:11:08AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 28, 2021 at 08:13:53AM -0700, Andy Lutomirski wrote:
> > > On Wed, Apr 28, 2021 at 8:05 AM Michel Lespinasse <michel@lespinasse.org> wrote:
> > > >
> > > > On Wed, Apr 07, 2021 at 08:36:01AM -0700, Andy Lutomirski wrote:
> > > > > On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> > > > > > The page table tree is walked with local irqs disabled, which prevents
> > > > > > page table reclamation (similarly to what fast GUP does). The logic is
> > > > > > otherwise similar to the non-speculative path, but with additional
> > > > > > restrictions: in the speculative path, we do not handle huge pages or
> > > > > > wiring new pages tables.
> > > > >
> > > > > Not on most architectures.  Quoting the actual comment in mm/gup.c:
> > > > >
> > > > > >  * Before activating this code, please be aware that the following assumptions
> > > > > >  * are currently made:
> > > > > >  *
> > > > > >  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
> > > > > >  *  free pages containing page tables or TLB flushing requires IPI broadcast.
> > > > >
> > > > > On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
> > > > > assumption that it is safe to dereference a pointer in a page table just
> > > > > because irqs are off.  You need RCU protection, too.
> > > > >
> > > > > You have the same error in the cover letter.
> > > >
> > > > Hi Andy,
> > > >
> > > > Thanks for your comment. At first I thought did not matter, because we
> > > > only enable ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT on selected
> > > > architectures, and I thought MMU_GATHER_RCU_TABLE_FREE is not set on
> > > > these. But I was wrong - MMU_GATHER_RCU_TABLE_FREE is enabled on X86
> > > > with paravirt. So I took another look at fast GUP to make sure I
> > > > actually understand it.
> > > >
> > > > This brings a question about lockless_pages_from_mm() - I see it
> > > > disabling interrupts, which it explains is necessary for disabling THP
> > > > splitting IPIs, but I do not see it taking an RCU read lock as would
> > > > be necessary for preventing paga table freeing on
> > > > MMU_GATHER_RCU_TABLE_FREE configs. I figure local_irq_save()
> > > > indirectly takes an rcu read lock somehow ? I think this is something
> > > > I should also mention in my explanation, and I have not seen a good
> > > > description of this on the fast GUP side...
> > > 
> > > Sounds like a bug!  That being said, based on my extremely limited
> > > understanding of how the common RCU modes work, local_irq_save()
> > > probably implies an RCU lock in at least some cases.  Hi Paul!
> > 
> > In modern kernels, local_irq_save() does have RCU reader semantics,
> > meaning that synchronize_rcu() will wait for pre-exiting irq-disabled
> > regions.  It will also wait for pre-existing bh-disable, preempt-disable,
> > and of course rcu_read_lock() sections of code.
> 
> Thanks Paul for confirming / clarifying this. BTW, it would be good to
> add this to the rcu header files, just so people have something to
> reference to when they depend on such behavior (like fast GUP
> currently does).

There is this in the synchronize_rcu() header block comment:

 * synchronize_rcu() was waiting.  RCU read-side critical sections are
 * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
 * In addition, regions of code across which interrupts, preemption, or
 * softirqs have been disabled also serve as RCU read-side critical
 * sections.  This includes hardware interrupt handlers, softirq handlers,
 * and NMI handlers.

I have pulled this into a separate paragraph to increase its visibility,
and will check out other locations in comments and documentation.

							Thanx, Paul

> Going back to my patch. I don't need to protect against THP splitting
> here, as I'm only handling the small page case. So when
> MMU_GATHER_RCU_TABLE_FREE is enabled, I *think* I could get away with
> using only an rcu read lock, instead of disabling interrupts which
> implicitly creates the rcu read lock. I'm not sure which way to go -
> fast GUP always disables interrupts regardless of the
> MMU_GATHER_RCU_TABLE_FREE setting, and I think there is a case to be
> made for following the fast GUP stes rather than trying to be smarter.
> 
> Andy, do you have any opinion on this ? Or anyone else really ?
> 
> Thanks,
> 
> --
> Michel "walken" Lespinasse
