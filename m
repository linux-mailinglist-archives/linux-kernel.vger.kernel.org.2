Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665EA3F4BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhHWN0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235813AbhHWN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:26:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AFF46126A;
        Mon, 23 Aug 2021 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629725121;
        bh=MaOXs1EQfq1559uMOg9vctLP0pFu5xuo7UllZjF95SI=;
        h=From:To:Cc:Subject:Date:From;
        b=kUvZJ1qyoV/dZDcU0Jl1yJ3BfgEw30VdMasYb2bx2pI9nwFMFWE8+8n5cBqgWkq95
         zhr+oD5z5a3593fqDwtROH8Km464i75g1aDCTXnkz+NvhEIU004sfsHgjKlKlZIj/X
         6TpJhZqLjExZC/uVXrcpch54Soe67+vrZXuGcjCzL/2peLJGgAwQeS8OOSqR+KG2+i
         iIcm+n/7bZIijUeboB+Cx9QbWIV6q7uxGr18fEka+3w9ZKCVf7WDpYCc7gDnIPH2BX
         dymig5tu4R7197XCVFWh21WsmE/pVQvbhFAdaVAr5TKP7a6ho8GZBwvMvxFjubq4Tc
         2vXcJNUBDEOuw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] mm/page_alloc: cache pte-mapped allocations
Date:   Mon, 23 Aug 2021 16:25:09 +0300
Message-Id: <20210823132513.15836-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is early prototype for addition of cache of pte-mapped pages to the
page allocator. It survives boot and some cache shrinking, but it's still
a long way to go for it to be ready for non-RFC posting.

The example use-case for pte-mapped cache is protection of page tables and
keeping them read-only except for the designated code that is allowed to
modify the page tables.

I'd like to get an early feedback for the approach to see what would be
the best way to move forward with something like this.

This set is x86 specific at the moment because other architectures either
do not support set_memory APIs that split the direct^w linear map (e.g.
PowerPC) or only enable set_memory APIs when the linear map uses basic page
size (like arm64).

== Motivation ==

There are usecases that need to remove pages from the direct map or at
least map them with 4K granularity. Whenever this is done e.g. with
set_memory/set_direct_map APIs, the PUD and PMD sized mappings in the
direct map are split into smaller pages.

To reduce the performance hit caused by the fragmentation of the direct map
it make sense to group and/or cache the 4K pages removed from the direct
map so that the split large pages won't be all over the place. 

There were RFCs for grouped page allocations for vmalloc permissions [1]
and for using PKS to protect page tables [2] as well as an attempt to use a
pool of large pages in secretmtm [3].

== Implementation overview ==

This set leverages ideas from the patches that added PKS protection to page
tables, but instead of adding per-user grouped allocations it tries to move
the cache of pte-mapped pages closer to the page allocator.

The idea is to use a gfp flag that will instruct the page allocator to use
the cache of pte-mapped pages because the caller needs to remove them from
the direct map or change their attributes. 

When the cache is empty there is an attempt to refill it using PMD-sized
allocation so that once the direct map is split we'll be able to use all 4K
pages made available by the split. 

If the high order allocation fails, we fall back to order-0 and mark the
entire pageblock as pte-mapped. When pages from that pageblock are freed to
the page allocator they are put into the pte-mapped cache. There is also
unimplemented provision to add free pages from such pageblock to the
pte-mapped cache along with the page that was allocated and cause the split
of the pageblock.

For now only order-0 allocations of pte-mapped pages are supported, which
prevents, for instance, allocation of PGD with PTI enabled.

The free pages in the cache may be reclaimed using a shrinker, but for now
they will remain mapped with PTEs in the direct map.

== TODOs ==

Whenever pte-mapped cache is being shrunk, it is possible to add some kind
of compaction to move all the free pages into PMD-sized chunks, free these
chunks at once and restore large page in the direct map.

There is also a possibility to add heuristics and knobs to control
greediness of the cache vs memory pressure so that freed pte-mapped cache
won't be necessarily put into the pte-mapped cache.

Another thing that can be implemented is pre-populating the pte-cache at
boot time to include the free pages that are anyway mapped by PTEs.

== Alternatives ==

Current implementation uses a single global cache.

Another option is to have per-user caches, e.g one for the page tables,
another for vmalloc etc.  This approach provides better control of the
permissions of the pages allocated from these caches and allows the user to
decide when (if at all) the pages can be accessed, e.g. for cache
compaction. The down side of this approach is that it complicates the
freeing path. A page allocated from a dedicated cache cannot be freed with
put_page()/free_page() etc but it has to be freed with a dedicated API or
there should be some back pointer in struct page so that page allocator
will know what cache this page came from.

Yet another possibility to make pte-mapped cache a migratetype of its own.
Creating a new migratetype would allow higher order allocations of
pte-mapped pages, but I don't have enough understanding of page allocator
and reclaim internals to estimate the complexity associated with this
approach. 

[1] https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com
[3] https://lore.kernel.org/lkml/20210121122723.3446-8-rppt@kernel.org/

Mike Rapoport (2):
  mm/page_alloc: introduce __GFP_PTE_MAPPED flag to allocate pte-mapped pages
  x86/mm: write protect (most) page tables

Rick Edgecombe (2):
  list: Support getting most recent element in list_lru
  list: Support list head not in object for list_lru

 arch/Kconfig                            |   8 +
 arch/x86/Kconfig                        |   1 +
 arch/x86/boot/compressed/ident_map_64.c |   3 +
 arch/x86/include/asm/pgalloc.h          |   2 +
 arch/x86/include/asm/pgtable.h          |  21 +-
 arch/x86/include/asm/pgtable_64.h       |  33 ++-
 arch/x86/mm/init.c                      |   2 +-
 arch/x86/mm/pgtable.c                   |  72 ++++++-
 include/asm-generic/pgalloc.h           |   2 +-
 include/linux/gfp.h                     |  11 +-
 include/linux/list_lru.h                |  26 +++
 include/linux/mm.h                      |   2 +
 include/linux/pageblock-flags.h         |  26 +++
 init/main.c                             |   1 +
 mm/internal.h                           |   3 +-
 mm/list_lru.c                           |  38 +++-
 mm/page_alloc.c                         | 261 +++++++++++++++++++++++-
 17 files changed, 496 insertions(+), 16 deletions(-)

-- 
2.28.0

