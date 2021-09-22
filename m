Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33BB414F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhIVRxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233552AbhIVRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632333123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vKKXIJLwy/fLR00ynbhI+6m3Ml8OSdkI8ATKMZTi12I=;
        b=cyEm8IIJyzipPm1Xu1qi+ANJVUaqDYvj4k0+Bum3oxDxe9nH7Uzx9aqGXe2zwF3uHig+sF
        uQIdyXaB9dI0CfaHRDaTtdAhbdqvTjO6HLrp/2FwcPI8G2rW3Pl4agUGm7YHZ+bfBEEBLp
        Ot1+0HpGa4xe4s2R1+dAwK6OObPaGzs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-TJyG7NkQOeOKjQLga2QY0A-1; Wed, 22 Sep 2021 13:52:02 -0400
X-MC-Unique: TJyG7NkQOeOKjQLga2QY0A-1
Received: by mail-qk1-f199.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso11700311qki.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKKXIJLwy/fLR00ynbhI+6m3Ml8OSdkI8ATKMZTi12I=;
        b=gTfCGD+F3POwmMBpFqWyEz+zSxXbKMa23SJU4LxI0o3hBw+zKs6a0gtLFRxg8uXn5H
         5hvHoz8KhH4VS4vHLsprNSLWJLhT+4WEFt83G4JDKIdxjN6zCIAMewRUYBdBTQjYScca
         TfBFD7/zRbDl5v8ziJJ9mrVOUnS8Mx6ZFy4tsA8m4ZvCRypA9eG0mLFDUq3oFUvLQDf6
         2zvSNK90ESAgUqnffK3jH/tBDYuUDgejTU17KrM+RnAlPPLLGjT1ZsEy2pMJDYPrAJVF
         0uvsRpxmGgLaum/Gdk1SNebxWJqVRmDDE3A0tag7QBTZUWhO5jJIVi/jW6e8dAwJBpsS
         I9UQ==
X-Gm-Message-State: AOAM530gmMHISU0z+llN+gS62KLrSgxKpa52iGKnSGj2lDoREgWDoifa
        9aFstj+WdV4ivSM5vslhujkL8prOCXJQzwhVnfVrOQHg850LiWTf5ZnbnDItF6u5dqOcp5FlM+i
        IpgfG6ZQC2Md4ntyZgzYSZp857DOy2x7uN6wbusDf1jyEin9Unt1khoqUkVd2onHvBQAvMywrJw
        ==
X-Received: by 2002:aed:2794:: with SMTP id a20mr490818qtd.243.1632333120207;
        Wed, 22 Sep 2021 10:52:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdxDXZlgkBgU1qcW7DZdL7V4D2gO7rktK27Bs2jpfo95oSFVNULk2DyaNxUBOonyDhSFOKlQ==
X-Received: by 2002:aed:2794:: with SMTP id a20mr490781qtd.243.1632333119878;
        Wed, 22 Sep 2021 10:51:59 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id r17sm1854075qtx.17.2021.09.22.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:51:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Date:   Wed, 22 Sep 2021 13:51:56 -0400
Message-Id: <20210922175156.130228-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forbid merging thps for uffd-wp enabled regions, by breaking the khugepaged
scanning right after we detected a uffd-wp armed pte (either present, or swap).

It works, but it's less efficient, because those ptes only exist for VM_UFFD_WP
enabled VMAs.  Checking against the vma flag would be more efficient, and good
enough.  To be explicit, we could still be able to merge some thps for
VM_UFFD_WP regions before this patch as long as they have zero uffd-wp armed
ptes, however that's not a major target for thp collapse anyways.

This mostly reverts commit e1e267c7928fe387e5e1cffeafb0de2d0473663a, but
instead we do the same check at vma level, so it's not a bugfix.

This also paves the way for file-backed uffd-wp support, as the VM_UFFD_WP flag
will work for file-backed too.

After this patch, the error for khugepaged for these regions will switch from
SCAN_PTE_UFFD_WP to SCAN_VMA_CHECK.

Since uffd minor mode should not allow thp as well, do the same thing for minor
mode to stop early on trying to collapse pages in khugepaged.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Axel: as I asked in the other thread, please help check whether minor mode will
work properly with shmem thp enabled.  If not, I feel like this patch could be
part of that effort at last, but it's also possible that I missed something.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/trace/events/huge_memory.h |  1 -
 mm/khugepaged.c                    | 26 +++-----------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 4fdb14a81108..53532f5925c3 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -15,7 +15,6 @@
 	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
 	EM( SCAN_EXCEED_SHARED_PTE,	"exceed_shared_pte")		\
 	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
-	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
 	EM( SCAN_PAGE_RO,		"no_writable_page")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
 	EM( SCAN_PAGE_NULL,		"page_null")			\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc579f724..3afe66d48db0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -31,7 +31,6 @@ enum scan_result {
 	SCAN_EXCEED_SWAP_PTE,
 	SCAN_EXCEED_SHARED_PTE,
 	SCAN_PTE_NON_PRESENT,
-	SCAN_PTE_UFFD_WP,
 	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
@@ -467,6 +466,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 	if (vma_is_temporary_stack(vma))
 		return false;
+	/* Don't allow thp merging for wp/minor enabled uffd regions */
+	if (userfaultfd_wp(vma) || userfaultfd_minor(vma))
+		return false;
 	return !(vm_flags & VM_NO_KHUGEPAGED);
 }
 
@@ -1246,15 +1248,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
 			if (++unmapped <= khugepaged_max_ptes_swap) {
-				/*
-				 * Always be strict with uffd-wp
-				 * enabled swap entries.  Please see
-				 * comment below for pte_uffd_wp().
-				 */
-				if (pte_swp_uffd_wp(pteval)) {
-					result = SCAN_PTE_UFFD_WP;
-					goto out_unmap;
-				}
 				continue;
 			} else {
 				result = SCAN_EXCEED_SWAP_PTE;
@@ -1270,19 +1263,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_uffd_wp(pteval)) {
-			/*
-			 * Don't collapse the page if any of the small
-			 * PTEs are armed with uffd write protection.
-			 * Here we can also mark the new huge pmd as
-			 * write protected if any of the small ones is
-			 * marked but that could bring unknown
-			 * userfault messages that falls outside of
-			 * the registered range.  So, just be simple.
-			 */
-			result = SCAN_PTE_UFFD_WP;
-			goto out_unmap;
-		}
 		if (pte_write(pteval))
 			writable = true;
 
-- 
2.31.1

