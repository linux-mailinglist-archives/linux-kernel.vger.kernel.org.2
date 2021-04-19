Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1745363930
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhDSByy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:54:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:4805 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhDSByx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:54:53 -0400
IronPort-SDR: UtEFBEKM5+Nikcsr7KevQeY5vNCeq3NGr1Tx6alDi6ITnet9KYbSlqAWfwvYCgilDbvotTd02v
 KaHvKMxTygkg==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="194813445"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="194813445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 18:54:05 -0700
IronPort-SDR: hoTCn/vzA05C4boFdlGAPO5290DZ1QWFyaG6qW/vyzCSd8GP1DCE5+YLM5Y+L0DzKJe8WfL/pU
 rUPd0pVnAF8A==
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="426326638"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 18:53:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2 4/5] mm/swap: remove confusing checking for
 non_swap_entry() in swap_ra_info()
References: <20210417094039.51711-1-linmiaohe@huawei.com>
        <20210417094039.51711-5-linmiaohe@huawei.com>
Date:   Mon, 19 Apr 2021 09:53:42 +0800
In-Reply-To: <20210417094039.51711-5-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sat, 17 Apr 2021 05:40:38 -0400")
Message-ID: <87v98jkpjt.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> While we released the pte lock, somebody else might faulted in this pte.
> So we should check whether it's swap pte first to guard against such race
> or swp_type would be unexpected. But the swap_entry isn't used in this
> function and we will have enough checking when we really operate the PTE
> entries later. So checking for non_swap_entry() is not really needed here
> and should be removed to avoid confusion.

Please rephrase the change log to describe why we have the code and why
it's unnecessary now.  You can dig the git history via git-blame to find
out it.

The patch itself looks good to me.

Best Regards,
Huang, Ying

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swap_state.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 272ea2108c9d..df5405384520 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -721,7 +721,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long ra_val;
> -	swp_entry_t entry;
>  	unsigned long faddr, pfn, fpfn;
>  	unsigned long start, end;
>  	pte_t *pte, *orig_pte;
> @@ -739,11 +738,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>  
>  	faddr = vmf->address;
>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
> -	entry = pte_to_swp_entry(*pte);
> -	if ((unlikely(non_swap_entry(entry)))) {
> -		pte_unmap(orig_pte);
> -		return;
> -	}
>  
>  	fpfn = PFN_DOWN(faddr);
>  	ra_val = GET_SWAP_RA_VAL(vma);
