Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD135619F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348187AbhDGDCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348197AbhDGDCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:02:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F882C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A4dQnqdPMEWgWHozydm8sHFmPoiQy22ClPwlRj1XJEM=; b=Y5kuozUjkrT9K9Ql4oSGLmJCMh
        XAWJ0mNEL+57KJuvF2wHh79M4/mjJV+mVhQavFoPxza6cBydNcSYm+SfhtuyjPvOg2Sw0RT+v08p3
        kqoPXi3SDgJn6OEanrDeah7wvne4dxBWtamMQBUoPZpQ6S/lI2MV1AwT9K7R6dQdCzC9TQ5v07v4W
        nVcCVkm6yVFVPs1WmKZcWOQ6OS7iqRz41CLZGT2lfVT7UQ5NMqqa7RLVy4TR4iCO3GwtihePkiHBR
        MDMbnJ05eK/9a9YwOJ98j806UaIPDBqwNbgA//p8OLebd6UcBLuNk31S9DfkVQagpi5ccUN77qIB4
        /zOLhh0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTyS2-00DnaP-8D; Wed, 07 Apr 2021 03:01:57 +0000
Date:   Wed, 7 Apr 2021 04:01:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20210407030154.GC2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <20210407023527.GX2531743@casper.infradead.org>
 <20210407025320.GA19997@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407025320.GA19997@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 07:53:20PM -0700, Michel Lespinasse wrote:
> On Wed, Apr 07, 2021 at 03:35:27AM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 06, 2021 at 06:44:49PM -0700, Michel Lespinasse wrote:
> > > In the speculative case, call the vm_ops->fault() method from within
> > > an rcu read locked section, and verify the mmap sequence lock at the
> > > start of the section. A match guarantees that the original vma is still
> > > valid at that time, and that the associated vma->vm_file stays valid
> > > while the vm_ops->fault() method is running.
> > > 
> > > Note that this implies that speculative faults can not sleep within
> > > the vm_ops->fault method. We will only attempt to fetch existing pages
> > > from the page cache during speculative faults; any miss (or prefetch)
> > > will be handled by falling back to non-speculative fault handling.
> > > 
> > > The speculative handling case also does not preallocate page tables,
> > > as it is always called with a pre-existing page table.
> > 
> > I still don't understand why you want to do this.  The speculative
> > fault that doesn't do I/O is already here, and it's called ->map_pages
> > (which I see you also do later).  So what's the point of this patch?
> 
> I have to admit I did not give much tought about which path would be
> generally most common here.
> 
> The speculative vm_ops->fault path would be used:
> - for private mapping write faults,
> - when fault-around is disabled (probably an uncommon case in general,
>   but actually common at Google).

Why is it disabled?  The PTE table is already being allocated and filled
... why not quickly check the page cache to see if there are other pages
within this 2MB range and fill in their PTEs too?  Even if only one
of them is ever hit, the reduction in page faults is surely worth it.
Obviously if your workload has such non-locality that you hit only one
page in a 2MB range and then no other, it'll lose ... but then you have
a really badly designed workload!

> That said, I do think your point makes sense in general, espicially if
> this could help avoid the per-filesystem enable bit.
