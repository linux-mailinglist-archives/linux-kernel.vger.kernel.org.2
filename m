Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0756339D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhCMKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:36:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13515 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhCMKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:36:19 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DyJvm2NB9zrSLB;
        Sat, 13 Mar 2021 18:34:28 +0800 (CST)
Received: from [10.174.179.232] (10.174.179.232) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 18:36:14 +0800
Subject: Re: [PATCH] mm/huge_memory.c: use helper function
 migration_entry_to_page()
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <richard.weiyang@linux.alibaba.com>, <peterx@redhat.com>,
        <anshuman.khandual@arm.com>, <thomas_os@shipmail.org>,
        <rcampbell@nvidia.com>, <aneesh.kumar@linux.ibm.com>,
        <yang.shi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210313103225.16607-1-linmiaohe@huawei.com>
 <20210313103225.16607-3-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9be38c47-ad59-6d32-dcd9-6fb76fe1e3f5@huawei.com>
Date:   Sat, 13 Mar 2021 18:36:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210313103225.16607-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/13 18:32, Miaohe Lin wrote:
> It's more recommended to use helper function migration_entry_to_page() to
> get the page via migration entry. We can also enjoy the PageLocked()
> check there.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

My bad! I have send this patch inside another patch series. Please ignore this one. Sorry for make noise! :(

> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c00205e7c548..0a7a9884d0a2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1693,7 +1693,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  
>  			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>  			entry = pmd_to_swp_entry(orig_pmd);
> -			page = pfn_to_page(swp_offset(entry));
> +			page = migration_entry_to_page(entry);
>  			flush_needed = 0;
>  		} else
>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
> @@ -2101,7 +2101,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		swp_entry_t entry;
>  
>  		entry = pmd_to_swp_entry(old_pmd);
> -		page = pfn_to_page(swp_offset(entry));
> +		page = migration_entry_to_page(entry);
>  		write = is_write_migration_entry(entry);
>  		young = false;
>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
> 

