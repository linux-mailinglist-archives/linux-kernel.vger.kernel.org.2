Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B320365512
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhDTJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhDTJPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94DCB613C0;
        Tue, 20 Apr 2021 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618910071;
        bh=I4+h/ALipOTPP6DVYApUM93ogLgtliC1nXYZbDm499c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/3KzwBNbvMZ9vKiinkZ0txuvP4OiZKHL8BEzNUWy7Wzf65zexnSIHJBEGIoSngC4
         yMxMN0SEdFoJL37GE9t4jHYb9euOV8VZDjNgd8XOSQzdgroqsi5NoO6QUCbrNiqGs2
         pgL3QVdxygB6k7DNnxjxPVoGmvhGSQLgh09nHa6seG/x+CuGow1LABULJWa16oDE4k
         CD+esqvI0QLFr3H+jI5eUBq8GtGf/ho7SZuzzvCtwTHL7ITBFP+u3mGbi1X6rd4Q5g
         YJ4nRYOotTP/1slJAwU2btpOdddzyS6wwIrn1dk64jMJ8J+WH8Cuw3oiQnQpenoOe0
         86WsTb3PXhoDA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 3/4] arm64: decouple check whether pfn is in linear map from pfn_valid()
Date:   Tue, 20 Apr 2021 12:09:24 +0300
Message-Id: <20210420090925.7457-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210420090925.7457-1-rppt@kernel.org>
References: <20210420090925.7457-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The intended semantics of pfn_valid() is to verify whether there is a
struct page for the pfn in question and nothing else.

Yet, on arm64 it is used to distinguish memory areas that are mapped in the
linear map vs those that require ioremap() to access them.

Introduce a dedicated pfn_is_map_memory() wrapper for
memblock_is_map_memory() to perform such check and use it where
appropriate.

Using a wrapper allows to avoid cyclic include dependencies.

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
index 0aabc3be9a75..194f9f993d30 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 
 #define virt_addr_valid(addr)	({					\
 	__typeof__(addr) __addr = __tag_reset(addr);			\
-	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
+	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
 })
 
 void dump_mem_limit(void);
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..99a6da91f870 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
 typedef struct page *pgtable_t;
 
 extern int pfn_valid(unsigned long);
+extern int pfn_is_map_memory(unsigned long);
 
 #include <asm/memory.h>
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8711894db8c2..23dd99e29b23 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 
 static bool kvm_is_device_pfn(unsigned long pfn)
 {
-	return !pfn_valid(pfn);
+	return !pfn_is_map_memory(pfn);
 }
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3685e12aba9b..c54e329aca15 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -258,6 +258,12 @@ int pfn_valid(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_valid);
 
+int pfn_is_map_memory(unsigned long pfn)
+{
+	return memblock_is_map_memory(PFN_PHYS(pfn));
+}
+EXPORT_SYMBOL(pfn_is_map_memory);
+
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index b5e83c46b23e..b7c81dacabf0 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -43,7 +43,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
 	/*
 	 * Don't allow RAM to be mapped.
 	 */
-	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
+	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
 		return NULL;
 
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
@@ -84,7 +84,7 @@ EXPORT_SYMBOL(iounmap);
 void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 {
 	/* For normal memory we already have a cacheable mapping. */
-	if (pfn_valid(__phys_to_pfn(phys_addr)))
+	if (pfn_is_map_memory(__phys_to_pfn(phys_addr)))
 		return (void __iomem *)__phys_to_virt(phys_addr);
 
 	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5d9550fdb9cf..26045e9adbd7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -81,7 +81,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-	if (!pfn_valid(pfn))
+	if (!pfn_is_map_memory(pfn))
 		return pgprot_noncached(vma_prot);
 	else if (file->f_flags & O_SYNC)
 		return pgprot_writecombine(vma_prot);
-- 
2.28.0

