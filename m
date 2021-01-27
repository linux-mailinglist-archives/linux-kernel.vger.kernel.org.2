Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926F430506D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhA0EIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:08:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11199 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbhA0Dh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:37:56 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQRvZ5rH1zlBL3;
        Wed, 27 Jan 2021 10:12:42 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 10:14:11 +0800
Subject: Re: [PATCH v2 02/10] mm: shuffle lru list addition and deletion
 functions
To:     Yu Zhao <yuzhao@google.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-3-yuzhao@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3057fa2e-b84b-fce9-783b-fb2b0adbe08e@huawei.com>
Date:   Wed, 27 Jan 2021 10:14:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210122220600.906146-3-yuzhao@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/23 6:05, Yu Zhao wrote:
> These functions will call page_lru() in the following patches. Move
> them below page_lru() to avoid the forward declaration.
> 
> Link: https://lore.kernel.org/linux-mm/20201207220949.830352-3-yuzhao@google.com/
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  include/linux/mm_inline.h | 42 +++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 8fc71e9d7bb0..2889741f450a 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -45,27 +45,6 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
>  #endif
>  }
>  
> -static __always_inline void add_page_to_lru_list(struct page *page,
> -				struct lruvec *lruvec, enum lru_list lru)
> -{
> -	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> -	list_add(&page->lru, &lruvec->lists[lru]);
> -}
> -
> -static __always_inline void add_page_to_lru_list_tail(struct page *page,
> -				struct lruvec *lruvec, enum lru_list lru)
> -{
> -	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> -	list_add_tail(&page->lru, &lruvec->lists[lru]);
> -}
> -
> -static __always_inline void del_page_from_lru_list(struct page *page,
> -				struct lruvec *lruvec, enum lru_list lru)
> -{
> -	list_del(&page->lru);
> -	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
> -}
> -
>  /**
>   * page_lru_base_type - which LRU list type should a page be on?
>   * @page: the page to test
> @@ -125,4 +104,25 @@ static __always_inline enum lru_list page_lru(struct page *page)
>  	}
>  	return lru;
>  }
> +
> +static __always_inline void add_page_to_lru_list(struct page *page,
> +				struct lruvec *lruvec, enum lru_list lru)
> +{
> +	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> +	list_add(&page->lru, &lruvec->lists[lru]);
> +}
> +
> +static __always_inline void add_page_to_lru_list_tail(struct page *page,
> +				struct lruvec *lruvec, enum lru_list lru)
> +{
> +	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> +	list_add_tail(&page->lru, &lruvec->lists[lru]);
> +}
> +
> +static __always_inline void del_page_from_lru_list(struct page *page,
> +				struct lruvec *lruvec, enum lru_list lru)
> +{
> +	list_del(&page->lru);
> +	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
> +}
>  #endif
> 

