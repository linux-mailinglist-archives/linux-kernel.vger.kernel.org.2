Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47E389B17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhETCAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:00:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:28360 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhETCAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:00:41 -0400
IronPort-SDR: 9ilHHvu3XFYG241UlYPqHJSwX1Df0nmi9IWeaOA664HAorf7ErFNf3JUBbB/EyEnWn88FEqcXU
 tYffy1+sDuUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="201177919"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201177919"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 18:59:20 -0700
IronPort-SDR: ldgRelLTgLkDSbx7NbL3uTtmESuVHgjQi6rC2dIQwEub0NGXnr8TdgNobmkvsZJvX14jJ/GIOa
 J7JkM8A92hQA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440088576"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 18:59:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
References: <20210519013313.1274454-1-ying.huang@intel.com>
        <YKUlfeAiq/vv+dHl@cmpxchg.org>
        <87r1i28ahm.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YKW/ix3Yg5HRuBaC@cmpxchg.org>
Date:   Thu, 20 May 2021 09:59:15 +0800
In-Reply-To: <YKW/ix3Yg5HRuBaC@cmpxchg.org> (Johannes Weiner's message of
        "Wed, 19 May 2021 21:46:51 -0400")
Message-ID: <87im3e88ss.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Thu, May 20, 2021 at 09:22:45AM +0800, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> 
>> > On Wed, May 19, 2021 at 09:33:13AM +0800, Huang Ying wrote:
>> >> diff --git a/mm/memory.c b/mm/memory.c
>> >> index b83f734c4e1d..2b6847f4c03e 100644
>> >> --- a/mm/memory.c
>> >> +++ b/mm/memory.c
>> >> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>> >>  				munlock_vma_page(old_page);
>> >>  			unlock_page(old_page);
>> >>  		}
>> >> +		if (page_copied && PageSwapCache(old_page) &&
>> >> +		    !page_mapped(old_page) && trylock_page(old_page)) {
>> >> +			try_to_free_idle_swapcache(old_page);
>> >> +			unlock_page(old_page);
>> >
>> > If there are no more swap or pte references, can we just attempt to
>> > free the page right away, like we do during regular unmap?
>> >
>> > 		if (page_copied)
>> > 			free_swap_cache(old_page);
>> > 		put_page(old_page);
>> 
>> A previous version of the patch does roughly this.
>> 
>> https://lore.kernel.org/lkml/20210113024241.179113-1-ying.huang@intel.com/
>> 
>> But Linus has concerns with the overhead introduced in the hot COW path.
>
> Sorry, I had missed that thread.
>
> It sounds like there were the same concerns about the LRU shuffling
> overhead in the COW page. Now we have numbers for that, but not the
> free_swap_cache version. Would you be able to run the numbers for that
> as well? It would be interesting to see how much the additional code
> complexity buys us.

The number for which workload?  The workload that is used to evaluate
this patch?

>> Another possibility is to move the idle swap cache page to the tail of
>> the file LRU list.  But the question is how to identify the page.
>
> The LRU type is identified by PG_swapbacked, and we do clear that for
> anon pages to implement MADV_FREE. It may work here too. But I'm
> honestly a bit skeptical about the ROI on this...

The definition of PageSwapCache() is

static __always_inline int PageSwapCache(struct page *page)
{
#ifdef CONFIG_THP_SWAP
	page = compound_head(page);
#endif
	return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
}

So we cannot clear PG_swapbacked directly.

Best Regards,
Huang, Ying
