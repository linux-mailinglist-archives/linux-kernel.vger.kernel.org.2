Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10EB3CADBF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbhGOUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245493AbhGOUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j48lYufpqnekDYwYR8maWxTIFb6q7AlY4/eyZPbLcoo=;
        b=NdWMQ7OwoVF3gp34UzLKBu0HN3EeUyiVd3LdVAjs3GsRRQjFxVbrFJV6v2v+sjg0/nsYMm
        1IvdrrnpnUt8VECoQMAEPzfeD8x7ZE7kUcZCQ4XZKSwjvhTmB5lR5hK3fbq6ToDpxMkDvk
        pdeJvcVyBOOOtoEfxQfVOm2/o9kxV78=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-Umdx8HkAOWuGnFhsBIERRg-1; Thu, 15 Jul 2021 16:16:48 -0400
X-MC-Unique: Umdx8HkAOWuGnFhsBIERRg-1
Received: by mail-qt1-f197.google.com with SMTP id 44-20020aed30af0000b029024e8ccfcd07so4937119qtf.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j48lYufpqnekDYwYR8maWxTIFb6q7AlY4/eyZPbLcoo=;
        b=eubiFwe8ei7n6dXWLgUyPtt3O8s45wfc9i/GyZdSSPOq913KgUjkA8360LsRxm1/Yd
         q+ir6Dtzo3574fxLQ1QxcVn/nKQtfk/Va7z8p0DpuOPJAaKHqRsJMDpNNaoegPvuCf9M
         LUuzjHAkZ9/5y9lJwAabsOql3MHQHFGRKi6qlGV4QEiFkiHgF6J+TcJ7T5yDNiA6QFYR
         m2N9Z589qquWB/F/jczHOZQk8SbhOTZp3WyzAbJpJUVFofnnEKQRpLuH/PJzVSqdU17V
         yYfnAni0OkM4wJfT/bB4hSB7/IEH9ZkIjKezm0S0MoJm72NYgUmXT9qaNeUrHcfYIFdJ
         yayw==
X-Gm-Message-State: AOAM532qOsPzw4mvGFVwjzl2IKUQwK1BPfi+LQLtkl5RFBasBu1vL8h6
        K4C0/C4OeDD6X15JutqpPBfj2KxBRc+V4BQ1mBceXR3nob6jeVUSDfgqjHUAk4pKcEB7Hp9qeGH
        zATqdmbEBYcFNqZ+RlfGlsuinM9YEt15ztPObUoxMCPtFMsLhemGRwvkLhkRQZmdtNB6yhYKaDA
        ==
X-Received: by 2002:a05:622a:14:: with SMTP id x20mr1157170qtw.150.1626380207118;
        Thu, 15 Jul 2021 13:16:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUeSgIltwtBR9YaKWY8pjrogeHtEb79B0itIbQGnhHcPRL3nBEDK9p6jBUBX/+9Gp665PuVQ==
X-Received: by 2002:a05:622a:14:: with SMTP id x20mr1157126qtw.150.1626380206833;
        Thu, 15 Jul 2021 13:16:46 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b6sm2512324qtg.1.2021.07.15.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 22/26] hugetlb/userfaultfd: Allow wr-protect none ptes
Date:   Thu, 15 Jul 2021 16:16:43 -0400
Message-Id: <20210715201643.212033-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index 5941b5cd7ecc..875adf3b000c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5561,7 +5561,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -5581,13 +5581,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
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
@@ -5612,12 +5618,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
@@ -5631,6 +5646,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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

