Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221093C93BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhGNW1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhGNW1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MXCY9EtHu8l00OeGEX9KSWIeSxJZ91wjW9WQpZLBho=;
        b=YJvLpzlphEv/NfWGDuhqJJ+auHx7xwHxyd/hmKhL9/03wj71TEzTVR8EXnj99XhCoK2EmF
        p3SmiUoeQX4eWDlkZhW5SjWC7q6VBBwchkQ7bnqxSRGu7jJgUV0YEgfTm3qbikIh/SPw4k
        bPIiCwKxF1Jyd66S7ddVw1wFH+28C30=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-Ti-zvfNWMDm0775Dv5dv3Q-1; Wed, 14 Jul 2021 18:24:37 -0400
X-MC-Unique: Ti-zvfNWMDm0775Dv5dv3Q-1
Received: by mail-qk1-f197.google.com with SMTP id 81-20020a370b540000b02903b854c43335so2274379qkl.21
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MXCY9EtHu8l00OeGEX9KSWIeSxJZ91wjW9WQpZLBho=;
        b=FdanyeMre+zHhZNHUmMEEqQ6wtYWgrcy6f78DvPEz5rdvDJ+fiHGzIXyAKydeAVy4g
         CVTeKW8qfRdZDnVR21GbtT/0oUqZqvG4fwIFxpf9Ix4bpMet2hyIVg0EXbZs5XARrEel
         g+HNrw+sk2U5IB5ZvuVTsRV3Fk7b2VhNwwepsB8C0PpjjDZ+Fh1alvThueoEeJJCm/9d
         hiQWjolB+0BHfHxDYOcfUpawFA1p4BSuMteDHmgd1b/eQMqZfSAWZJ71pQLOJwRpdKlm
         tGH43Lpzt0yNcIeIG5Ja3d4znSoetRCBL+ePE3yG+aHJdeZfYZciwg6mrBk+KEWNhwAs
         WGBg==
X-Gm-Message-State: AOAM532oXPoWXukjNdp4TJS5qsyCDdjUgDF5hzLW5vekqeoQtgtru4Ql
        oBLDkl6sH2qnNh78EhKachWDs+EaiVH4Ac6NrY1meD9HMyisJGnVqGvHPQg7d8VOTqL6PxoGvKY
        hPHTn8RdhxBBtvArJKOWoTn0D
X-Received: by 2002:a0c:f244:: with SMTP id z4mr351821qvl.27.1626301477390;
        Wed, 14 Jul 2021 15:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXznl2Ndf5naG4U62173v8gGkYkHnaeWte5gx6dL3tnVR+2chcnWckUY/pRUVCWX6tOzr7Lw==
X-Received: by 2002:a0c:f244:: with SMTP id z4mr351808qvl.27.1626301477140;
        Wed, 14 Jul 2021 15:24:37 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id n184sm1661512qkb.22.2021.07.14.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:24:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 11/26] shmem/userfaultfd: Allow wr-protect none pte for file-backed mem
Date:   Wed, 14 Jul 2021 18:24:33 -0400
Message-Id: <20210714222433.48637-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
index 4b743394afbe..8ec85b276975 100644
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
@@ -186,6 +187,32 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -219,6 +246,25 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
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
@@ -237,6 +283,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 		next = pmd_addr_end(addr, end);
 
+		change_protection_prepare(vma, pmd, addr, cp_flags);
+
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-- 
2.31.1

