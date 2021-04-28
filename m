Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280DE36D0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhD1DH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:07:29 -0400
Received: from foss.arm.com ([217.140.110.172]:59724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhD1DH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:07:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B12A1FB;
        Tue, 27 Apr 2021 20:06:44 -0700 (PDT)
Received: from [10.163.76.81] (unknown [10.163.76.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5505C3F694;
        Tue, 27 Apr 2021 20:06:34 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 2/5] mm/huge_memory.c: use page->deferred_list
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
 <20210427133214.2270207-3-linmiaohe@huawei.com>
Message-ID: <e326f0c6-a4dc-6788-7be7-a175c47b2249@arm.com>
Date:   Wed, 28 Apr 2021 08:37:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210427133214.2270207-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/21 7:02 PM, Miaohe Lin wrote:
> Now that we can represent the location of ->deferred_list instead of
> ->mapping + ->index, make use of it to improve readability.

Could you please explain how page->deferred_list and page->mapping
are interchangeable here ?

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..76ca1eb2a223 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
>  	list_for_each_safe(pos, next, &ds_queue->split_queue) {
> -		page = list_entry((void *)pos, struct page, mapping);
> +		page = list_entry((void *)pos, struct page, deferred_list);
>  		page = compound_head(page);
>  		if (get_page_unless_zero(page)) {
>  			list_move(page_deferred_list(page), &list);
> @@ -2883,7 +2883,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  
>  	list_for_each_safe(pos, next, &list) {
> -		page = list_entry((void *)pos, struct page, mapping);
> +		page = list_entry((void *)pos, struct page, deferred_list);
>  		if (!trylock_page(page))
>  			goto next;
>  		/* split_huge_page() removes page from list on success */
>
