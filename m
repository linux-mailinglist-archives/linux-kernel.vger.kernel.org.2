Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481DB36C952
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhD0QYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237552AbhD0QOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFcTcWKJ6vbywtGp6iOAQR8zJIhwD0TyppO0sf4kPHY=;
        b=WQT7zsSCCjfh8Mnyr6VB5cYcX0uw2wGWZ/Gw9R2lEsWl5EaX95tNhU+GX33tzzMUgi1tdL
        uvlDsPFzae5jPV+ildyD1O8PeZ9516sLXBxxeE/t+oCQgc/XG0VBNHLYvPG4Fes+MsThKk
        9ubYQRXUT1gyDpqOglgxpmgpnLCq4nk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ZGoLo1z2NluiIoy_P-V_xA-1; Tue, 27 Apr 2021 12:13:40 -0400
X-MC-Unique: ZGoLo1z2NluiIoy_P-V_xA-1
Received: by mail-qk1-f198.google.com with SMTP id k12-20020a05620a0b8cb02902e028cc62baso23259502qkh.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFcTcWKJ6vbywtGp6iOAQR8zJIhwD0TyppO0sf4kPHY=;
        b=O6BncjOYySoinqBgVgp9LyJQ4hRqbBXlu5/E2AxHJ9TQJjHih9TtEmrD8IMPmjN/J7
         WGiZ22ajuYFUuxC+ZpprIqdY82BBcYNRFNRf5WLjfihsGksFz6Lf0jDYQsVcnvhc9Lr7
         vp4RhFKSgKyUXeS5vqFgjglQkUdv01FFnPtk9Ifu6s22w9zfwdyKoedjgfK5f40pqiKV
         X1aHGMKJNXcHtmahViiv26eBuN8gloQxFnN6fKiK6RpefvWKKS/WNG6A18MqS/sncqr+
         NA8xacL6Fhn2tpmIxrWo9YZrDjqFcODlBb6YrkXZI0GdHFF764mCgBl3O+0IQ5roj++P
         VoPw==
X-Gm-Message-State: AOAM530M2rcV65UCmttCY19KhOIvgJ/W+fwRILKlZITsynCcjZd4XFOY
        s0LoU2KMaqH7e7I9qrwfZqX9fKi6oMlV0iKLV9nFmRGD/EQ1rAqqwszYOLj+rJaB5NJOiAiQdPp
        M62y1Os4JiH2IgD9S4+z30Gn4
X-Received: by 2002:a37:906:: with SMTP id 6mr23571610qkj.234.1619540019715;
        Tue, 27 Apr 2021 09:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwizuNUF7IfETxrg3V3tIEOD3b3VLA2dvV5qF9HpChu8JMhRtFPP+WV7Rtoqm2bFWb4I5EFlQ==
X-Received: by 2002:a37:906:: with SMTP id 6mr23571576qkj.234.1619540019405;
        Tue, 27 Apr 2021 09:13:39 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 11/24] shmem/userfaultfd: Allow wr-protect none pte for file-backed mem
Date:   Tue, 27 Apr 2021 12:13:04 -0400
Message-Id: <20210427161317.50682-12-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index b3def0a102bf4..6b63e3544b470 100644
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

