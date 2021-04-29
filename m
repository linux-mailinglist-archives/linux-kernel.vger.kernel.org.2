Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEEC36E258
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhD2AGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 20:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhD2AGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:06:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D590661448
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619654729;
        bh=ZC+xd/7ZmNYK1PhNfcZ+lZ3Q54ZiPxXwCjpfba43YdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPGUaW9NjOjSklWrJV4EudWx4GiPPpCbrp1sn7n3BcBIzTe3PSt69QWSgqqSHLlFM
         ZEKeMifrvmPnX4NLPy51VnBjLcC8wEMVEbbQVgGCbfelAKCfzKvbmNAJEh3g8pRWlH
         8RetqPpS712RdtUTQ2Nyp/SYVwpEbj+h37ENyJoc4yLPwVlSRTwIG01GQNT7KQYnBN
         Gwu1BcHjwHOZDxnIDDyinm55tq9b5fdubTd7buB0M9kJvS5Zh7hdyfFr02iLTTT8qV
         UONB0nGtcVf0qbGNMKzHDeSAj3981TfhYt+m0nw8mNazBSOn1n5T16vthpnHvbRQZU
         DoqgYmzhokzxQ==
Received: by mail-ed1-f43.google.com with SMTP id h10so76382804edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 17:05:29 -0700 (PDT)
X-Gm-Message-State: AOAM532/HYFJT9zLz3Nd4s6KPXZMQII3x7Ldz6lkLVa+RE9e6nozJWVe
        ngxQBRAyyO8jYNpotV/fepKjsi+VZ/eb2RRZJrOR0w==
X-Google-Smtp-Source: ABdhPJxp//vlm9G8en7jFepxpsQZsjbMVNlpknDqIon2nNUjFJgRW5sOhZiVskEANO9YQ4YcgDXg2lRfC5Tpn5A7IIk=
X-Received: by 2002:a50:fc91:: with SMTP id f17mr14647157edq.23.1619654728429;
 Wed, 28 Apr 2021 17:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210407014502.24091-1-michel@lespinasse.org> <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org> <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1> <20210429000225.GC10973@lespinasse.org>
In-Reply-To: <20210429000225.GC10973@lespinasse.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Apr 2021 17:05:17 -0700
X-Gmail-Original-Message-ID: <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
Message-ID: <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in __handle_mm_fault().
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 5:02 PM Michel Lespinasse <michel@lespinasse.org> wrote:
>
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

Or, even better, fast GUP could add an explicit RCU read lock.

>
> Going back to my patch. I don't need to protect against THP splitting
> here, as I'm only handling the small page case. So when
> MMU_GATHER_RCU_TABLE_FREE is enabled, I *think* I could get away with
> using only an rcu read lock, instead of disabling interrupts which
> implicitly creates the rcu read lock. I'm not sure which way to go -
> fast GUP always disables interrupts regardless of the
> MMU_GATHER_RCU_TABLE_FREE setting, and I think there is a case to be
> made for following the fast GUP stes rather than trying to be smarter.

How about adding some little helpers:

lockless_page_walk_begin();

lockless_page_walk_end();

these turn into RCU read locks if MMU_GATHER_RCU_TABLE_FREE and into
irqsave otherwise.  And they're somewhat self-documenting.

--Andy
