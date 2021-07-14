Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B293C93B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhGNWYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236658AbhGNWYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0JmFuDDelZXYWv/E+BZRvjlS5kkw3E6CXCgFUA2NEY=;
        b=XxnUZL8lcM3oSccOwNhMRwBmE2OeV4I7zaPECu4nBFavynD5A4WbX8/np8R5lH5GqWhU4j
        YI6AVTtbpFrDFNmA1odGuPbqQeLbnmz4IgupcI6nO/KrYZ1totKP0GMlHA+P9XuDTEcyQt
        JPM4JUFSNM4pVgYI6Vs382tru1Ifv3o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-a1rJ9pQSM_q5XfZIdPb37Q-1; Wed, 14 Jul 2021 18:21:28 -0400
X-MC-Unique: a1rJ9pQSM_q5XfZIdPb37Q-1
Received: by mail-qv1-f72.google.com with SMTP id z1-20020a0cfec10000b02902dbb4e0a8f2so2706752qvs.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0JmFuDDelZXYWv/E+BZRvjlS5kkw3E6CXCgFUA2NEY=;
        b=fvS1hloWba/xtX9ZXW9+jTTDpMGaJQSVyy3yR2FWp4QPqYj/SHzcjdl0mcr5br0XHg
         kI3On65Yps+gVnIoveZiLfQgKPnAkN1io/cqvxRHp7WiX61w80Q9Xg+Mew4Wcg2R5+0j
         KNk47CAleMtiqcLmDPjGIkT0KCxz8AsKmTMTSkrlUnS80beayPRoFg7aNaMZ1sjg0fvv
         LIX/bjXdKZH+3m6MfB0GC9CVkHhpmJBRnWOQQoRyeiYuatZRxY9aFnnjfXjNoIKeSSn3
         3hOS9AuoXeQLP93Qse5TEq2/DhPGms39mBybX44K0XO5uLPkUwcvwPihJ0IxMkxdE6as
         V5Sg==
X-Gm-Message-State: AOAM530K4aAkDcu2GNIisky11POY15XhRNn4lLX7LwWh4xt6LhTsuJGI
        RYtoXB5UjHlMxQy0Tu4hKavHHIj/bo/4QNKj5A6GUn3GXVxmLggQdCaxlWjf+bK81R6nWuszCw8
        qBopQ9FKIS5u6N0bcC3UfseAamBlGWbQwjswEnZaIHu3znnZle3mSlP8ethxaIZDIjvULTQK1pg
        ==
X-Received: by 2002:a05:622a:1987:: with SMTP id u7mr308294qtc.45.1626301288032;
        Wed, 14 Jul 2021 15:21:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8a60fJ/Iga9Wm6qTFCnF80A2iIi32agCJqRunS6d3XLWes8fPNIWRySZtcDQS5RPr3NCouw==
X-Received: by 2002:a05:622a:1987:: with SMTP id u7mr308258qtc.45.1626301287734;
        Wed, 14 Jul 2021 15:21:27 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 04/26] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Wed, 14 Jul 2021 18:20:55 -0400
Message-Id: <20210714222117.47648-5-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a very special swap-like pte for file-backed memories.

Currently it's only defined for x86_64 only, but as long as any arch that can
properly define the UFFD_WP_SWP_PTE_SPECIAL value as requested, it should
conceptually work too.

We will use this special pte to arm the ptes that got either unmapped or
swapped out for a file-backed region that was previously wr-protected.  This
special pte could trigger a page fault just like swap entries, and as long as
the page fault will satisfy pte_none()==false && pte_present()==false.

Then we can revive the special pte into a normal pte backed by the page cache.

This idea is greatly inspired by Hugh and Andrea in the discussion, which is
referenced in the links below.

The other idea (from Hugh) is that we use swp_type==1 and swp_offset=0 as the
special pte.  The current solution (as pointed out by Andrea) is slightly
preferred in that we don't even need swp_entry_t knowledge at all in trapping
these accesses.  Meanwhile, we also reuse _PAGE_SWP_UFFD_WP from the anonymous
swp entries.

This patch only introduces the special pte and its operators.  It's not yet
applied to have any functional difference.

Link: https://lore.kernel.org/lkml/20201126222359.8120-1-peterx@redhat.com/
Link: https://lore.kernel.org/lkml/20201130230603.46187-1-peterx@redhat.com/
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h     | 28 ++++++++++++++++++++++++++++
 include/asm-generic/pgtable_uffd.h |  3 +++
 include/linux/userfaultfd_k.h      | 25 +++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..71b1e73d5b26 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1300,6 +1300,34 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+
+/*
+ * This is a very special swap-like pte that marks this pte as "wr-protected"
+ * by userfaultfd-wp.  It should only exist for file-backed memory where the
+ * page (previously got wr-protected) has been unmapped or swapped out.
+ *
+ * For anonymous memories, the userfaultfd-wp _PAGE_SWP_UFFD_WP bit is kept
+ * along with a real swp entry instead.
+ *
+ * Let's make some rules for this special pte:
+ *
+ * (1) pte_none()==false, so that it'll not trigger a missing page fault.
+ *
+ * (2) pte_present()==false, so that it's recognized as swap (is_swap_pte).
+ *
+ * (3) pte_swp_uffd_wp()==true, so it can be tested just like a swap pte that
+ *     contains a valid swap entry, so that we can check a swap pte always
+ *     using "is_swap_pte() && pte_swp_uffd_wp()" without caring about whether
+ *     there's one swap entry inside of the pte.
+ *
+ * (4) It should not be a valid swap pte anywhere, so that when we see this pte
+ *     we know it does not contain a swap entry.
+ *
+ * For x86, the simplest special pte which satisfies all of above should be the
+ * pte with only _PAGE_SWP_UFFD_WP bit set (where swp_type==swp_offset==0).
+ */
+#define  UFFD_WP_SWP_PTE_SPECIAL  __pte(_PAGE_SWP_UFFD_WP)
+
 static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_SWP_UFFD_WP);
diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
index 828966d4c281..95e9811ce9d1 100644
--- a/include/asm-generic/pgtable_uffd.h
+++ b/include/asm-generic/pgtable_uffd.h
@@ -2,6 +2,9 @@
 #define _ASM_GENERIC_PGTABLE_UFFD_H
 
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+
+#define  UFFD_WP_SWP_PTE_SPECIAL  __pte(0)
+
 static __always_inline int pte_uffd_wp(pte_t pte)
 {
 	return 0;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 331d2ccf0bcc..bb5a72a2b07a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -145,6 +145,21 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 
+static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(vma_is_anonymous(vma));
+	return UFFD_WP_SWP_PTE_SPECIAL;
+}
+
+static inline bool pte_swp_uffd_wp_special(pte_t pte)
+{
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+	return pte_same(pte, UFFD_WP_SWP_PTE_SPECIAL);
+#else
+	return false;
+#endif
+}
+
 #else /* CONFIG_USERFAULTFD */
 
 /* mm helpers */
@@ -234,6 +249,16 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
+static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
+{
+	return __pte(0);
+}
+
+static inline bool pte_swp_uffd_wp_special(pte_t pte)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 #endif /* _LINUX_USERFAULTFD_K_H */
-- 
2.31.1

