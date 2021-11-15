Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7277044FFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhKOIH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234884AbhKOIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkupakg3emmkCuPdLA0U47j3HM8dJoa5zeaf2nr8YrE=;
        b=O1/v6JMId/inNqCslexgC86sf6yp70vXyfZR9KVpIwBCjYn/IpVlaG3oj6qm0kFWDZp/tT
        1+Gb6Zk5s6FsS2q0vgzToH/40d8MVTWANRn1FpabBdeZrPcEU6vUB9A6+3H/OSgcpv9RjC
        vkKQCl9841EwD/Qoerz1EpUH3lZWFFE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-QbftAqmcObqOppUWt8ZSxA-1; Mon, 15 Nov 2021 03:02:43 -0500
X-MC-Unique: QbftAqmcObqOppUWt8ZSxA-1
Received: by mail-pl1-f198.google.com with SMTP id p3-20020a170903248300b00143c00a5411so577997plw.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkupakg3emmkCuPdLA0U47j3HM8dJoa5zeaf2nr8YrE=;
        b=H1Jyc/SMuZemZUMxXJg3y2j/dRFUzG1Aq0/UptN8LsvE2kWkvddK9WSsn5E94Pl2Bh
         vPRvjb1DjP8SVKXFBQuzzEZVjw9xjVGTunxEgXNq+JdX3or5H7vxYSCA/1AIjrp9X57V
         cFX4cfxAD0EsspY1jhxSNO8bOHEp2Ncs/KGofm54l6zQ0kovhJYmTPlMQ88G2ezLj1mn
         4t2QclizKUSoHsOQeE9rJlOOq0vwGXkAW7YPWGm+5Aee6qkzT5BnHcIPcFh6leqP/4W/
         rYShDFFrTf8muz3vhRyveUrIoX8kxIqOzB8Y+w1N8jKk7qfxAnfC5BMUmk9Ugmopu04O
         0roQ==
X-Gm-Message-State: AOAM532dQkNnLEPq+dZ697D4t/hoNrpeW+phrlR+LsOsuH/o0BgH4BsP
        RJjAe6BBPV1B0M7lqR+sltCoDx//jkTmDswJkweN3QEoQjyTVM7TfRrgja+Q7vN1U4VzkppV37A
        7YaLL4abJzS6yQrS8wCc2cgQu
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id j25-20020aa78019000000b0044dd7616f79mr31742113pfi.3.1636963362556;
        Mon, 15 Nov 2021 00:02:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv5uP4O5V4xtiTKpwFZqqVXpd4X2FyO5vCLmFS1r+O+rAVPgEZZOgFH+PNonWxXoKguHRPXQ==
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id j25-20020aa78019000000b0044dd7616f79mr31742074pfi.3.1636963362297;
        Mon, 15 Nov 2021 00:02:42 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id 95sm11508978pjo.2.2021.11.15.00.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:02:41 -0800 (PST)
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
Subject: [PATCH v6 16/23] mm/hugetlb: Allow uffd wr-protect none ptes
Date:   Mon, 15 Nov 2021 16:02:28 +0800
Message-Id: <20211115080228.74982-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
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
 mm/hugetlb.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e8d01277af0f..bba2ede5f6dc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6145,7 +6145,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -6165,13 +6165,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
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
@@ -6196,12 +6202,20 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
+		if (unlikely(is_pte_marker_uffd_wp(pte))) {
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
@@ -6215,6 +6229,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+		} else {
+			/* None pte */
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP));
 		}
 		spin_unlock(ptl);
 	}
-- 
2.32.0

