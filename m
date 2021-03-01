Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38B32A020
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575356AbhCBDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbhCAW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:28:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1AC0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:27:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i2so20631254ybl.16
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LVgsG8gD6gGqXZonzM2R/jvJn0i4FAd6qzlSE0T5SJc=;
        b=ACYumy8b14lsyGbOvFKzGG5Y1wfhBC2GbamxaDapA11dEVWua31sqbA+qM0DHLmqiT
         x/Gw2T/EPJoBp4DHXeBCDXYZQy0q1t3bu9VW6OFMM+c5YLz1Xx5YTX9AUKbMn9micn+E
         X/nv5Umeq9Pq+B31APauVxQsEXiMEUZiX5OXMd9g+jbhwftHy8/z0zwTHMfwSYrmYqbm
         IUO+Kkuqbq8g5xAfgJcyDIGgXg3ak6JiOGNhbbDtGR4OIGdZc7ZYlL+02SOef69mjbRQ
         4JDklK1VhDpHv8H/9mRCkZ3CTfRcOXE7cf/nZVQNqM2phfEHHDk7yLPB+Pk+MvOKYra+
         UPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LVgsG8gD6gGqXZonzM2R/jvJn0i4FAd6qzlSE0T5SJc=;
        b=UZtdh3lyUWDIV+LmGjPxXjx+14acicFAkDQOz6/EMH1rdGIiGmNlAbAJ6kmCwE5nH4
         hLkXfzc1b5Ix7xy/tJeFu1vdYuuV2nPLQT02qZlRHQYF9lP75Uupk5HiGk5+KPxd3rt3
         sOTxBcQPwpYlJr0DR243FBaiP1Op21wjDY8w0MwP3f+dUe1k+va00RdrlUfIGNrXnOq2
         vwf75Nq4W7E8RAtCYu+rvj6ISXh8joajsIWkf+1WoI/mO1I444/XsoNHZvIF4vU1JvRN
         mhfkif3nNlL35AaGbxU4jRuW5yiwmD7SsgvD04kxdV+cod5z1wB+YIZfVwTdDk33Jprj
         hnZA==
X-Gm-Message-State: AOAM531XkZIf7h956xV328/pniQdiNhnzmDxM2OEAcjEC0niQ5Y2zbzQ
        Walu+Ltxxg+L1HjQTrqOfE/mIvEpoqls1ZsTdGzU
X-Google-Smtp-Source: ABdhPJztw1LshhAXlAwAwKjzozX7J61l0ZDSJy+U6psKHMErMJlxEOJp4+vxqvBRZ2CM0NvocrdecZV5HG16m3yEjgiA
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:5344:: with SMTP id
 h65mr26014172ybb.191.1614637661368; Mon, 01 Mar 2021 14:27:41 -0800 (PST)
Date:   Mon,  1 Mar 2021 14:27:25 -0800
In-Reply-To: <20210301222728.176417-1-axelrasmussen@google.com>
Message-Id: <20210301222728.176417-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210301222728.176417-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v9 3/6] userfaultfd: hugetlbfs: only compile UFFD helpers if
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
index c0b10f0c7f23..7b86bf809d7a 100644
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
index 61fd15185f0a..4422dab8db9a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4618,6 +4618,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4748,6 +4749,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif /* CONFIG_USERFAULTFD */
 
 static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 				 int refs, struct page **pages,
-- 
2.30.1.766.gb4fecdf3b7-goog

