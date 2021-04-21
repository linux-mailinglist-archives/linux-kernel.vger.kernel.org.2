Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB0366346
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhDUBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:03:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:39187 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhDUBD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:03:28 -0400
IronPort-SDR: 0wXGyT/Q6B3lHDQq6/6UbJfMebtuUb1Rlv04ls+Ykx6QF3gb4zkgxtY8Xqvw1bXJ8Njf2lbKd/
 mLGomCtBLgwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175727864"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="175727864"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 18:02:56 -0700
IronPort-SDR: iNNOnKMleJUK5iC0GvLhy2gB+oOZQynE/LB/uKmQg013EFDr0D1RGANaf02s73eyJvGHTlPD06
 C32nECZQlvRQ==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="463396021"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 18:02:52 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 4/4] mm/shmem: fix shmem_swapin() race with swapoff
References: <20210420133048.6773-1-linmiaohe@huawei.com>
        <20210420133048.6773-5-linmiaohe@huawei.com>
Date:   Wed, 21 Apr 2021 09:02:49 +0800
In-Reply-To: <20210420133048.6773-5-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 20 Apr 2021 09:30:48 -0400")
Message-ID: <87y2dc1mbq.fsf@yhuang6-desk1.ccr.corp.intel.com>
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
> CPU 1                                         CPU 2
> -----                                         -----
> shmem_swapin
>   swap_cluster_readahead
>     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
>                                               swapoff
>                                                 percpu_ref_kill(&p->users)
>                                                 synchronize_rcu()
>                                                 wait_for_completion

I don't think the above 3 lines are relevant for the race.

>                                                 ..
>                                                 si->swap_file = NULL;
>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>
> Close this race window by using get/put_swap_device() to guard against
> concurrent swapoff.
>
> Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
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

Better to put get/put_swap_device() in shmem_swapin_page(), that make it
possible for us to remove get/put_swap_device() in lookup_swap_cache().

Best Regards,
Huang, Ying

> +	if (unlikely(!si))
> +		return NULL;
>  	shmem_pseudo_vma_init(&pvma, info, index);
>  	page = swap_cluster_readahead(swap, gfp, &vmf);
>  	shmem_pseudo_vma_destroy(&pvma);
> +	put_swap_device(si);
>  
>  	return page;
>  }
