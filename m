Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09CE3936FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhE0UVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236051AbhE0UVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvvxzxRyoFFa1CRYUKJFbNEb/H/I+lhHBy9dt3/F7KA=;
        b=AXlPPuVr7WnbK8LgRfgN6Dx6/pDxG5L5NrGXd9OF2jWhHwl5/63WY9oX3AjlntCtOfXfOn
        Ss2MCLJRONNwYGYLbg0BZmg/UET33ROoV8YF6/nqTCznQ0nixEa9qhWAclZZbFTJLDIsf4
        XOdm0wh16pZf+A70zQcs9W5KIspOgEc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-RHaxcR9JPN-2-6sCrJVl5w-1; Thu, 27 May 2021 16:19:46 -0400
X-MC-Unique: RHaxcR9JPN-2-6sCrJVl5w-1
Received: by mail-qk1-f197.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so769539qkj.19
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvvxzxRyoFFa1CRYUKJFbNEb/H/I+lhHBy9dt3/F7KA=;
        b=ko34qqaVxu5rRexFRSdD/FteOdi3fMXWscREaFmOce0ZB08ydFc1MGsSjPH9iyXSwD
         MKqH/5iPkEyZsbrpt/m89/FMtQNPY/rwQqKS+1UGy6cZwwDStWLDtX49iGOdipuedIym
         49Qg2M2Dy+I8ICMSgIUeTzAN7tKBBFO8XVMRe6U52AzIWfb5et+Hfl91OomXkRWbYksz
         r/5GRuBeied2Mr8HFWCPd3EEMoB8jCzxwZN6uNONwx92n7EIRqkWoPgfA2esOpnX6UYO
         yECn5l1lLPCYBhRLpUBkdjYWIg8dbXjWJP+5mn6PeZ88ZLeuXUnjkV5h11ThWIVWWcTk
         xaTQ==
X-Gm-Message-State: AOAM533VYn9vrGh7+MHsW3u6c7S3U3u6sfIsAglRx4KXJXVSgesQwl7o
        6SA4j6xsN4lEuUqnJcHu+JQqO03isa08HD/IgzN2Z2oMZMhtfgru6QrVb0aNgbuAbAB51LvP0++
        2BgKXmeN3pLJRhHU8RZuWitfO/F6LzcwFkemXjrbVFOzkBPKVdfDnn8LpAu3vgFS15S/mugqpyg
        ==
X-Received: by 2002:ad4:4baf:: with SMTP id i15mr312409qvw.61.1622146781864;
        Thu, 27 May 2021 13:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9mMbN6hPTbdFTATmfDi5zfbVFhTvV13COXxAbZrbayo1xXYeoyJUoyvd4oXVYnWHsq6J0Gg==
X-Received: by 2002:ad4:4baf:: with SMTP id i15mr312376qvw.61.1622146781565;
        Thu, 27 May 2021 13:19:41 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u14sm2089536qkp.80.2021.05.27.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:19:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Thu, 27 May 2021 16:19:04 -0400
Message-Id: <20210527201927.29586-5-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
 include/linux/userfaultfd_k.h      | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2d9800..9781ba2da049 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1329,6 +1329,34 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
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
index 331d2ccf0bcc..93f932b53a71 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -145,6 +145,17 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
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
+	return pte_same(pte, UFFD_WP_SWP_PTE_SPECIAL);
+}
+
 #else /* CONFIG_USERFAULTFD */
 
 /* mm helpers */
@@ -234,6 +245,16 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
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

