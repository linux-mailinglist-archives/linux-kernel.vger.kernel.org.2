Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565D93718D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhECQDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhECQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:03:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A456C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JfhcAPftKZ8AsOlG154NgUsbwjQGFIEm1AMmoheMFkA=; b=OwP0/5CV1pUfYfQ4i6uG8wSwaV
        tST4mGakUlvxX86IJ4ouiltvqG3RiOnvY4JtD8UKaM0e+UOasps7MuU2lc9ATfTWJBXaogQgwgFwQ
        s/8woBTekFdK6LRupbN65TkOODriNgX6aA+S0IrYQKLHk0RH7HKU/KC/QBhkiv5DmXez33Uq2t1CR
        +/whsp9RlNLLptL29Ud3tZogzarCbl6Jk+9fKYBV4Xs/gm2IDNShIaz0PCq/YT3cFscGA86UrL+r0
        jAaTrsPBxsJjALIwRIQUohNh8DPkvf5F0gUIQaR3t18ZhVNnbhhAT0Tpd5+rKSaV2Riz/odS2Vrdy
        UKPCZMWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldazc-00FHow-8Z; Mon, 03 May 2021 16:00:39 +0000
Date:   Mon, 3 May 2021 17:00:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 38/94] mm/gup: Add mm_populate_vma() for use when the vma
 is known
Message-ID: <20210503160020.GC1847222@casper.infradead.org>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-39-Liam.Howlett@Oracle.com>
 <20210501051330.GC5188@lespinasse.org>
 <20210503155352.74xqhqgizaagdro5@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503155352.74xqhqgizaagdro5@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 03:53:58PM +0000, Liam Howlett wrote:
> * Michel Lespinasse <michel@lespinasse.org> [210501 01:13]:
> > On Wed, Apr 28, 2021 at 03:36:08PM +0000, Liam Howlett wrote:
> > > When a vma is known, avoid calling mm_populate to search for the vma to
> > > populate.
> > > 
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/gup.c      | 20 ++++++++++++++++++++
> > >  mm/internal.h |  4 ++++
> > >  2 files changed, 24 insertions(+)
> > > 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index c3a17b189064..48fe98ab0729 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1468,6 +1468,26 @@ long populate_vma_page_range(struct vm_area_struct *vma,
> > >  				NULL, NULL, locked);
> > >  }
> > >  
> > > +/*
> > > + * mm_populate_vma() - Populate a single range in a single vma.
> > > + * @vma: The vma to populate.
> > > + * @start: The start address to populate
> > > + * @end: The end address to stop populating
> > > + *
> > > + * Note: Ignores errors.
> > > + */
> > > +void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
> > > +		unsigned long end)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	int locked = 1;
> > > +
> > > +	mmap_read_lock(mm);
> > > +	populate_vma_page_range(vma, start, end, &locked);
> > > +	if (locked)
> > > +		mmap_read_unlock(mm);
> > > +}
> > > +
> > 
> > This seems like a nonsensical API at first glance - VMAs that are found
> > in the vma tree might be modified, merged, split, or freed at any time
> > if the mmap lock is not held, so the API can not be safely used. I think
> > this applies to maple tree vmas just as much as it did for rbtree vmas ?
> 
> This is correct - it cannot be used without having the mmap_sem lock.
> This is a new internal mm code API and is used to avoid callers that use
> mm_populate() on a range that is known to be in a single VMA and already
> have that VMA.  So instead of re-walking the tree to re-find the VMAs,
> this function can be used with the known VMA and range.
> 
> It is used as described in patch 39 and 40 of this series.

In patch 39, what you do is:

1 Take the mmap_sem for write
2 do stuff
3 Drop the mmap_sem
4 Call mm_populate_vm() with the vma, which takes the mmap_sem
   for read

The problem is that between 3 & 4, a racing thread might cause us to free
the vma and so we've now passed a bogus pointer into mm_populate_vm().

What we need instead is to downgrade the mmap_sem from write to read at
step 3, so the vma is guaranteed to still be good.
