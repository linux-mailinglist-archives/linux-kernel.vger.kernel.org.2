Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6600345581
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCWCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:34:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14843 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCWCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:34:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4FlQ169Nz92lh;
        Tue, 23 Mar 2021 10:32:50 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 10:34:45 +0800
Subject: Re: [PATCH 02/23] mm: Clear vmf->pte after pte_unmap_same() returns
To:     Peter Xu <peterx@redhat.com>
CC:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Axel Rasmussen" <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-3-peterx@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <28c1dfdc-b72b-88a7-411c-effc078f774a@huawei.com>
Date:   Tue, 23 Mar 2021 10:34:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210323004912.35132-3-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/23 8:48, Peter Xu wrote:
> pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
> will not be valid any more.  We should clear it.
> 
> It was safe only because no one is accessing vmf->pte after pte_unmap_same()
> returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
> where vmf->pte will in most cases be overwritten very soon.
> 
> pte_unmap_same() will be used in other places in follow up patches, so that
> vmf->pte will not always be re-written.  This patch enables us to call
> functions like finish_fault() because that'll conditionally unmap the pte by
> checking vmf->pte first.  Or, alloc_set_pte() will make sure to allocate a new
> pte even after calling pte_unmap_same().
> 
> Since we'll need to modify vmf->pte, directly pass in vmf into pte_unmap_same()
> and then we can also avoid the long parameter list.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Good cleanup! Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/memory.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index a458a595331f..d534eba85756 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2607,19 +2607,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
>   * proceeding (but do_wp_page is only called after already making such a check;
>   * and do_anonymous_page can safely check later on).
>   */
> -static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
> -				pte_t *page_table, pte_t orig_pte)
> +static inline int pte_unmap_same(struct vm_fault *vmf)
>  {
>  	int same = 1;
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
>  	if (sizeof(pte_t) > sizeof(unsigned long)) {
> -		spinlock_t *ptl = pte_lockptr(mm, pmd);
> +		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>  		spin_lock(ptl);
> -		same = pte_same(*page_table, orig_pte);
> +		same = pte_same(*vmf->pte, vmf->orig_pte);
>  		spin_unlock(ptl);
>  	}
>  #endif
> -	pte_unmap(page_table);
> +	pte_unmap(vmf->pte);
> +	/* After unmap of pte, the pointer is invalid now - clear it. */
> +	vmf->pte = NULL;
>  	return same;
>  }
>  
> @@ -3308,7 +3309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
>  
> -	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
> +	if (!pte_unmap_same(vmf))
>  		goto out;
>  
>  	entry = pte_to_swp_entry(vmf->orig_pte);
> 

