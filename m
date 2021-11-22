Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB1458AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhKVIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:52:52 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:49365 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238994AbhKVIwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:52:41 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HyLXm0zGYz9sSL;
        Mon, 22 Nov 2021 09:48:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X-aGPodMYSyc; Mon, 22 Nov 2021 09:48:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HyLXc1m9kz9sSr;
        Mon, 22 Nov 2021 09:48:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 256468B774;
        Mon, 22 Nov 2021 09:48:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9HhFgcCOVwLX; Mon, 22 Nov 2021 09:48:48 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A668B8B779;
        Mon, 22 Nov 2021 09:48:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AM8mei2631724
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 09:48:40 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AM8meCH631723;
        Mon, 22 Nov 2021 09:48:40 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH 4/8] powerpc/mm: Move vma_mmu_pagesize() and hugetlb_get_unmapped_area() to slice.c
Date:   Mon, 22 Nov 2021 09:48:24 +0100
Message-Id: <b9fe71514684c92239d2f44cd5a6330992ec1f88.1637570556.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637570556.git.christophe.leroy@csgroup.eu>
References: <cover.1637570556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637570906; l=2819; s=20211009; h=from:subject:message-id; bh=bAMv1qE3z5Fq0BLMA+9Ex8Wew7DRe92t24mVDmFzu8M=; b=EDoWFoSjFoTQFLeBg5vpnvbMirOOsruAGa1Pntjc3nkBZOH9J3VL9acRGhJr9JkfZ/3aM0BWB9yb fuIuk3tbBAjIlu08jxDiiPnywDgrzjoQd89aiNE2Q09EHM0xphSR
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_mmu_pagesize() is only required for slices,
otherwise there is a generic weak version.

hugetlb_get_unmapped_area() is dedicated to slices.

Move them to slice.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s64/slice.c | 22 ++++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage.c    | 28 ----------------------------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index 82b45b1cb973..62848c5fa2d6 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -779,4 +779,26 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 
 	return !slice_check_range_fits(mm, maskp, addr, len);
 }
+
+unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
+{
+	/* With radix we don't use slice, so derive it from vma*/
+	if (radix_enabled())
+		return vma_kernel_pagesize(vma);
+
+	return 1UL << mmu_psize_to_shift(get_slice_psize(vma->vm_mm, vma->vm_start));
+}
+
+unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+					unsigned long len, unsigned long pgoff,
+					unsigned long flags)
+{
+	struct hstate *hstate = hstate_file(file);
+	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
+
+	if (radix_enabled())
+		return radix__hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
+
+	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
+}
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 10c3b2b8e9d8..eb9de09e49a3 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -542,34 +542,6 @@ struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return page;
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-					unsigned long len, unsigned long pgoff,
-					unsigned long flags)
-{
-	struct hstate *hstate = hstate_file(file);
-	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
-
-#ifdef CONFIG_PPC_RADIX_MMU
-	if (radix_enabled())
-		return radix__hugetlb_get_unmapped_area(file, addr, len,
-						       pgoff, flags);
-#endif
-	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
-}
-#endif
-
-unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
-{
-	/* With radix we don't use slice, so derive it from vma*/
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled()) {
-		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
-
-		return 1UL << mmu_psize_to_shift(psize);
-	}
-	return vma_kernel_pagesize(vma);
-}
-
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	int shift = __ffs(size);
-- 
2.33.1

