Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8976A45D667
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350593AbhKYIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:47:22 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:48341 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352433AbhKYIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:45:21 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J09rY27k8z9sT3;
        Thu, 25 Nov 2021 09:23:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 91NP-ksrnybX; Thu, 25 Nov 2021 09:23:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J09rN0q4Pz9sT4;
        Thu, 25 Nov 2021 09:23:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 085748B763;
        Thu, 25 Nov 2021 09:23:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Fir6Bysfmk1l; Thu, 25 Nov 2021 09:23:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.227])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EFD758B781;
        Thu, 25 Nov 2021 09:23:46 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AP8NcHD086376
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 09:23:39 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AP8Ncto086375;
        Thu, 25 Nov 2021 09:23:38 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH v2 8/9] powerpc/mm: Properly randomise mmap with slices
Date:   Thu, 25 Nov 2021 09:23:30 +0100
Message-Id: <35c7120357b263667985684ee1df25548f7bc80e.1637828367.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637828367.git.christophe.leroy@csgroup.eu>
References: <cover.1637828367.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637828609; l=3498; s=20211009; h=from:subject:message-id; bh=ngfeg/2tmEpq6TE0+FDDvF+lIoivpzUM2irZRsGVREQ=; b=0z9cVIhuFRmpimO3m6RaNjDYTOLAvyylhuhx4XgTPhM82PVtQ/O3zDO5kKP8MJ7ZEso5qyJclvWa Z3/0XHmCCezj8nyBb31XTL4hHjE2RFcC1yY03joAQ6OAJ3f0Gn6L
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that powerpc switched to default topdown mmap layout,
mm->mmap_base is properly randomised.  However
slice_find_area_bottomup() doesn't use mm->mmap_base but
uses the fixed TASK_UNMAPPED_BASE instead.

slice_find_area_bottomup() being used as a fallback to
slice_find_area_topdown(), it can't use mm->mmap_base
directly.

Instead of always using TASK_UNMAPPED_BASE as base address, leave
it to the caller. When called from slice_find_area_topdown()
TASK_UNMAPPED_BASE is used. Otherwise mm->mmap_base is used.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s64/slice.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index 99742dde811c..997f40184e97 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -276,20 +276,18 @@ static bool slice_scan_available(unsigned long addr,
 }
 
 static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
-					      unsigned long len,
+					      unsigned long addr, unsigned long len,
 					      const struct slice_mask *available,
 					      int psize, unsigned long high_limit)
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
-	unsigned long addr, found, next_end;
+	unsigned long found, next_end;
 	struct vm_unmapped_area_info info;
 
 	info.flags = 0;
 	info.length = len;
 	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
 	info.align_offset = 0;
-
-	addr = TASK_UNMAPPED_BASE;
 	/*
 	 * Check till the allow max value for this mmap request
 	 */
@@ -322,12 +320,12 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 }
 
 static unsigned long slice_find_area_topdown(struct mm_struct *mm,
-					     unsigned long len,
+					     unsigned long addr, unsigned long len,
 					     const struct slice_mask *available,
 					     int psize, unsigned long high_limit)
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
-	unsigned long addr, found, prev;
+	unsigned long found, prev;
 	struct vm_unmapped_area_info info;
 	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
 
@@ -335,8 +333,6 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	info.length = len;
 	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
 	info.align_offset = 0;
-
-	addr = mm->mmap_base;
 	/*
 	 * If we are trying to allocate above DEFAULT_MAP_WINDOW
 	 * Add the different to the mmap_base.
@@ -377,7 +373,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	return slice_find_area_bottomup(mm, len, available, psize, high_limit);
+	return slice_find_area_bottomup(mm, TASK_UNMAPPED_BASE, len, available, psize, high_limit);
 }
 
 
@@ -386,9 +382,9 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 				     int topdown, unsigned long high_limit)
 {
 	if (topdown)
-		return slice_find_area_topdown(mm, len, mask, psize, high_limit);
+		return slice_find_area_topdown(mm, mm->mmap_base, len, mask, psize, high_limit);
 	else
-		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
+		return slice_find_area_bottomup(mm, mm->mmap_base, len, mask, psize, high_limit);
 }
 
 static inline void slice_copy_mask(struct slice_mask *dst,
-- 
2.33.1

