Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF881330B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCHKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:37:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13481 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCHKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:36:52 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DvF8l4L3HzrSV0;
        Mon,  8 Mar 2021 18:35:03 +0800 (CST)
Received: from [10.174.179.232] (10.174.179.232) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Mar 2021 18:36:46 +0800
Subject: Re: [PATCH] mm/huge_memory.c: Remove unnecessary local variable ret2
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210210072409.60587-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <44fad17d-7f40-3b82-0015-37a951ecb0f9@huawei.com>
Date:   Mon, 8 Mar 2021 18:36:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210072409.60587-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/10 15:24, Miaohe Lin wrote:
> There is no need to use a new local variable ret2 to get the return value
> of handle_userfault(). Use ret directly to make code more succinct.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

friendly ping in case it's forgotten. :)

> ---
>  mm/huge_memory.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 395c75111d33..caf552834dbb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -624,14 +624,12 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  
>  		/* Deliver the page fault to userland */
>  		if (userfaultfd_missing(vma)) {
> -			vm_fault_t ret2;
> -
>  			spin_unlock(vmf->ptl);
>  			put_page(page);
>  			pte_free(vma->vm_mm, pgtable);
> -			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
> -			VM_BUG_ON(ret2 & VM_FAULT_FALLBACK);
> -			return ret2;
> +			ret = handle_userfault(vmf, VM_UFFD_MISSING);
> +			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
> +			return ret;
>  		}
>  
>  		entry = mk_huge_pmd(page, vma->vm_page_prot);
> 

