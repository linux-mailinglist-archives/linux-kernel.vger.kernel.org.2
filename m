Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B323619A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhDPGBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:01:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239023AbhDPGBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:01:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618552874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcxZJXIn600KKHi4Ii9DOy7PKS3jJv9awLf/Br93sWI=;
        b=HOinFmk+SPJG00P75hIszwIpHFu1+7CmEVsIDNQN+nU6+l+AXkEDrqcjCN4Ox86I1hnp84
        KGZ7CTwfby81UyAS/CP52O55HcwHjF7uNjPkdu95Mdrxa03xulABq+oBD5jqPSgidiTf1U
        zKmtdmsiC9czyO3qleb2tnj/2OvDhKI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 239F2AFEA;
        Fri, 16 Apr 2021 06:01:14 +0000 (UTC)
Date:   Fri, 16 Apr 2021 08:01:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 5/8] mm: memcontrol: rename lruvec_holds_page_lru_lock
 to page_matches_lruvec
Message-ID: <YHkoJI12iADTAP69@dhcp22.suse.cz>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
 <20210416051407.54878-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416051407.54878-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 13:14:04, Muchun Song wrote:
> lruvec_holds_page_lru_lock() doesn't check anything about locking and is
> used to check whether the page belongs to the lruvec. So rename it to
> page_matches_lruvec().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> ---
>  include/linux/memcontrol.h | 7 +++----
>  mm/vmscan.c                | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2fc728492c9b..40b0c31ea4ba 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1492,8 +1492,7 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>  	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
>  }
>  
> -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> -					      struct lruvec *lruvec)
> +static inline bool page_matches_lruvec(struct page *page, struct lruvec *lruvec)
>  {
>  	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
>  	       lruvec_memcg(lruvec) == page_memcg(page);
> @@ -1504,7 +1503,7 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>  		struct lruvec *locked_lruvec)
>  {
>  	if (locked_lruvec) {
> -		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> +		if (page_matches_lruvec(page, locked_lruvec))
>  			return locked_lruvec;
>  
>  		unlock_page_lruvec_irq(locked_lruvec);
> @@ -1518,7 +1517,7 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
>  		struct lruvec *locked_lruvec, unsigned long *flags)
>  {
>  	if (locked_lruvec) {
> -		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> +		if (page_matches_lruvec(page, locked_lruvec))
>  			return locked_lruvec;
>  
>  		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bb8321026c0c..2bc5cf409958 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2062,7 +2062,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 * All pages were isolated from the same lruvec (and isolation
>  		 * inhibits memcg migration).
>  		 */
> -		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> +		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
>  		add_page_to_lru_list(page, lruvec);
>  		nr_pages = thp_nr_pages(page);
>  		nr_moved += nr_pages;
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
