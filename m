Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11B9318621
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBKINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:13:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:40144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBKIM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:12:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5B6BAE05;
        Thu, 11 Feb 2021 08:12:17 +0000 (UTC)
Date:   Thu, 11 Feb 2021 09:12:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: Remove unnecessary VM_BUG_ON_PAGE on
 putback_active_hugepage()
Message-ID: <20210211081214.GB4087@localhost.localdomain>
References: <20210209071151.44731-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209071151.44731-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:11:51AM -0500, Miaohe Lin wrote:
> All callers know they are operating on a hugetlb head page. So this
> VM_BUG_ON_PAGE can not catch anything useful.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 06719fdf9fd6..cfa06fd1b8d7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5577,7 +5577,6 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  
>  void putback_active_hugepage(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
>  	spin_lock(&hugetlb_lock);
>  	SetHPageMigratable(page);
>  	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
> -- 
> 2.19.1
> 
> 

-- 
Oscar Salvador
SUSE L3
