Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D131F36B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBSAuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhBSAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:49:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A9C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f127so4756578ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YLKfreZGzyZ40jYkVyobB++yF7t36mvNO2MMRpwh5Mo=;
        b=F4rL2A2y6KkWrRZM1eunAfZ6lX3wxUBY3Z5h/OvEQbyVHGWAtW/3Tv7B/CTvrAn88U
         A8zfJtjMObPSWcfj9JseIqRUr9CRg8KvRJ/3pjfLJ+2n6bVGaqBno1fxQ8EWEH0uWEKw
         z2yiTf6S2c+20JX3TDyn9BesfjLoAs01udHYlvJgVi+8GxOVQpag3XizNezw2TUslLiA
         un+PQtagO3sgc8GwBE6h7F7t7Ergl8BWVVhOuhS2b4ScNVTGjKWrZGSL+YdRiLbAnyQs
         YJ3v2oyDOGE9X3DUEBCdZFyRi75K7lnWpEpx8kHAGI4118OEcF4fi8iyWCsDmYeWfXs1
         +p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YLKfreZGzyZ40jYkVyobB++yF7t36mvNO2MMRpwh5Mo=;
        b=J54STd452mGhhtgZTKvQ15v0oyPAG/HBerKm7yMHTSVK5xFno/fJzzvJIoA2zZevq3
         3swzaTg3TyhC+mj+qZbGsCZ+CpPFAl3sSL3U0hS98GR3D16MKgY1V1T3QaO8n9wG03Oc
         dN6Vb2x6SIPSIyQGEVeC++D7Mo8vjRDiuB8ittjKjh3plna3iajEcr05eZe5/4V51QMI
         6hkgwjz7Evh63QymwDBZE7sLvv9VaY1yLIbsQBDqBirMG9nhH6Iy8SqAWcemTZk9cb7z
         tu/UvWuUcbRKRoNRQMOdquFsfkbD3YLAmYKWK5ZSrwxIGHoHFjvmZQQ5Gizvw+p+Vjor
         d7YA==
X-Gm-Message-State: AOAM533HQzeI6ySKPgL/Qqd4q6UAPhXZ/GmHo6qaerAcDvzWdxCNQ25V
        pIaL0OFo2l1I7hBy+2YeX1Mkm2jsNmYBxk/Y3tA8
X-Google-Smtp-Source: ABdhPJwHe7ylZl2on/KsFZVdo/aHg5L+jaRYxKr0V6jzS0peur4L2JajrBymMRQF219orA8Ci21f0SwzqyQIX0Ql7AX8
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:e939:4cce:117:5af3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:7784:: with SMTP id
 s126mr10722976ybc.475.1613695717644; Thu, 18 Feb 2021 16:48:37 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:48:21 -0800
In-Reply-To: <20210219004824.2899045-1-axelrasmussen@google.com>
Message-Id: <20210219004824.2899045-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v7 3/6] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For background, mm/userfaultfd.c provides a general mcopy_atomic
implementation. But some types of memory (i.e., hugetlb and shmem) need
a slightly different implementation, so they provide their own helpers
for this. In other words, userfaultfd is the only caller of these
functions.

This patch achieves two things:

1. Don't spend time compiling code which will end up never being
referenced anyway (a small build time optimization).

2. In patches later in this series, we extend the signature of these
helpers with UFFD-specific state (a mode enumeration). Once this
happens, we *have to* either not compile the helpers, or unconditionally
define the UFFD-only state (which seems messier to me). This includes
the declarations in the headers, as otherwise they'd yield warnings
about implicitly defining the type of those arguments.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 4 ++++
 mm/hugetlb.c            | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ef5b55dbeb9a..7e6d2f126df3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -134,11 +134,13 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+#ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				struct page **pagep);
+#endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
@@ -310,6 +312,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	BUG();
 }
 
+#ifdef CONFIG_USERFAULTFD
 static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						pte_t *dst_pte,
 						struct vm_area_struct *dst_vma,
@@ -320,6 +323,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	BUG();
 	return 0;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 					unsigned long sz)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0388107da4b1..301b6b64c04e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4624,6 +4624,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4754,6 +4755,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 				 int refs, struct page **pages,
-- 
2.30.0.617.g56c4b15f3c-goog

