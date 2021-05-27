Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40110393454
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhE0Qye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhE0Qyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:54:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:52:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s12so705281qta.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tW8aVIUgOS3ZLnQ4gtbVHOeCP2dupOYTeHOn+YcgsqU=;
        b=ATsfEW9uBHQ1lJfvp9JfTAX8Fs6pyiQCOirMRd1RT15806+L0T4hKneKMlxa9ExuSB
         l1Z7q+E6zWEGQ3IK3zAV9uEoaMc/Sr3ANqW84lDzLrtxP6hmY2rFVTIUItqj+Ah/GISX
         YeRJ1HUfUyJ4lpZfQfZPNYrhsWYZROkB8WnYI9lXSub50fLe8PzZY/UelFDQ+hHPoXIz
         hl90Iw/BeMXTozJa+06tDNgwMCR7l0l68WqhBCW1wgao1YvD3g1WY0vnwBAYYIoBjvcc
         MtScb0fdbPD3rDHLOZylaniwQKmtvQpMrbfdaCwohAs2F5gEgu6oF8clsNYJC1sFjOs6
         YC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tW8aVIUgOS3ZLnQ4gtbVHOeCP2dupOYTeHOn+YcgsqU=;
        b=qOl9Rq6Frs4NJV8knxC4SsgWV2XT0OQI/kprKgU3O9gFngQFjeIN9NYOPfGlYx8StN
         TItDdDP+mgG0fGANclUOwc04cfni9FhoF3qYp8U8uMkYf+fZgK9uUE5vbpe02CBQft/K
         xI+C+jxkSTbp9QG8kGsKWMv+vSR6Xois9EG0TLHZh9I0q8vl45GNoTfYa8vWL+DkvVOM
         fLfUz2HLCISQugqXgZKkMdVybSHmwIL30DY8YVWUIvCKJo7OqAQ30CZqL4l8S24GziYR
         0QHfhYa6vIJtud4MisP6cqyyVL1LmBFDmvt8L+CuXqy6hOYfV9EgETa7D7LuhWQ9/eyG
         LNBw==
X-Gm-Message-State: AOAM531GJsyZvf1F2QTLkt7fSJv/E2GsnRC8WYc/WHaeFzQISEtPr5v4
        byBgFlVHfaLXUbHMrLPLjbq9aZeLsH5frw==
X-Google-Smtp-Source: ABdhPJznhir0qZTsiDkeQ5vEx1jVCVaUERWECV17Sem7uftFd4thCN6fIn+s/lZK2hc6bTlqlhi2qg==
X-Received: by 2002:ac8:5751:: with SMTP id 17mr3970984qtx.389.1622134378469;
        Thu, 27 May 2021 09:52:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a6a3])
        by smtp.gmail.com with ESMTPSA id h8sm1639554qtp.46.2021.05.27.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:52:57 -0700 (PDT)
Date:   Thu, 27 May 2021 12:52:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -V2] mm: move idle swap cache pages to the tail of LRU
 after COW
Message-ID: <YK/OaEAwL4cufITY@cmpxchg.org>
References: <20210527084953.573788-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527084953.573788-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:49:53PM +0800, Huang Ying wrote:
> With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
> COW, the idle swap cache (neither the page nor the corresponding swap
> entry is mapped by any process) will be left at the original position
> in the LRU list.  While it may be in the active list or the head of
> the inactive list, so that vmscan may take more overhead or time to
> reclaim these actually unused pages.
> 
> To help the page reclaiming, in this patch, after COW, the idle swap
> cache will be tried to be moved to the tail of the inactive LRU list.
> To avoid to introduce much overhead to the hot COW code path, all
> locks are acquired with try locking.
> 
> To test the patch, we used pmbench memory accessing benchmark with
> working-set larger than available memory on a 2-socket Intel server
> with a NVMe SSD as swap device.  Test results shows that the pmbench
> score increases up to 21.8% with the decreased size of swap cache and
> swapin throughput.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> 
> V2:
> 
> - Move trylock_page() to try_to_free_idle_swapcache() per Rik and
>   Linus' comments.
> - Fix PageLRU() checking.
> - Fix THP processing.
> - Rename the function.
> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  include/linux/swap.h       |  3 +++
>  mm/memcontrol.c            | 12 ++++++++++++
>  mm/memory.c                |  2 ++
>  mm/swapfile.c              | 39 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+)

Sorry the discussion fizzled out on the last patch.

Let me try to recap this series: on your first submission you directly
freed the old page if we copied. Linus was worried about overhead in
the COW path that wouldn't pay off in a real workload. Before getting
numbers, it was then suggested to move the pages to the tail of the
LRU and leaving them to reclaim - which was also met with skepticism.

V2 presented the LRU moving version with pmbench numbers that indeed
show it pays off. However, much simpler direct freeing produces even
better numbers in the same benchmark. We don't have numbers showing if
the LRU shuffling would significantly fare better in other workloads.

Purely looking at the code: whether we defer or free, we need to lock
the page, take the LRU spinlock for this page, and touch the LRU
linkage. If we free, we add the swapcache deletion and the page
allocator, but it's most likely the percpu-cached fastpath. If we
defer, reclaim needs to re-establish information about the page that
we already had in the COW context, do another LRU operation, do the
swapcache deletion and go through the allocator, but on cold caches.

Personally, I'm a bit skeptical the extra code complexity and reclaim
overhead in paging workloads will definitely pay off in intermittently
paging loads (non-paging wouldn't have swap pages). As far as code
goes, the point of 09854ba94c6a (+17, -42) was simplification, and
this adds more lines back in another place. In particular it adds
another lifetime variant to swap pages which are already somewhat
unwieldy. OTOH, freeing is a two-liner reusing the swap unmap code:

	if (page_copied)
		free_swap_cache(old_page);

Linus, what do you think?
