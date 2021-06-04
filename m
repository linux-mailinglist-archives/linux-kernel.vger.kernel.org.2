Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FED39BC49
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFDPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:54:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2569C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 08:53:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r198so11448528lff.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnKirRT8gUEaS+Q1ln2ecqpD/vhYk0/SWSmMzyGGPnI=;
        b=Bx6EQYG0JsnQygCUhJjF4HE+jUEbqyPIRXPnHb3R5iPs3ls1JEjfMZSUnfaWTG12QQ
         ubC4QWKeQDhQf1j78hWZxDnVzH3CUGJEaCUaRAAFx1j10MaWeUdP157tggM5GfwRvZdy
         FIdREU/RcJW27IUalfqcRDkYxo8U0T+XJEoV6bN171QHk/9JeO38Ip8qguof4zeq45Ta
         149/x1ok9HpP/xrRMcOPCZZYewCa+SqGTqqZsVCuvYwnaRx0bGbZRNmoeNBdC5Tq6xup
         o6q9TIh/cI5zfxZI0/2jrhTmtBnV1uZ+okgyqGqOLipGAitiAL+cKjbPy02qE7eVqhg9
         P2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnKirRT8gUEaS+Q1ln2ecqpD/vhYk0/SWSmMzyGGPnI=;
        b=ojqrI3bSgNSkcQkjxUxF3q3HLi17pX092lA3R8Bpd0qIjCFYVOeSH72V6oSfaiA2n7
         A4gf5uFx9jiQcrHcpqP4k1va4oIt1qgd3Rrs275fjJqYC3yzPG/B3JD5Cq5suraqziVk
         yfCn+NPCvTl87lDU1HRMZm9bLjFm9tjiT/cs7UMZKt5L5LXgUBsLVS7V8gHVMuUjxl3M
         4lCN5U19PLjtkkOIu5knwCJ5SzllT4qqknUpjDqOn8cTEf3zT9VPmeOd+1QhazVa/R66
         ieVooKCfq1MLaUPmiOhHzsMzgW7Ce+Hv8j3hOth0v0c7tW+7Ptn2F/LhUyf2uxd5cJA8
         cCtQ==
X-Gm-Message-State: AOAM532ysUMAG8fmLwooa9TAD1WkOXaKXALkF4qJh8aJu/xXx3iplVr8
        ryNgjSv6uqEHVoLJLljHBtcG2A==
X-Google-Smtp-Source: ABdhPJzOsEg22+90pdmD9RIooxcQ31amNV/OFN+xJYCPar43Qhf3WP5Hn4EkNUX2giku+mVGd019xw==
X-Received: by 2002:ac2:519a:: with SMTP id u26mr3213934lfi.639.1622821991157;
        Fri, 04 Jun 2021 08:53:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r22sm742329ljp.129.2021.06.04.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:53:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EC1251027A9; Fri,  4 Jun 2021 18:53:22 +0300 (+03)
Date:   Fri, 4 Jun 2021 18:53:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mm/thp: fix vma_address() if virtual address
 below file offset
Message-ID: <20210604155322.vl6wcen4fmngg27r@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011408020.2148@eggly.anvils>
 <YLanDVVbKwwPmW/0@casper.infradead.org>
 <alpine.LSU.2.11.2106031427200.11704@eggly.anvils>
 <alpine.LSU.2.11.2106031436390.11704@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106031436390.11704@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:40:30PM -0700, Hugh Dickins wrote:
> Running certain tests with a DEBUG_VM kernel would crash within hours,
> on the total_mapcount BUG() in split_huge_page_to_list(), while trying
> to free up some memory by punching a hole in a shmem huge page: split's
> try_to_unmap() was unable to find all the mappings of the page (which,
> on a !DEBUG_VM kernel, would then keep the huge page pinned in memory).
> 
> When that BUG() was changed to a WARN(), it would later crash on the
> VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma) in
> mm/internal.h:vma_address(), used by rmap_walk_file() for try_to_unmap().
> 
> vma_address() is usually correct, but there's a wraparound case when the
> vm_start address is unusually low, but vm_pgoff not so low: vma_address()
> chooses max(start, vma->vm_start), but that decides on the wrong address,
> because start has become almost ULONG_MAX.
> 
> Rewrite vma_address() to be more careful about vm_pgoff; move the
> VM_BUG_ON_VMA() out of it, returning -EFAULT for errors, so that it can
> be safely used from page_mapped_in_vma() and page_address_in_vma() too.
> 
> Add vma_address_end() to apply similar care to end address calculation,
> in page_vma_mapped_walk() and page_mkclean_one() and try_to_unmap_one();
> though it raises a question of whether callers would do better to supply
> pvmw->end to page_vma_mapped_walk() - I chose not, for a smaller patch.
> 
> An irritation is that their apparent generality breaks down on KSM pages,
> which cannot be located by the page->index that page_to_pgoff() uses: as
> 4b0ece6fa016 ("mm: migrate: fix remove_migration_pte() for ksm pages")
> once discovered.  I dithered over the best thing to do about that, and
> have ended up with a VM_BUG_ON_PAGE(PageKsm) in both vma_address() and
> vma_address_end(); though the only place in danger of using it on them
> was try_to_unmap_one().
> 
> Sidenote: vma_address() and vma_address_end() now use compound_nr() on
> a head page, instead of thp_size(): to make the right calculation on a
> hugetlbfs page, whether or not THPs are configured.  try_to_unmap() is
> used on hugetlbfs pages, but perhaps the wrong calculation never mattered.
> 
> Fixes: a8fa41ad2f6f ("mm, rmap: check all VMAs that PTE-mapped THP can be part of")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
