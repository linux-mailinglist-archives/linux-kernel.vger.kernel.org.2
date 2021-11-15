Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A344FFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhKOIHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236367AbhKOIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juo8CnrknUVx2CU+cPYbVJwKflQnt9kXKdPVkj+rnzk=;
        b=i8O5T2F4VU79dV2GwNApT6jVjlKJdsnQqi6/NzmwBkOCOn2RqxI5nInEhsfapPSDeI7VlH
        JGD+GQlA5iBgmu0Qq9IPURIlr/nqoQ+3NaFJsMeqtpAul/WJc+pbb2rNe4ByeHMlZlrj8v
        /GZvFZV0dQuDeTeD7nvTu5vxO8ny6YU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-XoMOd6wUM_6KPQ8LO0Ghwg-1; Mon, 15 Nov 2021 03:02:29 -0500
X-MC-Unique: XoMOd6wUM_6KPQ8LO0Ghwg-1
Received: by mail-pj1-f70.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so4880531pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juo8CnrknUVx2CU+cPYbVJwKflQnt9kXKdPVkj+rnzk=;
        b=r+op1PbMxHyVfTY8gkovU0Je4z6clpx6rpBI8QUSU22oSEBwbs1as6n64UDWBaBbEY
         blMSbyIrJq3NENgG/K5TzMDqOKPgzH2AwVSGWte9ZgHSgjJGvi4aVT5tmGQiHHAjLQcG
         rSA7HRZrggIMDhpH7bBWdU5RO2AqcDw9tojOSvzgSOByl1TISIluh3sfvpterc7BzP9f
         XnZ7jvjpLrjKqLqhI0VX63keVHsFkMB8fojGcAExpMY3guN2YnS9xOJT4LoJdjTStOCZ
         Uo9Z1Y1cjeLu2ekpXe9mWVhGBO1UNheqXX0juJQicgj9TDmLOIQa6fOha/6ONlyEWqxv
         cPYQ==
X-Gm-Message-State: AOAM531jzxPfWQCnHY2M0f0NcxILUZU29cXNJ3bYBH0elYZrY42tGOuL
        IgQ4PWjLtHP6YF6xV6U8zEIiTZuXT3eyOwVzTSEI/Bz90358/tUWjIaZZ8qSJT5v3n1KBPR91x/
        AQL1XDVKhVP3yizp2MSnKOYZC
X-Received: by 2002:a17:902:e804:b0:142:1c0b:c2a6 with SMTP id u4-20020a170902e80400b001421c0bc2a6mr32648871plg.23.1636963347860;
        Mon, 15 Nov 2021 00:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDNuRUr56R2HgkYgfQqjH6+BcRz0mtYQUWUhFx5NvN9CbgJnvkwVUYkq/DiyMnk9FcFK3PfQ==
X-Received: by 2002:a17:902:e804:b0:142:1c0b:c2a6 with SMTP id u4-20020a170902e80400b001421c0bc2a6mr32648832plg.23.1636963347598;
        Mon, 15 Nov 2021 00:02:27 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id b4sm14912250pfl.60.2021.11.15.00.02.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:02:27 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 15/23] mm/hugetlb: Handle pte markers in page faults
Date:   Mon, 15 Nov 2021 16:02:14 +0800
Message-Id: <20211115080214.74926-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow hugetlb code to handle pte markers just like none ptes.  It's mostly
there, we just need to make sure we don't assume hugetlb_no_page() only handles
none pte, so when detecting pte change we should use pte_same() rather than
pte_none().  We need to pass in the old_pte to do the comparison.

Check the original pte to see whether it's a pte marker, if it is, we should
recover uffd-wp bit on the new pte to be installed, so that the next write will
be trapped by uffd.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7fc213c0ebf8..e8d01277af0f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5361,7 +5361,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -5487,7 +5488,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	/* If pte changed from under us, retry */
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -5497,6 +5499,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
+	/*
+	 * If this pte was previously wr-protected, keep it wr-protected even
+	 * if populated.
+	 */
+	if (unlikely(is_pte_marker_uffd_wp(old_pte)))
+		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -5614,8 +5622,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
-	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+	/* PTE markers should be handled the same way as none pte */
+	if (huge_pte_none_mostly(entry)) {
+		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+				      entry, flags);
 		goto out_mutex;
 	}
 
-- 
2.32.0

