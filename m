Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903983975F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhFAPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhFAPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:01:59 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2445C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:00:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d12so4725049qtq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glTCffzNZAga2gxixmoJ9kxSIEZt1XeVm/h8KhaD35s=;
        b=UYiCvDbHIuC2W4incbsaJsHUTvAD/ZmPNsxsEKzh29W4tQ1q0bN5L2fD1hY+iZTN9m
         99iS85WHOaDHaJSJzfBIXR3GnsMbniJ9EuPrViJq3zF2Z63mhFeCBbHxayBh9E+x1CiH
         YNWt0U/PgEXyTyzU5ZOA1QeTSLROtng/AswQAbViuGUcoP8tV6bmIl1Q0Zu2Amj1vUSo
         5uRJWA+lJlmRwZ5ZPJ9cFbBZxyGVmJM8ijZNSNvSfW4XBOa9n1puMbCwVxILwrG7MUUC
         ajw6J3n8RkT8UrQ0iVpWJiOA3+y8O23Ggg2kLnRqrPXgqjdJFlaEtlxsyC2QfpD3qceb
         AOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glTCffzNZAga2gxixmoJ9kxSIEZt1XeVm/h8KhaD35s=;
        b=QyD6mMfHJSO9q9hcbvJtsuno4SpOeNPmQH/UfUgVK0IqMB7BTDmNPIspJPLn1cbIrA
         WwALPGzlDqXL24ECQVe1+E4dZTzLX9zoAx0kU1ipvOJDHz7PwQrfBoQ94094lmWBxQIu
         hJVujzpyDrDtOwSRtKvbq8FqHUJiDME9VnrnKtQXWI39hL8aR8yCMdOmXL9rncHW15Bj
         B9fTV1sbe/K5a61VbSaCRyckmN/il7ebHzQ0A3mFVn1lG4oAuNJUpjsrB2XRUE7aGk0C
         Afr9RrBXmNnLGeO7wqKxQZ0ZGZBbL2vaGppFO82vqSuKeGPpq3FDFWxaMcKM4E5HY51s
         LYCQ==
X-Gm-Message-State: AOAM5338NFHkxk91XCm4ZPwjJvlbWm6Lc5cngd2sWZ+8TYKhjwVP75OW
        xb3w+Jn2ckRE+QEmOyTf1MEW/A==
X-Google-Smtp-Source: ABdhPJwdS42FJcT7Cg1mp/Zl97YtISSVdaKqYqhwZLMBjZ8mjLSbReur1d/K7L4WeNFc5us9ikf67Q==
X-Received: by 2002:ac8:5392:: with SMTP id x18mr19923103qtp.381.1622559616950;
        Tue, 01 Jun 2021 08:00:16 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id d21sm2208111qke.29.2021.06.01.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:00:16 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:00:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: free idle swap cache page after COW
Message-ID: <YLZLf7MI11rzGI1B@cmpxchg.org>
References: <20210601053143.1380078-1-ying.huang@intel.com>
 <YLYef3i2OGseGbsS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLYef3i2OGseGbsS@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 12:48:15PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 01, 2021 at 01:31:43PM +0800, Huang Ying wrote:
> > With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
> > COW, the idle swap cache page (neither the page nor the corresponding
> > swap entry is mapped by any process) will be left in the LRU list,
> > even if it's in the active list or the head of the inactive list.  So,
> > the page reclaimer may take quite some overhead to reclaim these
> > actually unused pages.
> > 
> > To help the page reclaiming, in this patch, after COW, the idle swap
> > cache page will be tried to be freed.  To avoid to introduce much
> > overhead to the hot COW code path,
> > 
> > a) there's almost zero overhead for non-swap case via checking
> >    PageSwapCache() firstly.
> > 
> > b) the page lock is acquired via trylock only.
> > 
> > To test the patch, we used pmbench memory accessing benchmark with
> > working-set larger than available memory on a 2-socket Intel server
> > with a NVMe SSD as swap device.  Test results shows that the pmbench
> > score increases up to 23.8% with the decreased size of swap cache and
> > swapin throughput.
> 
> So 2 percentage points better than my original idea?  Sweet.
> 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2b7ffcbca175..d44425820240 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3104,6 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >  				munlock_vma_page(old_page);
> >  			unlock_page(old_page);
> >  		}
> > +		if (page_copied)
> > +			free_swap_cache(old_page);
> >  		put_page(old_page);
> >  	}
> >  	return page_copied ? VM_FAULT_WRITE : 0;
> 
> Why not ...
> 
> 		if (page_copied)
> 			free_page_and_swap_cache(old_page);
> 		else
> 			put_page(old_page);
> 
> then you don't need to expose free_swap_cache().  Or does the test for
> huge_zero_page mess this up?

It's free_page[s]_and_swap_cache() we should reconsider, IMO.

free_swap_cache() makes for a clean API function that does one thing,
and does it right. free_page_and_swap_cache() combines two independent
operations, which has the habit of accumulating special case-handling
for some callers that is unncessary overhead for others (Abstraction
Inversion anti-pattern).

For example, free_page_and_swap_cache() adds an is_huge_zero_page()
check around the put_page() for the tlb batching code. This isn't
needed here. AFAICS it is also unnecessary for the other callsite,
__collapse_huge_page_copy(), where context rules out zero pages.

The common put_page() in Huang's version also makes it slighly easier
to follow the lifetime of old_page.

So I'd say exposing free_swap_cache() is a good move, for this patch
and in general.
