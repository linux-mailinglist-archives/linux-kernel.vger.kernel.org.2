Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A639FA38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhFHPVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhFHPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBLB4c6IVQivL3hkpAXNnbCJj11WTQNnSoK9+kBvh3Q=;
        b=THmGp8DQfuAspg7tyOXUhTM6qqqD+FSpIsCNnJkBRratxAwmqnbizMDJXW/mkusZyUTI+0
        Ito9fI/tVktpqrgBYefh6SrpUU0lxhGTRwViS8HiDaR+tijkBu/b+R43dKnAZlm+m/X5km
        BMjTkwz+FW4/KG6sje9twdIwM6qtFEk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-KWqEEghjOoua4iXlGWLXBg-1; Tue, 08 Jun 2021 11:19:44 -0400
X-MC-Unique: KWqEEghjOoua4iXlGWLXBg-1
Received: by mail-qk1-f198.google.com with SMTP id v16-20020ae9e3100000b02903aafadba721so880913qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBLB4c6IVQivL3hkpAXNnbCJj11WTQNnSoK9+kBvh3Q=;
        b=eYaE58+nSzSKhx10f63xJKkZEgO/RC5XjKebed0Ll+JH3zc9PQFGF6IxTu4PW+ur74
         uKNKvt+6XZ1Jd9y4Udh9InlzA4H0vIiTdny3+Hh/em3V2mvs8P95Rn8NBBEr7F/+SAyA
         wTNfUo45AYr842qpvNxqlel2OcEJCdTCKMV+MSIoi1gjXsI0bG5BbDS4Q0D5FXcjthgN
         kaLzHHUJnNUOwXpRICke/WU3j4RDaaaNetMQ7iplkD7gRmXIJ13xAM1pnwOeM9X7YMUs
         585YzyDYSOYEq+1ra277lGq6rh9O/69LRQenshJzJgXW1RldQ8m/vTIypq/99RAVmt+u
         WMZw==
X-Gm-Message-State: AOAM531uWuyl4XbtZ14s3RZ4oUTBcsioN+jyND3Z1MyQc8UVtk6Eog8M
        LxeuNR3ULeNPWqJJkwBIN5JWcFnHHmgAFoGPxGL/51x3nXCF9OjhTCLpPfPVtOocVXHOGYnvvf4
        PVW70fPhkB/S0J7HjnlAJ8JEI
X-Received: by 2002:a37:62d6:: with SMTP id w205mr15381155qkb.194.1623165584072;
        Tue, 08 Jun 2021 08:19:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9tQ2FgzwPiUwvaf6IEdO0u/PAmzdBq3+c1YQavhbNJmHVlWELWivs0V26IRzx6TXY9Z2KvQ==
X-Received: by 2002:a37:62d6:: with SMTP id w205mr15381138qkb.194.1623165583888;
        Tue, 08 Jun 2021 08:19:43 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id z127sm600836qkb.98.2021.06.08.08.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:19:43 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:19:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, hughd@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, bskeggs@redhat.com, jgg@nvidia.com,
        shakeelb@google.com, jhubbard@nvidia.com, willy@infradead.org
Subject: Re: [PATCH v10 06/10] mm/memory.c: Allow different return codes for
 copy_nonpresent_pte()
Message-ID: <YL+KjaB4fCt/xodJ@t490s>
References: <20210607075855.5084-1-apopple@nvidia.com>
 <20210607075855.5084-7-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210607075855.5084-7-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 05:58:51PM +1000, Alistair Popple wrote:
> Currently if copy_nonpresent_pte() returns a non-zero value it is
> assumed to be a swap entry which requires further processing outside the
> loop in copy_pte_range() after dropping locks. This prevents other
> values being returned to signal conditions such as failure which a
> subsequent change requires.
> 
> Instead make copy_nonpresent_pte() return an error code if further
> processing is required and read the value for the swap entry in the main
> loop under the ptl.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> v10:
> 
> Use a unique error code and only check return codes for handling.
> 
> v9:
> 
> New for v9 to allow device exclusive handling to occur in
> copy_nonpresent_pte().
> ---
>  mm/memory.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2fb455c365c2..0982cab37ecb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -718,7 +718,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  
>  	if (likely(!non_swap_entry(entry))) {
>  		if (swap_duplicate(entry) < 0)
> -			return entry.val;
> +			return -EIO;
>  
>  		/* make sure dst_mm is on swapoff's mmlist. */
>  		if (unlikely(list_empty(&dst_mm->mmlist))) {
> @@ -974,11 +974,13 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			continue;
>  		}
>  		if (unlikely(!pte_present(*src_pte))) {
> -			entry.val = copy_nonpresent_pte(dst_mm, src_mm,
> -							dst_pte, src_pte,
> -							src_vma, addr, rss);
> -			if (entry.val)
> +			ret = copy_nonpresent_pte(dst_mm, src_mm,
> +						dst_pte, src_pte,
> +						src_vma, addr, rss);
> +			if (ret == -EIO) {
> +				entry = pte_to_swp_entry(*src_pte);
>  				break;
> +			}
>  			progress += 8;
>  			continue;
>  		}
> @@ -1011,20 +1013,24 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	pte_unmap_unlock(orig_dst_pte, dst_ptl);
>  	cond_resched();
>  
> -	if (entry.val) {
> +	if (ret == -EIO) {
> +		VM_WARN_ON_ONCE(!entry.val);
>  		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
>  		entry.val = 0;
> -	} else if (ret) {
> -		WARN_ON_ONCE(ret != -EAGAIN);
> +	} else if (ret ==  -EAGAIN) {
                          ^
                          |----------------------------- one more space here

>  		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
>  		if (!prealloc)
>  			return -ENOMEM;
> -		/* We've captured and resolved the error. Reset, try again. */
> -		ret = 0;
> +	} else if (ret) {
> +		VM_WARN_ON_ONCE(1);
>  	}
> +
> +	/* We've captured and resolved the error. Reset, try again. */

Maybe better as:

      /*
       * We've resolved all error even if there is, reset error code and try
       * again if necessary.
       */

as it also covers the no-error path.  But I guess not a big deal..

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

> +	ret = 0;
> +
>  	if (addr != end)
>  		goto again;
>  out:
> -- 
> 2.20.1
> 

-- 
Peter Xu

