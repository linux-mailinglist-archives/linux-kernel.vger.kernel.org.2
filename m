Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A7359848
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhDIIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:50:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:45794 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhDIIui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:38 -0400
IronPort-SDR: Drgww6uLaV4L8ECM4dKXbxLpnQVdrc6hGDBEnavJ7bWZJSVI58gTkHl7al8x1awTiheOSA+z0G
 7kECTuI0mIlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="278997562"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="278997562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:50:25 -0700
IronPort-SDR: 2nVKxe0lWGZr4gIsqpDas1QZRO3N/XmeLyWI1dgidfpFhm0vVZAym3tcAZ4cB7jhA/kAIuGcOS
 0oU0VWjOTplQ==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="422644512"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:50:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] mm/swap_state: fix potential faulted in race in
 swap_ra_info()
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-5-linmiaohe@huawei.com>
Date:   Fri, 09 Apr 2021 16:50:18 +0800
In-Reply-To: <20210408130820.48233-5-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Thu, 8 Apr 2021 09:08:19 -0400")
Message-ID: <874kgfyh85.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> While we released the pte lock, somebody else might faulted in this pte.
> So we should check whether it's swap pte first to guard against such race
> or swp_type would be unexpected. And we can also avoid some unnecessary
> readahead cpu cycles possibly.
>
> Fixes: ec560175c0b6 ("mm, swap: VMA based swap readahead")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swap_state.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 709c260d644a..3bf0d0c297bc 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -724,10 +724,10 @@ static void swap_ra_info(struct vm_fault *vmf,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long ra_val;
> -	swp_entry_t entry;
> +	swp_entry_t swap_entry;
>  	unsigned long faddr, pfn, fpfn;
>  	unsigned long start, end;
> -	pte_t *pte, *orig_pte;
> +	pte_t *pte, *orig_pte, entry;
>  	unsigned int max_win, hits, prev_win, win, left;
>  #ifndef CONFIG_64BIT
>  	pte_t *tpte;
> @@ -742,8 +742,13 @@ static void swap_ra_info(struct vm_fault *vmf,
>  
>  	faddr = vmf->address;
>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
> -	entry = pte_to_swp_entry(*pte);
> -	if ((unlikely(non_swap_entry(entry)))) {
> +	entry = *pte;
> +	if (unlikely(!is_swap_pte(entry))) {
> +		pte_unmap(orig_pte);
> +		return;
> +	}
> +	swap_entry = pte_to_swp_entry(entry);
> +	if ((unlikely(non_swap_entry(swap_entry)))) {
>  		pte_unmap(orig_pte);
>  		return;
>  	}

This isn't a real issue.  entry or swap_entry isn't used in this
function.  And we have enough checking when we really operate the PTE
entries later.  But I admit it's confusing.  So I suggest to just remove
the checking.  We will check it when necessary.

Best Regards,
Huang, Ying
