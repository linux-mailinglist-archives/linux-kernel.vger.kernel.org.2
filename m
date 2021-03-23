Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0288345430
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhCWAul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbhCWAtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdeoM8mAgWisQJp09LS8IOLXFM1XCnluE4TOq2YmQQc=;
        b=dlOdDKUaWSVcTmgdhbDUrJ1bXcxPizfENdA4gaiGqA9ARJrbBfv5jHTyPE1NW1EGYiGWlo
        5zpp5pVTW092ZpmD8kG+WDHrQiedvB+/uVMHk02wWxtOq4cdtaLkDzlK7z0Czvkou99YTM
        HOaODrzdfvE7k75C71h8351r1AgSqMc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-Oa7dRmuJMPSkKtMpuDR9hQ-1; Mon, 22 Mar 2021 20:49:34 -0400
X-MC-Unique: Oa7dRmuJMPSkKtMpuDR9hQ-1
Received: by mail-qk1-f198.google.com with SMTP id b78so806155qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdeoM8mAgWisQJp09LS8IOLXFM1XCnluE4TOq2YmQQc=;
        b=d/VzM4280iOFPzpdxDb6HCmTrMljFm7ZLAvJT29slUBRsoUcklSXN8B7QWm8LOqhiY
         AraJ+JxR9Vr4C8v4rcgLGgSpN/VR7B7I8cpRXDq5Y8hw6CZ3qcg1QsFB2z8bBv/eZShZ
         /P190WyoeMe47GEnR/BfpUYs1qty7HNPzGZN+oesDMW0KU3h+jysY4ecSo2Ro+VE9hex
         c7+do1kPvc0nZfgv3725mZ7almAdI8j05lR1gRSY99pVaajeB+MiGCQQ8DoAe4B9G9Bc
         QIR63SYpdGSRBVdj1wqPvwDzi7Hp8k0jC9a6ByItEMoCb4+35/O/EoOh7qASt8ipg/yX
         K4ew==
X-Gm-Message-State: AOAM531pDgchP7ARsXfZcJWUPkC1Wgq+p5VwWHhR3MmKamI/ISoQX48p
        pJIBgP1CULFZcxEZNQGywO/iWzRMNPPkd+mylSYgCdiBpVTZRgnqxPq6dAqIIpKmvk3G4fislxj
        V/SoNw8zpGGnoi5U0mOvOV5XjPa8Ts2ik8+NxlEnxuWPWRrFoeDaU6iMlQojbbsj+/ZezP4hYwQ
        ==
X-Received: by 2002:a0c:ef81:: with SMTP id w1mr2559084qvr.0.1616460573585;
        Mon, 22 Mar 2021 17:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws9zEAWvWiYpilkK69WHg1W7DvCAHWTeaiLVpskY0kvpdwkfq5fk2WfOjV880qQyXwe5nCog==
X-Received: by 2002:a0c:ef81:: with SMTP id w1mr2559056qvr.0.1616460573212;
        Mon, 22 Mar 2021 17:49:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 11/23] shmem/userfaultfd: Allow wr-protect none pte for file-backed mem
Date:   Mon, 22 Mar 2021 20:49:00 -0400
Message-Id: <20210323004912.35132-12-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory differs from anonymous memory in that even if the pte is
missing, the data could still resides either in the file or in page/swap cache.
So when wr-protect a pte, we need to consider none ptes too.

We do that by installing the uffd-wp special swap pte as a marker.  So when
there's a future write to the pte, the fault handler will go the special path
to first fault-in the page as read-only, then report to userfaultfd server with
the wr-protect message.

On the other hand, when unprotecting a page, it's also possible that the pte
got unmapped but replaced by the special uffd-wp marker.  Then we'll need to be
able to recover from a uffd-wp special swap pte into a none pte, so that the
next access to the page will fault in correctly as usual when trigger the fault
handler next time, rather than sending a uffd-wp message.

Special care needs to be taken throughout the change_protection_range()
process.  Since now we allow user to wr-protect a none pte, we need to be able
to pre-populate the page table entries if we see !anonymous && MM_CP_UFFD_WP
requests, otherwise change_protection_range() will always skip when the pgtable
entry does not exist.

Note that this patch only covers the small pages (pte level) but not covering
any of the transparent huge pages yet.  But this will be a base for thps too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b3def0a102bf..6b63e3544b47 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
+#include <linux/userfaultfd_k.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -176,6 +177,32 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
+		} else if (unlikely(is_swap_special_pte(oldpte))) {
+			if (uffd_wp_resolve && !vma_is_anonymous(vma) &&
+			    pte_swp_uffd_wp_special(oldpte)) {
+				/*
+				 * This is uffd-wp special pte and we'd like to
+				 * unprotect it.  What we need to do is simply
+				 * recover the pte into a none pte; the next
+				 * page fault will fault in the page.
+				 */
+				pte_clear(vma->vm_mm, addr, pte);
+				pages++;
+			}
+		} else {
+			/* It must be an none page, or what else?.. */
+			WARN_ON_ONCE(!pte_none(oldpte));
+			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect even for a none pte!  Because
+				 * even if the pte is null, the page/swap cache
+				 * could exist.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   pte_swp_mkuffd_wp_special(vma));
+				pages++;
+			}
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
@@ -209,6 +236,25 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
+/*
+ * File-backed vma allows uffd wr-protect upon none ptes, because even if pte
+ * is missing, page/swap cache could exist.  When that happens, the wr-protect
+ * information will be stored in the page table entries with the marker (e.g.,
+ * PTE_SWP_UFFD_WP_SPECIAL).  Prepare for that by always populating the page
+ * tables to pte level, so that we'll install the markers in change_pte_range()
+ * where necessary.
+ *
+ * Note that we only need to do this in pmd level, because if pmd does not
+ * exist, it means the whole range covered by the pmd entry (of a pud) does not
+ * contain any valid data but all zeros.  Then nothing to wr-protect.
+ */
+#define  change_protection_prepare(vma, pmd, addr, cp_flags)		\
+	do {								\
+		if (unlikely((cp_flags & MM_CP_UFFD_WP) && pmd_none(*pmd) && \
+			     !vma_is_anonymous(vma)))			\
+			WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd));	\
+	} while (0)
+
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
@@ -227,6 +273,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 		next = pmd_addr_end(addr, end);
 
+		change_protection_prepare(vma, pmd, addr, cp_flags);
+
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-- 
2.26.2

