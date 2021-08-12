Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4083EADB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhHLXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238060AbhHLXi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC94610FC;
        Thu, 12 Aug 2021 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811480;
        bh=756huhpCIkumJJNbUzXKUy3Y4Jb2tLDhfukRVM8geaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8eBEeTBrCxLXIaLILkA2TGAhtbxiRSFBgwckHnqQ5EgTXPG4fpzE9H2hdqfIAbH+
         8255LaxxXNfBXSFz1+BH+10nGjdGLcuav46otwMidYiKWTxqhlFubzPvw7z73sTX17
         jXfSGZlKphIU4bGxMIuP2SU2D7AIp8qGOFkx+AyPQV8IB+l7FiykgvLYoz6WXzfy8W
         P6BwvqPFlYm/eiOT8KXX7skUHeWR/pkQ4Bf0B9GPgBuiSh33x9zmz2RuQeMjECKgFd
         zx+NM36kRPClDOwJpwC+jdZEk7Fx/LgRKzA1BgGu1NTpSg415ewnkuFQB2aO0QWDgi
         bJs6uCGfEpgpw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 07/19] ARC: mm: pmd_populate* to use the canonical set_pmd (and drop pmd_set)
Date:   Thu, 12 Aug 2021 16:37:41 -0700
Message-Id: <20210812233753.104217-8-vgupta@kernel.org>
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
 arch/arc/include/asm/pgalloc.h | 14 ++++++++++----
 arch/arc/include/asm/pgtable.h |  6 ------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index a32ca3104ced..408bc4b0842d 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -35,13 +35,19 @@
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
-	pmd_set(pmd, pte);
+	/*
+	 * The cast to long below is OK in 32-bit PAE40 regime with long long pte
+	 * Despite "wider" pte, the pte table needs to be in non-PAE low memory
+	 * as all higher levels can only hold long pointers.
+	 *
+	 * The cast itself is needed given simplistic definition of set_pmd()
+	 */
+	set_pmd(pmd, __pmd((unsigned long)pte));
 }
 
-static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t ptep)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
 {
-	pmd_set(pmd, (pte_t *) ptep);
+	set_pmd(pmd, __pmd((unsigned long)pte));
 }
 
 static inline int __get_order_pgd(void)
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index b054c14f8bf6..f762bacb2358 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -222,12 +222,6 @@ extern char empty_zero_page[PAGE_SIZE];
 /* find the logical addr (phy for ARC) of the Page Tbl ref by PMD entry */
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & PAGE_MASK)
 
-/* In a 2 level sys, setup the PGD entry with PTE value */
-static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
-{
-	pmd_val(*pmdp) = (unsigned long)ptep;
-}
-
 #define pte_none(x)			(!pte_val(x))
 #define pte_present(x)			(pte_val(x) & _PAGE_PRESENT)
 #define pte_clear(mm, addr, ptep)	set_pte_at(mm, addr, ptep, __pte(0))
-- 
2.25.1

