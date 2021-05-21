Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7342A38BC41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhEUCGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:06:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:26558 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhEUCGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:06:50 -0400
IronPort-SDR: 8kIxRO2jYPh21gpieYo5/EW+DDrG17FDZAkBfKh8G9P7MZb4NGb2y6bEVUEqplIaNn2V0HTCr5
 P0AJo4kNJzXw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201421274"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201421274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:05:28 -0700
IronPort-SDR: ozfDnHgnfmd6Um2s85dibhgvFoBS92YBbMvNTPTJZ74PI7MLraeXnzMmwyh7L8+2+M86u29a6B
 j8AKOMxTOGpg==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440705454"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:05:24 -0700
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
        <87im3e88ss.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YKahMXCwDRlBksAU@cmpxchg.org>
Date:   Fri, 21 May 2021 10:05:21 +0800
In-Reply-To: <YKahMXCwDRlBksAU@cmpxchg.org> (Johannes Weiner's message of
        "Thu, 20 May 2021 13:49:37 -0400")
Message-ID: <87wnrs7sf2.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Thu, May 20, 2021 at 09:59:15AM +0800, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> 
>> > On Thu, May 20, 2021 at 09:22:45AM +0800, Huang, Ying wrote:
>> >> Johannes Weiner <hannes@cmpxchg.org> writes:
>> >> 
>> >> > On Wed, May 19, 2021 at 09:33:13AM +0800, Huang Ying wrote:
>> >> >> diff --git a/mm/memory.c b/mm/memory.c
>> >> >> index b83f734c4e1d..2b6847f4c03e 100644
>> >> >> --- a/mm/memory.c
>> >> >> +++ b/mm/memory.c
>> >> >> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>> >> >>  				munlock_vma_page(old_page);
>> >> >>  			unlock_page(old_page);
>> >> >>  		}
>> >> >> +		if (page_copied && PageSwapCache(old_page) &&
>> >> >> +		    !page_mapped(old_page) && trylock_page(old_page)) {
>> >> >> +			try_to_free_idle_swapcache(old_page);
>> >> >> +			unlock_page(old_page);
>> >> >
>> >> > If there are no more swap or pte references, can we just attempt to
>> >> > free the page right away, like we do during regular unmap?
>> >> >
>> >> > 		if (page_copied)
>> >> > 			free_swap_cache(old_page);
>> >> > 		put_page(old_page);
>> >> 
>> >> A previous version of the patch does roughly this.
>> >> 
>> >> https://lore.kernel.org/lkml/20210113024241.179113-1-ying.huang@intel.com/
>> >> 
>> >> But Linus has concerns with the overhead introduced in the hot COW path.
>> >
>> > Sorry, I had missed that thread.
>> >
>> > It sounds like there were the same concerns about the LRU shuffling
>> > overhead in the COW page. Now we have numbers for that, but not the
>> > free_swap_cache version. Would you be able to run the numbers for that
>> > as well? It would be interesting to see how much the additional code
>> > complexity buys us.
>> 
>> The number for which workload?  The workload that is used to evaluate
>> this patch?
>
> Yeah, the pmbench one from the changelog.

Sure.  I have rebased the original patch that frees the idle swap cache
directly and done the test.  The results show that the pmbench score of
freeing directly is a little better than that of moving to the tail of
LRU.  The pmbench score increases about 3.6%.  I think this is expected,
because we need to free the page finally even if we move the idle swap
cache to the tail of LRU.

Best Regards,
Huang, Ying
