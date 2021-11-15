Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2839C44FF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhKOIDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229776AbhKOIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enD0wV1PzTMcVZir6gX0xAfGiKSstXRuvW8GppqUCLE=;
        b=Dkx4XmBvDT07MU+OF2hZO6fEPSdPiNvZuGgVSmOn6bGhRP37j9nER9I5GMMgqQe9U/Mifp
        u7SISyMgp9pMOda1nEJlV2ZWl4YlnjK0vLgLxUUIxn2rInwsr4NShEXx4ot+cQv7KY1/+N
        n0eIRC5daTM02LRuHZBeXsK1jFTmqK0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-Rr60l9JCPjyV8OQDY3dSsw-1; Mon, 15 Nov 2021 03:00:49 -0500
X-MC-Unique: Rr60l9JCPjyV8OQDY3dSsw-1
Received: by mail-pg1-f197.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so1401664pgo.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enD0wV1PzTMcVZir6gX0xAfGiKSstXRuvW8GppqUCLE=;
        b=3Li6UbdMHrcZ6BGHJrmJKmTXUFPS4x0S4WGFQtte5GVjZaXykJGBSopCxg36KKzz1T
         LfnHRn3dpd5HMqlJXH0Y9loLBfWSGHVUDKaYW4Q0GeX9ohjZT0ni1w1pQZ8XGncYl1F6
         uRQtRl09RMOVDDNnF863pDFmlZXo03lbSTAoUhkvxAeNRrusK3YKlqL0c3aEuOMtuFiK
         N12AcShggdMBTQ4VlqvZwyr/vPanOZftig8dQaOCRCtBxqG3dN/sJNmx0VKSJimWsNri
         d9C3gxUgRvqczzi0GcPy07bi58RqnPawuxzkVkGmwmlEfrkxGhOSV8VDN2+nd1GzbAbp
         YOtg==
X-Gm-Message-State: AOAM533rL2D7Sk2VWpzAK8gxCVnFp+F6pP9fq2ustEQVDzNy0UER+UPA
        hOryU9KOAKnztm/rf+lPkTHZUgjHCMxAi27JijwdpIzkJZ72pBicq6BkkSYVItc/EAirBEAuJKW
        53edVx+QwrmO02cC966P9e9wz
X-Received: by 2002:a05:6a00:84c:b0:494:6d40:ed76 with SMTP id q12-20020a056a00084c00b004946d40ed76mr31113164pfk.65.1636963248187;
        Mon, 15 Nov 2021 00:00:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnNCoV7LVEKS2kGNyP+wQ8iY7s2Exa4jA+VMzI9tOHbNahQ0/af4BuXB848choZ6Ilf+Dr0g==
X-Received: by 2002:a05:6a00:84c:b0:494:6d40:ed76 with SMTP id q12-20020a056a00084c00b004946d40ed76mr31113125pfk.65.1636963247852;
        Mon, 15 Nov 2021 00:00:47 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id t40sm14468176pfg.107.2021.11.15.00.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:00:47 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 08/23] mm/shmem: Allow uffd wr-protect none pte for file-backed mem
Date:   Mon, 15 Nov 2021 16:00:34 +0800
Message-Id: <20211115080034.74526-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory differs from anonymous memory in that even if the pte is
missing, the data could still resides either in the file or in page/swap cache.
So when wr-protect a pte, we need to consider none ptes too.

We do that by installing the uffd-wp pte markers when necessary.  So when
there's a future write to the pte, the fault handler will go the special path
to first fault-in the page as read-only, then report to userfaultfd server with
the wr-protect message.

On the other hand, when unprotecting a page, it's also possible that the pte
got unmapped but replaced by the special uffd-wp marker.  Then we'll need to be
able to recover from a uffd-wp pte marker into a none pte, so that the next
access to the page will fault in correctly as usual when accessed the next
time.

Special care needs to be taken throughout the change_protection_range()
process.  Since now we allow user to wr-protect a none pte, we need to be able
to pre-populate the page table entries if we see (!anonymous && MM_CP_UFFD_WP)
requests, otherwise change_protection_range() will always skip when the pgtable
entry does not exist.

For example, the pgtable can be missing for a whole chunk of 2M pmd, but the
page cache can exist for the 2M range.  When we want to wr-protect one 4K page
within the 2M pmd range, we need to pre-populate the pgtable and install the
pte marker showing that we want to get a message and block the thread when the
page cache of that 4K page is written.  Without pre-populating the pmd,
change_protection() will simply skip that whole pmd.

Note that this patch only covers the small pages (pte level) but not covering
any of the transparent huge pages yet.  That will be done later, and this patch
will be a preparation for it too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 890bc1f9ca24..be837c4dbc64 100644
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
@@ -174,7 +175,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
 			} else if (is_pte_marker_entry(entry)) {
-				/* Skip it, the same as none pte */
+				/*
+				 * If this is uffd-wp pte marker and we'd like
+				 * to unprotect it, drop it; the next page
+				 * fault will trigger without uffd trapping.
+				 */
+				if (uffd_wp_resolve &&
+				    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP)) {
+					pte_clear(vma->vm_mm, addr, pte);
+					pages++;
+				}
 				continue;
 			} else {
 				newpte = oldpte;
@@ -189,6 +199,20 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
+		} else {
+			/* It must be an none page, or what else?.. */
+			WARN_ON_ONCE(!pte_none(oldpte));
+			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect a none pte, because even if the
+				 * pte is none, the page/swap cache could
+				 * exist.  Doing that by install a marker.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   make_pte_marker(PTE_MARKER_UFFD_WP));
+				pages++;
+			}
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
@@ -222,6 +246,39 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
+/* Return true if we're uffd wr-protecting file-backed memory, or false */
+static inline bool
+uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
+{
+	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
+}
+
+/*
+ * If wr-protecting the range for file-backed, populate pgtable for the case
+ * when pgtable is empty but page cache exists.  When {pte|pmd|...}_alloc()
+ * failed it means no memory, we don't have a better option but stop.
+ */
+#define  change_pmd_prepare(vma, pmd, cp_flags)				\
+	do {								\
+		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+			if (WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd)))	\
+				break;					\
+		}							\
+	} while (0)
+/*
+ * This is the general pud/p4d/pgd version of change_pmd_prepare(). We need to
+ * have separate change_pmd_prepare() because pte_alloc() returns 0 on success,
+ * while {pmd|pud|p4d}_alloc() returns the valid pointer on success.
+ */
+#define  change_prepare(vma, high, low, addr, cp_flags)			\
+	do {								\
+		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+			low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
+			if (WARN_ON_ONCE(p == NULL))			\
+				break;					\
+		}							\
+	} while (0)
+
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
@@ -240,6 +297,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 		next = pmd_addr_end(addr, end);
 
+		change_pmd_prepare(vma, pmd, cp_flags);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -305,6 +363,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		change_prepare(vma, pud, pmd, addr, cp_flags);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
@@ -325,6 +384,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
+		change_prepare(vma, p4d, pud, addr, cp_flags);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
@@ -350,6 +410,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	inc_tlb_flush_pending(mm);
 	do {
 		next = pgd_addr_end(addr, end);
+		change_prepare(vma, pgd, p4d, addr, cp_flags);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-- 
2.32.0

