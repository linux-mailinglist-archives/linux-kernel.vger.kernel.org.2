Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC63E3980
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhHHHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 03:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhHHHmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 03:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D66C60F39;
        Sun,  8 Aug 2021 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628408507;
        bh=CYMKqE1+7fxAlSAmnYrtevdQ1lCY0IuaT2V+KxsI/e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSyDJFZqgH/M7RRbu8mmRrfyUy1GbApjnXeu7seD538P69tYX1Umz5DKse88X4qb9
         U5ZHOGWmWV339ajJk0QmFhV8xzFsIXqbgsnb0yGRjqfn3FMQ6NS7kdcqUyQ3q7X1VB
         w5i+Ec4xbIIjhThBmGg0CcuMcSzEH5TSkMIAoHRqxmp7s1VbhRXfDU00qfSVm8Mdtv
         fDaR799fK9k+a4ZYdCLMQPFIFc0P/71Bmx95ZqG29Gv3Q3dWIuuSb184X9E8wGuYjp
         BY7ln5lmgBS8gvYbH24KJ0KYFUucbKM8pnUX/iVLU8VXnj3Yr8+vrHGyBl7idZ7y+N
         Ib5VMCtSDVvfw==
Date:   Sun, 8 Aug 2021 10:41:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot
 time parameter.
Message-ID: <YQ+KtEuGswi5VYH2@kernel.org>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
 <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
 <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 06:54:14PM +0200, Vlastimil Babka wrote:
> On 8/6/21 6:16 PM, David Hildenbrand wrote:
> > On 06.08.21 17:36, Vlastimil Babka wrote:
> >> On 8/5/21 9:02 PM, Zi Yan wrote:
> >>> From: Zi Yan <ziy@nvidia.com>
> >>
> >>> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
> >>> pages across memory sections. The check was removed when ARM64 gets rid of holes
> >>> in zones, but holes can appear in zones again after this patchset.
> >>
> >> To me that's most unwelcome resurrection. I kinda missed it was going away and
> >> now I can't even rejoice? I assume the systems that will be bumping max_order
> >> have a lot of memory. Are they going to have many holes? What if we just
> >> sacrificed the memory that would have a hole and don't add it to buddy at all?
> > 
> > I think the old implementation was just horrible and the description we have
> > here still suffers from that old crap: "but holes can appear in zones again".
> > No, it's not related to holes in zones at all. We can have MAX_ORDER -1 pages
> > that are partially a hole.
> > 
> > And to be precise, "hole" here means "there is no memmap" and not "there is a
> > hole but it has a valid memmap".
> 
> Yes.
> 
> > But IIRC, we now have under SPARSEMEM always a complete memmap for a complete
> > memory sections (when talking about system RAM, ZONE_DEVICE is different but we
> > don't really care for now I think).
> > 
> > So instead of introducing what we had before, I think we should look into
> > something that doesn't confuse each person that stumbles over it out there. What
> > does pfn_valid_within() even mean in the new context? pfn_valid() is most
> > probably no longer what we really want, as we're dealing with multiple sections
> > that might be online or offline; in the old world, this was different, as a
> > MAX_ORDER -1 page was completely contained in a memory section that was either
> > online or offline.
> > 
> > I'd imagine something that expresses something different in the context of
> > sparsemem:
> > 
> > "Some page orders, such as MAX_ORDER -1, might span multiple memory sections.
> > Each memory section has a completely valid memmap if online. Memory sections
> > might either be completely online or completely offline. pfn_to_online_page()
> > might succeed on one part of a MAX_ORDER - 1 page, but not on another part. But
> > it will certainly be consistent within one memory section."
> > 
> > Further, as we know that MAX_ORDER -1 and memory sections are a power of two, we
> > can actually do a binary search to identify boundaries, instead of having to
> > check each and every page in the range.
> > 
> > Is what I describe the actual reason why we introduce pfn_valid_within() ? (and
> > might better introduce something new, with a better fitting name?)
> 
> What I don't like is mainly the re-addition of pfn_valid_within() (or whatever
> we'd call it) into __free_one_page() for performance reasons, and also to
> various pfn scanners (compaction) for performance and "I must not forget to
> check this, or do I?" confusion reasons. It would be really great if we could
> keep a guarantee that memmap exists for MAX_ORDER blocks.

Maybe I'm missing something, but what if we use different constants to
define maximal allocation order buddy can handle and maximal size of
reasonable physically contiguous chunk?
I've skimmed through the uses of MAX_ORDER and it seems that many of those
could use, say, pageblock_order of several megabytes rather than MAX_ORDER.

If we only use MAX_ORDER to denote the maximal allocation order and keep
PFN walkers to use smaller pageblock order that we'll be able to have valid
memory map in all the cases. 

Then we can work out how to make migration/compaction etc to process 1G
pages.

> I see two ways to achieve that:
> 
> 1. we create memmap for MAX_ORDER blocks, pages in sections not online are
> marked as reserved or some other state that allows us to do checks such as "is
> there a buddy? no" without accessing a missing memmap
> 2. smaller blocks than MAX_ORDER are not released to buddy allocator
> 
> I think 1 would be more work, but less wasteful in the end?

-- 
Sincerely yours,
Mike.
