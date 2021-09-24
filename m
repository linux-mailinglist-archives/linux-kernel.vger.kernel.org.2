Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA8416AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhIXEAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 00:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIXEAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 00:00:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12557C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:59:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r1so8301069qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4BXd5xVDHVm4ZarnqwczzUVLSm7Xt9A4iAceJWVqj4k=;
        b=laalLWc0/tU2MNR97u6oy6PF6LRcbHVgVHb17kL+F7upYb+37Xb9uyutFD+jpFyoep
         eSSGBHQEROGXBuZL5seUlCiFFjf77mshe4fewCS4YOlkLPpktdGvVYEOi2C2XgtYKibN
         bg2D+awgSpl25ceIb6nPMr6n4TbTaCcvRJrs4aEZQCv5TfqMbl0VHqv+fAxgtjURzTJO
         3GAbofUBIvQrn9EyKS3Kp4gErJ/NFRzHJIUTpsnT5tEF0RSswm+EZOF6XyLi3jFVZ1cP
         qLJxFWgrPB1iM6V6tFfYTXz3dFYmFc1dHOlKStawH6Ci3iwtYr4RurdKdwxWpuXs1vQm
         nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4BXd5xVDHVm4ZarnqwczzUVLSm7Xt9A4iAceJWVqj4k=;
        b=vQ8teCmTA6qIOWd7CqIEPPiXvOKSixyotWdxku+Wwo80hC+zPVSVODUK3mlnOrhkwX
         FWFfFs1DyP58yFGITq0p5IiVU5wkEcZ/IiUYVAAZDP0rrz8+ErHWlDu7lLWK+8eJvHHm
         R4IausFm62+gDj/iFB8eF3+AGW0EJoeJt048g+VwKFprkqfQEENCkCpW01VD98/6DpVK
         8LvAxz+xh6I/O2IRm76LbFNt9yg7kKaMwqEn3vS9n2boUE0wlP3IV6RMpXea4AVsLr8E
         2lTzJjrs8NrYgmCtiNlTZ/rNaiQcOkp0L2I00S3ydkyxfRZmuL8IP8Ra/e86EGIV5GhJ
         uGBQ==
X-Gm-Message-State: AOAM532Pc6h4N25JtTjq221ie73nfdsvDcu/u322lb59CHuOLkAXhLEU
        /AZn/QCIUwR8eHPHhlBg6ZpyfW4GrLxv3A==
X-Google-Smtp-Source: ABdhPJxqpHBhAsye+2CAExSw1Mhuro2Ybjik0l8pZBAcLbADkbLa+1/vw9JXYyrCXNAdcjbH/eu4rg==
X-Received: by 2002:ac8:60d9:: with SMTP id i25mr2149855qtm.406.1632455943052;
        Thu, 23 Sep 2021 20:59:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x3sm5516825qkl.107.2021.09.23.20.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 20:59:02 -0700 (PDT)
Date:   Thu, 23 Sep 2021 20:59:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 2/4] mm: Clear vmf->pte after pte_unmap_same()
 returns
In-Reply-To: <20210915181533.11188-1-peterx@redhat.com>
Message-ID: <7b877ef5-9dd5-97ed-dd1a-36dbf5d02547@google.com>
References: <20210915181456.10739-1-peterx@redhat.com> <20210915181533.11188-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Peter Xu wrote:

> pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
> will not be valid any more, we should clear it.
> 
> It was safe only because no one is accessing vmf->pte after pte_unmap_same()
> returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
> where vmf->pte will in most cases be overwritten very soon.
> 
> Directly pass in vmf into pte_unmap_same() and then we can also avoid the long
> parameter list too, which should be a nice cleanup.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

This one seems fine, thanks.
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/memory.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 25fc46e87214..7b095f07c4ef 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2724,19 +2724,19 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
>   * proceeding (but do_wp_page is only called after already making such a check;
>   * and do_anonymous_page can safely check later on).
>   */
> -static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
> -				pte_t *page_table, pte_t orig_pte)
> +static inline int pte_unmap_same(struct vm_fault *vmf)
>  {
>  	int same = 1;
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
>  	if (sizeof(pte_t) > sizeof(unsigned long)) {
> -		spinlock_t *ptl = pte_lockptr(mm, pmd);
> +		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>  		spin_lock(ptl);
> -		same = pte_same(*page_table, orig_pte);
> +		same = pte_same(*vmf->pte, vmf->orig_pte);
>  		spin_unlock(ptl);
>  	}
>  #endif
> -	pte_unmap(page_table);
> +	pte_unmap(vmf->pte);
> +	vmf->pte = NULL;
>  	return same;
>  }
>  
> @@ -3487,7 +3487,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
>  
> -	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
> +	if (!pte_unmap_same(vmf))
>  		goto out;
>  
>  	entry = pte_to_swp_entry(vmf->orig_pte);
> -- 
> 2.31.1
