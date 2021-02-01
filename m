Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93D330A6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBALuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:50:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:46518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBALuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:50:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612180188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFnrMJIQEE2ourhyO+GKx2F39xv/yVWuIZUE5mKeW+I=;
        b=IMq1SAd6dx+bVBYZCNiF9zAdI1LdLLtBebxw15V/F+f2UvUafy6fWfnnH7k0S5LM2PRpl+
        kC8iLryKlvjX3YiE5CPdnPeswErWS3eIvCZcytUK4MCnR+8ui2haYc2RjVDdKLRc7nJhMw
        QJbR9Xhe7kqPq8dDrgWIY2lN+UERkwo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEB47AD29;
        Mon,  1 Feb 2021 11:49:48 +0000 (UTC)
Date:   Mon, 1 Feb 2021 12:49:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
Message-ID: <YBfqzlG1C1mtKj4Z@dhcp22.suse.cz>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
 <20210127103523.GI827@dhcp22.suse.cz>
 <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
 <20210128055221.GA3166@localhost.localdomain>
 <20210128133733.ce1fb2eac98ab5696c08f288@linux-foundation.org>
 <12187293-e972-acd8-7789-22ebfa736f95@oracle.com>
 <20210128141531.17fec31e6075fe0eb6e33683@linux-foundation.org>
 <62a80585-2a73-10cc-4a2d-5721540d4ad2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a80585-2a73-10cc-4a2d-5721540d4ad2@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-01-21 10:46:15, Mike Kravetz wrote:
> On 1/28/21 2:15 PM, Andrew Morton wrote:
> > On Thu, 28 Jan 2021 14:00:29 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> Michal suggested that comments describing synchronization be added for each
> >> flag.  Since I did 'one patch per flag', that would be an update to each patch.
> >> Or, I could simply add a patch to update the comment block based on what you
> >> already have.
> >>
> >> Let me know what is best/easiest for you.
> > 
> > I guess just one patch is best for reviewers.  Then I'll split up into
> > a sprinkle of -fix patches if I'm feeling energetic ;)
> 
> Here is a patch to update the comments for all those flags.  It should
> apply on top of what is in your tree.
> 
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 29 Jan 2021 10:36:12 -0800
> Subject: [PATCH] huegtlb: add synchronization information for new hugetlb
>  specific flags
> 
> Adding comments, no functional change.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks Mike!

> ---
>  include/linux/hugetlb.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e5e6ffd55392..cf70795d2209 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -480,14 +480,24 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>   *	allocation time.  Cleared when page is fully instantiated.  Free
>   *	routine checks flag to restore a reservation on error paths.
> + *	Synchronization:  Examined or modified by code that knows it has
> + *	the only reference to page.  i.e. After allocation but before use
> + *	or when the page is being freed.
>   * HPG_migratable  - Set after a newly allocated page is added to the page
>   *	cache and/or page tables.  Indicates the page is a candidate for
>   *	migration.
> + *	Synchronization:  Initially set after new page allocation with no
> + *	locking.  When examined and modified during migration processing
> + *	(isolate, migrate, putback) the hugetlb_lock is held.
>   * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
>   *	allocator.  Typically used for migration target pages when no pages
>   *	are available in the pool.  The hugetlb free page path will
>   *	immediately free pages with this flag set to the buddy allocator.
> + *	Synchronization: Can be set after huge page allocation from buddy when
> + *	code knows it has only reference.  All other examinations and
> + *	modifications require hugetlb_lock.
>   * HPG_freed - Set when page is on the free lists.
> + *	Synchronization: hugetlb_lock held for examination and modification.
>   */
>  enum hugetlb_page_flags {
>  	HPG_restore_reserve = 0,
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs
