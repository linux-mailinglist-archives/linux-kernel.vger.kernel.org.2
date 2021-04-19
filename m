Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D81363953
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhDSCPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:15:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:49488 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhDSCPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:15:43 -0400
IronPort-SDR: XrIkAxIUvo3Op8/Rkgqi5ngQkB1kVOPkh3OL7V6fl59yP884B1/n5/Jx63uwM5nL01moQexEHC
 u1ji6HvSZhng==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="280580654"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="280580654"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:15:14 -0700
IronPort-SDR: iJjwYR+WlUCHdbwjvyCtNT+ukBMAkaTydHU70GJ1WrjiN6l+88DpV2LJgzaiQkjgeJ/vQ5RyFg
 FAqkOlPBbhfw==
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="400478900"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:15:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2 5/5] mm/shmem: fix shmem_swapin() race with swapoff
References: <20210417094039.51711-1-linmiaohe@huawei.com>
        <20210417094039.51711-6-linmiaohe@huawei.com>
Date:   Mon, 19 Apr 2021 10:15:08 +0800
In-Reply-To: <20210417094039.51711-6-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sat, 17 Apr 2021 05:40:39 -0400")
Message-ID: <87r1j7kok3.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> When I was investigating the swap code, I found the below possible race
> window:
>
> CPU 1                                           CPU 2
> -----                                           -----
> shmem_swapin
>   swap_cluster_readahead
>     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
>                                                 swapoff
>                                                   si->flags &= ~SWP_VALID;
>                                                   ..
>                                                   synchronize_rcu();
>                                                   ..

You have removed these code in the previous patches of the series.  And
they are not relevant in this patch.

>                                                   si->swap_file = NULL;
>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>
> Close this race window by using get/put_swap_device() to guard against
> concurrent swapoff.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

No.  This isn't the commit that introduces the race condition.  Please
recheck your git blame result.

Best Regards,
Huang, Ying

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/shmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..936ba5595297 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1492,15 +1492,21 @@ static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
>  static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
>  			struct shmem_inode_info *info, pgoff_t index)
>  {
> +	struct swap_info_struct *si;
>  	struct vm_area_struct pvma;
>  	struct page *page;
>  	struct vm_fault vmf = {
>  		.vma = &pvma,
>  	};
>  
> +	/* Prevent swapoff from happening to us. */
> +	si = get_swap_device(swap);
> +	if (unlikely(!si))
> +		return NULL;
>  	shmem_pseudo_vma_init(&pvma, info, index);
>  	page = swap_cluster_readahead(swap, gfp, &vmf);
>  	shmem_pseudo_vma_destroy(&pvma);
> +	put_swap_device(si);
>  
>  	return page;
>  }
