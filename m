Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EAA36E256
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhD2ADM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 20:03:12 -0400
Received: from server.lespinasse.org ([63.205.204.226]:47471 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhD2ADL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:03:11 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619654545; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=364G7l/8sx/U40osAdH/d+NTykEtV4SoCG8Fp6FtSTI=;
 b=cmUQPcwJhUN8pkqBnlbWpiz8waNG8cGGmO/gbi+NRxow6uC9T7phmzgXaYj0EMpqgaNdI
 CUEiqm1DV7q0WPiCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619654545; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=364G7l/8sx/U40osAdH/d+NTykEtV4SoCG8Fp6FtSTI=;
 b=Vjbls5uwhuaxHrVgNM7Aq2JLRYRVCdW5Esr84dd4L38oBpEb7dTfneXT9MmQ9VSupdFdz
 RbcaWJA/OFcdoNFxaUlln3j5v8qkqaKkmFpLjXrYPvlvmUG6dppb95nmXj+2yzuRs9yiw9U
 u6bRuvWl5Zsu+fSlcjgZ9/HHVjyO5YTpCDPDYroj4km9ACktDIR6sxCtH6H07OfjCKumZZ5
 dVnG//O5uFJ86ETD+eASuo6KWQ7s6NEHwZZ44k0qyqHu45ou3VVYCw8ev/0EY/J0RAadvmw
 VQ9x1MMW5iMVoeZpwIsQVRYVY+e5raBSB+T0OncODFSFeTQPT7VdK6p5vMEQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id E09771602DB; Wed, 28 Apr 2021 17:02:25 -0700 (PDT)
Date:   Wed, 28 Apr 2021 17:02:25 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
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
Message-ID: <20210429000225.GC10973@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 09:11:08AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 28, 2021 at 08:13:53AM -0700, Andy Lutomirski wrote:
> > On Wed, Apr 28, 2021 at 8:05 AM Michel Lespinasse <michel@lespinasse.org> wrote:
> > >
> > > On Wed, Apr 07, 2021 at 08:36:01AM -0700, Andy Lutomirski wrote:
> > > > On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> > > > > The page table tree is walked with local irqs disabled, which prevents
> > > > > page table reclamation (similarly to what fast GUP does). The logic is
> > > > > otherwise similar to the non-speculative path, but with additional
> > > > > restrictions: in the speculative path, we do not handle huge pages or
> > > > > wiring new pages tables.
> > > >
> > > > Not on most architectures.  Quoting the actual comment in mm/gup.c:
> > > >
> > > > >  * Before activating this code, please be aware that the following assumptions
> > > > >  * are currently made:
> > > > >  *
> > > > >  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
> > > > >  *  free pages containing page tables or TLB flushing requires IPI broadcast.
> > > >
> > > > On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
> > > > assumption that it is safe to dereference a pointer in a page table just
> > > > because irqs are off.  You need RCU protection, too.
> > > >
> > > > You have the same error in the cover letter.
> > >
> > > Hi Andy,
> > >
> > > Thanks for your comment. At first I thought did not matter, because we
> > > only enable ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT on selected
> > > architectures, and I thought MMU_GATHER_RCU_TABLE_FREE is not set on
> > > these. But I was wrong - MMU_GATHER_RCU_TABLE_FREE is enabled on X86
> > > with paravirt. So I took another look at fast GUP to make sure I
> > > actually understand it.
> > >
> > > This brings a question about lockless_pages_from_mm() - I see it
> > > disabling interrupts, which it explains is necessary for disabling THP
> > > splitting IPIs, but I do not see it taking an RCU read lock as would
> > > be necessary for preventing paga table freeing on
> > > MMU_GATHER_RCU_TABLE_FREE configs. I figure local_irq_save()
> > > indirectly takes an rcu read lock somehow ? I think this is something
> > > I should also mention in my explanation, and I have not seen a good
> > > description of this on the fast GUP side...
> > 
> > Sounds like a bug!  That being said, based on my extremely limited
> > understanding of how the common RCU modes work, local_irq_save()
> > probably implies an RCU lock in at least some cases.  Hi Paul!
> 
> In modern kernels, local_irq_save() does have RCU reader semantics,
> meaning that synchronize_rcu() will wait for pre-exiting irq-disabled
> regions.  It will also wait for pre-existing bh-disable, preempt-disable,
> and of course rcu_read_lock() sections of code.

Thanks Paul for confirming / clarifying this. BTW, it would be good to
add this to the rcu header files, just so people have something to
reference to when they depend on such behavior (like fast GUP
currently does).

Going back to my patch. I don't need to protect against THP splitting
here, as I'm only handling the small page case. So when
MMU_GATHER_RCU_TABLE_FREE is enabled, I *think* I could get away with
using only an rcu read lock, instead of disabling interrupts which
implicitly creates the rcu read lock. I'm not sure which way to go -
fast GUP always disables interrupts regardless of the
MMU_GATHER_RCU_TABLE_FREE setting, and I think there is a case to be
made for following the fast GUP stes rather than trying to be smarter.

Andy, do you have any opinion on this ? Or anyone else really ?

Thanks,

--
Michel "walken" Lespinasse
