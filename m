Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D293F6263
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHXQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:10:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41978 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhHXQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:10:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC66122114;
        Tue, 24 Aug 2021 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629821384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NM/UyP5fMgm6VzeA/16xaMdVO7TUS2GWUzF3N6pt5MY=;
        b=2Lyr+K0NRD4+kMokFJbLcNGiDAEF6Kjl+4qdOq7ILjTnH4hhi6NbBpI7+VVdOMIKFzngYT
        dmE5RmvqOFQcb3ypGll10mYcs80nvW9HUevmg/mFEQR64BhX8b2gauDbKzJig8oi3qzeUp
        cbyDLVHOhaq2s+i116uUESNo28eV+pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629821384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NM/UyP5fMgm6VzeA/16xaMdVO7TUS2GWUzF3N6pt5MY=;
        b=45UgDcqHkbgFjgUKPc0fIhtWy8020yG3jjUzhK3HfEOo0D395k2VFRSuWQ4WrQ4pPGrZ38
        cqr2RGdsR/4dPsCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6E91613A5B;
        Tue, 24 Aug 2021 16:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id t+2gGcgZJWENVwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 16:09:44 +0000
Message-ID: <9d61b4f7-82d0-5caf-88fa-ff1b78704eea@suse.cz>
Date:   Tue, 24 Aug 2021 18:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20210823132513.15836-1-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 0/4] mm/page_alloc: cache pte-mapped allocations
In-Reply-To: <20210823132513.15836-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 15:25, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is early prototype for addition of cache of pte-mapped pages to the
> page allocator. It survives boot and some cache shrinking, but it's still
> a long way to go for it to be ready for non-RFC posting.
> 
> The example use-case for pte-mapped cache is protection of page tables and
> keeping them read-only except for the designated code that is allowed to
> modify the page tables.
> 
> I'd like to get an early feedback for the approach to see what would be
> the best way to move forward with something like this.
> 
> This set is x86 specific at the moment because other architectures either
> do not support set_memory APIs that split the direct^w linear map (e.g.
> PowerPC) or only enable set_memory APIs when the linear map uses basic page
> size (like arm64).
> 
> == Motivation ==
> 
> There are usecases that need to remove pages from the direct map or at

Such use-case is e.g. the SEV-SNP support proposed here:
https://lore.kernel.org/linux-coco/20210820155918.7518-7-brijesh.singh@amd.com/

> least map them with 4K granularity. Whenever this is done e.g. with
> set_memory/set_direct_map APIs, the PUD and PMD sized mappings in the
> direct map are split into smaller pages.
> 
> To reduce the performance hit caused by the fragmentation of the direct map
> it make sense to group and/or cache the 4K pages removed from the direct
> map so that the split large pages won't be all over the place. 
> 
> There were RFCs for grouped page allocations for vmalloc permissions [1]
> and for using PKS to protect page tables [2] as well as an attempt to use a
> pool of large pages in secretmtm [3].
> 
> == Implementation overview ==
> 
> This set leverages ideas from the patches that added PKS protection to page
> tables, but instead of adding per-user grouped allocations it tries to move
> the cache of pte-mapped pages closer to the page allocator.
> 
> The idea is to use a gfp flag that will instruct the page allocator to use
> the cache of pte-mapped pages because the caller needs to remove them from
> the direct map or change their attributes. 

Like Dave, I don't like much the idea of a new GFP flag that all page
allocations now have to check, and freeing that has to check a new pageblock
flag, although I can see some of the benefits this brings...

> When the cache is empty there is an attempt to refill it using PMD-sized
> allocation so that once the direct map is split we'll be able to use all 4K
> pages made available by the split. 
> 
> If the high order allocation fails, we fall back to order-0 and mark the

Yeah, this fallback is where we benefit from the page allocator implementation,
because of the page freeing hook that will recognize page from such fallback
blocks and free them to the cache. But does that prevent so much fragmentation
to be worth it? I'd see first if we can do without it.

> entire pageblock as pte-mapped. When pages from that pageblock are freed to
> the page allocator they are put into the pte-mapped cache. There is also
> unimplemented provision to add free pages from such pageblock to the
> pte-mapped cache along with the page that was allocated and cause the split
> of the pageblock.
> 
> For now only order-0 allocations of pte-mapped pages are supported, which
> prevents, for instance, allocation of PGD with PTI enabled.
> 
> The free pages in the cache may be reclaimed using a shrinker, but for now
> they will remain mapped with PTEs in the direct map.
> 
> == TODOs ==
> 
> Whenever pte-mapped cache is being shrunk, it is possible to add some kind
> of compaction to move all the free pages into PMD-sized chunks, free these
> chunks at once and restore large page in the direct map.
> 
> There is also a possibility to add heuristics and knobs to control
> greediness of the cache vs memory pressure so that freed pte-mapped cache
> won't be necessarily put into the pte-mapped cache.
> 
> Another thing that can be implemented is pre-populating the pte-cache at
> boot time to include the free pages that are anyway mapped by PTEs.
> 
> == Alternatives ==
> 
> Current implementation uses a single global cache.
> 
> Another option is to have per-user caches, e.g one for the page tables,
> another for vmalloc etc.  This approach provides better control of the
> permissions of the pages allocated from these caches and allows the user to
> decide when (if at all) the pages can be accessed, e.g. for cache
> compaction. The down side of this approach is that it complicates the
> freeing path. A page allocated from a dedicated cache cannot be freed with
> put_page()/free_page() etc but it has to be freed with a dedicated API or
> there should be some back pointer in struct page so that page allocator
> will know what cache this page came from.
> 
> Yet another possibility to make pte-mapped cache a migratetype of its own.
> Creating a new migratetype would allow higher order allocations of
> pte-mapped pages, but I don't have enough understanding of page allocator
> and reclaim internals to estimate the complexity associated with this
> approach. 
> 
> [1] https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com/
> [2] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com
> [3] https://lore.kernel.org/lkml/20210121122723.3446-8-rppt@kernel.org/
> 
> Mike Rapoport (2):
>   mm/page_alloc: introduce __GFP_PTE_MAPPED flag to allocate pte-mapped pages
>   x86/mm: write protect (most) page tables
> 
> Rick Edgecombe (2):
>   list: Support getting most recent element in list_lru
>   list: Support list head not in object for list_lru
> 
>  arch/Kconfig                            |   8 +
>  arch/x86/Kconfig                        |   1 +
>  arch/x86/boot/compressed/ident_map_64.c |   3 +
>  arch/x86/include/asm/pgalloc.h          |   2 +
>  arch/x86/include/asm/pgtable.h          |  21 +-
>  arch/x86/include/asm/pgtable_64.h       |  33 ++-
>  arch/x86/mm/init.c                      |   2 +-
>  arch/x86/mm/pgtable.c                   |  72 ++++++-
>  include/asm-generic/pgalloc.h           |   2 +-
>  include/linux/gfp.h                     |  11 +-
>  include/linux/list_lru.h                |  26 +++
>  include/linux/mm.h                      |   2 +
>  include/linux/pageblock-flags.h         |  26 +++
>  init/main.c                             |   1 +
>  mm/internal.h                           |   3 +-
>  mm/list_lru.c                           |  38 +++-
>  mm/page_alloc.c                         | 261 +++++++++++++++++++++++-
>  17 files changed, 496 insertions(+), 16 deletions(-)
> 

