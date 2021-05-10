Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1499377CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhEJG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:58:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2425 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhEJG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:58:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FdsHC2SwVzCqrG;
        Mon, 10 May 2021 14:54:31 +0800 (CST)
Received: from [10.174.176.232] (10.174.176.232) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 14:57:06 +0800
Subject: Re: [PATCH] ksm: Revert "use GET_KSM_PAGE_NOLOCK to get ksm page in
 remove_rmap_item_from_tree()"
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <alpine.LSU.2.11.2105092253500.1127@eggly.anvils>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0e04877c-5b2d-b810-7464-108e793b84d3@huawei.com>
Date:   Mon, 10 May 2021 14:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2105092253500.1127@eggly.anvils>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 13:59, Hugh Dickins wrote:
> This reverts commit 3e96b6a2e9ad929a3230a22f4d64a74671a0720b.
> General Protection Fault in rmap_walk_ksm() under memory pressure:
> remove_rmap_item_from_tree() needs to take page lock, of course.
> 

I'am really sorry about it! And many thanks for this bugfix!
It seems rmap_walk_ksm() relies on the page lock to protect against
concurrent modifications to that page's node of the stable tree.
Could you please add a comment in remove_rmap_item_from_tree() to
clarify this in case similar trouble again? Many thanks!

> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  mm/ksm.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 5.13-rc1/mm/ksm.c	2021-05-09 17:03:44.010422188 -0700
> +++ linux/mm/ksm.c	2021-05-09 22:12:39.403008350 -0700
> @@ -776,11 +776,12 @@ static void remove_rmap_item_from_tree(s
>  		struct page *page;
>  
>  		stable_node = rmap_item->head;
> -		page = get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
> +		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
>  		if (!page)
>  			goto out;
>  
>  		hlist_del(&rmap_item->hlist);
> +		unlock_page(page);
>  		put_page(page);
>  
>  		if (!hlist_empty(&stable_node->hlist))
> .
> 

