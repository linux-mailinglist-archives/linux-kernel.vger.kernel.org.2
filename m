Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCCA3972C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhFALua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFALu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:50:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88781C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FG8QsXBT9RwonVdLjIFuZXWFVzP4Jy7oyS+/HVeFnwk=; b=U8zo4BcNXFspX345/GEHZU/xcq
        O1pN3s1GYhzCNlGlH7kB+2/c/YQys3SXLbhl7xrZBY8y5cPTpOKbfdARhdOxdQn8nWMpWNSlc5k8y
        yq9rl3VuvQdiI9nyJMMyx/pMovjihUJRfTvRRVQc3hYjUn/BucuiqrAh7WDsj5rryy8ayhNrr2wIg
        XtD2nv5CI/bzn0BLPc8lVsY91HXtWuFCeq0c74iFJeYL+Ezf55KnazeRgoXLmRzKxG07bNeL+nYJa
        x4D27m85R0mEJ4PbSyn+7gtBDG7DeWVtHrNQ5Il4BlE/hcREg0yn25CgnMgp9escsGZ4tvt30m+2A
        XPFZI+1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lo2sZ-009zEi-JF; Tue, 01 Jun 2021 11:48:19 +0000
Date:   Tue, 1 Jun 2021 12:48:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: free idle swap cache page after COW
Message-ID: <YLYef3i2OGseGbsS@casper.infradead.org>
References: <20210601053143.1380078-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601053143.1380078-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 01:31:43PM +0800, Huang Ying wrote:
> With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
> COW, the idle swap cache page (neither the page nor the corresponding
> swap entry is mapped by any process) will be left in the LRU list,
> even if it's in the active list or the head of the inactive list.  So,
> the page reclaimer may take quite some overhead to reclaim these
> actually unused pages.
> 
> To help the page reclaiming, in this patch, after COW, the idle swap
> cache page will be tried to be freed.  To avoid to introduce much
> overhead to the hot COW code path,
> 
> a) there's almost zero overhead for non-swap case via checking
>    PageSwapCache() firstly.
> 
> b) the page lock is acquired via trylock only.
> 
> To test the patch, we used pmbench memory accessing benchmark with
> working-set larger than available memory on a 2-socket Intel server
> with a NVMe SSD as swap device.  Test results shows that the pmbench
> score increases up to 23.8% with the decreased size of swap cache and
> swapin throughput.

So 2 percentage points better than my original idea?  Sweet.

> diff --git a/mm/memory.c b/mm/memory.c
> index 2b7ffcbca175..d44425820240 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3104,6 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  				munlock_vma_page(old_page);
>  			unlock_page(old_page);
>  		}
> +		if (page_copied)
> +			free_swap_cache(old_page);
>  		put_page(old_page);
>  	}
>  	return page_copied ? VM_FAULT_WRITE : 0;

Why not ...

		if (page_copied)
			free_page_and_swap_cache(old_page);
		else
			put_page(old_page);

then you don't need to expose free_swap_cache().  Or does the test for
huge_zero_page mess this up?

