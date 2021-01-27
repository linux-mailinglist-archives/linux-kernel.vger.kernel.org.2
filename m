Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24543058A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhA0Kj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:39:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:33178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235949AbhA0KgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:36:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611743726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlSBFLP0Vb+8qVldB0gSKtEyWNeUb6Om2JuiscXD3Qk=;
        b=MalpUyJsEln1nVRHCCjqCaOro/dqNbxdcHyN1WVShqunXnlqQI1NA5dYYJJ9Pzx+NoBL9C
        moYK0bw7J1xNOTtdfvI+yY8FDtLJihiVjlMvEdBBrLQZRs3ix4LTr+gxIMmv4RyBNujYsK
        VO3SAUlRCMAfj3DceUwfp0CiPHtJmLc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F60FADA2;
        Wed, 27 Jan 2021 10:35:26 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:35:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
Message-ID: <20210127103523.GI827@dhcp22.suse.cz>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-01-21 11:52:29, Mike Kravetz wrote:
> The HP_Migratable flag indicates a page is a candidate for migration.
> Only set the flag if the page's hstate supports migration.  This allows
> the migration paths to detect non-migratable pages earlier.  If migration
> is not supported for the hstate, HP_Migratable will not be set, the page
> will not be isolated and no attempt will be made to migrate.  We should
> never get to unmap_and_move_huge_page for a page where migration is not
> supported, so throw a warning if we do.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 2 +-
>  include/linux/hugetlb.h | 9 +++++++++
>  mm/hugetlb.c            | 8 ++++----
>  mm/migrate.c            | 9 ++++-----
>  4 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index e1d7ed2a53a9..93f7b8d3c5fd 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  
> -		SetHPageMigratable(page);
> +		SetHPageMigratableIfSupported(page);
>  		/*
>  		 * unlock_page because locked by add_to_page_cache()
>  		 * put_page() due to reference from alloc_huge_page()
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 58be44a915d1..cd1960541f2a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -740,6 +740,15 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  	return arch_hugetlb_migration_supported(h);
>  }
>  
> +/*
> + * Only set HPageMigratable if migration supported for page
> + */
> +static inline void SetHPageMigratableIfSupported(struct page *page)

This is really mouthful...

> +{
> +	if (hugepage_migration_supported(page_hstate(page)))
> +		SetHPageMigratable(page);

and it is really a trivial wrapper. I do understand why you want to
prevent from the code duplication and potentially a missing check but
this all is just an internal hugetlb code. Even if the flag is set on
non-migrateable hugetlb page then this will not be fatal. The migration
can fail even on those pages for which migration is supported right?

So I am not really sure this is an improvement in the end. But up to you
I do not really have a strong opinion here.

-- 
Michal Hocko
SUSE Labs
