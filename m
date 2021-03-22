Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE293437B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVEBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:01:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D88C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 21:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/PNbB4Hs0P8VQvycE2RHeV03E5g+vzC0dusBDgCGN8Y=; b=V4Xzv9EDO5mfSxevQTyWoompd9
        +SZhKCbWHzTRbJJet/cvCtbVPysHyoapEY/kCOVBMuFr152fYXIx81d0PU0LW0yim1D8h5wurAY1U
        Pxa0t/CVAO8tfCG9gItVTrGXQ0dwm3S9GPzA/MgQ9vGGTt02FEzQlukxowUa3tC5j8MfVHGRnQcmr
        SkQ+iksSx1KS5Eu/HdEaoJjQja3KSzu/519wpXYJSyubf3oIsllgN6yYxwOqoV+UgV3I1vqLVA3Z9
        6uVobhTm5gI5fuAHAny+wCvXeu3lA95OTbK9CxsJ3BdQ2XYmOoWCkvaw9Fpd9Xk9dpvBMEWxe2ZL9
        GVl3t1pQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOBkh-00Apyn-KP; Mon, 22 Mar 2021 04:01:16 +0000
Subject: Re: [PATCH] mm: Fix typos in comments
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>
References: <20210322025152.GA1922846@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c098463-9db9-372f-82ba-48a12849707f@infradead.org>
Date:   Sun, 21 Mar 2021 21:01:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322025152.GA1922846@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 7:51 PM, Ingo Molnar wrote:
> 
> Fix ~93 single-word typos in locking code comments, plus a few very 
> obvious grammar mistakes.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mm.h      |  2 +-
>  include/linux/vmalloc.h |  4 ++--
>  mm/balloon_compaction.c |  4 ++--
>  mm/compaction.c         |  2 +-
>  mm/filemap.c            |  2 +-
>  mm/gup.c                |  2 +-
>  mm/highmem.c            |  2 +-
>  mm/huge_memory.c        |  4 ++--
>  mm/hugetlb.c            |  4 ++--
>  mm/internal.h           |  2 +-
>  mm/kasan/kasan.h        |  8 ++++----
>  mm/kasan/quarantine.c   |  4 ++--
>  mm/kasan/shadow.c       |  4 ++--
>  mm/kfence/report.c      |  2 +-
>  mm/khugepaged.c         |  2 +-
>  mm/kmemleak.c           |  2 +-
>  mm/ksm.c                |  4 ++--
>  mm/madvise.c            |  4 ++--
>  mm/memcontrol.c         | 18 +++++++++---------
>  mm/memory-failure.c     |  2 +-
>  mm/memory.c             | 12 ++++++------
>  mm/mempolicy.c          |  4 ++--
>  mm/migrate.c            |  8 ++++----
>  mm/mmap.c               |  4 ++--
>  mm/mprotect.c           |  2 +-
>  mm/mremap.c             |  2 +-
>  mm/oom_kill.c           |  2 +-
>  mm/page-writeback.c     |  4 ++--
>  mm/page_alloc.c         | 14 +++++++-------
>  mm/page_owner.c         |  2 +-
>  mm/page_reporting.c     |  2 +-
>  mm/percpu-internal.h    |  2 +-
>  mm/percpu.c             |  2 +-
>  mm/pgalloc-track.h      |  6 +++---
>  mm/slab.c               |  8 ++++----
>  mm/slub.c               | 10 +++++-----
>  mm/swap_slots.c         |  2 +-
>  mm/swap_state.c         |  2 +-
>  mm/swapfile.c           |  4 ++--
>  mm/util.c               |  2 +-
>  mm/vmalloc.c            |  8 ++++----
>  mm/vmstat.c             |  2 +-
>  mm/zpool.c              |  2 +-
>  mm/zsmalloc.c           |  2 +-
>  44 files changed, 93 insertions(+), 93 deletions(-)

> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f4476e68e..048686fba230 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1977,7 +1977,7 @@ static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
>  	unsigned int wmark_low;
>  
>  	/*
> -	 * Cap the low watermak to avoid excessive compaction
> +	 * Cap the low watermark to avoid excessive compaction
>  	 * activity in case a user sets the proactivess tunable

	                                    proactiveness
?

>  	 * close to 100 (maximum).
>  	 */
> diff --git a/mm/memory.c b/mm/memory.c
> index 5efa07fb6cdc..a0d4fedd5e9b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4463,7 +4463,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>   * @flags: the fault flags.
>   * @ret: the fault retcode.
>   *
> - * This will take care of most of the page fault accountings.  Meanwhile, it
> + * This will take care of most of the page fault accounting.  Meanwhile, it
>   * will also include the PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN] perf counter
>   * updates.  However note that the handling of PERF_COUNT_SW_PAGE_FAULTS should

                However,

>   * still be in per-arch page fault handlers at the entry of page fault.
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index c50d93ffa252..8b9197074632 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -86,7 +86,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
>  			continue;
>  
>  		/*
> -		 * If page was not comingled with another page we can
> +		 * If page was not commingled with another page we can

Either spelling seems to be acceptable.

>  		 * consider the result to be "reported" since the page
>  		 * hasn't been modified, otherwise we will need to
>  		 * report on the new larger page when we make our way
> diff --git a/mm/slub.c b/mm/slub.c
> index 3021ce9bf1b3..a48892cc8359 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index be9de6d5b516..0158aa9c3e55 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -16,7 +16,7 @@
>   * to local caches without needing to acquire swap_info
>   * lock.  We do not reuse the returned slots directly but
>   * move them back to the global pool in a batch.  This
> - * allows the slots to coaellesce and reduce fragmentation.
> + * allows the slots to coalescence and reduce fragmentation.

                       to coalesce

>   *
>   * The swap entry allocated is marked with SWAP_HAS_CACHE
>   * flag in map_count that prevents it from being allocated


Mostly looks like a good, big cleanup. Thanks.

-- 
~Randy

