Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9A3581BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhDHL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhDHL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:29:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D085C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6L5DXhJLDb/LJ3Zk1Inyo0+MRzl97ueT3hWzUgjTxAQ=; b=U2ol3/AFz4trLaB07jh5OLdQJs
        Q1M4/k50bMUB2/GQPRrO766TWjKMaleVHYyan0480tHf8jxJRWfyjALxMjEJ8iK8sK1JFnKougkzd
        tGh+2PtppBE0x3iBq7JxyYPTex/pKkyXgBnKw1TIewUOEg19kzQqeBqgh6HTk5KK5J4UvYpsCul30
        frBeyv5A0WEe6wn2OoCFeDyxb6KM6AApyiG6/6hBqS19FSQApVAU1bFZNVNccLzSGk+WemouTpvf5
        1dWiS3riBVJeDgFgJ0xbkQCT5c0ghR5sipnBFP4p6FQYvYSuCrUNy9N2y51ChGKN0SPbaSDX5mz41
        eupWbCxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUSpU-00G52T-SR; Thu, 08 Apr 2021 11:28:10 +0000
Date:   Thu, 8 Apr 2021 12:28:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 24/37] mm: implement speculative handling in
 __do_fault()
Message-ID: <20210408112808.GK2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
 <20210407212027.GE25738@lespinasse.org>
 <20210407212712.GH2531743@casper.infradead.org>
 <YG6qCtRcz2ESUiFy@hirez.programming.kicks-ass.net>
 <20210408071343.GJ2531743@casper.infradead.org>
 <20210408083734.GB27824@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408083734.GB27824@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:37:34AM -0700, Michel Lespinasse wrote:
> On Thu, Apr 08, 2021 at 08:13:43AM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 08, 2021 at 09:00:26AM +0200, Peter Zijlstra wrote:
> > > On Wed, Apr 07, 2021 at 10:27:12PM +0100, Matthew Wilcox wrote:
> > > > Doing I/O without any lock held already works; it just uses the file
> > > > refcount.  It would be better to use a vma refcount, as I already said.
> > > 
> > > The original workload that I developed SPF for (waaaay back when) was
> > > prefaulting a single huge vma. Using a vma refcount was a total loss
> > > because it resulted in the same cacheline contention that down_read()
> > > was having.
> > > 
> > > As such, I'm always incredibly sad to see mention of vma refcounts.
> > > They're fundamentally not solving the problem :/
> > 
> > OK, let me outline my locking scheme because I think it's rather better
> > than Michel's.  The vma refcount is the slow path.
> > 
> > 1. take the RCU read lock
> > 2. walk the pgd/p4d/pud/pmd
> > 3. allocate page tables if necessary.  *handwave GFP flags*.
> > 4. walk the vma tree
> > 5. call ->map_pages
> > 6. take ptlock
> > 7. insert page(s)
> > 8. drop ptlock
> > if this all worked out, we're done, drop the RCU read lock and return.
> > 9. increment vma refcount
> > 10. drop RCU read lock
> > 11. call ->fault
> > 12. decrement vma refcount
> 
> Note that most of your proposed steps seem similar in principle to mine.
> Looking at the fast path (steps 1-8):
> - step 2 sounds like the speculative part of __handle_mm_fault()
> - (step 3 not included in my proposal)
> - step 4 is basically the lookup I currently have in the arch fault handler
> - step 6 sounds like the speculative part of map_pte_lock()
> 
> I have working implementations for each step, while your proposal
> summarizes each as a point item. It's not clear to me what to make of it;
> presumably you would be "filling in the blanks" in a different way
> than I have but you are not explaining how. Are you suggesting that
> the precautions taken in each step to avoid races with mmap writers
> would not be necessary in your proposal ? if that is the case, what is
> the alternative mechanism would you use to handle such races ?

I don't know if you noticed, I've been a little busy with memory folios.
I did tell you that on the call, but you don't seem to retain anything
I tell you on the call, so maybe I shouldn't bother calling in any more.

> Going back to the source of this, you suggested not copying the VMA,
> what is your proposed alternative ? Do you suggest that fault handlers
> should deal with the vma potentially mutating under them ? Or should
> mmap writers consider vmas as immutable and copy them whenever they
> want to change them ? or are you implying a locking mechanism that would
> prevent mmap writers from executing while the fault is running ?

The VMA should be immutable, as I explained to you before.
