Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCFD3E3286
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhHGBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhHGBLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:11:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 18:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0gkM+UinbwtOqMmJysOWd9GVZtLlhJgV0HyjzW5szG4=; b=rB3exe9IYtV34ChTRLpSed1lNg
        7QsbJaJRo0fSUK03lGDrWprgQvelPZ89Z2RzjVI/KXatwZsJYf8zIOG922SsakHPtpoRq6k6rXc0+
        t5YnwvvrxL753nTuCSf95PruIDk94dDIm5raWp2QUTCrLM5hhqTrPegf1DhXPk9O7b1rxkgskqcT7
        hTa8wEe7/VlImAUCS7hTcr8KXsEFE+Oftkr+yB0MhBWKBk9RqPkEc3eZQoWILMuvhx0XgmS3yTTBx
        BtBBy6E1sk3HqZMk1dMrxEmDQwkuILqfNneLVq6EQ3ixspqSlyyNvjucHZ0lNOOJSNYuNr/exHpw8
        ivaZ87AA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCArX-008l4C-Vz; Sat, 07 Aug 2021 01:10:59 +0000
Date:   Sat, 7 Aug 2021 02:10:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot
 time parameter.
Message-ID: <YQ3dn1oR2d0sO5jl@casper.infradead.org>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
 <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
 <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 01:27:27PM -0700, Hugh Dickins wrote:
> On Fri, 6 Aug 2021, Zi Yan wrote:
> > 
> > In addition, I would like to share more detail on my plan on supporting 1GB PUD THP.
> > This patchset is the first step, enabling kernel to allocate 1GB pages, so that
> > user can get 1GB THPs from ZONE_NORMAL and ZONE_MOVABLE without using
> > alloc_contig_pages() or CMA allocator. The next step is to improve kernel memory
> > fragmentation handling for pages up to MAX_ORDER, since currently pageblock size
> > is still limited by memory section size. As a result, I will explore solutions
> > like having additional larger pageblocks (up to MAX_ORDER) to counter memory
> > fragmentation. I will discover what else needs to be solved as I gradually improve
> > 1GB PUD THP support.
> 
> Sorry to be blunt, but let me state my opinion: 2MB THPs have given and
> continue to give us more than enough trouble.  Complicating the kernel's
> mm further, just to allow 1GB THPs, seems a very bad tradeoff to me.  I
> understand that it's an appealing personal project; but for the sake of
> of all the rest of us, please leave 1GB huge pages to hugetlbfs (until
> the day when we are all using 2MB base pages).

I respect your opinion, Hugh.  You, more than most of us, have spent an
inordinate amount of time debugging huge page related issues.  I also
share your misgivings about the potential performance improvements for
1GB pages.  They're too big for all but the most unusual of special cases.
This hasn't been helped by the scarce number of 1GB TLB entries in Intel
CPUs until very recently (and even those are hard to come by today).
I do not think they are of interest for the page cache (as I'm fond of
observing, if you have 7GB/s storage (eg the Samsung 980 Pro), you can
take seven page faults per second).

I am, however, of the opinion that 2MB pages give us so much trouble
because they're so very special.  Few people exercise those code paths and
it's easy to break them without noticing.  This is partly why I want to
do arbitrary-order pages.  If everybody is running with compound pages
all the time, we'll see the corner cases often, and people other than
Hugh, Kirill and Mike will be able to work on them.

Now, I'm not planning on working on arbitrary-order anonymous
pages myself.  I think I have enough to deal with in the page cache &
filesystems.  But I'm happy to help out when I can be useful.  I think
256kB pages are probably optimal at the moment for file-backed memory,
so I'm not planning on exploring the space above PMD_ORDER myself.
But there have already been some important areas of collaboration between
the 1GB effort and the folio effort.
