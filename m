Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDF351F92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhDATVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhDATVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:21:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536FC048F32
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 11:17:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 125so3563946ybd.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/4MVCuA19kT711pBZDOyNdDC4IPaQ3MXmMglGgWunkI=;
        b=A2MBXKazG6VXHBEacrR4R272Fv2VyyljxTojgnGD0pjSXOqU0JrzTPD8Q7Slu2pox/
         Obqr8pS/loTPtzaooVlrHJDXyooaEQtbW2honG/Glnb0yx5DrFy8zuuRhGB1wwD5SDU8
         2Og8pI17uKlUk8W0vw9m4G3ftLv05Q/Kk9icZ6ybNaTRoKg5r7VobyDCObIRUW1BMk+e
         35bnSo+/RfCzPFAcuin8yQIyi4EYKuGWyQiELmvILO4WrnkMEXLU96sgMLAJFeaeedhg
         im3KYgMaUB3klgVrnhNv530rX2U/LqAzF8I7k2Ay+H2nRiOUTxWwsf5/Mtfv3fXvmOYa
         coog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/4MVCuA19kT711pBZDOyNdDC4IPaQ3MXmMglGgWunkI=;
        b=XfGtFmkxjNVsVV3sra2E6X9MBaBR3OtDQWdJTPd641aPQrx/AeE4LlroOhopLBKVel
         zJ74M8mxlpw388s78GRY+Qd3e495gjc3cwu4bHCONoEwOf1TUJGiPC9ys4uTefCfVaKQ
         1AMpPV8twccOadvZCqh3gK7g5lXWdq9LMg3kDQldD+NofY0jHJmnGIbPb8G/ZtHgo70m
         WwWyj2bfyridWslGZlryU9VQxAMmt3IWhUv+ktGrYuT6kX6+QfO7eUawiOCzMZsTHCOT
         NFpyrWieJ4ukXbBygETSp4oU4x0kapUib1zqiXrkjKVS5Yg1R54eph0zhCycY9ledm1y
         ZTyg==
X-Gm-Message-State: AOAM5314SxGvV5iCKNP1z/L8Cqf2WeBox87oWRqlzhWlCurYn4nSLxbh
        JkoLjqeha4ZvDxRFvM/67cORN7R/XTg=
X-Google-Smtp-Source: ABdhPJy6sXEMldo5c/KFZxMY9gVy0+e2PTfj3si6bJlA/z3byivX7BFwq9cDAGhHdXEDbMd6hwUD3rtkNwU=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:899:1066:21fc:b3c5])
 (user=surenb job=sendgmr) by 2002:a25:3854:: with SMTP id f81mr13517804yba.466.1617301077360;
 Thu, 01 Apr 2021 11:17:57 -0700 (PDT)
Date:   Thu,  1 Apr 2021 11:17:41 -0700
In-Reply-To: <20210401181741.168763-1-surenb@google.com>
Message-Id: <20210401181741.168763-6-surenb@google.com>
Mime-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 5/5] mm/userfaultfd: fix memory corruption due to writeprotect
From:   Suren Baghdasaryan <surenb@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jannh@google.com, ktkhai@virtuozzo.com,
        torvalds@linux-foundation.org, shli@fb.com, namit@vmware.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Yu Zhao <yuzhao@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Userfaultfd self-test fails occasionally, indicating a memory corruption.

Analyzing this problem indicates that there is a real bug since mmap_lock
is only taken for read in mwriteprotect_range() and defers flushes, and
since there is insufficient consideration of concurrent deferred TLB
flushes in wp_page_copy().  Although the PTE is flushed from the TLBs in
wp_page_copy(), this flush takes place after the copy has already been
performed, and therefore changes of the page are possible between the time
of the copy and the time in which the PTE is flushed.

To make matters worse, memory-unprotection using userfaultfd also poses a
problem.  Although memory unprotection is logically a promotion of PTE
permissions, and therefore should not require a TLB flush, the current
userrfaultfd code might actually cause a demotion of the architectural PTE
permission: when userfaultfd_writeprotect() unprotects memory region, it
unintentionally *clears* the RW-bit if it was already set.  Note that this
unprotecting a PTE that is not write-protected is a valid use-case: the
userfaultfd monitor might ask to unprotect a region that holds both
write-protected and write-unprotected PTEs.

The scenario that happens in selftests/vm/userfaultfd is as follows:

cpu0				cpu1			cpu2
----				----			----
							[ Writable PTE
							  cached in TLB ]
userfaultfd_writeprotect()
[ write-*unprotect* ]
mwriteprotect_range()
mmap_read_lock()
change_protection()

change_protection_range()
...
change_pte_range()
[ *clear* =E2=80=9Cwrite=E2=80=9D-bit ]
[ defer TLB flushes ]
				[ page-fault ]
				...
				wp_page_copy()
				 cow_user_page()
				  [ copy page ]
							[ write to old
							  page ]
				...
				 set_pte_at_notify()

A similar scenario can happen:

cpu0		cpu1		cpu2		cpu3
----		----		----		----
						[ Writable PTE
				  		  cached in TLB ]
userfaultfd_writeprotect()
[ write-protect ]
[ deferred TLB flush ]
		userfaultfd_writeprotect()
		[ write-unprotect ]
		[ deferred TLB flush]
				[ page-fault ]
				wp_page_copy()
				 cow_user_page()
				 [ copy page ]
				 ...		[ write to page ]
				set_pte_at_notify()

This race exists since commit 292924b26024 ("userfaultfd: wp: apply
_PAGE_UFFD_WP bit").  Yet, as Yu Zhao pointed, these races became apparent
since commit 09854ba94c6a ("mm: do_wp_page() simplification") which made
wp_page_copy() more likely to take place, specifically if page_count(page)
> 1.

To resolve the aforementioned races, check whether there are pending
flushes on uffd-write-protected VMAs, and if there are, perform a flush
before doing the COW.

Further optimizations will follow to avoid during uffd-write-unprotect
unnecassary PTE write-protection and TLB flushes.

Link: https://lkml.kernel.org/r/20210304095423.3825684-1-namit@vmware.com
Fixes: 09854ba94c6a ("mm: do_wp_page() simplification")
Signed-off-by: Nadav Amit <namit@vmware.com>
Suggested-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>	[5.9+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 14470ceaf3f2..3f33651a2a39 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2810,6 +2810,14 @@ static int do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
=20
+	/*
+	 * Userfaultfd write-protect can defer flushes. Ensure the TLB
+	 * is flushed in this case before copying.
+	 */
+	if (unlikely(userfaultfd_wp(vmf->vma) &&
+		     mm_tlb_flush_pending(vmf->vma->vm_mm)))
+		flush_tlb_page(vmf->vma, vmf->address);
+
 	vmf->page =3D vm_normal_page(vma, vmf->address, vmf->orig_pte);
 	if (!vmf->page) {
 		/*
--=20
2.31.0.291.g576ba9dcdaf-goog

