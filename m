Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF08D345426
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhCWAt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231134AbhCWAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DNoRIuZQ4jXaA0anHGtp4SMKUmZM5prtrzcj00Thqk=;
        b=Yuu0OBWN9wlhu2sYzysrHMYDZu2k1qStvzEus1nyGliuPW/z2JNuLGggim/PUE9vrk4mOK
        sB7XQ4KTZxzsKI81K9FZ3XkR2e//FRmMiprixuXk7Z/UuVV9kOHGXDw/DFnRH1Ba2fRPuB
        HUygjBJwFg/dElWO9gQDGTIgu5MpvcI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-QPneGwpNNw6ez1VA6EexMw-1; Mon, 22 Mar 2021 20:49:21 -0400
X-MC-Unique: QPneGwpNNw6ez1VA6EexMw-1
Received: by mail-qt1-f199.google.com with SMTP id c20so403997qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DNoRIuZQ4jXaA0anHGtp4SMKUmZM5prtrzcj00Thqk=;
        b=nWsEPDb7lM0vIqSYXJskw/3aVQaPx3fSj5WaIEwNiW/T1uJX++ZKp3f5DA6aGj1QJn
         gmp1pmlcnNdPlIzE66KOMVUk9FK3Zb6NTZTFzFZeqhFUH7AGLyCvtICIoKawns8MdZ2x
         W2CqWGYjvAk5mah5lHizyIvzDbx8SyjilI7EgXPDe0W0sVpDDulA86wJ6PZStcrQqFI5
         UpeJk+OaDe7P8VsPZwU4DXZhvUdiK+Yjx26DMKs82HEXiojIKJPYGyWZgJqgDxBYQ2F3
         djdtccKUFhBPc5QwmontMeNJQCnzCo057ZTSnX62q8n93OJSjZm43GeAIWxULn4wumIK
         S9MQ==
X-Gm-Message-State: AOAM530HYr/sTJ06spVUKOrIWH8PIHqW7L08l4i3sgtlm5/FNnkhvxIQ
        1AVd9BiCLJkva2jGmBchKan4wlmKYGf/L/9eJxYHpG9ea9MGRwOuGg8EossdCTpTzQeigXu0Vn0
        +XbKZR2cY9q1YM0Jmu5PPP28za5D9FumMHJvPWYkFxGifQpWnhJOm7GXPP5jIgfa8vgClj3XHjA
        ==
X-Received: by 2002:a05:622a:1342:: with SMTP id w2mr2320763qtk.163.1616460560434;
        Mon, 22 Mar 2021 17:49:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9DxGHZBapow5ellIcCzucBZ0qtKlDBcxBkEZT6mDMY9J0jUAxRb3/6MZ2mRDfYsubV/pAsQ==
X-Received: by 2002:a05:622a:1342:: with SMTP id w2mr2320733qtk.163.1616460560045;
        Mon, 22 Mar 2021 17:49:20 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:19 -0700 (PDT)
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
Subject: [PATCH 03/23] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Mon, 22 Mar 2021 20:48:52 -0400
Message-Id: <20210323004912.35132-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index a02c67291cfc..379bae343dd1 100644
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
index 794d1538b8ba..bc733512c690 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -140,6 +140,17 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
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
@@ -229,6 +240,16 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
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
2.26.2

