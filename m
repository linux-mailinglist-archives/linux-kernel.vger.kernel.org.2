Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76163EADB3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbhHLXiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238433AbhHLXi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0B6E6108C;
        Thu, 12 Aug 2021 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811482;
        bh=ToKfOhhiER8j02fngobXA+3bITHxEeKJM0blznUvlNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qz4+ACaX+VhL6UDoG4GATHnXNG72f1jie44pd2QKRM/Fe242x5Rqwzt62yiHkhABI
         MJ/1t7szUYGw8tdaKtR8D9vCerC3VuDIIJtYTJWFWb0pVK8YkdwVZFN3/cC7PoaxVo
         Y+thDihH1djtm3oHMhYWc8ik+VvG4d58g49pit5v+E6Avw3D1LtRGJriJJ99kRM7+b
         BoH5ZmPGOCl0RZ3RbAOOdfUod3kXbWyaxhtNCcWKf6XLiOhhFwxV84smL9w5OC2FSs
         bVNGScJpcJGUt98HJx8A8QBEXBFWzYUXbsUC2wEVQpuzDpOBj8cOxRKwU32diPvcU/
         WPaoB/kKJ0qTA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 10/19] ARC: mm: non-functional code cleanup ahead of 3 levels
Date:   Thu, 12 Aug 2021 16:37:44 -0700
Message-Id: <20210812233753.104217-11-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/page.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 514b8b70df50..28ed82b1800f 100644
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
 
 typedef struct page *pgtable_t;
 
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
-- 
2.25.1

