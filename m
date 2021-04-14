Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4435F102
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhDNJqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:46:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbhDNJqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:46:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618393569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=05qnuH1nbbTYL5zFdv5eMMmudj0mqycIJlXy8sYIrAo=;
        b=oyjmC6heHUrWLTxImm+JHiXprN8BqhbDxcZrY2ANR1FvvTRXP05xLiO5H4ZMbyA1dDBsbS
        YRaCHLlvV20KO2WOZhA1cXL5kJyh0zofhzd22NO/P9/iIxPnaceqjIEnncQpHtik4Gp3+n
        XWaYWpCGkELA+bQIbU21wcemyqoDjac=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76B44ABB3;
        Wed, 14 Apr 2021 09:46:09 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:46:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 7/7] mm: vmscan: remove noinline_for_stack
Message-ID: <YHa54ENFqoPrTbXJ@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-8-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 14:51:53, Muchun Song wrote:
> The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
> set up pagevec as late as possible in shrink_inactive_list()"), its
> purpose is to delay the allocation of pagevec as late as possible to
> save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
> reclaim stack") replace pagevecs by lists of pages_to_free. So we do
> not need noinline_for_stack, just remove it (let the compiler decide
> whether to inline).
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 64bf07cc20f2..e40b21298d77 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2015,8 +2015,8 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>   *
>   * Returns the number of pages moved to the given lruvec.
>   */
> -static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> -						     struct list_head *list)
> +static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> +				      struct list_head *list)
>  {
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
> @@ -2096,7 +2096,7 @@ static int current_may_throttle(void)
>   * shrink_inactive_list() is a helper for shrink_node().  It returns the number
>   * of reclaimed pages
>   */
> -static noinline_for_stack unsigned long
> +static unsigned long
>  shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  		     struct scan_control *sc, enum lru_list lru)
>  {
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
