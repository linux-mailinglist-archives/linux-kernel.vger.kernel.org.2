Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD02742A1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhJLKSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232638AbhJLKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634033794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoTN3jo1U0TNsMaOgGR+Z4Eg7VJc5SuDhxCfX96qS/w=;
        b=YgNRPcPP6riKHrZEYc7ZdESH2spr32uzRMFvshOvQHiUaPwq+UhBuvFICGkdHIbMXpSP4F
        I5IYrjPVGmMZHKJk/qD3hCYyus/pw/aWKEN/ZH/5E5gw+Rh9wISpKpJYPU0O9dTVezqUDi
        BX25bnJ7hXAvRlNcXPbf5f4LdaViC1g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-c5d1qhrCM2WBmTrTXgzzHw-1; Tue, 12 Oct 2021 06:16:32 -0400
X-MC-Unique: c5d1qhrCM2WBmTrTXgzzHw-1
Received: by mail-pj1-f70.google.com with SMTP id z23-20020a17090ab11700b001a070e36178so5172785pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZoTN3jo1U0TNsMaOgGR+Z4Eg7VJc5SuDhxCfX96qS/w=;
        b=hLudSiAdgVlT2LB3k+yM8i1hL3GsvhoMsS/FobYwOJYuqToYNGLB3sBso53c09VnLE
         6nfEVk8ooZl012JbiUaQSb4GOlPkZriF2GZcxa0mX7RDsLobzVXT73OO4UoXj+yGdYuk
         QRVmP0rHnK6rmb4BsxbKJlCS4mea7n+8EsRtZTSg3TMq6Cvc/cM/tDFT3m7api14SUP4
         lV4/VWJqZ2M0mOURGKUyu1KJZztr/1fPUTrft6Amt9QRhyeztEXT0SRzNa0oAQKmx7hO
         Ml3P3UNJaQKTC3KMDwiqivyUfl1JxQKfpUn0nCtNdMeqCyqDYavtsMKYphmeelooXaUj
         BE5g==
X-Gm-Message-State: AOAM531GRCjtk8IQAPcxaIXWKteKjqCkyfiMQ+Qj1jfwUvO35IXfAvSf
        czZxIWM88VQ6flqtzzJAemVnQkDDhbkvyxoaE5Icg6UW8mJhB0qh0XYvGGBnpv6pIEg5DmS4KSY
        z1oW/VtrcewxWisw6x9BjRi3i
X-Received: by 2002:a17:90a:7e82:: with SMTP id j2mr4937795pjl.165.1634033791873;
        Tue, 12 Oct 2021 03:16:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkghYFByrZHWmiyuVaP/T5E/0uYqrI4d0vpEGa+/BuFxVaGcBXZCk9WyZp0G0JjIXp3aT0CA==
X-Received: by 2002:a17:90a:7e82:: with SMTP id j2mr4937753pjl.165.1634033791509;
        Tue, 12 Oct 2021 03:16:31 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 197sm10449044pfv.6.2021.10.12.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:16:30 -0700 (PDT)
Date:   Tue, 12 Oct 2021 18:16:22 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
Message-ID: <YWVgdmKIFnZcgjeY@t490s>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210925205423.168858-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
> @@ -338,25 +344,25 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  	pgd_t *pgd;
>  	unsigned long next;
> -	unsigned long start = addr;
>  	unsigned long pages = 0;
> +	struct mmu_gather tlb;
>  
>  	BUG_ON(addr >= end);
>  	pgd = pgd_offset(mm, addr);
>  	flush_cache_range(vma, addr, end);
>  	inc_tlb_flush_pending(mm);
> +	tlb_gather_mmu(&tlb, mm);
> +	tlb_start_vma(&tlb, vma);

Pure question:

I actually have no idea why tlb_start_vma() is needed here, as protection range
can be just a single page, but anyway.. I do see that tlb_start_vma() contains
a whole-vma flush_cache_range() when the arch needs it, then does it mean that
besides the inc_tlb_flush_pending() to be dropped, so as to the other call to
flush_cache_range() above?

>  	do {
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none_or_clear_bad(pgd))
>  			continue;
> -		pages += change_p4d_range(vma, pgd, addr, next, newprot,
> +		pages += change_p4d_range(&tlb, vma, pgd, addr, next, newprot,
>  					  cp_flags);
>  	} while (pgd++, addr = next, addr != end);
>  
> -	/* Only flush the TLB if we actually modified any entries: */
> -	if (pages)
> -		flush_tlb_range(vma, start, end);
> -	dec_tlb_flush_pending(mm);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb);
>  
>  	return pages;
>  }
> -- 
> 2.25.1
> 

-- 
Peter Xu

