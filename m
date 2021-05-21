Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D238BF68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhEUGdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:33:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhEUGdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:33:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621578730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MgAsTlp/G2cmqkGxmaaSKExDAxwHonea1c7OuAsPn3g=;
        b=KbojoLVxdsFbYDX5ZYujXe03f0TzPM28jH6utKeSnZqeVey6sy9x5mvuJsn9YPWPK3R9zW
        G8+qf31tsUptxJgXS2z87+fa7sA2NwW6q7cQ587JpV0VocZHVIUks62mNLqqc8Wm0STpQ5
        OtBvjfuyTg4Y6FPwNCIkRIi3EV6wkM4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6FD5AC47;
        Fri, 21 May 2021 06:32:09 +0000 (UTC)
Date:   Fri, 21 May 2021 08:32:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        mike.kravetz@oracle.com, david@redhat.com, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        fam.zheng@bytedance.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] mm: migrate: fix missing update page_private to
 hugetlb_page_subpool
Message-ID: <YKdT6XyDdymdQwZ0@dhcp22.suse.cz>
References: <20210521022747.35736-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521022747.35736-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-05-21 10:27:47, Muchun Song wrote:
> Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
> page flags") converts page.private for hugetlb specific page flags. We
> should use hugetlb_page_subpool() to get the subpool pointer instead of
> page_private().
> 
> This 'could' prevent the migration of hugetlb pages. page_private(hpage)
> is now used for hugetlb page specific flags.  At migration time, the
> only flag which could be set is HPageVmemmapOptimized.  This flag will
> only be set if the new vmemmap reduction feature is enabled.  In
> addition, !page_mapping() implies an anonymous mapping.  So, this will
> prevent migration of hugetb pages in anonymous mappings if the vmemmap
> reduction feature is enabled.
> 
> In addition, that if statement checked for the rare race condition of a
> page being migrated while in the process of being freed.  Since that
> check is now wrong, we could leak hugetlb subpool usage counts.
> 
> The commit forgot to update it in the page migration routine. So fix it.
> 
> Fixes: d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

The patch looks good to me. I hope Fixes tag will not confuse stable
backporters as this is a non issue for any released kernel.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Changeslog in v2:
>  1. Update commit log suggested by Mike and Andrew.
>  2. Fix compiler error when !CONFIG_HUGETLB_PAGE reported by Randy.
> 
>  Thanks.
> 
>  include/linux/hugetlb.h | 5 +++++
>  mm/migrate.c            | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 9f192ce44088..e11a2e9aa514 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -915,6 +915,11 @@ static inline bool is_hugetlb_free_vmemmap_enabled(void)
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> +static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
> +{
> +	return NULL;
> +}
> +
>  static inline int isolate_or_dissolve_huge_page(struct page *page,
>  						struct list_head *list)
>  {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 066b1e4e8bde..0692fc2638aa 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1292,7 +1292,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  	 * page_mapping() set, hugetlbfs specific move page routine will not
>  	 * be called and we could leak usage counts for subpools.
>  	 */
> -	if (page_private(hpage) && !page_mapping(hpage)) {
> +	if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
>  		rc = -EBUSY;
>  		goto out_unlock;
>  	}
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
