Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F76420A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhJDLkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232999AbhJDLka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:40:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 290916126A;
        Mon,  4 Oct 2021 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633347522;
        bh=N/fKuI91VrRX38cUMG86Df37anLTauMrP0OpxJCi4EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTkrdlhm3/0e4WSPrswiuvJ6yxGZZH6vwcl2WDPCFYPZr2jn45FbEWl3hH51TPZvb
         OWXVdGRV0O6Uohq6cjITxcYuib0OlvL0GzKGkIvXCwVElxgH6mwQZvj2z2q50wDJJt
         pDBBqywaPqY9+lEuXNzdZW6MW3ye2F6EX4AU9RVSgZOZqZjESk8d60SzEM1tqICqU2
         t2iCEUHmxKSxoEMmRcVQOLsxQGKG6CeJSOV8snLisDSgnLUztVaO6zaGbg4gS1An2d
         EP1YYfA/rty+mBnTxaOkZuFgcYgw78alWYM37TcB7FHtZ1s92B0EqQdli+cv6N1v6W
         +/PJFJ3akjvmg==
Date:   Mon, 4 Oct 2021 12:38:36 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        robin.murphy@arm.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH 5/5] iommu/iova: Avoid double-negatives in magazine
 helpers
Message-ID: <20211004113836.GB27373@willie-the-truck>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632477717-5254-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:01:57PM +0800, John Garry wrote:
> A similar crash to the following could be observed if initial CPU rcache
> magazine allocations fail in init_iova_rcaches():
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
> 
>   free_iova_fast+0xfc/0x280
>   iommu_dma_free_iova+0x64/0x70
>   __iommu_dma_unmap+0x9c/0xf8
>   iommu_dma_unmap_sg+0xa8/0xc8
>   dma_unmap_sg_attrs+0x28/0x50
>   cq_thread_v3_hw+0x2dc/0x528
>   irq_thread_fn+0x2c/0xa0
>   irq_thread+0x130/0x1e0
>   kthread+0x154/0x158
>   ret_from_fork+0x10/0x34
> 
> The issue is that expression !iova_magazine_full(NULL) evaluates true; this
> falls over in __iova_rcache_insert() when we attempt to cache a mag and
> cpu_rcache->loaded == NULL:
> 
> if (!iova_magazine_full(cpu_rcache->loaded)) {
> 	can_insert = true;
> ...
> 
> if (can_insert)
> 	iova_magazine_push(cpu_rcache->loaded, iova_pfn);
> 
> As above, can_insert is evaluated true, which it shouldn't be, and we try
> to insert pfns in a NULL mag, which is not safe.
> 
> To avoid this, stop using double-negatives, like !iova_magazine_full() and
> !iova_magazine_empty(), and use positive tests, like
> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
> can safely deal with cpu_rcache->{loaded, prev} = NULL.

I don't understand why you're saying that things like !iova_magazine_empty()
are double-negatives. What about e.g. !list_empty() elsewhre in the kernel?

The crux of the fix seems to be:

> @@ -783,8 +787,9 @@ static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
>  		if (new_mag) {
>  			spin_lock(&rcache->lock);
>  			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> -				rcache->depot[rcache->depot_size++] =
> -						cpu_rcache->loaded;
> +				if (cpu_rcache->loaded)
> +					rcache->depot[rcache->depot_size++] =
> +							cpu_rcache->loaded;

Which could be independent of the renaming?

Will
