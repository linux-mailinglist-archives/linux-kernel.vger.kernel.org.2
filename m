Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8F39371A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhE0UZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236655AbhE0UZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibDzUgI+Vk9OcaOLv+5pNYdmMu7OVveyljm4h1/HCNE=;
        b=B8r5Mwr8fc1HwCyqYSEqZS0KERGBLqbSpsQdcTNrMrm4zvsuWTiOObj0uUh5WrRdIKbRJK
        pKAvvQpcdn03b/8XpF+odgKJqcOZ/XPQNUM8zA2UfnuHe5yltvTYl+CcfEIcDIT+4jp59/
        UZL/zZx7giQbBKaAbZKz2qokV39oV8M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-4MrIg1O4P8S1UbGdL-ngPw-1; Thu, 27 May 2021 16:23:38 -0400
X-MC-Unique: 4MrIg1O4P8S1UbGdL-ngPw-1
Received: by mail-qt1-f198.google.com with SMTP id b8-20020ac812c80000b029023872d176eeso886789qtj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibDzUgI+Vk9OcaOLv+5pNYdmMu7OVveyljm4h1/HCNE=;
        b=lR3qd41t2DTA3CM7fr2eDgUtC+R48hOtnFBrkK9iopWmuB7R5L6Px4LUdJfuZ2Niao
         DvrSRI3XSXaKHsCW/gv/7OMgV/SmRkP30QxLnxW+EMs0Glm9xzsvyRPxXrw/BeLYQDhQ
         AgfS0Y0ZWxB47Sz2A4GmtZcej/Z9mzvrWea8gsW5dg5g3+GDkbPwh/JB7HZ6sFJlE0Yy
         xLkywdc1BhJbslEOUviJYj02NEnvYSRj23okmJklR2ADMgrEMOar1GXxlllhxSX/d7Vp
         LdXeGERjq0B2ECm665Y4NrR+v2U2c7nsOxl18D4d/lNJJtRLEpqMAsfZwSV8t4jKU77v
         MJPg==
X-Gm-Message-State: AOAM532U9jcbT6WP69e095t6wRsCeQmXcXiqkPyiCj5A5h7ObSkh1PsF
        gEG9VY2TTXw8kRcRgPO4HMwQqPMlF+rM2HsLgHoJu+fFF/xjaA9QxiwHBEIFPpi6YoloS2eWFw6
        AitURTPL/6i416CkxA6dQTwyEp0M1T5D4zqusH+4sCMyHLbU3MSroE+fZAQKLlP6DO9P+zXmMyw
        ==
X-Received: by 2002:ac8:4319:: with SMTP id z25mr368495qtm.262.1622147016933;
        Thu, 27 May 2021 13:23:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRfnnHZwDBhN/ZaRlD0zP/AETW62hdvxMzoXmXTSL4dORe6PtNpJSYMnRHeAUI2t6h/U4u8Q==
X-Received: by 2002:ac8:4319:: with SMTP id z25mr368460qtm.262.1622147016558;
        Thu, 27 May 2021 13:23:36 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id a27sm2057437qtn.97.2021.05.27.13.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 23/27] hugetlb/userfaultfd: Allow wr-protect none ptes
Date:   Thu, 27 May 2021 16:23:32 -0400
Message-Id: <20210527202332.32205-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach hugetlbfs code to wr-protect none ptes just in case the page cache
existed for that pte.  Meanwhile we also need to be able to recognize a uffd-wp
marker pte and remove it for uffd_wp_resolve.

Since at it, introduce a variable "psize" to replace all references to the huge
page size fetcher.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a17d894312c0..c4dd0c531bb5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5486,7 +5486,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -5506,13 +5506,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
-	for (; address < end; address += huge_page_size(h)) {
+	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, huge_page_size(h));
+		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+			/*
+			 * When uffd-wp is enabled on the vma, unshare
+			 * shouldn't happen at all.  Warn about it if it
+			 * happened due to some reason.
+			 */
+			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -5537,12 +5543,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, huge_page_size(h));
+						     newpte, psize);
 				pages++;
 			}
 			spin_unlock(ptl);
 			continue;
 		}
+		if (unlikely(is_swap_special_pte(pte))) {
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+			/*
+			 * This is changing a non-present pte into a none pte,
+			 * no need for huge_ptep_modify_prot_start/commit().
+			 */
+			if (uffd_wp_resolve)
+				huge_pte_clear(mm, address, ptep, psize);
+		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
@@ -5556,6 +5571,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+		} else {
+			/* None pte */
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						pte_swp_mkuffd_wp_special(vma));
 		}
 		spin_unlock(ptl);
 	}
-- 
2.31.1

