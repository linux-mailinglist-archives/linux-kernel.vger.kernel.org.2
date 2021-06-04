Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4F39BD07
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFDQZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFDQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:25:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6579C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 09:23:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c11so12298431ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j4zffj7E9EbdbLK666HJjMAp0CCeTiBG3SeLs6yURco=;
        b=Xd9Q5Akkct+3Yc/b5EMB8H3iNUzudJwdTcz/rqPQmSyq4OQHua2LaBtMg3H+TZICsF
         Z+qObzNdoIvKqchb8V3DUxkszulPKFrcjr1wib/gKPs8y/FgiDAZWY0ZCRUoJKblDzJy
         nc+C+WMpyYKPHHEvAefee8NtFffZnK1hSSrz2ljLJVFyBlBTInzllrJm0K188Sjs7gOO
         L4PdYmDPWTq6jvxLLVM1/rSKcIYERhMVt7avbX5J9MkgPDDoJfb9Y4UCEFTmcZqgbzvP
         gPWovDFH/aK7MsPJqu6OnqsACkxgAJvk/NItKQ961j2E4/QZLJhdkUKGmgA56fCJfRmC
         eh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4zffj7E9EbdbLK666HJjMAp0CCeTiBG3SeLs6yURco=;
        b=gg+Orcs7r10n4nFsJoQTh7R7vbkuHFi5ncJD8XNZckl+cT+DymBQqDdRAYYc4saGMQ
         2RhxIjQQa8MXaglfoDjVNstfjMA2+SaHTclCWp6ReiNnh5io9YmLjd+Xp8Ydc1n8/8lt
         z28IF51Ndg9bh6amxVJAl52xcBDh4pZ6UM2tioogOSSG6By5UTTS7SmQj6V1DVy022Iu
         Apm/jMRR++kdtDgq3hYibaqQyYIRgPTAp5KuAOEYvRAbb43Mm6Mk9JlxK8ng1Zu9OJG0
         wCnY00iiPbRaESWxH4zIeTlrYE5cqnsCFnfWlu+jee9QThIDzsSguMa4v8QidaGtAKzZ
         a0EA==
X-Gm-Message-State: AOAM530u0McccL0/a9CSePUnmGKcroLqW9KNnlEozJXympZgrHJ6LPk6
        N21ceBdBx/Gy/w7P+TzRbJcbKA==
X-Google-Smtp-Source: ABdhPJzTRJby1E7MHjm2jAHe7li5T6aIsGgqsyeh1pmumnjO2kcY+nhmf5gkZSODzdsl3jFuDylcXQ==
X-Received: by 2002:a05:651c:178f:: with SMTP id bn15mr4174552ljb.448.1622823831248;
        Fri, 04 Jun 2021 09:23:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a3sm232252lfu.11.2021.06.04.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:23:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ECB991027A9; Fri,  4 Jun 2021 19:24:02 +0300 (+03)
Date:   Fri, 4 Jun 2021 19:24:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/thp: fix page_vma_mapped_walk() if huge page
 mapped by ptes
Message-ID: <20210604162402.iclcdd3ywynkoamy@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011411290.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011411290.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:13:21PM -0700, Hugh Dickins wrote:
> Running certain tests with a DEBUG_VM kernel would crash within hours,
> on the total_mapcount BUG() in split_huge_page_to_list(), while trying
> to free up some memory by punching a hole in a shmem huge page: split's
> try_to_unmap() was unable to find all the mappings of the page (which,
> on a !DEBUG_VM kernel, would then keep the huge page pinned in memory).
> 
> Crash dumps showed two tail pages of a shmem huge page remained mapped
> by pte: ptes in a non-huge-aligned vma of a gVisor process, at the end
> of a long unmapped range; and no page table had yet been allocated for
> the head of the huge page to be mapped into.
> 
> Although designed to handle these odd misaligned huge-page-mapped-by-pte
> cases, page_vma_mapped_walk() falls short by returning false prematurely
> when !pmd_present or !pud_present or !p4d_present or !pgd_present: there
> are cases when a huge page may span the boundary, with ptes present in
> the next.

Oh. My bad. I guess it was pain to debug.

> Restructure page_vma_mapped_walk() as a loop to continue in these cases,
> while keeping its layout much as before. Add a step_forward() helper to
> advance pvmw->address across those boundaries: originally I tried to use
> mm's standard p?d_addr_end() macros, but hit the same crash 512 times
> less often: because of the way redundant levels are folded together,
> but folded differently in different configurations, it was just too
> difficult to use them correctly; and step_forward() is simpler anyway.
> 
> Merged various other minor fixes and cleanups into page_vma_mapped_walk()
> as I worked on it: which I find much easier to enumerate here than to
> prise apart into separate commits.

But it makes it harder to review...

> Handle all of the hugetlbfs PageHuge() case once at the start,
> so we don't need to worry about it again further down.
> 
> Sometimes local copy of pvmw->page was used, sometimes pvmw->page:
> just use pvmw->page throughout (and continue to use pvmw->address
> throughout, though we could take a local copy instead).
> 
> Use pmd_read_atomic() with barrier() instead of READ_ONCE() for pmde:
> some architectures (e.g. i386 with PAE) have a multi-word pmd entry,
> for which READ_ONCE() is not good enough.
> 
> Re-evaluate pmde after taking lock, then use it in subsequent tests,
> instead of repeatedly dereferencing pvmw->pmd pointer.
> 
> Rearrange the !pmd_present block to follow the same "return not_found,
> return not_found, return true" pattern as the block above it (note:
> returning not_found there is never premature, since the existence or
> prior existence of a huge pmd guarantees good alignment).
> 
> Adjust page table boundary test in case address was not page-aligned.
> 
> Reset pvmw->pte to NULL after unmapping that page table.
> 
> Respect the 80-column line limit.
> 
> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

I tried to review it and superficially it looks good, but it has to be
split into bunch of patches.


>  		/* when pud is not present, pte will be NULL */
> -		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
> +		pvmw->pte = huge_pte_offset(mm, pvmw->address,
> +					    page_size(pvmw->page));

AFAICS, it exactly fits into 80-column.

>  		if (!pvmw->pte)
>  			return false;
>  
> -		pvmw->ptl = huge_pte_lockptr(page_hstate(page), mm, pvmw->pte);
> +		pvmw->ptl = huge_pte_lockptr(page_hstate(pvmw->page),
> +					     mm, pvmw->pte);

And this one end on 79.

Hm?

-- 
 Kirill A. Shutemov
