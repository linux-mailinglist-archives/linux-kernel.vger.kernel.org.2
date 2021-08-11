Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17F3E875C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhHKAn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhHKAnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C330610FC;
        Wed, 11 Aug 2021 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642600;
        bh=iW4KvuWuC+r5z39MFQzwrbwCs0tKRK5GIGFWIb/ZRJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agy6Rj11nk6gxe06wBgAua7nlZQ5Lkktx0Qtu9NWGx3Dyz1Ac9gkJfbTindxD4NJb
         iVuNiEnXjhwfd7iOzQIh42HKk7mj/QSv3lYGVA83QIM1zjK1KTZxKWtt10tPW8abL7
         QcB4UC8QATKQ2XIOcbTGGiuba4r5F5wyMGhNuM/bB8ehF6Vtz/70Wo23Np+qvS821W
         yQ6zTuTQG9h/rkXk+7Sz40K8+hK+FLYpZQUV0uT3Q0bAsr/J+jl9nh2986SA5G41YZ
         6T/OzK/iD2vARp9YolUHaRcVfZMjd0I0ruDHt4s+h6VfCNZrKi/1NbRU1OgopWpU3G
         UDwuuvxls+8Lw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 09/18] ARC: mm: non-functional code cleanup ahead of 3 levels
Date:   Tue, 10 Aug 2021 17:42:49 -0700
Message-Id: <20210811004258.138075-10-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/page.h    | 30 ++++++++++++++++--------------
 arch/arc/include/asm/pgalloc.h |  7 ++++++-
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index c4ac827379cd..313e6f543d2d 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -34,6 +34,13 @@ void copy_user_highpage(struct page *to, struct page *from,
 			unsigned long u_vaddr, struct vm_area_struct *vma);
 void clear_user_page(void *to, unsigned long u_vaddr, struct page *page);
 
+typedef struct {
+	unsigned long pgd;
+} pgd_t;
+
+#define pgd_val(x)	((x).pgd)
+#define __pgd(x)	((pgd_t) { (x) })
+
 typedef struct {
 #ifdef CONFIG_ARC_HAS_PAE40
 	unsigned long long pte;
@@ -41,22 +48,17 @@ typedef struct {
 	unsigned long pte;
 #endif
 } pte_t;
-typedef struct {
-	unsigned long pgd;
-} pgd_t;
+
+#define pte_val(x)	((x).pte)
+#define __pte(x)	((pte_t) { (x) })
+
 typedef struct {
 	unsigned long pgprot;
 } pgprot_t;
 
-#define pte_val(x)      ((x).pte)
-#define pgd_val(x)      ((x).pgd)
-#define pgprot_val(x)   ((x).pgprot)
-
-#define __pte(x)        ((pte_t) { (x) })
-#define __pgd(x)        ((pgd_t) { (x) })
-#define __pgprot(x)     ((pgprot_t) { (x) })
-
-#define pte_pgprot(x) __pgprot(pte_val(x))
+#define pgprot_val(x)	((x).pgprot)
+#define __pgprot(x)	((pgprot_t) { (x) })
+#define pte_pgprot(x)	__pgprot(pte_val(x))
 
 typedef pte_t * pgtable_t;
 
@@ -96,8 +98,8 @@ extern int pfn_valid(unsigned long pfn);
  * virt here means link-address/program-address as embedded in object code.
  * And for ARC, link-addr = physical address
  */
-#define __pa(vaddr)  ((unsigned long)(vaddr))
-#define __va(paddr)  ((void *)((unsigned long)(paddr)))
+#define __pa(vaddr)  		((unsigned long)(vaddr))
+#define __va(paddr)  		((void *)((unsigned long)(paddr)))
 
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define virt_addr_valid(kaddr)  pfn_valid(virt_to_pfn(kaddr))
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 356237b9c537..0cf73431eb89 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -29,6 +29,11 @@
 #ifndef _ASM_ARC_PGALLOC_H
 #define _ASM_ARC_PGALLOC_H
 
+/*
+ * For ARC, pgtable_t is not struct page *, but pte_t * (to avoid
+ * extraneous page_address() calculations) hence can't use
+ * use asm-generic/pgalloc.h which assumes it being struct page *
+ */
 #include <linux/mm.h>
 #include <linux/log2.h>
 
@@ -36,7 +41,7 @@ static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 {
 	/*
-	 * The cast to long below is OK even when pte is long long (PAE40)
+	 * The cast to long below is OK in 32-bit PAE40 regime with long long pte
 	 * Despite "wider" pte, the pte table needs to be in non-PAE low memory
 	 * as all higher levels can only hold long pointers.
 	 *
-- 
2.25.1

