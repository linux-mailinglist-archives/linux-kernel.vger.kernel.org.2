Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04D33C55C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbhGLILw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:11:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34020 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346856AbhGLHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:31:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1CE101FF47;
        Mon, 12 Jul 2021 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626074902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GsR+/kf2MQIKkT4AEOPSXhgaTzxJXolcASGv+64IaZE=;
        b=qYasrGN+M6vKCQgO5rEVQBAy7nJOyNX9lj1oOpP+05lX43oLlldaxRrhw9Ya7bmCVq/M5v
        Mwjn0JomVMxNyZsNm3j4eMpVZdr4L/5M+4pl/k2ni44DeZtFziXBO1r6gSeKv+oMxurUYt
        bk5Il6CrvsJIl52nan2ZuBnnvd5OALI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE557A4725;
        Mon, 12 Jul 2021 07:28:21 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:28:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, willy@infradead.org, minchan@kernel.org,
        david@redhat.com, shli@fb.com, hillf.zj@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm/vmscan: fix misleading comment in
 isolate_lru_pages()
Message-ID: <YOvvFaYMBhISeGEI@dhcp22.suse.cz>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710100329.49174-6-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-07-21 18:03:29, Miaohe Lin wrote:
> We couldn't know whether the page is being freed elsewhere until we failed
> to increase the page count.

This is moving a hard to understand comment from one place to another.
If anything this would benefit from what that elsewhere might be
typically or simply drop the comment altogether.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a74760c48bd8..6e26b3c93242 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1891,7 +1891,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>  		 */
>  		scan += nr_pages;
>  		if (!__isolate_lru_page_prepare(page, mode)) {
> -			/* It is being freed elsewhere */
>  			list_move(&page->lru, src);
>  			continue;
>  		}
> @@ -1901,6 +1900,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>  		 * page release code relies on it.
>  		 */
>  		if (unlikely(!get_page_unless_zero(page))) {
> +			/* It is being freed elsewhere. */
>  			list_move(&page->lru, src);
>  			continue;
>  		}
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
