Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35339BD69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:42:20 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44554 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:42:19 -0400
Received: by mail-lf1-f47.google.com with SMTP id r198so11654989lff.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lH2Y44otqOO8m2Z4QXChzT2bnP+V+GekPu5UvhOWowA=;
        b=WcXs5AdBjkF+CE0fh3kikx+81uypOq9k4xyT49W67A4aj6YLiccUUyGe2cW7L4CptT
         paEfhEFGq8IfuxmcFkl6CWwLrk9CUMuVjhg5gEaZfTGTOBplAkuzAf2ACr5O6hOlvc5s
         uTfYHX3rfu2RjRJaluTtDcatJfoZyWlyeFGiIHu7ovuvgco4thoSK+15kExrMLBP7wn2
         HZJEAC1D0uUPzTRucDMCir3GdbHN4eFTT4nHNg1VTPjE8yA/anj5ym/P24HNiKpH2l9P
         1pedReMy0XjBPXXiAlsvXpnrVw4SgTBjQVp+nLnX+pwMlMU2pzo23uFkDTmnOrWVB6Tc
         4Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lH2Y44otqOO8m2Z4QXChzT2bnP+V+GekPu5UvhOWowA=;
        b=FU81a2p7x9+iPViQqse5Q1NovBxifUT+SqpVIIZJc2QqI2/f9d/pRVSgpVnLvWbMjv
         WJwpq632i+wf+aeYcePdHt7yxSVR6YaSKY73ydbdui7RpgywOrjiIh2ERIfnr5BA5gCN
         bIj40t0md3kVSxrHLqgUau9G9qQBsHamBAZZi6sCrWhismuC8/hm2E4JeQCA7S3dluC3
         lmn1aF0f+r3QHgNAolVeDNUPIa8wuPU7zldFc+/De4sVcKXmdqsOZBWhppn76xfbTU8D
         D/gKmb4hIFzjkOYq1Lqq3BjXiB6tQcAkYg30BgvkDQTDbuPpbxNgde+rHKbT3gq+p/jJ
         T4zA==
X-Gm-Message-State: AOAM532vmg3zjiy5fOk/vwkGVdwL0ey9S5HrPQzlngSCIqNEOQBuyr8X
        jtr+sfprMg0h2X04nEmrAgCndA==
X-Google-Smtp-Source: ABdhPJx/V+1XqlWq70e3IhJsAReN19iVKM8qgiUx8XR3B32eGvcbKMdFJ25EaQuN1FKJBlqBJN7/aA==
X-Received: by 2002:a19:4959:: with SMTP id l25mr3176253lfj.225.1622824762056;
        Fri, 04 Jun 2021 09:39:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z6sm277482lfs.64.2021.06.04.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:39:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9AB471027A9; Fri,  4 Jun 2021 19:39:33 +0300 (+03)
Date:   Fri, 4 Jun 2021 19:39:33 +0300
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
Subject: Re: [PATCH 6/7] mm/thp: unmap_mapping_page() to fix THP
 truncate_cleanup_page()
Message-ID: <20210604163933.h6dj6cgr6tudpprd@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011413280.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011413280.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:15:35PM -0700, Hugh Dickins wrote:
> There is a race between THP unmapping and truncation, when truncate sees
> pmd_none() and skips the entry, after munmap's zap_huge_pmd() cleared it,
> but before its page_remove_rmap() gets to decrement compound_mapcount:
> generating false "BUG: Bad page cache" reports that the page is still
> mapped when deleted.  This commit fixes that, but not in the way I hoped.
> 
> The first attempt used try_to_unmap(page, TTU_SYNC|TTU_IGNORE_MLOCK)
> instead of unmap_mapping_range() in truncate_cleanup_page(): it has often
> been an annoyance that we usually call unmap_mapping_range() with no pages
> locked, but there apply it to a single locked page.  try_to_unmap() looks
> more suitable for a single locked page.
> 
> However, try_to_unmap_one() contains a VM_BUG_ON_PAGE(!pvmw.pte,page):
> it is used to insert THP migration entries, but not used to unmap THPs.
> Copy zap_huge_pmd() and add THP handling now?  Perhaps, but their TLB
> needs are different, I'm too ignorant of the DAX cases, and couldn't
> decide how far to go for anon+swap.  Set that aside.
> 
> The second attempt took a different tack: make no change in truncate.c,
> but modify zap_huge_pmd() to insert an invalidated huge pmd instead of
> clearing it initially, then pmd_clear() between page_remove_rmap() and
> unlocking at the end.  Nice.  But powerpc blows that approach out of the
> water, with its serialize_against_pte_lookup(), and interesting pgtable
> usage.  It would need serious help to get working on powerpc (with a
> minor optimization issue on s390 too).  Set that aside.
> 
> Just add an "if (page_mapped(page)) synchronize_rcu();" or other such
> delay, after unmapping in truncate_cleanup_page()?  Perhaps, but though
> that's likely to reduce or eliminate the number of incidents, it would
> give less assurance of whether we had identified the problem correctly.
> 
> This successful iteration introduces "unmap_mapping_page(page)" instead
> of try_to_unmap(), and goes the usual unmap_mapping_range_tree() route,
> with an addition to details.  Then zap_pmd_range() watches for this case,
> and does spin_unlock(pmd_lock) if so - just like page_vma_mapped_walk()
> now does in the PVMW_SYNC case.  Not pretty, but safe.
> 
> Note that unmap_mapping_page() is doing a VM_BUG_ON(!PageLocked) to
> assert its interface; but currently that's only used to make sure that
> page->mapping is stable, and zap_pmd_range() doesn't care if the page is
> locked or not.  Along these lines, in invalidate_inode_pages2_range()
> move the initial unmap_mapping_range() out from under page lock, before
> then calling unmap_mapping_page() under page lock if still mapped.
> 
> Fixes: fc127da085c2 ("truncate: handle file thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

I think adding support for THP in try_to_unmap_one() is the most
future-proof way. We would need it there eventually.

But this works too:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
