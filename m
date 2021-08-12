Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2823EADAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbhHLXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238050AbhHLXiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C30B610CF;
        Thu, 12 Aug 2021 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811479;
        bh=cpK9jdDVnyzUhhaLu6k4Nl4QhGWKsalzqRxrkovXOy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHFvkmg3DnqKPsG484pJFu4vngYzfYgCM9Sn03Lcy1JGuAc2LeyuOYEyMZqKwjB9j
         fPDVQ//D+UGAIIg5iL/aY8yqTzUWYXK14bPDweaNhyKYFXs2x/F6X7TK5TovUd5Dtx
         44WSgUgpAiJENUVnnaVri3UPdb2uhceOR/3RO2Vc+wABGbduL1thNSpaACoTH0YvaB
         IvhlBTSgQfzOFoQ5rPMIBPwWIGWcZ14ZVoXFgFhElMIEyD59vuwPEzqCpaCS2CPkV3
         t/CI0MCKfcn/w0OabuJeBrYpPPKLzWZjwEnC5OSe7A08+U9LIr2jbgo1PM39rXgUZA
         wSM2zygyM1bsg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 05/19] ARC: mm: Enable STRICT_MM_TYPECHECKS
Date:   Thu, 12 Aug 2021 16:37:39 -0700
Message-Id: <20210812233753.104217-6-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past I've refrained from doing this (at least 2 times) due to the
slight code bloat due to ABI implications of pte_t etc becoming struct

Per ARC ABI, functions return struct via memory and not through register
r0, even if the struct would fit in register(s)

 - caller allocates space on stack and passes the address as first arg
   (r0), shifting rest of args by one

 - callee creates return struct in memory (referenced via r0)

This time around the code actually shrunk slightly (due to subtle
inlining heuristic effects), but still slightly inefficient due to
return values passed through memory. That however seems like a small
cost compared to maintenance burden given the impending new mmu support
for page walk etc

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/page.h | 26 --------------------------
 arch/arc/mm/ioremap.c       |  2 +-
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 4a9d33372fe2..c4ac827379cd 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -34,12 +34,6 @@ void copy_user_highpage(struct page *to, struct page *from,
 			unsigned long u_vaddr, struct vm_area_struct *vma);
 void clear_user_page(void *to, unsigned long u_vaddr, struct page *page);
 
-#undef STRICT_MM_TYPECHECKS
-
-#ifdef STRICT_MM_TYPECHECKS
-/*
- * These are used to make use of C type-checking..
- */
 typedef struct {
 #ifdef CONFIG_ARC_HAS_PAE40
 	unsigned long long pte;
@@ -64,26 +58,6 @@ typedef struct {
 
 #define pte_pgprot(x) __pgprot(pte_val(x))
 
-#else /* !STRICT_MM_TYPECHECKS */
-
-#ifdef CONFIG_ARC_HAS_PAE40
-typedef unsigned long long pte_t;
-#else
-typedef unsigned long pte_t;
-#endif
-typedef unsigned long pgd_t;
-typedef unsigned long pgprot_t;
-
-#define pte_val(x)	(x)
-#define pgd_val(x)	(x)
-#define pgprot_val(x)	(x)
-#define __pte(x)	(x)
-#define __pgd(x)	(x)
-#define __pgprot(x)	(x)
-#define pte_pgprot(x)	(x)
-
-#endif
-
 typedef pte_t * pgtable_t;
 
 /*
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 95c649fbc95a..052bbd8b1e5f 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -39,7 +39,7 @@ void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
 	if (arc_uncached_addr_space(paddr))
 		return (void __iomem *)(u32)paddr;
 
-	return ioremap_prot(paddr, size, PAGE_KERNEL_NO_CACHE);
+	return ioremap_prot(paddr, size, pgprot_val(PAGE_KERNEL_NO_CACHE));
 }
 EXPORT_SYMBOL(ioremap);
 
-- 
2.25.1

