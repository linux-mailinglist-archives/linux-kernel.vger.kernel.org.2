Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717493A2781
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFJI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:57:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EECDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:55:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a1so1981647lfr.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k8HHrhbDqQGirpSdp4ZdVQqESPBnbofSKT7LecLAJ9w=;
        b=mN3F3DYIRqj3v9kvQkuTf5YUM7BDyxusg+h9GvudYAxE2ohZCFPzTyVtLUTz266nMc
         In45IyTHEvNUDf/hpWrOU8nQtBJ5K4HFD5cgcOUej3vbOoy8knM12+eg3k49f0eaXDzG
         K4qwXv8cQVkoeCLhoVCeZrlrWQLeAI9KBnwxJy2qNW2FJwI8pPHiEY/029AuKAWJ3Hbk
         DrxJ9zcPsS2MWznSQ/39WuWdod4rr5FqDIg+8v+YUJPJvE/2YJ1LjtZrcbqESoWXq5k/
         0sOP86BBymiSplwP354vtkU9qylx3ob7x6BD2SudvT/m4CRjnmoMx238oNgvoSU2JR2x
         AYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8HHrhbDqQGirpSdp4ZdVQqESPBnbofSKT7LecLAJ9w=;
        b=RIzchT5PL0fby+E7BwYfztPp1nYjqcXqHoPPxYZF84N4Ga7rPk+jgQHbISHh7vcMCh
         bVQlrgT2p0Kxe73GOAT9LW47aQveJbT9SH1F/fe3pWljPq0s+q2YZZJ5fqwuPx2Juxeo
         H9Qgf+3JLH6EoDru4M67PDQy/nuKDkOvTw1HKO6+mVP31e40JFi/fOvWIvsSjZrSfC0X
         77IMJxHhSJpegDEYUWivlNwDCNtRcRbPuWZ3vtPf2mJz/u3Uj8wriQZ+gFjWynvhcSwK
         FFpNcx+Z5FMgbvFHnVQ5y+QtH3IXHCK0yClSErDYBARiF4fB3/G16kynYWIiXq/lxCWY
         Zl1g==
X-Gm-Message-State: AOAM533mt9IbYFlmq+PLiout2KLP8jSYBNOHBdAkub2nCf3tG0w4nwl0
        ivsDWod/NitJKIUlJ7e0eZGmLA==
X-Google-Smtp-Source: ABdhPJyfrY1aNiHSavPGpNgO2zxhunWxGSOaf4UNaIjUOZfRquJaVe6wo5dkTZFvxh9D/IpLCOgbHg==
X-Received: by 2002:a19:4949:: with SMTP id l9mr1209925lfj.642.1623315307579;
        Thu, 10 Jun 2021 01:55:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x19sm255787lfe.270.2021.06.10.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:55:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BA96D1027EE; Thu, 10 Jun 2021 11:55:22 +0300 (+03)
Date:   Thu, 10 Jun 2021 11:55:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] mm: page_vma_mapped_walk(): use page for pvmw->page
Message-ID: <20210610085522.f5ffyejzn3xtqark@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:34:40PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: sometimes the local copy of pvwm->page was
> used, sometimes pvmw->page itself: use the local copy "page" throughout.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

A question below.

> ---
>  mm/page_vma_mapped.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e37bd43904af..a6dbf714ca15 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -156,7 +156,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	if (pvmw->pte)
>  		goto next_pte;
>  
> -	if (unlikely(PageHuge(pvmw->page))) {
> +	if (unlikely(PageHuge(page))) {
>  		/* when pud is not present, pte will be NULL */
>  		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
>  		if (!pvmw->pte)
> @@ -217,8 +217,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		 * cannot return prematurely, while zap_huge_pmd() has
>  		 * cleared *pmd but not decremented compound_mapcount().
>  		 */
> -		if ((pvmw->flags & PVMW_SYNC) &&
> -		    PageTransCompound(pvmw->page)) {
> +		if ((pvmw->flags & PVMW_SYNC) && PageTransCompound(page)) {
>  			spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
>  
>  			spin_unlock(ptl);
> @@ -234,9 +233,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			return true;
>  next_pte:
>  		/* Seek to next pte only makes sense for THP */
> -		if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
> +		if (!PageTransHuge(page) || PageHuge(page))
>  			return not_found(pvmw);
> -		end = vma_address_end(pvmw->page, pvmw->vma);
> +		end = vma_address_end(page, pvmw->vma);
>  		do {
>  			pvmw->address += PAGE_SIZE;
>  			if (pvmw->address >= end)

I see two more pvmw->page in this loop. Do you leave them here as the code
will be rewritten later in the patchset?

-- 
 Kirill A. Shutemov
