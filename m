Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF697421CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJEDKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEDKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:10:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC94C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7dBLIl+nvuJ5/TshWkFH8R/LSyf8rCwOu4+qy+UdpKk=; b=OXiiUkcKKK02LNPNBKm308CqZl
        zn9XIlWG9x/zvF5x//XHHfl1P4EMHc3+d0kdlhmpbSADx523b5P/6myMusopE5FdU5SMx3cIZAPSs
        Um+djmUoxsEvNHMGRUrg9eALb6XiA9kL2JlaLd5SEe2yp4A+wJsuYVE2boLmQAJf2D6Imuj6NnSiN
        9TigofdnDDLNCnV6WjPIxcfsICV9VvjxqZlfhX9fyZ7hX4MV49+4ZOd/jSpgTcmwh30oZmc+AeBH9
        8XxdHcrgwIzVnyVRhJQ9KBMZWaf5gNYnxgbapnZtYUzYX5wHKT8rCQ6O1NNNMa8NxOXGTd3fBKR6c
        hxpYIPtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXanr-00HYe2-Rd; Tue, 05 Oct 2021 03:07:45 +0000
Date:   Tue, 5 Oct 2021 04:07:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVvBe/4L3BMWw68S@casper.infradead.org>
References: <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <YVT+KWFA8hfSKU+m@casper.infradead.org>
 <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
 <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
 <d2776967-bb9f-985b-6d38-d1d1dc83cd7b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2776967-bb9f-985b-6d38-d1d1dc83cd7b@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:58:10PM -0700, Hugh Dickins wrote:
> On Tue, 5 Oct 2021, Rongwei Wang wrote:
> 
> > Hi,
> > I have run our cases these two days to stress test new Patch #1. The new Patch
> > #1 mainly add filemap_invalidate_{un}lock before and after
> > truncate_pagecache(), basing on original Patch #1. And the crash has not
> > happened.
> > 
> > Now, I keep the original Patch #1, then adding the code below which suggested
> > by liu song (I'm not sure which one I should add in the next version,
> > Suggested-by or Signed-off-by? If you know, please remind me).
> > 
> > -               if (filemap_nr_thps(inode->i_mapping))
> > +               if (filemap_nr_thps(inode->i_mapping)) {
> > +                       filemap_invalidate_lock(inode->i_mapping);
> >                         truncate_pagecache(inode, 0);
> > +                       filemap_invalidate_unlock(inode->i_mapping);
> > +               }
> 
> I won't NAK that patch; but I still believe it's unnecessary, and don't
> see how it protects against all the races (collapse_file() does not use
> that lock, whereas collapse_file() does use page lock).  And if you're
> hoping to fix 5.10, then you will have to backport those invalidate_lock
> patches there too (they're really intended to protect hole-punching).

I believe all we really need to do is protect against calling
truncate_pagecache() simultaneously to avoid one of the calls seeing
a tail page.  i_mutex would work for this purpose just as well as
filemap_invalidate_lock().  See, for example, ext4_zero_range() which
first takes inode_lock(), then filemap_invalidate_lock() before calling
truncate_pagecache_range().

> > And the reason for keeping the original Patch #1 is mainly to fix the race
> > between collapse_file and truncate_pagecache. It seems necessary. Despite the
> > two-day test, I did not reproduce this race any more.
> > 
> > In addition, I also test the below method:
> > 
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 3f47190f98a8..33604e4ce60a 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -210,8 +210,6 @@ invalidate_complete_page(struct address_space *mapping,
> > struct page *page)
> > 
> >  int truncate_inode_page(struct address_space *mapping, struct page *page)
> >  {
> > -       VM_BUG_ON_PAGE(PageTail(page), page);
> > -
> >         if (page->mapping != mapping)
> >                 return -EIO;
> > 
> > I am not very sure this VM_BUG_ON_PAGE(PageTail) is what Hugh means. And
> > the test results show that only removing this VM_BUG_ON_PAGE(PageTail) has no
> > effect. So, I still keep the original Patch #1 to fix one race.
> 
> Yes, that's exactly what I meant, and thank you for intending to try it.
> 
> But if that patch had "no effect", then I think you were not running the
> kernel with that patch applied: because it deletes the BUG on line 213
> of mm/truncate.c, which is what you reported in the first mail!
> 
> Or, is line 213 of mm/truncate.c in your 5.10.46-hugetext+ kernel
> something else?  I've been looking at 5.15-rc.
> 
> But I wasn't proposing to delete it merely to hide the BUG: as I hope
> I explained, we could move it below the page->mapping check, but it
> wouldn't really be of any value there since tails have NULL page->mapping
> anyway (well, I didn't check first and second tails, maybe mapping gets
> reused for some compound page field in those). I was proposing to delete
> it because the page->mapping check then weeds out the racy case once
> we're holding page lock, without the need for adding anything special.

I think if we remove the race with the above mutex lock then we'll never
see a tail page in this routine.
