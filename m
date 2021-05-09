Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B601377611
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhEIJlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIJlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DBAE61370;
        Sun,  9 May 2021 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620553204;
        bh=arqj45G9UntJeTybAfBKTHblqTMzSlsbmScLhph1JQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LME6quczRrfH5T+sZlxMjLWKBvWW/uhkH89PfrtZENGozc14UbpYKyz+LEMe3jtTv
         A6Mq05FD+ZyCTiA7nDPDKOB0s6jgVT5AhLMzdI/xtaOrCL0el5+kwoYWXjdrbGZgI4
         bbZEGw4A23BaP2+qZN/TMDhOSzQ41o9h3RWsxO6uOdMwB1EUgL+EugElVMeWayt2Lg
         0+MpKZCLvUhmfjFvN2sL1/bJpFSgUfHAVnJCT0KQ+VaMceRy1twji2MkndvwMQv/kB
         PX/sRh0EuMbEZsc0L0+R8eCr0CrObDm/G9ZN39HhS6SO2FJKy5PYBj7+g2ZZTUBt/q
         VjhYQsQCEcxhQ==
Date:   Sun, 9 May 2021 12:39:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH RFC 3/9] x86/mm/cpa: Add grouped page allocations
Message-ID: <YJet66kzbb6UB5Qe@kernel.org>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <20210505003032.489164-4-rick.p.edgecombe@intel.com>
 <YJKKu7kMCtCuel2L@kernel.org>
 <YJKY+Ccxfe9wD0iP@hirez.programming.kicks-ass.net>
 <YJLnyJP755XAPZNX@kernel.org>
 <bb2a9aaedcd5d47ace719050fa06d7a21050cfc5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2a9aaedcd5d47ace719050fa06d7a21050cfc5.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 09:57:17PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2021-05-05 at 21:45 +0300, Mike Rapoport wrote:
> > On Wed, May 05, 2021 at 03:09:12PM +0200, Peter Zijlstra wrote:
> > > On Wed, May 05, 2021 at 03:08:27PM +0300, Mike Rapoport wrote:
> > > > On Tue, May 04, 2021 at 05:30:26PM -0700, Rick Edgecombe wrote:
> > > > > For x86, setting memory permissions on the direct map results
> > > > > in fracturing
> > > > > large pages. Direct map fracturing can be reduced by locating
> > > > > pages that
> > > > > will have their permissions set close together.
> > > > > 
> > > > > Create a simple page cache that allocates pages from huge page
> > > > > size
> > > > > blocks. Don't guarantee that a page will come from a huge page
> > > > > grouping,
> > > > > instead fallback to non-grouped pages to fulfill the allocation
> > > > > if
> > > > > needed. Also, register a shrinker such that the system can ask
> > > > > for the
> > > > > pages back if needed. Since this is only needed when there is a
> > > > > direct
> > > > > map, compile it out on highmem systems.
> > > > 
> > > > I only had time to skim through the patches, I like the idea of
> > > > having a
> > > > simple cache that allocates larger pages with a fallback to basic
> > > > page
> > > > size.
> > > > 
> > > > I just think it should be more generic and closer to the page
> > > > allocator.
> > > > I was thinking about adding a GFP flag that will tell that the
> > > > allocated
> > > > pages should be removed from the direct map. Then alloc_pages()
> > > > could use
> > > > such cache whenever this GFP flag is specified with a fallback
> > > > for lower
> > > > order allocations.
> > > 
> > > That doesn't provide enough information I think. Removing from
> > > direct
> > > map isn't the only consideration, you also want to group them by
> > > the
> > > target protection bits such that we don't get to use 4k pages quite
> > > so
> > > much.
> > 
> > Unless I'm missing something we anyway hand out 4k pages from the
> > cache and
> > the neighbouring 4k may end up with different protections.
> > 
> > This is also similar to what happens in the set Rick posted a while
> > ago to
> > support grouped vmalloc allocations:
> > 
> 
> One issue is with the shrinker callbacks. If you are just trying to
> reset and free a single page because the system is low on memory, it
> could be problematic to have to break a large page, which would require
> another page.

I don't follow you here. Maybe I've misread the patches but AFAIU the large
page is broken at allocation time and 4k pages remain 4k pages afterwards.

In my understanding the problem with a simple shrinker is that even if we
have the entire 2M free it is not being reinstated as 2M page in the direct
mapping.
 
-- 
Sincerely yours,
Mike.
