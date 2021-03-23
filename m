Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26734543C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhCWAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhCWAu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYSwV1DdjoGbYhLD7l7jd/ThoyIb5S4HvnYDjWOs2EQ=;
        b=P2WKWSsbTUWFBTnEUw005A41QKzl/gP56VEeoAvinnRAQ9anGP5nS82Vg2e0kn/4cd7hDU
        kmPNiN7QVBm/1OPhD8HfzaFF1wB2qWdV44C8sgrBuCQYETC8JPoNiGAy1TfE2SrPAzDrSG
        d3HOnH+3CdmX62mlMmljk2m9rncCI2E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-94h6BmyzOva8S0VDjeHpRQ-1; Mon, 22 Mar 2021 20:50:55 -0400
X-MC-Unique: 94h6BmyzOva8S0VDjeHpRQ-1
Received: by mail-qt1-f198.google.com with SMTP id m8so394038qtp.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYSwV1DdjoGbYhLD7l7jd/ThoyIb5S4HvnYDjWOs2EQ=;
        b=fYgq5p8XqBBEas17LaO/n+uMFCJtz3HVpZaRyjc8kIfuUY3rXymdvJbwDrcY/TqoXh
         n/IJaLjYU3XgUcNmYvlKA+5o6K/laRjMkruGk9HwJNY+G3qkRXRaS3l8odJxA3m20Kr9
         nFAEsxU+CTP9ApoWg/IMxvV+kFZ5flOBz8xt7xUdESHCMcUcSH26IuZ+INPtPWMLwdQm
         FHa6KPWAaNca+LNyDK++ZqNvh2Rjff80mg0rQODpey/AbZNyeGFkZDe3KlGT1dX3t10N
         WK1cHx79JqqZ6BTjDBa3Gba0lTYWSjLxTaEdsKGa+FtmgvZ5T9XbWXQt1Dqe1uU/AWnP
         YwLw==
X-Gm-Message-State: AOAM533uzPB7iys7qp18eXF7D8OkV6cDk8xg5wllm/9oxQ/Movmf6Mam
        p6Hxj4z7eO+B0fBRBH/3HGAzF3PTYBnUrMl9wFWlNrwxSHK5HTSJJAGSgshWu4G8h6nkccEWSun
        Z7QHghOTrUUCg6Zz5gyC0pb5g
X-Received: by 2002:ad4:4cc8:: with SMTP id i8mr2460896qvz.56.1616460654756;
        Mon, 22 Mar 2021 17:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/wYGS6MPDtkctKR6iln/9KAo2nZVmqKkBxLuPXgL5Im3S3NO0Z0sGaNw2LONKOI8LyEdDOw==
X-Received: by 2002:ad4:4cc8:: with SMTP id i8mr2460882qvz.56.1616460654532;
        Mon, 22 Mar 2021 17:50:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id 8sm12051921qkc.32.2021.03.22.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:50:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 20/23] hugetlb/userfaultfd: Allow wr-protect none ptes
Date:   Mon, 22 Mar 2021 20:50:52 -0400
Message-Id: <20210323005052.35916-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 448ef745d5ee..d4acf9d9d087 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5110,7 +5110,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -5130,13 +5130,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
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
@@ -5160,12 +5166,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
 
@@ -5178,6 +5193,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
2.26.2

