Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F63247EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 01:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhBYA2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 19:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhBYA2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:28:33 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76311C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 16:27:14 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m16so3147616qkh.20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=szGEt3o0qFpaHEBZZQO0VSXzDMyxQL5PtuhdO6ERPgY=;
        b=Lp3/iorZZRf87wK8lw+ZvUPIx9o0DFr4xrVXJ/N3bh/eB45JduZ1xLbUThQmY9bH9i
         G2nywxd9BVfQG5pYSAKlSiruy7YYsA0r4xLoM5VOCLYVsKIlWubbjGO5KUYeFsFhKV2+
         /D/Z8/wLOYmtkejORlwoGRdLixCgthOdd1iUm3GPNYwe1odWflIqdQO51HUeMtZzHJSV
         ZTpjw+rFWMfB6bF7hVHQS1hl3o3gBQ/L2upx5hUK30AelL7by144ElLjJKR3O4EJVbsl
         W745ioaG7iRoIUlZYsR2cBHwTUZhEda/ECoLuEZZdC3/39nWSUgITIM7GjDUVCNubZ9K
         vQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=szGEt3o0qFpaHEBZZQO0VSXzDMyxQL5PtuhdO6ERPgY=;
        b=sUeYkmIirDbwKBbZEHgIAhQWj/bvA8HyDBW6VC5VDoiC2NQfJ1wz0NxkQ4kX0/FVha
         3KUyfrcc4CCg5Rl2WOTsv9pYs9fWdZG11xjQ35M91aE6Mg03RxW6s2jBl5BPlEVMyP+1
         jHRs27ZVf1N3HoyZbSraz1PlWwrx2sVznh+3gsrw6tYBrmX/VgP/rSmK3faZv479va0U
         olc6crw7a85EvNyLkU/Ved5sxh/F5//eWg2N1X0i4l+xqILahmkQide0F1v/ptp/+TXh
         FOkrV6+h/GfyX1nsOHBLv4XDWIQZTgFUd5mFXfDZ8igYNF4JmGMG9CgKXR2Id3o4yAoo
         o/0A==
X-Gm-Message-State: AOAM532ZA3SGDHKtJvN7XbYpeKkXlmQy3Xn5s9UK/GjvAO8XBS19OZhG
        ep7SS0NE/AAnOPYS+HkSp2Zis89DX8IwfOiiXwzg
X-Google-Smtp-Source: ABdhPJxI4rMGlKtA+XXKxz1Z7iAglwLRN/JytqM/Yaf6FmF+vk8PgomBM79UxeXQCK82ovvLJdDWTdq9cOLYjCuq4y7u
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:f65:: with SMTP id
 iy5mr352301qvb.32.1614212833596; Wed, 24 Feb 2021 16:27:13 -0800 (PST)
Date:   Wed, 24 Feb 2021 16:26:55 -0800
In-Reply-To: <20210225002658.2021807-1-axelrasmussen@google.com>
Message-Id: <20210225002658.2021807-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225002658.2021807-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v8 3/6] userfaultfd: hugetlbfs: only compile UFFD helpers if
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
index 1d314b769cb5..9f17dc32d88f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4626,6 +4626,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4756,6 +4757,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 				 int refs, struct page **pages,
-- 
2.30.0.617.g56c4b15f3c-goog

