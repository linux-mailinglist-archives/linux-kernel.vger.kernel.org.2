Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475B636C92E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhD0QVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237531AbhD0QOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHI+Q0evUhnkGEC1JxzgrefD9XzCM+vPDN1MAUFX8eY=;
        b=XpT3GmUBZYSIpQw0f6Y38Dlemwdpw1+cjy/4fe2TjHS7Z58Sy4NFPHPbXSttxL+l1fT24x
        dXgMNz8RxCNiss97N40o/W45Ld7EQhlo3F+LJ4m7YwLFGFyZkO3F+oHUnjDcesfbItvTRx
        pJXdccKPxev0vA/obSB6p3EpzkTupkA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-szsi7Q_oNQy1kQzDw8PBgw-1; Tue, 27 Apr 2021 12:13:26 -0400
X-MC-Unique: szsi7Q_oNQy1kQzDw8PBgw-1
Received: by mail-qv1-f70.google.com with SMTP id w20-20020a0562140b34b029019c9674180fso26182509qvj.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHI+Q0evUhnkGEC1JxzgrefD9XzCM+vPDN1MAUFX8eY=;
        b=ISsOz8DpQxc5MQ3cGu8llcLuBgrSDuUte2HcekHW9ZOpbn2uMqEChbQNlWs4ocBcGv
         KW5izJJSyM/eC6Ux2xTyhYy99BeKpHo27WM4Z9G+5bwTgdYOPUnHzsf82vIiD1J4L83x
         WFqZ4wHaQesaGJZ9YrpTCcBGISaMojjb0EY7QCc+5AOlBZN0f5mlES8sohdWJvMzCetm
         ltc44jNKYT+Ct3sGlxwGwJgJJf2IA3gBtX96wrttN0O7b92xclqvSvYySEdZ5JtaKH3S
         C6NeE+MirbqlXC4rH633UP1gFkR27MV7U0OkPUMNHFrTW4ZFsX7PkrLl/nyhYaD+c3eP
         p+Nw==
X-Gm-Message-State: AOAM531LdaMOgFXZ9X80m83U4sgYciaISDw+kGYYiJw33SBF19RtHGVK
        HXTcLrtuc9EdIwJxBngCcEhG+Da09xPWo4J1E3DeO7roOCIOM8HX+HD/Q6LbEJL1+g2pTKi+LD7
        /fb+ds+E6B4PVWMAmNmgtrO9F
X-Received: by 2002:a37:8744:: with SMTP id j65mr25195892qkd.304.1619540005695;
        Tue, 27 Apr 2021 09:13:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz8mXLkD2L73o3l8180wYyAYZ2+Gx9rvoIyRgA/dN9pjw0lpVdb5eO//oDua/vL2UX+K6Lkw==
X-Received: by 2002:a37:8744:: with SMTP id j65mr25195859qkd.304.1619540005386;
        Tue, 27 Apr 2021 09:13:25 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:24 -0700 (PDT)
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
Subject: [PATCH v2 03/24] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Tue, 27 Apr 2021 12:12:56 -0400
Message-Id: <20210427161317.50682-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index a02c67291cfcb..379bae343dd16 100644
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
index 828966d4c2811..95e9811ce9d1f 100644
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
index 794d1538b8bac..bc733512c6905 100644
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

