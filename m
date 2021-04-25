Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3200E36A452
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhDYDH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:07:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:22914 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhDYDHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:07:53 -0400
IronPort-SDR: xcpAz9NFaRmU6DkP1ELkK1+SnKDDnUmitRyrGzq7pfP6TrorEH54Ah7Qsn/MAVCXcCm/eban4c
 Miwn6NLSkTvg==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="195762760"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="195762760"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:07:14 -0700
IronPort-SDR: tb7Uxd0r54Hy4tnkUnO2ZpI1EabmeQSPKX52feURX78+7Q0v31a3MwON9PupyowYQUzYq5MUek
 DxIYxI/RSccw==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="422203786"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:07:09 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 4/4] mm/shmem: fix shmem_swapin() race with swapoff
References: <20210425023806.3537283-1-linmiaohe@huawei.com>
        <20210425023806.3537283-5-linmiaohe@huawei.com>
Date:   Sun, 25 Apr 2021 11:07:07 +0800
In-Reply-To: <20210425023806.3537283-5-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sun, 25 Apr 2021 10:38:06 +0800")
Message-ID: <87bla3xdt0.fsf@yhuang6-desk1.ccr.corp.intel.com>
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
>                                                 ..
>                                                 si->swap_file = NULL;
>                                                 ..
>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>
> Close this race window by using get/put_swap_device() to guard against
> concurrent swapoff.
>
> Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/shmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..be388d0cf8b5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> +	struct swap_info_struct *si;
>  	struct page *page;
>  	swp_entry_t swap;
>  	int error;
> @@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	swap = radix_to_swp_entry(*pagep);
>  	*pagep = NULL;
>  
> +	/* Prevent swapoff from happening to us. */
> +	si = get_swap_device(swap);
> +	if (unlikely(!si)) {
> +		error = EINVAL;
> +		goto failed;
> +	}
>  	/* Look it up and read it in.. */
>  	page = lookup_swap_cache(swap, NULL, 0);
>  	if (!page) {
> @@ -1720,6 +1727,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  			goto failed;
>  		}
>  	}
> +	put_swap_device(si);

I think it's better to put_swap_device() just before returning from the
function.  It's not a big issue to slow down swapoff() a little.  And
this will make the logic easier to be understood.

Best Regards,
Huang, Ying

>  
>  	/* We have to do this with page locked to prevent races */
>  	lock_page(page);
> @@ -1775,6 +1783,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  		put_page(page);
>  	}
>  
> +	if (si)
> +		put_swap_device(si);
> +
>  	return error;
>  }
