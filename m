Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597BB3CADAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbhGOUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239860AbhGOUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0JmFuDDelZXYWv/E+BZRvjlS5kkw3E6CXCgFUA2NEY=;
        b=HoQrjecG3cB9YG3ybpk1GzbPvR5/yOHHqCZCBpnutC8lxccEBXaczL9GRJCeyNb1ukEYfp
        KTsu0oBYYHiUeDpMVHvrsUd45aKndNm9cQys19ryVQeq07ZjalesYWHpH2sj5Q43XfgZuc
        Wj7+d3FxvFdy5lPegF3e9YNP1rpbh5M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-M_I7C7XnP52yEjVZXoCGoQ-1; Thu, 15 Jul 2021 16:14:34 -0400
X-MC-Unique: M_I7C7XnP52yEjVZXoCGoQ-1
Received: by mail-qv1-f69.google.com with SMTP id y35-20020a0cb8a30000b0290270c2da88e8so5009454qvf.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0JmFuDDelZXYWv/E+BZRvjlS5kkw3E6CXCgFUA2NEY=;
        b=Fp3Leck65U0AmrYPDhyAgOmt9uA2WAJV+LmkqwBVogyS1cM7TxvrLhNKEey7pyjGOA
         MteCBeKRWqZZNPTGX9fMX2emGA4ajcmakoqP6aqam1AOrIG8G2hmRh5Ao39rmTFjDPy9
         5RL60wRBxiZIVq0pOyuecEcIfOQZcSHzqsez4T8PBgJK1ykdPDoPYwiGTiIBETYSB33N
         23MX695sGRP29kDfHsw823XMcGFfINCJMExIs7qPaMSd3HXhO6muZB2kPJioISgypOqw
         jhmnUAVkvF3/c6bvBVhcF53Zt5AOMkG8RayGnZ8VM0ko+TMHGNckiMxbfaoq0yydW9tm
         VbrA==
X-Gm-Message-State: AOAM533GM1SE3NMKmIXKtkIMclpM3yPIhf8wJWJ293ArC1GECAR3bdDE
        8XxsMjary667W+laglzAteWOfHZb1wFycr+5sKrKQwwE7uidjrDgxam8/PWu9BtGDcbNa1/tPbG
        s+FV0xmMN3uPYXZFFe7NZ0xd0
X-Received: by 2002:a05:6214:5b0:: with SMTP id by16mr6034934qvb.54.1626380073763;
        Thu, 15 Jul 2021 13:14:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7fWzr5P/wUOBCBzeu3pvVNU1EGhe2aUz3WLeAyZKgAp4DMoDdS0/Ut3Qq5Y4kozsnzR0Qaw==
X-Received: by 2002:a05:6214:5b0:: with SMTP id by16mr6034912qvb.54.1626380073524;
        Thu, 15 Jul 2021 13:14:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, peterx@redhat.com
Subject: [PATCH v5 04/26] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Thu, 15 Jul 2021 16:14:00 -0400
Message-Id: <20210715201422.211004-5-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

