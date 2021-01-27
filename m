Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC730506E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhA0EIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:08:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11898 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhA0Dh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:37:56 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DQRt25s8tz7bbx;
        Wed, 27 Jan 2021 10:11:22 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 10:12:31 +0800
Subject: Re: [PATCH v2 01/10] mm: use add_page_to_lru_list()
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
 <20210122220600.906146-2-yuzhao@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <24c55266-497b-db91-2784-5621ca35ebef@huawei.com>
Date:   Wed, 27 Jan 2021 10:12:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210122220600.906146-2-yuzhao@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/23 6:05, Yu Zhao wrote:
> There is add_page_to_lru_list(), and move_pages_to_lru() should reuse
> it, not duplicate it.
> 
> Link: https://lore.kernel.org/linux-mm/20201207220949.830352-2-yuzhao@google.com/
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
> ---
>  mm/vmscan.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04509994aed4..19875660e8f8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1823,7 +1823,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> -	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
> @@ -1868,11 +1867,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 * inhibits memcg migration).
>  		 */
>  		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> -		lru = page_lru(page);
> +		add_page_to_lru_list(page, lruvec, page_lru(page));
>  		nr_pages = thp_nr_pages(page);
> -
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_add(&page->lru, &lruvec->lists[lru]);
>  		nr_moved += nr_pages;
>  		if (PageActive(page))
>  			workingset_age_nonresident(lruvec, nr_pages);
> 

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
