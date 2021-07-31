Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C305A3DC7AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhGaSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 14:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhGaSbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 14:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C72C60249;
        Sat, 31 Jul 2021 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627756262;
        bh=wcL8LKqD7plHbuL5aCU90muQjJeiN0ilEFxCfkUJ5aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djL2FsraWKjMbxg+WPHW7kuHBKAhWWIHw6e51eMNZlHXLBLoQZdXuAGu0c9hDQ6/1
         RttWEbBHmK0DsjZYrA+ePAI+dhgDtaHS8qsg83Xf0o0bTbatAL4tYzQIePXESdnuXE
         n4Nz5cPWl5w7OAwxcvcXF+nCR7G3W6YCAu0Gk6xrYuk6wldDI7+28jBYI0pTbd3/ME
         mgPXyO9p5RAovB3xOX0z/klK1wLuFpLVTiesFFm4SZ91N4ujaP376P591ENXj10pP1
         1ntRsl/XTZ6zQ5j9OxZ3K4CJiFhzMlwUkJm0hofGogFNisgmiZIo1WFHY1UkVHvMjC
         tkUrLg5xKb6hg==
Date:   Sat, 31 Jul 2021 21:30:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/page_alloc: always initialize memory map for the
 holes
Message-ID: <YQWW3RCE4eWBuMu/@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-2-rppt@kernel.org>
 <20210731165601.GA1900220@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731165601.GA1900220@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 09:56:01AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jul 14, 2021 at 03:37:36PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Currently memory map for the holes is initialized only when SPARSEMEM
> > memory model is used. Yet, even with FLATMEM there could be holes in the
> > physical memory layout that have memory map entries.
> > 
> > For instance, the memory reserved using e820 API on i386 or
> > "reserved-memory" nodes in device tree would not appear in memblock.memory
> > and hence the struct pages for such holes will be skipped during memory map
> > initialization.
> > 
> > These struct pages will be zeroed because the memory map for FLATMEM
> > systems is allocated with memblock_alloc_node() that clears the allocated
> > memory. While zeroed struct pages do not cause immediate problems, the
> > correct behaviour is to initialize every page using __init_single_page().
> > Besides, enabling page poison for FLATMEM case will trigger
> > PF_POISONED_CHECK() unless the memory map is properly initialized.
> > 
> > Make sure init_unavailable_range() is called for both SPARSEMEM and FLATMEM
> > so that struct pages representing memory holes would appear as PG_Reserved
> > with any memory layout.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> This patch causes microblaze petalogix-ml605 qemu emulations to fail
> silently (no console output). Reverting it fixes the problem.

It appears that petalogix-ml605 memory starts at 0x50000, but microblaze's
pfn_valid does not reject pfns < ARCH_PFN_OFFSET.

This should fix the issue:

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index ce550978f4fc..4b8b2fa78fc5 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -112,8 +112,7 @@ extern int page_is_ram(unsigned long pfn);
 #  define page_to_phys(page)     (page_to_pfn(page) << PAGE_SHIFT)
 
 #  define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
-#  define pfn_valid(pfn)	((pfn) < (max_mapnr + ARCH_PFN_OFFSET))
-
+#  define pfn_valid(pfn)	((pfn) >= ARCH_PFN_OFFSET && (pfn) < (max_mapnr + ARCH_PFN_OFFSET))
 # endif /* __ASSEMBLY__ */
 
 #define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
> Guenter
> 
> ---
> Bisect log:
> 
> # bad: [8d4b477da1a807199ca60e0829357ce7aa6758d5] Add linux-next specific files for 20210730
> # good: [ff1176468d368232b684f75e82563369208bc371] Linux 5.14-rc3
> git bisect start 'HEAD' 'v5.14-rc3'
> # good: [8f3eb1f5c702ef868d89799b03c21d122f2fe197] Merge remote-tracking branch 'bpf-next/for-next'
> git bisect good 8f3eb1f5c702ef868d89799b03c21d122f2fe197
> # good: [32286c7080c56c835f25302c38eebccf41b7b576] Merge remote-tracking branch 'tip/auto-latest'
> git bisect good 32286c7080c56c835f25302c38eebccf41b7b576
> # good: [70c40604c7d393f95171f49717a27bf8e05b5439] Merge remote-tracking branch 'dmaengine/next'
> git bisect good 70c40604c7d393f95171f49717a27bf8e05b5439
> # good: [b038834891b35ec410693028a500f769db132a81] Merge remote-tracking branch 'rust/rust-next'
> git bisect good b038834891b35ec410693028a500f769db132a81
> # bad: [d8f4e506a9ba375110945d75573b3304491e6350] memory-hotplug.rst: complete admin-guide overhaul
> git bisect bad d8f4e506a9ba375110945d75573b3304491e6350
> # good: [bef692dcfb7cdb5c960abfc31e2386a0ff41af54] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
> git bisect good bef692dcfb7cdb5c960abfc31e2386a0ff41af54
> # bad: [5fcd957e2f0dc4cb25a6ee60ebfb1200de09c9d1] mm-migrate-demote-pages-during-reclaim-v11
> git bisect bad 5fcd957e2f0dc4cb25a6ee60ebfb1200de09c9d1
> # good: [8c2a82ab20eb09d217446989ae209f5ff19a64ac] mm/vmalloc: use batched page requests in bulk-allocator
> git bisect good 8c2a82ab20eb09d217446989ae209f5ff19a64ac
> # bad: [c36a5446e29f1461780b06785769b9402522f847] mm/page_alloc.c: fix 'zone_id' may be used uninitialized in this function warning
> git bisect bad c36a5446e29f1461780b06785769b9402522f847
> # good: [05e358c552628e26be3985933bea88e7512414c0] mm/kasan: move kasan.fault to mm/kasan/report.c
> git bisect good 05e358c552628e26be3985933bea88e7512414c0
> # bad: [b467ff7f560908e60ca181658b7ee48e5da94da1] microblaze: simplify pte_alloc_one_kernel()
> git bisect bad b467ff7f560908e60ca181658b7ee48e5da94da1
> # bad: [d2a572bf593a57246827bd79c91fe2ee6b7af1f0] mm/page_alloc: always initialize memory map for the holes
> git bisect bad d2a572bf593a57246827bd79c91fe2ee6b7af1f0
> # first bad commit: [d2a572bf593a57246827bd79c91fe2ee6b7af1f0] mm/page_alloc: always initialize memory map for the holes

-- 
Sincerely yours,
Mike.
