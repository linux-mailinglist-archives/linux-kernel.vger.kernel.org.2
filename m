Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85E3305865
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhA0K2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:28:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:54844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235846AbhA0K0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:26:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611743118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/1GVgbi5JapDlkuAM1CT4D/SC46Mqf1KhShlAOrt0c=;
        b=nvVqjQA+BZk4AAMn9wowZvKRbsY5BPu9qDlfGcT7BisChiU3wPoG40hIr6BQ68Z0up2+Bl
        PkN8mOvcYzxnAhLMp0Wo+V5BW/71D04pHrdY7m80fi0ftG4V7vaWFvEuQ5kKVo3rcABTdh
        gcH+L4fCbzwsMZIx2Fzkz6aHRUIe6eU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA4B7AD2B;
        Wed, 27 Jan 2021 10:25:18 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:25:17 +0100
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
Subject: Re: [PATCH v3 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
Message-ID: <20210127102517.GG827@dhcp22.suse.cz>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-01-21 11:52:28, Mike Kravetz wrote:
> Use the new hugetlb page specific flag HPageMigratable to replace the
> page_huge_active interfaces.  By it's name, page_huge_active implied
> that a huge page was on the active list.  However, that is not really
> what code checking the flag wanted to know.  It really wanted to determine
> if the huge page could be migrated.  This happens when the page is actually
> added to the page cache and/or task page table.  This is the reasoning
> behind the name change.

yeah, definitely less confusing!

> The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
> really necessary as we KNOW the page is a hugetlb page.  Therefore, they
> are removed.
> 
> The routine page_huge_active checked for PageHeadHuge before testing the
> active bit.  This is unnecessary in the case where we hold a reference or
> lock and know it is a hugetlb head page.  page_huge_active is also called
> without holding a reference or lock (scan_movable_pages), and can race with
> code freeing the page.  The extra check in page_huge_active shortened the
> race window, but did not prevent the race.  Offline code calling
> scan_movable_pages already deals with these races, so removing the check
> is acceptable.  Add comment to racy code.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

One nit below
[...]
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a7eb05315c6e..58be44a915d1 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>   *	allocation time.  Cleared when page is fully instantiated.  Free
>   *	routine checks flag to restore a reservation on error paths.
> + * HPG_migratable  - Set after a newly allocated page is added to the page
> + *	cache and/or page tables.  Indicates the page is a candidate for
> + *	migration.

The state change is synchronized by hugetlb_lock.

Pls.

>   */
>  enum hugetlb_page_flags {
>  	HPG_restore_reserve = 0,
> +	HPG_migratable,
>  	__NR_HPAGEFLAGS,
>  };
-- 
Michal Hocko
SUSE Labs
