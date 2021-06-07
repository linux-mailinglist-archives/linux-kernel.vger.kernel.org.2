Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCEA39D4DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGGXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:23:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:23:16 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF53621A6E;
        Mon,  7 Jun 2021 06:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623046884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6eZHG0uIgBTA1Ifaghvq/R+L0/1vhjozGE9giw8fveQ=;
        b=sOpfnymbGTdyrX5yUXr03S7Bo8EWyPaspDGDblDSvIETp4aFNcVpoOZhbJqg6GlgzDTZZF
        rJxp1+2as822+wGiZjsww2wiy8d1GTsUDTp58+j32e1NYRrF5TCxA+YZAHxqIJ4TESuAUS
        DITfi7PDJlDZUwlaPK+1KGrHIsJY4ww=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82248A3B81;
        Mon,  7 Jun 2021 06:21:24 +0000 (UTC)
Date:   Mon, 7 Jun 2021 08:21:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     ziy@nvidia.com, nao.horiguchi@gmail.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Message-ID: <YL265A86DQe5Rgon@dhcp22.suse.cz>
References: <20210604203513.240709-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604203513.240709-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-06-21 13:35:13, Yang Shi wrote:
> When trying to migrate pages to obey mempolicy, the huge zero page is
> split then the page table walk at PTE level just skips zero page.  So it
> seems pointless to split huge zero page, it could be just skipped like
> base zero page.

My THP knowledge is not the best but this is incorrect AIACS. Huge zero
page is not split. We do split the pmd which is mapping the said page. I
suspect you refer to vm_normal_page when talking about a zero page but
please be aware that huge zero page is not a normal zero page. It is
allocated dynamically (see get_huge_zero_page).

So in the end you patch disables mbind of zero pages to a target node
and that is a regression.

Have you tested the patch?

> Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> this case.

Btw. this changelog is missing a problem statement. I suspect there is
no actual problem that it should fix and it is likely driven by reading
the code. Right?

> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/mempolicy.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b5f4f584009b..205c1a768775 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -436,7 +436,8 @@ static inline bool queue_pages_required(struct page *page,
>  
>  /*
>   * queue_pages_pmd() has four possible return values:
> - * 0 - pages are placed on the right node or queued successfully.
> + * 0 - pages are placed on the right node or queued successfully, or
> + *     special page is met, i.e. huge zero page.
>   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>   *     specified.
>   * 2 - THP was split.
> @@ -460,8 +461,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  	page = pmd_page(*pmd);
>  	if (is_huge_zero_page(page)) {
>  		spin_unlock(ptl);
> -		__split_huge_pmd(walk->vma, pmd, addr, false, NULL);
> -		ret = 2;
> +		walk->action = ACTION_CONTINUE;
>  		goto out;
>  	}
>  	if (!queue_pages_required(page, qp))
> @@ -488,7 +488,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>   * and move them to the pagelist if they do.
>   *
>   * queue_pages_pte_range() has three possible return values:
> - * 0 - pages are placed on the right node or queued successfully.
> + * 0 - pages are placed on the right node or queued successfully, or
> + *     special page is met, i.e. zero page.
>   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>   *     specified.
>   * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
