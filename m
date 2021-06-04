Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4739B0DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhFDD2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDD2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:28:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70EC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 20:26:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r17so8069292qkp.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dnq8bi4WgTB+aCPH1lNk5tI4fbv6Xg2se78kMTkHbnk=;
        b=lSeSyo3iR3W+v7+Yz/7O/rtrgHddcmai7nJlBU3XmXwCvD5dZ5c0Xcy5YjoINAsUQX
         A2gpNl6V6SvvkXsXT1QOF6yt8BTFGd9x6Dd06jt47pRrndNy7VCu0NwtFTIUM9AEsVSp
         z4NYxvuFU8xHg8WvEr/U6vjxx+mclUNK47sEbYgS09ZEozrhzqMG7dP89vEDIEDwW2CI
         h1z5L4dpPNrRgUNlKbxzyjiraJPkRhK9WJ+75mKz99agwViHC4Xsr38eVhD649GAkuun
         voLxcQB/1gNUtNUOjf2iPZBcA6VHrowoLaY3A4VjuzXAWGb5oYUxP20GJX3jGNx9N68Q
         nshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dnq8bi4WgTB+aCPH1lNk5tI4fbv6Xg2se78kMTkHbnk=;
        b=gZJuDOvmwfiPfYzuDt5yMCh5z+l29/P1SdXLp7RbaMQ6TPTowBu9ajeCi/mzoL1vKR
         63kxmSjpDYWR7ud9vwHY3NEDOhcwcRzR8ZdZdy1MvTBxjnxCBAK17CiyqnrBmnJBQplB
         IwLqrmxZUw9R4lgueOx5kXTOlBz/7Qdusz/cGdKnqsq0/lwbSvxSlhN3oPdk031SR3jD
         QcDkMM7W9TM09+aBAVGt4qlIlRGEOUeMccCHtBvOpzg4A5e0RRxoSRSmDVINOMG80vNO
         RdkkJQERH8VBZd1Rjk2uvyTNJrQBfSRqhmVdTLWA1wfbjH69NmKdWKNywCXsg0aPivUb
         an1w==
X-Gm-Message-State: AOAM532ODz4I089oXoGiUK/ZZrI/vbXhY90xubc5n7/k6Ks1y3T8BaHM
        nKEMlpjaA/uNT9q72JrT7znzOg==
X-Google-Smtp-Source: ABdhPJwtC0zZZRQ+4Ojx/S//wpEjvhfB81RWQnckCOpv7r+YDSI8/bCcD23AnKjYlEIPZrENQe+1Gw==
X-Received: by 2002:a05:620a:cd6:: with SMTP id b22mr840611qkj.471.1622777164282;
        Thu, 03 Jun 2021 20:26:04 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e24sm171621qtp.97.2021.06.03.20.26.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 20:26:03 -0700 (PDT)
Date:   Thu, 3 Jun 2021 20:26:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm/swap: Fix pte_same_as_swp() not removing uffd-wp bit
 when compare
In-Reply-To: <20210603180546.9083-1-peterx@redhat.com>
Message-ID: <alpine.LSU.2.11.2106032015250.12760@eggly.anvils>
References: <20210603180546.9083-1-peterx@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021, Peter Xu wrote:

> I found it by pure code review, that pte_same_as_swp() of unuse_vma() didn't

Yes, that is an odd corner, easily missed.

> take uffd-wp bit into account when comparing ptes.  pte_same_as_swp() returning
> false negative could cause failure to swapoff swap ptes that was wr-protected
> by userfaultfd.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

I expect you're right: swapoff used to hang forever (but interruptibly)
when this went wrong on powerpc originally.  I don't know the uffd_wp
(nor the soft_dirty) end of it, but treating uffd_wp and soft_dirty
together looks a very good approach, so I'll venture an

Acked-by: Hugh Dickins <hughd@google.com>

But I think it should have a uffd_wp Fixes tag and be Cc stable.

> ---
>  include/linux/swapops.h | 15 +++++++++++----
>  mm/swapfile.c           |  2 +-
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index af3d2661e41e..d356ab4047f7 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -23,6 +23,16 @@
>  #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
>  #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
>  
> +/* Clear all flags but only keep swp_entry_t related information */
> +static inline pte_t pte_swp_clear_flags(pte_t pte)
> +{
> +	if (pte_swp_soft_dirty(pte))
> +		pte = pte_swp_clear_soft_dirty(pte);
> +	if (pte_swp_uffd_wp(pte))
> +		pte = pte_swp_clear_uffd_wp(pte);
> +	return pte;
> +}
> +
>  /*
>   * Store a type+offset into a swp_entry_t in an arch-independent format
>   */
> @@ -66,10 +76,7 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
>  {
>  	swp_entry_t arch_entry;
>  
> -	if (pte_swp_soft_dirty(pte))
> -		pte = pte_swp_clear_soft_dirty(pte);
> -	if (pte_swp_uffd_wp(pte))
> -		pte = pte_swp_clear_uffd_wp(pte);
> +	pte = pte_swp_clear_flags(pte);
>  	arch_entry = __pte_to_swp_entry(pte);
>  	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6212bc033602..1e07d1c776f2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1887,7 +1887,7 @@ unsigned int count_swap_pages(int type, int free)
>  
>  static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
>  {
> -	return pte_same(pte_swp_clear_soft_dirty(pte), swp_pte);
> +	return pte_same(pte_swp_clear_flags(pte), swp_pte);
>  }
>  
>  /*
> -- 
> 2.31.1
