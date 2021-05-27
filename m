Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BD392819
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhE0HAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:00:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhE0HAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622098740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uxrs8M1VcmOkWe5QS1sYN9XeLXXiQYAcgHDyySYmn3o=;
        b=VrpVpLUUEkIXq9cy0/Zr2kQ/8uNCwvou43vAx+4y5SCB//YS6drYFIn5EMqlzdf5dKLSZz
        hMsx2x8GEVQCUYSX5dYxr1x68FLyoTVnKfk7OY2ong3vMG21lT+67g80OeggobJzzXrSXb
        0IPD7j/Qu/bea5JtL3YYZXq+mUL3fgw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41A90ADFB;
        Thu, 27 May 2021 06:59:00 +0000 (UTC)
Date:   Thu, 27 May 2021 08:58:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
Message-ID: <YK9DM03ymX9PG0Zk@dhcp22.suse.cz>
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-05-21 08:52:57, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When memory_failure() or soft_offline_page() is called on a tail page of
> some hugetlb page, "BUG: unable to handle page fault" error can be
> triggered.
> 
> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> page points to a head page, but one of the caller,
> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> which could be a tail page.  So pass 'head' to it, instead.
> 
> Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

This is really nasty and easy to overlook. I have completely missed that
when reviewing and I do remember checking for head vs page as there is
quite some non trivial handling of both here.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git v5.13-rc3/mm/hugetlb.c v5.13-rc3_patched/mm/hugetlb.c
> index 95918f410c0f..470f7b5b437e 100644
> --- v5.13-rc3/mm/hugetlb.c
> +++ v5.13-rc3_patched/mm/hugetlb.c
> @@ -1793,7 +1793,7 @@ int dissolve_free_huge_page(struct page *page)
>  			SetPageHWPoison(page);
>  			ClearPageHWPoison(head);
>  		}
> -		remove_hugetlb_page(h, page, false);
> +		remove_hugetlb_page(h, head, false);
>  		h->max_huge_pages--;
>  		spin_unlock_irq(&hugetlb_lock);
>  		update_and_free_page(h, head);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
