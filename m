Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6F33705B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhCKKnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhCKKnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:43:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC8B764FC1;
        Thu, 11 Mar 2021 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615459410;
        bh=W+wnECo6RRj9GRx2hZne8BKNcZLOKizWgp0shy4URrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgAS24faT96JxuxYyBDnKYTGtEQ1usnqCu0767AmcH8DPCEQYdnLYvPXtxwoQj0Yy
         yBLeXZvStZhRmRlujZfn0Xy70hNi5DCaUXrhIs18UN4s0nR1k9XGMYS8SeQWLt5J78
         ca9a32eoJGobjPn94gr8lkwCLwSJOBJ/E9updVUE3ehiVdA/ph8NqCneWh6QqZQabL
         CLO54CI6vA6fj3TS+N50AyxX/janeNSZ4pdqL5RX9trZDl6gSEf53OhO6AhtXDB7yK
         bWDIF/GOw574sEFbiMPF38XFl/1ROZm3jwtBK70BtTO5Eyjt9ltYCi33zPqF5Orj6D
         yyeOfVpMo1mMw==
Date:   Thu, 11 Mar 2021 12:43:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
Message-ID: <YEn0SvIuSD0zedGI@kernel.org>
References: <1615174073-10520-1-git-send-email-anshuman.khandual@arm.com>
 <YEXme5SI+GxsYli8@kernel.org>
 <003d8a4b-9687-3e9a-c27b-908db280b44c@arm.com>
 <20210311093302.GA30603@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311093302.GA30603@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:33:02AM +0000, Will Deacon wrote:
> On Thu, Mar 11, 2021 at 01:22:53PM +0530, Anshuman Khandual wrote:
> > On 3/8/21 2:25 PM, Mike Rapoport wrote:
> > > On Mon, Mar 08, 2021 at 08:57:53AM +0530, Anshuman Khandual wrote:
> > >> Platforms like arm and arm64 have redefined pfn_valid() because their early
> > >> memory sections might have contained memmap holes caused by memblock areas
> > >> tagged with MEMBLOCK_NOMAP, which should be skipped while validating a pfn
> > >> for struct page backing. This scenario could be captured with a new option
> > >> CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES and then generic pfn_valid() can be
> > >> improved to accommodate such platforms. This reduces overall code footprint
> > >> and also improves maintainability.
> > > 
> > > I wonder whether arm64 would still need to free parts of its memmap after
> > 
> > free_unused_memmap() is applicable when CONFIG_SPARSEMEM_VMEMMAP is not enabled.
> > I am not sure whether there still might be some platforms or boards which would
> > benefit from this. Hence lets just keep this unchanged for now.
> 
> In my opinion, unless there's a compelling reason for us to offer all of
> these different implementations of the memmap on arm64 then we shouldn't
> bother -- it's not like it's fun to maintain! Just use sparsemem vmemmap
> and be done with it. Is there some reason we can't do that?

Regardless if the decision to stop supporting other memory models, I think
it's a long due for arm64 to stop using pfn_valid() for anything except to
check whether there is a valid struct page for a pfn.

Something like the completely untested patch below:

From 3a753a56c2d87711f937ba09e4e14e4ad4926c38 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 11 Mar 2021 12:28:29 +0200
Subject: [PATCH] arm64: decouple check whether pfn is normal memory from
 pfn_valid()

The intended semantics of pfn_valid() is to verify whether there is a
struct page for the pfn in question and nothing else.

Yet, on arm64 it is used to distinguish memory areas that are mapped in the
linear map vs those that require ioremap() to access them.

Introduce a dedicated pfn_is_memory() to perform such check and use it
where appropriate.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h | 2 +-
 arch/arm64/include/asm/page.h   | 1 +
 arch/arm64/kvm/mmu.c            | 2 +-
 arch/arm64/mm/init.c            | 6 ++++++
 arch/arm64/mm/ioremap.c         | 4 ++--
 arch/arm64/mm/mmu.c             | 2 +-
 6 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c759faf7a1ff..778dbfe95d0e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -346,7 +346,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 
 #define virt_addr_valid(addr)	({					\
 	__typeof__(addr) __addr = __tag_reset(addr);			\
-	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
+	__is_lm_address(__addr) && pfn_is_memory(virt_to_pfn(__addr));	\
 })
 
 void dump_mem_limit(void);
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..32b485bcc6ff 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
 typedef struct page *pgtable_t;
 
 extern int pfn_valid(unsigned long);
+extern int pfn_is_memory(unsigned long);
 
 #include <asm/memory.h>
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 77cb2d28f2a4..a60069604361 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 
 static bool kvm_is_device_pfn(unsigned long pfn)
 {
-	return !pfn_valid(pfn);
+	return !pfn_is_memory(pfn);
 }
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0ace5e68efba..77c08853bafc 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -235,6 +235,12 @@ int pfn_valid(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_valid);
 
+int pfn_is_memory(unsigned long pfn)
+{
+	return memblock_is_map_memory(PFN_PHYS(pfn));
+}
+EXPORT_SYMBOL(pfn_is_memory);
+
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index b5e83c46b23e..82a369b22ef5 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -43,7 +43,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
 	/*
 	 * Don't allow RAM to be mapped.
 	 */
-	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
+	if (WARN_ON(pfn_is_memory(__phys_to_pfn(phys_addr))))
 		return NULL;
 
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
@@ -84,7 +84,7 @@ EXPORT_SYMBOL(iounmap);
 void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 {
 	/* For normal memory we already have a cacheable mapping. */
-	if (pfn_valid(__phys_to_pfn(phys_addr)))
+	if (pfn_is_memory(__phys_to_pfn(phys_addr)))
 		return (void __iomem *)__phys_to_virt(phys_addr);
 
 	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3802cfbdd20d..ee66f2f21b6f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -81,7 +81,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-	if (!pfn_valid(pfn))
+	if (!pfn_is_memory(pfn))
 		return pgprot_noncached(vma_prot);
 	else if (file->f_flags & O_SYNC)
 		return pgprot_writecombine(vma_prot);
-- 
2.28.0


-- 
Sincerely yours,
Mike.
