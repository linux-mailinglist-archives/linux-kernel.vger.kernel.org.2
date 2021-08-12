Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45D3EADB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhHLXip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238143AbhHLXi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 311AD6113E;
        Thu, 12 Aug 2021 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811481;
        bh=P/zEitpJGWXqQnjfHf92tqfSZBtCS0Di5vxOaU/9MD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoMM9n1Tr9XrlR6f4RTBC9zHGaQ7Tv1e0NIHSbudb/XWoxRn7yJH/EpDjhLAoPG1U
         k2VsEjQP02DPXvFXHVj0R/S5Y2782k0scB4WxtX6mUIyBLJ7DJBN+h7ftKfmMPBqL/
         +DwhvMMSy8nq0eWpPPrIbZSFCcFjBC7vIKQLYgC3XG9amedpT0Z2lEUgg4tURebKiG
         YLkUqikSOR7OvDrVu4UmlG/b0J5Fj+t4XXjgRaiRZjacqnGyXqsrLy0Xfxr5Ihhlte
         5Eng0QYUmJZbsFRfwkwDPu7hBvayhRq+wFiEagK/TeSRFOxgwNdiBAFPKisC4F4rIU
         +uvGLl4pZGrxQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 09/19] ARC: mm: switch to asm-generic/pgalloc.h
Date:   Thu, 12 Aug 2021 16:37:43 -0700
Message-Id: <20210812233753.104217-10-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With previous patch ARC pgalloc functions are same as generic, hence
switch to that.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/pgalloc.h | 42 +---------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 8ab1af3da6e7..0cde9e5eefd7 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -31,6 +31,7 @@
 
 #include <linux/mm.h>
 #include <linux/log2.h>
+#include <asm-generic/pgalloc.h>
 
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
@@ -69,47 +70,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return ret;
 }
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_ZERO);
-
-	return pte;
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *page;
-
-	page = (pgtable_t)alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
-	if (!page)
-		return NULL;
-
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-
-	return page;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte_page)
-{
-	pgtable_pte_page_dtor(pte_page);
-	__free_page(pte_page);
-}
-
 #define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
 
 #endif /* _ASM_ARC_PGALLOC_H */
-- 
2.25.1

